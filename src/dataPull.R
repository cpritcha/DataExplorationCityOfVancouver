install.packages("checkpoint")
install.packages("dplyr")
install.packages("stringr")
install.packages("RCurl")

library(checkpoint)
checkpoint("2015-11-17")

require("dplyr")

# Download business license data
library(stringr)
library(RCurl)

DATA_DIR = "C:/Users/Jimmy/Documents/GitHub/DataExplorationCityOfVancouver/data"

download_dataset <- function(year, base_url) {
  fname <- str_c(year, "business_licences_csv.zip")
  url <- str_c(base_url, fname)
  dest <- str_c(DATA_DIR, "/", fname)
  
  cat("downloading:", url, "\n")
  content <- getBinaryURL(url = url)
  cat("downloaded:", url, "\n")
  
  con <- file(dest, open = "wb")
  writeBin(content, con)
  close(con)
  cat("wrote:", dest, "\n")
}

download_datasets <- function() {
  years <- 1997:2014
  base_url <- "ftp://webftp.vancouver.ca/OpenData/csv/"
  
  for (year in years) {
    download_dataset(year=year, base_url=base_url)
  }
  download_dataset(year="", base_url=base_url)
}

unzip_datasets <- function() {
  fnames <- list.files(DATA_DIR, pattern = "*.zip", full.names = TRUE)
  for (fname in fnames) {
    cat("unzipping:", fname, "\n")
    unzip(fname,overwrite = TRUE, exdir=DATA_DIR)
  }
}

prepare <- function() {
  # Run this to download data and extract files
  download_datasets()
  unzip_datasets()
}

