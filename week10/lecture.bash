#!/bin/bash

file="/var/log/apache2/access.log"

function pageCount(){
    all_logs=$(grep "page2.html" "$file" | cut -d' ' -f1,7 | tr -s ' ' | tr -d '/' | sort | uniq)
}

pageCount
echo "$all_logs"
