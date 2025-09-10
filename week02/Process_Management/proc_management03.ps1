# Lists every stopped service, orders it alphabetically, and saves it to a csv file

# Original Script, Correct but too messy
# $StoppedServices = Get-Service | Where-Object { $_.Status -eq 'Stopped' } | Sort-Object DisplayName 
# $StoppedServices | Export-Csv -Path "$PSScriptRoot\stopped_services.csv"

$StoppedServices = Get-Service | Where-Object { $_.Status -eq 'Stopped' } | Sort-Object DisplayName
$StoppedServices | Select-Object Name, DisplayName, Status | Export-Csv -Path "$PSScriptRoot\stopped_services.csv" 
