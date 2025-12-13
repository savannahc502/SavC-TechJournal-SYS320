#! /bin/bash
# Author: Savannah Ciak
# This script scrapes a specific IP address for the text it lists in a table 
# and saves the output to a text file 

echo ""

curl -s http://10.0.17.IOC/html | \
grep -Eo '(etc/passwd|/bin/bash|/bin/sh|1=1#|1=1--)' > IOC.txt
cat IOC.txt
