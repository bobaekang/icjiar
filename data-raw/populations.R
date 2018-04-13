# import data (new)
populations <- read.csv("data-raw/populations.csv")


# use data
devtools::use_data(populations, overwrite = TRUE)