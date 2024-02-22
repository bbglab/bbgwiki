# BGsignature

## Description

BGsignature is a package used to compute mutational profiles. A mutational profile corresponds to the count or the normalized frequencies of mutations in every possible k-nucleotide (e.g., trinucleotide or pentanucleotide) contexts. 

BGsignature package includes three tools:

* __count__: get the number of mutations in the k-nucleotide contexts
* __frequency__: get the frequency of mutations (count divided by total mutations) in the k-nucleotide contexts
* __normalize__: get the normalized frequency of mutations taking into account the k-nucleotide contexts

The count and the frequency of mutations can be computed for a set of regions or for a set of mutations that fall within certain regions.

## Instalation 

```bash
pip install bgsignature
```

## Input

BGsignature requires two input files:

* __mutations file__: tab separated file (can be compressed into gz, bgz or xz formats) with a header and at least these columns: CHROMOSOME, POSITION, REF, ALT. In addition, SAMPLE, CANCER_TYPE and SIGNATURE are optional columns that can be used for grouping the signature.

* __regions file__: tab separated file (can be compressed into gz, bgz or xz formats) with a header and at least these columns: CHROMOSOME, START, END, ELEMENT. In addition, SYMBOL, and SEGMENT are optional columns that can be used for grouping the signature.

## Examples

Example on how to compute the normalized frequency of mutations in trinucleotide contexts, i.e., the mutationalal profile of 192 channels often used by the driver discovery methods developed by the BBGLab.

1. Get the region files.

The region file can simply include the coordinates of the reference genome (including all regions), or the coordinates of a subset of regions of interest that the user want to use to compute the mutational profiles. The reference genome can be downloaded from different sources such as the [UCSC Genome Browser](https://genome.ucsc.edu/cgi-bin/hgTables){:target="_blank"}.

2. Get the count of mutatation in trinucleotide contexts

```bash
bgsignature count -r my/regions/file -s 3 -g hg38 --cores 4 --collapse --exclude-N -o my/count.json
```

3. Get the frequency of mutations normalized by trinucleotide bias


## Repository
Click here to see the [repository of BGsignature](https://bitbucket.org/bgframework/bgsignature/src/master/){:target="_blank"}.

## Reference
- Stefano Pellegrini
