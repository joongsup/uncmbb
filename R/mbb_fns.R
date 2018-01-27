
#' Season match summary
#'
#' @param df Input data frame containing a team's historical match data.
#'
#' @return A data frame containing number of games, wins, losses, win %, and loss %.
#' @export
#' @importFrom dplyr %>% group_by summarize mutate filter n
#'
#' @examples
#' get_season_result(unc)
get_season_result <- function(df){

  df %>% group_by(.data$Season) %>%
         summarize(games = n(), wins = sum(.data$Result == "W"), losses = sum(.data$Result == "L")) %>%
         mutate(pct_win = .data$wins/.data$games, pct_loss = .data$losses/.data$games)

}

#' Get NCAA championship winning seasons from a team's historical match data
#'
#' @param df Input data frame containing a team's historical match data.
#' @param type Match type
#'
#' @return Team's NCAA championship winning seasons (if any).
#' @export
#' @importFrom dplyr %>% group_by summarize filter select
#' @importFrom rlang .data
#' @examples
#' champ_season(unc, "NCAA")
champ_season <- function(df, type){
   df %>% filter(.data$Type == type) %>%
          # group_by(.data$Season) %>%
          # summarize(losses = sum(.data$Result == "L")) %>%
          # filter(.data$losses == 0) %>%
          # select(.data$Season)
          get_season_result() %>%
          filter(.data$losses == 0) %>%
          select(.data$Season)
  }



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
