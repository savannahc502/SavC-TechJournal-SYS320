#!/bin/bash

file="/home/champuser/SavC-TechJournal-SYS320/week12/fileaccesslog.txt"
time=$(date "+%Y-%m-%d %I:%M:%S %p") 
echo "File was accessed on $time" >> "$file"

function read_log(){
	cat $file
}

echo "To: savannah.ciak@mymail.champlain.edu" > email.txt
echo "Subject: File Access Log" >> email.txt

read_log >> email.txt

cat email.txt | ssmtp savannah.ciak@mymail.champlain.edu 
