
library(dplyr)
library(tidyr)
library(lubridate)
library(readr)
library(purrr)
library(stringr)
library(data.table)

source("data-raw/utils.R")

# add_new.R does same thing.
# 2018 and on, let's use new_season.R

#----------------------------------------
# take snapshot by running take_snapshot()
# one time for history, and then one for each new year
#----------------------------------------

#----------------------------------------
# for unc
#----------------------------------------

school <- "north-carolina"
year <- 2018 # new year to be added (around Apr/May every year)


# make sure there's no gap before adding to production data
new_season(school, year)
a <- readRDS(paste0("data-raw/match_results_", school, "_", year, ".RDS"))
b <- a %>% select(Season, Game_Date, Game_Day, Type, Where, Opponent_School, Result, Tm, Opp, OT) %>%
           arrange(Game_Date)

unc <- rbind(unc, b)
saveRDS(unc, file = paste0("data-raw/final_results_", school, "_", year, ".RDS"))
write.table(unc, file = paste0("data-raw/final_results_", school, "_", year, ".csv"), sep = ",", col.names = TRUE, row.names = FALSE, quote = FALSE)
devtools::use_data(unc, overwrite = TRUE)

#----------------------------------------
# for duke
#----------------------------------------

school <- "duke"
year <- 2018 # new year to be added (around Apr/May every year)

new_season(school, year)
a <- readRDS(paste0("data-raw/match_results_", school, "_", year, ".RDS"))
b <- a %>% select(Season, Game_Date, Game_Day, Type, Where, Opponent_School, Result, Tm, Opp, OT) %>%
  arrange(Game_Date)

duke <- rbind(duke, b)
saveRDS(duke, file = paste0("data-raw/final_results_", school, "_", year, ".RDS"))
write.table(duke, file = paste0("data-raw/final_results_", school, "_", year, ".csv"), sep = ",", col.names = TRUE, row.names = FALSE, quote = FALSE)
devtools::use_data(duke, overwrite = TRUE)
