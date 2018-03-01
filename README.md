### TABLE OF CONTENTS
---------------------

* DATASET TITLE
* AUTHORS AND AFFILIATIONS
* LANGUAGE
* SUMMARY/ABSTRACT
* KEYWORDS
* FILE ORGANIZATION
* DATASET DESCRIPTION 
* DATA DICTIONARIES
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

The GitHub repository is at https://github.com/1heidi/nar_repo

Please read the associated openly available research article for context, additional details, and results: 

Pre-Print
25 Years of Molecular Biology Databases: A Study of Proliferation, Impact, and Maintenance, 
Heidi J Imker
bioRxiv, XXXXXX; doi: https://doi.org/10.1101/XXXXX

### KEYWORDS

databases; research infrastructure; sustainability; data sharing; molecular biology; bioinformatics; bibliometrics

### FILE ORGANIZATION

* This dataset consists of 1 folder containing 34 files:
  * 1 Readme file (TXT)
  * 6 image files of figures (PDF)
  * 1 R markdown file (RMD)
  * 1 R project file (RPROJ)
  * 17 data files (CSV) 
  * 8 R script files (R)

* The initial input data file is nar_v20.csv. 

* Each script is named for its step in the analysis process, with an additional short descriptor (see also “DATA ANALYSIS” section below). As data was reshaped and analyzed, scripts created subsequent cvs files which are named accordingly, e.g. STEP_20_1_Database_Status_Loop.R created nar_v20_1.csv, STEP_20_2_Database_Desc_Stats.R created nar_v20_2.csv, etc. 

* CSV files appended with “plot” are the exact data used for plots in article figures. 

* CSV files appended with “tab” are the exact data used for article tables.

* CSV files appended with “sum” are the exact data used for additional stats reported within article text.

* CSV file appended with “scratch” is an intermediate file necessary for the code to execute.

* Files to create Figures and Tables
  * Figure 1: STEP_20_3_Article_Level_Stats.R & nar_v20_3_plot_1.csv
  * Figure 2: STEP_20_4_Citations.R & nar_v20_3_plot_2.csv
  * Figure 3: STEP_20_5_Issue_Level_Stats.R & nar_v20_5.csv (csv used unchanged)
  * Figure 4: STEP_20_5_Issue_Level_Stats.R & nar_v20_5_plot_4.csv
  * Figure 5: STEP_20_7_Maintenance.R & nar_v20_7_plot.csv
  * Figure S1: STEP_20_5_Issue_Level_Stats.R & nar_v20_5.csv (csv used unchanged)
  * Table 1: STEP_20_4_Citations.R & nar_v20_4_tab_1.csv
  * Table 2: STEP_20_7_Maintenance.R & nar_v20_7_tab_2.csv

### DATASET DESCRIPTION 

* Data sources: 

- Initial article metadata was obtained through Scopus via the University of Illinois at Urbana-Champaign’s library website. 
- Metadata was cleaned and augmented with URLs and additional metadata using PubMedCentral (https://www.ncbi.nlm.nih.gov/pmc/), the website for Nucleic Acids Research (NAR; https://academic.oup.com/nar), and the website for the Molecular Biology Database Collection (MBDC; http://www.oxfordjournals.org/nar/database/a/)

* Data collection dates:

- Initial article metadata was retrieved from Scopus December 6, 2016 
- MBDC metadata was retrieved from the website above on December 8, 2016
- Database URLs were retrieved from abstracts on PubMedCentral and the NAR 	website between Dec 19, 2016 – Feb 22, 2017

* Rules for standardizing distinct names (Y) into a single name (X):
- Y explicitly billed as an “update” to X -> X
- Y is just X plus version number 1, 2, 3, 4, 5, etc. (e.g. STITCH 5) -> X
- Y formally known as X (e.g. full malaria) -> X
- Y given as a generic title/name -> X (as determined by same or very similar url and/or same or very similar author set)

Additional notes: 
- Standardized sub-services into a single umbrella service if single url given in abstract.
- If there is an umbrella organization (e.g. EBI) then just EBI (space) [Resource] – no dashes. If the dash seems to be part of the actual name, then kept.
- Y remains Y if the purpose of the resource fundamentally different (e.g. Voronoia versus Voronoia4RNA)

### DATA DICTIONARIES


#### Variables for initial input CSV file, nar_v20.csv, and then used throughout:

**article_id** = A largely arbitrary number assigned to each NAR article on initial Scopus download of metadata. As articles were evaluated, some were deleted because of indexing errors or because they did not describe a specific database (e.g. editorials). Thus, these numbers are not strictly continuous.
          
**db_id** = Where possible (see associated article), this is the database’s MBDC id, otherwise it is a unique id applied of the purposes of this study following the format NAR9###. Thus, numbers are also not strictly continuous.
               
**resource_name** = A standardized name of the database represented in NAR articles.  The name may vary from that in the article if the name changed over time. See “naming” and “disambiguation” variables in the Notes column

**access** = Mechanism by which the database was made available. Variables are 1) “physical” if available via tape, print-put or other physical media, 2) “server” if available via FTP, Gopher, etc., 3) “Not Available” if the article described a database no longer available or the article was aspirational, 4) “Supplement” for the single occurrence in which the data was included only as supplement to the article or 5) the specific URL published in the NAR article for the database

