library(dplyr)


# get standard county names
source("data-raw/std_county_names.R")


# import shapefile
counties <- sp::spTransform(
  x = rgdal::readOGR(dsn = "data-raw", layer = "counties"),
  CRSobj = sp::CRS("+proj=longlat +ellps=GRS80")
)


# prepare data
counties@data <- counties@data %>%
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
    circuit = CIRCUIT,
    idoc = IDOC_CODE,
    fips = FIPS_CODE
  )


# use data
devtools::use_data(counties, overwrite = TRUE)
