. "C:\Users\champuser\SavC-TechJournal-SYS320\week04\table-scraping.ps1"

$rawClasses = gatherClasses

$classes = daysTranslator $rawClasses

# Original Table Call
# $classes | Format-Table -AutoSize

# List all the classes of intructor furkan paligu
# $classes | Where-Object {$_.Instructor -eq "Furkan Paligu"}

# List all classes of Joyce310 on Mondays, only display class code and time. Sort by start time. 
# $classes | Where-Object {($_.Location -eq "JOYC 310") -and ($_.days -eq "Monday")} | `
    # Sort-Object "Time Start" | `
    # Select-Object "Time Start", "Time End", "Class Code"

# List all intructors that teach at least 1 course in SYS, SEC, NET, FOR, CSI, DAT
# Sort by start name 
$its_instructors = $classes | Where-Object {
                             ($_."Class Code" -like "SYS*") -or `
                             ($_."Class Code" -like "SEC*") -or `
                             ($_."Class Code" -like "NET*") -or `
                             ($_."Class Code" -like "FOR*") -or `
                             ($_."Class Code" -like "CSI*") -or `
                             ($_."Class Code" -like "DAT*") } `
                             | Sort-Object "Instructor" -Unique `
                             | Select-Object -ExpandProperty "Instructor"
# $its_instructors


# Group all instructors by the number of classes they are teaching
$classes | Where-Object {$_.Instructor -in $its_instructors } `
         | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending
