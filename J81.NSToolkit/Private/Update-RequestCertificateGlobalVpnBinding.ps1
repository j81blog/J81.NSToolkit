function Update-RequestCertificateGlobalVpnBinding {
<#
    .SYNOPSIS
        Updates NetScaler global VPN SSL certificate binding.

    .DESCRIPTION
        Replaces an existing global VPN binding for the old certkey when present, or
        adds the new binding when no old certkey was supplied.

    .PARAMETER NSSession
        Existing NetScaler session returned by Connect-NSNode.

    .PARAMETER OldCertKeyName
        Existing certkey name being replaced.

    .PARAMETER NewCertKeyName
        New certkey name.

    .PARAMETER IncludeCA
        Bind as CA certificate.

    .PARAMETER CrlCheck
        CRL check value.

    .PARAMETER OcspCheck
        OCSP check value.

    .NOTES
        Function  : Update-RequestCertificateGlobalVpnBinding
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2218
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object]$NSSession,
        [string]$OldCertKeyName,
        [Parameter(Mandatory)][string]$NewCertKeyName,
        [switch]$IncludeCA,
        [string]$CrlCheck,
        [string]$OcspCheck
    )

    $oldWasBound = $true
    if ($OldCertKeyName) {
        try {
            $bindings = Invoke-NSGetVpnglobalSslcertkeyBinding -NSSession $NSSession -ErrorAction Stop
            $oldWasBound = @($bindings.vpnglobal_sslcertkey_binding | Where-Object { $_.certkeyname -eq $OldCertKeyName }).Count -gt 0
        } catch {
            Write-RequestCertificateLog Warning 'VPN' "Could not inspect global VPN bindings: $($_.Exception.Message)"
        }
    }
    if (-not $oldWasBound) {
        Write-RequestCertificateLog Info 'VPN' "Old certkey '$OldCertKeyName' was not globally bound; VPN binding skipped."
        return [pscustomobject]@{ Status = 'Skipped'; CertKeyName = $NewCertKeyName }
    }

    if ($OldCertKeyName -and $OldCertKeyName -ne $NewCertKeyName) {
        try {
            Invoke-NSDeleteVpnglobalSslcertkeyBinding -NSSession $NSSession -Certkeyname $OldCertKeyName -Cacert:$IncludeCA | Out-Null
        } catch {
            Write-RequestCertificateLog Debug 'VPN' "Old global VPN binding removal skipped: $($_.Exception.Message)"
        }
    }

    $params = @{ NSSession = $NSSession; Certkeyname = $NewCertKeyName; Cacert = [bool]$IncludeCA; Gotopriorityexpression = 'END' }
    if ($CrlCheck) { $params.Crlcheck = $CrlCheck.ToLowerInvariant() }
    if ($OcspCheck) { $params.Ocspcheck = $OcspCheck.ToLowerInvariant() }
    Invoke-NSAddVpnglobalSslcertkeyBinding @params | Out-Null
    [pscustomobject]@{ Status = 'Updated'; CertKeyName = $NewCertKeyName; IncludeCA = [bool]$IncludeCA }
}
