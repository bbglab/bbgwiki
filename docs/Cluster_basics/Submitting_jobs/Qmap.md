
# Qmap Submit

## Description

How to submit jobs to the Cluster using **Qmap**.

**Qmap** documentation: <https://qmap.readthedocs.io>

## Howto

### 1. Prepare .qmap file (example)

=== "IRB cluster"

    ```bash 
    [params]
    memory=50G

    [pre]
    ml load anaconda3  #OR . "/home/$USER/miniconda3/etc/profile.d/conda.sh"
    conda activate sciclone-env

    [jobs]
    Rscript run.R ../data/vafs.dat bmm 3 ./results.beta.3
    Rscript run.R ../data/vafs.dat gaussian.bmm 3 ./results.gaussian.3
    Rscript run.R ../data/vafs.dat binomial.bmm 3 ./results.binomial.3
    ```

=== "BBG cluster"

    ```bash
    [params]
    memory=50G

    [pre]
    . "/home/$USER/miniconda3/etc/profile.d/conda.sh"
    conda activate sciclone-env

    [jobs]
    Rscript run.R ../data/vafs.dat bmm 3 ./results.beta.3
    Rscript run.R ../data/vafs.dat gaussian.bmm 3 ./results.gaussian.3
    Rscript run.R ../data/vafs.dat binomial.bmm 3 ./results.binomial.3
    ```

The only difference is how you load conda. On the IRB cluster, you can use either of the following options:

 1) Use the pre-installed conda module (`ml load anaconda3`)

 2) If you use mamba or prefer to use your own conda installation,
  load it the same way you do on the BBG cluster:

  `. "/home/$USER/miniforge3/etc/profile.d/conda.sh"`

   For micromamba:

  `eval "$(micromamba shell hook --shell=bash)"`

### 2. Run "qmap submit" from the login node

=== "IRB cluster"

    ```bash 
    interactive
    spack load py-qmap
    qmap submit filename.qmap
    ```

=== "BBG cluster"

    ```bash
    qmap submit filename.qmap
    ```

## Additional info

### Extra parameters

If you need to provide any [extra parameter](https://qmap.readthedocs.io/en/latest/concepts.html#parameters) directly to
SLURM, you can do it defining a new profile.config file. E.g.

=== "IRB cluster"

    ```bash
    executor = slurm

    [params]
    extra = -G 1
    ```

=== "BBG cluster"

    ```bash
    executor = slurm

    [params]
    extra = -p bigmem
    ```

By default, the queue used in the BBG cluster is `bigrun`.

For Qmap runs using GPUs, use `-G 1`.

## Reference

- Federica Brando
- Miguel Grau
