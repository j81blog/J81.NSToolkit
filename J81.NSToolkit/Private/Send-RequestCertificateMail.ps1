function Send-RequestCertificateMail {
<#
    .SYNOPSIS
        Sends request-certificate completion mail.

    .DESCRIPTION
        Sends a concise completion mail with optional log attachment using the legacy
        SMTP parameters.

    .PARAMETER Settings
        Mail settings object.

    .PARAMETER Subject
        Mail subject.

    .PARAMETER Body
        Mail body.

    .PARAMETER LogFile
        Optional log file to attach.

    .NOTES
        Function  : Send-RequestCertificateMail
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2218
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object]$Settings,
        [Parameter(Mandatory)][string]$Subject,
        [Parameter(Mandatory)][string]$Body,
        [string]$LogFile
    )

    if (-not $Settings.SendMail) { return }
    foreach ($required in 'SMTPTo', 'SMTPFrom', 'SMTPServer') {
        if (-not $Settings.$required) {
            Write-RequestCertificateLog Warning 'Mail' "Mail skipped. Missing setting '$required'."
            return
        }
    }

    $params = @{
        To         = @($Settings.SMTPTo)
        From       = $Settings.SMTPFrom
        Subject    = $Subject
        Body       = $Body
        SmtpServer = $Settings.SMTPServer
        Port       = if ($Settings.SMTPPort) { [int]$Settings.SMTPPort } else { 25 }
        ErrorAction = 'Stop'
        WarningAction = 'SilentlyContinue'
    }
    if ($Settings.SMTPUseSSL) { $params.UseSsl = $true }
    if ($Settings.SMTPCredential -and $Settings.SMTPCredential -ne [pscredential]::Empty) { $params.Credential = $Settings.SMTPCredential }
    if ($Settings.LogAsAttachment -and $LogFile -and (Test-Path -LiteralPath $LogFile)) { $params.Attachments = $LogFile }

    try {
        Send-MailMessage @params
        Write-RequestCertificateLog Info 'Mail' "Completion mail sent to $(@($Settings.SMTPTo) -join ', ')."
    } catch {
        Write-RequestCertificateLog Warning 'Mail' "Completion mail failed: $($_.Exception.Message)"
    }
}
