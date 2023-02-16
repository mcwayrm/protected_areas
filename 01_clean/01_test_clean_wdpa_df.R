
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
gdb <- "./data/WDPA/raw/WDPA_Jan2023_Public.gdb"
wdpa_raw <- st_read(dsn = gdb)
                    
    # Check Layers within
#     st_layers(dsn = gdb) # Select the Polygons for the parks. 
#         # TODO: Will need to check out the point layer to see how this is different sometime
# wdpa_raw <- st_read(dsn = gdb, 
#                     # Only select Costa Rica parks
#                     query = "SELECT * FROM \"WDPA_poly_Jan2023\" WHERE ISO3 = 'CRI'")

# Subset to Costa Rica 
wdpa <- wdpa_raw[wdpa_raw$ISO3 == "CRI",]



tm_shape(wdpa) + tm_borders() + tmap_options(check.and.fix = TRUE)


#######################################################
# 02: Clean Data
#######################################################

# Only keep needed variables 


# Remove problematic observations
# check for invalid geometries
sum(wdpa[st_is_valid(wdpa) == FALSE,])
wdpa <- wdpa[st_is_valid(wdpa) == TRUE,]

# Create generally useful information (dummies)



#######################################################
# 03: Save Cleaned Data
#######################################################

# Save Tabular data 
write.csv()

# Save Geometries 
st_write()

