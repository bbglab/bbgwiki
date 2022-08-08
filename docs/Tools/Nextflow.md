# Nextflow

!!! note annotate ""
    Nextflow enables scalable and reproducible scientific workflows using software containers. It allows the adaptation of data-driven, computational pipelines written in the most common scripting languages.


## Usage
To run the default installed version of Nextflow, simply load the `nextflow` module:

```bash
$ module load nextflow
$ nextflow help

Usage: nextflow [options] COMMAND [arg...]
```

For usage documentation, run `nextflow help`.

### Submitting processes as serial jobs

!!! note annotate "Recommended for serial jobs only"

    This section is recommended for serial jobs only. For parallel jobs, please see the Parallel jobs section below.

Nextflow supports the ability to submit pipeline scripts as separate cluster jobs using the SGE executor.

To enable the SGE executor, simply set to `process.executor` property to sge in a configuration file named `nextflow.config` in the job working directory. The amount of resources requested by each job submission is defined in the [cluster options](https://www.nextflow.io/docs/latest/process.html#clusteroptions) section, where all Univa scheduler resources are supported.

For example, to run all pipeline jobs with 2 serial cores and 2GB of memory for 1 hour, create the following configuration file:

```
process.executor='sge'
process.clusterOptions='-pe smp 2 -l h_vmem=1G,h_rt=1:0:0'
```

!!! note annotate "Setting the memory limit for serial jobs"

    Add the `-DXmx` option to limit the amount of memory Nextflow can use in serial jobs. For more information regarding the Java VM memory allocation, see here.


### Parallel jobs
Parallel jobs will use the in-built Apache Ignite clustering platform; Execution will be performed on the nodes requested in the submit request over MPI rather than submitting new jobs for each pipeline.

!!! warning annotate "Do not use the SGE executor in parallel jobs"

    Using the SGE executor for parallel jobs causes the master job to hang until it is killed by the scheduler for exceeding walltime. This is due to Apache Ignite not being able to communicate to other pipeline scripts submitted as separate jobs.

To ensure parallel jobs use Apache Ignite, add the following to the configuration file (or omit the process.executor setting):

```
process.executor='ignite'
```

### Example jobs
#### Serial job
Here is an example job taken from the Nextflow website to submit each process in the `input.nf` file as a new cluster job with 1 core and 1GB of memory. Ensure the cumulative runtime across all processes does not exceed the runtime requested in the master job:

```nextflow
#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 1
#$ -l h_rt=1:0:0
#$ -l h_vmem=1G

module load nextflow

nextflow -DXmx=1G \
         -C nextflow.config \
         run input.nf
```

#### Parallel job
Here is an example job taken from the Nextflow website to run each process in the `input.nf` file using 48 cores across 2 sdv nodes with Apache Ignite:

```nextflow
#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe parallel 48
#$ -l infiniband=sdv-i
#$ -l h_rt=240:0:0

module load nextflow openmpi

mpirun --pernode \
       nextflow run input.nf \
       -with-mpi
```

## Links

- [Nextflow documentation](https://www.nextflow.io/docs/latest/index.html)
- [Nextflow basic pipeline example](https://www.nextflow.io/example1.html)
- [Nextflow presentation videos](https://www.nextflow.io/presentations.html)
- [Nextflow community support](https://groups.google.com/forum/#!forum/nextflow)
- [Nextflow MPI](https://www.nextflow.io/docs/latest/ignite.html#execution-with-mpi)
- [Apache Ignite](https://ignite.apache.org/whatisignite.html)

## Reference

- Jordi Deu-Pons
- Carlos López Elorduy
- Miguel Grau