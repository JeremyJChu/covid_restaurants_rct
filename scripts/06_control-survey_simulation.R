#### Preamble ####
# Purpose: This script simulates the control responses to a survey about restaurants in Peel.
# Author: Jeremy Chu
# Data: 21 February 2021
# Contact: jeremychuj@gmail.com
# License: MIT
# Pre-requisites: 04_scoping-survey_simulation.R, 05_intervention-survey_simulation.R run. 
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
# Q2: Are you a chain, fast food, or independent restaurant?
# Q3: Would you be able to stay afloat this month without government subsidies?
# Q4: Are you receiving any government subsidies last month?
# Q5: Can you stay afloat when combined with government subsidies?
# Q6: Are you optimistic about your business if you were to operate without reopening for another month?

# Using Scoping Results Information, Respondents - Intervention group numbers = Control group numbers #
set.seed(912)
qsr_chain_ctrl_observations <- 378 - round(378/3)
qsr_independent_ctrl_observations <- 210 - round(210/3)
fsr_chain_ctrl_observations <- 127 - round(127/3)
fsr_independent_ctrl_observations <- 549 - round(549/3)
drink_chain_ctrl_observations <- 169 - round(169/3)
drink_independent_ctrl_observations <- 69 - round(69/3)

### Quick Service Control Chain Restaurants ###
set.seed(912)
qsr_ctrl_chain <- 
  tibble(type = rep("Control", qsr_chain_ctrl_observations),
    Q1 = sample(x = c(
    "Quick Service Restaurant"), #What Restaurant
    size = qsr_chain_ctrl_observations,
    replace = TRUE,
    prob = 1),
    Q2 = sample(x = c(
      "Chain"), #Chain or Independent
      size = qsr_chain_ctrl_observations,
      replace = TRUE,
      prob = 1),
    Q3 = sample(x = c( 
      "Yes", #Stay afloat without?
      "No"),
      size = qsr_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.55,0.45)),
    Q4 = sample(x = c( 
      "Yes", #Any Subsidies?
      "No"),
      size = qsr_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.8,0.2)),
    Q5 = sample(x =c(
      "Yes", #Stay afloat with subsidies?
      "No"),
      size = qsr_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.65,0.35)),
    Q6 = sample(x = c(
      "Yes", #Optimistic?
      "No"),
      size = qsr_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.4,0.6))
  )

### Quick Service Control Indie Restaurants ###
set.seed(912)
qsr_ctrl_indie <- 
  tibble(type = rep("Control", qsr_independent_ctrl_observations),
    Q1 = sample(x = c(
    "Quick Service Restaurant"), #What Restaurant
    size = qsr_independent_ctrl_observations,
    replace = TRUE,
    prob = 1),
    Q2 = sample(x = c(
      "Independent"), #Chain or Independent
      size = qsr_independent_ctrl_observations,
      replace = TRUE,
      prob = 1),
    Q3 = sample(x = c(
      "Yes", #Stay afloat without subsidies?
      "No"),
      size = qsr_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.05, 0.95)),
    Q4 = sample(x = c( 
      "Yes", #Any Subsidies?
      "No"),
      size = qsr_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.8,0.2)),
    Q5 = sample(x =c(
      "Yes", #Stay afloat with subsidies?
      "No"),
      size = qsr_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.15,0.85)),
    Q6 = sample(x = c(
      "Yes", #Optimistic?
      "No"),
      size = qsr_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.15,0.85))
  )

### Full Service Control Chain Restaurants ###
set.seed(912)
fsr_ctrl_chain <- 
  tibble(type = rep("Control", fsr_chain_ctrl_observations),
    Q1 = sample(x = c(
    "Full Service Restaurant"), #What Restaurant
    size = fsr_chain_ctrl_observations,
    replace = TRUE,
    prob = 1),
    Q2 = sample(x = c(
      "Chain"), #Chain or Independent
      size = fsr_chain_ctrl_observations,
      replace = TRUE,
      prob = 1),
    Q3 = sample(x = c(
      "Yes", #Stay afloat without subsidies?
      "No"),
      size = fsr_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.2, 0.8)),
    Q4 = sample(x = c( 
      "Yes", #Any Subsidies?
      "No"),
      size = fsr_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.8,0.2)),
    Q5 = sample(x =c(
      "Yes", #Stay afloat with subsidies?
      "No"),
      size = fsr_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.4,0.6)),
    Q6 = sample(x = c(
      "Yes", #Optimistic?
      "No"),
      size = fsr_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.4,0.6))
  )

