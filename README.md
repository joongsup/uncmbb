
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![R-CMD-check](https://github.com/joongsup/uncmbb/workflows/R-CMD-check/badge.svg)](https://github.com/joongsup/uncmbb/actions)
[![Coverage
Status](https://img.shields.io/codecov/c/github/joongsup/uncmbb/master.svg)](https://codecov.io/github/joongsup/uncmbb?branch=master)
[![CRAN
status](http://www.r-pkg.org/badges/version/uncmbb)](https://cran.r-project.org/package=uncmbb)

# uncmbb

This package contains the University of North Carolina (UNC) Men’s
basketball team’s (and their archrival Duke’s) match results since
1949-1950 season with select match attributes. Base match records are
obtained from the source (1) below and augmented from the source (2):

1.  <https://www.sports-reference.com/cbb/schools/north-carolina/>
2.  <https://www.tarheeltimes.com/schedulebasketball-1949.aspx>

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
#>      Season  Game_Date Game_Day   Type Where      Opponent_School Result Tm Opp
#> 2256   2020 2020-02-25      Tue    REG     H North Carolina State      W 85  79
#> 2257   2020 2020-02-29      Sat    REG     A             Syracuse      W 92  79
#> 2258   2020 2020-03-03      Tue    REG     H          Wake Forest      W 93  83
#> 2259   2020 2020-03-07      Sat    REG     A                 Duke      L 76  89
#> 2260   2020 2020-03-10      Tue CTOURN     N        Virginia Tech      W 78  56
#> 2261   2020 2020-03-11      Wed CTOURN     N             Syracuse      L 53  81
#>        OT
#> 2256 <NA>
#> 2257 <NA>
#> 2258 <NA>
#> 2259 <NA>
#> 2260 <NA>
#> 2261 <NA>

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
