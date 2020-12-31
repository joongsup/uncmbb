
library(dplyr)
library(tidyr)
library(lubridate)
library(readr)
library(purrr)
library(stringr)
library(data.table)
library(rvest) # rvest::read_html

#------------------------------------
# scrap base match results from 1950 to 2017
# need error handling for years without records
# typically 404 error (page not exist)
#------------------------------------
take_snapshot <- function(school, yrs){

  url_main <- "http://www.sports-reference.com/cbb/schools/"
  #schools <- c("north-carolina", "duke")
  #years_range <- 1950:2017

  url_head <- paste0(url_main, school, "/")
  years <- yrs
  list_yrs <- vector("list", length(years))
  overall_yrs <- vector("list", length(years))

  for (yr in seq_along(years)){
    print(years[yr])
    url_yr <- paste0(url_head, years[yr], "-schedule.html")
    # list_yrs contains available match result for each year
    # may not add up to the final records for each year as in overall_yrs
    list_yrs[[yr]] <- url_yr %>% read_html() %>%
      html_nodes(xpath = "//*[(@id = \"schedule\")]") %>%
      html_table(fill = TRUE)

    # overall_yrs contains overall final results for each year
    # and can be different from sum of list_yrs results
    # maybe better to combine the two extracts?
    overall_yrs[[yr]] <- url_yr %>% read_html() %>%
      html_nodes(xpath = "//*[@id=\"meta\"]/div[2]/p[1]/text()") %>%
      html_text()

  }

  names(list_yrs) <- years
  names(overall_yrs) <- years

  match_list <- list(match_records = list_yrs, overall_records = overall_yrs)
  match_list
}

#----------------------------------------
# slice off the extra list layer
#----------------------------------------
slice_layer <- function(list_raw){

  list_yrs_cleaned <- vector("list", length(list_raw))
    for (yr in seq_along(list_raw)){
      list_yrs_cleaned[yr] <- list_raw[[yr]]
    }

  names(list_yrs_cleaned) <- names(list_raw)

list_yrs_cleaned
}


#----------------------------------------
# last 2 seasons (2015, 2016) have
# 2 additional fields (Time and Network)
# for 2018-2019 season, there's no network column (hence column length = 15)
#----------------------------------------

remove_cols <- function(list){

  column_cnt <- list %>% map_int(function(x) length(x))
  for (num in seq_along(column_cnt)){
    if (as.numeric(names(list)) < 2019){
      if (column_cnt[num] > 14){
        list[[num]] <- list[[num]][, c(1, 2, 5:length(list[[num]]))]
        #list[[num]] <- list[[num]][, c(1, 2, 5:16)]
      }
    } else if (names(list) == "2019"){
      list[[num]] <- list[[num]][, c(1, 2, 4, 5, 6, 8, 9, 10, 11)]
    }
  }

list
}

#----------------------------------------
# add col names (for those missing)
#----------------------------------------

add_column_name <- function(df){
  names_to_fill <- c("Where", "Result")
  # pre 2018-19 season
  #names(df)[4] <- names_to_fill[1]
  #names(df)[7] <- names_to_fill[2]
  # for 2018-19 season
  names(df)[5] <- names_to_fill[1]
  names(df)[8] <- names_to_fill[2]
  df
}

#----------------------------------------
# remove header
#----------------------------------------

remove_mid_header <- function(df){
  df <- df %>% dplyr::filter(G != "G")
  df
}

#----------------------------------------
# extract ranking from opp name
#----------------------------------------

extract_ranking <- function(df){
  df$Opponent_Ranking <- parse_number(df$Opponent)
  df$Opponent_School <- gsub("\\s*\\([^\\)]+\\)", "", df[["Opponent"]])

  attributes(df$Opponent_Ranking) <- NULL
  attributes(df$Opponent_School) <- NULL

  df
}

#----------------------------------------
# fix date
#----------------------------------------

fix_date <- function(df){
  df$Game_Day <- substr(df$Date, 1, 3)
  df$Game_Date <- substr(df$Date, 6, length(df$Date))
  df$Game_Date <- mdy(df$Game_Date)

  df
}

#----------------------------------------
# fix where
#----------------------------------------

fix_where <- function(df){
  df$Where <- ifelse(df$Where == "@", "A",
                     ifelse(df$Where == "", "H", "N"))
  df
  }

#----------------------------------------
# fill empty w/ na
#----------------------------------------

na_empty <- function(df){
  # after checking apply(d, 2, function(x) sum(x == ""))
  df$Conf <- ifelse(df$Conf == "", NA, df$Conf)
  df$OT <- ifelse(df$OT == "", NA, df$OT)
  df$Arena <- ifelse(df$Arena == "", NA, df$Arena)

  df
}

#----------------------------------------
# finalize type
#----------------------------------------

fix_type <- function(df){
  # Game_Date should be of type Date
  df$G <- as.numeric(df$G)
  df$Tm <- as.numeric(df$Tm)
  df$Opp <- as.numeric(df$Opp)
  df$W <- as.numeric(df$W)
  df$L <- as.numeric(df$L)
  df$Opponent_Ranking <- as.numeric(df$Opponent_Ranking)

  df
}

#----------------------------------------
# final prep (a wrapper for most prep tasks)
#----------------------------------------

