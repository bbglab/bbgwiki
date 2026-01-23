# New BBGlab project protocol

These guidelines will help you to create a new project in the lab.

## Create project folders in the cluster

Check the [cluster structure organization](https://bbglab.github.io/bbgwiki/Cluster_basics/Structure/#description).
You can create the corresponding project folders within these main directories:

- Create **project folder** in `/data/bbg/projects/`.
This folder should contain all the files related to the analysis of your project
(jupyter notebooks, scripts, processed files, etc.)
- Create **dataset folder** in `/data/bbg/datasets/` or `/data/bbg/datasafe/` or s3.
This folder should contain all the original data (or mildly processed data) of your project
(fastq files, bam files, vcf files, maf files, etc.).

To create these folders in the cluster,
follow [these instructions](https://bbglab.github.io/bbgwiki/Cluster_basics/NewFolders/).

Remember to add the dataset to the **BBG Datasets spreadsheet**, either if it is external
(downloaded from a repository, from a collaborator) or internal (in house sequenced).
Find further information about the
[BBG Datasets](https://bbglab.github.io/bbgwiki/Datasets/Datasets_BBGLAB/).

## Properly organize your project folder

Remember to follow the
**[BBGlab best practices](https://bbglab.github.io/bbgwiki/BBGProtocols/BBglab_data_organization/)**
when organizing your project directory.

Additionally, you should fill the **Project Compilation spreadsheet**
that indicates all the paths in the cluster that you have been working in across all your projects.
For that:

1. Create a copy of the
**[Project Compilation template][project-compilation-template]**
2. Change the name of the document with your information as follow:
 `ProjectCompilation-202X-NameSurename`
3. Store it in your Google drive folder
(to be updated once the bbglab shared drive is available to store it accordingly)
4. Modify the document by removing the rows showing the examples,
and adding our own entries.

Remember to keep updating the file regularly so that information is available for everyone at any time.
Note that this file will be needed once you do the
**[BBGlab Exit Protocol](https://drive.google.com/file/d/1BnhLZCygroJ-dfamuZw8YvDgndIFmzzP/view?usp=drive_link)**.

## Properly organize your google drive

You can also follow the
[BBGlab best practices](https://bbglab.github.io/bbgwiki/BBGProtocols/BBglab_data_organization/) for that.

## Track changes in Git

You should have a Github account to track all your code in terms of version control and collaboration.
You can create a github account if you don't have one yet.
Check the [Git guidelines](https://bbglab.github.io/bbgwiki/Tools/Programming/git/).

## Reference

- Elisabet Figuerola
- Ferriol Calvet
- Mònica Sánchez

[project-compilation-template]: https://docs.google.com/spreadsheets/d/1jJleTek9eP4S6CCe5fO8_M4-vLuKhumgKjlQ58jP_rc/edit?gid=0#gid=0
