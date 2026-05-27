function Write-RequestCertificateLog {
<#
    .SYNOPSIS
        Writes a request-certificate log entry.

    .DESCRIPTION
        Writes a timestamped support log entry to the configured script log file and,
        unless disabled, mirrors the message to the PowerShell information, warning,
        or error stream.

    .PARAMETER Level
        Severity level for the log entry.

    .PARAMETER Component
        Component name used in the log entry.

    .PARAMETER Message
        Message text to write.

    .NOTES
        Function  : Write-RequestCertificateLog
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Error', 'Warning', 'Info', 'Debug')]
        [string]$Level,

        [Parameter(Mandatory)]
        [string]$Component,

        [Parameter(Mandatory)]
        [string]$Message
    )

    $rank = @{ Error = 0; Warning = 1; Info = 2; Debug = 3; None = -1 }
    $logLevel = if ($script:RequestCertificateLogLevel) { $script:RequestCertificateLogLevel } else { 'Info' }
    $safeMessage = [string]$Message
    foreach ($pattern in @(
            '(?i)(password|passplain|secret|token|apikey|api_key|key)\s*[:=]\s*["'']?[^;"'',}\s]+',
            '(?i)("?(password|passplain|secret|token|apikey|api_key|key)"?\s*:\s*)"?[^,""}]+"?'
        )) {
        $safeMessage = [regex]::Replace($safeMessage, $pattern, {
                param($match)
                if ($match.Groups.Count -gt 2 -and $match.Groups[1].Success) { return "$($match.Groups[1].Value)`"***`"" }
                return ($match.Value -replace '([:=]\s*["'']?).+$', '$1***')
            })
    }

    if ($rank[$logLevel] -ge $rank[$Level]) {
        $line = '{0}`t{1}`t{2}`t{3}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss:ffff'), $Level.Substring(0, 1).ToUpperInvariant(), $Component, $safeMessage
        if ($script:RequestCertificateLogFile) {
            Add-Content -LiteralPath $script:RequestCertificateLogFile -Value $line -Encoding UTF8
        }
        if (-not $script:RequestCertificateNoConsoleOutput) {
            if ($Level -eq 'Error') { Write-Error $safeMessage -ErrorAction Continue }
            elseif ($Level -eq 'Warning') { Write-Warning $safeMessage }
            else { Write-Information "[$Component] $safeMessage" -InformationAction Continue }
        }
    }
}
