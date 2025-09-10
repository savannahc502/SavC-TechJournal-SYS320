# Without changing the directory (do your operations recursively without
# getting into the child directory), find every .csv file and change their extensions
# to .log. Then, recursively display all the files 

# Old Code, Did Not Work:
# $files = Get-ChildItem -File -Recurse
# $files | ForEach-Object -Process { $_.Name -replace '.csv', '.log' }
# Get-ChildItem -Recurse -File

$files = Get-ChildItem -File -Recurse
$files | ForEach-Object -Process { Rename-Item $_.FullName ($_.Name -replace '.csv', '.log') }
Get-ChildItem -File -Recurse
