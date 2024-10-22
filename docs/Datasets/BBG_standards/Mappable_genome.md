# Mappable Genome

## Description
The mappable genome is a fraction of the whole genome that excludes low-mappability regions. This mappable genome is usually applied in projects that need a highly reliable list of mutations.

It was created by Loris Mularoni and later refined by Claudia Arnedo (both previous members of the BBG Lab).

There are 3 main steps for generating the mappable genome:

1. A first step is performed by Loris with a tool [GEM Mapper](https://bio.tools/gemmapper) from [this paper](https://www.nature.com/articles/nmeth.2221) from 2012. The file obtained can be found here: `/workspace/projects/pileup_mappability/hg38/hg38_100bp.coverage.regions.gz`
2. A second step is to filter blacklisted regions (aka problematic regions) from ENCODE project. This file is downloaded from ENCODE project web or UCSC database. [Here](https://genome.ucsc.edu/cgi-bin/hgTrackUi?hgsid=1644365230_FsaTsAyXgLRGXZzsZwG7Bmy3xxai&db=hg38&c=chr12&g=problematicSuper) is explained what is this file and what it includes. From [here](https://genome.ucsc.edu/cgi-bin/hgTables) we can download the most updated file.
3. A third step is to filter common polymorphisms by using gnomAD. This step may be omitted depending on our project's objectives. Claudia's hotspots project needed a very clean mappable genome, so she had to avoid any possible germline contamination.
The input file generated in step 1, the downloaded ENCODE blacklisted regions file (not the latest) and the gnomad 3.0 file are in Claudia's hotspots repo here: `/workspace/projects/hartwig/hotspots/hotspotfinder/2022_06/mappable_genome/data/inputs/`. In this folder there is a file `paths.txt` with the paths to the original files.

These are the main cluster paths relevant for the making of the mappable genome:
- `/workspace/projects/pileup_mappability/`: mappable genome with GEM mapper.
- `/workspace/datasets/mappability_blacklists/`: blacklisted regions from ENCODE
- `/workspace/datasets/genomes/`: reference genomes
- `/workspace/projects/genomic_regions/`: genomic regions annotations

Mònica has created a mappable genome with an updated blacklisted regions file and saved it here:\
`/workspace/projects/pileup_mappability/hg38/hg38_100bp.coverage.regions.filtered_blacklisted.gz`

The updated blacklisted regions file is downloaded here:\
`/workspace/datasets/mappability_blacklists/hg38/20240807/`

This plot is the comparison of the trinucleotide counts of the mappable genome (with updated ENCODE blacklisted regions and without filtering the SNPs from gnomAD) with the counts of the genome used in COSMIC (the one used to calculate the signatures). There are no major differences.
![image](https://github.com/user-attachments/assets/e4eb98e6-0a4c-4ea5-aef7-8c44ab8eb904)

## References
Mònica Sánchez Guixé\
Olivia Dove
