# check devel version
library(devtools)
library(dplyr)

dev_mode(on = TRUE)
#install_github("joongsup/uncmbb")
library(uncmbb, .libPaths("/Users/jl939a/R-dev"))
unc[unc$Game_Date == "1955-03-03", ]

unc %>% champ_season("CTOURN")

dev_mode(on = FALSE)



