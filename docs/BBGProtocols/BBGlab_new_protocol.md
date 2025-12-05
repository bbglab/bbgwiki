# New BBGlab project protocol

These guidelines will help you to create a new project in the lab.

## Create project folders in the cluster

Check the cluster structure organization [here](https://bbglab.github.io/bbgwiki/Cluster_basics/Structure/#description).
You can create the corresponding project folders within main directories:
-  Create **project folder** in `/data/bbg/projects/`.
This folder should contain all the files related to the analysis of your project
(jupyter notebooks, scripts, processed files, etc.)
-  Create **dataset folder** in `/data/bbg/datasets/` or `/data/bbg/datasafe/` or s3.
This folder should contain all the original data (or mildly processed data) of your project
(fastq files, bam files, vcf files, maf files, etc.).
Remember to add the dataset to the **BBG Datasets spreadsheet**, either if it is external
(downloaded from a repository, from a collaborator) or internal (in house sequenced).
Please find further information about the BBG Datasets [here](https://bbglab.github.io/bbgwiki/Datasets/Datasets_BBGLAB/).

To create these foldes, follow [these instrucions](https://bbglab.github.io/bbgwiki/Cluster_basics/NewFolders/).
 
## Properly organize your project folder

Remember to follow the [BBGlab best practices](https://bbglab.github.io/bbgwiki/BBGProtocols/BBglab_data_organization/).
when organizing your project directory. 
In addition, you should create a copy of the **Project Compilation spreadsheet** with your name, 
fill it up with the information of your project/s and keep updating it whenever needed.
Please find the Project Compilation files [here](https://drive.google.com/drive/u/0/folders/1vGfO8B-vU-QRRf4ho4B5_Tnfe4neS7Y9).

## Properly organize your google drive

You can also follow the [BBGlab best practices](https://bbglab.github.io/bbgwiki/BBGProtocols/BBglab_data_organization/) for that.

## Track changes in Git
You should have a Github account to track all your code in terms of version control and collaboration.
You can create a github account if you don't have one yet. Check the 
[Git guidelines](https://bbglab.github.io/bbgwiki/Tools/Programming/git/). 


## Reference

- Elisabet Figuerola
- Mònica Sánchez
