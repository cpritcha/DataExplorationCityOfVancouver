##################################################################################
# This takes the complete data, and seperates them first by year,
# then by whether they are close to the station or not
# and finally into whether they are Residential, Disposable, or Other type

# BussinessType has 181 levels in the complete data set, I remove the 
# ones that are not relevant in Res, Dis, and Other in the final seperation step
# This allows for easier graph production

# Using the last year * close to station * Res, Dis, Other = 3 * 2 * 3 = 12
# Thus, there are a total of 12 sub data set in the format of 
#
#                       data(YR)(S/V).(R/D/O)
#               
# ex: data08V.D, which represents the data for 08, not close to station
#     and contains only businesses of type Disposable.
#     Using levels(data08V.D$BusinessType) confirms unnecessary levels are removed
#######################################################################################




rm(list=ls())

# Seperation of data as below

# Year
# close to station vs All of Vancouver
# Residential, Disposable 
# Plot


data.final <- read.csv(file = "complete.txt", header=TRUE, sep=',')

###################
# seperate by year
###################
data02 <- subset(data.final, data.final$Year == 2002)
data08 <- subset(data.final, data.final$Year == 2008)
data14 <- subset(data.final, data.final$Year == 2014)

##############################
# Seperate by Close to Station 
##############################

# S denotes close to station, V denotes in Vancouver (not close to station)
data02S <- subset(data02, !is.na(StationName))
data02V <- subset(data02, is.na(StationName))
data08S <- subset(data08, !is.na(StationName))
data08V <- subset(data08, is.na(StationName))
data14S <- subset(data14, !is.na(StationName))
data14V <- subset(data14, is.na(StationName))

##############################################
# Seperate by Disposable, Residential or other
##############################################

# .D, .R, .O stands for Disposable, Residential, and Others respectively

# 2002
data02S.D <- subset(data02S, IsDisposable == TRUE)
data02S.R <- subset(data02S, IsResidential == TRUE)
data02S.O <- subset(data02S, IsDisposable == FALSE & IsResidential == FALSE)
data02V.D <- subset(data02V, IsDisposable == TRUE)
data02V.R <- subset(data02V, IsResidential == TRUE)
data02V.O <- subset(data02V, IsDisposable == FALSE & IsResidential == FALSE)

# Because $BusinessType by default has 181 levels, I drop all the levels
# that are not found in the sub-data

data02S.D$BusinessType <- factor(data02S.D$BusinessType)
data02S.R$BusinessType <- factor(data02S.R$BusinessType)
data02S.O$BusinessType <- factor(data02S.O$BusinessType)
data02V.D$BusinessType <- factor(data02V.D$BusinessType)
data02V.R$BusinessType <- factor(data02V.R$BusinessType)
data02V.O$BusinessType <- factor(data02V.O$BusinessType)

# 2008
data08S.D <- subset(data08S, IsDisposable == TRUE)
data08S.R <- subset(data08S, IsResidential == TRUE)
data08S.O <- subset(data08S, IsDisposable == FALSE & IsResidential == FALSE)
data08V.D <- subset(data08V, IsDisposable == TRUE)
data08V.R <- subset(data08V, IsResidential == TRUE)
data08V.O <- subset(data08V, IsDisposable == FALSE & IsResidential == FALSE)

data08S.D$BusinessType <- factor(data08S.D$BusinessType)
data08S.R$BusinessType <- factor(data08S.R$BusinessType)
data08S.O$BusinessType <- factor(data08S.O$BusinessType)
data08V.D$BusinessType <- factor(data08V.D$BusinessType)
data08V.R$BusinessType <- factor(data08V.R$BusinessType)
data08V.O$BusinessType <- factor(data08V.O$BusinessType)

#2014
data14S.D <- subset(data14S, IsDisposable == TRUE)
data14S.R <- subset(data14S, IsResidential == TRUE)
data14S.O <- subset(data14S, IsDisposable == FALSE & IsResidential == FALSE)
data14V.D <- subset(data14V, IsDisposable == TRUE)
data14V.R <- subset(data14V, IsResidential == TRUE)
data14V.O <- subset(data14V, IsDisposable == FALSE & IsResidential == FALSE)

data14S.D$BusinessType <- factor(data14S.D$BusinessType)
data14S.R$BusinessType <- factor(data14S.R$BusinessType)
data14S.O$BusinessType <- factor(data14S.O$BusinessType)
data14V.D$BusinessType <- factor(data14V.D$BusinessType)
data14V.R$BusinessType <- factor(data14V.R$BusinessType)
data14V.O$BusinessType <- factor(data14V.O$BusinessType)


###############################
# house keeping double checking
###############################
levels(data02S.D$BusinessType)
levels(data02V.D$BusinessType)
levels(data02S.R$BusinessType)
levels(data02S.O$BusinessType)
summary(data02S.D$BusinessType)
hist(table(factor(data02S.D$BusinessType)))
length(table(data02S.D$BusinessType))
hold <- factor(data02S.D$BusinessType)

#################################
#          Plot
#################################


# Plotting goes here



##### General exploration #########


# obs that are within 1k of station, and is a Disposable or Residential  
data.station <- subset(data.final, (data.final$IsDisposable == "TRUE"
                       | data.final$IsResidential == "TRUE") & !is.na(data.final$StationName)) 


# How many obs are within 1k
# 1/3 of all business are within 1k of a skytrain station
dim(subset(data.final, !is.na(StationName))) #48179 obs
dim(subset(data.final, is.na(StationName))) #80693 obs






