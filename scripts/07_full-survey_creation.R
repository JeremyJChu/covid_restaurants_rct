#### Preamble ####
# Purpose: This script cleans up the survey data, merges intervention with control survey responses for a full survey dataset, and also creates a dataset for logistic regression.
# Author: Jeremy Chu
# Data: 21 February 2021
# Contact: jeremychuj@gmail.com
# License: MIT
# Pre-requisites: 04_scoping-survey_simulation.R, 05_intervention-survey_simulation.R, 06_control-survey_simulation.R run.
# - None


#### Workspace setup ####
library(tidyverse)

#### Read data ####
scoping_survey <- read_csv(here("inputs","data","03_scoping_survey.csv"))
intervention_survey <- read_csv(here("inputs","data","04_intervention_survey.csv"))
control_survey <- read_csv(here("inputs","data","05_control_survey.csv"))

### Scoping Survey Results ###
scoping_results <-
  scoping_survey %>% 
  filter(Q5 != 'Permanently Closed') %>%
  filter(Q6 == 'Yes') %>%
  group_by(category) %>%
  count()

### Transforming Control Survey ###
# As control survey doesn't have intervention survey's question 3, I have to make a dummy Q3 to merge datasets
# First renaming the columns so they match 
control_survey <- 
  control_survey %>%
  rename(Q7 = Q6,
         Q6 = Q5,
         Q5 = Q4,
         Q4 = Q3)

# Making Dummy Q3
control_survey$Q3 <- "N/A"

# Reordering Columns
control_survey <- control_survey[,c("type","Q1","Q2","Q3","Q4","Q5","Q6","Q7")]

### Merging Intervention and Control ###
full_survey_raw <- rbind(intervention_survey, control_survey)

### Transforming Full Survey ###
### Renaming Q1 ###
# Goal: Have QSR Chain in 1 column rather than Quick Service Restaurant in Q1, and Chain/Independent in Q2

# Renaming Q1
full_survey_cleaned <- full_survey_raw %>%
  mutate(Q1 = case_when(
    Q1 == "Quick Service Restaurant" ~ "QSR",
    Q1 == "Full Service Restaurant" ~ "FSR",
    Q1 == "Drinking Place" ~ "Drink"))

# Combining Q1 and Q2 into a Category column
full_survey_cleaned$category <- paste(full_survey_cleaned$Q1, full_survey_cleaned$Q2)

#### Save and clean-up
write_csv(full_survey_cleaned, 'inputs/data/08_full-survey_cleaned.csv')


#### Prep dataset for logisitc regression ####

# Cloning the dataset
full_logit <- full_survey_cleaned

# Coding type
full_logit <- full_logit %>%
  mutate(type = case_when(
    type == "Treated" ~ 1,
    type == "Control" ~ 0))

# Coding Q1
full_logit <- full_logit %>%
  mutate(Q1 = case_when(
    Q1 == "QSR" ~ 1,
    Q1 == "FSR" ~ 2,
    Q1 == "Drink" ~ 3))

# Coding Q2
full_logit <- full_logit %>%
  mutate(Q2 = case_when(
    Q2 == "Chain" ~ 0,
    Q2 == "Independent" ~ 1))

# Coding Q3
full_logit <- full_logit %>%
  mutate(Q3 = case_when(
    Q3 == "Yes" ~ 1,
    Q3 == "No" ~ 0))

# Coding Q4
full_logit <- full_logit %>%
  mutate(Q4 = case_when(
    Q4 == "Yes" ~ 1,
    Q4 == "No" ~ 0))

# Coding Q5
full_logit <- full_logit %>%
  mutate(Q5 = case_when(
    Q5 == "Yes" ~ 1,
    Q5 == "No" ~ 0))

# Coding Q6
full_logit <- full_logit %>%
  mutate(Q6 = case_when(
    Q6 == "Yes" ~ 1,
    Q6 == "No" ~ 0))

# Coding Q7
full_logit <- full_logit %>%
  mutate(Q7 = case_when(
    Q7 == "Yes" ~ 1,
    Q7 == "No" ~ 0))

#### Save and clean-up
write_csv(full_logit, 'inputs/data/09_full-logit_cleaned.csv')
