function Wait-RequestCertificateOrderFinal {
<#
    .SYNOPSIS
        Waits for a finalized ACME order to become valid.

    .DESCRIPTION
        Polls Posh-ACME order state after Submit-OrderFinalize until the order is
        valid, invalid, or the timeout expires.

    .PARAMETER MainDomain
        Main domain of the Posh-ACME order.

    .PARAMETER TimeoutSeconds
        Maximum number of seconds to wait.

    .NOTES
        Function  : Wait-RequestCertificateOrderFinal
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
        Start-Sleep -Seconds 3
        $order = Posh-ACME\Get-PAOrder -MainDomain $MainDomain -Refresh
        if ($order.status -eq 'valid') { return $order }
        if ($order.status -eq 'invalid') { throw "ACME order for $MainDomain became invalid." }
        Write-RequestCertificateLog Info 'ACME' "Waiting for finalized order: $($order.status)."
    } while ((Get-Date) -lt $deadline)

    throw "Timed out waiting for ACME order finalization for $MainDomain."
}
