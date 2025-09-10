# lists every process for which the path does not include the string "system32"

Get-Process | Where-Object { $_.Path -notlike '*\system32\*' }
