# OBJECTIVE 3 CHILD SAMPLING IN Fiji - 26 SEPTEMBER 2019 TO ???NOVEMBER 2019

library (tidyverse)
library (lubridate)
library (stringr)

rm(list = ls())
setwd("Z:/Data Files/Data Files Objective 3")

# DEFINE TODAY FOR DAILY QC - this is the date of data collection
date <- "2019-09-30"
day.qc <- ymd (date)
rm(date)

# CHILD SAMPLING
child <- read_csv (file="O3_child_sample_FJ_v1.csv")

# FECES COLLECTION
feces <- read_csv (file="O3_feces_FJ_v1.csv")
feces.sample <- read_csv (file="O3_feces_FJ_v1-feces_collection.csv")

#############################################
#############################################
##  Clean variables                        ##
#############################################
#############################################
# need to fix dates to allow for return visits with survey left open (can't use "today")
child$starttime <- as.Date(child$starttime, format = '%B %d, %Y')
feces$starttime <- as.Date(feces$starttime, format = '%B %d, %Y')

#############################################
#############################################
##  MERGE                                  ##
#############################################
#############################################

#MERGE CHILD SAMPLING - don't need merge for Fiji as only one child per survey
child.merge <- child %>% 
  select (settlement_barcode, extract_house_no, 
          caregiver_present,	home_yn, survey_status, starttime, 
          barcode_edta,	barcode_edta_text, barcode_serum, barcode_serum_text,	
          barcode_bloodspot,	barcode_bloodspot_text, blood_check2, survey_check2, 
          feces_kit_barcode,	feces_kit_barcode_note) %>% 
  mutate (edta = ifelse (is.na(barcode_edta), barcode_edta_text, barcode_edta),
          serum = ifelse (is.na(barcode_serum), barcode_serum_text, barcode_serum), 
          bloodspot = ifelse (is.na(barcode_bloodspot), barcode_bloodspot_text, barcode_bloodspot), 
          feces = ifelse (is.na(feces_kit_barcode), feces_kit_barcode_note, feces_kit_barcode)) %>% 
  select (-barcode_edta,	-barcode_edta_text, -barcode_serum, -barcode_serum_text,	
          -barcode_bloodspot,	-barcode_bloodspot_text, -feces_kit_barcode, -feces_kit_barcode_note)

#MERGE FECES
#pull out required variables
feces1 <- feces %>% 
  select (settlement_barcode, extract_house_no, 
          feces_sample_yn, survey_status, starttime, KEY)

feces2 <- feces.sample %>% 
  select (barcode_feces, barcode_feces_text, PARENT_KEY, KEY)  %>% #PARENT_KEY MATCHES KEY IN feces1
  mutate (barcode = ifelse (is.na(barcode_feces), barcode_feces_text, barcode_feces)) %>% 
  select (-barcode_feces, -barcode_feces_text)

feces.merge <- merge(x = feces1, y = feces2, by.x = "KEY", by.y = "PARENT_KEY", all.y = TRUE) 
#matches all of feces 2; like a right-join
rm(feces1, feces2)

#############################################
#############################################
# SUBSET - ONLY DATA COLLECTED TODAY
#############################################
#############################################

subchild1 <- subset (child, starttime == day.qc, 
                     select = c (settlement_barcode, extract_house_no, 
                                 caregiver_present,	home_yn, survey_status))

subchild2 <- subset (child.merge, starttime == day.qc, 
                     select = c (-starttime)) 
# *******************

subfeces1 <- subset (feces, starttime == day.qc, 
                    select = c (settlement_barcode, extract_house_no, 
                                feces_sample_yn, survey_status))

subfeces2 <- subset (feces.merge, starttime == day.qc, 
                     select = c (settlement_barcode, extract_house_no, 
                                 feces_sample_yn, barcode, survey_status)) %>% 
  filter (!is.na(barcode))

#############################################
#############################################
# DAILY QC REPORT
#############################################
#############################################

#############################################
####### what settlements were visited ************

settlement_child <-  subchild1 %>%
  select (settlement_barcode)
settlement_feces <-  subfeces1 %>%
  select (settlement_barcode) %>% 
  filter (!is.na(settlement_barcode))

# append
settlement_group <- rbind(settlement_child, settlement_feces)

# then group
settlement <- settlement_group %>% 
  arrange (settlement_barcode) %>% 
  group_by (settlement_barcode) %>%
  summarize (count = n ())

settlement.list <- pull (settlement, var = settlement_barcode)

#############################################
# CHILD SURVEYS

#number started
nrow(subchild1)

no.edta <- subchild2 %>% 
  filter (!is.na (edta))

no.serum <- subchild2 %>% 
  filter (!is.na (serum))

no.bloodspot <- subchild2 %>% 
  filter (!is.na (bloodspot))

no.feces <- subchild2 %>% 
  filter (!is.na (feces))


#############################################
# FECES SURVEYS

#number started
nrow(subfeces1)

#number yes to feces sample collection
feces.yes <- subfeces1 %>% 
  filter (feces_sample_yn == 1)

# number of samples collected
nrow(subfeces2)





