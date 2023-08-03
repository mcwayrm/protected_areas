
#######################################################
# Generate: Sentiel 2 Data
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
    # condaenv <- 
}
if (user == "mbraaksma") {
    # Matt
    setwd("/Volumes/GoogleDrive-105356043703869020275/My Drive/Research/Protected_Areas")
    env <- "8222env1"
}

#######################################################
# Library
#######################################################

# Import Sentiel Data 
library(reticulate)
use_condaenv(env)
library(rgee)
ee_check()
ee_clean_pyenv()
ee_Initialize()

library(tidyverse)

#######################################################
# 01: Import Sentinel Data
#######################################################

# sentinel2 <- ee$Image("COPERNICUS/S2_SR_HARMONIZED/2023-03-15T15:02:25")$
#   select(c("B4","B8"))
# 
# Map$centerObject(eeObject = sentinel2)
# Map$addLayer(eeObject = sentinel2, visParams = list(max = 0.4,gamma=0.1))
s2 <- ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")
s2.bands <- s2$toBands()

s2.c <- ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")
s2.i <- ee$Image(s2.c)
s2.b <- s2.i$select(c('B8', 'B4'))
s2.r <- ee_as_raster(s2.b, 
                     region = geometry,
                     via = "drive")


s2.c <- ee$Image

# test
# Load an image collection
sen <- ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")$
  filterBounds(ee$Geometry$BBox(-85.94172543, 8.22502798099, -82.5461962552, 11.2171192489))$
  filterDate('2019-01-01', '2019-12-31')$
  sort('CLOUDY_PIXEL_PERCENTAGE')$
  first()



################
# Load an image collection
sen <- ee$ImageCollection("COPERNICUS/S2")$
  filterBounds(ee$Geometry$BBox(-85.94172543, 8.22502798099, -82.5461962552, 11.2171192489))$
  filterDate('2019-01-01', '2019-12-31')$
  sort('CLOUDY_PIXEL_PERCENTAGE')$
  first()

# Define the visualization parameters.
vizParams <- list(
  bands = c("B4", "B3", "B2"),
  min = 0,
  max = 2000,
  gamma = c(0.95, 1.1, 1)
)

# Center the map and display the image.
Map$centerObject(sen, 7)
# You can see it
m1 <- Map$addLayer(sen, vizParams, 'first')
m1
#########





terraclimate <- ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED") %>% # dataset
  ee$ImageCollection$filterDate("2019-01-01", "2019-01-01") %>%   # data range
  ee$ImageCollection$select(c("B4","B8")) %>% # Select only precipitation bands
  ee$ImageCollection$toBands() #%>% # from ImageCollection to Image
  # ee$Image$rename(sprintf("%02d",1:12)) # rename the bands of an image
print(terraclimate)

bandNames <- terraclimate$bandNames()
cat("Band names: ",paste(bandNames$getInfo(),collapse=","))


# Import
sentinel2 <- ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED") %>%
  ee$ImageCollection$filterDate("2019-01-01", "2019-02-01") %>%
  ee$ImageCollection$toBands()

library(terra)
geometry <- ee$Geometry$Rectangle(
  coords = c(-85.94172543, 8.22502798099, -82.5461962552, 11.2171192489),
  proj = "EPSG:4326",
  geodesic = FALSE
)

sentinel2.r <- ee_as_raster(sentinel2,
                            region = geometry,
                            via = "drive")


dataset <- ee$ImageCollection('LANDSAT/LC08/C01/T1_8DAY_EVI')$filterDate('2017-01-01', '2017-12-31')
> ee_print(dataset)

#######################################################
# 02: Clean Data
#######################################################

# Only keep needed variables 

# Remove problematic observations



#######################################################
# 03: Save Data
#######################################################

# Save 

