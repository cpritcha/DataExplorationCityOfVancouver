library(dplyr)
library(ggvis)
data <- read.csv("data/1997business_licences.csv", stringsAsFactors = F)

res <- data %>%
  group_by(LicenceRSN) %>%
  summarise(AveFeePaid = mean(FeePaid), n_fees = length(FeePaid)) %>%
  filter(!is.na(AveFeePaid) & n_fees > 1)

ave_price_by_area <- data %>%
  group_by(LocalArea) %>%
  filter(LocalArea != "") %>%
  summarize(AveFeePaid = mean(FeePaid, na.rm = T), N = length(FeePaid), AveEmp = mean(NumberOfEmployees, na.rm = T))