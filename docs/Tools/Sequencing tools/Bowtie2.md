# Bowtie2

!!! note annotate ""
    Bowtie2 is an ultra fast and memory-efficient tool for aligning sequencing reads to long reference sequences.


## Installation

### Conda

```bash
conda install -c bioconda bowtie2
```

### Package manager

```bash
sudo apt update
sudo apt install bowtie2
```

## Usage

```
$ bowtie2 -h

Usage:   bowtie2 [options]* -x <bt2-idx> {-1 <m1> -2 <m2> | -U <r> |
         --interleaved <i>} -S [<sam>]
```

For full usage documentation, run `bowtie2 -h`.

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

# Prepare example genomes in <inputDir>
# Output is stored in <outputDir>
bowtie2-build <inputDir> <outputDir>
bowtie2-inspect <outputDir>
```

## Links

- [Bowtie2 GitHub](https://github.com/BenLangmead/bowtie2)
- [Bowtie2 example](https://github.com/BenLangmead/bowtie2/blob/master/MANUAL.markdown#getting-started-with-bowtie-2-lambda-phage-example)

## Reference

- Hania Kranas