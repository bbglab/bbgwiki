# Bowtie2

!!! note annotate ""
    Bowtie2 is an ultra fast and memory-efficient tool for aligning sequencing reads to long reference sequences.

---

## Installation

You can check the installation documentation [here](https://www.metagenomics.wiki/tools/bowtie2/install).

### Conda

```bash
conda install -c bioconda bowtie2
```

### Package manager

```bash
sudo apt update
sudo apt install bowtie2
```

### Manually on Ubuntu/Linux

Create and go to install directory

```bash
cd $HOME/tools/bowtie2/
```

Download Ubuntu/Linux version

```bash
wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.4.2/bowtie2-2.4.2-sra-linux-x86_64.zip/download
```

Decompress

```bash
unzip download
```

Add location to system PATH

```bash
export PATH=$HOME/tools/bowtie2/bowtie2-2.4.2-sra-linux-x86_64:$PATH
```

### Check installation

```bash
bowtie2 --help
```

---

## Usage

```bash
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

---

## Links

- [Bowtie2 GitHub](https://github.com/BenLangmead/bowtie2)
- [Bowtie2 example](https://github.com/BenLangmead/bowtie2/blob/master/MANUAL.markdown#getting-started-with-bowtie-2-lambda-phage-example)<!--markdownlint-disable MD013-->

---

## Reference

- Hania Kranas
