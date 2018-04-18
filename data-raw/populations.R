# import data (new)
populations <- read.csv("data-raw/populations.csv", fileEncoding="UTF-8-BOM")


# get pipe
`%>%` <- dplyr::`%>%`


# modify data
populations <- populations %>%
  tidyr::gather(
    key = "year",
    value = "population",
    3:ncol(.)
  ) %>%
  dplyr::mutate(
    year = as.numeric(substr(year, 2, nchar(year))),
    fips = ifelse(
      fips < 10, paste0("1700", fips), ifelse(
        fips < 100, paste0("170", fips), paste0("17", fips)
      )
    )
  ) %>%
  dplyr::select(year, county, fips, population)


# use data
devtools::use_data(populations, overwrite = TRUE)
