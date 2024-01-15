# R Notebooks (Quarto) in the cluster

## Description

Quarto Notebooks allows users to combine plain text markdown with a variety of programming languages such as R or python. Although is natively supported by the newest versions of Rstudio, quarto documents can also be run in other IDES such as JupyterLab, VScode and others.

In this document it is described how to set up the cluster environment to run an Rstudio server instance in the cluster where you can manage and execute your code.

## Use cases:

- Your tasks demand a lot of resources CPU/memory.
- The files you want to use are already in the cluster and you don't want to copy them elsewhere.
- Your task is long and time consuming and you want the process to run for a long time even if you power off your pc.
- You want to be able to connect to your notebook from anywhere. (As long as you can connect to the network)

In any other case, such as performing regular development tasks or small scripts it is highly discouraged to run in the cluster read the local setup instead. Otherwise:

- You may experience a significant slowdown compared to local instances of Rstudio.
- Small commands such as simple sums may take up to several seconds to finish.
- You will be wasting resources in the cloud that others may need.

To run a quarto notebook in the cluster, [Singularity](docs/Tools/Singularity/)  a [screen](../Screen/) and an [interactive](../Interactive/) will be used.

## Create a notebook

You will need to follow the next steps:

1.  Connect to the cluster:

    ``` bash
    ssh -p 22022 <username>@bbgcluster
    ```

2.  Open a screen:

    ``` bash
    <username>@login01:~$ screen -S <screen_name>
    ```

3.  Run an interactive job and remember the node you are assigned to (*e.g. bbgn005*)

    ``` bash
    [screen_name] <username>@login01:~$ interactive
    ```

    !!! info If your notebook needs more than 8G and 2 cores, you can specify it here -- see [interactive](../Interactive/) section.

5.  Run the following script:

    ``` bash
    #!/usr/bin/env bash

# Loosely based on https://www.rocker-project.org/use/singularity/

# This is an interesting image from somebody at dockerhub tags:{R_version}-{Seurat_version}
# IMAGE=${IMAGE:-pansapiens/rocker-seurat:4.1.1-4.0.4}

# Here is a modified version of rocker/rstudio I made in github registry:
 IMAGE=${IMAGE:-ghcr.io/izarvillasante/dockerfiles:main}

# A base rstudio image:
# IMAGE=${IMAGE:-rocker/rstudio:latest}

# you can override the IMAGE in the script with the env command:
#IMAGE=rocker/rstudio:4.1.1 ./rstudio.sh

# Create the folders needed for rstudio to work:

mkdir -p -m 770 run var-lib-rstudio-server
cat > database.conf <<END
provider=sqlite
directory=/var/lib/rstudio-server
END

IMAGE_SLASHED=$(echo $IMAGE | sed 's/:/\//g')
R_LIBS_USER=${HOME}/.rstudio-rocker/${IMAGE_SLASHED} # Main path to store installed packages

RSTUDIO_HOME=${HOME}/.rstudio-rocker/${IMAGE_SLASHED}/session
mkdir -p ${HOME}/.rstudio # will bind here RSTUDIO_HOME so it is allways the same when working on rstudio

RSTUDIO_TMP=${HOME}/.rstudio-rocker/${IMAGE_SLASHED}/tmp
RSITELIB=${HOME}/.rstudio-rocker/${IMAGE_SLASHED}/site-library

mkdir -p -m 770 ${R_LIBS_USER} ${RSTUDIO_HOME} ${RSTUDIO_TMP} ${RSITELIB}
mkdir -p ${RSTUDIO_TMP}/var/run

cat > rsession.sh <<END
#!/bin/sh
export R_LIBS_USER=${HOME}/.rstudio-rocker/${IMAGE_SLASHED}

exec /usr/lib/rstudio-server/bin/rsession "\${@}"
END
chmod +x rsession.sh

# Search for a free port to use (needs python):
PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
# Search for a free port (needs netstat)
if [ $? -ne 0 ]; then
  # Set a default port value
  PORT=8787
  until ! netstat -ln | grep "  LISTEN  " | grep -iEo  ":[0-9]+" | cut -d: -f2 | grep -wqc ${PORT};
  do
      ((PORT++))
      echo "Checking port: ${PORT}"
  done
      echo "Got one !"
fi

#Generate the password:
export SINGULARITYENV_PASSWORD=$(openssl rand -base64 15)

# Use a shared cache location if unspecified
export SINGULARITY_CACHEDIR=${SINGULARITY_CACHEDIR:-"/tmp/.cache/singularity"}

# We detect if we are on the bbgcluster by the hostname.
# Hardcode this to `local` if you don't ever use it.
if [[ $HOSTNAME == bbgn* ]]; then
    HPC_ENV="bbgn"
else
    HPC_ENV="local"
fi

echo "Getting required containers ... this may take a while ..."
echo
# by doing `singularity test` we cache the container image without dumping a local sif file here
# mksquashfs isn't installed everywhere, so we pull on a head node
if [[ $HPC_ENV == "bbgn" ]]; then
    singularity test docker://${IMAGE}
    LOCALPORT=8787
    echo "On you local machine, open an SSH tunnel like:"
    echo "  ssh -N -L ${LOCALPORT}:$(hostname -f):${PORT} -p 22022  ${USER}@bbgcluster"
    echo
    echo "Point your web browser at http://localhost:${LOCALPORT}"
    echo
    echo "Login to RStudio with:"
    echo "  username: ${USER}"
    echo "  password: ${SINGULARITYENV_PASSWORD}"
    echo
    echo "Protip: You can choose your version of R from any of the tags listed here: https://hub.docker.com/r/rocker/rstudio/tags"
    echo "        and set the environment variable IMAGE, eg"
    echo "        IMAGE=rocker/rstudio:4.1.1 $(basename "$0")"
    echo
    echo "Starting RStudio Server (R version from image ${IMAGE})"

else
    export LOCALPORT=$PORT
    echo "Point your web browser at http://localhost:${LOCALPORT}"
    echo
    echo "Login to RStudio with:"
    echo "  username: ${USER}"
    echo "  password: ${SINGULARITYENV_PASSWORD}"
    echo
    echo "Protip: You can choose your version of R from any of the tags listed here: https://hub.docker.com/r/rocker/rstudio/tags"
    echo "        and set the environment variable IMAGE, eg"
    echo "        IMAGE=rocker/rstudio:4.1.1 $(basename "$0")"
    echo
    echo "Starting RStudio Server (R version from image ${IMAGE})"
    singularity pull docker://${IMAGE}
fi

# Set some locales to suppress warnings
LC_CTYPE="C"
LC_TIME="C"
LC_MONETARY="C"
LC_PAPER="C"
LC_MEASUREMENT="C"

if [[ $HPC_ENV == 'bbgn' ]]; then
    export SINGULARITY_BIND="${RSTUDIO_HOME}:${HOME}/.rstudio,${RSTUDIO_TMP}:/tmp,${RSTUDIO_TMP}/var:/var/lib/rstudio-server,${RSTUDIO_TMP}/var/run:/var/run/rstudio-server,/workspace,${R_LIBS_USER},rsession.sh:/etc/rstudio/rsession.sh,database.conf:/etc/rstudio/database.conf,${RSITELIB}:/usr/local/lib/R/site-library"
    export SINGULARITYENV_RSTUDIO_SESSION_TIMEOUT=0
    singularity exec --env R_LIBS_USER=${R_LIBS_USER} \
    docker://${IMAGE} \
                     /usr/lib/rstudio-server/bin/rserver --server-user=${USER} --auth-none=0 --auth-pam-helper-path=pam-helper --auth-timeout-minutes=0 --auth-stay-signed-in-days=30 --rsession-path=/etc/rstudio/rsession.sh  --www-port=${PORT} 
else

    singularity exec --bind ${HOME}:/home/rstudio \
                     --bind ${RSTUDIO_HOME}:${HOME}/.rstudio \
                     --bind ${R_LIBS_USER}:${R_LIBS_USER} \
                     --bind ${RSTUDIO_TMP}:/tmp \
                     --bind=${RSTUDIO_TMP}/var:/var/lib/rstudio-server \
                     --bind=${RSTUDIO_TMP}/var/run:/var/run/rstudio-server \
                     --env R_LIBS_USER=${R_LIBS_USER} \
                     docker://${IMAGE} \
                     rserver --database-config-file database.conf --server-user=${USER} --auth-none=0 --auth-pam-helper-path=pam-helper --www-port=${PORT}
fi

printf 'rserver exited' 1>&2
    
    ```


