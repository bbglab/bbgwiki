
# Sarek

!!! note annotate ""
    Sarek is a pipeline built using Nextflow designed to detect variants in whole or targeted sequencing data.
    It works on any species with a
    reference genome and allows for germline, tumor only and tumor-normal pair variant calling

## Description

Sarek workflow consists of the following steps:

- **Preprocessing** (based on GATK4 Best Practices): includes sequencing quality control, reads alignment (BWA),
mark duplicates and base recalibration.
- **Variant calling**. You can choose any caller, but here are some recommendations:
  - *HaplotypeCaller* for germline SNVs and indels.
  - *[Mutect2](Mutect2.md)* and *Strelka* for somatic SNVs and indels.
  - *Manta* for structural variants (SVs).
  - *ASCAT* for copy number variants (CNVs)
- **Annotation**: you can choose snpEff, VEP or merge both.

Note sarek allows to run the pipeline starting from any step.

## Installation

You can follow the instructions in [Sarek's webpage](https://nf-co.re/sarek#quick-start). Take this into account
if you plan to use sarek in the cluster:

1. Create a conda environment to install the latest java version ([openjdk](https://anaconda.org/conda-forge/openjdk)
specifically).
2. Preferably, use Singularity as container. It is not necessary to install it as it is already
installed in the cluster.
3. Better download and run the pipeline test specifying the version, entering the `-r` argument:

    ```sh
    nextflow run nf-core/sarek -r 3.1.2 -profile test,singularity
    ```

4. Create a config file (you can name it `sarek.conf`) to specify the executor and Singularity cache directory.
In this file you can also add any changes in the configuration specification of the pipeline steps
(*e.g.*: memory limit). Example:

    ```conf
    executor {
        name = 'slurm'
        queueSize = 25
    }

    singularity {
        cacheDir = '/home/$USER/singcache'
    }

    process {
        withName: 'NFCORE_SAREK:SAREK:BAM_MARKDUPLICATES:GATK4_MARKDUPLICATES' {
            cpus = 28
            memory = 200.GB
        }
    }
    ```

## Usage

To run the pipeline you can follow the instruction in
[sarek's webpage](https://nf-co.re/sarek/3.1.2/usage#running-the-pipeline), first activating the conda environment
with java installed. Here is an example of a command to run the analysis from alignment generation to variant
annotation, calling germline and somatic SNVs, SVs and CNVs:

```sh
conda activate java
nextflow run nf-core/sarek -r 3.1.2 -profile singularity -c /path/to/sarek.conf \
    --input input.csv --genome GATK.GRCh38 --igenomes_base /path/to/igenomes/ \
    --tools 'haplotypecaller,strelka,ascat,manta,mutect2,vep' 
```

To start the pipeline from a different step you will have to include the `--step` flag in the command. If you only want
to generate the alignments, omit the `--tools` flag.
To avoid pipeline freezing, it is highly recommended to use a local version of iGenomes instead of pulling it
from AWS during pipeline execution.

### Create `input.csv`

Sarek uses a comma-separated samplesheet with information about the samples to run the pipeline. Here you specify
information as the patient-id, sex, status (normal/tumor), etc. In
[sarek's webpage](https://nf-co.re/sarek/3.1.2/usage#running-the-pipeline) you can find examples of the mandatory
fields required in the samplesheet depending on the pipeline step from which you start the analysis.

### Main outputs

If you run the entire pipeline, you will end with many files. From those, we will highlight:

- In  `results/preprocessing/recalibrated/` the final alignments in CRAM format per sample.
- In `results/variant_calling/` the VCFs per caller and sample.
- In `results/annotation/` the annotated VCFs per caller and sample.

## Links

- [Sarek official webpage](https://nf-co.re/sarek/3.1.2)
- As an output example, the data in `/workspace/datasets/all_aecc_pediatric` was generated using sarek version 3.1.1.
Feel free to give it a look if needed.

## Reference

- Raquel Blanco
- Monica Sanchez
- Miguel Grau
