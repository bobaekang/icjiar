library(dplyr)


# get standard county names
source("std_county_names.R")


# get file paths
dirname = "crimes"
if (!dir.exists(dirname)) {
  source("crime_download.R")
}

paths_fbi <- paste0(dirname, "/", list.files(path = dirname, pattern = "^fbi.*"))
path_isp <- paste0(dirname, "/", "isp_all.csv")


# define functions to read files
read_fbi <- function(path) {
  newnames <- c(
    "county_name",
    "violent_crime",
    "murder",
    "rape_old",
    "rape_new",
    "robbery",
    "aggravated_assault",
    "property_crime",
    "burglary",
    "larceny_theft",
    "motor_vehicle_theft",
    "arson",
    "year"
  )

  tolower_trim <- function(x) gsub(" ", "", tolower(x))

  output <- readxl::read_excel(path, skip = 5) %>%
    select(2:ncol(.)) %>%
    arrange(County) %>%
    mutate(
      year = as.integer(gsub("\\D+", "", path)),
      County = ifelse(tolower_trim(County) == "dekalb", "DeKalb", County),
      County = ifelse(tolower_trim(County) == "dupage", "DuPage", County),
      County = ifelse(tolower_trim(County) == "lasalle", "LaSalle", County)
    )

  if (ncol(output) == 12) {
    output <- output %>%
      mutate(rape_new = NA) %>%
      select(1:3, 13, 4:12)
  }

  colnames(output) <- newnames

  output %>%
    filter(!is.na(county_name)) %>%
    left_join(county_std, by = "county_name") %>%
    select(
      year,
      county = county_name,
      fips = fips_number,
      violent_crime:arson
    ) %>%
    arrange(year, fips)
}

read_isp <- function(path) {
  read.csv(path) %>%
    mutate(
      fips = fips_number + 17000,
      violent_crime = murder + sexual_assault + robbery + aggravated_assault,
      property_crime = burglary + larceny_theft + motor_vehicle_theft + arson
    ) %>%
    select(
      year,
      county = county_name,
      fips,
      violent_crime,
      murder,
      rape = sexual_assault,
      robbery,
      aggravated_assault,
      property_crime,
      burglary,
      larceny_theft,
      motor_vehicle_theft,
      arson
    ) %>%
    arrange(year, fips)
}


# read and combine all
crimes_fbi <- do.call("rbind", lapply(paths_fbi, read_fbi))
crimes_isp <- read_isp(path_isp)


# replace 0 to NA in isp data when appropriate
crimes_isp[
  crimes_isp$year >= 2013 & crimes_isp$county %in% c("Calhoun", "Pope"),
  4:13
] <- NA


# export data
write.csv(crimes_fbi, "crimes_fbi.csv", row.names = FALSE)
write.csv(crimes_isp, "crimes_isp.csv", row.names = FALSE)


# clear environmet
rm(list = ls())
