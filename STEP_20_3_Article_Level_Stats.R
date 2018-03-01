##STEP 3 - Article Categorization
##Purpose: Categorize each article as a "debut" article or an "update" article
##Package(s): tidyverse, ggplot2
##Input file(s): nar_v20_2.csv
##Output file(s): nar_v20_3.csv, nar_v20_3_plot_1.csv, Figure_1_Article_Growth_2018-03-01.PDF

library(tidyverse)

nar_v20_2 <- read.csv("nar_v20_2.csv")
nar_v20_2 <- tbl_df(nar_v20_2)

nar_v20_3 <- nar_v20_2 %>%
group_by(db_id) %>%
mutate(article_status = ifelse(test = (debut_yr == article_year),
                                      yes = "debut",
                                      no = "update"))

write.csv(nar_v20_3, "nar_v20_3.csv", row.names=FALSE)

## Plotting
## for hex colors https://www.w3schools.com/colors/colors_picker.asp
## export for figure as PDF
## size as 6 x 8 but then adjust to 5 by 8

nar_by_article <- group_by(nar_v20_3, article_status)
write.csv(nar_by_article, "nar_v20_3_plot_1.csv", row.names=FALSE)

## Plotting
## export for figure as PDF
## size as 6 x 8 and *do not adjust*

library(ggplot2)

ggplot() +
  geom_bar(data = nar_by_article, mapping = aes(x = article_year, fill = article_status)) +
  labs(x = "Issue Year") +
  labs(y = "Article Count per Issue") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 5)) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 20)) +
  guides(fill=guide_legend(title=NULL)) +
  ggtitle("Growth of Articles in NAR Database Issues 1991-2016") +
  theme(plot.title = element_text(face='bold',size=16,hjust=0.5)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position="bottom") +
  scale_fill_manual(values = c("#888888", "#A9A9A9"), labels = c("Debut Articles", "Update Articles")) +
  theme(axis.title.x = element_text(face='bold',size=12,hjust=0.5),
          axis.title.y = element_text(face='bold',size=12,vjust=1),
          axis.text.x = element_text(size=10,color='black'),
          axis.text.y = element_text(size=10,color='black'))
