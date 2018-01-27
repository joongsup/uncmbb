# put cran badge using usethis

#install.packages("usethis") # keeps failing!?
# Error : .onLoad failed in loadNamespace() for 'usethis', details:
#   call: NULL
# error: 'import' is not an exported object from 'namespace:backports'
# Error: loading failed
# Execution halted
# ERROR: loading failed

library(devtools)
#devtools::install_github("r-lib/usethis")
library(usethis) # devel version from github
use_cran_badge()
