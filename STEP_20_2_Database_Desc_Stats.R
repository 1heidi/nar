##STEP 2 - Database Stats  
##Purpose: Determine descriptive stats for individual databases
##Package(s): tidyverse
##Input file(s): nar_v20_1.csv
##Output file(s): nar_v20_2.csv

library(tidyverse)

nar_v20_1 <- read.csv("nar_v20_1.csv")
nar_v20_1 <- tbl_df(nar_v20_1)

s<-split(nar_v20_1, nar_v20_1$db_id)

## Determine Debut Year

debut_yr <- sapply(s, function(x) {
  min(x[, c("article_year")])
  })

## convert to data frame with columns named
debut_yr_df = data.frame(db_id = names(debut_yr), debut_yr = debut_yr)

## Determine total number of NAR publications for each db

total_art <- sapply(s, function(x) {
  x <- nrow(x[,(c("article_id"))])
})

## convert to data frame with columns named
total_art_df = data.frame(db_id = names(total_art), total_articles = total_art)

## Determine Total Citations

total_cit <- sapply(s, function (x) {
  x <- sum(x[, c("citations")])
})

## convert to data frame with columns named
total_cit_df = data.frame(db_id = names(total_cit), total_citations = total_cit)

## Merge new variables with nar
nar_v20_1_a <- tbl_df(merge(nar_v20_1, debut_yr_df, by = "db_id"))
nar_v20_1_b <- tbl_df(merge(nar_v20_1_a, total_art_df, by = "db_id"))
nar_v20_2 <- tbl_df(merge(nar_v20_1_b, total_cit_df, by = "db_id"))

## Save file
write.csv(nar_v20_2, "nar_v20_2.csv", row.names=FALSE)

