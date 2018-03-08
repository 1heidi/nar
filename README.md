### TABLE OF CONTENTS
---------------------

* DATASET TITLE
* AUTHORS AND AFFILIATIONS
* LANGUAGE
* SUMMARY/ABSTRACT
* KEYWORDS
* FILE ORGANIZATION
* DATASET DESCRIPTION 
* DATA DICTIONARY
* DATA ANALYSIS
* SHARING & ACCESSING INFORMATION
* ADDITIONAL NOTES/COMMENTS

### DATASET TITLE

Molecular Biology Databases Published in Nucleic Acids Research between 1991-2016

### AUTHORS AND AFFILIATIONS

* Name: Heidi Imker
* Organization/institution: University of Illinois at Urbana-Champaign
* ORCID: 0000-0003-4748-7453
* Email: imker@illinois.edu

### LANGUAGE

* English

### SUMMARY/ABSTRACT

This dataset was developed to create a census of sufficiently documented molecular biology databases to answer several preliminary research questions. Articles published in the annual Nucleic Acids Research (NAR) “Database Issues” were used to identify a population of databases for study. Namely, the questions addressed herein include: 1) what is the historical rate of database proliferation versus rate of database attrition, 2) to what extent do citations indicate persistence?, and 3) are databases under active maintenance and does evidence of maintenance likewise correlate to citation? An overarching goal of this study is to provide the ability to identify subsets of databases for further analysis, both as presented within this study and through subsequent use of this openly released dataset. 

* Please read the associated openly available research article for context, additional details, and results: 

  * Imker, Heidi (2018): 25 Years of Molecular Biology Databases: A Study of Proliferation, Impact, and Maintenance. bioRxiv, XXXXXX; doi: https://doi.org/10.1101/XXXXX

* The archived dataset that accompanies the preprint is also available at:

  * Imker, Heidi (2018): Molecular Biology Databases Published in Nucleic Acids Research between 1991-2016. University of Illinois at Urbana-Champaign. https://doi.org/10.13012/B2IDB-#######

### KEYWORDS

databases; research infrastructure; sustainability; data sharing; molecular biology; bioinformatics; bibliometrics

### FILE ORGANIZATION

* This dataset consists of 35 files:
  * 1 Readme file (MD)
  * 1 Readme file for dataset archived in the Illinios Data Bank (TXT)
  * 6 image files of figures (TIFF)
  * 1 R project file (RPROJ)
  * 18 data files (CSV) 
  * 8 R script files (R)

* The initial input data file is nar_v20.csv. 

* Each script is named for its step in the analysis process, with an additional short descriptor (see also “DATA ANALYSIS” section below). As data was reshaped and analyzed, scripts created subsequent CSV files which are named accordingly, e.g. STEP_20_1_Database_Status_Loop.R created nar_v20_1.csv, STEP_20_2_Database_Desc_Stats.R created nar_v20_2.csv, etc. 

* CSV files appended with “plot” are the exact data used for plots in article figures. 

* CSV files appended with “tab” are the exact data used for article tables.

* CSV files appended with “sum” are the exact data used for additional stats reported within article text.

* CSV file appended with “scratch” occurs only once and is an intermediate file necessary for the code to execute in step 5 specifically

* Files necessary to create Figures
  * Figure 1 Article Growth: STEP_20_3_Article_Level_Stats.R & nar_v20_3_plot_1.csv
  * Figure 2 Database Growth: STEP_20_5_Issue_Level_Stats.R & nar_v20_5.csv (csv used unchanged)
  * Figure 3 Citations: STEP_20_4_Citations.R & nar_v20_3_plot_2.csv
  * Figure 4 Attrition: STEP_20_5_Issue_Level_Stats.R & nar_v20_5_plot_4.csv
  * Figure 5 Maintenance: STEP_20_7_Maintenance.R & nar_v20_7_plot.csv
  * Figure S1 Cumulative Citations: STEP_20_5_Issue_Level_Stats.R & nar_v20_5.csv (csv used unchanged)

