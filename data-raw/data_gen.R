library(dplyr)
library(lubridate)
library(readr)
library(data.table)
library(purrr)
library(stringr)
library(tidyr)


#----------------------------------------
# take snapshot (one time)
# by running take_snapshot.R
# and the function w/ same name
#----------------------------------------

match_result_list <- take_snapshot("duke", 1950:2017)
list_yrs <- match_result_list[[1]]
overall_yrs <- match_result_list[[2]]

#----------------------------------------
# slice off the extra list layer
#----------------------------------------

list_yrs_cleaned <- vector("list", length(list_yrs))
for (yr in seq_along(list_yrs)){
  list_yrs_cleaned[yr] <- list_yrs[[yr]]
}
names(list_yrs_cleaned) <- names(list_yrs)

#----------------------------------------
# last 2 seasons (2015, 2016) have
# 2 additional fields (Time and Network)
#----------------------------------------

column_cnt <- list_yrs_cleaned %>% map_int(function(x) length(x))
for (num in seq_along(column_cnt)){
  if (column_cnt[num] > 14){
    list_yrs_cleaned[[num]] <- list_yrs_cleaned[[num]][, c(1, 2, 5:16)]
  }
}

#----------------------------------------
# final prep
#----------------------------------------

d <- list_yrs_cleaned %>% map(function(x) add_column_name(x))
d <- d %>% map(function(x) remove_mid_header(x))
d <- rbindlist(d, idcol = "Season")

d <- extract_ranking(d)
d <- fix_type(d)
d <- fix_date(d)
d <- fix_where(d)
d <- na_empty(d)

final_cols <- c("Season", "G", "Game_Date", "Game_Day", "Type",  "Where", "Opponent_School", "Opponent_Ranking", "Conf", "Result", "Tm", "Opp", "OT", "W", "L", "Streak", "Arena")
d <- as.data.frame(d)
d <- d[, final_cols]

#save(d, file = "data/matchresults.RData")
# note that manually saving to .RData didn't work
# .RData vs. .rda?
# matchresults <- d # for unc
#devtools::use_data(matchresults, overwrite = TRUE)
#write.table(matchresults, file = "data-raw/matchresults.csv", col.names = TRUE, row.names = FALSE, quote = FALSE, sep = ",")

dukeresults <- d
#write.table(dukeresults, file = "data-raw/dukeresults.csv", col.names = TRUE, row.names = FALSE, quote = FALSE, sep = ",")

#----------------------------------------
# overall records from other source
# including matches against non Div-1 schools
#----------------------------------------

a <- overall_yrs %>% map(function(x) str_split(x, " ")) %>% map_chr(function(x) x[[1]][[2]]) %>% as.data.frame(optional = TRUE, stringsAsFactors = FALSE)
a <- data.frame(year = row.names(a), overall = a[1], row.names = NULL)
a <- a %>% separate(overall, into = c("WINS", "LOSES"), convert = TRUE)
a$year <- as.character(a$year)

b <- d %>% group_by(Season) %>% summarize(wins = max(W), loses = max(L))
a <- a %>% inner_join(b, by = c("year" = "Season"))
overallrecords <- a %>% mutate(gaps_wins = WINS - wins, gaps_loses = LOSES - loses)

# there are 11 seasons with missing games (won matches)
# there are 2 seasons with missing games (lost matches)
#devtools::use_data(overallrecords, overwrite = TRUE)
overallrecords %>% filter(gaps_loses > 0 | gaps_wins > 0)
