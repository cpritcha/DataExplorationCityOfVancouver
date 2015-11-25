# stage 3: create a dataset to calculate distance from Canada line with
load("data/stage2.RData")

source("src/utils.R")

# Distinct Missing Addresses
missing_geocoded_df <- read.csv("data/geocoded_02_08_14.txt", 
                        head=F, col.names = c("address", "lat", "lng"), stringsAsFactors = F)

# make a new datset from the geocoded data
data_02_08_14 <- before_and_after %>%
  filter(Street != "") %>%
  mutate(address = make_address(House, Street)) %>%
  left_join(y = missing_geocoded_df, by = "address") %>%
  mutate(Latitude = ifelse(is.na(Latitude), lat, Latitude),
         Longitude = ifelse(is.na(Longitude), lng, Longitude)) %>%
  select(id, LicenceRSN, BusinessType, Latitude, Longitude, year, address)

write.table(data_02_08_14, file = "data/stage3.csv", row.names = F)

