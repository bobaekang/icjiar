#' Crime in Illinois 2010-2016 from FBI.
#'
#' The county-level crime data in Illinois from 2010 to 2016 extracted from
#' the Federal Bureau of Investigation's Crime in the United States (CIUS)
#' Uniform Crime Reports (UCR) publications.
#'
#' @format A data frame with 13 variables:
#' \describe{
#' \item{\code{year}}{Calendar year}
#' \item{\code{county}}{County name}
#' \item{\code{violent_crime}}{Total sum of violent crime, including murder, rape, roberry and aggravated assault}
#' \item{\code{murder}}{Count of murder}
#' \item{\code{rape_old}}{Count of rape, based on an old definition, until 2013}
#' \item{\code{rape_new}}{Count of rape, based on a new definition, from 2014 onward}
#' \item{\code{robbery}}{Count of robbery}
#' \item{\code{assault}}{Count of aggrevated assault}
#' \item{\code{property_crime}}{Total sum of property crime, including  burglary, larceny-theft, motor vehicle-theft and arson}
#' \item{\code{burglary}}{Count of burglary}
#' \item{\code{larcenytft}}{Count of larceny-theft}
#' \item{\code{mvtft}}{Count of motor vehicle-theft}
#' \item{\code{arson}}{Count ofarson}
#' }
#'
#' @source \url{https://ucr.fbi.gov/ucr-publications}
"crimes_fbi"


#' Crime in Illinois 2001-2015 from ISP.
#'
#' The county-level crime data in Illinois from 2001 to 2015 extracted from
#' the Illinois State Police's Unifrom Crime Reports (UCR) annual reports.
#'
#' @format A data frame with 12 variables:
#' \describe{
#' \item{\code{year}}{Calendar Year}
#' \item{\code{county}}{County name}
#' \item{\code{violent_crime}}{Total sum of violent crime, including murder, rape, roberry and aggravated assault}
#' \item{\code{murder}}{Count of murder}
#' \item{\code{rape}}{Count of rape}
#' \item{\code{robbery}}{Count of robbery}
#' \item{\code{assault}}{Count of aggrevated assault}
#' \item{\code{property_crime}}{Total sum of property crime, including burglary, larceny-theft, motor vehicle-theft and arson}
#' \item{\code{burglary}}{Count of burglary}
#' \item{\code{larcenytft}}{Count of larceny-theft}
#' \item{\code{mvtft}}{Count of motor vehicle-theft}
#' \item{\code{arson}}{Count ofarson}
#' }
#'
#' @source \url{https://www.isp.state.il.us/crime/ucrhome.cfm}
"crimes_isp"


#' Crime in Illinois 2011-2015 from FBI.
#'
#' The county-level crime data in Illinois from 2011 to 2015 extracted from
#' the Federal Bureau of Investigation's Crime in the United States (CIUS)
#' Uniform Crime Reports (UCR) publications. This will deprecate in future versions;
#' Use \code{crimes_fbi} instead.
#'
#' @format A data frame with 13 variables:
#' \describe{
#' \item{\code{year}}{Calendar year}
#' \item{\code{county}}{County name}
#' \item{\code{violentCrime}}{Total sum of violent crime, including murder, rape, roberry and aggravated assault}
#' \item{\code{murder}}{Count of murder}
#' \item{\code{rape_old}}{Count of rape, based on an old definition, until 2013}
#' \item{\code{rape_new}}{Count of rape, based on a new definition, from 2014 onward}
#' \item{\code{robbery}}{Count of robbery}
#' \item{\code{aggAssault}}{Count of aggrevated assault}
#' \item{\code{propertyCrime}}{Total sum of property crime, including  burglary, larceny-theft, motor vehicle-theft and arson}
#' \item{\code{burglary}}{Count of burglary}
#' \item{\code{larcenyTft}}{Count of larceny-theft}
#' \item{\code{MVTft}}{Count of motor vehicle-theft}
#' \item{\code{arson}}{Count ofarson}
#' }
#'
#' @source \url{https://ucr.fbi.gov/ucr-publications}
"fbicrime"


#' Crime in Illinois 2011-2015 from ISP.
#'
#' The county-level crime data in Illinois from 2011 to 2015 extracted from
#' the Illinois State Police's Unifrom Crime Reports (UCR) annual reports.
#' This will deprecate in future versions; use \code{crimes_isp} instead.
#'
#' @format A data frame with 12 variables:
#' \describe{
#' \item{\code{year}}{Calendar Year}
#' \item{\code{county}}{County name}
#' \item{\code{violentCrime}}{Total sum of violent crime, including murder, rape, roberry and aggravated assault}
#' \item{\code{murder}}{Count of murder}
#' \item{\code{rape}}{Count of rape}
#' \item{\code{robbery}}{Count of robbery}
#' \item{\code{aggAssault}}{Count of aggrevated assault}
#' \item{\code{propertyCrime}}{Total sum of property crime, including burglary, larceny-theft, motor vehicle-theft and arson}
#' \item{\code{burglary}}{Count of burglary}
#' \item{\code{larcenyTft}}{Count of larceny-theft}
#' \item{\code{MVTft}}{Count of motor vehicle-theft}
#' \item{\code{arson}}{Count ofarson}
#' }
#'
#' @source \url{https://www.isp.state.il.us/crime/ucrhome.cfm}
"ispcrime"


#' Regional Categories for Illinois Counties.
#'
#' Illinois counties are categorised into three larger regions: Northern,
#' Central, and Southern. Note that the Cook county is of its own category.
#'
#' @format A data frame with 2 variables: \code{region} and \code{county}
#'
#' @source \url{https://www.isp.state.il.us/crime/ucrhome.cfm}
"regions"


#' Illinois Counties.
#'
#' A \code{SpatialPolygonsDataFrame} object containing the Illinois counties polygons with
#' additional attributes. See "Format" below for more on the \code{data} table for
#' the attributes.
#'
#' @format A data frame with 7 variables
#' \describe{
#' \item{\code{name}}{County name}
#' \item{\code{id}}{ID number}
#' \item{\code{type}}{Type of the county: Cook, Collar, Rural, or Urban}
#' \item{\code{region}}{Region of the county: Central, North, or South}
#' \item{\code{circuit}}{Illinois juditical circuit number}
#' \item{\code{IDOC}}{Illinois Department of Correction code}
#' \item{\code{FIPS}}{Federal Information Processing Standards code}
#' }
#'
"counties"


#' Illinois Population Estimates by County
#'
#' Illinois population estimates by county from 2001 to 2017. Population data
#' for the first ten years come from Illinois Center for Health Statistics.
#' Population data for the following years use the latest Annual Estimates of
#' the Resident Population by the U.S. Census Bureau.
#'
#' @format A data frame with 3 variables: \code{year}, \code{county} and \code{population}
#'
#' @source \url{https://data.illinois.gov/dataset/539illinois_population_20002009} and
#' \url{https://factfinder.census.gov/faces/tableservices/jsf/pages/productview.xhtml?pid=PEP_2017_PEPANNRES&prodType=table}
"populations"
