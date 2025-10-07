# Practicing: Utilize the script files I have used in the earlier labs
# Author: Savannah Ciak
# 7 October 2025 

# Importing files containing needed functions using dot notation
. "C:\Users\champuser\SavC-TechJournal-SYS320\week04\apache-logs.ps1" # Contains accessedPages
. "C:\Users\champuser\SavC-TechJournal-SYS320\week06\Event-Logs.ps1" # Contains getFailedLogins and at_risk_users

# Creating the variable choice 
$choice = 0

# Main menu using a while loop
while ($choice -ne 5) { # Prompt the menu till user enters 5
  Write-Host "`nMain Menu: Pick an Option`n"
  Write-Host "1. Display the last 10 Apache logs`n" 
  Write-Host "2. Display the last 10 failed logins for all users`n" 
  Write-Host "3. Display at-risk users (users who failed login >9 times)`n" # Idea for criteria borrowed from Matt Compton
  Write-Host "4. Start Chrome web browser and navigate it to champlain.edu`n" 
  Write-Host "5. Exit`n" 

  $choice = Read-Host -Prompt "Enter your choice (1-5)"
  
    if ($choice -eq 1) {
        $page = Read-Host "Enter the page name (example index.html)"
        $code = Read-Host "Enter the HTTP status code (example 200)"
        $browserName = Read-Host "Enter the browser name (example Firefox)"

        # Pulls from the required function and displays the last 10 only
        accessedPages $page $code $browserName }

        # Get-Content "C:\xampp\apache\logs\access.log" -Tail 10 }
    
    elseif ( $choice -eq 2 ) {
        getFailedLogins}
    
    elseif ( $choice -eq 3 ) {
        at_risk_users }
    
    elseif ( $choice -eq 4 ) {
        $chromeRunning = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
        if ( -not $chromeRunning ) {
            Start-Process "chrome.exe" "https://www.champlain.edu"
            Write-Host "Chrome started and navigated to champlain.edu" }
            
        else {
            Write-Host "Chrome is already running." }}
            
    elseif ( $choice -eq 5 ) {
        Write-Host "Exiting menu"}
        
    else {
        Write-Host "Invalid input. Enter an integer between 1 and 5."}
}
