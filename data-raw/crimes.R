# import data
fbicrime <- read.csv("data-raw/fbicrime.csv")
ispcrime <- read.csv("data-raw/ispcrime.csv")

# use data
devtools::use_data(fbicrime, ispcrime, overwrite = TRUE)
