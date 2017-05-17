
library(dplyr)
library(readr)
library(lubridate)

# unc

#-------------------------------
# read base
#-------------------------------
school <- "north-carolina"
years <- 1950:2016
df_base <- readRDS(paste0("data-raw/interim_match_results_", school, "_", years[1], "_", years[length(years)], ".RDS"))

#-------------------------------
# read gap and convert date type
#-------------------------------

df_gap <- read_csv(file = "data-raw/manual_inserts_unc.csv", col_names = TRUE, col_types = cols(.default = col_character(), G = col_number(), Tm = col_number(), Opp = col_number(), W = col_number(), L = col_number(), Opponent_Ranking = col_number()))
df_gap$Game_Date <- mdy(df_gap$Game_Date)

#-------------------------------
# read gap and convert date type
#-------------------------------
df_final <- rbind(df_base, df_gap) #%>%
        #select(Season, Game_Date, Game_Day, Type, Where, Opponent_School, Result, Tm, Opp, OT) %>% arrange(Game_Date)

saveRDS(df_final, paste0("data-raw/interim_match_results_gaps_fixed_", school, "_", years[1], "_", years[length(years)], ".RDS"))
write.table(df_final, file = paste0("data-raw/interim_match_results_gap_fixed_", school, "_", years[1], "_", years[length(years)], ".csv"), sep = ",", col.names = TRUE, row.names = FALSE, quote = FALSE)


