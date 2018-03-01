##STEP 7 - Maintenance
##Purpose: Determine maintenance timeframe and date since last update as observed on websites and as mapped to citation quartiles
##Package(s): tidyverse, ggplot2
##Input file(s):  nar_v20_4.csv
##Output file(s): nar_v20_7.csv, nar_v20_7_tab_2.csv, nar_v20_7_plot.csv, Figure_5_Maintenance.PDF

library(tidyverse)
nar_v20_4 <- read.csv("nar_v20_4.csv")
nar_v20_4_available <- filter(nar_v20_4, status == "yes")

## Note databases w/ diff URLS may have diff update dates (either unknown or acutally different if not maintaining both URLs in concert), so assign db_last_update as the most recent since at least one version is being updated

nar_v20_4_available$available_update_date <- as.numeric(as.character(nar_v20_4_available$available_update_date)) ## expect NA introduced by coercion

nar_v20_4_available_2 <- nar_v20_4_available %>%
  group_by(db_id) %>%
  mutate(db_last_update = (test = ifelse(all(is.na(available_update_date)),
                            yes = NA,
                            no = max(na.omit(available_update_date))))) %>%
      mutate(maint_aft_debut = (test = ifelse((db_last_update - debut_yr) > 1,
                                     yes = 1,
                                     no = 0))) %>%
          mutate(maintdiff = (db_last_update - debut_yr)) ## to check aft_debut_calc returns

nar_v20_4_available_3 <- select(nar_v20_4_available_2, db_id, resource_name, status, total_articles, total_citations, ave_issue_percent_rank, debut_yr, db_last_update, quartile, maintdiff, maint_aft_debut)

nar_v20_4_available_3 <-distinct(nar_v20_4_available_3)  ## this number should match the number of total databases still available in the citation quartile analysis (STEP 4)

nar_v20_7 <- nar_v20_4_available_3

## output
write.csv(nar_v20_7,"nar_v20_7.csv", row.names = FALSE)

## for summary TABLE 

nar_v20_7_sum <- nar_v20_7 %>% 
  group_by(quartile) %>% 
  summarise(db_sample = sum(length(db_id)), updates_found = sum(!is.na(db_last_update)), mean_update_date = mean(na.omit(db_last_update)), sum_maint_aft_debut = sum(na.omit(maint_aft_debut)), percent_maint_aft_debut = 100*(sum_maint_aft_debut/updates_found))

## output
write.csv(nar_v20_7_sum,"nar_v20_7_tab_2.csv", row.names = FALSE)  

### Plotting - PERCENT of databases in each citation quartlie binned by maintenance & plotted by facets
## export for figure as PDF
## size as 6 x 8 but then adjust to 5 by 8

nar_v20_7 <- read.csv("nar_v20_7.csv")

nar_v20_7_2 <- nar_v20_7 %>%
  group_by(db_id) %>%
  mutate(maint_life = db_last_update - debut_yr) %>%
  mutate(maint_bin = ifelse(test = (db_last_update > 2015),
                            yes = "2016-2017",
                            no = ifelse(test = (db_last_update > 2013 & db_last_update < 2016),
                                        yes = "2014-2015",
                                        no = ifelse(test = (db_last_update > 2011 & db_last_update < 2014),
                                                    yes = "2012-2013", 
                                                    no = ifelse(test = (db_last_update > 2009 & db_last_update < 2012),
                                                                yes = "2010-2011", 
                                                                no = "< 2010")))))

## For summary figure

nar_v20_7_3 <- na.omit(nar_v20_7_2) ## removing those w/o an update

nar_v20_7_count_barchart <- nar_v20_7_3 %>% 
  group_by(maint_bin, quartile) %>% 
  summarise(quartile_count = length(quartile))

nar_v20_7_percent_barchart <- nar_v20_7_count_barchart %>% 
  group_by(quartile) %>% 
  mutate(quartile_count_sum = sum(quartile_count), quartile_percent = 100*(quartile_count/quartile_count_sum))

nar_v20_7_plot <- ungroup(nar_v20_7_percent_barchart)

write.csv(nar_v20_7_plot,"nar_v20_7_plot.csv", row.names = FALSE) ## saved as raw data for plotting

### Plotting - maintenance by bins
## export for figure as PDF
## size as 6 x 8 but then adjust to 5 by 8

library(ggplot2)

ggplot() + 
  geom_bar(data = nar_v20_7_plot, aes(x = maint_bin, y = quartile_percent, fill = factor(maint_bin)), stat= "identity", position = "dodge") +
  facet_grid(~quartile, switch='x') +
  ggtitle("Updates Found for Currently Available Databases") +
  xlab("Citation Quartile") +
  ylab("Percent of Databases") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10), limits = c(0,100), expand = c(0, 1)) +
  scale_fill_manual(values=c("#AAAA44", "#E39C37", "#7DB874", "#529DB7", "#404096")) +
  guides(fill=guide_legend(title="Update Period")) +
  theme(plot.title = element_text(face='bold',size=16,hjust=0.5),
        axis.title.x = element_text(face='bold',size=16,hjust=0.5),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.y = element_text(face='bold',size=16,vjust=1),
        axis.text.y = element_text(face='bold',size=12,color='black'),
        legend.position = c(1, 1), 
        legend.justification = c(1, 1),
        legend.box.margin = margin(c(5,5,5,5)),
        legend.title = element_text(face='bold',size=10,color='black'),
        legend.text = element_text(face='bold',size=10),
        strip.background = element_blank(),
        strip.text = element_text(face='bold',size=12,color='black'),
        panel.spacing = unit(1, "lines"))
  