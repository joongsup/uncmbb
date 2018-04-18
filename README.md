
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
#> 2187   2018 2018-03-07      Wed CTOURN     N        Syracuse      W 78  59
#> 2188   2018 2018-03-08      Thu CTOURN     N           Miami      W 82  65
#> 2189   2018 2018-03-09      Fri CTOURN     N            Duke      W 74  69
#> 2190   2018 2018-03-10      Sat CTOURN     N        Virginia      L 63  71
#> 2191   2018 2018-03-16      Fri   NCAA     N        Lipscomb      W 84  66
#> 2192   2018 2018-03-18      Sun   NCAA     N       Texas A&M      L 65  86
#>        OT
#> 2187 <NA>
#> 2188 <NA>
#> 2189 <NA>
#> 2190 <NA>
#> 2191 <NA>
#> 2192 <NA>

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
#> 1 1957   REG      24    24      0   1.00    0.    
#> 2 1984   REG      27    26      1   0.963   0.0370
#> 3 2008   REG      31    29      2   0.935   0.0645
#> 4 1987   REG      29    27      2   0.931   0.0690
#> 5 1976   REG      26    24      2   0.923   0.0769
```
