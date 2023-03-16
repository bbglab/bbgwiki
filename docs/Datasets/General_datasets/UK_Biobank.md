# UK Biobank

## Description
UK Biobank (UKB) is a large-scale biomedical database and research resource, containing in-depth genetic and health information from half a million UK participants. 
It is a very large and detailed prospective study with over 500,000 participants aged 40–69 years when recruited in 2006–2010.

The study has collected and continues to collect extensive phenotypic and genotypic detail about its participants, including data from questionnaires, physical measures, sample assays, accelerometry, multimodal imaging, genome-wide genotyping and longitudinal follow-up for a wide range of health-related outcomes.
It is accessible to approved researchers undertaking vital research into the most common and life-threatening diseases. <br/>

!!! note annotate "Website" 
	[https://www.ukbiobank.ac.uk/](https://www.ukbiobank.ac.uk/){:target="_blank"}

### Genomic data

UKB includes **Whole Exome Sequencing** data obtained from blood samples from nearly the whole cohort (about 470,000 individuals). Moreover, it also has **Whole Genome Sequencing** data obtained also from blood from about 200,000 individuals, and, by the end of 2023, it is expected to be extended to the whole cohort (500,000 individuals). More info [here](https://www.ukbiobank.ac.uk/enable-your-research/about-our-data/genetic-data).

## Data access
Access to UKB data is restricted to authorized users that have to submit a research proposal to UKB. As BBGLab we can use the data on the study of the genetic basis of clonal hematopoiesis. Only some people in the lab have access to the data, you can ask Martina or Paula for more information.

Originally, the data was downloadable, so we have in our cluster a lot of clinical data from the entire cohort and also the WES from 200,000 individuals in the folder:
```bash 
/workspace/datasets/ukbiobank_ch/
```

More recently, the UK Biobank Research Analysis Platform ([UKB RAP](https://www.ukbiobank.ac.uk/enable-your-research/research-analysis-platform)) was created, so the data can not be downloaded anymore. The UKB RAP is a platform in the cloud based on DNA Nexus. The WES data from the full cohort and the WGS data are only accessible through this platform.

## Citing in Publications and Presentations
All publications should include the acknowledgement, “This research has been conducted using
data from UK Biobank, a major biomedical database” and where appropriate, include a link to the
UK Biobank website: www.ukbiobank.ac.uk

More information [here](https://www.ukbiobank.ac.uk/media/c4yefr4t/210527-uk-biobank-communications-guidelines.pdf).

## Reference
- Santi Demajo
- Joan Enric Ramis
- Miguel Grau
- Paula Gomis
