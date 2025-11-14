#!/bin/bash

file="/home/champuser/SavC-TechJournal-SYS320/week12/fileaccesslog.txt"
time=$(date "+%Y-%m-%d %I-%M-%S %p")
echo "File was accessed on $time" >> "$file"

{ echo "To: savannah.ciak@mymail.champlain.edu"
  echo "Subject: File Access Log"
  cat "$file"
} > email.txt

ssmtp savannah.ciak@mymail.champlain.edu < email.txt
