param ([switch]$Main)

. "C:\Users\champuser\SavC-TechJournal-SYS320\week06\Event-Logs.ps1"
. "C:\Users\champuser\SavC-TechJournal-SYS320\week07\Email.ps1"
. "C:\Users\champuser\SavC-TechJournal-SYS320\week07\Scheduler.ps1"

if ($Main) {
    . "C:\Users\champuser\SavC-TechJournal-SYS320\week07\Configuration.ps1"}
    else {Write-Host "The '-Main' switch was not used, re-run with it to see the menu. Automatic exit starting shortly."}

# Obtaining configuration
$configuration = Get-Content "C:\Users\champuser\SavC-TechJournal-SYS320\week07\configuration.txt" 

# Obtaining at risk users
$Failed = at_risk_users($configuration[0])

# Sending at risk users as email
SendAlertEmail($Failed | Format-Table | Out-String)

# Setting the script to be run daily 
ChooseTimeToRun($configuration[1])

