# Hartwig

## Description
The Hartwig Medical Foundation (HMF) is aiming to make whole genome sequencing WGS) the future standard of care in the Netherlands ( https://www.hartwigmedicalfoundation.nl/en/). The HMF maintains and develops a growing database with >5,000 metastatic cancer patients with rich clincial and genomic data (https://www.hartwigmedicalfoundation.nl/en/data/database/) - the largest such database in the entire world. The only way to truly to understand the HMF data is to look through the very detailed provided github repos. Most of the bioinformatics pipeline in HMF is made with their own in-house tools. 

## Data access
!!! warning "Permission"
To use data from Hartwig Medical Foundation Database you need special permission. Contact Martina or Paula if you need to use this data. 

Once you obtains permissions, you can find the data from Hartwig Medical Foundation Database on bbgcluster here:
```bash 
/workspace/datasets/hartwig
```

## Processed data 
In our lab several projects have used HMF data. From these projects the HMF data was pre-processed in away that could be re-used for other projects.  

For one such project (immunobiomarkers) a pipeline to extract and format HMF biomarkers was created (https://bitbucket.org/bbglab/hartwig_biomarkers/src/master/). This pipeline creates pre-processed data files of different data types. The HMF processed clinical data is output on our cluster here:
```bash 
/workspace/datasets/hartwig/20220809/biomarkers/tmp/clinical_ready.csv
```
The full output from the biomarkers pipline collects more than 60,000 curated columns of biomarkers into a table ready for analysis (located in folder below):
```bash
/workspace/datasets/hartwig/20220809/biomarkers/clean/biomarkers_AdjTPM.csv
```
	
## Exhaustive Study 
For the immunobiomarkers project an exhaustive study of biomarkers was run. The exhaustive analysis is found within this repo - https://bitbucket.org/bbglab/immune_biomarkers/src/main/ - and the code could be re-purposed in the future to study other classes of treatmetns (e.g. Chemo, Targeted, Hormonal therapies).
	
!!! note annotate "Website" 
	[https://www.hartwigmedicalfoundation.nl/en/data/database/](https://www.hartwigmedicalfoundation.nl/en/data/database/){:target="_blank"}

## Citing in Publications and Presentations
Researchers making use of data provided by Hartwig Medical Foundation must acknowledge this in every publication, by using at least the text below:

> This publication and the underlying research are partly facilitated by Hartwig Medical Foundation and the Center for Personalized Cancer Treatment (CPCT) which have generated, analysed and made available data for this research.

Read this [document](https://www.hartwigmedicalfoundation.nl/wp-content/uploads/2022/01/Publication-Policy-Annex-IV-License-Agreement-EN.pdf){:target="_blank"} to learn more about how to cite Hartwig Medical Foundation Database.


## Reference
- Paula Gomis
- Monica Sanchez
- Joseph Usset
