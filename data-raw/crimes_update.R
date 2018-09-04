library(dplyr)
library(readxl)


# define variables
crimes_isp <- read.csv("crimes_isp.csv", stringsAsFactors = FALSE)
year_max <- max(crimes_isp$year) - 2000
year_new <- year_max + 1
path <- "crimes/isp_temp.xlsx"


# define functions
check_new_data <- function(year_max, year_new) {
  url <- paste0(
    "http://www.isp.state.il.us/docs/cii/cii",
    year_new,
    "/ds/CrimeData_",
    year_new,
    "_",
    year_max,
    ".xlsx"
  )

  if (url != head(httr::GET(url))$url) stop()
  url
}

get_isp_temp <- function(year_max, year_new, path) {
  tryCatch(
    url <- check_new_data(year_max, year_new),
    error = function(e) stop("Data is currently up-to-date.")
  )

  download.file(url, destfile = path, mode = "wb")
  read_excel(path) %>%
    select_at(vars(County, matches(as.character(year_new)))) %>%
    rename_all(tolower) %>%
    select(1, 5:12)
}

get_isp_new <- function(crimes_isp, isp_temp, year_new) {
  isp_new <- isp_temp[1:102,]
  colnames(isp_new) <- colnames(crimes_isp)[c(1, 3, 5:8, 10:13)]

  isp_new %>%
    mutate_at(vars(-county), as.integer) %>%
    mutate(
      county = ifelse(county == "DeWitt", "De Witt", county),
      year = year_new + 2000,
      violent_crime = murder + rape + robbery + aggravated_assault,
      property_crime = burglary + larceny_theft + motor_vehicle_theft + arson
    )
}

append_to_crimes_isp <- function(crimes_isp, isp_new) {
  crimes_isp %>%
    rbind(left_join(isp_new, distinct(crimes_isp, county, fips))) %>%
    arrange(year, fips)
}

update_crimes_isp <- function(crimes_isp, year_max, year_new, path) {
  isp_temp <- get_isp_temp(year_max, year_new, path)
  isp_new  <- get_isp_new(isp_temp, year_new)
  updated  <- append_to_crimes_isp(crimes_isp, isp_new)

  write.csv(updated, "crimes_isp.csv", row.names = FALSE)
  unlink(path)
  message("Update completed.")
}


# excecute updating
tryCatch(
  update_crimes_isp(crimes_isp, year_max, year_new, path),
  error = function(e) geterrmessage()
)
