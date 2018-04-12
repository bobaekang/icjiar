library(dplyr)
library(readxl)
library(foreign)


# get file paths
dirname = "crimes"
paths_isp <- paste0(dirname, "/", list.files(path = dirname, pattern = "^isp.*"))
paths_fbi <- paste0(dirname, "/", list.files(path = dirname, pattern = "^fbi.*"))


# (INCOMPLETE!!)
# define functions to read files 
read_isp <- function(path) {
  if (grepl("dbf$", path)) {
    output <- foreign::read.dbf(path)
    if (ncol(output) == 35) {
      output <- output %>%
        filter(!is.na(AGENCY)) %>%
        select(COUNTY, MURDER:ARSON) 
    } else {
      output <- output %>%
        filter()
    }
  } else {
    if (grepl("2011", path)) {
      output <- readxl::read_excel(path, skip = 2)
    } else {
      output <- readxl::read_excel(path)
    }
    output <- output %>%
      filter(!is.na(Agency)) %>%
      select(grep(".*[^chg|Chg]$", colnames(.), value = TRUE)) %>%
      select(-c(Agency, AgencyType, Multicnty, Verified))
  }
  
  colnames(output) <- tolower(colnames(output))
  return(output)
}


read_fbi <- function(path) {
  output <- readxl::read_excel(path, skip = 5) %>%
    select(2:ncol(.)) %>%
    arrange(County)
  
  colnames1 <- c(
    'county',
    'violentCrime',
    'murder',
    'rape_old',
    'robbery',
    'aggAssult',
    'propertyCrime',
    'burglary',
    'larcenyTft',
    'MVTft',
    'arson'
  )
  colnames2 <- c(
    colnames1[1:3],
    'rape_new',
    colnames1[4:11]
  )
  
  if(ncol(output) == 11){
    colnames(output) <- colnames1
  } else{
    colnames(output) <- colnames2
  }
  
  return(output[!is.na(output$county), ])
}


# read files
dfs_isp <- lapply(files_isp, read_isp)
dfs_fbi <- lapply(files_fbi, read_fbi)