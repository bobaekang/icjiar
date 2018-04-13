library(dplyr)
# library(tidyr)


# get standard county names
source("std_county_names.R")


# get paths
path_pop_2000s <- "https://data.illinois.gov/dataset/27a3da67-23d5-494e-b5f4-8ec2b4db2220/resource/f048f107-74d2-4df0-990c-09f214c0bf35/download/data.csv"
path_pop_2010s <- "population_estimate_2017.csv"


# read files
pop_2000s <- read.csv(path_pop_2000s)
pop_2010s <- read.csv(path_pop_2010s, skip = 1)


# define function to clean data
clean_pop <- function(pop, decade = "2000s") {
  gather_years <- function(pop) {
    pop %>%
      tidyr::gather(
        key = "year",
        value = "population",
        2:ncol(.)
      ) %>%
      mutate(year = as.integer(substr(year, 3, 7)))
  }
  
  if (decade == "2000s") {
    output <- pop %>%
      filter(county != "Illinois") %>%
      select(ncol(.), 1:(ncol(.) - 1)) %>%
      mutate(county = as.character(county)) %>%
      gather_years()
    
    return(output)
  } else if (decade == "2010s") {
    output <- pop %>%
      select(3, 6:ncol(.))
      
    colnames(output) <- c("county", paste0("X_", 2010:(2010 + ncol(output) - 2)))
    
    output <- output %>%
      mutate(county = gsub(" County, Illinois", "", as.character(county))) %>%
      gather_years()
    
    return(output)
  }
}


# clean and concatenate
populations <- rbind(
  clean_pop(pop_2000s),
  clean_pop(pop_2010s, decade = "2010s")
)


# redo county names
populations <- populations %>%
  arrange(year, county) %>%
  mutate(county = rep(county_std, nrow(.) / 102))


# export data
write.csv(populations, "populations.csv")