#### Preamble ####
# Purpose: This script is used to create a dataset on population numbers on the 4 hotspots vs the rest of Ontario. Numbers Googled.
# Data: 21 February 2021
# Contact: jeremychuj@gmail.com
# License: MIT
# Pre-requisites: 
# - None

#### Workspace setup ####
library(tidyverse)
library(here)

#### Make Dataset ###
hotspots <-
  tibble(location = c("peel","toronto","york","ottawa","all_hotspots","rest_of_ontario"),
         population = c(1.382,2.93,1.11,0.995,6.417,8.153))

#### Write Data ####
write_csv(hotspots, here('inputs/data/07_hotspots.csv'))