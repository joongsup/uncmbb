

library(readr)

#----------------------------
# load historical data
#----------------------------

interim_file <- "data-raw/interim_match_results_gaps_fixed_north-carolina_1950_2016.RDS"
#interim_file <- "data-raw/interim_match_results_north-carolina_1950_2016.RDS"
df_history <- readRDS(interim_file)

#----------------------------
# scrap new data and format to the existing (historical data)
#----------------------------
school <- "north-carolina"
new_years <- 2017
#match_result_new <- take_snapshot(school, new_years)
#saveRDS(match_result_new, file = paste0("data-raw/new_match_results_", school, "_", new_years[1], "_", new_years[length(new_years)], ".RDS"))
match_result_new <- readRDS(paste0("data-raw/new_match_results_", school, "_", new_years[1], "_", new_years[length(new_years)], ".RDS"))

new_yr <- match_result_new[[1]]
new_overall <- match_result_new[[2]]

new_yr_cleaned <- new_yr %>%
                      slice_layer() %>%
                      remove_cols()

df_new <- final_prep(new_yr_cleaned)

#----------------------------
# append the new to the historical data
#----------------------------

df_results <- rbind(df_history, df_new)

#----------------------------------------
# save final results
#----------------------------------------
unc_results <- df_results %>%
                select(Season, Game_Date, Game_Day, Type, Where, Opponent_School, Result, Tm, Opp, OT) %>% arrange(Game_Date)

saveRDS(unc_results, file = paste0("data-raw/final_results_", school, "_", years[1], "_", new_years[length(new_years)], ".RDS"))
write.table(unc_results, file = paste0("data-raw/final_results_", school, "_", years[1], "_", new_years[length(new_years)], ".csv"), sep = ",", col.names = TRUE, row.names = FALSE, quote = FALSE)
devtools::use_data(unc_results, overwrite = TRUE)


