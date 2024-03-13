# BGsignature

## Description

BGsignature is a tool to compute mutational profiles. A mutational profile corresponds to the count or the frequencies of mutations in every possible k-nucleotide (e.g., trinucleotide or pentanucleotide) contexts. BGsignature can be used from the command line or as a Python package.

It includes three main functionalities:

* __count__: get the number of mutations in the k-nucleotide contexts or just count different k-mers
* __frequency__: get the frequency of mutations (count divided by total mutations) in the k-nucleotide contexts
* __normalize__: get the normalized frequency of mutations taking into account the k-nucleotide bias

The count and the frequency of mutations can be computed for a set of regions or for a set of mutations that fall within certain regions.

## Installation 

```bash
pip install bgsignature
```

## Input

* __mutations file__: tab separated file (can be compressed into gz, bgz or xz formats) with a header and at least these columns: CHROMOSOME, POSITION, REF, ALT. In addition, SAMPLE, CANCER_TYPE and SIGNATURE are optional columns that can be used for grouping the signature.

* __regions file__: tab separated file (can be compressed into gz, bgz or xz formats) with a header and at least these columns: CHROMOSOME, START, END, ELEMENT. In addition, SYMBOL, and SEGMENT are optional columns that can be used for grouping the signature.

## Examples

Example on how to compute the normalized frequency of mutations in trinucleotide contexts, i.e., the mutationalal profile of 192 channels often used by the driver discovery methods developed by the BBGLab.

### 1. Get the region files

The region file can simply include the coordinates of the reference genome (all regions), or the coordinates of a subset of regions of interest. The reference genome can be downloaded from different sources such as [GenBank](https://www.ncbi.nlm.nih.gov/datasets/genome/){:target="_blank"} or [UCSC Genome Browser](https://genome.ucsc.edu/cgi-bin/hgTables){:target="_blank"}.

### 2. Get the count of trinucleotides (it will be used to normalize the frequency of mutations)

```bash
bgsignature count -r my/regions/file -s 3 -g hg38 --cores 4 --collapse --exclude-N -o my/count.json
```

`collapse` add together reverse complementary sequences

### 3. Get the frequency of mutations normalized by trinucleotide bias

```bash
bgsignature normalize -m my/muts.tsv -r my/regions.tsv --normalize my/count.json -s 3 -g hg38 --collapse --cores 4 -o my/mut_profile.json
```

## Repository
Check out the [BGsignature repository](https://bitbucket.org/bgframework/bgsignature/src/master/){:target="_blank"}. It includes additional information and (not fully comprehensive) examples on how to use the tool as Python package.

## Reference
- Stefano Pellegrini
