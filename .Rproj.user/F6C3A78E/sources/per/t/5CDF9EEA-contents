#' Crime in Illinois 2011-2015 from FBI.
#'
#' The county-level crime data in Illinois from 2011 to 2015 extracted from
#' the Federal Bureau of Investigation's Crime in the United States (CIUS)
#' Uniform Crime Reports (UCR) publications.
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
