##STEP 5 - Issue Level Status 
##Purpose: Determine issue level stats, including the average precent availability of databases 1991-2001
##Package(s): tidyverse, ggplot2, ggpmisc
##Input file(s): nar_v20_3.csv
##Output file(s): nar_v20_5.csv, nar_v20_5_plot_4.csv, nar_v20_5_sum.csv, nar_v20_5_scratch.csv, Figure_3_DB_Growth.PDF, Figure_4_DB_Avail.PDF, Figure_S1_Cumulative_Citations.PDF

nar <- read.csv("nar_v20_3.csv")
nar <- tbl_df(nar)

nar_stat_issue_art_cit_cumulative <- nar %>%
  group_by(article_year) %>%
    mutate(issue_total_articles = sum(length(article_year))) %>%
      mutate(issue_total_citations = sum(citations, na.rm=TRUE))%>%
        mutate(issue_total_debuts = sum(article_status == "debut")) %>%
          mutate(issue_total_debuts_available = sum(article_status == "debut" & status == "yes")) %>%
              mutate(issue_total_debuts_unavailable = sum(article_status == "debut" & status == "no"))

## pare down to just issue level
nar_issue_art_cit_cumulative2 <- select(nar_stat_issue_art_cit_cumulative, article_year, issue_total_citations, issue_total_articles, issue_total_debuts, issue_total_debuts_available, issue_total_debuts_unavailable)
nar_issue_art_cit_cumulative_unique <- distinct(nar_issue_art_cit_cumulative2, article_year, .keep_all = TRUE)
nar_issue_art_cit_cumulative_unique <- arrange(nar_issue_art_cit_cumulative_unique, article_year)

## export/import hack - otherwise views fine but does not plot correctly
write.csv(nar_issue_art_cit_cumulative_unique, "nar_v20_5_scratch.csv", row.names = FALSE)
nar_issue_art_cit_cumulative_unique <- read.csv("nar_v20_5_scratch.csv")

## calculate cumulative values
nar_stat_issue_art_cit_cumulative_unique2 <- mutate(nar_issue_art_cit_cumulative_unique, cum_cit = cumsum(issue_total_citations),cum_art = cumsum(issue_total_articles), cum_debute = cumsum(issue_total_debuts), cum_debute_avail = cumsum(issue_total_debuts_available), cum_debute_unavail = cumsum(issue_total_debuts_unavailable))

write.csv(nar_stat_issue_art_cit_cumulative_unique2, "nar_v20_5.csv", row.names = FALSE)

nar_v20_5 <- nar_stat_issue_art_cit_cumulative_unique2

## Plotting
## export for figure as PDF
## size as 6 x 8 but then adjust to 5 by 8

## Figure Database Growth

library(ggplot2)
library(ggpmisc) ## for trendline

sub_2002_2016 <- slice(nar_v20_5, 11:25)  ## subset for trendline

formula <- y ~ x
ggplot(sub_2002_2016, aes(x = article_year, y = cum_debute)) +
  geom_point(nar_v20_5, mapping = aes(x = article_year, y = cum_debute), alpha = 0.7, size=4) +
  geom_smooth(method = "lm", formula = formula, se = F, color="black") +
  stat_poly_eq(aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")), 
               label.x.npc = "right", label.y.npc = 0.15,
               formula = formula, rr.digits = 4, parse = TRUE, size = 5, color="black") +
  labs(x = "Debut Year") +
  labs(y = "Cumulative Count") +
  ggtitle("Unique Databases Debuted between 1991-2016") + 
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10)) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
  theme(plot.title = element_text(face='bold',size=16,hjust=0.5),
        axis.title.x = element_text(face='bold',size=14,hjust=0.5),
        axis.title.y = element_text(face='bold',size=14,vjust=1),
        axis.text.x = element_text(size=12,color='black'),
        axis.text.y = element_text(size=12,color='black'))

## Figure Database Availability

percent <- nar_v20_5 %>%
  mutate(percent_avail = (issue_total_debuts_available/issue_total_debuts)*100)

write.csv(percent, "nar_v20_5_plot_4.csv", row.names = FALSE)

percent_sub_2002_2016 <- slice(percent, 11:25) ## subset for trendline

formula <- y ~ x
ggplot(percent_sub_2002_2016, aes(x = article_year, y = percent_avail)) +
  geom_point(percent, mapping = aes(x = article_year, y = percent_avail), alpha = 0.7, size=4) +
  geom_smooth(method = "lm", formula = formula, se = F, color="black") +
  stat_poly_eq(aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")), 
               label.x.npc = "right", label.y.npc = 0.15,
               formula = formula, rr.digits = 4, parse = TRUE, size = 5, color="black") +
  labs(x = "Debut Year") +
  labs(y = "Percent Available") +
  ggtitle("Current Availability of Unique Databases") + 
  scale_y_continuous(breaks = scales::pretty_breaks(n = 20)) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 10)) +
  ylim(0, 100) +
  theme(plot.title = element_text(face='bold',size=16,hjust=0.5),
        axis.title.x = element_text(face='bold',size=14,hjust=0.5),
        axis.title.y = element_text(face='bold',size=14,vjust=1),
        axis.text.x = element_text(size=12,color='black'),
        axis.text.y = element_text(size=12,color='black'))

## Cumulative Citaiton Counts (supplemental figure)

sub_2002_2012 <- slice(nar_v20_5, 11:21)  ## subset for trendline

formula <- y ~ x
ggplot(sub_2002_2012, aes(x = article_year, y = cum_cit)) +
  geom_point(nar_v20_5, mapping = aes(x = article_year, y = cum_cit), alpha = 0.7, size=4) +
  geom_smooth(method = "lm", formula = formula, se = F, color="black") +
  stat_poly_eq(aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")), 
               label.x.npc = "right", label.y.npc = 0.15,
               formula = formula, rr.digits = 4, parse = TRUE, size = 5, color="black") +
  labs(x = "Debut Year") +
  labs(y = "Count") +
  ggtitle("Cumulative Citations 1991-2016") + 
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10)) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
  theme(plot.title = element_text(face='bold',size=16,hjust=0.5),
        axis.title.x = element_text(face='bold',size=14,hjust=0.5),
        axis.title.y = element_text(face='bold',size=14,vjust=1),
        axis.text.x = element_text(size=12,color='black'),
        axis.text.y = element_text(size=12,color='black'))

## for average precent availability of databases 1991-2001
percent <- nar_v20_5 %>%
  mutate(percent_avail = (issue_total_debuts_available/issue_total_debuts)*100)
sub_1991_2001 <- slice(percent, 1:10)  ## subset to average
ave <- mean(sub_1991_2001$percent_avail) ## 39.49%

write.csv(ave, "nar_v20_5_sum.csv", row.names = FALSE)