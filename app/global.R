# Load Libraries

library(shiny)
library(tidyverse)
library(here)
library(shinyWidgets)
library(bslib)
library(gt)
library(gtExtras)

# Read In Clean Data

admissions <- read_csv(here("data/clean_data/admissions_clean.csv"))
admissions_age_sex <- read_csv(here("data/clean_data/admissions_age_sex_clean.csv"))

# Set Input Choices

health_board_choice <- admissions %>% 
  distinct(health_board) %>%
  arrange(health_board) %>% 
  pull()

age_choice <- admissions_age_sex %>% 
  distinct(age_group) %>%
  pull()

colour_scheme <- c("#01497c", "#2196f3", "#a9d6e5", "#5a189a", "#0d1b2a")