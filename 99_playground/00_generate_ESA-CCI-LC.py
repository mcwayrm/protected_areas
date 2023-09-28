"""
Download and Extract ZIP File Script

This Python script allows you to download a ZIP file from a given URL and extract its contents into a new folder. 
The script creates a new directory with the name of the downloaded ZIP file inside the specified location and downloads the ZIP file to this folder. 
After that, it extracts the contents of the ZIP file inside the same folder and removes the downloaded ZIP file.

Usage:
1. Replace the "file_url" variable with the URL of the ZIP file you want to download.
2. Set the "extraction_folder" variable to the desired location where you want to save and extract the file.

Note:
- This script requires the "requests" library, which you can install using "pip install requests".
- The downloaded ZIP file will have the same name as in the URL and will be removed after extraction.
- The folder name for extraction will be "GLASS-GLC". If you want a different name, modify the "extraction_folder" variable accordingly.

Author: Matthew Braaksma
Date: 08-03-2023
"""

import os
import requests
import zipfile

def download_and_unzip(url, extraction_folder):
    # Step 1: Create the new folder for extraction
    os.makedirs(extraction_folder, exist_ok=True)

    # Step 2: Download the file from the URL and save it in the new folder
    response = requests.get(url)
    if response.status_code == 200:
        file_name = os.path.basename(url)
        download_and_extraction_path = os.path.join(extraction_folder, file_name)
        with open(download_and_extraction_path, 'wb') as file:
            file.write(response.content)
        print("File downloaded successfully.")
    else:
        print(f"Failed to download the file. Status Code: {response.status_code}")
        return

    # Step 3: Check if the downloaded file is a ZIP file based on its extension
    if file_name.lower().endswith(".zip"):
        # Step 4: Unzip the downloaded file inside the new folder and remove the ZIP file
        try:
            with zipfile.ZipFile(download_and_extraction_path, 'r') as zip_ref:
                zip_ref.extractall(extraction_folder)

            # Remove the downloaded ZIP file after extraction
            os.remove(download_and_extraction_path)

            print("File extracted successfully.")
        except Exception as e:
            print(f"Failed to extract the file. Error: {str(e)}")
    else:
        print("The downloaded file is not a ZIP file. No extraction performed.")

if __name__ == "__main__":
    # Provide the URL of the file you want to download
    file_url = 'https://dap.ceda.ac.uk/neodc/esacci/land_cover/data/land_cover_maps/v2.0.7/ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.tif'


    # Provide the path to the folder where you want to extract the file
    extraction_folder = '../../data/ESA-CCI-LC/raw'

    # Create the extraction folder if it doesn't exist
    os.makedirs(extraction_folder, exist_ok=True)

    download_and_unzip(file_url, extraction_folder)