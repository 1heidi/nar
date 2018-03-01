##STEP 4 - Citations and Citation Quartiles
##Purpose: plot citations, also calculate & bin citation quartiles, and create summary table - also determine number of MBDC collection IDs vs unique NAR IDs for this study
##Process for quartiles: remove newest articles, then loop through to determine the ordered rank within issue for each article, then the percent rank within issue for each article, then average percent rank across all articles for db with > 1 articles, and finally assign citation quartile
##Package(s): tidyverse, ggplot2, stringr
##Input file(s): nar_v20_3.csv
##Output file(s): nar_v20_3_plot_2.csv, nar_v20_4.csv, nar_v20_4_tab_1.csv, Figure_2_Citations.PDF

library(tidyverse)
nar_v20_3 <- read.csv("nar_v20_3.csv")

nar <- nar_v20_3
nar <- filter(nar, article_year < 2013)

nar_v20_4 <- nar %>%
  group_by(article_year) %>% 
      arrange(article_year, desc(citations)) %>% 
          mutate(issue_rank = rank(desc(citations), ties.method= "random")) %>%
              mutate(issue_percent_rank = 1-(issue_rank/length(article_year)))

## next, for db with >1 paper,  average the percent rank across all papers

nar_v20_4 <- nar_v20_4 %>%
    group_by(db_id) %>% 
         mutate(ave_issue_percent_rank = mean(issue_percent_rank))

nar_v20_4 <- mutate(nar_v20_4, quartile = ifelse(test = (ave_issue_percent_rank > 0.75), 
          yes = 1,
          no = ifelse(test = (ave_issue_percent_rank <= 0.75 & ave_issue_percent_rank > 0.5), 
                yes = 2,
                no = ifelse(test = (ave_issue_percent_rank <= 0.5 & ave_issue_percent_rank > 0.25),
                       yes = 3,
                      no = 4))))

write.csv(nar_v20_4, "nar_v20_4.csv", row.names = FALSE)

## Create Summary Table

nar_v20_4_uni <- distinct(nar_v20_4, db_id, .keep_all = TRUE)
nar_v20_4_notwww <- filter(nar_v20_4_uni, status != "never_www")

nar_v20_4_notwww_tibble <- nar_v20_4_notwww %>% 
  group_by(quartile) %>% 
  summarise(db_count = length(unique(db_id)), art_count = sum(total_articles), art_per_db = mean(total_articles), std = sd(total_articles), raw_cit_sum = sum(total_citations), curr_available_count = sum(status=="yes"))

write.csv(nar_v20_4_notwww_tibble, "nar_v20_4_tab_1.csv", row.names = FALSE)

## Plotting
## export for figure as PDF
## size as 6 x 8 and *do not adjust*
## Citations by Database (ALL Online databases - not just <2013)

nar_v20_3_uni <- distinct(nar_v20_3, db_id, .keep_all = TRUE)
nar_v20_3_notwww <- filter(nar_v20_3_uni, status != "never_www")

write.csv(nar_v20_3_notwww, "nar_v20_3_plot_2.csv", row.names = FALSE)

ggplot(nar_v20_3_notwww) +
  geom_smooth(aes(x = jitter(debut_yr), y = log10(total_citations), color = status)) + ## note method used is 'gam' - generalized additive model for better local means - it does model the dip due to citation lag for recent years better than a linear model (lm)
  geom_count(aes(x = debut_yr, y = log10(total_citations),  color = status), alpha = 0.7) +
  xlab("Year Debuted in NAR Database Issue") +
  ylab("Log10 Total Citations") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 5)) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 10)) +
  ggtitle("Total Citation Counts for Unique Databases") +
  scale_color_manual(values = c("#E39C37", "#404096"), 
                     labels = c("Currently Unavailable", "Currently Available")) +
  theme(plot.title = element_text(face='bold',size=16,hjust=0.5),
        axis.title.x = element_text(face='bold',size=12,hjust=0.5),
        axis.title.y = element_text(face='bold',size=12),
        axis.text.x = element_text(size=10,color='black'),
        axis.text.y = element_text(size=10,color='black'),
        legend.title = element_blank(),
        legend.position="bottom")

## Determine number of MBDC collection IDs vs unique NAR IDs for this study

library(stringr)
NARcount <- sum(str_count(nar_v20_3_uni$db_id, "NAR")) ## result:  322
MBDCcount <- sum(str_count(nar_v20_3_uni$db_id, "MBDC"))  ## result:  1405

## Determine number of single article DB vs multiple article DB
single <- sum(nar_v20_4_notwww$total_articles == 1)
mult <- sum(nar_v20_4_notwww$total_articles > 1)




