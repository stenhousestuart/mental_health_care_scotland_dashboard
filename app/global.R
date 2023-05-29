# Load Libraries

library(shiny)
library(tidyverse)
library(here)

# Read In Clean Data

admissions <- read_csv(here("data/clean_data/admissions_clean.csv"))

# Set-up Input Choices from Data

year_choice <- admissions %>% 
  distinct(financial_year)

health_board_choice <- admissions %>% 
  distinct(health_board)