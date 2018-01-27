# check devel version
library(devtools)
library(dplyr)

dev_mode(on = TRUE)
#install_github("joongsup/uncmbb")
library(uncmbb, .libPaths("/Users/jl939a/R-dev"))
unc[unc$Game_Date == "1955-03-03", ]

unc %>% champ_season("CTOURN")

dev_mode(on = FALSE)


# code coverage
install.packages("covr")
library(covr)

#use_coverage(pkg = ".", type = c("codecov"))
codecov(token = "af82c61e-c03f-4bf8-a7b6-906f82765aae")
