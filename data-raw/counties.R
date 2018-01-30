# import shapefile
counties <- sp::spTransform(
  x = rgdal::readOGR('data-raw', 'counties'),
  CRSobj = sp::CRS("+proj=longlat +ellps=GRS80")
)

# use data
devtools::use_data(counties, overwrite = TRUE)
