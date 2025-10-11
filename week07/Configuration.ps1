# Manages the configuration.txt file by allowing users to view, update, or exit a menu 
# that controls log evalualtion duration and daily execution time
#
# Author: Savannah Ciak
# Date: 11 October 2025 

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
            Write-Host "$configFile file is incomplete or formatted incorrectly." 
        }
    } else {
        Write-Host "$configFile file not found."
    }
}

