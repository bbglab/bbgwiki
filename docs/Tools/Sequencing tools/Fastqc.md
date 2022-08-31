# Fastqc

!!! note annotate ""
    FastQC aims to provide a simple way to do some quality control checks on raw sequence data coming from high throughput sequencing pipelines.

## Installation

### apt-get

```bash
sudo apt-get update
sudo apt-get install fastqc
```

### apt

```bash
sudo apt update
sudo apt install fastqc
```

---

## Usage

```bash
$ fastqc --help
            FastQC - A high throughput sequence QC analysis tool

SYNOPSIS

        fastqc seqfile1 seqfile2 .. seqfileN

    fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam]
           [-c contaminant file] seqfile1 .. seqfileN
```

---

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

fastqc raw_data.fastq.gz raw_data2.fastq.gz
```

!!! note annotate "Viewing the Fastqc results"
    To view the Fastqc results, you may open the fastqc_report.html file in a web browser or the summary.txt file (located in the zipped output archive) on the command line. For assistance copying files to your local machine, please see the Moving Data page.

---

## Links

- [FastQC website](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [FastQC manual](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/)
- [FastQC video tutorial](https://www.youtube.com/watch?v=bz93ReOv87Y)

---

## Reference

- Hania Kranas
