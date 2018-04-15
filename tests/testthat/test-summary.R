context("summary")

library(uncmbb)
end_year <- 2017
unc17 <- unc %>% filter(Season <= end_year)
duke17 <- duke %>% filter(Season <= end_year)

test_that("As of the end of 2016-2017 season, UNC has 6 championship seasons, Duke 5.", {

  expect_equal(dim(mbb_champ_season(unc17, "NCAA"))[1], 6)
  expect_equal(dim(mbb_champ_season(duke17, "NCAA"))[1], 5)

}
)
