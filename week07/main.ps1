. "C:\Users\champuser\SavC-TechJournal-SYS320\week06\Event-Logs.ps1"
. "C:\Users\champuser\SavC-TechJournal-SYS320\week07\Email.ps1"
. "C:\Users\champuser\SavC-TechJournal-SYS320\week07\Scheduler.ps1"
. "C:\Users\champuser\SavC-TechJournal-SYS320\week07\Configuration.ps1"

# Obtaining configuration
$configuration = readConfiguration

# Obtaining at risk users
$Failed = at_risk_users $configuration.Days

# Sending at risk users as email
SendAlertEmail "Suspicious Activity" ($Failed | Format-Table | Out-String)

# Setting the script to be run daily 
ChooseTimeToRun $configuration.ExecutionTime