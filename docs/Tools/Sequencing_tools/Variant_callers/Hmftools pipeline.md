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
activate the environment 

```sh
conda activate hwpipe
```

!!! warning Data Access
    You need specific permission to access the `/workspace/projects/hartwig/` following folder. Please contact Martina or Paula if you need to use this data. More info [here](../../../Datasets/General_datasets/Hartwig.md).

## Run

It can be run with a `.bam` file or a `.fastq` file.

=== "BAM"

    !!! info "Run mode"
        === "WGS mode" 

            to run the pipeline the command is the following: 

            ```sh
            ./scripts/run_pipeline <sample_data> "tumorID,referenceID" <gen_version> <run_mode> <threads> <memory>
            ```  

            ### `sample data` directory = output directory

            The `sample_data` directory must have:

            - a directory named as the sample's tumorId
            - tumor and reference BAM and BAM index files in the sample's directory, named as tumorId and referenceId.bam

            i.e. see folder tree below

            ```sh
            sample_data
             └── tumorID
                  ├── referenceId.bam
                  ├── referenceId.bam.bai
                  ├── tumorId.bam
                  └── tumorId.bam.bai
            ```

            In the tumorID folder the pipeline will make a directory for each of the steps and store the results in subfolders.


            ### `gen_version` parameter

            | Genome version | Genome file |
            |:--------------:|:-----------:|
            | V38 |`./ref_data_dir/V38/ref_genome/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna`
            | V37 |`./ref_data_dir/V37/ref_genome/Homo_sapiens.GRCh37.GATK.illumina.fasta` 

            ### `threads` and `memory` parameters

            - `threads` number of threads used for each component
            - `memory`: GB allocated to each component (default=12GB)

            ## Example

            my directory:

            ```sh
            pipeline/test_data/
             └── COLO928T
                  ├── COLO928R.bam
                  ├── COLO928R.bam.bai
                  ├── COLO928T.bam
                  └── COLO928T.bam.bai
            ```
            Run: 

            ```sh
            ./scripts/run_pipeline test_data "COLO928T,COLO928R" V37 WGS 8 16
            ```  
            ??? example "Example output"

                ```
                pipeline/test_data/COLO829T
                ├── amber
                │   ├── amber.version
                │   ├── COLO829R.amber.homozygousregion.tsv
                │   ├── COLO829R.amber.snp.vcf.gz
                │   ├── COLO829R.amber.snp.vcf.gz.tbi
                │   ├── COLO829T.amber.baf.pcf
                │   ├── COLO829T.amber.baf.tsv.gz
                │   ├── COLO829T.amber.contamination.tsv
                │   ├── COLO829T.amber.contamination.vcf.gz
                │   ├── COLO829T.amber.contamination.vcf.gz.tbi
                │   └── COLO829T.amber.qc
                ├── cobalt
                │   ├── cobalt.version
                │   ├── COLO829R.cobalt.gc.median.tsv
                │   ├── COLO829R.cobalt.ratio.median.tsv
                │   ├── COLO829R.cobalt.ratio.pcf
                │   ├── COLO829T.cobalt.gc.median.tsv
                │   ├── COLO829T.cobalt.ratio.pcf
                │   └── COLO829T.cobalt.ratio.tsv.gz
                ├── COLO829R.bam
                ├── COLO829R.bam.bai
                ├── COLO829T.bam
                ├── COLO829T.bam.bai
                ├── gridss
                │   ├── COLO829R.sv_prep.bam
                │   ├── COLO829R.sv_prep.junctions.csv
                │   ├── COLO829R.sv_prep.sorted.bam
                │   ├── COLO829R.sv_prep.sorted.bam.bai
                │   ├── COLO829T.gridss.raw.vcf.gz
                │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam
                │   ├── COLO829T.gridss.raw.vcf.gz.tbi
                │   ├── COLO829T.gridss.unfiltered.vcf.gz
                │   ├── COLO829T.gridss.unfiltered.vcf.gz.tbi
                │   ├── COLO829T.sv_prep.bam
                │   ├── COLO829T.sv_prep.fragment_lengths
                │   ├── COLO829T.sv_prep.junctions.csv
                │   ├── COLO829T.sv_prep.sorted.bam
                │   ├── COLO829T.sv_prep.sorted.bam.bai
                │   └── gridss
                │       ├── COLO829R.bam.gridss.working
                │       ├── COLO829R.sv_prep.sorted.bam.gridss.working
                │       │   ├── COLO829R.sv_prep.sorted.bam.cigar_metrics
                │       │   ├── COLO829R.sv_prep.sorted.bam.computesamtags.changes.tsv
                │       │   ├── COLO829R.sv_prep.sorted.bam.idsv_metrics
                │       │   ├── COLO829R.sv_prep.sorted.bam.insert_size_histogram.pdf
                │       │   ├── COLO829R.sv_prep.sorted.bam.insert_size_metrics
                │       │   ├── COLO829R.sv_prep.sorted.bam.mapq_metrics
                │       │   ├── COLO829R.sv_prep.sorted.bam.sv.bam
                │       │   ├── COLO829R.sv_prep.sorted.bam.sv.bam.csi
                │       │   └── COLO829R.sv_prep.sorted.bam.tag_metrics
                │       ├── COLO829T.bam.gridss.working
                │       ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.gridss.working
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.alignment_summary_metrics
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.cigar_metrics
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.coverage.blacklist.bed
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.downsampled_0.bed
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.excluded_0.bed
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.idsv_metrics
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.mapq_metrics
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.subsetCalled_0.bed
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.sv.bam
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.sv.bam.bai
                │       │   └── COLO829T.gridss.raw.vcf.gz.assembly.bam.tag_metrics
                │       ├── COLO829T.gridss.raw.vcf.gz.gridss.working
                │       │   └── COLO829T.gridss.raw.vcf.gz.allocated.vcf.idx
                │       ├── COLO829T.sv_prep.sorted.bam.gridss.working
                │       │   ├── COLO829T.sv_prep.sorted.bam.cigar_metrics
                │       │   ├── COLO829T.sv_prep.sorted.bam.computesamtags.changes.tsv
                │       │   ├── COLO829T.sv_prep.sorted.bam.idsv_metrics
                │       │   ├── COLO829T.sv_prep.sorted.bam.insert_size_histogram.pdf
                │       │   ├── COLO829T.sv_prep.sorted.bam.insert_size_metrics
                │       │   ├── COLO829T.sv_prep.sorted.bam.mapq_metrics
                │       │   ├── COLO829T.sv_prep.sorted.bam.sv.bam
                │       │   ├── COLO829T.sv_prep.sorted.bam.sv.bam.csi
                │       │   └── COLO829T.sv_prep.sorted.bam.tag_metrics
                │       ├── gridss.full.20221116_120546.bbgn004.49271.log
                │       ├── gridss.timing.20221116_120546.bbgn004.49271.log
                │       └── libsswjni.so
                ├── gripss_germline
                │   ├── COLO829T.gripss.filtered.germline.vcf.gz
                │   ├── COLO829T.gripss.filtered.germline.vcf.gz.tbi
                │   ├── COLO829T.gripss.germline.vcf.gz
                │   └── COLO829T.gripss.germline.vcf.gz.tbi
                ├── gripss_somatic
                │   ├── COLO829T.gripss.filtered.somatic.vcf.gz
                │   ├── COLO829T.gripss.filtered.somatic.vcf.gz.tbi
                │   ├── COLO829T.gripss.somatic.vcf.gz
                │   └── COLO829T.gripss.somatic.vcf.gz.tbi
                ├── lilac
                │   ├── COLO829T.candidates.coverage.csv
                │   ├── COLO829T.lilac.csv
                │   └── COLO829T.lilac.qc.csv
                ├── linx_germline
                │   ├── COLO829T.linx.germline.clusters.tsv
                │   ├── COLO829T.linx.germline.disruption.tsv
                │   ├── COLO829T.linx.germline.driver.catalog.tsv
                │   ├── COLO829T.linx.germline.links.tsv
                │   ├── COLO829T.linx.germline.svs.tsv
                │   └── linx.version
                ├── linx_somatic
                │   ├── COLO829T.linx.breakend.tsv
                │   ├── COLO829T.linx.clusters.tsv
                │   ├── COLO829T.linx.driver.catalog.tsv
                │   ├── COLO829T.linx.drivers.tsv
                │   ├── COLO829T.linx.fusion.tsv
                │   ├── COLO829T.linx.links.tsv
                │   ├── COLO829T.linx.svs.tsv
                │   ├── COLO829T.linx.vis_copy_number.tsv
                │   ├── COLO829T.linx.vis_fusion.tsv
                │   ├── COLO829T.linx.vis_gene_exon.tsv
                │   ├── COLO829T.linx.vis_protein_domain.tsv
                │   ├── COLO829T.linx.vis_segments.tsv
                │   ├── COLO829T.linx.vis_sv_data.tsv
                │   ├── linx.version
                │   ├── plot_data
                │   │   ├── COLO829T.chr10.debug.003.png.error
                │   │   ├── COLO829T.chr10.debug.003.png.out
                │   │   ├── COLO829T.chr10.debug.chromosome.circos
                │   │   ├── COLO829T.chr10.debug.circos.003.conf
                │   │   ├── COLO829T.chr10.debug.cna.circos
                │   │   ├── COLO829T.chr10.debug.connector.circos
                │   │   ├── COLO829T.chr10.debug.distance.circos
                │   │   ├── COLO829T.chr10.debug.exon.circos
                │   │   ├── COLO829T.chr10.debug.exon.rank.circos
                │   │   ├── COLO829T.chr10.debug.fragile.circos
                │   │   ├── COLO829T.chr10.debug.gene.circos
                │   │   ├── COLO829T.chr10.debug.gene.name.circos
                │   │   ├── COLO829T.chr10.debug.karyotype.circos
                │   │   ├── COLO829T.chr10.debug.line_element.circos
                │   │   ├── COLO829T.chr10.debug.link.circos
                │   │   ├── COLO829T.chr10.debug.map.circos
                │   │   ├── COLO829T.chr10.debug.position.circos
                │   │   ├── COLO829T.chr10.debug.scatter.circos
                │   │   ├── COLO829T.chr10.debug.scatter.sgl.circos
                │   │   ├── COLO829T.chr10.debug.segment.circos
                │   │   ├── COLO829T.chr18.debug.003.png.error
                │   │   ├── COLO829T.chr18.debug.003.png.out
                │   │   ├── COLO829T.chr18.debug.chromosome.circos
                │   │   ├── COLO829T.chr18.debug.circos.003.conf
                │   │   ├── COLO829T.chr18.debug.cna.circos
                │   │   ├── COLO829T.chr18.debug.connector.circos
                │   │   ├── COLO829T.chr18.debug.distance.circos
                │   │   ├── COLO829T.chr18.debug.exon.circos
                │   │   ├── COLO829T.chr18.debug.exon.rank.circos
                │   │   ├── COLO829T.chr18.debug.fragile.circos
                │   │   ├── COLO829T.chr18.debug.gene.circos
                │   │   ├── COLO829T.chr18.debug.gene.name.circos
                │   │   ├── COLO829T.chr18.debug.karyotype.circos
                │   │   ├── COLO829T.chr18.debug.line_element.circos
                │   │   ├── COLO829T.chr18.debug.link.circos
                │   │   ├── COLO829T.chr18.debug.map.circos
                │   │   ├── COLO829T.chr18.debug.position.circos
                │   │   ├── COLO829T.chr18.debug.scatter.circos
                │   │   ├── COLO829T.chr18.debug.scatter.sgl.circos
                │   │   ├── COLO829T.chr18.debug.segment.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.003.png.error
                │   │   ├── COLO829T.cluster-1.sv1.debug.003.png.out
                │   │   ├── COLO829T.cluster-1.sv1.debug.chromosome.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.circos.003.conf
                │   │   ├── COLO829T.cluster-1.sv1.debug.cna.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.connector.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.distance.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.exon.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.exon.rank.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.fragile.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.gene.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.gene.name.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.karyotype.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.line_element.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.link.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.map.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.position.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.scatter.circos
                │   │   ├── COLO829T.cluster-1.sv1.debug.scatter.sgl.circos
                │   │   └── COLO829T.cluster-1.sv1.debug.segment.circos
                │   └── plots
                │       ├── COLO829T.chr10.debug.003.png
                │       ├── COLO829T.chr18.debug.003.png
                │       └── COLO829T.cluster-1.sv1.debug.003.png
                ├── pave_germline
                │   ├── COLO829T.sage.germline.pave.vcf.gz
                │   └── COLO829T.sage.germline.pave.vcf.gz.tbi
                ├── pave_somatic
                │   ├── COLO829T.sage.somatic.pave.vcf.gz
                │   └── COLO829T.sage.somatic.pave.vcf.gz.tbi
                ├── purple
                │   ├── circos
                │   │   ├── COLO829R.ratio.circos
                │   │   ├── COLO829T.baf.circos
                │   │   ├── COLO829T.circos.conf
                │   │   ├── COLO829T.circos.png.error
                │   │   ├── COLO829T.circos.png.out
                │   │   ├── COLO829T.cnv.circos
                │   │   ├── COLO829T.indel.circos
                │   │   ├── COLO829T.input.conf
                │   │   ├── COLO829T.input.png.error
                │   │   ├── COLO829T.input.png.out
                │   │   ├── COLO829T.link.circos
                │   │   ├── COLO829T.map.circos
                │   │   ├── COLO829T.ratio.circos
                │   │   ├── COLO829T.snp.circos
                │   │   └── gaps.txt
                │   ├── COLO829T.driver.catalog.germline.tsv
                │   ├── COLO829T.driver.catalog.somatic.tsv
                │   ├── COLO829T.purple.cnv.gene.tsv
                │   ├── COLO829T.purple.cnv.somatic.tsv
                │   ├── COLO829T.purple.germline.deletion.tsv
                │   ├── COLO829T.purple.germline.vcf.gz
                │   ├── COLO829T.purple.germline.vcf.gz.tbi
                │   ├── COLO829T.purple.purity.range.tsv
                │   ├── COLO829T.purple.purity.tsv
                │   ├── COLO829T.purple.qc
                │   ├── COLO829T.purple.segment.tsv
                │   ├── COLO829T.purple.somatic.clonality.tsv
                │   ├── COLO829T.purple.somatic.hist.tsv
                │   ├── COLO829T.purple.somatic.vcf.gz
                │   ├── COLO829T.purple.somatic.vcf.gz.tbi
                │   ├── COLO829T.purple.sv.vcf.gz
                │   ├── COLO829T.purple.sv.vcf.gz.tbi
                │   ├── plot
                │   │   ├── COLO829T.circos.png
                │   │   ├── COLO829T.copynumber.png
                │   │   ├── COLO829T.input.png
                │   │   ├── COLO829T.map.png
                │   │   ├── COLO829T.purity.range.png
                │   │   ├── COLO829T.segment.png
                │   │   ├── COLO829T.somatic.clonality.png
                │   │   ├── COLO829T.somatic.png
                │   │   └── COLO829T.somatic.rainfall.png
                │   └── purple.version
                ├── run005_37_wgs.log
                ├── sage_germline
                │   ├── COLO829T.sage.germline.vcf.gz
                │   └── COLO829T.sage.germline.vcf.gz.tbi
                └── sage_somatic
                    ├── COLO829R.sage.bqr.tsv
                    ├── COLO829T.sage.bqr.tsv
                    ├── COLO829T.sage.exon.medians.tsv
                    ├── COLO829T.sage.gene.coverage.tsv
                    ├── COLO829T.sage.somatic.vcf.gz
                    └── COLO829T.sage.somatic.vcf.gz.tbi
                ```
           
        === "Panel mode"

            to run the pipeline the command is the following: 

            ```sh
            ./scripts/run_pipeline <sample_data> "tumorID" <gen_versio> <run mode> <threads> <memory>
            ```  

            ### `sample data` directory = output directory

            The `sample_data` must have:

            - a directory named as the sample's tumorId
            - tumor BAM and BAM index files in the sample's directory, named as tumorId and referenceId.bam

            i.e. see folder tree below

            ```sh
            sample_data
             └── tumorID
                  ├── tumorId.bam
                  └── tumorId.bam.bai
            ```

            In the tumorID folder the pipeline will make a directory for each of the steps and store the results in subfolders.


            ### `gen_version` parameter

            | Genome version | Genome file |
            |:--------------:|:-----------:|
            | V38 |`./ref_data_dir/V38/ref_genome/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna`
            | V37 |`./ref_data_dir/V37/ref_genome/Homo_sapiens.GRCh37.GATK.illumina.fasta` 

            ### `threads` and `memory` parameters

            - `threads` number of threads used for each component
            - `memory`: GB allocated to each component (default=12GB)
 
            ## Example

            my directory:

            ```sh
            pipeline/test_data/
             └── COLO928T
                  ├── COLO928T.bam
                  └── COLO928T.bam.bai
            ```
            Run: 

            ```sh
            ./scripts/run_pipeline test_data COLO928T V37 PANEL 8 16
            ```  
            ??? example "Example output"

                ```
                pipeline/test_data/COLO829T/
                ├── amber
                │   ├── amber.version
                │   ├── COLO829T.amber.baf.pcf
                │   ├── COLO829T.amber.baf.tsv.gz
                │   └── COLO829T.amber.qc
                ├── cobalt
                │   ├── cobalt.version
                │   ├── COLO829T.cobalt.gc.median.tsv
                │   ├── COLO829T.cobalt.ratio.pcf
                │   └── COLO829T.cobalt.ratio.tsv.gz
                ├── COLO829T.bam
                ├── COLO829T.bam.bai
                ├── gridss
                │   ├── COLO829T.gridss.raw.vcf.gz
                │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam
                │   ├── COLO829T.gridss.raw.vcf.gz.tbi
                │   ├── COLO829T.gridss.unfiltered.vcf.gz
                │   ├── COLO829T.gridss.unfiltered.vcf.gz.tbi
                │   ├── COLO829T.sv_prep.bam
                │   ├── COLO829T.sv_prep.fragment_lengths
                │   ├── COLO829T.sv_prep.junctions.csv
                │   ├── COLO829T.sv_prep.sorted.bam
                │   ├── COLO829T.sv_prep.sorted.bam.bai
                │   └── gridss
                │       ├── COLO829T.bam.gridss.working
                │       ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.gridss.working
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.alignment_summary_metrics
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.cigar_metrics
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.coverage.blacklist.bed
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.downsampled_0.bed
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.excluded_0.bed
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.idsv_metrics
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.mapq_metrics
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.subsetCalled_0.bed
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.sv.bam
                │       │   ├── COLO829T.gridss.raw.vcf.gz.assembly.bam.sv.bam.bai
                │       │   └── COLO829T.gridss.raw.vcf.gz.assembly.bam.tag_metrics
                │       ├── COLO829T.gridss.raw.vcf.gz.gridss.working
                │       │   └── COLO829T.gridss.raw.vcf.gz.allocated.vcf.idx
                │       ├── COLO829T.sv_prep.sorted.bam.gridss.working
                │       │   ├── COLO829T.sv_prep.sorted.bam.cigar_metrics
                │       │   ├── COLO829T.sv_prep.sorted.bam.computesamtags.changes.tsv
                │       │   ├── COLO829T.sv_prep.sorted.bam.idsv_metrics
                │       │   ├── COLO829T.sv_prep.sorted.bam.insert_size_histogram.pdf
                │       │   ├── COLO829T.sv_prep.sorted.bam.insert_size_metrics
                │       │   ├── COLO829T.sv_prep.sorted.bam.mapq_metrics
                │       │   ├── COLO829T.sv_prep.sorted.bam.sv.bam
                │       │   ├── COLO829T.sv_prep.sorted.bam.sv.bam.csi
                │       │   └── COLO829T.sv_prep.sorted.bam.tag_metrics
                │       ├── fbrando
                │       ├── gridss.full.20230113_110106.login01.6901.log
                │       └── libsswjni.so
                ├── gripss
                │   ├── COLO829T.gripss.filtered.somatic.vcf.gz
                │   ├── COLO829T.gripss.filtered.somatic.vcf.gz.tbi
                │   ├── COLO829T.gripss.somatic.vcf.gz
                │   └── COLO829T.gripss.somatic.vcf.gz.tbi
                ├── lilac
                │   ├── COLO829T.candidates.coverage.csv
                │   ├── COLO829T.lilac.csv
                │   └── COLO829T.lilac.qc.csv
                ├── linx
                │   ├── plot_data
                │   └── plots
                ├── pave
                │   ├── COLO829T.sage.pave.vcf.gz
                │   └── COLO829T.sage.pave.vcf.gz.tbi
                ├── purple
                │   ├── circos
                │   │   ├── COLO829T.baf.circos
                │   │   ├── COLO829T.circos.conf
                │   │   ├── COLO829T.circos.png.error
                │   │   ├── COLO829T.circos.png.out
                │   │   ├── COLO829T.cnv.circos
                │   │   ├── COLO829T.indel.circos
                │   │   ├── COLO829T.input.conf
                │   │   ├── COLO829T.input.png.error
                │   │   ├── COLO829T.input.png.out
                │   │   ├── COLO829T.link.circos
                │   │   ├── COLO829T.map.circos
                │   │   ├── COLO829T.ratio.circos
                │   │   ├── COLO829T.snp.circos
                │   │   ├── gaps.txt
                │   │   └── null.ratio.circos
                │   ├── COLO829T.driver.catalog.somatic.tsv
                │   ├── COLO829T.purple.cnv.gene.tsv
                │   ├── COLO829T.purple.cnv.somatic.tsv
                │   ├── COLO829T.purple.purity.range.tsv
                │   ├── COLO829T.purple.purity.tsv
                │   ├── COLO829T.purple.qc
                │   ├── COLO829T.purple.segment.tsv
                │   ├── COLO829T.purple.somatic.clonality.tsv
                │   ├── COLO829T.purple.somatic.hist.tsv
                │   ├── COLO829T.purple.somatic.vcf.gz
                │   ├── COLO829T.purple.somatic.vcf.gz.tbi
                │   ├── COLO829T.purple.sv.vcf.gz
                │   ├── COLO829T.purple.sv.vcf.gz.tbi
                │   ├── plot
                │   │   ├── COLO829T.input.png
                │   │   ├── COLO829T.somatic.clonality.png
                │   │   ├── COLO829T.somatic.png
                │   │   └── COLO829T.somatic.rainfall.png
                │   └── purple.version
                └── sage
                    ├── COLO829T.sage.bqr.tsv
                    ├── COLO829T.sage.exon.medians.tsv
                    ├── COLO829T.sage.gene.coverage.tsv
                    ├── COLO829T.sage.vcf.gz
                    └── COLO829T.sage.vcf.gz.tbi
                ```

