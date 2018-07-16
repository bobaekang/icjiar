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

# standard name to join
to_join <-
  counties@data %>%
  distinct(CNTYNAM_LO, FIPS_CODE) %>%
  arrange(CNTYNAM_LO) %>%
  cbind(name = county_std) %>%
  mutate(
    county = as.character(CNTYNAM_LO),
    name = ifelse(county == "LaSalle", "La Salle", as.character(name)),
    name = ifelse(county == "Lake", "Lake", as.character(name))
  ) %>%
  distinct(FIPS_CODE, name)


# prepare data
counties@data <-
  counties@data %>%
  left_join(to_join) %>%
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
