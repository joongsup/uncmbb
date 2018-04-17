
[![Travis-CI Build Status](https://travis-ci.org/joongsup/uncmbb.svg?branch=master)](https://travis-ci.org/joongsup/uncmbb)
[![CRAN status](http://www.r-pkg.org/badges/version/uncmbb)](https://cran.r-project.org/package=uncmbb)

# UNCMBB

This package contains the University of North Carolina (UNC) Men's basketball team's (and their archrival Duke's) match results since 1949-1950 season with select match attributes. Base match records are obtained from the source (1) below and augmented from the source (2):

1. http://www.sports-reference.com/cbb/schools/north-carolina/
2. http://www.tarheeltimes.com/schedulebasketball-1949.aspx

Any data discrepancies are fixed once they are identified. 

## Installation
```R
# Install the released version from CRAN
install.packages("uncmbb")
```

Or install the development version from GitHub with:
```R
# install.packages("devtools")
devtools::install_github("joongsup/uncmbb")
```

## Examples
```R
library(uncmbb)
library(dplyr)

# Match data
tail(unc)
     Season  Game_Date Game_Day   Type Where Opponent_School Result Tm Opp   OT
2187   2018 2018-03-07      Wed CTOURN     N        Syracuse      W 78  59 <NA>
2188   2018 2018-03-08      Thu CTOURN     N           Miami      W 82  65 <NA>
2189   2018 2018-03-09      Fri CTOURN     N            Duke      W 74  69 <NA>
2190   2018 2018-03-10      Sat CTOURN     N        Virginia      L 63  71 <NA>
2191   2018 2018-03-16      Fri   NCAA     N        Lipscomb      W 84  66 <NA>
2192   2018 2018-03-18      Sun   NCAA     N       Texas A&M      L 65  86 <NA>

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
      
