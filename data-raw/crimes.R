# import data (old)
fbicrime <- read.csv("data-raw/fbicrime.csv")
ispcrime <- read.csv("data-raw/ispcrime.csv")


# import data (new)
crimes_fbi <- read.csv("data-raw/crimes_fbi.csv")
crimes_isp <- read.csv("data-raw/crimes_isp.csv")


# use data
devtools::use_data(fbicrime, ispcrime, crimes_fbi, crimes_isp, overwrite = TRUE)
