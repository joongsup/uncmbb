#-------
# current season
#-------
Sys.setenv(http_proxy='http://one.proxy.att.com:8080')
Sys.setenv(https_proxy='http://one.proxy.att.com:8080')


library(dplyr)
library(tidyr)
library(readr)
library(rvest)
library(purrr)
source("data-raw/utils.R")
a <- take_snapshot("north-carolina", 2018)
b <- a$match_records %>%
  slice_layer() %>%
  remove_cols() %>%
  data.frame() %>%
  add_column_name() #%>%
#remove_mid_header()
#b[b$X2018.G == 5, ]$X2018.Tm <- 87
#b[b$X2018.G == 5, ]$X2018.Opp <- 68
names(b) <- c("G", "Date", "Type", "Where", "Opponent", "Conf", "Result", "Tm", "Opp", "OT", "Win", "Lose", "Streak", "Arena")
b <- b %>%
  mutate(diff = Tm - Opp, diffsum = cumsum(diff), num = row_number(), diffavg = diffsum/num)
saveRDS(b, file =  "/Users/jl939a/projects/blog/backup/current_season.RDS")
