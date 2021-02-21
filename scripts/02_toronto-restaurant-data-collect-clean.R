#### Preamble ####
# Purpose: This script is used to create a dataset on restaurants in Toronto, just to have a feel as to a very rough breakdown on the types of restaurants in the region.
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
# Information manually inputted from https://www.toronto.com/toronto-directory/c-restaurants-dining/ as website is unscrapable using html. 
# The order, categorization, and values are 1-1 copied down. 
# Based on observation, we can see some oddities. What are pizza_restaurants? Foods-Take_Out? Why are there coffee shops and coffee houses?
# Bascially it looks like all food stuffs fall under restaurants, in fact we are seeing duplicate entries. 
# Restaurants-Italian for example also fall into Restaurants itself
# Meanwhile coffee shops and coffee houses don't seem to overlap. As this is a rough estimate, the dataset would look instead like

toronto_restaurants <-
  tibble(
    type = c('total_restaurants','coffee_shops','banquet_rooms','bars_lounges','remainder'),
    number = c(7564,(473 + 319 + 446),201,250,(7564 - (473 + 319 + 446 + 201 + 250))),
    region = rep('Toronto',5),
    percentage_total = c(7564/7564,(473 + 319 + 446)/7564,201/7564,250/7564,(7564 - (473 + 319 + 446 + 201 + 250))/7564)
  )

# Save and write data
write_csv(toronto_restaurants, here('inputs/data/06_toronto-restaurants_cleaned.csv'))
