

library(readr)
library(rvest)

#----------------------------
# load historical data
#----------------------------

#interim_file <- "data-raw/interim_match_results_gaps_fixed_north-carolina_1950_2016.RDS"
#interim_file <- "data-raw/interim_match_results_north-carolina_1950_2016.RDS"
interim_file <- "data-raw/final_results_north-carolina_2018.RDS"
interim_file <- "data-raw/final_results_duke_2018.RDS"
df_history <- readRDS(interim_file)

#----------------------------
# scrap new data and format to the existing (historical data)
#----------------------------
school <- "duke" #"north-carolina"
new_years <- 2019


match_result_new <- take_snapshot(school, new_years)

# to prevent calling the site over and over again
saveRDS(match_result_new, file = paste0("data-raw/new_match_results_", school, "_", new_years[1], "_", new_years[length(new_years)], ".RDS"))
match_result_new <- readRDS(paste0("data-raw/new_match_results_", school, "_", new_years[1], "_", new_years[length(new_years)], ".RDS"))

new_yr <- match_result_new[[1]]
new_overall <- match_result_new[[2]]

new_yr_cleaned <- new_yr %>%
                      slice_layer() #%>%
                      #remove_mid_header() # why is this needed?

df_new <- final_prep(new_yr_cleaned)
df_new <- df_new %>% select(Season, Game_Date, Game_Day, Type, Where, Opponent_School, Result, Tm, Opp, OT)

#----------------------------
# append the new to the historical data
#----------------------------

df_results <- rbind(df_history, df_new)

#----------------------------------------
# save final results
#----------------------------------------

df_results %>% save_data(school, new_years)


