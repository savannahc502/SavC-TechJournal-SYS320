# Without changing the directory (do your operations recursively without
# getting into the child directory), find every .csv file and change their extensions
# to .log. Then, recursively display all the files 

$files = Get-ChildItem -File -Recurse
$files | ForEach-Object -Process { $_.Name -replace '.csv', '.log' }
Get-ChildItem -Recurse -File
