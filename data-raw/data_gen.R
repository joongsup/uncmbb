library(dplyr)
library(lubridate)
library(readr)
library(data.table)

#----------------------------------------
# slice off the extra list layer
#----------------------------------------

list_yrs_cleaned <- vector("list", length(list_yrs))
for (yr in seq_along(list_yrs)){
  list_yrs_cleaned[yr] <- list_yrs[[yr]]
}
names(list_yrs_cleaned) <- years

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
d <- formate_date(d)
d <- fix_where(d)

final_cols <- c("Season", "G", "Game_Date", "Game_Day", "Type",  "Where", "Opponent_School", "Opponent_Ranking", "Conf", "Result", "Tm", "Opp", "OT", "W", "L", "Streak", "Arena")
d <- as.data.frame(d)
d <- d[, final_cols]

#save(d, file = "data/matchresults.RData")
# note that manually saving to .RData didn't work
# .RData vs. .rda?
matchresults <- d
devtools::use_data(matchresults, overwrite = TRUE)
