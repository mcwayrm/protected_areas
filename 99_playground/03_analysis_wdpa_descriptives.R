# Title: WDPA Descriptives
# Purpose: Summary stats and graphics to better understand protected areas dataset 

##################
# Libraries 
##################
# Import shapefiles  
library(sf)
# Edit data 
library(data.table)
# Visualize Data 
library(ggplot2)
# Descriptive statistics 
library(vtable)
# Create maps 
library(tmap)

##################
# Set Working Directory
##################

# Need to make quick switch based on user 
setwd("C:/Users/ryanm/Dropbox (Personal)/Protected_Areas")

# Load WDPA dataset 
sf_wdpa <- st_read("./data/WDPA/raw/WDPA_Jan2023_Public.gdb", layer = "WDPA_poly_Jan2023")

# Sources
sources_wdpa <- st_read("./data/WDPA/raw/WDPA_Jan2023_Public.gdb", layer = "WDPA_source_Jan2023")
unique(sources_wdpa$data_title)
    # NOTE: These are the 365 sources for the WDPA dataset

# Create a tabular dataset to work with when not plotting 
df_wdpa <- setDT(wdpa)

# List of main varibales in dataset 
vtable(df_wdpa)

# Summary statistics 
sumtable(df_wdpa)
# NOTE: 88% national parks >> mostly federal action 
# NOTE: 93% terresterial >> mostly a land-based policy

# We will want to remove all WDPA that are STATUS == "Not Reported" | "Proposed"
df_wdpa <- df_wdpa[!(STATUS == "Not Reported" | STATUS == "Proposed"),] 
    # TODO: What is the percentage of each status

# Parks below resolution for analysis 
# wdpa['GIS_AREA'] <= .3]
    # TODO: What is the variation in % between the different areas
    # TODO: Which one to use with justification.


# Distribution of year park was established
table(df_wdpa$STATUS_YR)
ggplot(data = subset(df_wdpa, STATUS_YR != 0)) + 
    geom_freqpoly(aes(x = STATUS_YR)) + 
    geom_vline(xintercept = mean(df_wdpa$STATUS_YR))
    # TODO: Save this plot

# TODO: % of parks run by government. 

# TODO: How does size of the park vary by Desig_type, by marine/terresterial, by if managed by gov/NGO

# TODO: Map the parks: (1) showing marine vs. not, (2) showing type of designation, (3) showing year of establishment in bins, (4) showing gov/other ownership 


# TODO: Create some key statistics to capture by country level. Create a table with rows for each country and overall (total) average. 


# TODO: Given these are IUCN and CBD protected area definitions, add that definition into notes for the data description. 
    # TODO: Note htere is a category for park type (IUCN_CAT)


# TODO: What is the difference points and the polygons

# TODO: histogram of park size (marine vs. terresterial)
    # TODO: Binning the type of park (s, m, l)
