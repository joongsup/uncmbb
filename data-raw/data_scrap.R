rm(list = ls())

library(rvest)
library(dplyr)

# UNC
#------------------------------------
# scrap base match results from 1950 to 2016
#------------------------------------

url_head <- "http://www.sports-reference.com/cbb/schools/north-carolina/"
years <- 1950:2016
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

#names(list_yrs) <- years
#names(overall_yrs) <- years


#------------------------------------
# scrap delta match results 2017
#------------------------------------

years_delta <- 2017
#list_yrs <- vector("list", length(years))
#overall_yrs <- vector("list", length(years))

for (yr in seq_along(years_delta)){
  print(years_delta[yr])
  url_yr <- paste0(url_head, years_delta[yr], "-schedule.html")
  list_yrs[[yr + length(list_yrs)]] <- url_yr %>% read_html() %>%
    html_nodes(xpath = "//*[(@id = \"schedule\")]") %>%
    html_table(fill = TRUE)

  # maybe better to combine the two extracts?
  overall_yrs[[yr + length(overall_yrs)]] <- url_yr %>% read_html() %>%
    html_nodes(xpath = "//*[@id=\"meta\"]/div[2]/p[1]/text()") %>%
    html_text()

}
names(list_yrs) <- c(years, years_delta)
names(overall_yrs) <- c(years, years_delta)





# Duke
#------------------------------------
# scrap base match results from 1950 to 2017
#------------------------------------

url_head <- "http://www.sports-reference.com/cbb/schools/duke/"
years <- 1950:2017
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

