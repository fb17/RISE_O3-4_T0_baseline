# OBJECTIVE 3 AND 4 BASELINE SURVEY IN INDONESIA - NOVEMBER 2018 TO ???



library (tidyverse)
library (lubridate)
library (stringr)

rm(list = ls())
setwd("S:/R-MNHS-SPHPM-EPM-IDEpi/Current/RISE/4. Surveys/3.Baseline/2. ID/2. Data/1. raw data/testing")

# DEFINE TODAY FOR DAILY QC - this is the date of data collection
date <- "2018-10-12"
day.qc <- ymd (date)
rm(date)

# HOUSE SURVEY
house <- read_csv (file="RISE_baseline_house_ID_v16.csv")
house.water <- read_csv (file="RISE_baseline_house_ID_v16-house_survey-water_use-water_repeat.csv")

# HOUSEHOLD SURVEY
hhd <- read_csv (file = "RISE_baseline_hhd_ID_v14.csv")
hhd.child <- read_csv (file = "RISE_baseline_hhd_ID_v14-hhd_survey-child_loop.csv")
hhd.activity <- read_csv (file = "RISE_baseline_hhd_ID_v14-hhd_survey-demographics-activity.csv")
hhd.daycare <- read_csv (file = "RISE_baseline_hhd_ID_v14-hhd_survey-demographics-daycare.csv")
hhd.ethnicity <- read_csv (file = "RISE_baseline_hhd_ID_v14-hhd_survey-demographics-ethnicity_screen-ethnicity_repeat.csv")
hhd.marital <- read_csv (file = "RISE_baseline_hhd_ID_v14-hhd_survey-demographics-marital_status1.csv")
hhd.read <- read_csv (file = "RISE_baseline_hhd_ID_v14-hhd_survey-demographics-read.csv")
hhd.religion <- read_csv (file = "RISE_baseline_hhd_ID_v14-hhd_survey-demographics-religion_screen-religion_repeat.csv")
hhd.school <- read_csv (file = "RISE_baseline_hhd_ID_v14-hhd_survey-demographics-school.csv")
hhd.person <- read_csv (file = "RISE_baseline_hhd_ID_v14-hhd_survey-person_details1.csv")

# CONSENT SURVEY
consent <- read_csv (file = "consent_ID.csv")
consent.form3 <- read_csv (file = "consent_ID-consent_form3.csv")
consent.childname <- read_csv (file = "consent_ID-consent3_childname.csv")

#############################################

# FIX ALL DATES *****************************
fix_date <- function(x_date){
  x_date <- ifelse(!is.na(ymd_hms(x_date)), ymd_hms(x_date), dmy_hms(x_date))  # Check the format and return the correct integer-date
  x_date <- as.POSIXct(x_date, origin = "1970-01-01", tz = "UTC")  # Convert the integer-date to a consistent format
}


house$endtime <- fix_date(house$endtime) 
house$starttime <- fix_date (house$starttime)
house$today <- dmy (house$today)
house$time1 <- fix_date (house$time1)
house$time2 <- fix_date (house$time2)
house$time3 <- fix_date (house$time3)
house$time4 <- fix_date (house$time4)
house$time5 <- fix_date (house$time5)
house$time7 <- fix_date (house$time7)
house$time8 <- fix_date (house$time8)
house$time9 <- fix_date (house$time9)
house$time10 <- fix_date (house$time10)

# hhd$starttime <- fix_date (hhd$starttime)
# hhd$endtime <- fix_date (hhd$endtime)
# hhd$today <- ymd (hhd$today)
hhd$time1 <- fix_date (hhd$time1)
hhd$time2 <- fix_date (hhd$time2)
hhd$time3 <- fix_date (hhd$time3)
hhd$time4 <- fix_date (hhd$time4)
hhd$time9 <- fix_date (hhd$time9)
hhd$time10 <- fix_date (hhd$time10)
hhd$time11 <- fix_date (hhd$time11)
hhd$time12 <- fix_date (hhd$time12)
hhd$time13 <- fix_date (hhd$time13)
hhd$time14 <- fix_date (hhd$time14)

hhd.child$time5 <- fix_date (hhd.child$time5)
hhd.child$time6 <- fix_date (hhd.child$time6)
hhd.child$time7 <- fix_date (hhd.child$time7)
hhd.child$time8 <- fix_date (hhd.child$time8)

consent$endtime <- fix_date(consent$endtime) 
consent$starttime <- fix_date (consent$starttime)
# consent$today <- mdy (consent$today)
consent$time1 <- fix_date (consent$time1)
consent$time2 <- fix_date (consent$time2)
consent$time3 <- fix_date (consent$time3)
consent$time4 <- fix_date (consent$time4)
consent$time5 <- fix_date (consent$time5)
consent$time9 <- fix_date (consent$time9)
consent$time10 <- fix_date (consent$time10)
consent$time11 <- fix_date (consent$time11)

consent.childname$time7 <- fix_date (consent.childname$time7)

consent.form3$time6 <- fix_date (consent.form3$time6)
consent.form3$time8 <- fix_date (consent.form3$time8)


#############################################
##  Correct known errors in the data       ##
#############################################
# setwd("S:/R-MNHS-SPHPM-EPM-IDEpi/Current/RISE/4. Surveys/2.Consent and House ID/2. ID/2. Data/2. code")
# source("consentid-corrections.R")
# setwd("S:/R-MNHS-SPHPM-EPM-IDEpi/Current/RISE/4. Surveys/2.Consent and House ID/2. ID/2. Data")




#############################################
#############################################
##  Clean variables                        ##
#############################################
#############################################
# setwd("S:/R-MNHS-SPHPM-EPM-IDEpi/Current/RISE/4. Surveys/2.Consent and House ID/2. ID/2. Data/2. code")
# source("consentid-clean.R")
# setwd("S:/R-MNHS-SPHPM-EPM-IDEpi/Current/RISE/4. Surveys/2.Consent and House ID/2. ID/2. Data")
