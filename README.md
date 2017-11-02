
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

# NCAA championship seasons
unc %>% 
      filter(Type == "NCAA") %>% 
      group_by(Season) %>% 
      summarize(wins = sum(Result == "W"), losses = sum(Result == "L")) %>% 
      filter(losses == 0)

# Highest season win percentage
duke %>% 
      group_by(Season) %>%
      summarize(wins = sum(Result == "W"), losses = sum(Result == "L"), win_perc = round(wins/(wins + losses), 2)) %>%
      arrange(desc(win_perc)) %>%
      head(5)
      
      
      
