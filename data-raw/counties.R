# get pipe
`%>%` <- dplyr::`%>%`


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
  dplyr::transmute(
    name = as.character(CNTYNAM_LO),
    name = ifelse(name == "DeWitt", "De Witt", name),
    type = COUNTYTYPE,
    region = ifelse(
      as.character(CNTYNAM_LO) == "Cook", "Cook", ifelse(
        as.character(REGION) == "South", "Southern", ifelse(
          as.character(REGION) == "North", "Northern", "Central"
        )
      )
    ),
    # fix region information for Kankakee and LaSalle (08132018)
    region = ifelse(
      FIPS_CODE == 17091, "Central", ifelse(
        FIPS_CODE == 17099, "Northern", region
      )
    ),
    circuit = as.character(CIRCUIT),
    idoc = as.integer(as.character(IDOC_CODE)),
    fips = as.integer(as.character(FIPS_CODE))
  ) %>%
  dplyr::left_join(
    dplyr::select(rural_urban, fips, rural_urban_2010, rural_percentile_2010)
  )


# use data
devtools::use_data(counties, overwrite = TRUE)
