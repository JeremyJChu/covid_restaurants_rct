#### Preamble ####
# Purpose: This script is used to create a dataset on the number of restaurants in Peel, just to have a feel as to a very rough breakdown on the types of restaurants in the region.
# Author: Jeremy Chu
# Data: 21 February 2021
# Contact: jeremychuj@gmail.com
# License: MIT
# Pre-requisites: 
# - None

#### Workspace setup ####
library(tidyverse)
library(here)

#### Make Dataset ###
# Information manually inputted from https://www.mississauga.com/peel-directory/c-restaurants-dining/ as website is unscrapable using html. 
# The order, categorization, and values are 1-1 copied down. 

peel_restaurants <- 
  tibble(
    'restaurants' = 2393,
    'pizza_restaurants' = 297,
    'foods-take_out' = 153,
    'coffee_shops' = 145,
    'restaurants-sandwich_shops' = 143,
    'coffee_houses' = 126,
    'banquet_rooms' = 121,
    'restaurants_italian' = 103,
    'lounges-licensed' = 89
  )

write_csv(peel_restaurants, here('inputs/data/01_peel-restaurants_raw.csv'))

#### Data Cleaning ####
peel_restaurants <- read_csv(here('inputs/data/01_peel-restaurants.csv'))

# Based on observation, we can see some oddities. What are pizza_restaurants? Foods-Take_Out? Why are there coffee shops and coffee houses?
# Bascially it looks like all food stuffs fall under restaurants, in fact we are seeing duplicate entries. 
# Meanwhile coffee shops and coffee houses don't seem to overlap. As this is a rough estimate, the dataset would look instead like

peel_restaurants_2 <-
  tibble(
    type = c('total_restaurants','coffee_shops','banquet_rooms','bars_lounges','remainder'),
    number = c(2393,(145 + 126),121,89,(2393 - (145+126+121+89))),
    region = rep('Peel',5),
    percentage_total = c(2393/2393,(145 + 126)/2393,121/2393,89/2393,(2393 - (145+126+121+89))/2393)
  )

write_csv(peel_restaurants_2, here('inputs/data/02_peel-restaurants_cleaned.csv'))
