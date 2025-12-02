#!/bin/bash

link="http://10.0.17.6/Assignment.html"
fullPage=$(curl -sL "$link")

toolOutput=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template \
--value-of "//html//body//table//tr/td" \
--nl)

echo "$toolOutput" | paste -d' ' - - - 
