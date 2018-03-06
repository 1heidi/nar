##STEP 6 - Online Transition 
##Purpose: Determine how many db started out offline but then went online, finally summary stats 
##Package(s): tidyverse
##Input file(s): nar_v20_3.csv
##Output file(s): nar_v20_6.csv, nar_v20_6_sum.csv

library(tidyverse)

nar_v20_3 <- read.csv("nar_v20_3.csv")

nar_v20_6a <- nar_v20_3 %>%
  group_by(db_id) %>%
  mutate(start = ifelse(test = (article_status == "debut" & available == "not_www"),
                                 yes = "offline_start",
                                  no = "online_start"))

nar_v20_6b <- nar_v20_6a %>%
  group_by(db_id) %>%
  mutate(transition = ifelse(test = (start == "offline_start" & (status == "yes" | status == "no")),
            yes = "transitioned",
            no = ifelse(test = (start == "offline_start" & status == "never_www"),
                          yes = "never_transitioned",
                          no = "online_only")))


nar_v20_6c <- select(nar_v20_6b, db_id, resource_name, status, debut_yr, total_articles, total_citations, start, transition)

nar_v20_6d <- distinct(nar_v20_6c, .keep_all = TRUE)

nar_v20_6e <- ungroup(nar_v20_6d)

write.csv(nar_v20_6e, "nar_v20_6.csv", row.names = FALSE)

nar_v20_6f <- summarise(nar_v20_6e, started_offline = sum(start=="offline_start"),transitoned_to_online = sum(transition =="transitioned"), currently_available = sum(transition == "transitioned" & status == "yes"))

write.csv(nar_v20_6f, "nar_v20_6_sum.csv", row.names = FALSE)
