# Load Libraries

library(tidyverse)
library(testthat)
library(janitor)
library(here)

# Load Functions

source(here("scripts/functions.R"))

# Read In Raw Data

load_data(here("data/raw_data"))

# Read In Raw Data

# admissions_health_board <- read_csv(here("data/raw_data/health_board_trend.csv"))
# admissions_scotland <- read_csv(here("data/raw_data/scotland_trend.csv"))
# admissions_age_sex <- read_csv(here("data/raw_data/age_sex.csv"))
# 
# # Clean Data
# 
# admissions_health_board_clean <- admissions_health_board %>% clean_names()
# admissions_scotland_clean <- admissions_scotland %>% clean_names()
# admissions_age_sex_clean <- admissions_age_sex %>% clean_names()

## Map Health Board Names To Health Board Alphanumeric Identifiers

### Admissions by Health Board

admissions_health_board_clean <- health_board_trend %>% 
  mutate(hbt = case_when(
    hbt == "S08000015" ~ "NHS Ayrshire and Arran",
    hbt == "S08000016" ~ "NHS Borders",
    hbt == "S08000017" ~ "NHS Dumfries and Galloway",
    hbt == "S08000018" ~ "NHS Fife",
    hbt == "S08000019" ~ "NHS Forth Valley",
    hbt == "S08000020" ~ "NHS Grampian",
    hbt == "S08000021" ~ "NHS Greater Glasgow and Clyde",
    hbt == "S08000022" ~ "NHS Highland",
    hbt == "S08000023" ~ "NHS Lanarkshire",
    hbt == "S08000024" ~ "NHS Lothian",
    hbt == "S08000025" ~ "NHS Orkney",
    hbt == "S08000026" ~ "NHS Shetland",
    hbt == "S08000027" ~ "NHS Tayside",
    hbt == "S08000028" ~ "NHS Western Isles",
    hbt == "S08000029" ~ "NHS Fife",
    hbt == "S08000030" ~ "NHS Tayside",
    hbt == "S08000031" ~ "NHS Greater Glasgow and Clyde",
    hbt == "S08000032" ~ "NHS Lanarkshire",
    hbt == "S92000003" ~ "All of Scotland",
    hbt == "S27000001" ~ "Non-NHS Provider",
    hbt == "SB0802" ~ "State Hospitals Board for Scotland")) %>% 
    rename("health_board" = "hbt")

### Admissions by Country

admissions_scotland_clean <- scotland_trend %>% 
  mutate(country = case_when(
    country == "S92000003" ~ "All of Scotland")) %>% 
    rename("health_board" = "country")

### Admissions by Age & Sex

admissions_age_sex_clean <- age_sex %>% 
  mutate(hbr = case_when(
    hbr == "S08000015" ~ "NHS Ayrshire and Arran",
    hbr == "S08000016" ~ "NHS Borders",
    hbr == "S08000017" ~ "NHS Dumfries and Galloway",
    hbr == "S08000018" ~ "NHS Fife",
    hbr == "S08000019" ~ "NHS Forth Valley",
    hbr == "S08000020" ~ "NHS Grampian",
    hbr == "S08000021" ~ "NHS Greater Glasgow and Clyde",
    hbr == "S08000022" ~ "NHS Highland",
    hbr == "S08000023" ~ "NHS Lanarkshire",
    hbr == "S08000024" ~ "NHS Lothian",
    hbr == "S08000025" ~ "NHS Orkney",
    hbr == "S08000026" ~ "NHS Shetland",
    hbr == "S08000027" ~ "NHS Tayside",
    hbr == "S08000028" ~ "NHS Western Isles",
    hbr == "S08000029" ~ "NHS Fife",
    hbr == "S08000030" ~ "NHS Tayside",
    hbr == "S08000031" ~ "NHS Greater Glasgow and Clyde",
    hbr == "S08000032" ~ "NHS Lanarkshire",
    hbr == "S92000003" ~ "All of Scotland",
    hbr == "S27000001" ~ "Non-NHS Provider",
    hbr == "SB0802" ~ "State Hospitals Board for Scotland")) %>%
  drop_na(hbr) %>% 
  rename("health_board" = "hbr")
           
## Filter for SMR01 + SMR04 Total Only

admissions_health_board_clean <- admissions_health_board_clean %>% 
  filter(dataset != "SMR04",
         number_of_hospital_residents != ":")

admissions_scotland_clean <- admissions_scotland_clean %>% 
  filter(dataset != "SMR04",
         number_of_hospital_residents != ":")

admissions_age_sex_clean <- admissions_age_sex_clean %>% 
  filter(dataset == "Total")

## Select Only Columns That Will Be Used In App

admissions_health_board_clean <- admissions_health_board_clean %>% 
  select(-c(id, dataset, dataset_qf, number_of_hospital_residents_qf))

admissions_scotland_clean <- admissions_scotland_clean %>% 
  select(-c(id, dataset, dataset_qf, number_of_hospital_residents_qf))

admissions_age_sex_clean <- admissions_age_sex_clean %>% 
  select(-c(id, hbrqf, dataset, dataset_qf))

## Tidy Age Strings

admissions_age_sex_clean <- admissions_age_sex_clean %>% 
  mutate(age_group = str_remove(age_group, "years"),
         age_group = str_remove(age_group, "and over"),
         age_group = str_trim(age_group),
         age_group = recode(age_group, "65plus" = "65+"))

## Join Datasets

admissions_clean <- bind_rows(admissions_health_board_clean, 
                              admissions_scotland_clean)

## Format Year Column

pattern_to_remove <- "\\/+[0-9]{2}"

admissions_clean <- admissions_clean %>% 
  mutate(financial_year = str_remove(financial_year,
                                     pattern_to_remove))

admissions_age_sex_clean <- admissions_age_sex_clean %>% 
  mutate(financial_year = str_remove(financial_year,
                                     pattern_to_remove))

## Write Clean Data To .csv For Use In App

write_csv(admissions_clean, 
          here("data/clean_data/admissions_clean.csv"))

write_csv(admissions_age_sex_clean, 
          here("data/clean_data/admissions_age_sex_clean.csv"))

## Clear Environment

rm(admissions_clean)
rm(health_board_trend)
rm(admissions_health_board_clean)
rm(scotland_trend)
rm(admissions_scotland_clean)
rm(age_sex)
rm(admissions_age_sex_clean)
rm(pattern_to_remove)
