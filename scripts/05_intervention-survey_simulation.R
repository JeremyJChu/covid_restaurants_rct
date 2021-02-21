#### Preamble ####
# Purpose: This script simulates the intervention responses to a survey about restaurants in Peel.
# Author: Jeremy Chu
# Data: 21 February 2021
# Contact: jeremychuj@gmail.com
# License: MIT
# Pre-requisites: 04_scoping-survey_simulation.R run.
# Note: This is all simulated data. The percentage breakdown of each answer category was meticulously researched, 
#       referencing multiple real life surveys that can be found in the reference section of the actual paper.
#       Cited organizational surveys include Restaurants Canada, Andie.work, and Angus Reid. 
#       They helped inform the breakdown of QSR, FSR, and Drinking Places in Canada, as well as Chain vs Independent.
#       They also informed how restaurants felt reopening in the Summer, and how many restaurants were still at a loss even after reopening.
#       We simulated our responses using those surveys in mind to paint a realisitc picture of the restaurant industry, 
#       and what a RCT with an intervention centred around reopening would actually report.


#### Workspace setup ####
library(tidyverse)

#### Read data ####
scoping_survey <- read_csv(here("inputs","data","03_scoping_survey.csv"))

### Scoping Survey Results ###
scoping_results <-
  scoping_survey %>% 
  filter(Q5 != 'Permanently Closed') %>%
  filter(Q6 == 'Yes') %>%
  group_by(category) %>%
  count()

#### Simulate questions ####
# Q1: What do you categorize as?
# Q2: Are you a chain or independent restaurant?
# Q3: Did reopening have a positive effect on your business?
# Q4: Would you be able to stay afloat in April 2021 without government subsidies?
# Q5: Are you receiving any sources of government subsidies in April 2021?
# Q6: Would you be able to stay afloat in April 2021 without government subsidies?
# Q7: Are you optimistic about your business if you were to operate under these conditions for another month?

### Using Scoping Results Information, all divided by 3 because we are taking a third of each category as our treatment group ###
set.seed(912)
qsr_chain_observations <- round(378/3) 
qsr_independent_observations <- round(210/3)
fsr_chain_observations <- round(127/3)
fsr_independent_observations <- round(549/3)
drink_chain_observations <- round(169/3)
drink_independent_observations <- round(69/3)

### Quick Service Chain Restaurants ###
set.seed(912)
qsr_chain <- 
  tibble(type = rep("Treated", qsr_chain_observations),
         Q1 = sample(x = c(
           "Quick Service Restaurant"), #What Restaurant
           size = qsr_chain_observations,
           replace = TRUE,
           prob = 1),
         Q2 = sample(x = c(
           "Chain"), #Chain or Independent
           size = qsr_chain_observations,
           replace = TRUE,
           prob = 1),
         Q3 = sample(x = c( 
           "Yes", #Reopening Positive?
           "No"),
           size = qsr_chain_observations,
           replace = TRUE,
           prob = c(0.57,0.43)),
         Q4 = sample(x = c(
           "Yes", #Stay afloat without subsidies?
           "No"),
           size = qsr_chain_observations,
           replace = TRUE,
           prob = c(0.60, 0.40)),
         Q5 = sample(x = c( 
           "Yes", #Any Subsidies?
           "No"),
           size = qsr_chain_observations,
           replace = TRUE,
           prob = c(0.8,0.2)),
         Q6 = sample(x =c(
           "Yes", #Stay afloat with subsidies?
           "No"),
           size = qsr_chain_observations,
           replace = TRUE,
           prob = c(0.65,0.35)),
         Q7 = sample(x = c(
           "Yes", #Optimistic?
           "No"),
           size = qsr_chain_observations,
           replace = TRUE,
           prob = c(0.4,0.6))
  )

### Quick Service Indie Restaurants ###
set.seed(912)
qsr_indie <- 
  tibble(type = rep("Treated", qsr_independent_observations),
         Q1 = sample(x = c("Quick Service Restaurant"), #What Restaurant
                     size = qsr_independent_observations,
                     replace = TRUE,
                     prob = 1),
         Q2 = sample(x = c("Independent"), #Chain or Independent
                     size = qsr_independent_observations,
                     replace = TRUE,
                     prob = 1),
         Q3 = sample(x = c( 
           "Yes", #Reopening Positive?
           "No"),
           size = qsr_independent_observations,
           replace = TRUE,
           prob = c(0.35,0.65)),
         Q4 = sample(x = c(
           "Yes", #Stay afloat without subsidies?
           "No"),
           size = qsr_independent_observations,
           replace = TRUE,
           prob = c(0.1, 0.9)),
         Q5 = sample(x = c( 
           "Yes", #Any Subsidies?
           "No"),
           size = qsr_independent_observations,
           replace = TRUE,
           prob = c(0.8,0.2)),
         Q6 = sample(x =c(
           "Yes", #Stay afloat with subsidies?
           "No"),
           size = qsr_independent_observations,
           replace = TRUE,
           prob = c(0.22,0.78)),
         Q7 = sample(x = c(
           "Yes", #Optimistic?
           "No"),
           size = qsr_independent_observations,
           replace = TRUE,
           prob = c(0.23,0.73))
         )

