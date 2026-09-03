# GENIE

## Description

A dataset of many panel sequencing samples (>170 000) from many institutions in many countries.  
[Dataset website](https://genie.synapse.org/Explore/GENIE).  
Data downloaded from [sypanspe.org](synapse.org).  
[Here](https://docs.google.com/presentation/d/18MMDAOfSa3rRfApb8obhicyIU2n60aGcM9QA_2lMbao/edit?slide=id.p#slide=id.p)
you can find a Google Slides document with some details about the GENIE dataset.  
GENIE contains panels from MSKCC IMPACT (>80%), DFCI, UCSC, VHIO, etc.
Many of them are without a normal-matched control.
Some panels are on hotspots instead of the whole gene.
Overall, the MSKCC IMPACT panel data is the most complete one,
with a normal-match control and covering ~500 cancer-related genes.

Downloaded data is in this path: ```/data/bbg/datasets/intogen/input/data/cancer/panels/GENIE/```  
The latest version downloaded is GENIE v.15 (syn53210170).  
Take into account that some IMPACT panel data could be duplicated in the cbioportal panel data download:
```/data/bbg/datasets/intogen/input/data/cancer/panels/cbioportal/```.
The IMPACT panels from cbioportal have more clinical data.

### Important note
>
> This dataset has synonymous mutations filtered. It cannot be used for intOGen.

## Reference

Mònica Sánchez Guixé  
Santi Demajo  
Abel González Perez
