

library(rvest)
library(dplyr)

#------------------------------------
# scrap base match results from 1950 to 2017
# need error handling for years without records
# typically 404 error (page not exist)
#------------------------------------
url_main <- "http://www.sports-reference.com/cbb/schools/"
schools <- c("north-carolina", "duke", "kansas")
years_range <- 1950:2017

take_snapshot <- function(school, yrs){

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
