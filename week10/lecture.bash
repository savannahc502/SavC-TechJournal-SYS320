#!/bin/bash

file="/var/log/apache2/access.log"

function pageCount(){
    all_logs=$(grep "page2.html" "$file" | cut -d' ' -f1,7 | tr -s ' ' | sort | uniq -c)
}

pageCount
echo "$all_logs"
