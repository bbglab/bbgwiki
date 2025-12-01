
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
	ml load anaconda3
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
        


## Aditional info

### Extra parameters

If you need to provide any [extra parameter](https://qmap.readthedocs.io/en/latest/concepts.html#parameters) directly to
SLURM, you can do it defining a new profile.config file. E.g.

   === "IRB cluster"    
    
    ```toml 
    executor = slurm

    [params]
	extra = -G 1
	```
   === "BBG cluster"    
    
    ```toml
    executor = slurm

	[params]
	extra = -p bigmem
	```
				
				
By default, the queue used in the bbgcluster is `bigrun`.    
For qmap runs using gpus, `-G 1`

## Reference

- Federica Brando
- Miguel Grau
