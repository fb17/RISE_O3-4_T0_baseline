# OBJECTIVE 3 AND 4 BASELINE SURVEY IN INDONESIA - NOVEMBER 2018 TO ???



library (tidyverse)
library (lubridate)
library (stringr)

rm(list = ls())
setwd("S:/R-MNHS-SPHPM-EPM-IDEpi/Current/RISE/4. Surveys/3.Baseline/2. ID/2. Data/1. raw data/20181102_practice_ID")


# DEFINE TODAY FOR DAILY QC - this is the date of data collection
date <- "2018-11-02"
day.qc <- ymd (date)
rm(date)

# HOUSE SURVEY
# house <- read_csv (file="RISE_baseline_house_ID_v17.csv")
house <- read.csv(file="RISE_baseline_house_ID_v17.csv", header=TRUE, sep="\t")
house.water <- read.csv(file="RISE_baseline_house_ID_v17-house_survey-water_use-water_repeat.csv", header=TRUE, sep="\t")

# HOUSEHOLD SURVEY
hhd <- read.csv (file = "RISE_baseline_hhd_ID_v15.csv", header=TRUE, sep="\t")
hhd.child <- read.csv (file = "RISE_baseline_hhd_ID_v15-hhd_survey-child_loop.csv", header=TRUE, sep="\t")
hhd.activity <- read.csv (file = "RISE_baseline_hhd_ID_v15-hhd_survey-demographics-activity.csv", header=TRUE, sep="\t")
hhd.daycare <- read.csv (file = "RISE_baseline_hhd_ID_v15-hhd_survey-demographics-daycare.csv", header=TRUE, sep="\t")
hhd.ethnicity <- read.csv (file = "RISE_baseline_hhd_ID_v15-hhd_survey-demographics-ethnicity_screen-ethnicity_repeat.csv", header=TRUE, sep="\t")
hhd.marital <- read.csv (file = "RISE_baseline_hhd_ID_v15-hhd_survey-demographics-marital_status1.csv", header=TRUE, sep="\t")
hhd.read <- read.csv (file = "RISE_baseline_hhd_ID_v15-hhd_survey-demographics-read.csv", header=TRUE, sep="\t")
hhd.religion <- read.csv (file = "RISE_baseline_hhd_ID_v15-hhd_survey-demographics-religion_screen-religion_repeat.csv", header=TRUE, sep="\t")
hhd.school <- read.csv (file = "RISE_baseline_hhd_ID_v15-hhd_survey-demographics-school.csv", header=TRUE, sep="\t")
hhd.person <- read.csv (file = "RISE_baseline_hhd_ID_v15-hhd_survey-person_details1.csv", header=TRUE, sep="\t")

# CONSENT SURVEY
consent <- read.csv (file = "RISE_consent_ID.csv", header=TRUE, sep="\t")
consent.form3 <- read.csv (file = "RISE_consent_ID-consent_form3.csv", header=TRUE, sep="\t")
consent.childname <- read.csv (file = "RISE_consent_ID-consent3_childname.csv", header=TRUE, sep="\t")

#############################################











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

house$today <- ymd (house$today)  #you will need to change depending on how the data downloads
#fiona to fix later
hhd$today <- ymd (hhd$today) 
consent$today <- ymd (consent$today)


#############################################
#############################################
# SUBSET - ONLY DATA COLLECTED TODAY
#############################################
#############################################

subconsent <- subset (consent, today == day.qc,
                      select = c (community_name, house_no))
subhouse <- subset (house, today == day.qc, 
                    select = c (extract_settlement, extract_house_no, verify1, survey_status))

subhhd <- subset (hhd, today == day.qc, 
                  select = c (extract_settlement, extract_house_no, verify1, survey_status))




#############################################
#############################################
# DAILY QC REPORT
#############################################
#############################################

#############################################
####### what settlements were visited ************
settlement <-  subhouse %>% 
  arrange (extract_settlement) %>% 
  group_by (extract_settlement) %>%
  summarize (count = n ())
settlement.list <- pull (settlement, var = extract_settlement)


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
# number started
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