## Open a notebook

In order to open an already existing notebook, you'll need to know the **port** (*e.g 8888*) and the **node** of the cluster (*e.g bbgn005*) where you created it in the previous step.

``` bash
ssh -L <port>:<node>:<port> -p 22022 <username>@bbgcluster
# For example: ssh -L 8888:bbgn005:8888 -p 22022 clopeze@bbgcluster
```

!!! note If you don't want to remember these commands, you can create an alias. You can do this by adding the following lines to your `~/.bashrc` file or `~/.bash_aliases` file:

````         
```bash
notebook(){
    # Ask for cluster user
    echo "Enter cluster user: "
    read user
    # Ask for node
    echo "Enter node name: "
    read node
    # Ask for port
    echo "Enter port: "
    read port
    # Connect to ssh cluster
    ssh -L $port:$node:$port -p 22022 ${user}@bbgcluster
}

```
````

Open the URL you obtain when creating the notebook in the cluster (step 7).

``` bash
# For example: http://127.0.0.1:8888/?token=730ea7a95c02207c9fb7cbd434c2de81e03168845d42c23c
```

## Close a notebook

When you don't need the notebook to continue running in the cluster, reconnect to the screen:

``` bash
screen -r <screen_name>
```

And kill jupyter (Ctrl + C) and exit the screen (write `exit` in the terminal and press enter)

## Beyond R

### Python quartos

It may be convenient to author your python code as a plain text file (`.qmd`) in case you want to see a more version control compatible view of your code, while you are also able to see the markdown output in the go. You may also want to use normal notebook file (`.ipynb`) if you want your file to be compatible with JupyterLab. In both cases quarto is going to use the jupyter kernel to render the document into html.

You can use the quarto convert command to transform from (`.ipynb` to `.qmd` )

You ca also take advantage of the quarto rendering engine inside JupyterLab to propperly display the content of the markdown cells and extensions. You will need to install the [JupyterLab Extension](https://quarto.org/docs/tools/jupyter-lab-extension.html) in your JupyterLab. You don't need that if you are already using Rstudio.

## Errors and solutions

### I forgot the URL of the notebook

1.  Enter to the cluster and check your screens:

    ``` bash
    screen -ls
    ```

2.  Enter the screen where you have your notebook:

    ``` bash
    screen -r <screen name>
    ```

3.  Scroll up until you find the URL, which should look like:

    ``` bash
    http://127.0.0.1:8888/?token=730ea7a95c02207c9fb7cbd434c2de81e03168845d42c23c
    ```

### My notebook doesn't open

One possibility is that the running notebook in the cluster has **crashed**. You can check this by going to the cluster, entering the screen where you have the notebook and check if it is still running.

If not, you should **create a notebook** following the steps at the beginning of this page (*Create a new notebook*).

## Reference

-   Jordi Deu-Pons
-   Miguel Grau
-   Carlos López-Elorduy
-   Paula Gomis
-   Federica Brando
