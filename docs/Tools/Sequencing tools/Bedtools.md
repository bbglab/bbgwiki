# Bedtools

!!! note annotate ""
    The Bedtools suite is a collection of tools for a wide-range of genomics analysis tasks.

## Installation

You can check the installation guide [here](https://bedtools.readthedocs.io/en/latest/content/installation.html).

## Usage
To run the default installed version of Bedtools, simply load the bedtools module:

```
$ bedtools -h

Usage:   bedtools <subcommand> [options]
For full usage documentation, run bedtools -h.
```

## Example job
### Serial job
Here is an example job running on 1 core and 1GB of memory:

```bash
#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 1
#$ -l h_rt=1:0:0
#$ -l h_vmem=1G

# Report the base-pair overlap between the features in two BED files.
bedtools intersect -a reads.bed -b genes.bed
```

## Links

- [Bedtools GitHub](https://github.com/arq5x/bedtools2)
- [Bedtools documentation](https://bedtools.readthedocs.io/en/latest/index.html#)

## Reference

- Hania Kranas