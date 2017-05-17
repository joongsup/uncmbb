
library(dplyr)
library(tidyr)
library(lubridate)
library(readr)
library(purrr)
library(stringr)
library(data.table)

source("data-raw/utils.R")
#----------------------------------------
# take snapshot by running take_snapshot()
# one time for history, and then one for each new year
#----------------------------------------

school <- "north-carolina"
years <- 1950:2016

#match_result_list <- take_snapshot(school, years)
#saveRDS(match_result_list, file = paste0("data-raw/initial_match_results_", school, "_", years[1], "_", years[length(years)], ".RDS"))
match_result_list <- readRDS(paste0("data-raw/initial_match_results_", school, "_", years[1], "_", years[length(years)], ".RDS"))

list_yrs <- match_result_list[[1]]
overall_yrs <- match_result_list[[2]]

#----------------------------------------
# slice off the extra list layer
# and remove extra columns
#----------------------------------------
list_yrs_cleaned <- list_yrs %>%
                      slice_layer() %>%
                      remove_cols()

#----------------------------------------
# final prep
#----------------------------------------

d <- final_prep(list_yrs_cleaned)

#----------------------------------------
# check gaps
#----------------------------------------

check_gaps(d, overall_yrs)

#----------------------------------------
# save interim results
#----------------------------------------

saveRDS(d, file = paste0("data-raw/interim_match_results_", school, "_", years[1], "_", years[length(years)], ".RDS"))
write.table(d, file = paste0("data-raw/interim_match_results_", school, "_", years[1], "_", years[length(years)], ".csv"), col.names = TRUE, row.names = FALSE, quote = FALSE, sep = ",")


