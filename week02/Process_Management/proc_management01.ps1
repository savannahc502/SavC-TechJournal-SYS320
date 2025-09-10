# List all processes where the ProcessName starts with 'C'
Get-Process | Where-Object { $_.ProcessName -like 'C*' }
