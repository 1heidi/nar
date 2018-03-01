##STEP 1 - Database Status 
##Purpose: Loop through to determine availability status of each individual database
##Package(s): tidyverse
##Input file(s):  nar_v20.csv
##Output file(s): nar_v20_1.csv

library(tidyverse)
nar <- read.csv("nar_v20.csv")
s <- split(nar, nar$db_id)

status <- sapply(s, function(x) {
  x <- x[,c("available")]
  
  if(any(x=="yes")) {
    print("yes") }
  
  else if(any(x=="no")) {
    print("no")}
  
  else { 
    print("never_www")}
  
})

## create a dataframe from from the results above
status_df = data.frame(db_id = names(status), status = status)

## merge the status column into the nar dataset
nar_v20_1 <- merge(nar, status_df, by = "db_id")

## save csv appended as _1
write.csv(nar_v20_1, "nar_v20_1.csv", row.names=FALSE)

## double check that expected dbs return correctly