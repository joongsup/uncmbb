
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis-CI Build
Status](https://travis-ci.org/joongsup/uncmbb.svg?branch=master)](https://travis-ci.org/joongsup/uncmbb)
[![Coverage
Status](https://img.shields.io/codecov/c/github/joongsup/uncmbb/master.svg)](https://codecov.io/github/joongsup/uncmbb?branch=master)
[![CRAN
status](http://www.r-pkg.org/badges/version/uncmbb)](https://cran.r-project.org/package=uncmbb)

# uncmbb

This package contains the University of North Carolina (UNC) Men’s
basketball team’s (and their archrival Duke’s) match results since
1949-1950 season with select match attributes. Base match records are
obtained from the source (1) below and augmented from the source (2):

1.  <http://www.sports-reference.com/cbb/schools/north-carolina/>
2.  <http://www.tarheeltimes.com/schedulebasketball-1949.aspx>

Any data discrepancies are fixed once they are identified.

## Installation

``` r
install.packages("uncmbb")
```

Or install the development version from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("joongsup/uncmbb")
```

## Example

``` r
library(uncmbb)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

# Match data
tail(unc)
#>      Season  Game_Date Game_Day   Type Where Opponent_School Result Tm Opp
#> 2223   2019 2019-03-09      Sat    REG     H            Duke      W 79  70
#> 2224   2019 2019-03-14      Thu CTOURN     N      Louisville      W 83  70
#> 2225   2019 2019-03-15      Fri CTOURN     N            Duke      L 73  74
#> 2226   2019 2019-03-22      Fri   NCAA     N            Iona      W 88  73
#> 2227   2019 2019-03-24      Sun   NCAA     N      Washington      W 81  59
#> 2228   2019 2019-03-29      Fri   NCAA     N          Auburn      L 80  97
#>        OT
#> 2223 <NA>
#> 2224 <NA>
#> 2225 <NA>
#> 2226 <NA>
#> 2227 <NA>
#> 2228 <NA>

# NCAA championship seasons
mbb_champ_season(unc)
#> # A tibble: 6 x 1
#> # Groups:   Season [6]
#>   Season
#>   <chr> 
#> 1 1957  
#> 2 1982  
#> 3 1993  
#> 4 2005  
#> 5 2009  
#> 6 2017

# Highest regular season win percentage
unc %>% mbb_season_result() %>%
        filter(Type == "REG") %>%
        arrange(desc(pct_win)) %>%
        head(5)
#> # A tibble: 5 x 7
#> # Groups:   Season [5]
#>   Season Type  games  wins losses pct_win pct_loss
#>   <chr>  <chr> <int> <int>  <int>   <dbl>    <dbl>
#> 1 1957   REG      24    24      0   1       0     
#> 2 1984   REG      27    26      1   0.963   0.0370
#> 3 2008   REG      31    29      2   0.935   0.0645
#> 4 1987   REG      29    27      2   0.931   0.0690
#> 5 1976   REG      26    24      2   0.923   0.0769
```
