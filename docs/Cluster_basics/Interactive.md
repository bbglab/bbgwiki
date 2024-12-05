---
search:
  boost: 2 

tags:
  - IRBCluster
  - BBGCluster
  - HPC
---

# Interactive

The `interactive` command gives to the user an **interactive shell** in the cluster with slurm allocation. In other words, it allocates the user to a specific node of the cluster so that the jobs can be executed there without disturbing the rest of the users.

## Usage

There is a difference between running an interactive session within the BBGCluster or the IRB Cluster. Please select the tab accordingly to where you are working.

=== "BBG Cluster"
    Once you enter the bbgcluster, you will see in the terminal `<username>@login01`. It is here where, if you want to be allocated to your own node, you can just run the command:

    ```bash
    $ interactive
    ```

    If the `login01` has changed to `bbgn###` where `###` is the number identifying the current node.
    
    Apart from the basic use, there are optional arguments/flags for extra features:
    
    - `-c`: Number of CPU cores (default: 1)
    - `-m`: Total amount of memory (GB) (default: 8 [GB])
    - `-w`: Target node
    - `-J`: Job name
    - `-x`: Binary that you want to run interactively
    - `-p`: specify queue (see [queues](https://bbglab.github.io/bbgwiki/Cluster_basics/queues/))

=== "IRB Cluster"
    In order to run `interactive` command in the IRB cluster you need to tell your terminal where to find it first.

    !!! warning "Installation"

        The `interactive` script is located here: `/data/bbg/software/bin/interactive`. In order to have it always available from wherever directory you want to run it, you need to add the following to your `.bashrc`

        ```bash
            export PATH=/home/$USER/.local/bin/:/data/bbg/software/bin/:$PATH
        ```

    Once you enter the irbcluster, you will see in the terminal `<username>@irblogin01`. Here is where you'd need to allocate desired resources to start working. The command to run is the following:

    ```bash
    $ interactive
    ```

    If the `irblogin01` has changed to `irbcn##` where `###` is the number identifying the current node.
    
    Apart from the basic use, there are optional arguments/flags for extra features:
    
    - `-c`: Number of CPU cores (default: 1)
    - `-m`: Total amount of memory (GB) (default: 8 [GB])
    - `-w`: Target node
    - `-J`: Job name
    - `-x`: Binary that you want to run interactively
    - `-p`: specify queue (see [queues](https://bbglab.github.io/bbgwiki/Cluster_basics/queues/)) (default: `bbg_cpu_zen4`)
    - `-q`: specify the QoS (see [slides](https://bbgcloud.irbbarcelona.org/f/559435))

## Reference

- Federica Brando
- Jordi Deu-Pons
- Miguel Grau
- Carlos López-Elorduy
