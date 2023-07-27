
## load_data() Function Reads In All .csv files from a specified
## directory and performs basic cleaning


load_data <- function(folder_path){
  
  files <- list.files(path = folder_path, full.names = TRUE)
  
  if (any(!grepl("\\.csv$", files, ignore.case = TRUE))) {
    stop("Not All Data Is In .csv Format")
  }
  
  for (file_path in files) {
    file_name <- basename(file_path)
    data_frame_name <- str_replace(file_name, "\\.csv$", "")
    
    data <- read_csv(file_path)
    cleaned_data <- janitor::clean_names(data)
    
    assign(data_frame_name, cleaned_data, envir = .GlobalEnv)
  }
}

## load_data() Unit Testing

# test_that("load_data() Returns Error If Non .csv Included In Raw Data", {
# 
#   expect_error(load_data(here("data/test_fail_data/")))
#   
# }
# 
# )
# 
# test_that("load_data() Returns No Error If All Files Are .csv", {
#   
#   expect_no_error(load_data(here("data/test_pass_data/")))
#   
# }
# 
# )


