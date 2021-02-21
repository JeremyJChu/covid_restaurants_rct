#### Preamble ####
# Purpose: This script simulates the responses to our scoping survey about restaurants in Peel to calculate our sample size.
# Author: Jeremy Chu
# Data: 21 February 2021
# Contact: jeremychuj@gmail.com
# License: MIT
# Pre-requisites: 
# - None


#### Workspace setup ####
library(tidyverse)

#### Simulate questions ####
# Q3: What do you categorize as? 
# Q4: Are you a chain or independent restaurant?
# Q5: What are your current state of operations?
# Q6: If given vaccines for your staff, do you consent to signing up for reopening under Ontario's orange level restrictions?
# Q7: How much staff would you be employing for April 2021 if you were allowed to reopen?

set.seed(912)
number_of_restaurants_scoped <- 1912+121
number_of_drinks_scoped <- 271+89

### Quick Service Restaurants ###
set.seed(912)
qsr_observations <- number_of_restaurants_scoped * 0.4
qsr <- 
  tibble(Q3 = sample(x = c(
           "Quick Service Restaurant"),
           size = qsr_observations,
           replace = TRUE,
           prob = 1),
         Q4 = sample(x = c(
           "Chain",
           "Independent"),
           size = qsr_observations,
           replace = TRUE,
           prob = c(0.66,0.34)),
         Q5 = sample(x = c(
           "Offering takeout/delivery",
           "Temporarily Closed",
           "Permanently Closed"),
           size = qsr_observations,
           replace = TRUE,
           prob = c(0.9,0.05,0.05)))

# Since permanently closed cannot answer, they get assigned N/A instead for these questions 
qsr <- qsr %>%
  mutate(Q6 = ifelse(Q5 != "Permanently Closed", 
                     sample(x = c("Yes",
                                  "No"),
                            size = qsr_observations, 
                            replace = TRUE, 
                            prob = c(0.75,0.25)),
                     "N/A"))   

qsr <- qsr %>%
  mutate(Q7 = ifelse(Q5 != "Permanently Closed", 
                     rpois(n = qsr_observations, lambda = 10),
                     "N/A")) 

# Turning staff hire numbers to numeric
qsr$Q7 <- as.numeric(qsr$Q7)

### Full Service Restaurants ###
set.seed(912)
fsr_observations <- number_of_restaurants_scoped * 0.5
fsr <- 
  tibble(Q3 = sample(x = c(
           "Full Service Restaurant"),
           size = fsr_observations,
           replace = TRUE,
           prob = 1),
         Q4 = sample(x = c(
           "Chain",
           "Independent"),
           size = fsr_observations,
           replace = TRUE,
           prob = c(0.17,0.83)),
         Q5 = sample(x = c(
           "Offering takeout/delivery",
           "Temporarily Closed",
           "Permanently Closed"),
           size = fsr_observations,
           replace = TRUE,
           prob = c(0.8,0.1,0.1)))

# Since permanently closed cannot answer, they get assigned N/A instead for these questions 
fsr <- fsr %>%
  mutate(Q6 = ifelse(Q5 != "Permanently Closed", 
                     sample(x = c("Yes",
                                  "No"),
                            size = fsr_observations, 
                            replace = TRUE, 
                            prob = c(0.75,0.25)),
                     "N/A"))     
fsr <- fsr %>%
  mutate(Q7 = ifelse(Q5 != "Permanently Closed", 
                     rpois(n = fsr_observations, lambda = 7),
                     "N/A")) 

# Turning staff hire numbers to numeric
fsr$Q7 <- as.numeric(fsr$Q7)

### Drinking Places ###
set.seed(912)
drinking_observations <- number_of_drinks_scoped 
drinking <- 
  tibble(Q3 = sample(x = c(
           "Drinking Place"),
           size = drinking_observations,
           replace = TRUE,
           prob = 1),
         Q4 = sample(x = c(
           "Chain",
           "Independent"),
           size = drinking_observations,
           replace = TRUE,
           prob = c(0.7,0.3)),
         Q5 = sample(x = c(
           "Offering takeout/delivery",
           "Temporarily Closed",
           "Permanently Closed"),
           size = drinking_observations,
           replace = TRUE,
           prob = c(0.8,0.1,0.1)))

# Since permanently closed cannot answer, they get assigned N/A instead for these questions 
drinking <- drinking %>%
  mutate(Q6 = ifelse(Q5 != "Permanently Closed", 
                     sample(x = c("Yes",
                                  "No"),
                            size = drinking_observations, 
                            replace = TRUE, 
                            prob = c(0.75,0.25)),
                     "N/A"))     
drinking <- drinking %>%
  mutate(Q7 = ifelse(Q5 != "Permanently Closed", 
                     rpois(n = drinking_observations, lambda = 5),
                     "N/A")) 

# Turning staff hire numbers to numeric
drinking$Q7 <- as.numeric(drinking$Q7)

### Caterers ###
set.seed(912)
cater_observations <- number_of_restaurants_scoped * 0.1
cater <- 
  tibble(Q3 = sample(x = c(
           "Caterer"),
           size = cater_observations,
           replace = TRUE,
           prob = 1),
         Q4 = sample(x = c(
           "Chain",
           "Independent"),
           size = cater_observations,
           replace = TRUE,
           prob = c(0.5,0.5)),
         Q5 = sample(x = c(
           "Offering takeout/delivery",
           "Temporarily Closed",
           "Permanently Closed"),
           size = cater_observations,
           replace = TRUE,
           prob = c(0.8,0.1,0.1)))

# Caterers can't reopen so assigned N/A/
cater <- cater %>%
  mutate(Q6 = "N/A")    
cater <- cater %>%
  mutate(Q7 = "N/A") 

### Merge Datasets ###
scoping_survey <- rbind(qsr,fsr,drinking,cater)

#### Save and clean-up
write_csv(scoping_survey, 'inputs/data/03_scoping_survey.csv')