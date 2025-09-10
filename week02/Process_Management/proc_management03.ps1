# Lists every stopped service, orders it alphabetically, and saves it to a csv file

# Original Script, Correct but too messy
# $StoppedServices = Get-Service | Where-Object { $_.Status -eq 'Stopped' } | Sort-Object DisplayName 
# $StoppedServices | Export-Csv -Path "$PSScriptRoot\stopped_services.csv"

# Get all stopped services, sort by DisplayName, and export selected properties to CSV
$StoppedServices = Get-Service | Where-Object { $_.Status -eq 'Stopped' } | Sort-Object DisplayName
$StoppedServices | Export-Csv -Path "$PSScriptRoot\stopped_services.csv" -NoTypeInformation
