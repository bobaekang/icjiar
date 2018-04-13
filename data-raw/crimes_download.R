# get URLs: FBI
fbi_url_df <- data.frame(
  url <- paste0(
    "https://ucr.fbi.gov/crime-in-the-u.s/",
    c(
      "2016/crime-in-the-u.s.-2016/tables/table-8/table-8-state-cuts/illinois.xls/output.xls",
      "2015/crime-in-the-u.s.-2015/tables/table-10/table-10-state-pieces/table_10_offenses_known_to_law_enforcement_illinois_by_metropolitan_and_nonmetropolitan_counties_2015.xls/output.xls",
      "2014/crime-in-the-u.s.-2014/tables/table-10/table-10-pieces/Table_10_Offenses_Known_to_Law_Enforcement_Illinois_by_Metropolitan_and_Nonmetropolitan_Counties_2014.xls/output.xls",
      "2013/crime-in-the-u.s.-2013/tables/table-10/table-10-pieces/table_10_offenses_known_to_law_enforcement_by_illinois_by_metropolitan_and_nonmetropolitan_counties_2013.xls/output.xls",
      "2012/crime-in-the-u.s.-2012/tables/10tabledatadecpdf/table-10-state-cuts/table_10_offenses_known_to_law_enforcement_illinois_by_metropolitan_and_nonmetropolitan_counties_2012.xls/output.xls",
      "2011/crime-in-the-u.s.-2011/tables/table10statecuts/table_10_offenses_known_to_law_enforcement_illinois_by_metropolitan_and_nonmetropolitan_counties_2011.xls/output.xls",
      "2010/crime-in-the-u.s.-2010/tables/table-10/10tbl10il.xls/output.xls"
    )
  ),
  filename <- paste0(
    "fbi_",
    c(
      "2016.xls",
      "2015.xls",
      "2014.xls",
      "2013.xls",
      "2012.xls",
      "2011.xls",
      "2010.xls"
    )
  ),
  stringsAsFactors = FALSE
)


# get URLs: isp
isp_url_df <- data.frame(
  url = paste0(
    "http://www.isp.state.il.us/docs/cii/",
    c(
      "cii15/ds/CrimeData_15_14.xlsx",
      "cii14/ds/IndexCrimeDrugArrestData_14_13.xlsx",
      "cii13/ds/IndexCrimeOffenses_Data_13_12.xlsx",
      "cii12/ds/Internet_Crime_12_11.xlsx",
      "cii11/ds/Internet_Crime_11_10.xls",
      "cii09/db/Internet_Crime0908.dbf",
      "cii08/db/Internet_Crime0807.dbf",
      "cii07/db/Internet_Crime0706.dbf",
      "cii06/db/Internet_Crime0605.dbf",
      "cii05/db/internet_crime0504.dbf",
      "cii04/db/internet_crime04_03.dbf",
      "cii03/db/internet_crime03_02.dbf",
      "cii02/db/internet_crime02_01.dbf",
      "cii01/db/IndexOffenses2001,2000.dbf"
    )
  ),
  filename = paste0(
    "isp_",
    c(
      "2015_14.xlsx",
      "2014_13.xlsx",
      "2013_12.xlsx",
      "2012_11.xlsx",
      "2011_10.xls",
      "2009_08.dbf",
      "2008_07.dbf",
      "2007_06.dbf",
      "2006_05.dbf",
      "2005_04.dbf",
      "2004_03.dbf",
      "2003_02.dbf",
      "2002_01.dbf",
      "2001_00.dbf"
    )
  ),
  stringsAsFactors = FALSE
)


# create directory if not already existing
dirname <- "crimes"

if (!dir.exists(dirname)) {
  dir.create(dirname)
}


# download data
download_files <- function(df) {
  for(i in 1:nrow(df)) {
    download.file(
      df$url[i],
      paste(dirname, df$filename[i], sep="/"),
      mode='wb',
      cacheOK=FALSE
    )
  }
}

if (!length(list.files(dirname))) {
  download_files(fbi_url_df)
  download_files(isp_url_df)
}


# clear environmet
rm(list = ls())
