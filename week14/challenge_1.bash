#! /bin/bash
# Author: Savannah Ciak
# This script scrapes a specific IP address for the text it lists in a table 
# and saves the output to a text file 

echo ""

xmlstarlet sel -H -t -m "//table/tr[position()>1]" \
 -v "td[1]" -o "  " \
 -v "td[3]" -n IOC.html > IOC.txt
 
echo ""
