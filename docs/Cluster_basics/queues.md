
# Queues

When submitting jobs to the bbgcluster, with [interactive](https://bbglab.github.io/bbgwiki/Cluster_basics/Interactive/) or e.g., [sbatch](https://bbglab.github.io/bbgwiki/Cluster_basics/Submitting_jobs/SLURM/), you have the option to specify the queue/partition where sending the job. By default (if not specified), it goes to the `normal`partition.

### Choose the correct queue
Selecting the right queue is crucial for the proper functioning of the cluster:
- `normal`: Standard job in terms of time and resources. E.g, notebook, an `interactive`, etc
- `bigmem`: Job requiring a lot of memory. 512Gb at max.
- `bigrun`: Job requiring a lot of nodes during hours/days (a lot of cpus/mem). Normally this case is when using a (nextflow) pipeline and your main job is submitting many sub-jobs to the queue for days. *Optimal for intogen/boostDM, sarek, deepUMIcaller,... jobs*

### List queues

Once you enter the bbgcluster, you will see in the terminal `<username>@login01`:
```
<username>@login01:~$ sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
normal*      up   infinite      1   drng bbgn004
normal*      up   infinite      6    mix bbgn[012,014,016,019-020,022]
normal*      up   infinite      2  alloc bbgn[021,023]
normal*      up   infinite     11   idle bbgn[005-011,013,015,017-018]
bigmem       up   infinite      2    mix bbgn[020,022]
bigmem       up   infinite      2  alloc bbgn[021,023]
bigrun       up   infinite      6    mix bbgn[012,014,016,019-020,022]
bigrun       up   infinite      2  alloc bbgn[021,023]
bigrun       up   infinite      8   idle bbgn[008-011,013,015,017-018]
```
In here, you can see all the three partitions (`normal`, `bigmem` and `bigrun`) and  the status of every working node (bbgnXXX). The possible states are:
- `drng`: The node is under maintenance.
- `alloc`: Nodes with no resources available
- `idle`: Nodes with all the resources available.
- `mix`: Nodes with some resources available.

### Nextflow example

You can edit your nextflow config file and define the partition:
```
process { 
executor = 'slurm' 
queue = 'bigrun' 
errorStrategy = 'retry' 
maxRetries = 2 
} 

executor { 
queueSize = 30 
}
```


## Reference

- Miguel Grau
- Federica Brando
