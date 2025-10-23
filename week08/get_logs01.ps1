function Get-ApacheLogs() {
    $logs_file = Get-Content "C:\Users\champuser\access.log"
    $records_array = @()

    for($i=0; $i -lt $logs_file.Count; $i++){
        $format = $logs_file[$i].Split(" ");
        $records_array += [PSCustomObject]@{
            "IP" = $format[0]; `
            "Time" = $format[3].Trim('['); `
            "Method" = $format[5].Trim('"'); `
            "Page" = $format[6]; `
            "Protocol" = $format[7].Trim('"'); `
            "Response" = $format[8]; `
            "Referrer" = $format[10]; `
            "Client" = $format[11..($format.Count -1)] -join ' ';
        }
    }
    return $records_array | Where-Object { $_.IP -ilike "10.*" }
}

Get-ApacheLogs | Format-Table -AutoSize -Wrap
