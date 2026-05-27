function New-NSRequestCertificateUser {
    <#
    .SYNOPSIS
        Creates or updates a NetScaler user for certificate automation.

    .DESCRIPTION
        Creates the limited command policies used by Invoke-RequestCertificate and,
        optionally, creates or updates a NetScaler system user and binds those
        policies to the user. This is the module replacement for the legacy
        GenLeCertForNS -CreateUserPermissions and -CreateApiUser bootstrap path.

        The function is idempotent. Existing command policies are updated with the
        current command specification, existing users are updated when ApiPassword is
        provided, and missing policy bindings are added.

    .PARAMETER NSSession
        Existing NetScaler session returned by Connect-NSNode.

    .PARAMETER ManagementURL
        NetScaler management URL. Used when NSSession is not supplied.

    .PARAMETER Credential
        Credential used to connect when NSSession is not supplied.

    .PARAMETER PolicyName
        Base name for the three command policies. The effective base is truncated to
        24 characters when needed so the suffixed policy names stay within NetScaler
        limits. Alias: NSCPName.

    .PARAMETER ApiUsername
        Optional NetScaler system user to create or update.

    .PARAMETER ApiPassword
        Password for ApiUsername. Accepts plain text, SecureString, PSCredential, or
        legacy GenLeCertForNS secret objects.

    .PARAMETER CsVipName
        Content switching vServers that the generated command policy should permit.
        Required unless UseLbVip is used.

    .PARAMETER UseLbVip
        Indicates that HTTP validation uses an existing load balancing vServer instead
        of content switching vServers.

    .PARAMETER LbName
        Load balancing vServer name used by HTTP validation.

    .PARAMETER SvcName
        Service name used by HTTP validation.

    .PARAMETER RspName
        Responder policy name prefix.

    .PARAMETER RsaName
        Responder action name prefix.

    .PARAMETER CspName
        Content switching policy name.

    .PARAMETER CsaName
        Content switching action name.

    .PARAMETER EnableVipBefore
        Adds enable permission for configured CS vServers.

    .PARAMETER DisableVipAfter
        Adds disable permission for configured CS vServers.

    .PARAMETER UseNetScalerDNS
        Adds DNS TXT record permissions for NetScaler-hosted DNS validation.

    .PARAMETER UpdateGlobalVPNCertBinding
        Adds VPN global binding permissions.

    .PARAMETER Partitions
        Optional NetScaler partitions to bind to the created user. Partition command
        policy permissions are included when non-default partitions are specified.

    .PARAMETER PruneExistingPolicyBindings
        Removes command policy bindings from ApiUsername that do not match the three
        generated policies or have the wrong priority.

    .PARAMETER SaveADCConfig
        Saves the NetScaler configuration after changes.

    .PARAMETER PassThru
        Returns a result object.

    .EXAMPLE
        PS C:\> New-NSRequestCertificateUser -ManagementURL https://adc.example.com -Credential (Get-Credential) -PolicyName script-GenLeCertForNS -CsVipName cs_example_http -ApiUsername GenLEUser -ApiPassword 'P@ssw0rd!' -SaveADCConfig

        Creates or updates the certificate automation policies, creates/updates
        GenLEUser, binds the policies, and saves the ADC configuration.

    .NOTES
        Function  : New-NSRequestCertificateUser
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0526.0001
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Connect')]
    param(
        [Parameter(ParameterSetName = 'Session', Mandatory)]
        [object]$NSSession,

        [Parameter(ParameterSetName = 'Connect', Mandatory)]
        [Alias('URL', 'NSManagementURL')]
        [string]$ManagementURL,

        [Parameter(ParameterSetName = 'Connect', Mandatory)]
        [Alias('NSCredential', 'ADCCredential')]
        [System.Management.Automation.PSCredential]$Credential,

        [Alias('NSCPName')]
        [string]$PolicyName = 'script-GenLeCertForNS',

        [string]$ApiUsername,

        [object]$ApiPassword,

        [Alias('NSCsVipName')]
        [string[]]$CsVipName,

        [switch]$UseLbVip,

        [Alias('NSLbName')]
        [string]$LbName = 'lb_letsencrypt_cert',

        [Alias('NSSvcName')]
        [string]$SvcName = 'svc_letsencrypt_cert_dummy',

        [Alias('NSRspName')]
        [string]$RspName = 'rsp_letsencrypt',

        [Alias('NSRsaName')]
        [string]$RsaName = 'rsa_letsencrypt',

        [Alias('NSCspName')]
        [string]$CspName = 'csp_letsencrypt',

        [string]$CsaName = 'csa_letsencrypt',

        [switch]$EnableVipBefore,

        [switch]$DisableVipAfter,

        [switch]$UseNetScalerDNS,

        [switch]$UpdateGlobalVPNCertBinding,

        [string[]]$Partitions = @('default'),

        [switch]$PruneExistingPolicyBindings,

        [Alias('SaveNSConfig')]
        [switch]$SaveADCConfig,

        [switch]$PassThru
    )

    begin {
        Import-Module J81.NSToolkit.Config -ErrorAction Stop
    }

    process {
        function Get-NSRequestCertificateSystemCmdPolicy {
            param([object]$Session, [string]$Name)

            try {
                if ($Name -match '^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$') {
                    return Invoke-NSGetSystemcmdpolicy -NSSession $Session -Policyname $Name -ErrorAction Stop
                }
                return Invoke-NSNitroApi -NSSession $Session -Method GET -Type systemcmdpolicy -Resource $Name -ErrorAction Stop
            } catch {
                if ($_.Exception.Message -match '404|Not Found|No such resource|does not exist|\[258\]') { return $null }
                throw
            }
        }

        function Add-NSRequestCertificateSystemCmdPolicy {
            param([object]$Session, [string]$Name, [string]$Spec)

            if ($Name -match '^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$') {
                Invoke-NSAddSystemcmdpolicy -NSSession $Session -Policyname $Name -Action 'ALLOW' -Cmdspec $Spec | Out-Null
            } else {
                Invoke-NSNitroApi -NSSession $Session -Method POST -Type systemcmdpolicy -Payload @{ policyname = $Name; action = 'Allow'; cmdspec = $Spec } | Out-Null
            }
        }

        function Update-NSRequestCertificateSystemCmdPolicy {
            param([object]$Session, [string]$Name, [string]$Spec)

            if ($Name -match '^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$') {
                Invoke-NSUpdateSystemcmdpolicy -NSSession $Session -Policyname $Name -Action 'ALLOW' -Cmdspec $Spec | Out-Null
            } else {
                Invoke-NSNitroApi -NSSession $Session -Method PUT -Type systemcmdpolicy -Payload @{ policyname = $Name; action = 'Allow'; cmdspec = $Spec } | Out-Null
            }
        }

        if (-not $UseLbVip -and (-not $CsVipName -or @($CsVipName).Count -lt 1)) {
            throw 'CsVipName is required when creating request-certificate user permissions unless UseLbVip is specified.'
        }

        if (-not $NSSession) {
            $normalizedUrl = ([string]$ManagementURL).TrimEnd('/') + '/'
            $NSSession = Connect-NSNode -ManagementURL $normalizedUrl -Credential $Credential -PassThru -ErrorAction Stop
        }

        $effectivePolicyBase = if ($PolicyName.Length -ge 24) { $PolicyName.Substring(0, 24) } else { $PolicyName }
        $csVipExtraActions = ''
        if ($EnableVipBefore) { $csVipExtraActions += '|enable' }
        if ($DisableVipAfter) { $csVipExtraActions += '|disable' }

        $csVipString = ''
        if (-not $UseLbVip) {
            foreach ($vipName in @($CsVipName | Where-Object { $_ })) {
                $escapedVip = [regex]::Escape($vipName)
                $escapedCsp = [regex]::Escape($CspName)
                $escapedCsa = [regex]::Escape($CsaName)
                $csVipString += "|(^(set|show|bind|unbind$csVipExtraActions)\s+cs\s+vserver(\s+$escapedVip.*))|(^\S+\s+cs\s+(policy\s+$escapedCsp|action\s+$escapedCsa).*)"
            }
        }

        $cmdSpec = [ordered]@{
            Basics = "(^show\s+ns\s+license)|(^show\s+ns\s+license\s+.*)|(^(create|show)\s+system\s+backup)|(^(create|show)\s+system\s+backup\s+.*)|(^convert\s+ssl\s+pkcs12)|(^show\s+ns\s+feature)|(^show\s+ns\s+feature\s+.*)|(^show\s+responder\s+action)|(^show\s+responder\s+policy)|(^(show|add|rm)\s+system\s+file.*-fileLocation.*nsconfig.*ssl.*)|(^show\s+ssl\s+certKey)|(^(add|link|unlink|update)\s+ssl\s+certKey\s+.*)|(^show\s+HA\s+node)|(^show\s+HA\s+node\s+.*)|(^(save|show)\s+ns\s+config)|(^(save|show)\s+ns\s+config\s+.*)|(^show\s+ns\s+trafficDomain)|(^show\s+ns\s+trafficDomain\s+.*)|(^show\s+ssl\s+certChain)|(^show\s+ssl\s+certChain\s+.*)|(^add\s+ssl\s+certificateChain)|(^add\s+ssl\s+certificateChain\s+.*)|(^show\s+ssl\s+certificateChain)|(^show\s+ssl\s+certificateChain\s+.*)|(^show\s+ssl\s+certLink)|(^show\s+ssl\s+certLink\s+.*)"
            LEBkEd = "(^show\s+ns\s+version)|(^\S+\s+Service\s+$([regex]::Escape($SvcName)).*)|(^\S+\s+lb\s+vserver\s+$([regex]::Escape($LbName)).*)|(^\S+\s+responder\s+action\s+$([regex]::Escape($RsaName)).*)|(^\S+\s+responder\s+policy\s+$([regex]::Escape($RspName)).*)"
            LEFtEd = "(^show\s+ns\s+version)$csVipString"
        }
        $cmdSpecPriority = @{
            Basics = 10
            LEBkEd = 20
            LEFtEd = 30
        }
        if ($UseNetScalerDNS) {
            $cmdSpec['LEFtEd'] += "|(^\S+\s+dns\s+txtRec)|(^\S+\s+dns\s+txtRec\s+.*)"
        }
        if ($UpdateGlobalVPNCertBinding) {
            $cmdSpec['LEBkEd'] += "|(^\S+\s+vpn\s+global)|(^\S+\s+vpn\s+global\s+.*)"
        }
        if (@($Partitions | Where-Object { $_ -and $_ -ne 'default' }).Count -gt 0) {
            $cmdSpec['Basics'] += "|(^(show|switch)\s+ns\s+partition)|(^(show|switch)\s+ns\s+partition\s+.*)"
        }

        $policyResults = @()
        foreach ($item in $cmdSpec.GetEnumerator()) {
            $itemPolicyName = "$effectivePolicyBase-$($item.Name)"
            $existing = Get-NSRequestCertificateSystemCmdPolicy -Session $NSSession -Name $itemPolicyName

            if ($existing) {
                if ($PSCmdlet.ShouldProcess($itemPolicyName, 'Update NetScaler system command policy')) {
                    Update-NSRequestCertificateSystemCmdPolicy -Session $NSSession -Name $itemPolicyName -Spec $item.Value
                }
                $policyResults += [pscustomobject]@{ PolicyName = $itemPolicyName; Priority = $cmdSpecPriority[$item.Name]; Action = 'Updated' }
            } else {
                if ($PSCmdlet.ShouldProcess($itemPolicyName, 'Create NetScaler system command policy')) {
                    Add-NSRequestCertificateSystemCmdPolicy -Session $NSSession -Name $itemPolicyName -Spec $item.Value
                }
                $policyResults += [pscustomobject]@{ PolicyName = $itemPolicyName; Priority = $cmdSpecPriority[$item.Name]; Action = 'Created' }
            }
        }

        $userResult = $null
        $bindingResults = @()
        if ($ApiUsername) {
            if (-not $ApiPassword) { throw 'ApiPassword is required when ApiUsername is specified.' }
            $apiPasswordText = ConvertFrom-RequestCertificateLegacySecret -Object $ApiPassword -AsClearText
            $existingUser = $null
            try {
                $existingUser = Invoke-NSGetSystemuser -NSSession $NSSession -Username $ApiUsername -ErrorAction Stop
            } catch {
                if ($_.Exception.Message -notmatch '404|Not Found|No such resource|does not exist|\[258\]') { throw }
            }

            if ($existingUser) {
                if ($PSCmdlet.ShouldProcess($ApiUsername, 'Update NetScaler system user')) {
                    try {
                        Invoke-NSUpdateSystemuser -NSSession $NSSession -Username $ApiUsername -Password $apiPasswordText -Externalauth 'DISABLED' -Allowedmanagementinterface @('API') | Out-Null
                    } catch {
                        Invoke-NSUpdateSystemuser -NSSession $NSSession -Username $ApiUsername -Password $apiPasswordText -Externalauth 'DISABLED' | Out-Null
                    }
                }
                $userResult = [pscustomobject]@{ Username = $ApiUsername; Action = 'Updated' }
            } else {
                if ($PSCmdlet.ShouldProcess($ApiUsername, 'Create NetScaler system user')) {
                    Invoke-NSAddSystemuser -NSSession $NSSession -Username $ApiUsername -Password $apiPasswordText -Externalauth 'DISABLED' | Out-Null
                    try {
                        Invoke-NSUpdateSystemuser -NSSession $NSSession -Username $ApiUsername -Externalauth 'DISABLED' -Allowedmanagementinterface @('API') | Out-Null
                    } catch {
                        Write-Verbose "Could not restrict allowed management interface to API: $($_.Exception.Message)"
                    }
                }
                $userResult = [pscustomobject]@{ Username = $ApiUsername; Action = 'Created' }
            }

            $existingBindings = @()
            try {
                $bindingResponse = Invoke-NSGetSystemuserSystemcmdpolicyBinding -NSSession $NSSession -Username $ApiUsername -ErrorAction Stop
                $existingBindings = @($bindingResponse.systemuser_systemcmdpolicy_binding)
            } catch {
                if ($_.Exception.Message -notmatch '404|Not Found|No such resource|does not exist|\[258\]') { throw }
            }

            $expectedNames = @($policyResults.PolicyName)
            if ($PruneExistingPolicyBindings) {
                $bindingsToRemove = @($existingBindings | Where-Object {
                        $bindingPolicyName = $_.policyname
                        $expectedPolicy = $policyResults | Where-Object { $_.PolicyName -eq $bindingPolicyName } | Select-Object -First 1
                        ($_.policyname -notin $expectedNames) -or
                        ($_.policyname -in $expectedNames -and $expectedPolicy -and [int]$_.priority -ne [int]$expectedPolicy.Priority)
                    })
                foreach ($binding in $bindingsToRemove) {
                    if ($PSCmdlet.ShouldProcess("$ApiUsername/$($binding.policyname)", 'Remove NetScaler system user command policy binding')) {
                        Invoke-NSDeleteSystemuserSystemcmdpolicyBinding -NSSession $NSSession -Username $ApiUsername -Policyname $binding.policyname | Out-Null
                    }
                    $bindingResults += [pscustomobject]@{ Username = $ApiUsername; PolicyName = $binding.policyname; Priority = $binding.priority; Action = 'Removed' }
                }
                if ($bindingsToRemove.Count -gt 0) {
                    $bindingResponse = Invoke-NSGetSystemuserSystemcmdpolicyBinding -NSSession $NSSession -Username $ApiUsername -ErrorAction SilentlyContinue
                    $existingBindings = @($bindingResponse.systemuser_systemcmdpolicy_binding)
                }
            }

            foreach ($policy in $policyResults) {
                $present = @($existingBindings | Where-Object { $_.policyname -ieq $policy.PolicyName -and [int]$_.priority -eq [int]$policy.Priority }).Count -gt 0
                if ($present) {
                    $bindingResults += [pscustomobject]@{ Username = $ApiUsername; PolicyName = $policy.PolicyName; Priority = $policy.Priority; Action = 'Present' }
                } else {
                    if ($PSCmdlet.ShouldProcess("$ApiUsername/$($policy.PolicyName)", 'Create NetScaler system user command policy binding')) {
                        Invoke-NSAddSystemuserSystemcmdpolicyBinding -NSSession $NSSession -Username $ApiUsername -Policyname $policy.PolicyName -Priority ([double]$policy.Priority) | Out-Null
                    }
                    $bindingResults += [pscustomobject]@{ Username = $ApiUsername; PolicyName = $policy.PolicyName; Priority = $policy.Priority; Action = 'Bound' }
                }
            }

            foreach ($partition in @($Partitions | Where-Object { $_ -and $_ -ne 'default' })) {
                try {
                    $partitionBindings = Invoke-NSGetSystemuserNspartitionBinding -NSSession $NSSession -Username $ApiUsername -ErrorAction Stop
                    $partitionPresent = @($partitionBindings.systemuser_nspartition_binding | Where-Object { $_.partitionname -eq $partition }).Count -gt 0
                    if (-not $partitionPresent -and $PSCmdlet.ShouldProcess("$ApiUsername/$partition", 'Create NetScaler system user partition binding')) {
                        Invoke-NSAddSystemuserNspartitionBinding -NSSession $NSSession -Username $ApiUsername -Partitionname $partition | Out-Null
                    }
                } catch {
                    Write-Warning "Could not bind partition '$partition' to '$ApiUsername': $($_.Exception.Message)"
                }
            }
        }

        if ($SaveADCConfig) {
            if ($PSCmdlet.ShouldProcess('nsconfig', 'Save NetScaler configuration')) {
                Invoke-NSSaveNsconfig -NSSession $NSSession | Out-Null
            }
        }

        $result = [pscustomobject]@{
            PolicyBase       = $effectivePolicyBase
            Policies         = $policyResults
            User             = $userResult
            PolicyBindings   = $bindingResults
            SaveADCConfig    = [bool]$SaveADCConfig
            PrunedBindings   = [bool]$PruneExistingPolicyBindings
        }

        if ($PassThru) { return $result }
        return $result
    }
}
