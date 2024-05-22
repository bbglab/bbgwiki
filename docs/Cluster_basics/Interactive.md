# Interactive

The `interactive` command gives to the user an **interactive shell** in the cluster with slurm allocation. In other words, it allocates the user to a specific node of the cluster so that the jobs can be executed there without disturbing the rest of the users.

## Usage

Once you enter the bbgcluster, you will see in the terminal `<username>@login01`. It is here where, if you want to be allocated to your own node, you can just run the command:

```bash
$ interactive
```

If the `login01` has changed to `bbgn###` where `###` is the number identifying the current node.

Apart from the basic use, there are optional arguments/flags for extra features:

```bash
interactive [-c] [-m] [-w] [-J] [-x] [-p]
```

- `-c`: Number of CPU cores (default: 1)
- `-m`: Total amount of memory (GB) (default: 8 [GB])
- `-w`: Target node
- `-J`: Job name
- `-x`: Binary that you want to run interactively
- `-p`: specify queue (see [queues](https://bbglab.github.io/bbgwiki/Cluster_basics/queues/))

## Reference

- Jordi Deu-Pons
- Miguel Grau
- Carlos López-Elorduy
