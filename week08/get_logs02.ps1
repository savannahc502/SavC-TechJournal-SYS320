function Get-ApacheLogs2() {
    param(
    [string]$file_path,
    [string[]]$indicators
    )

    $not_found = Get-Content -Path $file_path
    $regex_format = [regex] '^(?<IP>\d+\.\d+\.\d+\.\d+) - - \[(?<Time>[^\]]+)\] "(?<Method>[A-Z]+) (?<Page>.*?) (?<Protocol>HTTP/[\d\.]+)" (?<ResponseCode>\d+) \d+ "(?<Referrer>.*?)"'
    # Regex idea given by Seraphim while she was working on another assignment for a different class 

    $data_array = @()

    foreach ($i in $not_found) {
        if ($regex_format.IsMatch($i)) {
            $match = $regex_format.Match($i)
            $page = $match.Groups['Page'].Value

            foreach ($e in $indicators) {
                if ($page -match $e) {
                    $logObject = [PSCustomObject]@{
                    IP = $match.Groups['IP'].Value
                    Time = $match.Groups['Time'].Value
                    Method = $match.Groups['Method'].Value
                    Page = $match.Groups['Page'].Value
                    Protocol = $match.Groups['Protocol'].Value
                    ResponseCode = $match.Groups['ResponseCode'].Value
                    Referrer = $match.Groups['Referrer'].Value
                }

                $data_array += $logObject
                break
                }
            }
        }
    }

    $data_array | Format-Table
}

$indicators = @('etc/passwd', 'cmd=/bin/bash', '/bin/sh', '1=1#', '1=1--')
$FilePath = "C:\Users\champuser\access.log"

Get-ApacheLogs2 -file_path $FilePath -indicators $indicators | Format-Table
