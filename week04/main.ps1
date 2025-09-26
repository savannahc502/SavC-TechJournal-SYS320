# Load function from apache-logs.ps1 and allow user input

# Dot source function
. .\apache-logs.ps1

# User Input
$page = Read-Host "Enter the page visited (ex. index.html)"
$code = Read-Host "Enter the HTTP response number (ex. 200)"
$browserName = Read-Host "Enter the name of the browser (ex. Chrome)" 

# Call Function
accessedPages $page $code $browserName