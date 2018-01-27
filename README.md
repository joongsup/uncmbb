
[![Travis-CI Build Status](https://travis-ci.org/joongsup/uncmbb.svg?branch=master)](https://travis-ci.org/joongsup/uncmbb)
[![Coverage Status](https://img.shields.io/codecov/c/github/joongsup/uncmbb/master.svg)](https://codecov.io/github/joongsup/uncmbb?branch=master)
[![CRAN status](http://www.r-pkg.org/badges/version/uncmbb)](https://cran.r-project.org/package=uncmbb)

# UNCMBB

This package contains the University of North Carolina (UNC) Men's basketball team's (and their archrival Duke's) match results since 1949-1950 season with select match attributes. Base match records are obtained from the source (1) below and augmented from the source (2):

1. http://www.sports-reference.com/cbb/schools/north-carolina/
2. http://www.tarheeltimes.com/schedulebasketball-1949.aspx

## Installation
```R
# Install the released version from CRAN
install.packages("uncmbb")
```

## Examples
```R
library(uncmbb)
library(dplyr)

# Match data
tail(unc)
     Season  Game_Date Game_Day Type Where Opponent_School Result  Tm Opp   OT
2150   2017 2017-03-17      Fri NCAA     N  Texas Southern      W 103  64 <NA>
2151   2017 2017-03-19      Sun NCAA     N        Arkansas      W  72  65 <NA>
2152   2017 2017-03-24      Fri NCAA     N          Butler      W  92  80 <NA>
2153   2017 2017-03-26      Sun NCAA     N        Kentucky      W  75  73 <NA>
2154   2017 2017-04-01      Sat NCAA     N          Oregon      W  77  76 <NA>
2155   2017 2017-04-03      Mon NCAA     N         Gonzaga      W  71  65 <NA>

# NCAA championship seasons
unc %>% 
      filter(Type == "NCAA") %>% 
      group_by(Season) %>% 
      summarize(wins = sum(Result == "W"), losses = sum(Result == "L")) %>% 
      filter(losses == 0)

# A tibble: 6 x 3
  Season  wins losses
   <chr> <int>  <int>
1   1957     5      0
2   1982     5      0
3   1993     6      0
4   2005     6      0
5   2009     6      0
6   2017     6      0

# Highest season win percentage
duke %>% 
      group_by(Season) %>%
      summarize(wins = sum(Result == "W"), losses = sum(Result == "L"), win_perc = round(wins/(wins + losses), 2)) %>%
      arrange(desc(win_perc)) %>%
      head(5)
      
# A tibble: 5 x 4
  Season  wins losses win_perc
   <chr> <int>  <int>    <dbl>
1   1999    37      2     0.95
2   1992    34      2     0.94
3   1986    37      3     0.92
4   1963    27      3     0.90
5   2001    35      4     0.90
      
