function Update-RequestCertificateIisBinding {
<#
    .SYNOPSIS
        Imports a PFX and updates an IIS HTTPS binding.

    .DESCRIPTION
        Implements the legacy UpdateIIS behavior only when explicitly requested. This
        operation is Windows-only and typically requires elevation.

    .PARAMETER PfxPath
        PFX file path.

    .PARAMETER PfxSecret
        PFX password.

    .PARAMETER SiteName
        IIS site name.

    .NOTES
        Function  : Update-RequestCertificateIisBinding
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2218
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$PfxPath,
        [Parameter(Mandatory)][securestring]$PfxSecret,
        [string]$SiteName = 'Default Web Site'
    )

    if (-not $IsWindows -and $PSVersionTable.PSEdition -ne 'Desktop') {
        throw 'UpdateIIS is only supported on Windows.'
    }
    Import-Module WebAdministration -ErrorAction Stop
    $cert = Import-PfxCertificate -FilePath $PfxPath -CertStoreLocation Cert:\LocalMachine\My -Password $PfxSecret -ErrorAction Stop
    $binding = Get-WebBinding -Name $SiteName -Protocol https -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $binding) {
        New-WebBinding -Name $SiteName -Protocol https -Port 443 -ErrorAction Stop | Out-Null
        $binding = Get-WebBinding -Name $SiteName -Protocol https | Select-Object -First 1
    }
    $binding.AddSslCertificate($cert.Thumbprint, 'My')
    [pscustomobject]@{ SiteName = $SiteName; Thumbprint = $cert.Thumbprint; Status = 'Updated' }
}
