# SLURM

[SLURM](https://slurm.schedmd.com) is an open source, fault-tolerant, and highly scalable cluster management and job scheduling system for large and small Linux clusters.

## Description

With SLURM commands you can SUBMIT and MANAGE jobs in the cluster.

### SUBMIT

There are 3 major command to submit jobs:

- `sbatch` : Submits a batch script for later execution
- `srun` : Obtain a job allocation and execute an application
- `salloc` : Obtain a job allocation

!!! tip inline "Use `interactive`!"
  
    Instead of using the above mentioned commands, you can use `interactive`, a in-house command that allows to allocate resources in the cluster.
    More reference [here](../Interactive.md)
  
```bash
$ interactive -h 
Usage: interactive [-c] [-m] [-w] [-J] [-x]

Optional arguments:
    -c: number of CPU cores (default: 1)
    -m: total amount of memory (GB) (default: 8 [GB])
    -w: target node
    -J: job name
    -x: binary that you want to run interactively
```

#### 1. `salloc`

Allows you to allocate the resources that you need on the cluster.

```bash
salloc [OPTIONS]
```

The options are plenty and can be inspected by typing `salloc --help` command. 

??? example "Example"
    
    ```bash 
    salloc -w bbgn004 -J my_cool_job --mem-per-cpu=4GB
    ``` 
    It's asking to allocate 4GB of memory on node bbgn004 for a job named "my_cool_job"

#### 2. `srun`

Submits an application for immediate execution. The command is interactive, it will output on the terminal that runs it and it is blocking, this means that you cannot use the terminal where you `srun` command. 

><my_applicayion.sh\>
```sh
#!/bin/bash

echo "$(date +'%r') This is a dummy script"
sleep 5s
echo "$(date +'%r') Bye"
```

Then you can run the application with the following:

```bash
$ srun my_dummy_script.sh 
srun: job 8725263 queued and waiting for resources
srun: job 8725263 has been allocated resources
06:33:32 PM This is a dummy script
06:33:37 PM Bye
```

#### 3. `sbatch`

Submits a batch script for later execution. You need a batch script and a set of parameters.
There are a fair amount of parameters that can be inspected with the following command:

`sbatch -h` or `sbatch -u`

An example of batch script is the following:

> <my_job_script\>

```sh
#!/bin/bash
#SBATCH --time=00:30:00
#SBATCH -c 8
#SBATCH --mem 16gb
#SBATCH -J my_job_name

# Load the module environment suitable for the job
conda activate my_env

# And finally run the job​
srun ./test1.sh 
srun ./test2.sh
```

Then you can submit the job as follows:

```bash
sbatch <my_job_script>
```

This will send to the cluster a job with 8 cores and 16GB of RAM named _my_job_name_ and with a time limit of _30mins_.

!!! tip "Use `qmap`!"
  
    Do you need to run parallel jobs in the cluster? You can use an in-house package called `qmap`, that allows you to let SLURM decide where and which node to use to run the commands with basic template file.
    More info [here](./Qmap.md)

### MANAGE

#### 1. `squeue`

In order to see the queue status of the cluster and what is going on in the nodes, you can access the list  with the general command:

```bash
squeue
```

You can also specify some parameters:

- `--user $USER` will show only your JOBS
- `--job=$JOB_ID` will show only the JOBS listed with their JOB_Id
- `--states=[RUNNING]` will show only RUNNING jobs.

Full list of parameters can be seen with `squeue --help` command.

#### 2. `scancel`

```bash
scancel [job_id]
```

You can specify some parameters:

- `-A` will act only on jobs charging this account
- `-state=PENDING` will act only on PENDING jobs
- `-u` will act only on jobs of this user

Full list of parameters can be seen with `scancel --help` command.

!!! tip "What about canceling more than one job?"

    **SPOILER ALERT!** You can! 
    You can either list all the jobs one after the other.

    ```sh
    scancel job_id1 job_id2 job_id3
    ```

    If your jobs are sequencially you can use:

    ```sh
    scancel {job_id1...job_id3}
    ```

    In this case also job_id2 will be deleted


## Reference

- Federica Brando
