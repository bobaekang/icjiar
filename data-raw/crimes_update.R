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
    select_at(vars(County, matches(paste0(year_new, "|", year_max) ))) %>%
    rename_all(tolower) %>%
    select(1, 8:23)
}


get_isp_new <- function(isp_temp, crimes_isp, year_new) {
  f <- function(x, year) {
    x <- select_at(x[1:102, ], vars(county, matches(paste0(year))))
    colnames(x) <- colnames(crimes_isp)[c(2, 5:8, 10:13)]
    x %>%
      mutate_at(vars(-county), as.integer) %>%
      mutate(
        county = ifelse(county == "DeWitt", "De Witt", county),
        year = year + 2000,
        violent_crime = murder + rape + robbery + aggravated_assault,
        property_crime = burglary + larceny_theft + motor_vehicle_theft + arson
      )
  }

  rbind(f(isp_temp, year_new-1), f(isp_temp, year_new))
}

append_to_crimes_isp <- function(isp_new, crimes_isp, year_max) {
  crimes_isp %>%
    filter(year < 2000 + year_max) %>%
    rbind(left_join(isp_new, distinct(crimes_isp, county, fips))) %>%
    arrange(year, fips)
}

update_crimes_isp <- function(crimes_isp, year_max, year_new, path) {
  updated <- get_isp_temp(year_max, year_new, path) %>%
    get_isp_new(crimes_isp, year_new) %>%
    append_to_crimes_isp(crimes_isp, year_max)

  write.csv(updated, "crimes_isp.csv", row.names = FALSE)
  unlink(path)
  message("Update completed.")
}


# excecute updating
tryCatch(
  update_crimes_isp(crimes_isp, year_max, year_new, path),
  error = function(e) geterrmessage()
)