### Full Service Control Independent Restaurants ###
set.seed(912)
fsr_ctrl_indie <- 
  tibble(type = rep("Control", fsr_independent_ctrl_observations),
    Q1 = sample(x = c(
    "Full Service Restaurant"), #What Restaurant
    size = fsr_independent_ctrl_observations,
    replace = TRUE,
    prob = 1),
    Q2 = sample(x = c(
      "Independent"), #Chain or Independent
      size = fsr_independent_ctrl_observations,
      replace = TRUE,
      prob = 1),
    Q3 = sample(x = c(
      "Yes", #Stay afloat without subsidies?
      "No"),
      size = fsr_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.2, 0.8)),
    Q4 = sample(x = c( 
      "Yes", #Any Subsidies?
      "No"),
      size = fsr_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.8,0.2)),
    Q5 = sample(x =c(
      "Yes", #Stay afloat with subsidies?
      "No"),
      size = fsr_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.25,0.75)),
    Q6 = sample(x = c(
      "Yes", #Optimistic?
      "No"),
      size = fsr_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.2,0.8))
  )
### Drinking Places - Control Chain ###
set.seed(912)
drinking_ctrl_chain <- 
  tibble(type = rep("Control", drink_chain_ctrl_observations),
    Q1 = sample(x = c(
    "Drinking Place"), #What Restaurant
    size = drink_chain_ctrl_observations,
    replace = TRUE,
    prob = 1),
    Q2 = sample(x = c(
      "Chain"), #Chain or Independent
      size = drink_chain_ctrl_observations,
      replace = TRUE,
      prob = 1),
    Q3 = sample(x = c(
      "Yes", #Stay afloat without subsidies?
      "No"),
      size = drink_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.5, 0.5)),
    Q4 = sample(x = c( 
      "Yes", #Any Subsidies?
      "No"),
      size = drink_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.6,0.4)),
    Q5 = sample(x =c(
      "Yes", #Stay afloat with subsidies?
      "No"),
      size = drink_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.6,0.4)),
    Q6 = sample(x = c(
      "Yes", #Optimistic?
      "No"),
      size = drink_chain_ctrl_observations,
      replace = TRUE,
      prob = c(0.8,0.2))
  )

### Drinking Places - Control Independent ###
set.seed(912)
drinking_ctrl_indie <- 
  tibble(type = rep("Control", drink_independent_ctrl_observations),
    Q1 = sample(x = c(
    "Drinking Place"), #What Restaurant
    size = drink_independent_ctrl_observations,
    replace = TRUE,
    prob = 1),
    Q2 = sample(x = c(
      "Independent"), #Chain or Independent
      size = drink_independent_ctrl_observations,
      replace = TRUE,
      prob = 1),
    Q3 = sample(x = c(
      "Yes", #Stay afloat without subsidies?
      "No"),
      size = drink_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.35, 0.65)),
    Q4 = sample(x = c( 
      "Yes", #Any Subsidies?
      "No"),
      size = drink_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.7,0.3)),
    Q5 = sample(x =c(
      "Yes", #Stay afloat with subsidies?
      "No"),
      size = drink_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.65,0.35)),
    Q6 = sample(x = c(
      "Yes", #Optimistic?
      "No"),
      size = drink_independent_ctrl_observations,
      replace = TRUE,
      prob = c(0.7,0.3))
  ) 

### Merge Datasets ###
control_survey <- rbind(qsr_ctrl_chain, qsr_ctrl_indie, fsr_ctrl_chain, fsr_ctrl_indie, drinking_ctrl_chain, drinking_ctrl_indie)

#### Save and clean-up
write_csv(control_survey, 'inputs/data/05_control_survey.csv')
