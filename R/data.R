#' UNC Men's Basketball Match Results From 1949 - 1950 Season.
#'
#' UNC men's basketball match results from 1949 - 1950 season. Data is scraped from
#' http://www.sports-reference.com/cbb/schools/north-carolina/, and according to the source,
#' may contain missing records especially for matches with non Div-1 teams
#' prior to 1995 - 1996 season. Those missing records were later filled in using data from other source (http://www.tarheeltimes.com/schedulebasketball-1949.aspx)
#'
#' @format A data frame with variables:
#' \describe{
#' \item{Season}{season year, ending}
#' \item{Game_Date}{date of match, y-m-d}
#' \item{Game_Day}{day of match}
#' \item{Type}{match type, one of REG, CTOURN, NIT, or NCAA}
#' \item{Where}{match location, one of H(ome), A(way), or N(eutral)}
#' \item{Opponent_School}{match opponent}
#' \item{Result}{match result, W for UNC win}
#' \item{Tm}{UNC score in the match}
#' \item{Opp}{opponent's score in the match}
#' \item{OT}{overtime indicator, one of OT, 2OT, or 3OT}
#' }
#' @source \url{http://www.sports-reference.com/cbb/schools/north-carolina/}
"unc_results"


#' Duke Men's Basketball Match Results From 1949 - 1950 Season.
#'
#' Duke men's basketball match results from 1949 - 1950 season. Data is scraped from
#' http://www.sports-reference.com/cbb/schools/duke/, and according to the source,
#' may contain missing records especially for matches with non Div-1 teams
#' prior to 1995 - 1996 season. No missing records were found.
#'
#' @format A data frame with variables:
#' \describe{
#' \item{Season}{season year, ending}
#' \item{Game_Date}{date of match, y-m-d}
#' \item{Game_Day}{day of match}
#' \item{Type}{match type, one of REG, CTOURN, NIT, or NCAA}
#' \item{Where}{match location, one of H(ome), A(way), or N(eutral)}
#' \item{Opponent_School}{match opponent}
#' \item{Result}{match result, W for UNC win}
#' \item{Tm}{UNC score in the match}
#' \item{Opp}{opponent's score in the match}
#' \item{OT}{overtime indicator, one of OT, 2OT, or 3OT}
#' }
#' @source \url{http://www.sports-reference.com/cbb/schools/duke/}
"duke_results"
