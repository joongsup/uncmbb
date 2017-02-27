#' UNC Men's Basketball Match Results From 1949 - 1950 Season.
#'
#' UNC men's basketball match results from 1949 - 1950 season. Data is scraped from
#' http://www.sports-reference.com/cbb/schools/north-carolina/, and according to the source,
#' may contain missing records especially for matches with non Div-1 teams
#' prior to 1995 - 1996 season.
#'
#' @format A data frame with seventeen variables:
#' \describe{
#' \item{Season}{season year, ending}
#' \item{G}{match number for the corresponding season}
#' \item{Game_Date}{date of match, y-m-d}
#' \item{Game_Day}{day of match}
#' \item{Type}{match type, one of REG, CTOURN, NIT, or NCAA}
#' \item{Where}{match location, one of H(ome), A(way), or N(eutral)}
#' \item{Opponent_School}{match opponent}
#' \item{Opponent_Ranking}{match opponent's ranking at the time of match (which ranking system?)}
#' \item{Conf}{match opponent's conference at the time of match}
#' \item{Result}{match result, W for UNC win}
#' \item{Tm}{UNC score in the match}
#' \item{Opp}{opponent's score in the match}
#' \item{OT}{overtime indicator, one of OT, 2OT, or 3OT}
#' \item{W}{number of wins for the season as a result of the match}
#' \item{L}{number of losses for the season as a result of the match}
#' \item{Streak}{win/loss streak for the season as a result of the match}
#' \item{Arena}{arena in which the match was played}
#' }
#' @source \url{http://www.sports-reference.com/cbb/schools/north-carolina/}
"matchresults"
