# BBGlab best practices

We all want the BBGlab to be a well-organized space where files or data — yours or a colleague's — are quick and easy to find. To help, we present some best practices on how to organize data in projects in the **Cluster** and **Google Drive** to make your life easier to save time and boost efficiency. With these practices, you will also be able to set up **[BBGlab Exit protocol](https://drive.google.com/file/d/1Z-jg7cLP7lAPZL0PC88pnozc_7gVF_2S/view?usp=drive_link)** handing things over when the time comes, making transitions easy and efficient for everyone. 

In addition, we've included practices focused on sustainability to help reduce our carbon footprint and promote an environmentally friendly workplace.

## Organizing the data

### Project Compilation

Essential information for both finished and ongoing projects:

 - Data:
   remember it is **essential** that all your project data is updated and stored in [BBGlab datasets](https://docs.google.com/spreadsheets/d/10eVPI8X9dObmSdypmcID0DTxO1XW8h3AGHbm_IT0El8/edit?usp=sharing). Check how to do it in the BBGWiki **Datasets/Datasets_BBGLAB**. It is responsibility of all the users involved in the project to keep it updated!
 - Scripts
 - Environments
 - Notebooks
 - Software (useful)
	- Local in your computer
		- Tools not installable in the cluster
		- Custom scripts
	 - Environments in the cluster
	- Tools installed in your user in the cluster (some /bin folder somewhere) linked to source code
 
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

## Contact compilation

Fill contact compilation sheet with contact details including:
    
-   Older collaborations contacts
    
-   Regular contacts

## Be environmentally friendly!

Did you know it is estimated that the emission of a biology project (both wet and dry lab) has an estimated cost of 29 tCO2e/person? Or that a single analysis of RNA seq data of 10 million 100bp reads aligned to *P.falciparum* (13Gb, 1h 30) cost 240g CO2e? Also data storage has an environmental impact: a data center uses as much water as three average-sized hospitals. So our work also leaves a carbon footprint that we should be aware of and try to reduce it as much as possible. What can we do?

 - Reduce electricity
	 - Turn off the screens when you are not in the lab. Also the mouse and the keyboard
	 - Lock the computer when it is necessary
	 - Turn off the light of the lab when you are the last one leaving
 - Reduce the CO2 cost of your coding: you can estimate the CO2 footprint of your scripts or pipelines and make it efficientlier with many tools like:
	 -  [nf-co2footprint](https://github.com/nextflow-io/nf-co2footprint)
	 - [CodeCarbon](https://codecarbon.io/)
	 - [carbontracker](https://github.com/lfwa/carbontracker)
	 -  Check out more [here](https://github.com/GreenAlgorithms/GreenAlgorithms4HPC)

If you want to learn more about this take a look to Loïc Lannealongue session [Towards environmentally sustainable computational science with Green Algorithms](https://summit.nextflow.io/2024/barcelona/agenda/10-30--towards-environmentally-sustainable-computational-science/) presented nextflow submit Barcelona2 024.

## Reference
- Elisabet Figuerola
- Ferriol Calvet
