# Download business license data
library(dplyr)
library(stringr)
library(RCurl)

DATA_DIR = "data"

# Download the data
download_dataset <- function(year, base_url, out_year=year) {
  fname <- str_c(year, "business_licences_csv.zip")
  url <- str_c(base_url, fname)
  dest <- str_c(DATA_DIR, "/", str_c(out_year, ".zip"))

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
  download_dataset(year="", base_url=base_url, out_year = 2015)
}

unzip_datasets <- function() {
  years <- 1997:2015
  fnames <- str_c(DATA_DIR, "/", years, ".zip")
  stopifnot(all(!is.na(years)))
  for (i in seq_along(fnames)) {
    fname <- fnames[i]
    src <- str_c(DATA_DIR, "/", unzip(fname, list=TRUE)$Name)
    cat("src: ", src, "\n")
    if (length(file) > 1) {
      stop("zip file should only have one file in it")
    }
    unzip(fname, overwrite = TRUE, exdir=DATA_DIR)
    dest <- str_c(DATA_DIR, "/", years[i], ".csv")
    cat("dest", dest, "\n")
    file.rename(src, dest)
  }
}

# Run this to download data and extract files
prepare <- function() {
  download_datasets()
  unzip_datasets()
}

load_datasets <- function() {
  fnames <- list.files(DATA_DIR, pattern = "*.csv$")
  years <- str_match(fnames, "^[0-9]{4}")
  stopifnot(all(!is.na(years)))

  dfs <- list()
  for (i in seq_along(fnames)) {
    fname <- fnames[i]
    full_fname <- str_c(DATA_DIR, "/", fname)
    dfs[[years[i]]] <- read.csv(full_fname, stringsAsFactors = FALSE)
  }
 
  dfs
}

add_years <- function(dfs) {
  years <- names(dfs)
  new_dfs <- list()
  for (year in years) {
    new_dfs[[year]] <- dfs[[year]] %>% mutate(year=as.integer(year))
  }
  new_dfs
}

# create a dataset of all data with a year column
stack <- function() {
  dfs <- load_datasets()
  new_dfs <- add_years(dfs)
  stacked_df <- bind_rows(new_dfs)
  #save(stacked_df, file = "data/allyears.RData")
  stacked_df
}
