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
house$today <- dmy (house$today)
# hhd$today <- ymd (hhd$today)
# consent$today <- mdy (consent$today)

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


#############################################
#############################################
# SUBSET - ONLY DATA COLLECTED TODAY
#############################################
#############################################

subconsent <- subset (consent, today == day.qc, 
                      select = c (settlement_name, extract_house_no, signed_form1, consent1_1, consent1_2, consent1_3, verify1)) 
subhouse <- subset (house, today == day.qc, 
                    select = c (settlement, extract_house_no, verify1, survey_status))

subhhd <- subset (hhd, today == day.qc, 
                  select = c (settlement, extract_house_no, verify1, survey_status))




#############################################
#############################################
# DAILY QC REPORT
#############################################
#############################################

#############################################
####### what settlements were visited ************
settlement <-  subhouse %>% 
  arrange (settlement) %>% 
  group_by (settlement) %>%
  summarize (count = n ())
settlement.list <- pull (settlement, var = settlement)


#############################################
# HOUSE SURVEYS

#number started
nrow(subhouse)

#number completed
house.complete <- subhouse %>% 
  filter (survey_status == 1)


#############################################
# HOUSEHOLD SURVEYS

#number started
nrow(subhhd)

#number completed
hhd.complete <- subhhd %>% 
  filter (survey_status == 1)


#############################################
# HOUSEHOLD CONSENT FORMS
#number started
nrow(subconsent)

#number completed
hhd.consent.yes <- subconsent %>% 
  filter (signed_form1 == 1, consent1_1 == "yes", consent1_2 == "yes", consent1_3 == "yes", verify1 == 1)
nrow(hhd.consent.yes) #2


#############################################
# VERIFICATION ERRORS
# check that all surveys collected were verified by respondents
house.no.verify <- subhouse %>% 
  filter (verify1 == 0)
hhd.no.verify <- subhhd %>% 
  filter (verify1 == 0)
consent.no.verify <- subconsent %>% 
  filter (verify1 == 0)







#############################################
# HOUSE SURVEYS WITH NO HOUSEHOLD SURVEY?



