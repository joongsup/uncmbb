library(rvest)
library(dplyr)

url <- "http://www.sports-reference.com/cbb/schools/north-carolina/2016-schedule.html"
a <- url %>% read_html() %>%
  html_nodes(xpath = "//*[(@id = \"schedule\")]") %>%
  html_table(fill = TRUE)


#------------------------------------
# scrap match results from 1950
#------------------------------------

years <- 1950:2016
list_yrs <- vector("list", length(years))
url_head <- "http://www.sports-reference.com/cbb/schools/north-carolina/"
for (yr in seq_along(years)){
  print(years[yr])
  url_yr <- paste0(url_head, years[yr], "-schedule.html")
  list_yrs[[yr]] <- url_yr %>% read_html() %>%
    html_nodes(xpath = "//*[(@id = \"schedule\")]") %>%
    html_table(fill = TRUE)
}
names(list_yrs) <- years


