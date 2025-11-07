#!/bin/bash

file="/var/log/apache2/access.log"

function filterPage2Requests(){
    all_logs=$(grep 'GET /page2.html' "$file" | cut -d' ' -f1,7 | tr -s ' ' | while read ip page; do
        echo "$ip ${page#/}"
    done)
}

filterPage2Requests
echo "$all_logs"
