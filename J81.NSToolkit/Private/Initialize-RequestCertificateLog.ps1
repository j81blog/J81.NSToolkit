function Initialize-RequestCertificateLog {
<#
    .SYNOPSIS
        Initializes the request-certificate support log.

    .DESCRIPTION
        Creates the log directory, rotates an existing log when it is larger than the
        requested size, and writes a diagnostic header containing runtime and module
        details.

    .PARAMETER Path
        Log file path.

    .PARAMETER MaxSizeMB
        Maximum log size before rotation.

    .NOTES
        Function  : Initialize-RequestCertificateLog
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2218
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [int]$MaxSizeMB = 10
    )

    $logDir = Split-Path -Parent $Path
    if ($logDir) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }
    if ((Test-Path -LiteralPath $Path) -and ((Get-Item -LiteralPath $Path).Length -gt ($MaxSizeMB * 1MB))) {
        $archive = '{0}.{1:yyyyMMddHHmmss}.old' -f $Path, (Get-Date)
        Move-Item -LiteralPath $Path -Destination $archive -Force
    }

    $isAdmin = $false
    if ($IsWindows -or ('PSEdition' -notin $PSVersionTable.Keys) -or $PSVersionTable.PSEdition -eq 'Desktop') {
        try {
            $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
            $principal = [Security.Principal.WindowsPrincipal]::new($identity)
            $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
        } catch {}
    }

    $moduleVersion = try { (Get-Module J81.NSToolkit -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1).Version } catch { $null }
    $poshVersion = try { (Get-Module Posh-ACME -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1).Version } catch { $null }
    $os = try { [System.Runtime.InteropServices.RuntimeInformation]::OSDescription } catch { [Environment]::OSVersion.VersionString }

    $header = @(
        '================================================================================'
        "Invoke-RequestCertificate started: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss zzz')"
        "PowerShell version            : $($PSVersionTable.PSVersion)"
        "PowerShell edition            : $($PSVersionTable.PSEdition)"
        "OS                            : $os"
        "Process elevated              : $isAdmin"
        "J81.NSToolkit version         : $moduleVersion"
        "Posh-ACME version             : $poshVersion"
        '================================================================================'
    )
    Set-Content -LiteralPath $Path -Value $header -Encoding UTF8
}
