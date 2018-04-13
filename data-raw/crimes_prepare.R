library(dplyr)
# library(readxl)
# library(foreign)


# get standard county names
source("std_county_names.R")


# get file paths
dirname = "crimes"
if (!dir.exsits(dirname)) {
  source("crime_download.R")  
}

paths_fbi <- paste0(dirname, "/", list.files(path = dirname, pattern = "^fbi.*"))
paths_isp <- paste0(dirname, "/", list.files(path = dirname, pattern = "^isp.*"))


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
    select(county, year, violent_crime:arson)
  
  return(output)
}

read_isp <- function(path) {
  yearnum <- substr(gsub("\\D+", "", path), 3, 4)
  newnames <- c("county", "murder", "rape", "robbery", "assault", "burglary", "larcenytft", "mvtft", "arson")
  target_cols <- c("murder", "rape", "rob", "asslt", "burg", "larc", "auto", "arson")
  if (grepl("2015", path)) {
    target_cols <- c("CH", "Rape", "Rob", "AggBA", "Burg", "Theft", "MVT", "Arson")
  }
  
  if (grepl("dbf$", path)) {
    output <- foreign::read.dbf(path)
    output <- output %>%
      select(COUNTY, paste0(toupper(target_cols), yearnum)) %>%
      group_by(COUNTY) %>%
      mutate_if(is.numeric, sum) %>%
      ungroup() %>%
      unique()
  } else {
    clean <- function(output, yearnum) {
      output %>%
        filter(is.na(Agency)) %>%
        select(
          County,
          paste0(
            paste0(
              toupper(substr(target_cols, 1, 1)),
              substr(target_cols, 2, nchar(target_cols))
            ),
            yearnum
          )
        ) %>%
        mutate_at(vars(matches("[^county]")), as.numeric)
    }
    if (grepl("2011", path)) {
      output <- readxl::read_excel(path, skip = 2, na = c("", "--"))
      
      output10 <- clean(output, "10") %>% mutate(year = 2010L)
      output11 <- clean(output, "11") %>% mutate(year = 2011L)
      
      colnames(output10) <- c(newnames, "year")
      colnames(output11) <- c(newnames, "year")
      
      output <- rbind(output10, output11) %>%
        mutate(
          county = as.character(county),
          violent_crime = murder + rape + robbery + assault,
          property_crime = burglary + larcenytft + mvtft + arson
        ) %>%
        select(county, year, violent_crime, murder:assault, property_crime, burglary:arson)

      return(output)
    } else {
      output <- readxl::read_excel(path, na = c("", "--"))
      output <- clean(output, yearnum)
    }
  }
  
  colnames(output) <- newnames
  
  output <- output %>%
    mutate(
      county = as.character(county),
      year = as.integer(paste0("20", yearnum)),
      violent_crime = murder + rape + robbery + assault,
      property_crime = burglary + larcenytft + mvtft + arson
    ) %>%
    select(county, year, violent_crime, murder:assault, property_crime, burglary:arson)
  
  return(output)
}


# read all files
dfs_fbi <- lapply(paths_fbi, read_fbi)
dfs_isp <- lapply(paths_isp, read_isp)


# combine each into a single table
crimes_fbi <- do.call("rbind", dfs_fbi)
crimes_isp <- do.call("rbind", dfs_isp)


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


# export data
write.csv(crimes_fbi, "crimes_fbi.csv")
write.csv(crimes_isp, "crimes_isp.csv")


# clear environmet
rm(list = ls())
