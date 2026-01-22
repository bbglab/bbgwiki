# Reference genomes

## Description

The same reference genomes are used across many different projects. Although each user may prefer to have its own copy
of the genome sequence, there is a `genomes` folder in datasets that can serve as the collective
storage of reference genomes.

You can find the full path to the directory here:
`/data/bbg/datasets/genomes/`

The contents of this folder are the following:

```sh
GRCh37
GRCh38
iGenomes
iGenomes_2022
purple_resources
README.txt
Saccharomyces_cerevisiae
SageGermlinePon.hg38.98x.vcf.gz
SAGE_resources
```

GRCh37 -> contains only the FASTA file of the genome assembly GRCh37

GRCh38 -> contains the genomic sequence of GRCh38 human genome assembly with several index files,
as well as some annotation files.

iGenomes -> contains the illumina Homo sapiens genomes in different versions and
from different origins (NCBI, GATK, UCSC)

iGenomes_2022 -> contains the illumina Homo sapiens genome for version GRCh38 and from NCBI

purple_resources -> contains two files seemingly related to a panel of normals.

Saccharomyces_cerevisiae -> contains information of the genome of this species and it was downloaded from UCSC iGenomes.

SageGermlinePon... and SAGE resources are resources related to running SAGE.

### Recommendations

It would be good to get used to use the reference files that are here avoiding the creation of
multiple copies of the same files all along the cluster.

## Reference

Ferriol Calvet

2023/03/16
