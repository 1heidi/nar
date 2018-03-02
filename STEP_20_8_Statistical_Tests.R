##STEP_20_8 Statistical tests for signifiance of trends and proportions 
##Purpose: execute chisq.test and prop.trend.test to test for significance & reject null hypotheses. Ref for prop.trend.test: Introductory Statistics with R (2008) Dalgaard, Peter pgs. 149-151 and ref for chisq.test: Agresti, A. (2007) An Introduction to Categorical Data Analysis, 2nd ed., New York: John Wiley & Sons. Page 38.
##Package(s): base R
##Input file(s): see specifics for each test
##Output file(s): none - copied and pasted into manuscript text

##### Test Trend in Citation Quartiles for:  Available Databases (Table 1)

##input: nar_v20_4_sum.csv
prop.trend.test(nar_v20_4_sum$available, nar_v20_4_sum$databases)
## output: X-squared = 86.245, df = 1, p-value < 2.2e-16

##### Test Trend in Citation Quartiles for:  Updated Databases Found  (Table 2)

## input:  nar_v20_7_sum.csv
prop.trend.test(nar_v20_7_sum$updates_found, nar_v20_7_sum$db_sample)
## output:  X-squared = 42.558, df = 1, p-value = 6.862e-11

##### Test Trend in Citation Quartiles for:  Maintenace After Debut  (Table 2)

## input:  nar_v20_7_sum.csv
prop.trend.test(nar_v20_7_sum$sum_maint_aft_debut, nar_v20_7_sum$updates_found)
## output:  X-squared = 23.278, df = 1, p-value = 1.402e-06

##### Pearson's Chi-squared Test for Count Data for: Update Periods within Quartiles  (Figure 5)

## input:  nar_v20_7_plot.csv
q1 <- filter(nar_v20_7_plot, quartile == 1)
q2 <- filter(nar_v20_7_plot, quartile == 2)
q3 <- filter(nar_v20_7_plot, quartile == 3)
q4 <- filter(nar_v20_7_plot, quartile == 4)

chisq.test(q1$quartile_count, p = rep(1/5,5))
##output:  X-squared = 150.43, df = 4, p-value < 2.2e-16

chisq.test(q2$quartile_count, p = rep(1/5,5))
##output:  X-squared = 95.197, df = 4, p-value < 2.2e-16

chisq.test(q3$quartile_count, p = rep(1/5,5))
##output:  X-squared = 23.727, df = 4, p-value = 9.058e-05

chisq.test(q4$quartile_count,p = rep(1/5,5))
##output:  X-squared = 5.2676, df = 4, p-value = 0.2609
