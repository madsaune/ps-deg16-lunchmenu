# Fetch lunchmenu for DEG16 with Powershell
This script fetches the lunchmenu for DEG16. By default it will fetch todays menu. By using parameter `-All` you can fetch the menu for the whole week.

## Send as mail

    $creds = Get-Credential
    $body = $(.\Get-Lunchmenu.ps1 | fl | Out-String).trim()
    Send-MailMessage -To <email> -From <email> -Subject "Todays lunchmenu" -Body $body -UseSsl -Port 587 -SmtpServer smtp.office365.com -Credential $creds