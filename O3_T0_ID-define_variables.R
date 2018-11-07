#try to match response options to survey data

rm(list = ls())
setwd("S:/R-MNHS-SPHPM-EPM-IDEpi/Current/RISE/4. Surveys/3.Baseline/2. ID/2. Data/1. raw data/testing")

# HOUSE SURVEY
house <- read_csv (file="RISE_baseline_house_ID_v16.csv")
house.water <- read_csv (file="RISE_baseline_house_ID_v16-house_survey-water_use-water_repeat.csv")

#get response labels from file
setwd("S:/R-MNHS-SPHPM-EPM-IDEpi/Current/RISE/4. Surveys/3.Baseline")

house_responses <- readxl::read_excel("RISE_baseline_house_ID_20181012_v16.xlsx", 
                                      sheet = "choices")


for(i in 1:ncol(house)){
  if(grepl("factor", surveyDF$type[i])){
    factor_label <- surveyDF$factorlabel[i]
    factorDF <- filter(choicesDF, list_name == factor_label) %>%
      select(value, label = `label::English`) %>%
      arrange(as.numeric(value))
  
  
}