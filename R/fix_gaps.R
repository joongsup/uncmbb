
library(dplyr)
library(readr)
library(lubridate)

# unc
df_base <- read_csv(file = "data-raw/interim_match_results_unc.csv", col_names = TRUE, col_types = cols(.default = col_character(), G = col_number(), Tm = col_number(), Opp = col_number(), W = col_number(), L = col_number(), Opponent_Ranking = col_number()))

df_base$Game_Date <- mdy(df_base$Game_Date)

df_gap <- read_csv(file = "data-raw/manual_inserts_unc.csv", col_names = TRUE, col_types = cols(.default = col_character(), G = col_number(), Tm = col_number(), Opp = col_number(), W = col_number(), L = col_number(), Opponent_Ranking = col_number()))

df_gap$Game_Date <- mdy(df_gap$Game_Date)

unc_results <- rbind(df_base, df_gap) %>% select(Season, Game_Date, Game_Day, Type, Where, Opponent_School, Result, Tm, Opp, OT) %>% arrange(Game_Date)

write.table(unc_results, file = "data-raw/results_final_unc.csv", sep = ",", col.names = TRUE, row.names = FALSE, quote = FALSE)
devtools::use_data(unc_results, overwrite = TRUE)

# duke
df_base_duke <- read_csv(file = "data-raw/interim_match_results_duke.csv", col_names = TRUE, col_types = cols(.default = col_character(), G = col_number(), Tm = col_number(), Opp = col_number(), W = col_number(), L = col_number(), Opponent_Ranking = col_number()))

duke_results <- df_base_duke %>% select(Season, Game_Date, Game_Day, Type, Where, Opponent_School, Result, Tm, Opp, OT) %>% arrange(Game_Date)

write.table(duke_results, file = "data-raw/results_final_duke.csv", sep = ",", col.names = TRUE, row.names = FALSE, quote = FALSE)
devtools::use_data(duke_results, overwrite = TRUE)
