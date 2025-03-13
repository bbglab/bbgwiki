# Running notebooks in the cluster

## Description

Running a jupyter notebook in the cluster allows you to work with a notebook which will be **running even if you disconnect from the cluster**.

This is especially useful for time-consuming/memory-consuming processes or notebooks with a high number of variables/packages needed, so that you have more computational power than your local computer, you can leave them running in the background without the fear of accidentally disconnecting and losing all the progress and you can come back to a notebook without the need of loading all the variables/packages again.

To run a notebook in the cluster, a [screen](Screen.md) and an [interactive](Interactive.md) will be used.

## Create a notebook

You will need to follow the next steps:

1. Connect to the cluster:

    ```bash
    ssh -p 22022 <username>@bbgcluster
    ```

2. Open a screen:

    ```bash
    <username>@login01:~$ screen -S <screen_name>
    ```

3. Run an interactive job and remember the node you are assigned to (_e.g. bbgn005_)

    ```bash
    [screen_name] <username>@login01:~$ interactive
    ```

    !!! info
        If your notebook needs more than 8G and 2 cores, you can specify it here -- see [interactive](Interactive.md) section.

4. Activate conda base or the conda environment that you need in your notebook:

    ```bash
    [screen_name] <username>@bbgn005:~$ conda activate <your environment>
    ```

5. Go to the folder that you wish to run the notebook:

    ```bash
    (base)[screen_name] <username>@bbgn005:~$ cd /data/bbg/folder
    ```

6. Run the jupyter notebook:

    === "Notebook"
        Copy the following command:

        ```bash
        unset XDG_RUNTIME_DIR && jupyter notebook --ip=0.0.0.0
        ```
    === "Lab"
        Copy the following command:

        ```bash
        unset XDG_RUNTIME_DIR && jupyter lab --ip=0.0.0.0
        ```

7. Keep the URL with the token and the port (_e.g.8888_) in which the interactive is running:

    ```bash
    [I 10:37:20.371 NotebookApp] The Jupyter Notebook is running at: http://127.0.0.1:8888/?token=730ea7a95c02207c9fb7cbd434c2de81e03168845d42c23c
    ```

Now, your notebook is running and you can dettach from the screen by pressing `Ctrl + A + D`. You can now close the terminal and the notebook will continue running in the cluster.

## Open a notebook

In order to open an already existing notebook, you'll need to know the **port** (_e.g 8888_) and the **node** of the cluster (_e.g bbgn005_) where you created it in the previous step.

```bash
ssh -L <port>:<node>:<port> -p 22022 <username>@bbgcluster
# For example: ssh -L 8888:bbgn005:8888 -p 22022 clopeze@bbgcluster
```

!!! note
    If you don't want to remember these commands, you can create an alias.
    You can do this by adding the following lines to your `~/.bashrc` file or `~/.bash_aliases` file:

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

Open the URL you obtain when creating the notebook in the cluster (step 7).

```bash
# For example: http://127.0.0.1:8888/?token=730ea7a95c02207c9fb7cbd434c2de81e03168845d42c23c
```

## Close a notebook

When you don't need the notebook to continue running in the cluster, reconnect to the screen:

```bash
screen -r <screen_name>
```

And kill jupyter (Ctrl + C) and exit the screen (write `exit` in the terminal and press enter)

## Errors and solutions

### I forgot the URL of the notebook

1. Enter to the cluster and check your screens:

    ```bash
    screen -ls
    ```

2. Enter the screen where you have your notebook:

    ```bash
    screen -r <screen name>
    ```

3. Scroll up until you find the URL, which should look like:

    ```bash
    http://127.0.0.1:8888/?token=730ea7a95c02207c9fb7cbd434c2de81e03168845d42c23c
    ```

### My notebook doesn't open

One possibility is that the running notebook in the cluster has **crashed**. You can check this by going to the cluster, entering the screen where you have the notebook and check if it is still running.

If not, you should **create a notebook** following the steps at the beginning of this page (_Create a new notebook_).

## Reference

- Jordi Deu-Pons
- Miguel Grau
- Carlos López-Elorduy
- Paula Gomis
- Federica Brando
