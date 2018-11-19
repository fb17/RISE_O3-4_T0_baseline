# OBJECTIVE 3 AND 4 BASELINE SURVEY IN INDONESIA - NOVEMBER 2018 TO ???


# FIX ALL DATES *****************************
temp = NULL #create blank variable
fix_date <- function(x_date){
  for(i in 1:nrow(house)) {     # Loop through number of rows in document
    temp2 <- x_date[i]          # For each row, separate the date and convert from string to date and correct yyyy-mm-dd format
    temp2 <- parse_date_time(temp2, orders = c("mdy HMS", "ymd HMS", "dmy HMS")) # Convert String to POSIXct format
    temp2 <- as.Date(as.POSIXct(temp2, origin = "1970-01-01", tz = "UTC"))  # Convert POSIXct to Date format
    temp <- append(temp, temp2)    # Put each row back into a single column
  }
  x_date <- temp
}


fix_date <- function(x_date){
  x_date <- parse_date_time(x_date, orders = c("mdy HMS", "ymd HMS", "dmy HMS")) # Convert String to POSIXct format
  x_date <- as.POSIXct(x_date, origin = "1970-01-01", tz = "UTC")  # Convert POSIXct to Date format
}


house$endtime <- fix_date(house$endtime) 
house$starttime <- fix_date (house$starttime)
#house$today <- dmy (house$today) the column is already ymd
house$time1 <- fix_date (house$time1)
house$time2 <- fix_date (house$time2)
house$time3 <- fix_date (house$time3)
house$time4 <- fix_date (house$time4)
house$time5 <- fix_date (house$time5)
house$time7 <- fix_date (house$time7)
house$time8 <- fix_date (house$time8)
house$time9 <- fix_date (house$time9)
house$time10 <- fix_date (house$time10)





house$today <- dmy (house$today)
# hhd$today <- ymd (hhd$today)
# consent$today <- mdy (consent$today)





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

hhd.person$dob <- dmy (hhd.person$dob)

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



#############################################
#############################################
# LABEL VARIABLES

#get response labels from file
setwd("S:/R-MNHS-SPHPM-EPM-IDEpi/Current/RISE/4. Surveys/3.Baseline")

house_responses <- readxl::read_excel("RISE_baseline_house_ID_20181012_v16.xlsx", 
                               sheet = "choices")
      






house$plants_yn <- factor (house$plants_yn,
                             levels = c (0, 1, -88, -99, -66),
                             labels = c ("no", "yes", "refused", "don't know", "not asked")) 

table(house$plants_yn)

#############################################
#############################################
# CODEBOOK
# 
# library(dataMaid)
# makeCodebook(hhd) #didn't work for house - problem with date?
# 




#############################################
# checking things

table(house$survey_status, useNA = "always")
table(house$home_yn, house$survey_status, useNA = "always")

# how to identify a completed house survey?
table(house$children_yn)
table(house$respondent_house, house$home_yn, useNA = "always")



table(hhd$survey_status, useNA = "always")
# how to identify a completed house survey?
sum (hhd$no_people)
table (hhd$no_people)
sum (hhd$no_child_under5)

# put house and household together
house1 <- house %>% 
  select (settlement_barcode, extract_house_no, survey_status, home_yn)
hhd1 <- hhd %>% 
  select (settlement_barcode, extract_house_no, hhd_name, survey_status)

  
  
  
rm(house1, )



# 
table (hhd$language)

#############################################
# DESCRIPTIVE / SUMMARY STATISTICS???
lapply(house, function(x) {
  if (is.numeric(x)) return(summary(x))
  if (is.factor(x)) return(table(x))
  if (is.character(x)) return(list(x))
  if (is.Date(x)) return(min(x))
  if (is.Date(x)) return(max(x))
  })

date
summarise(house$today)

What things do I want to check?
  
# are there incomplete surveys?
table(house$survey_status)
table(hhd$survey_status)

#############################################
#############################################
##  HOUSE SURVEY                           ##
#############################################
#############################################







#############################################
#############################################
##  Person-level data                      ##
#############################################
#############################################

hhd.person.clean <- hhd.person %>% 
  mutate (age = (today() - dob) / 365) %>% 
  select (person_name, person_name_last, person_relationship, gender, dob, age, name_list, PARENT_KEY, KEY) 
hhd.person.clean$KEY <- str_replace (hhd.person.clean$KEY, ".*\\[", "") #remove everything before "["- worked
hhd.person.clean$KEY <- str_replace (hhd.person.clean$KEY, "\\]", "") #remove "]"


