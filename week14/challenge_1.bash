#! /bin/bash
# Author: Savannah Ciak
# This script scrapes a specific IP address for the text it lists in a table 
# and saves the output to a text file 

echo ""

page =$(curl -s http://10.0.17.IOC/html)

table+$(echo "$page" | grep -oP '(?<=<td>).*?(?=</td>)' | sed -n '1~2p')

echo "$table" > IOC.txt
