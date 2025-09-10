# If an instance of it is not running already,  starts Google Chrome web browser and directs it Champlain.edu
# If an instance is already running, stops it

# Old Code. Worked but nothing printed for the screenshot. 
# $chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
# if (-not $chrome) {
#    Start-Process "chrome.exe" "https://www/champlain.edu"
# }
#    else {
#    Stop-Process -Name "chrome" -Force
# }

$chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if (-not $chrome) {
   Start-Process "chrome.exe" "https://www/champlain.edu"
   Write-Output "Champlain Website Loading..."
}
   else {
   Stop-Process -Name "chrome" -Force
   Write-Output "Chrome Closed"
}
