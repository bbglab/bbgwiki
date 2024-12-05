# Cutadapt

## Description

!!! note annotate ""
    Cutadapt finds and removes adapter sequences, primers, poly-A tails and other types of unwanted sequence from your high-throughput sequencing reads.

---

## Installation

You can check the installation documentation [here](https://cutadapt.readthedocs.io/en/stable/installation.html).

### Package Manager

```bash
sudo apt install cutadapt
```

Or possibly

```bash
sudo apt install python3-cutadapt
```

Verify the installation:

```bash
cudatapt --version
```

### Conda

If you use `conda`, you can install `cutadapt` with:

```bash
conda install -c bioconda cutadapt
```

## Basic usage

For the full list of options:

```bash
cutadapt -h
```

### Basic command syntax

```bash
cutadapt -a <adapter-sequence> -o <output-file> <input-file>
```

For example, trimming an adapter (`AGATCGGAAGAG` in this case) from a fastq file will be:

```bash
cutadapt -a AGATCGGAAGAG -o output_reads.fastq input_reads.fastq
```

If you're working with paired-end reads, specify both input and output files:

```bash
cutadapt -a AGATCGGAAGAG -A AGATCGGAAGAG -o output_R1.fastq -p output_R2.fastq input_R1.fastq input_R2.fastq
```

You can use `cutadapt` to trim low-quality bases from the ends of reads ( in this example quality score < 20):

```bash
cutadapt -q 20 -o output_reads.fastq input_reads.fastq
```

And also to discard reads shorter than a selected value after trimming (in this example 30 nucleotides)

```bash
cutadapt -m 30 -o output_reads.fastq input_reads.fastq
```

## Warning

Check out the full documentation on how to use cutadapt for all different types of adapters.
Cutadapt can detect multiple adapter types:

| Adapter Type            | Command-line Option           |
|-------------------------|-------------------------------|
| Regular 3' adapter      | `-a ADAPTER`                 |
| Regular 5' adapter      | `-g ADAPTER`                 |
| Non-internal 3' adapter | `-a ADAPTERX`                |
| Non-internal 5' adapter | `-g XADAPTER`                |
| Anchored 3' adapter     | `-a ADAPTER$`                |
| Anchored 5' adapter     | `-g ^ADAPTER`                |
| 5' or 3' (both possible)| `-b ADAPTER`                 |
| Linked adapter          | `-a ADAPTER1...ADAPTER2 -g ADAPTER1...ADAPTER2` |

## Reference

- [Full documentation](https://cutadapt.readthedocs.io/en/stable/index.html)
- [cutadapt GitHub](https://github.com/marcelm/cutadapt)
- Davide Scarpetta