**available** = Current availability at the time access was assessed between Dec 19, 2016 – Feb 22, 2017.  Variables are 1) “not_www” if the database was not available  via the world wide web, meaning no URL was reported in the paper, 2) “no” if the database’s reported URL did not resolve, and “yes” if the database’s reported URL did not resolve

**unavailable_message** = Message found if a URL did not resolve. Variables are 1) “blank page” if a plain, blank page returned, 2) “can't be reached” if the message timed out and returned that the site couldn’t be reached, 3) “discontinued notice” if the page indicated the resource was discontinued with no further information, 4) “forbidden” if the page returned that access was forbidden, 5) “malware warning” if a security warning returned, 6) “not found” if the page simply stated not found, 7) “related generic commercial site redirect” if the page resolved to a commercial website that initially hosted the database but the current page did not provide information about the database, 8) “related generic government site redirect” if the page resolved to a government website that initially hosted the database but the current  page did not provide information about the database, 9) “related generic publisher site redirect” the page resolved to a publishers website that initially hosted the database but the current page did not provide information about the database, 10) ”related generic research institution site redirect” the page resolved to the website of research institution that initially hosted the database but the current page did not provide information about the database, 11) “service unavailable” if the page returned that the service was not available, and 12) “unrelated site redirect” if the page returned (e.g. claiming of a lasped domain)

**available_update_date** = If URL did resolve, the database website was reviewed to locate an update date.  Variable is either 1) “not_applicable” for databases whose URL did not resolve, 2) “unknown” if the URL did resolve but no date was located, or 3) the specific date found if the URL did resolve and a date was located

**notes** = miscellaneous notes observed
                 
**article_year** = the year the associate NAR article was published   
     
**citations** = the citation count for associated NAR article as of download from Scopus on December 6, 2016 

#### Additional variables created for nar_v20_1.csv and then used throughout:

**status** = Using information available for each article, determined overall stats of the database. Variables are 1) “yes” if at least URL reported resolved, 2) “no” if none of the URLs reported resolved, 3) “never_www” if the database was never available via a URL

#### Additional variables created for nar_v20_2.csv and then used throughout:

**debut_yr** = Determined the first article published and assigned that articles year as the debut year

**total_articles** = A count of articles published for a given database

**total_citations** = A count of total citations for all articles published for a given database

#### Additional variables created for nar_v20_3.csv and then used throughout:

**article_status** = Variables are 1) “update” if the article is an update to an original debut NAR article published earlier or 2) “debut” if the article is the initial NAR article published 

#### Additional variables created for nar_v20_4.csv and then used throughout:

**issue_rank** = Ordered articles within issue by number of citations and assigned a ranking. Variables are 1-# of total articles within the specific issue. Ties were determined randomly

**issue_percent_rank** = Calculated the overall percent rank for each article within the issue.  Variables are a percentage which range from 0.0000 to 0.9949

**ave_issue_percent_rank** = For databases with multiple articles, the average issue percent rank across articles was averaged. Variables range from 0.0000 to 0.9943. For databases with a single article, issue_percent_rank == ave_issue_percent_rank

**quartile** = Each ave_issue_percent_rank was binned into quartiles.  Variables range from 1 to 4

#### Additional variables created for nar_v20_4_tab_1.csv and used solely for the Table 1

**db_count** = Count of total databases within in each citation quartile for 1991-2012

**art_count** = Count of total articles for the databases within in each citation quartile for 1991-2012

**art_per_db** = Average of total articles per databases within in each citation quartile for 1991-2012

**std** = Standard diversion of total articles per databases within in each citation quartile for 1991-2012

**raw_cit_sim** = Count of raw citations counts for all databases within in each citation quartile for 1991-2012

**curr_available_count** = Count of databases still available within in each citation quartile for 1991-2012

#### Additional variables created for nar_v20_5.csv and nar_v20_5_sum.csv; used solely for the purposes of obtaining issue-level metrics

**article_year** = This is equivalent to issue year

**issue_total_citations** = Count of all citations for the issue
      
**issue_total_articles** = Count of all articles for the issue
      
**issue_total_debuts** = Count of all debuts for the issue
           
**issue_total_debuts_available** = Count of all debuts still available for the issue

**issue_total_debuts_unavailable** = Count of all debuts no longer available for the issue

