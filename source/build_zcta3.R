library(dplyr)
library(sf)

create_data <- function(year){

  ## switch year if necessary
  if (year == 2011){
    year <- 2010
  }

  ## download geometry
  out <- tigris::zctas(year = year)

  ## rename ZCTA3
  if (year >= 2020){
    out <- mutate(out, ZCTA3 = substr(GEOID20, 1, 3))
  } else if (year < 2020){
    out <- mutate(out, ZCTA3 = substr(GEOID10, 1, 3))
  }

  ## geoprocess - dissolve
  out %>%
    select(ZCTA3) %>%
    group_by(ZCTA3) %>%
    summarise() -> out

  ## geoprocess - simplify
  out <- sf::st_simplify(out, preserveTopology = TRUE, dTolerance = 20)

  ## write data
  sf::st_write(out, dsn = paste0("data/zcta3_", year, ".geojson"), delete_dsn = TRUE)

}

create_data(year = 2019)
