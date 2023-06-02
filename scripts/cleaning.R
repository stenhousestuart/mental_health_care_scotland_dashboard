# Load Libraries

library(tidyverse)
library(janitor)
library(here)

# Read In Raw Data

admissions_health_board <- read_csv(here("data/raw_data/health_board_trend.csv"))
admissions_scotland <- read_csv(here("data/raw_data/scotland_trend.csv"))
admissions_age_sex <- read_csv(here("data/raw_data/age_sex.csv"))

length_of_stay <- read_csv(here("data/raw_data/length_of_stay.csv"))
diagnosis <- read_csv(here("data/raw_data/diagnosis.csv"))
suicide <- read_csv(here("data/raw_data/suicide.csv"))

# Clean Data

admissions_health_board_clean <- admissions_health_board %>% clean_names()
admissions_scotland_clean <- admissions_scotland %>% clean_names()
admissions_age_sex_clean <- admissions_age_sex %>% clean_names()

length_of_stay_clean <- length_of_stay %>% clean_names()
diagnosis_clean <- diagnosis %>% clean_names()
suicide_clean <- suicide %>% clean_names()

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

### Admissions by Age & Sex

admissions_age_sex_clean <- admissions_age_sex_clean %>% 
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

### Diagnosis

diagnosis_clean <- diagnosis_clean %>% 
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

### Suicide

suicide_clean <- suicide_clean %>% 
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

length_of_stay_clean <- length_of_stay_clean %>%
  filter(dataset == "Total")

diagnosis_clean <- diagnosis_clean %>%
  filter(dataset == "Total")

## Select Only Columns That Will Be Used In App

admissions_health_board_clean <- admissions_health_board_clean %>% 
  select(-c(id, dataset, dataset_qf, number_of_hospital_residents_qf))

admissions_scotland_clean <- admissions_scotland_clean %>% 
  select(-c(id, dataset, dataset_qf, number_of_hospital_residents_qf))

admissions_age_sex_clean <- admissions_age_sex_clean %>% 
  select(-c(id, hbrqf, dataset, dataset_qf))

length_of_stay_clean <- length_of_stay_clean %>%
  select(-c(id, hbtqf, dataset, dataset_qf))

diagnosis_clean <- diagnosis_clean %>%
  select(-c(id, hbtqf, dataset, dataset_qf))

suicide_clean <- suicide_clean %>% 
  select(-c(id, hbrqf, sex_qf))

## Map ICD 10 Codes

diagnosis_clean <- diagnosis_clean %>% 
  mutate(diagnosis_grouping = case_when(
    icd10codes == "F60 - F69" ~ "Disorders of Adult Personality & Behaviour",
    icd10codes == "F10 - F19" ~ "Mental & Behavioural Disorders Due to Psychoactive Ssubstance Use",
    icd10codes == "F30 - F39" ~ "Mood Disorders",
    icd10codes == "F40 - F49" ~ "Neurotic, Stress-related & Somatoform Disorders",
    icd10codes == "F00 - F09 or Chapter G and second position F00" ~ "Organic, Including Symptomatic Mental Disorders",
    icd10codes == "F50 - F59, F70 - F99" ~ "Other Selected Diagnoses Principally Affecting Children & Young People",
    icd10codes == "F20 - F29" ~ "Schizophrenia, Schizotypal & Delusional Disorders"))

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

length_of_stay_clean <- length_of_stay_clean %>%
  mutate(financial_year = str_remove(financial_year,
                                     pattern_to_remove))

diagnosis_clean <- diagnosis_clean %>%
  mutate(financial_year = str_remove(financial_year,
                                     pattern_to_remove))

## Write Clean Data To .csv For Use In App

write_csv(admissions_clean, 
          here("data/clean_data/admissions_clean.csv"))

write_csv(admissions_age_sex_clean, 
          here("data/clean_data/admissions_age_sex_clean.csv"))

write_csv(length_of_stay_clean, 
          here("data/clean_data/length_of_stay_clean.csv"))

write_csv(diagnosis_clean, 
          here("data/clean_data/diagnosis_clean.csv"))

write_csv(suicide_clean, 
          here("data/clean_data/suicide_clean.csv"))

## Clear Environment

rm(admissions_clean)
rm(admissions_health_board)
rm(admissions_health_board_clean)
rm(admissions_scotland)
rm(admissions_scotland_clean)
rm(pattern_to_remove)
rm(length_of_stay)
rm(length_of_stay_clean)
rm(diagnosis)
rm(diagnosis_clean)
rm(suicide)
rm(suicide_clean)
rm(admissions_age_sex)
rm(admissions_age_sex_clean)
