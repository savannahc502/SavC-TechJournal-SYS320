#!/bin/bash

all_logs=""
file="/var/log/apache2/access.log"

function pageCount(){
    all_logs=$(cat "$file" | cut -d' ' -f1,7 | tr -s ' ' | sort | uniq -c)
}

pageCount
echo "$all_logs"

