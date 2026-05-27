function Publish-RequestCertificateHttpChallenge {
<#
    .SYNOPSIS
        Publishes ACME HTTP-01 challenges on the NetScaler.

    .DESCRIPTION
        Creates responder actions and policies for pending ACME HTTP-01 challenges,
        binds them to the validation load balancing vServer, and acknowledges each
        challenge with Posh-ACME.

    .PARAMETER NSSession
        Existing NetScaler session returned by Connect-NSNode.

    .PARAMETER Settings
        Normalized request settings object with responder and LB names.

    .PARAMETER Order
        Posh-ACME order object.

    .PARAMETER Account
        Posh-ACME account object used to calculate key authorization values.

    .NOTES
        Function  : Publish-RequestCertificateHttpChallenge
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object]$NSSession,
        [Parameter(Mandatory)][object]$Settings,
        [Parameter(Mandatory)][object]$Order,
        [Parameter(Mandatory)][object]$Account
    )

    $authzs = $Order | Posh-ACME\Get-PAOrder -Refresh | Posh-ACME\Get-PAAuthorizations
    $bindings = @()
    $priority = 100
    foreach ($authz in @($authzs | Where-Object { $_.status -ne 'valid' })) {
        $priority++
        $tokenPath = ".well-known/acme-challenge/$($authz.HTTP01Token)"
        $keyAuth = Posh-ACME\Get-KeyAuthorization -Token $authz.HTTP01Token -Account $Account
        $responseText = "HTTP/1.0 200 OK\r\nContent-Type: text/plain\r\n\r\n$keyAuth"
        $actionName = "{0}_{1}" -f $Settings.RsaName, $priority
        $policyName = "{0}_{1}" -f $Settings.RspName, $priority

        Invoke-NSAddResponderaction -NSSession $NSSession -Name $actionName -Type 'respondwith' -Target ('"' + $responseText + '"') | Out-Null
        Invoke-NSAddResponderpolicy -NSSession $NSSession -Name $policyName -Action $actionName -Rule "HTTP.REQ.URL.CONTAINS(`"$tokenPath`")" | Out-Null
        Invoke-NSAddLbvserverResponderpolicyBinding -NSSession $NSSession -Name $Settings.LbName -Policyname $policyName -Priority ([double]$priority) | Out-Null

        $bindings += [pscustomobject]@{ PolicyName = $policyName; ActionName = $actionName; Priority = $priority; Fqdn = $authz.fqdn }
        Write-RequestCertificateLog Info 'ACME' "Acknowledging HTTP-01 challenge for $($authz.fqdn)."
        Posh-ACME\Send-ChallengeAck -ChallengeUrl $authz.HTTP01Url -Account $Account -ErrorAction Stop
    }
    return $bindings
}
