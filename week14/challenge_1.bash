#!/bin/bash
# Author: Savannah Ciak
# This script scrapes a specific IP address for the text it lists in a table 
# and saves the output to a text file 

echo ""

URL="http://10.0.17.16/IOC.html"

echo "Page Downloading" 
curl -s "URL" -o IOC.html

xmlstarlet sel -t -m "//table/tr[position()>1]" \
  -v "td[1]" -n IOC.html > IOC.txt

echo ""
