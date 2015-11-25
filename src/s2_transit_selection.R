# stage 2: subset the data for geocoding 
library(dplyr)
library(stringr)

source("src/utils.R")
load("data/allyears.RData")

areas <- c("Shaughnessy",
           "Riley Park", 
           "South Cambie",
           "Oakridge",
           "Sunset",
           "Marpole",
           "Fairview",
           "Mount Pleasant",
           "Central Business/Downtown",
           "West End",
           "Strathcona")

df <- stacked_df %>%
  mutate(Areas = str_sub(LocalArea, 4))

# subset data to the area around the site 
before_and_after <- df %>%
  filter(year %in% YEARS) %>%
  filter(Areas %in% areas)

save(before_and_after, file = "data/stage2.RData")

missing_latlongs <- before_and_after %>% 
  filter(is.na(Latitude) & Street != "") %>%
  mutate(address = make_address(House, Street)) %>%
  distinct(address) %>%
  select(address)

# write missing addresses to file for geocoding with python
write.table(missing_latlongs, 
            file="data/addresses.txt", row.names=F, sep=",", col.names=F, quote=F)
