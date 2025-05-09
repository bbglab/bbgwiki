# Tapestri pipeline

!!! note annotate ""
    Tapestri pipeline is designed for processing single-cell DNA and DNA+protein
    sequencing data generated on the Tapestri Platform

## Accessing the platform

The pipeline is currently used online, accessible from the [personal user portal](https://portal.missionbio.com/) on
their website.

## Usage

Clicking on the `Start Run` button here initializes the Run set-up.

![buttons to upload or start run](../../../assets/images/MissionBio-Start_Run.png#center){ width="300" height="200" style="display: block; margin: 0 auto" }<!-- markdownlint-disable MD013 -->

### Options and files

There are three different options that requires different files:

|Options   | Reference Genome | Panel | FASTQ | Notes |
|---------|:-----------------:|:--------:|:-------:|--------|
|1. DNA v2.0.2|yes|1 DNA| DNA | Possibility to stop the run after cells.bam file is produced |
|2. DNA + Protein v2.0.2|yes|1 DNA + 1 Protein| DNA + Protein| The number of DNA and Protein FASTQ files **must be the same**|
|3. Merge Runs v1.0 |no|no|no| at least two **.h5** files (recommended no more than 5)|

- **Reference Genome**. Custom reference file must be in `.fa.zip` format. As of now, there are h19 and mouse reference genomes on Tapestri portal.
- **Panels**. Both DNA and Protein can be either customed or taken from their [Designer catalog](https://designer.missionbio.com/catalog-panels). Custom Panels files must be in `zip` format.
- **FASTQ files**. They must be in `.fastq`, `.fastq.gz`, `.fq` or `.fq.gz` format. The number of files must be even.
- **.h5 files** . Tapestri Pipeline output file of one run. *i.e.* If we have multiple runs of the sample patients but with different stage of the disease we can merge the runs to produce an .h5 file with both samples.

### Output

At the end of the run we end up with a list of files. A detailed list of output files is found [here](Tapestri_pipeline.md#links). Here we present three files:

|File   | Extension | Notes |
|---------|:-----------------:|:--------|
|**report.html**|`.html`| It contains the run details with a summary of the most important specs. Merge Runs and DNA only option do not produce this report.|
|**cells.loom** |`.loom`| It consists of a numerical genotype (NGT) matrix that has 4 other layers. It contains metadata for all the variants. It's the file used as input for [Tapestri Insight](Tapestri_insight.md).|
|**dna+protein.h5** |`.h5`| It contsins data for one or more run. Each run contains data for one or more assays (eg. DNA assay, CNV assay, Protein assay) associated with all the barcodes. It's the file used as input for [Mosaic package](Mosaic.md).|

## Additional resources

MissionBio provided a personal training course, the video lesson on Tapestri Pipeline can be found here:

```sh
/workspace/projects/scell_tall/LOPEBIG_44_analysis/mosaic/Video_Trainings/MissionBio-1-TapestriPipeline.mp4
```

## Links

- [Tapestri Pipeline user guide](https://support.missionbio.com/hc/en-us/articles/360055980994-Tapestri-Pipeline-User-Guide) <!-- markdownlint-disable MD013 -->
- [Pipeline output files overview](https://support.missionbio.com/hc/en-us/articles/360045939853-Pipeline-output-files-overview) <!-- markdownlint-disable MD013 -->
- [Video - Tapestri Pipeline: Processing DNA + Protein sequencing data](https://support.missionbio.com/hc/en-us/articles/1500008569581-Tapestri-Pipeline-Processing-DNA-Protein-sequencing-data)<!-- markdownlint-disable MD013 -->
- [FAQs](https://support.missionbio.com/hc/en-us/sections/360006996673-FAQs)

## Reference

- Federica Brando