* Files necessary to create Tables (in article only)
  * Table 1: STEP_20_4_Citations.R & nar_v20_4_tab_1.csv
  * Table 2: STEP_20_7_Maintenance.R & nar_v20_7_tab_2.csv

* A CSV file is also included that maps ids used for this study with a global identifier for the articles. The global identifiers mapped are nearly all DOIs, but a DOI could not be located for 17 of the articles from 1994, so PMCIDs are provided instead. This file is not necessary for these analyses but may be helpful for further reuse.  

### DATASET DESCRIPTION 

#### Data sources: 

* Initial article metadata was obtained through Scopus via the University of Illinois at Urbana-Champaign’s library website. 
* Metadata was cleaned and augmented with URLs and additional metadata using PubMedCentral (https://www.ncbi.nlm.nih.gov/pmc/), the website for Nucleic Acids Research (NAR; https://academic.oup.com/nar), and the website for the Molecular Biology Database Collection (MBDC; http://www.oxfordjournals.org/nar/database/a/)

#### Data collection dates:

* Initial article metadata was retrieved from Scopus December 6, 2016 
* MBDC metadata was retrieved from the website above on December 8, 2016
* Database URLs were retrieved from abstracts on PubMedCentral and the NAR 	website between Dec 19, 2016 – Feb 22, 2017

#### Rules for standardizing distinct names (Y) into a single name (X):
* Y explicitly billed as an “update” to X -> X
* Y is just X plus version number 1, 2, 3, 4, 5, etc. (e.g. STITCH 5) -> X
* Y formally known as X (e.g. full malaria) -> X
* Y given as a generic title/name -> X (as determined by same or very similar url and/or same or very similar author set)
* Additional notes: 
  * Standardized sub-services into a single umbrella service if single url given in abstract 
  * If there is an umbrella organization (e.g. EBI) then just EBI (space) [Resource] – no dashes. If the dash seems to be part of the actual name, then kept.
  * Y remains Y if the purpose of the resource fundamentally different (e.g. Voronoia versus Voronoia4RNA)

### DATA DICTIONARY

#### Variables for initial input CSV file, nar_v20.csv, and then used throughout:

* **article_id** = A largely arbitrary number assigned to each NAR article on initial Scopus download of metadata. As articles were evaluated, some were deleted because of indexing errors or because they did not describe a specific database (e.g. editorials). Therefore these numbers are not strictly continuous, although the lower the number the older the article, in general.
          
* **db_id** = Where possible (see associated article), this is the database’s MBDC id, following the format MBDC0###, otherwise it is a unique id applied of the purposes of this study following the format NAR9###. Therefore numbers are also not strictly continuous.
               
* **resource_name** = A standardized name of the database represented in NAR articles. When an abbreviation, the name follows the following syntax "RN: Resource Name" to capture both the abbreviation and the spelled out name. The name may vary from that in the article if the name changed over time. See “naming” and “disambiguation” variables in the Notes column

* **access** = Mechanism by which the database was made available. Variables are 1) “physical” if available via tape, print-put or other physical media, 2) “server” if available via FTP, Gopher, etc., 3) “Not Available” if the article did not describe a database in existence as the time of the article, e.g. announcing a database no longer available or announcing an aspirational intent to develop a database, 4) “Supplement” for the single occurrence in which the data was included only as supplement to the article or 5) the specific URL published in the NAR article for the database

* **available** = Current availability at the time access was assessed between Dec 19, 2016 – Feb 22, 2017.  Variables are 1) “not_www” if the database was not available via the world wide web, meaning no URL was reported in the paper, 2) “no” if the database’s reported URL did not resolve, and 3) “yes” if the database’s reported URL did resolve

