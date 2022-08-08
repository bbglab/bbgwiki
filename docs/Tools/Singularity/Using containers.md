# Using containers
## Running commands inside a container
The `singularity exec` command will allow you to execute any program within a given container. The `singularity run` command performs the action defined by the `%runscript` section, which is the primary task of the container. Using the `singularity run` command is the simpler approach for job submissions.

You can even "execute" a container, which performs the same action as the `singularity run` command. For example, the following demonstrates how to inspect the runscript and execute the `/data/containers/public/python3_helloworld.simg` container:

```bash
$ singularity inspect -r /data/containers/public/python3_helloworld.simg
#!/bin/sh
  python3 -c 'print("Hello, World!")'

$ /data/containers/public/python3_helloworld.simg
Hello, World!

$ singularity run /data/containers/public/python3_helloworld.simg
Hello, World!
```

## Execute a script from outside the container
!!! note annotate "Using on the cluster"

    For typical use, you want to use the singularity run or singularity exec commands, especially when submitting the work via the scheduler.

The following example runs a python script `hello_world2.py` from the current directory using the `/data/containers/public/python3_helloworld.simg` container:

```bash
$ singularity exec /data/containers/public/python3_helloworld.simg python3 ./hello_world2.py
Hello, World!
Hello, World (again)!
```

The file hello_world2.py contains the following code:

```python
print("Hello, World!")
print("Hello, World (again)!")
```

If command `singularity exec` was replaced by `singularity run`, the runscript would be called, ignoring any parameters after the container name.

!!! warning annotate "Customised Environments"

    While we encourage users to customise their environment to make their workflow easier, please be aware that customisations which change the user's environment for example by setting variables in the ~/.bash_profile file, or by using python's pip to create a ~/.local folder, may cause problems with Singularity which can be difficult to troubleshoot.

## Using containers with Grid Engine
One of the major benefits of Singularity is the simplicity with which it can be used in an HPC environment. Your Grid Engine submission script may not require any modules loading to run your container. The resource requirements should be very similar to native code.

### Simple example

```bash
#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 1
#$ -l h_rt=1:0:0
#$ -l h_vmem=1G

singularity run /data/containers/public/python3_helloworld.simg
```

### Modules example
Applications installed within Singularity containers may also be provided as a module to abstract the container invocation commands (`singularity run` and `singularity exec`). In these cases, the container name will match the runscript command. For example, to use Pandoc as a module, simply load the `pandoc` module to use the application.

```bash
#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 1
#$ -l h_rt=1:0:0
#$ -l h_vmem=1G

module load pandoc
pandoc --help
```

### Shell access to the container
It is possible to launch a shell within the container using the `shell` command. Interacting directly with a shell inside the container can be useful for code debugging and running multiple commands in a single interactive session, as an alternative to writing a single script. Below demonstrates how to invoke python3 from inside the `/data/containers/public/python3_helloworld.simg` container using an interactive shell:

```
$ singularity shell /data/containers/public/python3_helloworld.simg
Singularity> python3
Python 3.8.10 (default, Sep 28 2021, 16:10:42)
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

Documentation is available on the [Singularity Hub Wiki](https://github.com/singularityhub/singularityhub.github.io/wiki)

## Running containers from external sources
!!! note annotate "Use of external containers for Research"

    For long term reproducibility of containers, we recommend that you build your own native Singularity containers from definition files instead of relying on 3rd party containers for your research. Using containers from external sources may produce undesirable results if the container is rebuilt after upstream changes such as updated or obsoleted packages.

Containers created elsewhere can be copied or imported, and run on the cluster. The following example demonstrates how to import and run the latest Ubuntu official image stored in the [Docker Hub](https://hub.docker.com/_/ubuntu/):

```
$ singularity pull ubuntu.simg docker://ubuntu:latest
$ singularity exec ubuntu.simg cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04.3 LTS"
```