hhd.ethnicity.clean <- hhd.ethnicity %>% 
  select (ethnicity, PARENT_KEY, KEY)
hhd.ethnicity.clean$KEY <- str_replace (hhd.ethnicity.clean$KEY, ".*\\[", "") #remove everything before "["- worked
hhd.ethnicity.clean$KEY <- str_replace (hhd.ethnicity.clean$KEY, "\\]", "") #remove "]"

hhd.religion.clean <- hhd.religion %>% 
  select (religion, PARENT_KEY, KEY)
hhd.religion.clean$KEY <- str_replace (hhd.religion.clean$KEY, ".*\\[", "") #remove everything before "["- worked
hhd.religion.clean$KEY <- str_replace (hhd.religion.clean$KEY, "\\]", "") #remove "]"
  
hhd.marital.clean <- hhd.marital %>% 
  select(marital_status, PARENT_KEY, KEY)
hhd.marital.clean$KEY <- str_replace (hhd.marital.clean$KEY, ".*\\[", "") #remove everything before "["- worked
hhd.marital.clean$KEY <- str_replace (hhd.marital.clean$KEY, "\\]", "") #remove "]"
  
hhd.daycare.clean <- hhd.daycare %>% 
  select(kinder_yn, PARENT_KEY, KEY)
hhd.daycare.clean$KEY <- str_replace (hhd.daycare.clean$KEY, ".*\\[", "") #remove everything before "["- worked
hhd.daycare.clean$KEY <- str_replace (hhd.daycare.clean$KEY, "\\]", "") #remove "]"
  
hhd.school.clean <- hhd.school %>% 
  select(school_yn, school_level, school_level_highest, PARENT_KEY, KEY)
hhd.school.clean$KEY <- str_replace (hhd.school.clean$KEY, ".*\\[", "") #remove everything before "["- worked
hhd.school.clean$KEY <- str_replace (hhd.school.clean$KEY, "\\]", "") #remove "]"

hhd.read.clean <- hhd.read %>% 
  select(read_write, PARENT_KEY, KEY)
hhd.read.clean$KEY <- str_replace (hhd.read.clean$KEY, ".*\\[", "") #remove everything before "["- worked
hhd.read.clean$KEY <- str_replace (hhd.read.clean$KEY, "\\]", "") #remove "]"

hhd.activity.clean <- hhd.activity %>% 
  select(primary_activity, PARENT_KEY, KEY)
hhd.activity.clean$KEY <- str_replace (hhd.activity.clean$KEY, ".*\\[", "") #remove everything before "["- worked
hhd.activity.clean$KEY <- str_replace (hhd.activity.clean$KEY, "\\]", "") #remove "]"

#complete file of demographics for all people
demographics <- left_join (hhd.person.clean, hhd.ethnicity.clean, by = c("PARENT_KEY", "KEY"))
demographics <- left_join (demographics, hhd.religion.clean, by = c("PARENT_KEY", "KEY"))
demographics <- left_join (demographics, hhd.marital.clean, by = c("PARENT_KEY", "KEY")) 
demographics <- left_join (demographics, hhd.daycare.clean, by = c("PARENT_KEY", "KEY")) 
demographics <- left_join (demographics, hhd.school.clean, by = c("PARENT_KEY", "KEY")) 
demographics <- left_join (demographics, hhd.read.clean, by = c("PARENT_KEY", "KEY")) 
demographics <- left_join (demographics, hhd.activity.clean, by = c("PARENT_KEY", "KEY")) 

#complete file of child health data plus child demographics
dput(names(hhd.child)) #produces full list of variable names

hhd.child.health <- hhd.child %>% 
  select (name_child, health_general_child:PARENT_KEY) %>% 
  select (-time7, -time8) %>%  #to remove columns 
  rename (name_list = name_child)

hhd.child.health <- right_join (demographics, hhd.child.health, by = c("PARENT_KEY", "name_list")) 
# might want to clean out a few more variables


  
  # 
  # select (health_general_child, health_next_yr, cough, toothache, breathing, diarrhea1,
  #         diarrhea_7, fever, skin, injury, injury_type, injury_type_1, injury_type_2, 
  #         injury_type_3, injury_type_4, injury_type_5, injury_type_6, injury_type__77, 
  #         injury_type__88, injury_type__99, doctor_yn, doctor_sick, doctor_why, 
  #         doctor_why_1, doctor_why_2, doctor_why_3, doctor_why_4, doctor_why_5, 
  #         doctor_why_6, doctor_why_7, doctor_why_8, doctor_why__77, doctor_why__88, 
  #         doctor_why__99,)
  