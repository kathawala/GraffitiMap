library(readr)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)
if (length(args)!=1) {
  stop("At least one must be supplied like (input file).csv", call.=FALSE)
} else {
  infile <- args[1]
}

data <- read_csv(infile)
names(data) <- make.names(names(data))

# Data Cleaning
# 1) Filters only the graffiti cases
# 2) Extracts the latitudes and longitudes from the SF Case Data.
# 3) Formats the timestamps correctly
# 4) Makes a location column using Request.Details and Address
# 5) Saves only (Location, Opened, Closed, Status, Request.Type, Long, and Lat into a RDS file)

# (1)
data <- filter(data, grepl("Graffiti", Category))

# (2)
data <- filter(data, !(is.na(Point) | as.character(Point)==""))
lats_and_longs <- gsub("[\\(\\)]", "", as.character(data$Point)) %>%
  strsplit(split=", ") %>%
  unlist %>%
  as.double
data$Lat <- lats_and_longs[c(TRUE, FALSE)]
data$Long <- lats_and_longs[c(FALSE, TRUE)]

# (3)
data$Opened <- as.POSIXct(data$Opened, format="%m/%d/%Y")
data$Closed <- as.POSIXct(data$Closed, format="%m/%d/%Y")

# (4)
data$Request.Details <- gsub(" - .*", "", data$Request.Details)
data$Request.Details <- gsub("Other_enter_additional_details_below", "", data$Request.Details)
data$Request.Details <- gsub("_commercial", "", data$Request.Details)
data$Request.Details <- gsub("_residential", "", data$Request.Details)
data$Request.Details <- gsub("_other", "", data$Request.Details)
data$Request.Details <- gsub("_", " ", data$Request.Details)
data$Location <- paste(data$Request.Details, " @ ", data$Address)

# (5)
# Only select useful columns of the data for saving
data <- select(data, CaseID, Location, Opened, Closed, Status, Request.Type, Long, Lat, Media.URL)

# Keep these dates for quick initialization of UI
dates <- new.env()
assign("max", max(data$Opened), dates)
assign("min", min(data$Opened), dates)
assign("start", max(data$Opened) - (24*60*60*7), dates)

saveRDS(data, "GraffitiMap/SF_Graffiti.Rds")
saveRDS(dates, "GraffitiMap/dates.Rds")
