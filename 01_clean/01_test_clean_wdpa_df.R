
#######################################################
# Clean: WDPA (Protected Areas Data)
#######################################################

#######################################################
# Preamble
#######################################################

# Clear Variables
remove(list = ls())
# Capture Today's Date
today <- Sys.Date()
today <- format(today, format = "%y%m%d")

# Set Working Directory
user <- Sys.info()["user"]
if (user == "ryanm") {
    # Ryan 
    setwd("C:/Users/ryanm/Dropbox (Personal)/Protected_Areas")
}
if (user == "mbraaksma") {
    # Matt
    setwd("/Volumes/GoogleDrive-105356043703869020275/My Drive/Research/protected_areas")
}

#######################################################
# Library
#######################################################

# Cleaning Data 
library(data.table)
# Spatial Data 
library(sf)
library(tmap)


#######################################################
# 01: Import WDPA
#######################################################

# Bring in raw WDPA data
gdb <- "../data/WDPA/raw/WDPA_Jan2023_Public.gdb"

wdpa_raw <- st_read(dsn = gdb)
           
# Query not working         
    # Check Layers within
#     st_layers(dsn = gdb) # Select the Polygons for the parks. 
#         # TODO: Will need to check out the point layer to see how this is different sometime
# wdpa_raw <- st_read(dsn = gdb, 
#                     # Only select Costa Rica parks
#                     query = "SELECT * FROM \"WDPA_poly_Jan2023\" WHERE ISO3 = 'CRI'")

# Subset to Costa Rica 
wdpa <- wdpa_raw[wdpa_raw$ISO3 == "CRI",]

# Plot
tm_shape(wdpa) + tm_borders()


#######################################################
# 02: Clean Data
#######################################################

# Remove problematic observations
# check for invalid geometries
sum(wdpa[st_is_valid(wdpa) == FALSE,])
wdpa <- wdpa[st_is_valid(wdpa) == TRUE,]

# Create generally useful information (dummies)
wdpa$ANY_MARINE <- ifelse(wdpa$MARINE > 0, 1, 0)

# Only keep needed variables 
wdpa_tab <- wdpa[, c("WDPAID", "STATUS_YR", "ANY_MARINE")]
wdpa_geom <- wdpa[, c("WDPAID", "SHAPE")]


#######################################################
# 03: Save Cleaned Data
#######################################################

# Save Tabular data 
st_write(wdpa_tab, "../data/WDPA/clean/wdpa_tab.csv")

# Save Geometries 
st_write(wdpa_geom, "../data/WDPA/clean/wdpa_geom.shp")


