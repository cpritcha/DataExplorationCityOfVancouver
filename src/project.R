rm(list=ls())

install.packages("dplyr")
library(dplyr)

# Getting data into R

data08 <- read.csv(file = "2008.csv", header=TRUE, sep=',')
data14 <- read.csv(file = "2014.csv", header=TRUE, sep=',')

# Removing Obs with Status that are not Pending or issued
data08 <- subset(data08, Status == "Issued" | Status == "Pending" )
data14 <- subset(data14, Status == "Issued" | Status == "Pending" )

# Adding year to data set

data08$year <- 2008
data14$year <- 2014

data.all <- rbind(data08, data14)

# Calvin's data set with obs that are within 1km of a Canada line station
data.station <- read.csv(file ="data", header=TRUE, sep=',')


# Extracting Primary Business Type

bType08 <- data08$BusinessType
bType14 <- data14$BusinessType
BusinessType.station <- data.station$BusinessTy
BusinessType.all <- data.all$BusinessType


summary(bType08)
head(bType08)
head(bType14)

length(table(bType08))
length(table(bType14))

# Generating frequency table for levels in

B08 <- as.data.frame(table(bType08))
B14 <- as.data.frame(table(bType14))
B.station <- as.data.frame(table(BusinessType.station))
B.all <- as.data.frame(table(BusinessType.all))


# 2014 has one more Business type not found in 2008
length(B08$bType08) #183
length(B.all$Freq)  #184


# Generating indicator variable for Residental

data.all$Residential <- ifelse(data.all$BusinessType == "Apartment House" 
                              | data.all$BusinessType == "Apartment House-99 Year Lease"
                              | data.all$BusinessType == "Apartment House Strata"
                              | data.all$BusinessType == "Artist Live/Work Studio"
                              | data.all$BusinessType == "Bed and Breakfast"
                              | data.all$BusinessType == "Duplex"
                              | data.all$BusinessType == "Hotel"
                              | data.all$BusinessType == "Motel"
                              | data.all$BusinessType == "Multiple Dwelling"
                              | data.all$BusinessType == "Non-profit Housing"
                              | data.all$BusinessType == "One-Family Dwelling"
                              | data.all$BusinessType == "Personal Care Home"
                              | data.all$BusinessType == "Pre-1956 Dwelling "
                              | data.all$BusinessType == "Residential/Commercial"
                              | data.all$BusinessType == "Rooming House"
                              | data.all$BusinessType == "Secondary Suite - Permanent", 1,0)


# Generating Disposable


data.all$Disposable <- ifelse(data.all$BusinessType == "Club" 
                              | data.all$BusinessType == "Dining Lounge *Historic*"
                              | data.all$BusinessType == "Liquor Establishment Extended"
                              | data.all$BusinessType == "Liquor Establishment Standard"
                              | data.all$BusinessType == "Liquor Retail Store"
                              | data.all$BusinessType == "Ltd Service Food Establishment"
                              | data.all$BusinessType == "Restaurant Class 1"
                              | data.all$BusinessType == "Restaurant Class 2"
                              | data.all$BusinessType == "Retail Dealer"
                              | data.all$BusinessType == "Retail Dealer - Food"
                              | data.all$BusinessType == "Retail Dealer - Grocery"
                              | data.all$BusinessType == "Retail Dealer - Market Outlet", 1,0)


# merge data.all and data.station on LicenseRSN


