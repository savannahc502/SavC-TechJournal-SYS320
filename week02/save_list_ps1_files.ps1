# List # List all the files in your working directory that has the extension ".ps1" 
# and save the results to out.csv file in "outfolder" directory
$files = Get-ChildItem

$folderPath = "$PSScriptRoot/outfolder/"
$filePath = Join-Path $folderPath "out.csv"

$files | Where-Object { $_.Extension -eq ".ps1" } |
Export-Csv -Path $filePath
