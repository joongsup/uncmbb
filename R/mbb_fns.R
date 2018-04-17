#' Get season's win/loss summary for all match types.
#'
#' @param df Input data frame containing a team's historical match data that are included in uncmbb package.
#'
#' @return A data frame containing number of games, wins, losses, win %, and loss %.
#' @importFrom dplyr %>% group_by summarize mutate filter n
#' @export
#' @examples
#' mbb_season_result(unc)
mbb_season_result <- function(df){
  if(sum(names(df) != names(uncmbb::unc)) > 0){ # if df is not a df from uncmbb package (better check?)
    stop("Input data frame has to (1) be either unc or duke, or (2) have same data structure as those.")
  } else {
  df %>% group_by(.data$Season, .data$Type) %>%
    summarize(games = n(), wins = sum(.data$Result == "W"), losses = sum(.data$Result == "L")) %>%
    mutate(pct_win = .data$wins/.data$games, pct_loss = .data$losses/.data$games)
  }
}

#' Get NCAA championship winning seasons from a team's historical match data.
#'
#' @param df Input data frame containing a team's historical match data that are included in uncmbb package.
#' @param type Match type. NCAA (default).
#'
#' @return Team's championship (either NCAA or CTOURN) winning seasons (if any).
#' @importFrom dplyr %>% group_by summarize filter select
#' @importFrom rlang .data
#' @export
#' @examples
#' mbb_champ_season(unc)
mbb_champ_season <- function(df, type = "NCAA"){
  if(sum(names(df) != names(uncmbb::unc)) > 0){ # if df is not a df from uncmbb package (better check?)
    stop("Input data frame has to (1) be either unc or duke, or (2) have same data structure as those.")
  } else {
    df %>% mbb_season_result() %>%
          filter(.data$Type == type) %>%
          filter(.data$losses == 0) %>%
          select(.data$Season)
  }
}
