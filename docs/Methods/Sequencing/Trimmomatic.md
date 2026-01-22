# Trimmomatic

!!! note annotate ""
    Trimmomatic, a  flexible read trimming tool for Illumina NGS data.

## Description

Trimmomatic performs a variety of useful trimming tasks for illumina paired-end and single ended data.The selection of
trimming steps and their associated parameters are supplied on the command line.

The current trimming steps are:

- **ILLUMINACLIP**: Cut adapter and other illumina-specific sequences from the read.
- **SLIDINGWINDOW**: Perform a sliding window trimming, cutting once the average quality within the window falls
below a threshold.
- **LEADING**: Cut bases off the start of a read, if below a threshold quality
- **TRAILING**: Cut bases off the end of a read, if below a threshold quality
- **CROP**: Cut the read to a specified length
- **HEADCROP**: Cut the specified number of bases from the start of the read
- **MINLEN**: Drop the read if it is below a specified length
- **TOPHRED33**: Convert quality scores to Phred-33
- **TOPHRED64**: Convert quality scores to Phred-64

It works with FASTQ (using phred + 33 or phred + 64 quality scores, depending on the Illumina pipeline used),
either uncompressed or gzipp'ed FASTQ. Use of gzip format is determined based on the .gz extension.

For single-ended data, one input and one output file are specified, plus the processing steps. For paired-end data,
two input files are specified, and 4 output files, 2 for the 'paired' output where both reads survived the processing,
and 2 for corresponding 'unpaired' output where a read survived, but the partner read did not.

## Installation

### Conda

Use the bioconda channel to install Trimmomatic:

```bash
conda install -c bioconda trimmomatic
```

Check the installation simply running:

```bash
trimmomatic
```

This should output a message or the help output.

### Manual Installation

As `Trimmomatic` is a Java-based tool, be sure to have Java installed checking the version:

```bash
java -version
```

Install it if needed.

The easiest option is to download a binary release zip, and unpack it somewhere convenient.
You can download the binary file from the [GitHub](https://github.com/timflutre/trimmomatic)
official `Trimmomatic` repo or from the website:

```bash
http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip
```

I recommend to download the `version 0.40` directly from the GitHub repo.
Then you'll have to unzip the downloaded file:

```bash
unzip Trimmomatic-0.40.zip
```

This is optional, but if you want to use `Trimmomatic` globally, add it to your path:

```bash
export PATH=/path/to/trimmomatic:$PATH
```

## Basic Usage

### Basic Syntax

```bash
java -jar trimmomatic.jar <mode> <input> <options>
```

- `mode`: Specify whether it's single-end (SE) or paired-end (PE) sequencing.
- `input`: The input FASTQ file(s).
- `options`: Specify trimming options (e.g., adapters, quality thresholds).

### Paired End

```bash
java -jar trimmomatic-0.39.jar PE input_forward.fq.gz input_reverse.fq.gz output_forward_paired.fq.gz output_forward_unpaired.fq.gz output_reverse_paired.fq.gz output_reverse_unpaired.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36
```

This will perform the following:

- Remove adapters (ILLUMINACLIP:TruSeq3-PE.fa:2:30:10)
- Remove leading low quality or N bases (below quality 3) (LEADING:3)
- Remove trailing low quality or N bases (below quality 3) (TRAILING:3)
- Scan the read with a 4-base wide sliding window, cutting when the average
quality per base drops below 15 (SLIDINGWINDOW:4:15)
- Drop reads below the 36 bases long (MINLEN:36)

### Single End

```bash
java -jar trimmomatic-0.35.jar SE -phred33 input.fq.gz output.fq.gz ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
```

This will perform the same steps as paired-end command, using the single-ended adapter file.

## Reference

- [Full documentation](http://www.usadellab.org/cms/?page=trimmomatic)
- [trimmomatic GitHub](https://github.com/timflutre/trimmomatic)
- Davide Scarpetta
