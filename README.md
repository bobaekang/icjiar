# icjiar

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This is an R package for [the Illinois Criminal Justice Information Authority (ICJIA)](http://www.icjia.state.il.us/). The package includes sample datasets to be used in the ICJIA R Workshop as well as a few other functions to facilitate common tasks. Please refer to [the workshop website](https://bobaekang.github.io/icjia-r-workshop/) for more on the workshop and the relevant materials.

The sample datasets in this package include:
* `counties`: Spatial object containing the county-level information
* `crimes_fbi`: County-level data for crime in Illinois from 2010 to 2016, provided by FBI
* `crimes_isp`: County-level data for crime in Illinois from 2001 to 2015, provided by Illinois State Police
* `fbicrime`: County-level data for crime in Illinois from 2011 to 2015, provided by FBI (This will deprecate; use `crimes_fbi` instead)
* `ispcrime`: County-level data for crime in Illinois from 2011 to 2015, provided by Illinois State Police (This will deprecate; use `crimes_isp` instead) 
* `populations`: County-level data for population estimates from 2000 to 2017, collected from the Illinois Center for Health Statistics and the U.S. Census Bureau data.
* `regions`: Regional categories for Illinois counties (central, Cook, northern, and southern)