* **unavailable_message** = Message found if a URL did not resolve. Variables are 1) “blank page” if a plain, blank page returned, 2) “can't be reached” if the message timed out and returned that the site couldn’t be reached, 3) “discontinued notice” if the page indicated the resource was discontinued with no further information, 4) “forbidden” if the page returned that access was forbidden, 5) “malware warning” if a security warning returned, 6) “not found” if the page simply stated not found, 7) “related generic commercial site redirect” if the page resolved to a commercial website that initially hosted the database but the current page did not provide information about the database, 8) “related generic government site redirect” if the page resolved to a government website that initially hosted the database but the current  page did not provide information about the database, 9) “related generic publisher site redirect” the page resolved to a publishers website that initially hosted the database but the current page did not provide information about the database, 10) ”related generic research institution site redirect” the page resolved to the website of research institution that initially hosted the database but the current page did not provide information about the database, 11) “service unavailable” if the page returned that the service was not available, 12) “unrelated site redirect” if the page returned was completely unrelated (e.g. claiming of a lapsed domain), and 13) "not applicable" for URLs that did resolve appropriately (no message applies)

* **available_update_date** = If URL did resolve, the database website was reviewed to locate an update year. Variable is either 1) “not_applicable” for databases whose URL did not resolve, 2) “unknown” if the URL did resolve but no year was located, or 3) the specific year found if the URL did resolve and a year was located

* **notes** = Miscellaneous notes observed
                 
* **article_year** = Year the associate NAR article was published   
     
* **citations** = Citation count for associated NAR article as of download from Scopus on December 6, 2016 

#### Additional variables created for nar_v20_1.csv and then used throughout:

* **status** = Using information available for each article, determined overall status of each database. Variables are 1) “yes” if at least one URL reported resolved, 2) “no” if none of the URLs reported resolved, and 3) “never_www” if the database was never available via a URL

#### Additional variables created for nar_v20_2.csv and then used throughout:

* **debut_yr** = Determined the first NAR Database Issue article published and assigned that article's year as the debut year for the database

* **total_articles** = A count of number of articles published for a given database

* **total_citations** = A count of total citations for all articles published for a given database

#### Additional variables created for nar_v20_3.csv and then used throughout:

* **article_status** = Variables are 1) “update” if the article is an update to an original debut NAR Database Issue article published earlier or 2) “debut” if the article is the initial NAR Database Issue article

#### Additional variables created for nar_v20_4.csv and then used throughout:

* **issue_rank** = Ordered articles within issue by number of citations and assigned a ranking. Variables are 1-#, where # is the total number of articles within a specific issue. Ties were determined randomly

* **issue_percent_rank** = Calculated overall percent rank for each article within the issue. Variables are a percentage ranging from 0.0000 to 0.9949

* **ave_issue_percent_rank** = For databases with multiple articles, the average issue percent rank across all of its articles was averaged. Variables range from 0.0000 to 0.9943. For databases with a single article, issue_percent_rank == ave_issue_percent_rank

* **quartile** = Each ave_issue_percent_rank was binned into quartiles. Variables range from 1 to 4

#### Additional variables created for nar_v20_4_tab_1.csv and used solely for the Table 1

* **db_count** = Count of total databases within each citation quartile (for 1991-2012 only)

* **art_count** = Count of total articles for databases within each citation quartile (for 1991-2012 only)

* **art_per_db** = Average of total articles per databases within each citation quartile (for 1991-2012 only)

* **std** = Standard diversion of total articles per databases within each citation quartile (for 1991-2012 only)

* **raw_cit_sim** = Count of raw citations for all databases within each citation quartile (for 1991-2012 only)

* **curr_available_count** = Count of databases still available within each citation quartile (for 1991-2012 only)

#### Additional variables created for nar_v20_5.csv and nar_v20_5_sum.csv; used solely for the purposes of obtaining issue-level metrics

* **article_year** = Equivalent to issue year

* **issue_total_citations** = Count of all citations for the issue
      
