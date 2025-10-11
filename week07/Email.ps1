function SendAlertEmail ($Body){

$From = "savannah.ciak@mymail.champlain.edu"
$To = "savannah.ciak@mymail.champlain.edu"
$Subject = "Suspicious Activity" 

$Password = Get-Content "C:\Users\champuser\Documents\app.txt" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential - ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
-port 587 -UseSsl -Credential $Credential

}

SendAlertEmail "Body of Email" 