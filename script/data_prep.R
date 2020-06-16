# Making dataset for training course

library(tidyverse)
library(readxl)
library(sf)

simd_2009 <- read_excel(here::here("data", "simd-2009-overall.xls"))
simd_2012 <- read_excel(here::here("data", "simd-2012-overall.xls"))
simd_2016 <- read_excel(here::here("data", "simd-2016-ranks.xlsx"),
                        sheet = 2)
simd_2020 <- read_excel(here::here("data", "SIMD_2020_Ranks_and_Domain_Ranks.xlsx"),
                        sheet = 2)




simd_2009 <- 
simd_2009 %>% 
  select(3, contains("v2 rank"), contains("2009 Rank"), contains("total population")) %>% 
  select(council_area = contains("authority"),
         overall = contains("2009 v2 rank"),
         health = contains("health"),
         employment = contains("employment"),
         income = contains("income"),
         education = contains("education"),
         access = contains("access"),
         crime = contains("crime"),
         total_pop = contains("population")) %>% 
  mutate(simd = "SIMD 2009")

simd_2012 <- 
simd_2012 %>% 
  select(3, contains("2012 Rank"), contains("total population")) %>% 
  select(council_area = contains("authority"),
         overall = contains("overall"),
         health = contains("health"),
         employment = contains("employment"),
         income = contains("income"),
         education = contains("education"),
         access = contains("access"),
         crime = contains("crime"),
         total_pop = contains("population")) %>% 
  mutate(simd = "SIMD 2012")

simd_2016 <- 
simd_2016 %>% 
  select(Council_area, contains("Rank"), contains("total_population")) %>% 
  select(council_area = Council_area,
         overall = contains("overall"),
         health = contains("health"),
         employment = contains("employment"),
         income = contains("income"),
         education = contains("education"),
         access = contains("access"),
         crime = contains("crime"),
         total_pop = contains("population")) %>% 
  mutate(simd = "SIMD 2016")

simd_2020 <- 
simd_2020 %>% 
  select(Council_area, contains("Rank"), contains("total_population")) %>% 
  select(council_area = Council_area,
         overall = contains("simd2020_rank"),
         health = contains("health"),
         employment = contains("employment"),
         income = contains("income"),
         education = contains("education"),
         access = contains("access"),
         crime = contains("crime"),
         total_pop = contains("population")) %>% 
  mutate(simd = "SIMD 2020")

simd <- 
bind_rows(
  simd_2009,
  simd_2012,
  simd_2016,
  simd_2020
) %>% 
  mutate(council_area = str_replace(council_area, " & ", " and "),
         council_area = str_replace(council_area, "Edinburgh, City of", "City of Edinburgh"),
         council_area = str_replace(council_area, "Eilean Siar", "Na h-Eileanan an Iar")) %>% 
  group_by(council_area, simd) %>% 
  summarise_at(vars(overall:crime), ~ median(.x, na.rm = TRUE)) %>% 
  ungroup()

simd %>% 
  ggplot(aes(x = overall, y = crime)) +
  geom_point(aes(colour = simd)) +
  geom_line(aes(group = council_area)) +
  geom_smooth(aes(colour = simd), se = FALSE)


# adding region variable --------------------------------------------------
simd <- 
simd %>% 
  mutate(division = case_when(
    council_area == "Argyll and Bute"~          "Argyll and West Dunbartonshire (W)",
    council_area == "Highland"~                   "Highlands and Islands (N)",
    council_area == "Orkney Islands"~                   "Highlands and Islands (N)",
    council_area == "Shetland Islands"~                   "Highlands and Islands (N)",
    council_area == "Na h-Eileanan an Iar"~                   "Highlands and Islands (N)",
    council_area == "Aberdeen City"~                              "North East (N)",
    council_area == "Aberdeenshire"~                              "North East (N)",
    council_area == "Moray"~                              "North East (N)",
    council_area == "City of Edinburgh"~                               "Edinburgh (E)",
    council_area == "Fife"~                                    "Fife (E)",
    council_area == "Clackmannanshire"~                            "Forth Valley (E)",
    council_area == "Falkirk"~                            "Forth Valley (E)",
    council_area == "Stirling"~                            "Forth Valley (E)",
    council_area == "Angus"~                                 "Tayside (N)",
    council_area == "Dundee City"~                                 "Tayside (N)",
    council_area == "Perth and Kinross"~                                 "Tayside (N)",
    council_area == "East Lothian"~       "The Lothians and Scottish Borders (E)",
    council_area == "Midlothian"~       "The Lothians and Scottish Borders (E)",
    council_area == "West Lothian"~       "The Lothians and Scottish Borders (E)",
    council_area == "Scottish Borders"~       "The Lothians and Scottish Borders (E)",
    council_area == "Dumfries and Galloway"~                   "Dumfries and Galloway (W)",
    council_area == "East Ayrshire"~                                "Ayrshire (W)",
    council_area == "North Ayrshire"~                                "Ayrshire (W)",
    council_area == "South Ayrshire"~                                "Ayrshire (W)",
    council_area == "East Dunbartonshire"~                         "Greater Glasgow (W)",
    council_area == "West Dunbartonshire"~                         "Greater Glasgow (W)",
    council_area == "East Renfrewshire"~                         "Greater Glasgow (W)",
    council_area == "Glasgow City"~                         "Greater Glasgow (W)",
    council_area == "South Lanarkshire"~                             "Lanarkshire (W)",
    council_area == "North Lanarkshire"~                             "Lanarkshire (W)",
    council_area == "Renfrewshire"~             "Renfrewshire and Inverclyde (W)",
    council_area == "Inverclyde"~             "Renfrewshire and Inverclyde (W)"),
    region = case_when(
      str_detect(division, "(N)") ~ "North",
      str_detect(division, "(W)") ~ "West",
      str_detect(division, "(E)") ~ "East",
    )) %>% 
  select(-division)

simd <- 
simd %>% 
  mutate(year = as.numeric(str_sub(simd, 6, 9)))


# adding shapefile --------------------------------------------------------




la_shp <- read_sf(here::here("data", "la_shapefile.shp"))

la_shp <- 
la_shp %>% 
  select(council_area = concl_r, long, lat, geometry)

simd_2020_shp <- 
left_join(
  la_shp,
  simd %>% 
    filter(simd == "SIMD 2020")
)

simd_2020_shp <- 
simd_2020_shp %>% 
    sf::st_transform(4326)

simd_2020_shp <- 
simd_2020_shp %>% 
  mutate(long = map_dbl(geometry, ~ sf::st_point_on_surface(.x)[[1]]),
         lat = map_dbl(geometry, ~ sf::st_point_on_surface(.x)[[2]]))

simd_2020_shp <- 
simd_2020_shp %>% 
  select(council_area, overall:crime, region, long:geometry)

saveRDS(simd_2020_shp,
        here::here("data", "simd_2020_shp.rds"))

saveRDS(simd,
        here::here("data", "simd_series.rds"))


simd_2020_shp %>% 
  ggplot() +
  geom_sf(aes(geometry = geometry)) +
  coord_sf(crs = 27700)




