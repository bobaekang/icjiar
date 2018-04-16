# get standard county names
source("data-raw/std_county_names.R")


# import shapefile
counties <- sp::spTransform(
  x = rgdal::readOGR(dsn = "data-raw", layer = "counties"),
  CRSobj = sp::CRS("+proj=longlat +ellps=GRS80")
)


# change county names
counties@data <- dplyr::arrange(
  dplyr::mutate(counties@data, name = as.character(name)),
  name
)

counties@data$name <- as.factor(county_std)


# use data
devtools::use_data(counties, overwrite = TRUE)