final_prep <- function(list){

  list <- list %>% map(function(x) add_column_name(x))
  list <- list %>% map(function(x) remove_mid_header(x))

  df <- rbindlist(list, idcol = "Season")
  df <- df %>%
          extract_ranking %>%
          fix_date() %>%
          fix_where() %>%
          na_empty() %>%
          fix_type()

  final_cols <- c("Season", "G", "Game_Date", "Game_Day", "Type",  "Where", "Opponent_School", "Opponent_Ranking", "Conf", "Result", "Tm", "Opp", "OT", "W", "L", "Streak", "Arena")
  df <- as.data.frame(df)
  df <- df[, final_cols]

df
}


save_data <- function(df, school, new_years){
    if(school == "north-carolina"){
    unc <- df %>% arrange(Game_Date)
    saveRDS(df, file = paste0("data-raw/final_results_", school, "_", new_years[1], "_", new_years[length(new_years)], ".RDS"))
    write.table(unc, file = paste0("data-raw/final_results_", school, "_", new_years[1], "_", new_years[length(new_years)], ".csv"), sep = ",", col.names = TRUE, row.names = FALSE, quote = FALSE)
    usethis::use_data(unc, overwrite = TRUE) # usethis::use_data, not devtools::use_data
  } else if(school == "duke"){
    duke <- df %>% arrange(Game_Date)
    saveRDS(df, file = paste0("data-raw/final_results_", school, "_", new_years[1], "_", new_years[length(new_years)], ".RDS"))
    write.table(duke, file = paste0("data-raw/final_results_", school, "_", new_years[1], "_", new_years[length(new_years)], ".csv"), sep = ",", col.names = TRUE, row.names = FALSE, quote = FALSE)
    usethis::use_data(duke, overwrite = TRUE) # usethis::use_data, not devtools::use_data
  }
}

#----------------------------------------
# final prep (a wrapper for most prep tasks)
#----------------------------------------
check_gaps <- function(results, overalls){

  a <- overalls %>%
                map(function(x) str_split(x, " ")) %>%
                map_chr(function(x) x[[1]][[2]]) %>%
                as.data.frame(optional = TRUE, stringsAsFactors = FALSE)
  a <- data.frame(year = row.names(a), overall = a[1], row.names = NULL)
  a <- a %>% separate(overall, into = c("WINS", "LOSES"), convert = TRUE)
  a$year <- as.character(a$year)

  b <- results %>% group_by(Season) %>% summarize(wins = max(W), loses = max(L))
  a <- a %>% inner_join(b, by = c("year" = "Season"))
  overallrecords <- a %>% mutate(gaps_wins = WINS - wins, gaps_loses = LOSES - loses)

  gaps <- overallrecords %>% dplyr::filter(gaps_loses > 0 | gaps_wins > 0)

  if(dim(gaps)[1] > 0){
    print("Following gaps are found: ")
    gaps
  } else {
    print("No gaps found!")
    gaps
  }

}

new_season <- function(school, year){

  match_result_list <- take_snapshot(school, year)
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

  saveRDS(d, file = paste0("data-raw/match_results_", school, "_", year, ".RDS"))
  write.table(d, file = paste0("data-raw/match_results_", school, "_", year, ".csv"), col.names = TRUE, row.names = FALSE, quote = FALSE, sep = ",")

}

#----------------------------------------
# mbb_fns
#----------------------------------------

# #-----------------------------------------------------
# df_pct <- unc %>%
#   count(Season, Result) %>%
#   group_by(Season) %>%
#   mutate(pct = n/sum(n), games = sum(n)) %>%
#   filter(Result == "W") %>%
#   ungroup() %>%
#   mutate(champ = ifelse(Season %in% df_ncaa$Season, 1, 0))
#
#
# }
#
# #-----------------------------------------------------
#
#
# #OR
#
# unc %>% filter(Type == "NCAA") %>%
#         get_season_result %>%
#         filter(losses == 0) %>%
#         select(Season)
#
# #-----------------------------------------------------
# uncts <- unc %>%
#   group_by(Season) %>%
#   summarize(wins = sum(Result == "W"), loses = sum(Result == "L"))
#
#
# #-----------------------------------------------------
# get_series_history <- function(records, min_games){
#
#   opponents <- records %>% count(Opponent_School, sort = TRUE) %>% add_percent(var = n)
#   schools <- opponents %>% filter(n >= min_games)
#
#   results <- records %>%
#     filter(Opponent_School %in% schools$Opponent_School) %>%
#     group_by(Opponent_School) %>%
#     summarize(wins = sum(Result == "W"), loses = sum(Result == "L"),
#               first_game = min(Game_Date), last_game = max(Game_Date)) %>%
#     mutate(games = wins + loses) %>%
#     mutate(win_perc = round(wins/games, 4)) %>%
#     arrange(desc(win_perc)) %>%
#     select(Opponent_School, first_game, last_game, games, wins, loses, win_perc)
#
#   results
# }
#
#
# #-----------------------------------------------------
# get_home_history <- function(records, min_home_games){
#
#   opponents <- records %>% filter(Where == "H") %>% count(Opponent_School, sort = TRUE) %>% add_percent(var = n)
#   schools <- opponents %>% filter(n >= min_home_games)
#
#   results <- records %>%
#     filter(Opponent_School %in% schools$Opponent_School) %>%
#     group_by(Opponent_School) %>%
#     summarize(wins = sum(Result == "W"), loses = sum(Result == "L"),
#               first_game = min(Game_Date), last_game = max(Game_Date)) %>%
#     mutate(games = wins + loses) %>%
#     mutate(win_perc = round(wins/games, 4)) %>%
#     arrange(desc(win_perc)) %>%
#     select(Opponent_School, first_game, last_game, games, wins, loses, win_perc)
#
#   results
# }
#
