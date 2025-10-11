<#
Executes event functions from login_logoff_records.ps1 using dot notation
Input (aka parameter): Number of days to obtain logs
Author: Savannah Ciak
Date: 09/18/2025
#>

.\login_logoff_records.ps1

$Days = Read-Host "Enter the days you want to look back. Prefix with a subtraction symbol"

GetLoginLogoffRecords($Days)
GetStartupShutdownRecords($Days)