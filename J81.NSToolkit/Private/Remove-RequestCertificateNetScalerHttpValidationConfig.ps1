function Remove-RequestCertificateNetScalerHttpValidationConfig {
<#
    .SYNOPSIS
        Removes NetScaler HTTP validation objects created by Invoke-RequestCertificate.

    .DESCRIPTION
        Safely removes temporary responder, content switching, load balancing, and
        service objects used for ACME HTTP-01 validation. Missing objects are logged
        at Debug level and do not fail cleanup.

    .PARAMETER NSSession
        Existing NetScaler session returned by Connect-NSNode.

    .PARAMETER Settings
        Normalized settings object with NetScaler object names.

    .PARAMETER CsVipName
        Content switching vServers to unbind from.

    .NOTES
        Function  : Remove-RequestCertificateNetScalerHttpValidationConfig
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2218
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object]$NSSession,
        [Parameter(Mandatory)][object]$Settings,
        [string[]]$CsVipName
    )

    function Invoke-RequestCertificateCleanupStep {
        param([string]$Name, [scriptblock]$ScriptBlock)
        try {
            & $ScriptBlock
            Write-RequestCertificateLog Info 'CleanADC' "$Name removed or verified."
            return $true
        } catch {
            if ($_.Exception.Message -match '404|Not Found|No such resource|No Service|does not exist|\[258\]|\[344\]|\[538\]|\[1540\]') {
                Write-RequestCertificateLog Debug 'CleanADC' "$Name was already absent."
                return $false
            }
            Write-RequestCertificateLog Warning 'CleanADC' "$Name cleanup failed: $($_.Exception.Message)"
            return $false
        }
    }

    foreach ($csVip in @($CsVipName | Where-Object { $_ })) {
        Invoke-RequestCertificateCleanupStep "CS policy binding '$($Settings.CspName)' on '$csVip'" {
            Invoke-NSDeleteCsvserverCspolicyBinding -NSSession $NSSession -Name $csVip -Policyname $Settings.CspName -Priority ([double]$Settings.CsVipBinding) | Out-Null
        } | Out-Null
    }

    try {
        $responderBindings = Invoke-NSGetLbvserverResponderpolicyBinding -NSSession $NSSession -Name $Settings.LbName -ErrorAction Stop
        foreach ($binding in @($responderBindings.lbvserver_responderpolicy_binding | Where-Object { $_.policyname -like "$($Settings.RspName)*" })) {
            Invoke-RequestCertificateCleanupStep "Responder binding '$($binding.policyname)'" {
                Invoke-NSDeleteLbvserverResponderpolicyBinding -NSSession $NSSession -Name $Settings.LbName -Policyname $binding.policyname -Priority ([double]$binding.priority) -Bindpoint 'REQUEST' | Out-Null
            } | Out-Null
        }
    } catch {
        Write-RequestCertificateLog Debug 'CleanADC' "Responder binding lookup skipped: $($_.Exception.Message)"
    }

    try {
        $policies = Invoke-NSGetResponderpolicy -NSSession $NSSession -GetAll -ErrorAction Stop
        foreach ($policy in @($policies.responderpolicy | Where-Object { $_.name -like "$($Settings.RspName)*" })) {
            Invoke-RequestCertificateCleanupStep "Responder policy '$($policy.name)'" {
                Invoke-NSDeleteResponderpolicy -NSSession $NSSession -Name $policy.name | Out-Null
            } | Out-Null
        }
    } catch {
        Write-RequestCertificateLog Debug 'CleanADC' "Responder policy lookup skipped: $($_.Exception.Message)"
    }

    try {
        $actions = Invoke-NSGetResponderaction -NSSession $NSSession -GetAll -ErrorAction Stop
        foreach ($action in @($actions.responderaction | Where-Object { $_.name -like "$($Settings.RsaName)*" })) {
            Invoke-RequestCertificateCleanupStep "Responder action '$($action.name)'" {
                Invoke-NSDeleteResponderaction -NSSession $NSSession -Name $action.name | Out-Null
            } | Out-Null
        }
    } catch {
        Write-RequestCertificateLog Debug 'CleanADC' "Responder action lookup skipped: $($_.Exception.Message)"
    }

    Invoke-RequestCertificateCleanupStep "CS policy '$($Settings.CspName)'" {
        Invoke-NSDeleteCspolicy -NSSession $NSSession -Policyname $Settings.CspName | Out-Null
    } | Out-Null
    Invoke-RequestCertificateCleanupStep "CS action '$($Settings.CsaName)'" {
        Invoke-NSDeleteCsaction -NSSession $NSSession -Name $Settings.CsaName | Out-Null
    } | Out-Null
    Invoke-RequestCertificateCleanupStep "LB service binding '$($Settings.SvcName)'" {
        Invoke-NSDeleteLbvserverServiceBinding -NSSession $NSSession -Name $Settings.LbName -Servicename $Settings.SvcName | Out-Null
    } | Out-Null
    Invoke-RequestCertificateCleanupStep "LB vServer '$($Settings.LbName)'" {
        Invoke-NSDeleteLbvserver -NSSession $NSSession -Name $Settings.LbName | Out-Null
    } | Out-Null
    Invoke-RequestCertificateCleanupStep "Service '$($Settings.SvcName)'" {
        Invoke-NSDeleteService -NSSession $NSSession -Name $Settings.SvcName | Out-Null
    } | Out-Null

    foreach ($file in 'TST-fullchain.pfx', 'fullchain.pfx') {
        Invoke-RequestCertificateCleanupStep "System file '$file'" {
            Invoke-NSDeleteSystemfile -NSSession $NSSession -Filename $file -Filelocation '/nsconfig/ssl/' | Out-Null
        } | Out-Null
    }

    if ($Settings.SaveADCConfig) { Invoke-NSSaveNsconfig -NSSession $NSSession | Out-Null }
    [pscustomobject]@{ Status = 'Completed'; LbName = $Settings.LbName; ServiceName = $Settings.SvcName; CspName = $Settings.CspName }
}