**cum_cit** = Count of running cumulative total of all citations
                       
**cum_art** = Count of running cumulative total of all articles 
                      
**cum_debute** = Count of running cumulative total of newly debuted databases
              
**cum_debute_avail** = Count of running cumulative total of newly debuted databases still available
            
**cum_debute_unavail** = Count of running cumulative total of newly debuted databases no longer available

**x** = average precent availability of databases 1991-2001

#### Additional variables created for nar_v20_6.csv and nar_v20_6_sum.csv; used solely for the purposes of reporting database transitioning (discussed within article text only)

**start** = According to the debut article, if the database started 1) “offline” or 2) “online”

**transition** =  1) “transitioned” if started offline and moved to online, 2) “never_transitioned” if started offline and did not transition, or 3) “online_only” if started online

**started_offline** = Count of number of databases that initially stated offline

**transitoned_to_online** = Count of number of databases that initially stated offline but transitioned to online

**currently_available** = Count of number of databases that initially stated offline, transitioned online and are still available at the time of testing

#### Additional variables created for nar_v20_7.csv, nar_v20_7_tab_2.csv, and nar_v20_7_plot.csv,; used solely for the purposes of reporting database maintenance

**db_last_update** = Most recent update found for a database

**maintdiff** =  Length of time (in years) between when the database deputed and the most recent update date

**maint_aft_debut** = Determination of if databases were updated after their debut. Variables are 1) “1” if update is at least one year greater than the debut date, 2) “0” if the database was last updated prior to publication of its NAR debut article, and 3) “NA” if no update was found

**db_sample** =  Count of databases included within in each citation quartile for 1991-2012          

**updates_found** =  Count of databases with an update found within in each citation quartile for 1991-2012       

**mean_update_date** = Average date of update for the databases found within in each citation quartile for 1991-2012  

**sum_maint_aft_debut** = Count of total databases that were updated after debut within in each citation quartile for 1991-2012  

**percent_maint_aft_debut** = Percent of databases that were updated after debut within in each citation quartile for 1991-2012  

**maint_bin** = Databases with updates found were binned into two-year periods: 1) “< 2010”, 2) “2010-2011”, 3) “2012-2013”, 4) “2014-2015”, and  5) “2016-2017”

**quartile_count** = Count of databases in a given maint_bin for a given quartile

**quartile_count_sum** = Sum of all databases in a given quartile

**quartile_percent** = Percent of databases in a given maint_bin for a given quartile


### DATA ANALYSIS

* Program used:
  * R version 3.3.3 (2017-03-06)
  * Platform: x86_64-apple-darwin13.4.0 (64-bit)
  * Running under: OS X El Capitan 10.11.6
  * Packages: see below

* There are 8 scripts that work sequentially:

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
   * Output file(s): nar_v20_3_plot_2.csv, nar_v20_4.csv, nar_v20_4_tab_1.csv, Figure_2_Citations.PDF

**STEP 5** Purpose: Determine issue level stats as well as the average precent availability of databases 1991-2001
   * Package(s): tidyverse, ggplot2, ggpmisc
   * Input file(s): nar_v20_3.csv
   * Output file(s): nar_v20_5.csv, nar_v20_5_scratch.csv, nar_v20_5_sum.csv, nar_v20_5_plot_4.csv, Figure_3_DB_Growth.PDF, Figure_4_DB_Avail.PDF, Figure_S1_Cumulative_Citations.PDF

**STEP 6** Purpose: Determine how many db started out offline but then went online, with summary stats 
   * Package(s): tidyverse
   * Input file(s): nar_v20_3.csv
   * Output file(s): nar_v20_6.csv, nar_v20_6_sum.csv		

**STEP 7** Purpose: Determine maintenance timeframe and date since last update as observed on websites and as mapped to citation quartiles
   * Package(s): tidyverse, ggplot2
   * Input file(s):  nar_v20_4.csv
   * Output file(s): nar_v20_7.csv, nar_v20_7_tab_2.csv, nar_v20_7_plot.csv, and Figure_5_Maintenance.PDF

**STEP 8** Purpose: Execute chisq.test and prop.trend.test to test for significance & reject null hypotheses. Ref for prop.trend.test: Introductory Statistics with R (2008) Dalgaard, Peter pgs. 149-151 and ref for chisq.test: Agresti, A. (2007) An Introduction to Categorical Data Analysis, 2nd ed., New York: John Wiley & Sons. Page 38.
   * Package(s): base R
   * Input file(s): see specifics for each test
   * Output file(s): none - copied and pasted results into manuscript text

### SHARING & ACCESSING INFORMATION

* **Formally:** CC0 to facilitate ease-of-use
* **Informally:** Please cite this dataset regardless. Provenance is important.

### ADDITIONAL NOTES/COMMENTS

There are bound to errors in this dataset. Please let me know if any are found. 




