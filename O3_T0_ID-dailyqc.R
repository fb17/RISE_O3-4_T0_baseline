# OBJECTIVE 3 AND 4 BASELINE SURVEY IN INDONESIA - NOVEMBER 2018 TO ???



library (tidyverse)
library (lubridate)
library (stringr)

rm(list = ls())
setwd("S:/R-MNHS-SPHPM-EPM-IDEpi/Current/RISE/4. Surveys/3.Baseline/2. ID/2. Data/1. raw data/20181114")


# DEFINE TODAY FOR DAILY QC - this is the date of data collection
date <- "2018-11-14"
day.qc <- ymd (date)
rm(date)

# HOUSE SURVEY
house <- read_csv (file="RISE_baseline_house_ID.csv")
# house <- read.csv(file="RISE_baseline_house_ID.csv", header=TRUE, sep="\t")
# house.water <- read.csv(file="RISE_baseline_house_ID-house_survey-water_use-water_repeat.csv", header=TRUE, sep="\t")
house.water <- read_csv(file="RISE_baseline_house_ID-house_survey-water_use-water_repeat.csv")

# HOUSEHOLD SURVEY
# hhd <- read.csv (file = "RISE_baseline_hhd_ID.csv", header=TRUE, sep="\t")
# hhd.child <- read.csv (file = "RISE_baseline_hhd_ID-hhd_survey-child_loop.csv", header=TRUE, sep="\t")
# hhd.activity <- read.csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-activity.csv", header=TRUE, sep="\t")
# hhd.daycare <- read.csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-daycare.csv", header=TRUE, sep="\t")
# hhd.ethnicity <- read.csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-ethnicity_screen-ethnicity_repeat.csv", header=TRUE, sep="\t")
# hhd.marital <- read.csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-marital_status1.csv", header=TRUE, sep="\t")
# hhd.read <- read.csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-read.csv", header=TRUE, sep="\t")
# hhd.religion <- read.csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-religion_screen-religion_repeat.csv", header=TRUE, sep="\t")
# hhd.school <- read.csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-school.csv", header=TRUE, sep="\t")
# hhd.person <- read.csv (file = "RISE_baseline_hhd_ID-hhd_survey-person_details1.csv", header=TRUE, sep="\t")

hhd <- read_csv (file = "RISE_baseline_hhd_ID.csv")
hhd.child <- read_csv (file = "RISE_baseline_hhd_ID-hhd_survey-child_loop.csv")
hhd.activity <- read_csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-activity.csv")
hhd.daycare <- read_csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-daycare.csv")
hhd.ethnicity <- read_csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-ethnicity_screen-ethnicity_repeat.csv")
hhd.marital <- read_csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-marital_status1.csv")
hhd.read <- read_csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-read.csv")
hhd.religion <- read_csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-religion_screen-religion_repeat.csv")
hhd.school <- read_csv (file = "RISE_baseline_hhd_ID-hhd_survey-demographics-school.csv")
hhd.person <- read_csv (file = "RISE_baseline_hhd_ID-hhd_survey-person_details1.csv")



# CONSENT SURVEY
# consent <- read.csv (file = "RISE_consent_ID.csv", header=TRUE, sep="\t")
# consent.form3 <- read.csv (file = "RISE_consent_ID-consent_form3.csv", header=TRUE, sep="\t")
# consent.childname <- read.csv (file = "RISE_consent_ID-consent3_childname.csv", header=TRUE, sep="\t")

consent <- read_csv (file = "consent_ID_final.csv")
consent.form3 <- read_csv (file = "consent_ID_final-consent_form3.csv")
consent.childname <- read_csv (file = "consent_ID_final-consent3_childname.csv")
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

# need to fix dates to allow for return visits with survey left open (can't use "today")
house$endtime <- date(dmy_hms (house$endtime))
hhd$endtime <- date(dmy_hms (hhd$endtime)) 
consent$endtime <- date(dmy_hms (consent$endtime))


# house$today <- ymd (house$today)  #you will need to change depending on how the data downloads
# #fiona to fix later
# hhd$today <- ymd (hhd$today) 
# consent$today <- ymd (consent$today)


#############################################
#############################################
# SUBSET - ONLY DATA COLLECTED TODAY
#############################################
#############################################

subconsent <- subset (consent, endtime == day.qc,
                      select = c (settlement_name, house_no, signed_form1, 
                                  consent1_1, consent1_2, consent1_3, verify1))
subhouse <- subset (house, endtime == day.qc, 
                    select = c (extract_settlement, settlement_barcode, 
                                extract_house_no, verify1, survey_status))

subhhd <- subset (hhd, endtime == day.qc, 
                  select = c (extract_settlement, settlement_barcode,extract_house_no, 
                              verify1, survey_status))




#############################################
#############################################
# DAILY QC REPORT
#############################################
#############################################

#############################################
####### what settlements were visited ************

# need to merge settlements from both house and household surveys because there
# might not always be a house survey

settlement_house <-  subhouse %>%
  select (settlement_barcode)
settlement_hhd <-  subhhd %>%
  select (settlement_barcode)

# append
settlement_group <- rbind(settlement_house, settlement_hhd)

# then group
settlement <- settlement_group %>% 
  arrange (settlement_barcode) %>% 
  group_by (settlement_barcode) %>%
  summarize (count = n ())

settlement.list <- pull (settlement, var = settlement_barcode)


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
nrow(hhd.consent.yes) #


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



