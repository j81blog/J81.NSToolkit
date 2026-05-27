function Remove-RequestCertificateExpiredDiskCertificate {
<#
    .SYNOPSIS
        Removes old local certificate output folders.

    .DESCRIPTION
        Removes legacy GenLeCertForNS certificate directories older than the requested
        number of days. When CN is supplied, only folders for that domain are removed.

    .PARAMETER CertDir
        Certificate directory to clean.

    .PARAMETER Days
        Minimum folder age in days.

    .PARAMETER CN
        Optional common name used to narrow cleanup.

    .NOTES
        Function  : Remove-RequestCertificateExpiredDiskCertificate
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2218
#>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][string]$CertDir,
        [int]$Days = 100,
        [string]$CN
    )

    if (-not (Test-Path -LiteralPath $CertDir)) {
        return [pscustomobject]@{ Removed = 0; CertDir = $CertDir; Pattern = $null }
    }

    $suffix = if ($CN) { [regex]::Escape($CN.Replace('*.', '')) } else { '\w+\.\w+' }
    $pattern = '(?>CRT-SAN|LECRT)-[0-9]{8}-[0-9]{6}-' + $suffix
    $cutoff = (Get-Date).AddDays(-[int]$Days)
    $folders = @(Get-ChildItem -LiteralPath $CertDir -Directory -ErrorAction Stop | Where-Object { $_.Name -match $pattern -and $_.CreationTime -lt $cutoff })
    foreach ($folder in $folders) {
        if ($PSCmdlet.ShouldProcess($folder.FullName, 'Remove expired certificate folder')) {
            Remove-Item -LiteralPath $folder.FullName -Recurse -Force -ErrorAction Stop
        }
    }
    [pscustomobject]@{ Removed = $folders.Count; CertDir = $CertDir; Pattern = $pattern }
}
