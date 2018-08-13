# get pipe
`%>%` <- dplyr::`%>%`


# import data (new)
populations <- read.csv("data-raw/populations.csv", fileEncoding="UTF-8-BOM")


# modify data
county_to_fix <- c("De Kalb", "DuPage", "La Salle")

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
    ),
    county = as.character(county),
    county = ifelse(county %in% county_to_fix, gsub(" ", "", county), county)
  ) %>%
  dplyr::arrange(year, county) %>%
  dplyr::select(year, county, fips, population)


# use data
devtools::use_data(populations, overwrite = TRUE)
