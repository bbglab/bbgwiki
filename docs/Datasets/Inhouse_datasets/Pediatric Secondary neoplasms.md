# Pediatric Secondary neoplasms

## Description

This dataset is a collection of WGS of normal-matched tumors from 12 patients with secondary tumors. There are 2 tumor samples per case, except for one case with XPC germline mutation, with 3 tumoral samples (1 for the first tumor -melanoma- and 2 for the second tumor -undifferentiated pleomorfic sarcoma-).

This is a collaboration with Jaume Mora and Cinzia Lavarino from Sant Joan de Déu Hospital.

Original FASTQ files can be found at:
```text
s3://bbg/datasets/tumor/sjd_seq/[date_of_download]/

```
`platinum` results (Hartwig pipeline in google cloud), can be found at:

```text
s3://bbg/datasets/tumor/sjd_seq/platinum_results/20210201/
s3://bbg/datasets/tumor/sjd_seq/platinum_results/20220528/
/data/bbg/datasafe/sjd_seq/platinum_results/20220809/
/data/bbg/datasets/sjd_melos/sjd_patient/vcf/run_tfm/20240223_oncoanalyser_results/

```
The first third also include the bam files.


The `20220809` run is the one used in the second tumors paper (DOI:10.1158/2159-8290.CD-23-1186).
`sarek`results can be found at:
```text
/data/bbg/datasets/tumor/sjd_seq/platinum_results/20220809/[sample_id]/sarek_results/
/data/bbg/datasets/sjd_melos/sjd_patient/vcf/run_tfm/20240219_sarek_results/

```
The `20240223_` and `20240219_` runs are from the patient with XPC germline mutation and bam files can be found together with FASTQ. 

## Reference
Mònica Sánchez Guixé  
Bet Figuerola Bou
