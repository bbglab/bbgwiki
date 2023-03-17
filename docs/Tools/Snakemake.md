# Snakemake

The Snakemake workflow management system is a tool to create **reproducible and scalable** data analyses. Workflows are described via a human readable, Python based language. They can be seamlessly scaled to server, cluster, grid and cloud environments, without the need to modify the workflow definition. Finally, Snakemake workflows can entail a description of required software, which will be automatically deployed to any execution environment.

## Installation
You can use conda/mamba  to install Snakemake:
```bash
#mamba way. FASTER
$ conda  install  -n  mambaenv  -c  conda-forge  mamba
$ conda  activate  mambaenv
$ mamba  create  -c  conda-forge  -c  bioconda  -n  snakemakenv  snakemake
$ conda  activate  snakemakenv
```

```bash
#conda way
$ conda  create  -c  conda-forge  -c  bioconda  -n  snakemakenv  snakemake
$ conda  activate  snakemakenv
```

More details [here](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html) 

## Usage

Before actually running a snakemake pipeline, you can try the ``dry mode (-np)``, which do not execute anything, and display what would be done. This is a good way to check that all the commands/inputs/output are as expected:

```bash
$ snakemake --snakefile example.snk.py --cores 1 -np
```
And if you want to run it:
```bash
$ snakemake --snakefile example.snk.py --cores 1
```

For usage documentation, run `snakemake --help`.

## Examples
 
 Let's start with a very basic example, a pipeline with a single real step.
 
  ### Example1. A simple example
```python
#dry run
#snakemake --snakefile example1.snk.py --cores 1 -np

import subprocess, sys, os, glob

# Input parameters  ---------------------------------

# Rules             --------------------------------- 

rule all:
    input:
        'output/sample1_1_fastqc.html'

rule FASTQC:
    input:
        'data/sample1_1.fastq.gz'
    output:
        'output/sample1_1_fastqc.html'
    threads: 1
    shell:""" 
        fastqc -o output/ -t 1 {input}
    """
```
 
!!! warning annotate " Snakemake starts at the end. " 

By default snakemake executes the first rule in the snakefile. It is possible to overwrite this behavior by explicitly marking a rule as being the default target via the default_target directive. ([+ info](It%20is%20possible%20to%20overwrite%20this%20behavior%20to%20use%20the%20first%20rule%20as%20a%20default%20target,%20by%20explicitly%20marking%20a%20rule%20as%20being%20the%20default%20target%20via%20the%20default_target%20directive:)). 

As you can see, there are two rules, ``all`` and ``FASTQC`` but actually only one of them (``FASTQC``) is a proper rule. Our first rule, ``all``, requires as an input the final output of the pipeline, the ``fastqc.html`` files. We only define it as a final-rule, to explicity define what we want as a final pipeline ouput. To obtain the rule ``all`` input (and finish the pipeline's execution), snakemake checks which rule needs to be executed to obtain it (``FASTQC``, in this case). Then it checks again the input of ``FASTQC``, in case it is the output from another rule, and so on, until it reaches the beggining of the pipeline. In this example, there is only one rule, so the final output (``fastqc.html`` files) is the output of the unique rule (``FASTQC``).


Every step from the pipeline is defined within a rule. Every rule has some basic parameters:
- **Input/output** where we define the input and expected output of our rule.
- **Shell/run/script**: A rule can be a bash command (``shell``), a python script (``run``) or a script in almost any language (``script``).

Additionally, there are many optional parameters: [threads](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#threads), [resources](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#resources) , [preemptible-jobs](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#preemptible-jobs), [messages](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#messages), [Log-Files](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#log-files) and [more.](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html)..

  ### Example2. **Wildcards**
  
  In this case, we specified (hardcoded) the name of the samples (``['sample1_1',  'sample1_2']``) and the input folder (``data/``)
  
```python
#dry run
#snakemake --snakefile example2.snk.py --cores 1 -np

import subprocess, sys, os, glob

# Input parameters  ---------------------------------

# Rules             --------------------------------- 

SAMPLES = ['sample1_1', 'sample1_2']

rule all:
    input:
        expand('output/{sample}_fastqc.html', sample=SAMPLES)

rule FASTQC:
    input:
        'data/{sample}.fastq.gz'
    output:
        'output/{sample}_fastqc.html'
    threads: 1
    shell:""" 
        fastqc -o output/ -t 1 {input}
    """

Usage: nextflow [options] COMMAND [arg...]
```
Now, If we run the script in dry mode:
```bash
$ snakemake --snakefile example2.snk.py --cores 1 -np
Building DAG of jobs...
Job stats:
job       count    min threads    max threads
------  -------  -------------  -------------
FASTQC        2              1              1
all           1              1              1
total         3              1              1


[Thu Mar 16 15:25:31 2023]
rule FASTQC:
    input: data/sample1_1.fastq.gz
    output: output/sample1_1_fastqc.html
    jobid: 1
    reason: Missing output files: output/sample1_1_fastqc.html; Code has changed since last execution
    wildcards: sample=sample1_1
    resources: tmpdir=/tmp/jobs/mgrau/8723006

 
        fastqc -o output/ -t 1 data/sample1_1.fastq.gz
    

[Thu Mar 16 15:25:31 2023]
rule FASTQC:
    input: data/sample1_2.fastq.gz
    output: output/sample1_2_fastqc.html
    jobid: 2
    reason: Missing output files: output/sample1_2_fastqc.html; Code has changed since last execution
    wildcards: sample=sample1_2
    resources: tmpdir=/tmp/jobs/mgrau/8723006

 
        fastqc -o output/ -t 1 data/sample1_2.fastq.gz
    

[Thu Mar 16 15:25:31 2023]
localrule all:
    input: output/sample1_1_fastqc.html, output/sample1_2_fastqc.html
    jobid: 0
    reason: Input files updated by another job: output/sample1_1_fastqc.html, output/sample1_2_fastqc.html
    resources: tmpdir=/tmp/jobs/mgrau/8723006

Job stats:
job       count    min threads    max threads
------  -------  -------------  -------------
FASTQC        2              1              1
all           1              1              1
total         3              1              1
```
For every sample defined in the ``SAMPLES = ['sample1_1', 'sample1_2']``, it executes the rule ``FASTQC``:
- ``fastqc -o output/ -t 1 data/sample1_1.fastq.gz``
- ``fastqc -o output/ -t 1 data/sample1_2.fastq.gz``

And it ends when the rule ``all`` is executed. Three rules are executed in total (``FASTQC`` x2 times + ``all`` x 1 time).

### TO BE CONTINUED...


## Links

- [Snakemake Installation](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html)


## Reference

- Miguel Grau
