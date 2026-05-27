function Remove-RequestCertificateNetScalerTestCertificate {
<#
    .SYNOPSIS
        Removes staging/test ACME certificates from a NetScaler.

    .DESCRIPTION
        Removes NetScaler sslcertkey objects that are clearly staging/test artifacts.
        By default this targets certkeys prefixed with TST- and certificates issued by
        the Let's Encrypt staging fake intermediate.

    .PARAMETER NSSession
        Existing NetScaler session returned by Connect-NSNode.

    .PARAMETER DeleteFromDevice
        Also deletes certificate/key files from the appliance when supported.

    .NOTES
        Function  : Remove-RequestCertificateNetScalerTestCertificate
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2218
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object]$NSSession,
        [switch]$DeleteFromDevice
    )

    $response = Invoke-NSGetSslcertkey -NSSession $NSSession -GetAll -ErrorAction Stop
    $certs = @($response.sslcertkey | Where-Object {
            $_.certkey -like 'TST-*' -or
            $_.issuer -match 'Fake LE|STAGING|Lets Encrypt.*Staging|Let''s Encrypt.*Staging'
        })

    $removed = @()
    foreach ($cert in $certs) {
        try {
            Write-RequestCertificateLog Info 'RemoveTestCerts' "Removing test certkey '$($cert.certkey)'."
            Invoke-NSDeleteSslcertkey -NSSession $NSSession -Certkey $cert.certkey -Deletefromdevice:$DeleteFromDevice | Out-Null
            $removed += $cert.certkey
        } catch {
            Write-RequestCertificateLog Warning 'RemoveTestCerts' "Could not remove '$($cert.certkey)': $($_.Exception.Message)"
        }
    }
    [pscustomobject]@{ Removed = $removed.Count; CertKeyName = $removed }
}
