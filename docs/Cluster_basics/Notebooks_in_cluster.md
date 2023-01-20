# Running notebooks in the cluster

## Description

Running a jupyter notebook in the cluster allows you to work with a notebook which will be **running even if you disconnect from the cluster**.

This is especially useful for time-consuming/memory-consuming processes or notebooks with a high number of variables/packages needed, so that you have more computational power than your local computer, you can leave them running in the background without the fear of accidentally disconnecting and losing all the progress and you can come back to a notebook without the need of loading all the variables/packages again.

To run a notebook in the cluster, a [screen](../Screen/) and an [interactive](../Interactive/) will be used.

## Usage

You will need to follow the next steps:

Connect to the cluster:

```bash
ssh -p 22022 <username>@bbgcluster
```

Open a screen:

```bash
<username>@login01:~$ screen -S <screen_name>
```

Run an interactive job:

```bash
[screen_name] <username>@login01:~$ interactive
```

!!! info
    If your notebook needs more than 8G and 2 cores, you can specify it here -- see [interactive](../Interactive/) section.

Activate conda base or the conda environment that you need in your notebook:

```bash
[screen_name] <username>@bbgn005:~$ conda activate
```

Go to the folder that you wish to run the notebook:

```bash
(base)[screen_name] <username>@bbgn005:~$ cd /workspace/folder
```

Run the jupyter notebook:

```bash
(base)[screen_name] <username>@bbgn005:~/workspace/folder$ unset XDG_RUNTIME_DIR && jupyter notebook --ip=0.0.0.0
```

Keep the URL with the token and the node in which the interactive is running:

```bash
[I 10:37:20.371 NotebookApp] The Jupyter Notebook is running at: http://127.0.0.1:8888/?token=730ea7a95c02207c9fb7cbd434c2de81e03168845d42c23c
```

Now, your notebook is running and you can dettach from the screen:

```text
Ctrl + A -> D
```

Open a new terminal and create an ssh tunnel to be able to access the port **8888** in the node -- following the example, this is node **bbgn005**:

```bash
ssh -L 8888:bbgn005:8888 -p 22022 <username>@bbgcluster
```

Now use the URL, replacing **127.0.0.1** with **localhost** and open the URL in your browser:

```link
http://localhost:8888/?token=730ea7a95c02207c9fb7cbd434c2de81e03168845d42c23c
```

Using the tunnel (ssh -L terminal) and the URL in the browser, you can enter the notebook as many times as you need.
When you don't need the notebook to continue running in the cluster, reconnect to the screen:

```bash
screen -r <screen_name>
```

And kill jupyter and exit the interactive session.

## Reference

-   Jordi Deu-Pons
-   Miguel Grau
-   Carlos López
-   Ferran Muiños
-   Paula Gomis
