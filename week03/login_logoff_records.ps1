<#
Function: Get login and logoff records from Windows Events
Input (aka parameter): Number of days to obtain logs
Author: Savannah Ciak
Date: 09/18/2025
#>

# User Inputs
$Days_User = (Read-Host "Enter the days you want look back at for login/logoff records. Prefix with a subtraction sign")

# First Function
function GetLoginLogoffRecords($Days){

# Get login and logoff records from Windows Events and save to a variable
$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays($Days)

$loginoutsTable = @() # Empty array to fill customly
for ($i=0; $i -lt $loginouts.Count; $i++){

# Creating event property value
$event = ""
if($loginouts[$i].InstanceId -eq 7001) {$event="LogOn"}
if($loginouts[$i].InstanceId -eq 7002) {$event="LogOff"}

# Creating user property value
# $user = $loginouts[$i].ReplacementStrings[1]

# Creating user property value
# Use System Security Principle SecurityIdentifier to translate the user id to username
$user = (New-Object -TypeName System.Security.Principal.SecurityIdentifier $loginouts[$i].ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])

# Adding each new line (in form of a custom object) to our empty array
$loginoutsTable += [PSCustomObject]@{"Time" = $loginouts[$i].TimeGenerated;
                                       "Id" = $loginouts[$i].InstanceId;
                                    "Event" = $event;
                                     "User" = $user;
                                     }
} # End of for loop

return $loginoutsTable

} # End of function 

# Second Function
function GetStartupShutdownRecords($Days){

# Event IDs for Startup and Shutdown
$shutdownID = 6006
$startupID = 6005

# Get Startup and Shutdown Events from System Logs
$events = Get-EventLog System -After (Get-Date).AddDays($Days) | Where-Object {$_.EventID -eq $startupID -or $_.EventID -eq $shutdownID}

$eventTable = @() # Empty array to fill customly
for ($i=0; $i -lt $events.Count; $i==){

# Creating event property value
$event = ""
if($events[$i].EventID -eq $startupID) {$event="System Startup"}
if($events[$i].EventID -eq $shutdownID) {$event="System Shutdown"}

# Creating user property value
# Use System Security Principle SecurityIdentifier to translate the user id to username
$user = (New-Object -TypeName System.Security.Principal.SecurityIdentifier $loginouts[$i].ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])

# Adding each new line (in form of a custom object) to our empty array
$eventTable += [PSCustomObject]@{"Time" = $events[$i].TimeGenerated;
                                   "Id" = $events[$i].EventID;
                                "Event" = $event;
                                 "User" = $user;
                                 }
} # End of for loop

return $eventTable

} # End of Function

# Call Functions
GetLoginLogoffRecords($Days_User)
GetStartupShutdownRecords($Days_User)

