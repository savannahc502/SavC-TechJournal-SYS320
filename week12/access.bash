#!/bin/bash

log="/home/champuser/SavC-TechJournal-SYS320/week12/fileaccesslog.txt"
time=$(date "+%Y-%m-%d %I:%M:%S %p")
echo "File was accessed at $time" >> "$log"

function logFile(){
 cat $log
}

echo "To: savannah.ciak@mymail.champlain.edu" > email.txt
echo "Subject: File Access" >> email.txt

logFile >> email.txt

cat email.txt | ssmtp savannah.ciak@mymail.champlain.edu