* **issue_total_articles** = Count of all articles for the issue
      
* **issue_total_debuts** = Count of all debuts for the issue
           
* **issue_total_debuts_available** = Count of all debuts still available for the issue

* **issue_total_debuts_unavailable** = Count of all debuts no longer available for the issue

* **cum_cit** = Count of running cumulative total of all citations
                       
* **cum_art** = Count of running cumulative total of all articles 
                      
* **cum_debute** = Count of running cumulative total of debuted databases within issue
              
* **cum_debute_avail** = Count of running cumulative total of debuted databases within issue still available
            
* **cum_debute_unavail** = Count of running cumulative total of debuted databases within issue no longer available

* **x** = Average percent availability of databases debuted between 1991-2001

#### Additional variables created for nar_v20_6.csv and nar_v20_6_sum.csv; used solely for the purposes of reporting database transitioning (discussed within article text only)

* **start** = According to the debut article, the initial access mechanism available when the database debuted. Variables are 1) “offline” or 2) “online”

* **transition** =  Variables are 1) “transitioned” if started offline and moved to online, 2) “never_transitioned” if started offline and did not transition to online, or 3) “online_only” if started online

* **started_offline** = Count of the number of databases that initially started offline

* **transitoned_to_online** = Count of the number of databases that initially started offline but transitioned to online

* **currently_available** = Count of the number of databases that initially started offline, transitioned online, and were still available at the time of testing for this study

#### Additional variables created for nar_v20_7.csv, nar_v20_7_tab_2.csv, and nar_v20_7_plot.csv,; used solely for the purposes of reporting database maintenance

* **db_last_update** = The most recent update, reported in years, found for a database

* **maintdiff** =  Length of time, reported in years, between when the database deputed and the most recent update year

* **maint_aft_debut** = Determined if databases were updated after their initial debut in an NAR Database Issue. Variables are 1) “1” if update year found is at least one year greater than the debut year, 2) “0” if the database was last updated prior to the publication year of its associated NAR debut article, and 3) “NA” if no update year was found

* **db_sample** =  Count of databases included within each citation quartile for analysis of maintenance (for databases debuted between 1991-2012 only)         

* **updates_found** =  Count of databases with an update found within each citation quartile for analysis of maintenance (for databases debuted between 1991-2012 only)         

* **mean_update_date** = Average year of update for the databases found within each citation quartile for analysis of maintenance (for databases debuted between 1991-2012 only)         

* **sum_maint_aft_debut** = Count of total databases that were updated after debut within each citation quartile for analysis of maintenance (for databases debuted between 1991-2012 only)         

* **percent_maint_aft_debut** = Percent of databases that were updated after debut within each citation quartile for analysis of maintenance (for databases debuted between 1991-2012 only)         

* **maint_bin** = Databases with updates found were binned into two-year periods. Variables are 1) “< 2010”, 2) “2010-2011”, 3) “2012-2013”, 4) “2014-2015”, and 5) “2016-2017”

* **quartile_count** = Count of databases in a given maint_bin for a given citation quartile for analysis of maintenance (for databases debuted between 1991-2012 only)         

* **quartile_count_sum** = Sum of all databases in a given citation quartile for analysis of maintenance (for databases debuted between 1991-2012 only)         

* **quartile_percent** = Percent of databases in a given maint_bin for a given citation quartile for analysis of maintenance (for databases debuted between 1991-2012 only) 

#### Additional variables created for nar_id_mapping.csv; this file is not necessary for these analyses but may be helpful for future reuse

* **article_global_id** = The DOI associated with each NAR Database Issue article; a DOI could not be found for 17 articles in 1994 and PMCIDs are provided instead

### DATA ANALYSIS

#### Program used:
* R version 3.3.3 (2017-03-06)
* RStudio 1.0.136 
* Platform: x86_64-apple-darwin13.4.0 (64-bit)
* Running under: OS X El Capitan 10.11.6
* Attached base packages:
  * stats
  * graphics
  * grDevices
  * utils
  * datasets 
  * methods
  * base     