===+ "FASTQ.gz"

    This option is going to take longer since we are running the alignment step.

    !!! info "Run mode"
        === "WGS mode" 

            to run the pipeline the command is the following: 

            ```sh
            ./scripts/run_pipeline <sample_data> "tumorID,referenceID" <gen_version> <run_mode> <threads> <memory>
            ```  

            ### `sample data` directory = output directory

            The `sample_data` directory must have:

            - a directory named as the sample's tumorId
            - tumor and reference fastq files in the sample's directory, named as tumorId and referenceId.fastq.gz

            i.e. see folder tree below

            ```sh
            sample_data
             └── tumorID
                  ├── referenceId.fastq.gz
                  └── tumorId.fastq.gz
            ```

            The pipeline searches for the files that match the regex `tumorId.*.fastq.gz` and `referenceId.*.fastq.gz` in order to perform the alignment. Therefore, you could provide several fastq.gz files to align as in the example below: 

            ```sh
            sample_data
             └── tumorID
                  ├── referenceId_L001_R1_001.fastq.gz
                  ├── referenceId_L001_R2_001.fastq.gz
                  ├── tumorId_L001_R1_001.fastq.gz
                  └── tumorId_L001_R2_001.fastq.gz
            ```
            the pipeline will match all the fastq files that start with the `referenceId` or `tumorId` and end with `fastq.gz`, then it aligns them to the **reference genome**.

            ### `gen_version` parameter

            | Genome version | Genome file |
            |:--------------:|:-----------:|
            | V38 |`./ref_data_dir/V38/ref_genome/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna`
            | V37 |`./ref_data_dir/V37/ref_genome/Homo_sapiens.GRCh37.GATK.illumina.fasta`            

            ### `threads` and `memory` parameters   

            - `threads` number of threads used for each component
            - `memory`: GB allocated to each component (default=12GB)
 
            ## Example

            my directory:

            ```sh
            pipeline/test_data/
             └── ALL-280622
                  ├── ALL-280622-DIAGNOSTIC-DNA_1.fastq.gz
                  └── ALL-280622-DIAGNOSTIC-DNA_2.fastq.gz
            ```
            Run: 

            ```sh
            ./scripts/run_pipeline test_data "ALL-280622" V37 WGS 8 16
            ```  
            !!! note "WGS without reference"

                as this example, is it possible to use WGS without a non-tumoral reference. the output is the following: 

                ??? example output without reference

                    ```sh
                    TBC
                    ```

        === "Panel mode" 

## Reference

## Source

- Federica Brando
