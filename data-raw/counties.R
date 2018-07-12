library(dplyr)


# get standard county names
source("data-raw/std_county_names.R")

# get rural-urban categories
rural_urban <- read.csv('data-raw/rural_urban.csv', stringsAsFactors=FALSE)
colnames(rural_urban) <- c("fips", "county", "region", "rural_urban_2010", "rural_percentile_2010")

# import shapefile
counties <- sp::spTransform(
  x = rgdal::readOGR(dsn = "data-raw", layer = "counties"),
  CRSobj = sp::CRS("+proj=longlat +ellps=GRS80")
)


# prepare data
counties@data <-
  counties@data %>%
  left_join(
    data.frame(
      name = county_std,
      FIPS_CODE = as.factor(17000 + seq(1, 102*2, 2))
    )
  ) %>%
  transmute(
    name = name,
    type = COUNTYTYPE,
    region = ifelse(
      as.character(CNTYNAM_LO) == "Cook", "Cook", ifelse(
        as.character(REGION) == "South", "Southern", ifelse(
          as.character(REGION) == "North", "Northern", "Central"
        )
      )
    ),
    circuit = as.integer(as.character(CIRCUIT)),
    idoc = as.integer(as.character(IDOC_CODE)),
    fips = as.integer(as.character(FIPS_CODE))
  ) %>%
  left_join(select(rural_urban, fips, rural_urban_2010, rural_percentile_2010))


# use data
devtools::use_data(counties, overwrite = TRUE)
