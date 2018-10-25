library (tidyverse)
library (lubridate)
library (stringr)

rm(list = ls())
setwd("E:/R_Stuff")

surveyDF <- readxl::read_excel("RISE_baseline_house_ID_20181012_v16.xlsx", 
                               sheet = "survey")
choicesDF <- readxl::read_excel("RISE_baseline_house_ID_20181012_v16.xlsx", 
                                sheet = "choices")
settingsDF <- readxl::read_excel("RISE_baseline_house_ID_20181012_v16.xlsx", 
                                 sheet = "settings")

house <- read_csv (file="RISE_baseline_house_ID_v16.csv")
house.water <- read_csv (file="RISE_baseline_house_ID_v16-house_survey-water_use-water_repeat.csv")

house$today <- ymd (house$today)

form_title <- settingsDF$form_title[[1]]
form_id <- settingsDF$form_id[[1]]


form_version <- settingsDF$version[[1]]
default_language <- settingsDF$default_language[[1]]
rm(settingsDF)


surveyDF <- filter(surveyDF, 
                   !(type %in% c("note", 
                                 "begin group", 
                                 "end group", 
                                 "begin repeat",
                                 "end repeat")), 
                   !is.na(type))

surveyDF$id <- 1:nrow(surveyDF)

surveyDF$factorlabel <- NA
the_labels <- grep("select_one|select_multiple", surveyDF$type) #these are row numbers
surveyDF$factorlabel[the_labels] <- surveyDF$type[the_labels]
surveyDF$factorlabel <- gsub("select_one ", "", surveyDF$factorlabel) #remove select_one
surveyDF$factorlabel <- gsub("select_multiple ", "", surveyDF$factorlabel)



surveyDF$type[surveyDF$type == "start"] <- "date-time (start)"
surveyDF$type[surveyDF$type == "end"] <- "date-time (end)"
surveyDF$type[surveyDF$type == "deviceid"] <- "deviceid (string)"
surveyDF$type[surveyDF$type == "text"] <- "string"
surveyDF$type[surveyDF$type == "text"] <- "string"
surveyDF$type[surveyDF$type == "barcode"] <- "string"
surveyDF$type[surveyDF$type == "calculate"] <- "unknown (calculate)"





the_type <- grep("select_one", surveyDF$type)
surveyDF$type[the_type] <- "factor (select one)"
the_type <- grep("select_multiple", surveyDF$type)
surveyDF$type[the_type] <- "factor (select multiple)"

HouseColumns <- colnames(house, do.NULL = TRUE, prefix = "col")

#######################################
# Merge data set with data dictionary #
#######################################
for(i in 1:nrow(surveyDF)) {
  if(grepl("factor", surveyDF$type[i])) {
    factor_label <- surveyDF$factorlabel[i]
    factorDF <- filter(choicesDF, list_name == factor_label) %>%
      select(value, label = `label:English`) %>%
      arrange(as.numeric(value))

    for(j in 1:ncol(house)) {
      if(grepl(HouseColumns[j], surveyDF$name[i])) {
        
        house[[j]] <- factor(house[[j]], levels = c(factorDF$value),
                                     labels = c(factorDF$label))
      }
    }
  }
}

