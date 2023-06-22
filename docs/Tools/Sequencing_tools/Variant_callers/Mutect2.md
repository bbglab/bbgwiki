# Mutect2

## Description

Mutect2 is a variant caller that calls somatic SNVs and indels via local assembly of haplotypes.
It is included into [Genome Analysis Toolkit](https://gatk.broadinstitute.org/hc/en-us/) a collection of command-line tools for analyzing high-throughput sequencing data with a primary focus on variant discovery.

It can be used with two modes:
1. tumor-normal mode where a tumor sample is matched with a normal sample in analysis.
1. tumor-only mode where a single sample's alignment data undergoes analysis

## Requirements

To run Mutect2, the program required the following files:

-Tumor bam file.
-Normal bam file. (Only required in the tumor-normal mode)
-reference file in fasta format.

Mutect2 does not require a germline resource nor a panel of normals (PoN) to run, although both are recommended.
-germline resource: 
-panel of normals vcf file. To create a PoN, call on each normal sample in this mode, then use [CreateSomaticPanelOfNormals](https://gatk.broadinstitute.org/hc/en-us/articles/360037227652-CreateSomaticPanelOfNormals-BETA-) to generate the PoN.

## Usage

(i) Tumor with matched normal

```
     gatk Mutect2 \
     -R reference.fa \
     -I tumor.bam \
     -I normal.bam \
     -normal normal_sample_name \
     --germline-resource af-only-gnomad.vcf.gz \
     --panel-of-normals pon.vcf.gz \
     -O somatic.vcf.gz
```

(ii) Tumor-only mode

```
    gatk Mutect2 \
    -R reference.fa \
    -I sample.bam \
    --germline-resource af-only-gnomad.vcf.gz \
    --panel-of-normals pon.vcf.gz \
    -O single_sample.vcf.gz
```

## Best Practises

Mutect2 can be also used together with other GATK tools for complete workflows. 
Check for [Best Practices Workflows](https://gatk.broadinstitute.org/hc/en-us/articles/360035894731-Somatic-short-variant-discovery-SNVs-Indels-)

Somatic short variant discovery workflow includes the following steps:
* Call candidate variants: Mutect2
* Calculate Contamination: 
* Learn Orientation Bias Artifacts
* Filter Variants

## Reference

[Mutect2](https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2) official webpage
