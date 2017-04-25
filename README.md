
This package contains University of North Carolin (UNC) Men's basketball team's match results from 1949-1950 season with select match attributes. Match records are obtained and augmented from:

1. http://www.sports-reference.com/cbb/schools/north-carolina/
2. http://www.tarheeltimes.com/schedulebasketball-1949.aspx

Steps
1. Run: take_snapshot.R to scrap base.
2. Load: data_prep.R (util functions)
3. Run: generate_data.R
    - This generates an interim dataset and writes to a file.
4. Identify and fill in gaps if applicable by running check_gaps.R and fix_gaps.R
    - After gaps are filled, write to a file and rds. 