### Full Service Chain Restaurants ###
set.seed(912)
fsr_chain <- 
  tibble(type = rep("Treated", fsr_chain_observations),
    Q1 = sample(x = c(
    "Full Service Restaurant"), #What Restaurant
    size = fsr_chain_observations,
    replace = TRUE,
    prob = 1),
    Q2 = sample(x = c(
      "Chain"), #Chain or Independent
      size = fsr_chain_observations,
      replace = TRUE,
      prob = 1),
    Q3 = sample(x = c( 
      "Yes", #Reopening Positive?
      "No"),
      size = fsr_chain_observations,
      replace = TRUE,
      prob = c(0.51,0.49)),
    Q4 = sample(x = c(
      "Yes", #Stay afloat without subsidies?
      "No"),
      size = fsr_chain_observations,
      replace = TRUE,
      prob = c(0.25, 0.75)),
    Q5 = sample(x = c( 
      "Yes", #Any Subsidies?
      "No"),
      size = fsr_chain_observations,
      replace = TRUE,
      prob = c(0.8,0.2)),
    Q6 = sample(x =c(
      "Yes", #Stay afloat with subsidies?
      "No"),
      size = fsr_chain_observations,
      replace = TRUE,
      prob = c(0.48,0.52)),
    Q7 = sample(x = c(
      "Yes", #Optimistic?
      "No"),
      size = fsr_chain_observations,
      replace = TRUE,
      prob = c(0.74,0.26))
  )

### Full Service Independent Restaurants ###
set.seed(912)
fsr_indie <- 
  tibble(type = rep("Treated", fsr_independent_observations),
    Q1 = sample(x = c(
    "Full Service Restaurant"), #What Restaurant
    size = fsr_independent_observations,
    replace = TRUE,
    prob = 1),
    Q2 = sample(x = c(
      "Independent"), #Chain or Independent
      size = fsr_independent_observations,
      replace = TRUE,
      prob = 1),
    Q3 = sample(x = c( 
      "Yes", #Reopening Positive?
      "No"),
      size = fsr_independent_observations,
      replace = TRUE,
      prob = c(0.51,0.49)),
    Q4 = sample(x = c(
      "Yes", #Stay afloat without subsidies?
      "No"),
      size = fsr_independent_observations,
      replace = TRUE,
      prob = c(0.25, 0.75)),
    Q5 = sample(x = c( 
      "Yes", #Any Subsidies?
      "No"),
      size = fsr_independent_observations,
      replace = TRUE,
      prob = c(0.8,0.2)),
    Q6 = sample(x =c(
      "Yes", #Stay afloat with subsidies?
      "No"),
      size = fsr_independent_observations,
      replace = TRUE,
      prob = c(0.35,0.65)),
    Q7 = sample(x = c(
      "Yes", #Optimistic?
      "No"),
      size = fsr_independent_observations,
      replace = TRUE,
      prob = c(0.52,0.48))
  )

### Drinking Places - Chain ###
set.seed(912)
drinking_chain <- 
  tibble(type = rep("Treated", drink_chain_observations),
    Q1 = sample(x = c(
    "Drinking Place"), #What Restaurant
    size = drink_chain_observations,
    replace = TRUE,
    prob = 1),
    Q2 = sample(x = c(
      "Chain"), #Chain or Independent
      size = drink_chain_observations,
      replace = TRUE,
      prob = 1),
    Q3 = sample(x = c( 
      "Yes", #Reopening Positive?
      "No"),
      size = drink_chain_observations,
      replace = TRUE,
      prob = c(0.8,0.2)),
    Q4 = sample(x = c(
      "Yes", #Stay afloat without subsidies?
      "No"),
      size = drink_chain_observations,
      replace = TRUE,
      prob = c(0.5, 0.5)),
    Q5 = sample(x = c( 
      "Yes", #Any Subsidies?
      "No"),
      size = drink_chain_observations,
      replace = TRUE,
      prob = c(0.6,0.4)),
    Q6 = sample(x =c(
      "Yes", #Stay afloat with subsidies?
      "No"),
      size = drink_chain_observations,
      replace = TRUE,
      prob = c(0.6,0.4)),
    Q7 = sample(x = c(
      "Yes", #Optimistic?
      "No"),
      size = drink_chain_observations,
      replace = TRUE,
      prob = c(0.8,0.2))
  )

### Drinking Places - Independent ###
set.seed(912)
drinking_indie <- 
  tibble(type = rep("Treated", drink_independent_observations),
    Q1 = sample(x = c(
    "Drinking Place"), #What Restaurant
    size = drink_independent_observations,
    replace = TRUE,
    prob = 1),
    Q2 = sample(x = c(
      "Independent"), #Chain or Independent
      size = drink_independent_observations,
      replace = TRUE,
      prob = 1),
    Q3 = sample(x = c( 
      "Yes", #Reopening Positive?
      "No"),
      size = drink_independent_observations,
      replace = TRUE,
      prob = c(0.7,0.3)),
    Q4 = sample(x = c(
      "Yes", #Stay afloat without subsidies?
      "No"),
      size = drink_independent_observations,
      replace = TRUE,
      prob = c(0.4, 0.6)),
    Q5 = sample(x = c( 
      "Yes", #Any Subsidies?
      "No"),
      size = drink_independent_observations,
      replace = TRUE,
      prob = c(0.7,0.3)),
    Q6 = sample(x =c(
      "Yes", #Stay afloat with subsidies?
      "No"),
      size = drink_independent_observations,
      replace = TRUE,
      prob = c(0.7,0.3)),
    Q7 = sample(x = c(
      "Yes", #Optimistic?
      "No"),
      size = drink_independent_observations,
      replace = TRUE,
      prob = c(0.8,0.2))
  ) 

### Merge Datasets ###
intervention_survey <- rbind(qsr_chain, qsr_indie, fsr_chain, fsr_indie, drinking_chain, drinking_indie)

#### Save and clean-up
write_csv(intervention_survey, 'inputs/data/04_intervention_survey.csv')