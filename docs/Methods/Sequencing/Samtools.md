# SAMtools

!!! note annotate ""
    SAMtools implements various utilities for post-processing alignments in the SAM format, such as indexing, variant
    caller and alignment viewer, and thus provides universal tools for processing read alignments.

## Installation

### Conda

```bash
conda install -c bioconda samtools
```

### Manual

For the manual installation, you can find the instructions
[here](http://www.sthda.com/english/wiki/install-samtools-on-unix-system).

## Usage

```bash
samtools view -b -S -o genome_reads_aligned.bam genome_reads_aligned.sam
```

!!! note annotate "Core Usage"
    To ensure that SAMtools uses the correct number of cores, the `-@ ${NSLOTS}` option
    should be used on commands that support it.

## Example job

### Serial job

Here is an example job running on 4 cores and 8GB of memory:

```bash
#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 4
#$ -l h_rt=1:0:0
#$ -l h_vmem=2G

samtools view -@ ${NSLOTS} -b -S -o genome_reads_aligned.bam \
    genome_reads_aligned.sam

samtools sort -@ ${NSLOTS} genome_reads_aligned.bam \
    > genome_reads_aligned.sorted.bam

samtools index genome_reads_aligned.sorted.bam

samtools mpileup -g -f ref_genome_1K.fna genome_reads_aligned.sorted.bam \
    > genome_variants.bcf
```

## Links

- [Samtools GitHub](https://github.com/samtools/samtools)
- [Samtools website](https://www.htslib.org/)
- [Samtools documentation](https://www.htslib.org/doc/samtools.html)

## Reference

- Hania Kranas
