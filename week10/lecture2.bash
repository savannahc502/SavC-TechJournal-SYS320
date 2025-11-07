#!/bin/bash

all_logs=""
file="/var/log/apache2/access.log"

function countingCurlAccess(){
  all_logs=$(cat "$file" | grep "curl" |  cut -d' ' -f1,12 | sort | uniq -c )
  }

countingCurlAccess
echo "$all_logs"
