# BBGlab best practices

We present some best practices to make your life easier and more efficient and when day comes to be able to set up the **[BBGlab Exit protocol](https://drive.google.com/drive/folders/1veXAAucPqNQ2KIVFLyEJqPVjEeDcqsR-)**.

## Organizing the data

### Project Compilation

You MUST all the relevant information about your finished or ongoing project in:

1. [ProjectCompilation](https://docs.google.com/spreadsheets/d/1jJleTek9eP4S6CCe5fO8_M4-vLuKhumgKjlQ58jP_rc/edit?gid=0#gid=0) google spreadsheet. It should be one file per BBGlab member. It is the responsibility of all the people involved to keep it updated.
2. [BBGlab datasets](https://bbglab.github.io/bbgwiki/Datasets/Datasets_BBGLAB/) google spreadsheet.

> **It is esential to fill all these files so that all your project data is updated and stored. It is the responsibility of ALL the users involved in the project to keep it updated!**


Essential information both for finished and for on going projects:

 - Data
 - Scripts
 - Environments
 - Notebooks
 - Software (useful)
	- Local in your computer
		- Tools not installable in the cluster
		- Custom scripts
	 - Environments in the cluster
	- Tools installed in your user in the cluster (some /bin folder somewhere) linked to source code
- Figures
- Abstracts, Slides, Posters, Manuscripts

### Google Drive

You should have one directory per project shared (if necessary) with the people ivolved in the project. This directory MUST contain the following:

-   **Slides**
    
	It is good to include links to where plots were generated as much as possible. This directory would contain:

	-   FormalPresentations (not linked to conferences)
    
	-   WorkingMeetings / Project follow-up presentations
    
	-   NuriaSlides (link to Nextcloud or copy from there)
    
-   **Conferences**
   
	-   Abstracts
    
	-   Posters
    
	-   Slides
    
-   **Manuscripts**
    
	-   Mature versions of the figures including
    
		-   Images
    
		-   Link to code (i.e. GitHub repo)
    
	-   Text
		If different versions, make sure that the date is updated. Do not remove older versions, either make sure that the history is available or duplicate the file and store it in the OLD_versions folder.
	    

-   **Relevant papers**
    
	-   PDFs of those papers relevant for the project
    
	-   If there are any notes or summary from the paper, include it as well. (BUT NAME IT PROPERLY)
    
-   **Communications**
    -   Meeting notes (if relevant, usually it is)
    
	-   Content of relevant emails or slack conversations.
	- Relevant contacts

## Naming files / folders / …

Everywhere where you store files (Cluster, Drive, Cloud, Computer)

-   Use dates in YYYYMMDD format or YYMMDD.  
    Always year first…
    
-   Use informative words
    
-   No spaces replace them by "_"

-   For more official guidelines or recommendations check these links: [HarvardFileNamingConvention](https://datamanagement.hms.harvard.edu/plan-design/file-naming-conventions) and [HowToNameFiles](https://speakerdeck.com/jennybc/how-to-name-files).

## Avoid accumulating unnecessary data

**Store** only essential files in the cluster by ensuring you **erase** intermediate or temporary files that are no longer needed, and **archive** the essential files from completed projects to keep the cluster clean and manageable. Instructions on how to archive files in the BBGcluster here.

## Contact compilation

Fill [contact compilation sheet](https://docs.google.com/spreadsheets/d/1cibsyM8m7tMMu4XzCjQbkiBOWEOzO-R-VXTYjCW-iik/edit?gid=0#gid=0) with contact details including:
    
-   Older collaborations contacts
    
-   Regular contacts

## Track and Manage Your Code with GitHub

It's a good idea to create a GitHub repository for your project code and regularly update it to track changes, share it with others, review it... Find all documentation on how to work with GitHub repositories [here](https://docs.github.com/en/repositories/creating-and-managing-repositories/about-repositories).

## Be environmentally friendly!

Did you know it is estimated that the emission of a biology project (both wet and dry lab) has an estimated cost of 29 tCO2e/person? Or that a single analysis of RNA seq data of 10 million 100bp reads aligned to *P.falciparum* (13Gb, 1h 30) cost 240g CO2e? Also data storage has an environmental impact: a data center uses as much water as three average-sized hospitals. So our work also leaves a carbon footprint that we should be aware of and try to reduce it as much as possible. What can we do?

 - Reduce electricity
	 - Turn off the screens when you are not in the lab. Also the mouse and the keyboard
	 - Lock/Suspend the computer when it is not used
	 - Turn off the light of the lab when you are the last one leaving
 - Reduce the CO2 cost of your coding: you can estimate the CO2 footprint of your scripts or pipelines and make it efficientlier with many tools like:
	 -  [nf-co2footprint](https://github.com/nextflow-io/nf-co2footprint)
	 - [CodeCarbon](https://codecarbon.io/)
	 - [carbontracker](https://github.com/lfwa/carbontracker)
	 -  Check out more [here](https://github.com/GreenAlgorithms/GreenAlgorithms4HPC)

You can have a look to Loïc Lannealongue [talk](https://summit.nextflow.io/2024/barcelona/agenda/10-30--towards-environmentally-sustainable-computational-science/) to learn more about this.

## Reference
- Elisabet Figuerola
- Ferriol Calvet