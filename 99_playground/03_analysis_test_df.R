
#######################################################
# Analysis: Testing Playground
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
if (user == "") {
    # Matt
    setwd("C:/Users/..../Dropbox (Personal)/Protected_Areas")
}

#######################################################
# Library
#######################################################

# Cleaning Data 
library(data.table)
# Spatial Data 
library(sf)
# Plotting Maps
library(tmap)
# Making Plots 
library(ggplot2)
# RDD Estimations
library(rdd)
# Difference in Differences Estimation
library(did)


#######################################################
# 01: Proliferation of Parks over time
#######################################################

# Tabulation of parks by type (level of administration)

# Distribution of the size of parks 

# Count of parks by year established

# CDF of parks year of establishment

# Create a visual animation of the parks coming online

#######################################################
# 02: Parks and Greeness
#######################################################

# Basic OLS reg for difference in greeness on either side


# Nearest Neighbor match for PSM


# RDD 


## Diff n Diff 


# RDD-Disc 
    # TODO: May need to create this package in R (potentially push this to github or CRAN)

# RDD-Disc with PSM


#######################################################
# 03: Marina and Health Water
#######################################################

# Top Measures for Healthy Water: 
    # Temperature > plants and algae grow in warmer waters
    # Dissolved Oxygen (DO): microorganisms need oxygen in water to decompose organic materials
    # pH (acdity): Healthy range is 6.5-8.5
    # Turbidity (clarity of water): How much light passes through. Plants die if not enough light. 
    # https://publiclab.org/notes/anngneal/12-08-2017/7-ways-to-measure-monitor-and-evaluate-water-quality

# Basic OLS reg for difference in healthy water on either side


# Nearest Neighbor match for PSM


# RDD 


## Diff n Diff 


# RDD-Disc 
# TODO: May need to create this package in R (potentially push this to github or CRAN)

# RDD-Disc with PSM




