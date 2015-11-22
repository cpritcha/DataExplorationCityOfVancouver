library(stringr)

# geocode the missing lat longs
make_address <- function(house_number, street) {
  ifelse(street != "",
         str_c(house_number, " ", street, ", Vancouver, BC"),
         NA)
}

YEARS <- c(2002, 2008, 2014)
STATUSES <- c("Issued", "Pending")