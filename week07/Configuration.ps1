# Manages the configuration.txt file by allowing users to view, update, or exit a menu 
# that controls log evalualtion duration and daily execution time
#
# Author: Savannah Ciak
# Date: 11 October 2025 

### ADDED: Support for silent mode
param (
    [switch]$Silent
)

$configFile = "configuration.txt"

# Reads and prints the configuration.txt file
function readConfiguration {
    if (Test-Path $configFile) { # Tests for the existene of configFile
        $fileContent = Get-Content -Path $configFile # Reads all lines into an array
        if ($fileContent.Count -ge 2) { # Checks for two lines
            $config = [PSCustomObject]@{ # Create custom object
                Days = $fileContent[0] # First line in file defined as Days
                ExecutionTime = $fileContent[1] # Seond line in file defined as ExecutionTime
            }
            return $config # Returns custom object 
        } else { 
            Write-Host "`n$configFile file is incomplete or formatted incorrectly." 
        }
    } else {
        Write-Host "`n$configFile file not found."
    }
}

# Edits the configuration.txt file 
function changeConfiguration { 
    $validDays = $false
    while (-not $validDays) {
        $days = Read-Host "Enter number of days to evaluate logs (integer only)"
        if ($days -match '^\d+$') {
            $validDays = $true
        } else {
            Write-Host "`nInvalid input, try again bestie." 
        }
    }

    $validTime = $false
    while (-not $validTime) {
        $time = Read-Host "Enter execution time in format H:MM AM/PM)"
        if ($time -match '^\d{1,2}:\d{2}\s?(AM|PM)$') {
            $validTime = $true
        } else {
            Write-Host "`nInvalid input, try again bestie." 
        }
    }

    "$days" > $configFile
    "$time" >> $configFile

    Write-Host "`n$configFile updated." 
} 

# Display menu for user choices 
function configMenu {
    $running = $true
    while ($running) {
        Write-Host "`n=== Configuration Menu ===" 
        Write-Host "1. Show configuration"
        Write-Host "2. Change configuration"
        Write-Host "3. Exit" 
        $choice = Read-Host "`nEnter choice 1, 2, or 3"

        if ($choice -eq '1') {
            readConfiguration | Format-List
        } elseif ($choice -eq '2') {
            changeConfiguration
        } elseif ($choice -eq '3') {
            Write-Host "`nBye barbie" 
            $running = $false
        } else {
            Write-Host "`nCome on, you only have three choices" 
        }
    }
}

### CHANGED: Only run menu if not in silent mode
if (-not $Silent) {
    configMenu #Start the menu 
}
