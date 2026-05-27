function Initialize-RequestCertificateHttpValidationConfig {
<#
    .SYNOPSIS
        Initializes NetScaler objects for ACME HTTP-01 validation.

    .DESCRIPTION
        Ensures the required NetScaler features, services, load balancing objects,
        content switching policy, and bindings exist for HTTP-01 challenge handling.

    .PARAMETER NSSession
        Existing NetScaler session returned by Connect-NSNode.

    .PARAMETER Settings
        Normalized request settings object with NetScaler object names.

    .PARAMETER Request
        Certificate request object with validation and VIP settings.

    .NOTES
        Function  : Initialize-RequestCertificateHttpValidationConfig
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object]$NSSession,
        [Parameter(Mandatory)][object]$Settings,
        [Parameter(Mandatory)][object]$Request
    )

    Write-RequestCertificateLog Info 'NetScaler' 'Configuring HTTP validation prerequisites.'
    $features = if ($Request.UseLbVip) { @('RESPONDER', 'SSL') } else { @('LB', 'RESPONDER', 'CS', 'SSL') }
    try {
        Invoke-NSEnableNsfeature -NSSession $NSSession -Feature $features | Out-Null
    } catch {
        Write-RequestCertificateLog Warning 'NetScaler' "Could not enable one or more features: $($_.Exception.Message)"
    }

    if (-not $Request.UseLbVip) {
        foreach ($csVip in @($Request.CsVipName)) {
            Invoke-NSGetCsvserver -NSSession $NSSession -Name $csVip | Out-Null
        }
    }

    $svcPayload = @{ name = $Settings.SvcName; ip = $Settings.SvcDestination; servicetype = 'HTTP'; port = '80'; healthmonitor = 'NO' }
    if ([int]$Settings.TrafficDomain -gt 0) { $svcPayload.td = [int]$Settings.TrafficDomain }
    Assert-RequestCertificateNSResource -NSSession $NSSession -Type service -Resource $Settings.SvcName -Payload $svcPayload

    if (-not $Request.UseLbVip) {
        $lbPayload = @{ name = $Settings.LbName; servicetype = 'HTTP'; ipv46 = '0.0.0.0'; port = '0' }
        if ([int]$Settings.TrafficDomain -gt 0) { $lbPayload.td = [int]$Settings.TrafficDomain }
        Assert-RequestCertificateNSResource -NSSession $NSSession -Type lbvserver -Resource $Settings.LbName -Payload $lbPayload
    } else {
        Invoke-NSGetLbvserver -NSSession $NSSession -Name $Settings.LbName | Out-Null
    }

    try {
        $bindings = Invoke-NSGetLbvserverServiceBinding -NSSession $NSSession -Name $Settings.LbName
    } catch {
        if ($_.Exception.Message -match '404|Not Found|No such resource|No Service|No such|\[258\]|\[344\]') { $bindings = $null }
        else { throw }
    }
    if (-not ($bindings.lbvserver_service_binding | Where-Object { $_.servicename -eq $Settings.SvcName })) {
        Invoke-NSAddLbvserverServiceBinding -NSSession $NSSession -Name $Settings.LbName -Servicename $Settings.SvcName | Out-Null
    }

    if (-not $Request.UseLbVip) {
        $csaPayload = @{ name = $Settings.CsaName; targetlbvserver = $Settings.LbName; comment = 'ACME HTTP validation temporary action' }
        try {
            Invoke-NSAddCsaction -NSSession $NSSession -Name $Settings.CsaName -Targetlbvserver $Settings.LbName -Comment 'ACME HTTP validation temporary action' | Out-Null
        } catch {
            if ($_.Exception.Message -notmatch 'already exists|already in use|Resource already exists|\[273\]|\[528\]') { throw }
            Invoke-NSUpdateCsaction -NSSession $NSSession -Name $Settings.CsaName -Targetlbvserver $Settings.LbName -Comment 'ACME HTTP validation temporary action' | Out-Null
        }

        $cspPayload = @{ policyname = $Settings.CspName; rule = 'HTTP.REQ.URL.CONTAINS("well-known/acme-challenge/")'; action = $Settings.CsaName }
        try {
            Invoke-NSAddCspolicy -NSSession $NSSession -Policyname $Settings.CspName -Rule 'HTTP.REQ.URL.CONTAINS("well-known/acme-challenge/")' -Action $Settings.CsaName | Out-Null
        } catch {
            if ($_.Exception.Message -notmatch 'already exists|already in use|Resource already exists|\[273\]|\[528\]') { throw }
            Invoke-NSUpdateCspolicy -NSSession $NSSession -Policyname $Settings.CspName -Rule 'HTTP.REQ.URL.CONTAINS("well-known/acme-challenge/")' -Action $Settings.CsaName | Out-Null
        }

        foreach ($csVip in @($Request.CsVipName)) {
            Invoke-NSAddCsvserverCspolicyBinding -NSSession $NSSession -Name $csVip -Policyname $Settings.CspName -Priority ([double]$Settings.CsVipBinding) -Gotopriorityexpression 'END' | Out-Null
        }
    }
}
