#!/bin/bash
# Author: Savannah Ciak
# This script scrapes a specific IP address for the text it lists in a table 
# and saves the output to a text file 

echo "Checking for IOC.html in the current directory"

# Verification
if [[ ! -f "IOC.html" ]]; then
  echo "Error: IOC.html not found in the current directory."
  echo "Please make sure the file is saved here before running this script."
  exit 1
fi

# File Exists
xmlstarlet sel -t -m "//table/tr[position()>1]" \
  -v "td[1]" -n IOC.html > IOC.txt

# Output
if [[ -f "IOC.txt" ]]; then
  echo "Success: IOC.txt has been created."
else
  echo "Warning: IOC.txt was not created."
  exit 1
fi

echo "Done."

echo "" 

cat IOC.txt
