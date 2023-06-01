# Load Libraries

library(shiny)
library(tidyverse)
library(here)
library(shinyWidgets)
library(bslib)

# Read In Clean Data

admissions <- read_csv(here("data/clean_data/admissions_clean.csv"))
length_of_stay <- read_csv(here("data/clean_data/length_of_stay_clean.csv"))
diagnosis <- read_csv(here("data/clean_data/diagnosis_clean.csv"))
suicide <- read_csv(here("data/clean_data/suicide_clean.csv"))

# Set Input Choices

health_board_choice <- admissions %>% 
  distinct(health_board) %>%
  arrange(health_board) %>% 
  pull()

data_view_options <- c("Total Admissions" = "total_admissions",
                    "Length of Stay" = "length_of_stay")
