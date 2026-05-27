function Remove-RequestCertificateHttpChallengeBinding {
<#
    .SYNOPSIS
        Removes temporary NetScaler HTTP-01 challenge bindings.

    .DESCRIPTION
        Removes responder policy bindings, responder policies, and responder actions
        created for ACME HTTP-01 validation.

    .PARAMETER NSSession
        Existing NetScaler session returned by Connect-NSNode.

    .PARAMETER ChallengeBindings
        Collection of challenge binding objects returned by Publish-RequestCertificateHttpChallenge.

    .PARAMETER Settings
        Normalized request settings object containing the validation LB vServer name.

    .NOTES
        Function  : Remove-RequestCertificateHttpChallengeBinding
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object]$NSSession,
        [object[]]$ChallengeBindings,
        [Parameter(Mandatory)][object]$Settings
    )

    foreach ($binding in @($ChallengeBindings)) {
        try {
            Invoke-NSDeleteLbvserverResponderpolicyBinding -NSSession $NSSession -Name $Settings.LbName -Policyname $binding.PolicyName -Priority ([double]$binding.Priority) -Bindpoint 'REQUEST' | Out-Null
        } catch {
            Write-RequestCertificateLog Warning 'Cleanup' "Could not unbind responder policy $($binding.PolicyName): $($_.Exception.Message)"
        }
        try {
            Invoke-NSDeleteResponderpolicy -NSSession $NSSession -Name $binding.PolicyName | Out-Null
        } catch {
            Write-RequestCertificateLog Warning 'Cleanup' "Could not remove responder policy $($binding.PolicyName): $($_.Exception.Message)"
        }
        try {
            Invoke-NSDeleteResponderaction -NSSession $NSSession -Name $binding.ActionName | Out-Null
        } catch {
            Write-RequestCertificateLog Warning 'Cleanup' "Could not remove responder action $($binding.ActionName): $($_.Exception.Message)"
        }
    }
}
