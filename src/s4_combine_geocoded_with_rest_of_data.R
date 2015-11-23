library(dplyr)

load("data/allyears.RData")

source("src/utils.R")

# Create subset of all data that has a street address with the correct status
all_data <- stacked_df %>%
  filter(year %in% YEARS)
  
# Bring in dist data within 1km of Canada line 
# Remove duplicate RSNs (RSN is supposed to be unique... and it almost is except for 8 rows)
# Duplicate RSNs have the same address and business looks the same but have spelling mistakes
canada_line <- read.csv("data/dist.csv", stringsAsFactors = F) %>%
  distinct(LicenceRSN)

# Create a dataset combining the two

residential_categories <- c(
  "Apartment House",
  "Apartment House-99 Year Lease",
  "Apartment House Strata",
  "Artist Live/Work Studio",
  "Bed and Breakfast",
  "Duplex",
  "Hotel",
  "Motel",
  "Multiple Dwelling",
  "Non-profit Housing",
  "Personal Care Home",
  "Pre-1956 Dwelling ",
  "Residential/Commercial",
  "Rooming House",
  "Secondary Suite - Permanent")

disposable_categories <- c(
  "Club", 
  "Dining Lounge *Historic*",
  "Liquor Establishment Extended",
  "Liquor Establishment Standard",
  "Liquor Retail Store",
  "Ltd Service Food Establishment",
  "Restaurant Class 1",
  "Restaurant Class 2",
  "Retail Dealer",
  "Retail Dealer - Food",
  "Retail Dealer - Grocery",
  "Retail Dealer - Market Outlet")

all_data_with_canada_line <- all_data %>%
  filter(Street != "") %>%
  filter(Status %in% STATUSES) %>%
  full_join(canada_line, 
            by = c("id")) %>%
  mutate(address = make_address(House, Street)) %>%
  distinct(LicenceRSN.x) %>%
  select(ID = id,
         Year = year.x,
         Status,
         LicenceRSN = LicenceRSN.x, 
         BusinessType, 
         Address = address,
         Latitude = Latitude.y, 
         Longitude = Longitude.y,
         StationName = join_Name,
         DistToTracks = d_to_track,
         DistToStation = d_to_stat) %>%
  mutate(IsResidential = BusinessType %in% residential_categories,
         IsDisposable = BusinessType %in% disposable_categories)

write.csv(all_data_with_canada_line, file="data/complete.txt", row.names = F)

different <- all_data_with_canada_line %>%
  anti_join(all_data, by = c("id"))
