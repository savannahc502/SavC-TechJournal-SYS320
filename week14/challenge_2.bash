#!/bin/bash
echo "Enter the name of the file to be scanned:"
read logfile

echo ""

echo "Enter the scanning file:"
read iocfile

# Clearing report file
> report.txt


while IFS= read -r ioc;
do
	ioc=$(echo "$ioc" | xargs)
	[[ -z "$ioc" ]] && continue
	grep -F "$ioc" "$logfile" | awk '{print $1, $4, $7}' >> report.txt

done < "$iocfile"
