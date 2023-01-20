# HMFtools

## Description

HMFtools is a pipeline that can be run on our cluster to perform variant calling and analysis. It resembles the exact pipeline that it is used in Google Cloud Platform (see [Platinum](Platinum.md)) but it **does not** run in parallel and it is not optimized for HPC computing.

The scripts, the tools and the reference data are provided by HMF on their [GitHub](https://github.com/hartwigmedical/hmftools/tree/master/pipeline) and Google Cloud.


## Installation

### create conda env with requirements

Move to the hmftools pipeline folder:

```sh
cd /workspace/projects/hartwig/hmftools/pipeline/
```

create a conda envirnoment with the `ENV.txt` file.

```sh
conda create --name hwpipe --file ENV.txt
```

!!! warning Data Access
    You need specific permission to access the `/workspace/projects/hartwig/` following folder. Please contact Martina or Paula if you need to use this data. More info [here](../../../Datasets/General_datasets/Hartwig.md).



## Run

It can be run with a `.bam` file or a `.fastq` file.

=== "BAM" 

    !!! info "Different run mode"
        === "WGS mode" 

            to run the pipeline the command is the following: 

            ```sh
            ./scripts/run_pipeline sample_data "tumorID,referenceID" V38 WGS 10 16
            ```  

            ### Sample data directory = output directory

            The `sample_data` must have:

            - a directory named as the sample's tumorId
            - tumor and reference BAM and BAM index files in the sample's directory, named as tumorId and referenceId.bam

            ```sh
            sample_data
             ├── referenceId.bam.bai
             ├── referenceId.bam
             ├── tumorId.bam.bai
             └── tumorId.bam
            ```

            In this folder the pipeline will make a directory for each of the steps of the pipeline and store the results in subfolders.


            ### Genome reference
            
            The gene reference is `ref_data_dir/V37/ref_genome/Homo_sapiens.GRCh37.GATK.illumina.fasta` for V37 option and `ref_data_dir/V38/ref_genome/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna` for V38

            ### Memory and CPUs parameters
            
            Last two parameters 

            - number of threads used for each component
            - maximum memory allocated to each component (default=12GB)

           
        === "Panel mode"

            to run the pipeline the command is the following: 

            ```sh
            ./scripts/run_pipeline sample_data tumorID V38 PANEL 10 16
            ```  

            ### Sample data directory = output directory

            The `sample_data` must have:

            - a directory named as the sample's tumorId
            - tumor BAM and BAM index files in the sample's directory, named as tumorId and referenceId.bam

            ```sh
            sample_data
             ├── tumorId.bam.bai
             └── tumorId.bam
            ```

            In this folder the pipeline will make a directory for each of the steps of the pipeline and store the results in subfolders.


            ### Genome reference
            
            The gene reference is `ref_data_dir/V37/ref_genome/Homo_sapiens.GRCh37.GATK.illumina.fasta` for V37 option and `ref_data_dir/V38/ref_genome/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna` for V38

            ### Memory and CPUs parameters
            
            Last two parameters 
            
            - number of threads used for each component
            - maximum memory allocated to each component (default=12GB)

=== "FASTQ.gz"

## Reference

## Source

- Federica Brando
