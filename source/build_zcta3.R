library(dplyr)
library(sf)

zcta <- tigris::zctas(year = 2020)

zcta %>%
  mutate(ZCTA3 = substr(GEOID20, 1, 3)) %>%
  select(ZCTA3) %>%
  group_by(ZCTA3) %>%
  summarise() -> zcta

zcta <- sf::st_simplify(zcta, preserveTopology = TRUE, dTolerance = 20)

st_write(zcta, dsn = "data-raw/zcta_2020.geojson", delete_dsn = TRUE)

zcta <- tigris::zctas(year = 2021)

zcta %>%
  mutate(ZCTA3 = substr(GEOID20, 1, 3)) %>%
  select(ZCTA3) %>%
  group_by(ZCTA3) %>%
  summarise() -> zcta

zcta <- sf::st_simplify(zcta, preserveTopology = TRUE, dTolerance = 20)
