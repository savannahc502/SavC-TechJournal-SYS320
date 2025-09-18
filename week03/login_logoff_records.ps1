<#
Function: Get login and logoff records from Windows Events
Input (aka parameter): Number of days to obtain logs
#>

$Days_User = (Read-Host "Enter the days you want look back at for login/logoff records. Prefix with a subtraction sign")

function get_login_logoff_records($Days){

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
} #End of for loop

return $loginoutsTable

} #End of function 

# Call Function
get_login_logoff_records($Days_User)

