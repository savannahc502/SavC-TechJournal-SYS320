function Get-IoCWeb () {

    $url = "http://10.0.17.19/IOC.html"
    $page_content = Invoke-WebRequest -Uri $url -UseBasicParsing
    $html_format = $page_content.Content -join "`n"

    $xml_format = [xml]("<root>" + $html_format + "</root>")
    $format_rows = $xml_format.SelectNodes("//tr")

    $IoC_array = @()

    foreach ($row in $format_rows) {
        $columns = $row.SelectNodes("td")
        if ($columns.Count -eq 2) {
            $pattern = $columns[0].InnerText.Trim()
            $description = $columns[1].InnerText.Trim()

            $IoC_array += [PSCustomObject]@{
                Pattern = $pattern
                Explanation = $description
            }
        }
    }
    return $IoC_array
}

Get-IoCWeb | Format-Table -AutoSize