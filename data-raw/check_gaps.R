
library(dplyr)
library(tidyr)


#----------------------------------------
# take snapshot (one time)
# by running take_snapshot.R
# and the function w/ same name
#----------------------------------------

#match_result_list <- take_snapshot("duke", 1950:2017)
#list_yrs <- match_result_list[[1]]
#overall_yrs <- match_result_list[[2]]

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
