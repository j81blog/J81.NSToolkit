function Wait-RequestCertificateAuthorization {
<#
    .SYNOPSIS
        Waits for ACME authorizations to become valid.

    .DESCRIPTION
        Polls Posh-ACME authorization state until all authorizations for the order
        become valid, one becomes invalid, or the timeout expires.

    .PARAMETER MainDomain
        Main domain of the Posh-ACME order.

    .PARAMETER TimeoutSeconds
        Maximum number of seconds to wait.

    .NOTES
        Function  : Wait-RequestCertificateAuthorization
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$MainDomain,
        [int]$TimeoutSeconds = 180
    )

    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    do {
        Start-Sleep -Seconds 5
        $authzs = Posh-ACME\Get-PAOrder -Refresh -MainDomain $MainDomain | Posh-ACME\Get-PAAuthorizations
        $invalid = @($authzs | Where-Object { $_.status -eq 'invalid' -or $_.HTTP01Status -eq 'invalid' })
        if ($invalid.Count -gt 0) { throw "One or more HTTP-01 validations failed: $($invalid.fqdn -join ', ')" }
        if (-not (@($authzs | Where-Object { $_.status -ne 'valid' }).Count)) { return $true }
        Write-RequestCertificateLog Info 'ACME' "Waiting for validation: $((@($authzs | Select-Object -ExpandProperty status -Unique)) -join ', ')."
    } while ((Get-Date) -lt $deadline)

    throw "Timed out waiting for ACME validation for $MainDomain."
}
