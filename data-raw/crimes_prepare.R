library(dplyr)


# get standard county names
source("std_county_names.R")


# get file paths
dirname = "crimes"
if (!dir.exists(dirname)) {
  source("crime_download.R")
}

paths_fbi <- paste0(dirname, "/", list.files(path = dirname, pattern = "^fbi.*"))
path_isp <- paste0(dirname, "/", "isp_all.xls")
# paths_isp <- paste0(dirname, "/", list.files(path = dirname, pattern = "^isp.*"))


# define functions to read files
read_fbi <- function(path) {
  newnames <- c("county", "violent_crime", "murder", "rape_old", "rape_new", "robbery", "assault", "property_crime", "burglary", "larcenytft", "mvtft", "arson", "year")
  output <- readxl::read_excel(path, skip = 5) %>%
    select(2:ncol(.)) %>%
    arrange(County) %>%
    mutate(year = as.integer(gsub("\\D+", "", path)))

  if (ncol(output) == 12) {
    output <- output %>%
      mutate(rape_new = NA) %>%
      select(1:3, 13, 4:12)
  }

  colnames(output) <- newnames

  output <- output %>%
    filter(!is.na(county)) %>%
    select(year, county, violent_crime:arson)

  return(output)
}

read_isp <- function(path) {
  read_icjia <- function(path, sheet) {
    range <- "B6:AK108"
    file <- readxl::read_excel(path, sheet = sheet, range = range)
    output <- file %>%
      tidyr::gather(
        key = "year",
        value = "value",
        3:ncol(.)
      )
  }

  df_all <- data.frame()
  newnames <- c("county", "violent_crime", "murder", "rape", "robbery", "assault", "property_crime", "burglary", "larcenytft", "mvtft", "arson", "year")
  for (i in 2:11) {
    df <- read_icjia(path, i)
    colnames(df) <- c("fips", "county", "year", newnames[i])
    if (i == 2) {
      df_all <- df
    } else {
      df_all <- left_join(df_all, df)
    }
  }

  output <- df_all %>%
    mutate(
      fips = ifelse(
        fips < 10, paste0("1700", fips), ifelse(
          fips < 100, paste0("170", fips), paste0("17", fips)
        )
      ),
      year = as.numeric(year)
    ) %>%
    select(year, county, fips, violent_crime:arson)
  return(output)
}
# read_isp <- function(path) {
#   yearnum <- substr(gsub("\\D+", "", path), 3, 4)
#   newnames <- c("county", "murder", "rape", "robbery", "assault", "burglary", "larcenytft", "mvtft", "arson")
#   target_cols <- c("murder", "rape", "rob", "asslt", "burg", "larc", "auto", "arson")
#   if (grepl("2015", path)) {
#     target_cols <- c("CH", "Rape", "Rob", "AggBA", "Burg", "Theft", "MVT", "Arson")
#   }
#
#   if (grepl("dbf$", path)) {
#     output <- foreign::read.dbf(path)
#     output <- output %>%
#       select(COUNTY, paste0(toupper(target_cols), yearnum)) %>%
#       group_by(COUNTY) %>%
#       mutate_if(is.numeric, sum) %>%
#       ungroup() %>%
#       unique()
#   } else {
#     clean <- function(output, yearnum) {
#       output %>%
#         filter(is.na(Agency)) %>%
#         select(
#           County,
#           paste0(
#             paste0(
#               toupper(substr(target_cols, 1, 1)),
#               substr(target_cols, 2, nchar(target_cols))
#             ),
#             yearnum
#           )
#         ) %>%
#         mutate_at(vars(matches("[^county]")), as.numeric)
#     }
#     if (grepl("2011", path)) {
#       output <- readxl::read_excel(path, skip = 2, na = c("", "--"))
#
#       output10 <- clean(output, "10") %>% mutate(year = 2010L)
#       output11 <- clean(output, "11") %>% mutate(year = 2011L)
#
#       colnames(output10) <- c(newnames, "year")
#       colnames(output11) <- c(newnames, "year")
#
#       output <- rbind(output10, output11) %>%
#         mutate(
#           county = as.character(county),
#           violent_crime = murder + rape + robbery + assault,
#           property_crime = burglary + larcenytft + mvtft + arson
#         ) %>%
#         select(year, county, violent_crime, murder:assault, property_crime, burglary:arson)
#
#       return(output)
#     } else {
#       output <- readxl::read_excel(path, na = c("", "--"))
#       output <- clean(output, yearnum)
#     }
#   }
#
#   colnames(output) <- newnames
#
#   output <- output %>%
#     mutate(
#       county = as.character(county),
#       year = as.integer(paste0("20", yearnum)),
#       violent_crime = murder + rape + robbery + assault,
#       property_crime = burglary + larcenytft + mvtft + arson
#     ) %>%
#     select(year, county, violent_crime, murder:assault, property_crime, burglary:arson)
#
#   return(output)
# }


# read and combine all
crimes_fbi <- do.call("rbind", lapply(paths_fbi, read_fbi))
crimes_isp <- read_isp(path_isp)
# crimes_isp <- do.call("rbind", lapply(paths_isp, read_isp))


# redo county names
crimes_fbi <- crimes_fbi %>%
  arrange(year, county) %>%
  mutate(
    county = ifelse(
      county %in% c("DuPage", "Dupage"),
      "Du Page",
      county
    )
  )

crimes_isp <- crimes_isp %>%
  arrange(year, county) %>%
  mutate(county = rep(county_std, nrow(.) / 102))


# replace 0 to NA in isp data when appropriate
crimes_isp[
  crimes_isp$year >= 2013 & crimes_isp$county  %in% c("Calhoun", "Pope"),
  4:13
] <- NA


# export data
write.csv(crimes_fbi, "crimes_fbi.csv", row.names = FALSE)
write.csv(crimes_isp, "crimes_isp.csv", row.names = FALSE)


# clear environmet
rm(list = ls())
