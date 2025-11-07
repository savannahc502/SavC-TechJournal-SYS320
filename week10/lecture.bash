#!/bin/bash

file="/var/log/apache2/access.log"

function pageCount(){
    all_logs=$(grep 'GET /page2.html' "$file" | cut -d' ' -f1,7 | tr -s ' ' | while read ip page; do
        echo "$ip ${page#/}"
    done)
}

pageCount
echo "$all_logs"

