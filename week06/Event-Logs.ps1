# Example from Champlain College Course Material. 
# Edited by Savannah Ciak on 10/7/2025
 . (Join-Path $PSScriptRoot String-Helper.ps1)


<# ******************************
    Retrieves logon and logoff events from the System event log for the past user input number of days. 
    Identifies users and event types (Logon/Logoff) and returns a table.
****************************** #>
function getLogInAndOffs($timeBack){

$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays("-"+"$timeBack")

$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){

$type = ""
if($loginouts[$i].InstanceID -eq 7001) {$type="Logon"}
if($loginouts[$i].InstanceID -eq 7002) {$type="Logoff"}


# Check if user exists first
$user = (New-Object System.Security.Principal.SecurityIdentifier `
         $loginouts[$i].ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                    "Event" = $type; `
                                     "User" = $user;
                                     }
} # End of for

return $loginoutsTable
} # End of function getLogInAndOffs




<# ******************************
     Retrieves failed login attempts from the Security event log for the past user input number of days. 
     Parses event messages to extract account and domain information, then returns a table.
****************************** #>
function getFailedLogins($timeBack){
  
  $failedlogins = Get-EventLog security -After (Get-Date).AddDays("-"+"$timeBack") | Where { $_.InstanceID -eq "4625" }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }

    }

    return $failedloginsTable
} # End of function getFailedLogins

<# ******************************
     Retrieves failed login attempts that are suspicious aka "high risk."
****************************** #>
function at_risk_users {
    param ([int]$days)

    $results = getFailedLogins $days |
        Group-Object -Property User |
        Where-Object { $_.Count -gt 9 } |
        Select-Object Count, Name |
        Out-String

    Write-Host $results
    return $results
}
