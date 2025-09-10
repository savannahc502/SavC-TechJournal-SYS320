# Create a folder called "outfolder" if it does not already exists 
# Hardcoded to add the folder "outfolder" 

$folderpath="PSScriptRoot\outfolder"
if (Test-Path $folderpath){
    Write-Host "Folder Already Exists" 
}
else{
   New-Item -ItemType Directory -Path $folderpath
}
