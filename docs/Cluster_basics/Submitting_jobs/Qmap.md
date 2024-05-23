# Qmap Submit

## Description

How to submit jobs to the Cluster using **Qmap**.

**Qmap** documentation: https://qmap.readthedocs.io

## Howto

### 1. Prepare .qmap file (example)

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

### 2. Run "qmap submit" from the login node

```bash
$ qmap submit filename.qmap

```

## Aditional info 

### Extra parameters

If you need to provide any [extra parameter](https://qmap.readthedocs.io/en/latest/concepts.html#parameters) directly to SLURM, you can do it defining a new profile.config file. E.g.
```
executor = slurm

[params]
extra = -p bigmem
```

By default, the queue used is `bigrun`.



## Reference

- Federica Brando
- Miguel Grau
