#!/bin/bash

link="http://10.0.17.6/Assignment.html"
fullPage=$(curl -sL "$link")

# First Attempt, formatting was off
# toolOutput=$(echo "$fullPage" | \
# xmlstarlet format --html --recover 2>/dev/null | \
# xmlstarlet select --template \
# --value-of "//html//body//table//tr/td" \
# --nl)

# echo "$toolOutput" | paste -d' ' - - - 

# Second Attempt -- string-join only supported in newer XML
# echo "$fullPage" | \
# xmlstarlet format --html --recover 2>/dev/null | \
# xmlstarlet select --template \
# --match "//html//body//table//tr" \
# --value-of "normalize-space(string-join(td,' '))" \
# --nl

temps=$(echo "$fullPage" | \
xmlstarlet sel -t -m "//table[@id='temp']/tr/td[1]" -v . -n)

times=$(echo "$fullPage" | \
xmlstarlet sel -t -m "//table[@id='temp']/tr/td[2]" -v . -n)

press=$(echo "$fullPage" | \
xmlstarlet sel -t -m "//table[@id='press']/tr/td[1]" -v . -n)

paste <(echo "$temps") <(echo "$press") <(echo "$times")
