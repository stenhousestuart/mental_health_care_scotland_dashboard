# Load Libraries

library(tidyverse)
library(janitor)
library(here)

# Read In Raw Data

admissions_health_board <- read_csv(here("data/raw_data/health_board_trend.csv"))
admissions_scotland <- read_csv(here("data/raw_data/scotland_trend.csv"))
length_of_stay <- read_csv(here("data/raw_data/length_of_stay.csv"))

# Clean Data

admissions_health_board_clean <- admissions_health_board %>% clean_names()
admissions_scotland_clean <- admissions_scotland %>% clean_names()
length_of_stay_clean <- length_of_stay %>% clean_names()

## Map Health Board Names To Health Board Alphanumeric Identifiers

### Admissions by Health Board

admissions_health_board_clean <- admissions_health_board_clean %>% 
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

admissions_scotland_clean <- admissions_scotland_clean %>% 
  mutate(country = case_when(
    country == "S92000003" ~ "All of Scotland")) %>% 
    rename("health_board" = "country")

### Length of Stay

length_of_stay_clean <- length_of_stay_clean %>%
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
    hbt == "SB0801" ~ "The Golden Jubilee National Hospital",
    hbt == "SB0802" ~ "State Hospitals Board for Scotland")) %>% 
  rename("health_board" = "hbt")
           
## Filter for SMR01 + SMR04 Total Only

admissions_health_board_clean <- admissions_health_board_clean %>% 
  filter(dataset != "SMR04",
         number_of_hospital_residents != ":")

admissions_scotland_clean <- admissions_scotland_clean %>% 
  filter(dataset != "SMR04",
         number_of_hospital_residents != ":")

length_of_stay_clean <- length_of_stay_clean %>%
  filter(dataset == "Total")

## Select Only Columns That Will Be Used In App

admissions_health_board_clean <- admissions_health_board_clean %>% 
  select(-c(id, dataset, dataset_qf, number_of_hospital_residents_qf))

admissions_scotland_clean <- admissions_scotland_clean %>% 
  select(-c(id, dataset, dataset_qf, number_of_hospital_residents_qf))

length_of_stay_clean <- length_of_stay_clean %>%
  select(-c(id, hbtqf, dataset, dataset_qf))

## Join Datasets

admissions_clean <- bind_rows(admissions_health_board_clean, 
                              admissions_scotland_clean)

## Format Year Column

pattern_to_remove <- "\\/+[0-9]{2}"

admissions_clean <- admissions_clean %>% 
  mutate(financial_year = str_remove(financial_year,
                                     pattern_to_remove))

length_of_stay_clean <- length_of_stay_clean %>%
  mutate(financial_year = str_remove(financial_year,
                                     pattern_to_remove))

## Write Clean Data To .csv For Use In App

write_csv(admissions_clean, 
          here("data/clean_data/admissions_clean.csv"))

write_csv(length_of_stay_clean, 
          here("data/clean_data/length_of_stay_clean.csv"))

## Clear Environment

rm(admissions_clean)
rm(admissions_health_board)
rm(admissions_health_board_clean)
rm(admissions_scotland)
rm(admissions_scotland_clean)
rm(pattern_to_remove)
rm(length_of_stay)
rm(length_of_stay_clean)