* Other attached packages:
  * dplyr_0.7.4
  * purrr_0.2.2.2   
  * readr_1.1.1    
  * tidyr_0.6.3
  * tibble_1.3.4    
  * ggplot2_2.2.1  
  * tidyverse_1.1.1
  * ggpmisc_0.2.16
  * stringr_1.2.0 

#### There are 8 scripts that work sequentially:

**STEP 1** Purpose: Loop through to determine availability status of each individual database
   * Package(s): tidyverse
   * Input file(s):  nar_v20.csv
   * Output file(s): nar_v20_1.csv

**STEP 2** Purpose: Determine descriptive stats for individual databases
   * Package(s): tidyverse
   * Input file(s): nar_v20_1.csv
   * Output file(s): nar_v20_2.csv

**STEP 3** Purpose: Categorize each article as a "debut" article or an "update" article 
   * Package(s): tidyverse, ggplot2
   * Input file(s): nar_v20_2.csv
   * Output file(s): nar_v20_3.csv, nar_v20_3_plot_1.csv, Figure_1_Article_Growth.PDF

**STEP 4** Purpose: Plot citations, calculate & bin citation quartiles, and create summary table - also determine number of MBDC collection IDs vs unique NAR IDs for this study
   * Package(s): tidyverse, ggplot2, stringr
   * Input file(s): nar_v20_3.csv
   * Output file(s): nar_v20_3_plot_2.csv, nar_v20_4.csv, nar_v20_4_tab_1.csv, Figure_3_Citations.PDF

**STEP 5** Purpose: Determine issue level stats, including the average precent availability of databases 1991-2001 and maximum points of curvatures
   * Package(s): tidyverse, ggplot2, ggpmisc
   * Input file(s): nar_v20_3.csv
   * Output file(s): nar_v20_5.csv, nar_v20_5_scratch.csv, nar_v20_5_sum.csv, nar_v20_5_plot_4.csv, Figure_2_DB_Growth.PDF, Figure_4_DB_Avail.PDF, Figure_S1_Cumulative_Citations.PDF

**STEP 6** Purpose: Determine how many databases started out offline but then went online, with summary stats 
   * Package(s): tidyverse
   * Input file(s): nar_v20_3.csv
   * Output file(s): nar_v20_6.csv, nar_v20_6_sum.csv		

**STEP 7** Purpose: Determine maintenance timeframe and year since last update as observed on websites and as mapped to citation quartiles
   * Package(s): tidyverse, ggplot2
   * Input file(s):  nar_v20_3.csv, nar_v20_4.csv
   * Output file(s): nar_v20_7.csv, nar_v20_7_tab_2.csv, nar_v20_7_plot.csv, and Figure_5_Maintenance.PDF

**STEP 8** Purpose: Execute chisq.test and prop.trend.test to test for significance & reject null hypotheses. Ref for prop.trend.test: Introductory Statistics with R (2008) Dalgaard, Peter pgs. 149-151 and ref for chisq.test: Agresti, A. (2007) An Introduction to Categorical Data Analysis, 2nd ed., New York: John Wiley & Sons. Page 38.
   * Package(s): base R
   * Input file(s): see specifics for each test
   * Output file(s): none - copied and pasted results into manuscript text

### SHARING & ACCESSING INFORMATION

* **Formally:** CC0 to facilitate ease-of-use
* **Informally:** Please cite this dataset regardless. It matters to me, and provenance is important. The citation is:

   * Imker, Heidi (2018): Molecular Biology Databases Published in Nucleic Acids Research between 1991-2016. University of Illinois at Urbana-Champaign. https://doi.org/10.13012/B2IDB-4311325_V1

### ADDITIONAL NOTES/COMMENTS

There are bound to errors in this dataset. Please let me know if any are found. 




