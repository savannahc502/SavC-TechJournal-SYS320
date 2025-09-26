# Filters Apache access logs based on page, HTTP code, and browser 
# Returns counted list of ip addresses that match the criteria 

function accessedPages($page, $code, $browserName){
    # Read apache access logs and filter for three inputs
    # Inputs pulled from the main.ps1 file
    $access_logs = Get-Content C:\xampp\apache\logs\access.log | Select-String -Pattern ".+$page.+$code.+$browserName.+"

    # Initrial empty array
    $unorganizedIP = @()

    # Loop through the matching access logs and extract IPs using regex matching
    foreach ($line in $access_logs) {
        $unorganizedIP += [regex]::Matches($line.ToString(), "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")}

    # Turn each IP into a custom object with a property called "IP"
    # Needed for grouping and counting
    $ips = @()
    foreach ($ip in $unorganizedIP) {
        $ips += [pscustomobject]@{ IP = $ip }}

    # Filters to only internal addresses starting with 10
    $ipcounts = $ips | Where-Object { $_.IP -ilike "10.*" }

    # Group IPs and count 
    $ipcounts | Group-Object IP | Select-Object Count, Name
} 