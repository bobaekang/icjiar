# define a function to standardize county names
standardize_county <- function(df) {
  county_to_fix <- c("De Kalb", "DuPage", "La Salle")

  dplyr::mutate(
    df,
    county = as.character(county),
    county = ifelse(county %in% county_to_fix, gsub(" ", "", county), county)
  )
}


# import data (old)
fbicrime <- standardize_county(read.csv("data-raw/fbicrime.csv"))
ispcrime <- standardize_county(read.csv("data-raw/ispcrime.csv"))


# import data (new)
crimes_fbi <- standardize_county(read.csv("data-raw/crimes_fbi.csv"))
crimes_isp <- standardize_county(read.csv("data-raw/crimes_isp.csv"))


# use data
devtools::use_data(fbicrime, ispcrime, crimes_fbi, crimes_isp, overwrite = TRUE)
