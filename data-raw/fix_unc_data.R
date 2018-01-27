
# Change game type for UNC vs. Wake Forest on 1955-03-03 from REG to CTOURN
library(uncmbb)

unc_new <- unc
unc_new[unc_new$Game_Date == "1955-03-03", "Type"] <- "CTOURN"

unc <- unc_new
devtools::use_data(unc, overwrite = TRUE)

library(devtools)
dev_mode(on = TRUE)
dev_mode(on = FALSE)
