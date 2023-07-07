#INSTALLING THE PACKAGES

install.packages("tidyverse")
install.packages("lubridate")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyr")
install.packages("here")
install.packages("skimr")
install.packages("janitor")


#LOADING PACKAGES
library(tidyverse)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)
library(here)
library(skimr)
library(janitor)


#DOWNLOADING THE DATASET
library(utils)

url <- "https://www.kaggle.com/arashnic/fitbit"

bellabeat <- "https://www.kaggle.com/arashnic/fitbit"

download.file(url, destfile = bellabeat)


#Importing Dataset
Activity <- read.csv("dailyActivity_merged.csv")
head(Activity)
colnames(Activity)
str(Activity)


Calories <- read.csv("dailyCalories_merged.csv")
head(Calories)
colnames(Calories)
str(Calories)

Intensities <- read.csv("dailyIntensities_merged.csv")
head(Intensities)
colnames(Intensities)
str(Intensities)

Heartrate <- read.csv("heartrate_seconds_merged.csv")
head(Heartrate)
colnames(Heartrate)
str(Heartrate)

Sleep <- read.csv("sleepDay_merged.csv")
head(Sleep)
colnames(Sleep)
str(Sleep)

Weight <- read.csv("weightLogInfo_merged.csv")
head(Weight)
colnames(Weight)
str(Weight)




#DATA WRANGLING


# Basic Cleaning: Spelling errors, Misfield values, Missing values

#mispelling

install.packages("hunspell")
library(hunspell)
misspelled_Activity_words <- hunspell_check("Activity")
print(misspelled_Activity_words)


#null values
is_na <- is.na(Activity)
num_missing <- sum(is_na)
complete_cases <- complete.cases(Activity)
num_complete_cases <- sum(complete_cases)
num_complete_cases

#missing value
is_na <- is.na(Activity)
num_missing <- sum(is_na)
complete_cases <- complete.cases(Activity)
num_complete_cases <- sum(complete_cases)
library(dplyr)
missing_summary <- Activity %>% summarise_all(~sum(is.na(.)))
missing_summary



#DATA FORMATTING

# Activity
Activity$ActivityDate=as.POSIXct(Activity$ActivityDate, format="%m/%d/%Y", tz=Sys.timezone())
Activity$date <- format(Activity$ActivityDate, format = "%m/%d/%y")
Activity$ActivityDate=as.Date(Activity$ActivityDate, format="%m/%d/%Y", tz=Sys.timezone())
Activity$date=as.Date(Activity$date, format="%m/%d/%Y")
Activity$date

# Intensities
Intensities$ActivityDay=as.Date(Intensities$ActivityDay, 
                                format="%m/%d/%Y", tz=Sys.timezone())

# Sleep
Sleep$SleepDay=as.POSIXct(Sleep$SleepDay, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
Sleep$date <- format(Sleep$SleepDay, format = "%m/%d/%y")
Sleep$date=as.Date(Sleep$date, "% m/% d/% y")




#DATASET SUMMARY
Activity %>%
  summarise(Activity_participants = n_distinct(Activity$Id))

n_distinct(Calories$Id)

n_distinct(Intensities$Id)

n_distinct(Heartrate$Id)

n_distinct(Sleep$Id)

n_distinct(Weight$Id)



# Activity
Activity %>%
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes, Calories) %>%
  summary()

# Explore number of active minutes per category
Intensities %>%
  select(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes) %>%
  summary()

# Calories
Calories %>%
  select(Calories) %>%
  summary()

# Sleep
Sleep %>%
  select(TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed) %>%
  summary()

# Weight
Weight %>%
  select(WeightKg, Fat) %>%
  summary()



#Merging Activity and Sleep
Combined_data_inner <- merge(Sleep, Activity, by="Id")
n_distinct(Combined_data_inner$Id)

Combined_data_outer <- merge(Sleep, Activity, by="Id", all = TRUE)
n_distinct(Combined_data_outer$Id)














































































