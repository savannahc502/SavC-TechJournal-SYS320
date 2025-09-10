# Lists every stopped service, orders it alphabetically, and saves it to a csv file
$StoppedServices = Get-Service | Where-Object { $_.Status -eq 'Stopped' } | Sort-Object DisplayName 

$StoppedServices | Export-Csv -Path "$PSScriptRoot\stopped_services.csv"
