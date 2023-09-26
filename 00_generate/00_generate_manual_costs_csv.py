##########
# Purpose: 
    # This code generates a csv for a 5% of each the countries in the WDPA data. 
    # This creates the template for the manual data collection (for checking data entry) of the costs.
# !!!!!!!!!!! WARNING !!!!!!!!!!!
    # If you re-run this code, it will overwrite the current data from the manual data collection.
    # Before re-running, save existing manual data collection elsewhere to copy back in after edits are made. 
##########

# TODO: .py has issue with relative paths for reading data. 
# TODO: Need to update with the notebook. Can wait until completed before proceeding. 

# Libraries
import geopandas as gpd # Work with shapefiles
import pandas as pd # Work with tabular data
import numpy as np # Work with arrays and math
from pathlib import Path # Call local path for files

# Set Seed 
import random
random.seed(12345)

# Imports PA dataset
wdpa = gpd.read_file("../../data/WDPA/raw/WDPA_Jan2023_Public.gdb")

# Create new variable of ISO3 to desginate if a park is international (e.g., multiple ISO3 codes)
wdpa["ISO3_Int"] = np.where(wdpa["ISO3"].str.contains(";"), "INT", wdpa["ISO3"])

# Get list of unique country ISO3 codes 
list_countries = set(wdpa["ISO3_Int"])

# Loop through countries 
for country in list_countries: 
    # Subset for country
    wdpa_country = wdpa[wdpa["ISO3_Int"] == country]

    # Only keep necessary info
    wdpa_country = pd.DataFrame(
                wdpa_country[["WDPAID", "WDPA_PID", "NAME", 
                        "ORIG_NAME", "DESIG_ENG", "DESIG_TYPE", 
                        "MARINE", "STATUS_YR", "OWN_TYPE", 
                        "MANG_AUTH", "ISO3"]]
    )

    # Add variables to collect info on costs
    added_vars = ["cost_established", "cost_maintainted"]
    for var in added_vars:
        wdpa_country[var] = ""
        wdpa_country[var + "_units"] = ""
        wdpa_country[var + "_source"] = ""

    # Proper subsampling of 5% of parks from every country to check.
    wdpa_country = wdpa_country.sample(frac = 0.05)
    
    # Export template for manual data entry
    filepath = Path('../../data/WDPA/costs/manual/costs_' + country + '_manual.csv')  
    filepath.parent.mkdir(parents = True, exist_ok = True)  
    wdpa_country.to_csv(filepath, index = False)  
