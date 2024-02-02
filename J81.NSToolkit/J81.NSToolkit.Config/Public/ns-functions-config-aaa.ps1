function Invoke-NSUpdateAaacertparams {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for certificate parameter resource.
    .PARAMETER Usernamefield 
        Client certificate field that contains the username, in the format &lt;field&gt;:&lt;subfield&gt;. . 
    .PARAMETER Groupnamefield 
        Client certificate field that specifies the group, in the format &lt;field&gt;:&lt;subfield&gt;. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaacertparams 
        An example how to update aaacertparams config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaacertparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaacertparams/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Usernamefield,

        [string]$Groupnamefield,

        [string]$Defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaacertparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('usernamefield') ) { $payload.Add('usernamefield', $usernamefield) }
            if ( $PSBoundParameters.ContainsKey('groupnamefield') ) { $payload.Add('groupnamefield', $groupnamefield) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaacertparams", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaacertparams -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaacertparams: Finished"
    }
}

function Invoke-NSUnsetAaacertparams {
    <#
    .SYNOPSIS
        Unset Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for certificate parameter resource.
    .PARAMETER Usernamefield 
        Client certificate field that contains the username, in the format &lt;field&gt;:&lt;subfield&gt;. . 
    .PARAMETER Groupnamefield 
        Client certificate field that specifies the group, in the format &lt;field&gt;:&lt;subfield&gt;. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAaacertparams 
        An example how to unset aaacertparams config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAaacertparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaacertparams
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$usernamefield,

        [Boolean]$groupnamefield,

        [Boolean]$defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAaacertparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('usernamefield') ) { $payload.Add('usernamefield', $usernamefield) }
            if ( $PSBoundParameters.ContainsKey('groupnamefield') ) { $payload.Add('groupnamefield', $groupnamefield) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaacertparams", "Unset Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type aaacertparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUnsetAaacertparams: Finished"
    }
}

function Invoke-NSGetAaacertparams {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for certificate parameter resource.
    .PARAMETER GetAll 
        Retrieve all aaacertparams object(s).
    .PARAMETER Count
        If specified, the count of the aaacertparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaacertparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaacertparams -GetAll 
        Get all aaacertparams data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaacertparams -name <string>
        Get aaacertparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaacertparams -Filter @{ 'name'='<value>' }
        Get aaacertparams data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaacertparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaacertparams/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaacertparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaacertparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaacertparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaacertparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaacertparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaacertparams configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaacertparams: Ended"
    }
}

function Invoke-NSAddAaaglobalAaapreauthenticationpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the aaapreauthenticationpolicy that can be bound to aaaglobal.
    .PARAMETER Policy 
        Name of the policy to be unbound. 
    .PARAMETER Priority 
        Priority of the bound policy. 
    .PARAMETER PassThru 
        Return details about the created aaaglobal_aaapreauthenticationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaaglobalAaapreauthenticationpolicyBinding 
        An example how to add aaaglobal_aaapreauthenticationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaaglobalAaapreauthenticationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaglobal_aaapreauthenticationpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Policy,

        [double]$Priority,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaaglobalAaapreauthenticationpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSCmdlet.ShouldProcess("aaaglobal_aaapreauthenticationpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaaglobal_aaapreauthenticationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaaglobalAaapreauthenticationpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaaglobalAaapreauthenticationpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaaglobalAaapreauthenticationpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the aaapreauthenticationpolicy that can be bound to aaaglobal.
    .PARAMETER Policy 
        Name of the policy to be unbound.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaaglobalAaapreauthenticationpolicyBinding 
        An example how to delete aaaglobal_aaapreauthenticationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaaglobalAaapreauthenticationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaglobal_aaapreauthenticationpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Policy 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaaglobalAaapreauthenticationpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSCmdlet.ShouldProcess("aaaglobal_aaapreauthenticationpolicy_binding", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaaglobalAaapreauthenticationpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaaglobalAaapreauthenticationpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the aaapreauthenticationpolicy that can be bound to aaaglobal.
    .PARAMETER GetAll 
        Retrieve all aaaglobal_aaapreauthenticationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaaglobal_aaapreauthenticationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaglobalAaapreauthenticationpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaaglobalAaapreauthenticationpolicyBinding -GetAll 
        Get all aaaglobal_aaapreauthenticationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaaglobalAaapreauthenticationpolicyBinding -Count 
        Get the number of aaaglobal_aaapreauthenticationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaglobalAaapreauthenticationpolicyBinding -name <string>
        Get aaaglobal_aaapreauthenticationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaglobalAaapreauthenticationpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaaglobal_aaapreauthenticationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaaglobalAaapreauthenticationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaglobal_aaapreauthenticationpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaaglobalAaapreauthenticationpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaaglobal_aaapreauthenticationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaglobal_aaapreauthenticationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaglobal_aaapreauthenticationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaglobal_aaapreauthenticationpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaglobal_aaapreauthenticationpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaaglobalAaapreauthenticationpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaaglobalAuthenticationnegotiateactionBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationnegotiateaction that can be bound to aaaglobal.
    .PARAMETER Windowsprofile 
        Name of the negotiate profile to be bound. 
    .PARAMETER PassThru 
        Return details about the created aaaglobal_authenticationnegotiateaction_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaaglobalAuthenticationnegotiateactionBinding 
        An example how to add aaaglobal_authenticationnegotiateaction_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaaglobalAuthenticationnegotiateactionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaglobal_authenticationnegotiateaction_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateLength(1, 32)]
        [string]$Windowsprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaaglobalAuthenticationnegotiateactionBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('windowsprofile') ) { $payload.Add('windowsprofile', $windowsprofile) }
            if ( $PSCmdlet.ShouldProcess("aaaglobal_authenticationnegotiateaction_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaaglobal_authenticationnegotiateaction_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaaglobalAuthenticationnegotiateactionBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaaglobalAuthenticationnegotiateactionBinding: Finished"
    }
}

function Invoke-NSDeleteAaaglobalAuthenticationnegotiateactionBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationnegotiateaction that can be bound to aaaglobal.
    .PARAMETER Windowsprofile 
        Name of the negotiate profile to be bound.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaaglobalAuthenticationnegotiateactionBinding 
        An example how to delete aaaglobal_authenticationnegotiateaction_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaaglobalAuthenticationnegotiateactionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaglobal_authenticationnegotiateaction_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Windowsprofile 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaaglobalAuthenticationnegotiateactionBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Windowsprofile') ) { $arguments.Add('windowsprofile', $Windowsprofile) }
            if ( $PSCmdlet.ShouldProcess("aaaglobal_authenticationnegotiateaction_binding", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaaglobalAuthenticationnegotiateactionBinding: Finished"
    }
}

function Invoke-NSGetAaaglobalAuthenticationnegotiateactionBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authenticationnegotiateaction that can be bound to aaaglobal.
    .PARAMETER GetAll 
        Retrieve all aaaglobal_authenticationnegotiateaction_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaaglobal_authenticationnegotiateaction_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaglobalAuthenticationnegotiateactionBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaaglobalAuthenticationnegotiateactionBinding -GetAll 
        Get all aaaglobal_authenticationnegotiateaction_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaaglobalAuthenticationnegotiateactionBinding -Count 
        Get the number of aaaglobal_authenticationnegotiateaction_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaglobalAuthenticationnegotiateactionBinding -name <string>
        Get aaaglobal_authenticationnegotiateaction_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaglobalAuthenticationnegotiateactionBinding -Filter @{ 'name'='<value>' }
        Get aaaglobal_authenticationnegotiateaction_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaaglobalAuthenticationnegotiateactionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaglobal_authenticationnegotiateaction_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaaglobalAuthenticationnegotiateactionBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaaglobal_authenticationnegotiateaction_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaglobal_authenticationnegotiateaction_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaglobal_authenticationnegotiateaction_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaglobal_authenticationnegotiateaction_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaglobal_authenticationnegotiateaction_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaaglobalAuthenticationnegotiateactionBinding: Ended"
    }
}

function Invoke-NSGetAaaglobalBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to aaaglobal.
    .PARAMETER GetAll 
        Retrieve all aaaglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaaglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaaglobalBinding -GetAll 
        Get all aaaglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaglobalBinding -name <string>
        Get aaaglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaglobalBinding -Filter @{ 'name'='<value>' }
        Get aaaglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaaglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaglobal_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaaglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaaglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaaglobalBinding: Ended"
    }
}

function Invoke-NSAddAaagroup {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for AAA group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the group is added. 
    .PARAMETER Weight 
        Weight of this group with respect to other configured aaa groups (lower the number higher the weight). 
         
         
        Maximum value = 65535 
    .PARAMETER PassThru 
        Return details about the created aaagroup item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroup -groupname <string>
        An example how to add aaagroup config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [double]$Weight = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSCmdlet.ShouldProcess("aaagroup", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type aaagroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroup -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroup: Finished"
    }
}

function Invoke-NSDeleteAaagroup {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for AAA group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the group is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroup -Groupname <string>
        An example how to delete aaagroup config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroup: Finished"
    }
}

function Invoke-NSGetAaagroup {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for AAA group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the group is added. 
    .PARAMETER GetAll 
        Retrieve all aaagroup object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroup -GetAll 
        Get all aaagroup data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroup -Count 
        Get the number of aaagroup objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroup -name <string>
        Get aaagroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroup -Filter @{ 'name'='<value>' }
        Get aaagroup data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaagroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroup: Ended"
    }
}

function Invoke-NSAddAaagroupAaauserBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Username 
        The user name. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_aaauser_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupAaauserBinding -groupname <string>
        An example how to add aaagroup_aaauser_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupAaauserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_aaauser_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Username,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupAaauserBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_aaauser_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_aaauser_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupAaauserBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupAaauserBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupAaauserBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Username 
        The user name.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupAaauserBinding -Groupname <string>
        An example how to delete aaagroup_aaauser_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupAaauserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_aaauser_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupAaauserBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Username') ) { $arguments.Add('username', $Username) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupAaauserBinding: Finished"
    }
}

function Invoke-NSGetAaagroupAaauserBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAaauserBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupAaauserBinding -GetAll 
        Get all aaagroup_aaauser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupAaauserBinding -Count 
        Get the number of aaagroup_aaauser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAaauserBinding -name <string>
        Get aaagroup_aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAaauserBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupAaauserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_aaauser_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupAaauserBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_aaauser_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_aaauser_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupAaauserBinding: Ended"
    }
}

function Invoke-NSAddAaagroupAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupAuditnslogpolicyBinding -groupname <string>
        An example how to add aaagroup_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_auditnslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_auditnslogpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupAuditnslogpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupAuditnslogpolicyBinding -Groupname <string>
        An example how to delete aaagroup_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_auditnslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaagroupAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAuditnslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupAuditnslogpolicyBinding -GetAll 
        Get all aaagroup_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupAuditnslogpolicyBinding -Count 
        Get the number of aaagroup_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAuditnslogpolicyBinding -name <string>
        Get aaagroup_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAuditnslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_auditnslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupAuditnslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_auditnslogpolicy_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_auditnslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupAuditnslogpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaagroupAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupAuditsyslogpolicyBinding -groupname <string>
        An example how to add aaagroup_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_auditsyslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_auditsyslogpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupAuditsyslogpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupAuditsyslogpolicyBinding -Groupname <string>
        An example how to delete aaagroup_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_auditsyslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaagroupAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAuditsyslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupAuditsyslogpolicyBinding -GetAll 
        Get all aaagroup_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupAuditsyslogpolicyBinding -Count 
        Get the number of aaagroup_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAuditsyslogpolicyBinding -name <string>
        Get aaagroup_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAuditsyslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_auditsyslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupAuditsyslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_auditsyslogpolicy_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupAuditsyslogpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaagroupAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_authorizationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupAuthorizationpolicyBinding -groupname <string>
        An example how to add aaagroup_authorizationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupAuthorizationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_authorizationpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupAuthorizationpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_authorizationpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_authorizationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupAuthorizationpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupAuthorizationpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupAuthorizationpolicyBinding -Groupname <string>
        An example how to delete aaagroup_authorizationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupAuthorizationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_authorizationpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupAuthorizationpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupAuthorizationpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaagroupAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_authorizationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_authorizationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAuthorizationpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupAuthorizationpolicyBinding -GetAll 
        Get all aaagroup_authorizationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupAuthorizationpolicyBinding -Count 
        Get the number of aaagroup_authorizationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAuthorizationpolicyBinding -name <string>
        Get aaagroup_authorizationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupAuthorizationpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_authorizationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupAuthorizationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_authorizationpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupAuthorizationpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_authorizationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_authorizationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_authorizationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_authorizationpolicy_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_authorizationpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupAuthorizationpolicyBinding: Ended"
    }
}

function Invoke-NSGetAaagroupBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupBinding -GetAll 
        Get all aaagroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupBinding -name <string>
        Get aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupBinding: Ended"
    }
}

function Invoke-NSAddAaagroupIntranetip6Binding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Intranetip6 
        The Intranet IP6(s) bound to the group. 
    .PARAMETER Numaddr 
        Numbers of ipv6 address bound starting with intranetip6. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_intranetip6_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupIntranetip6Binding -groupname <string>
        An example how to add aaagroup_intranetip6_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupIntranetip6Binding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_intranetip6_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Gotopriorityexpression,

        [string]$Intranetip6,

        [double]$Numaddr,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupIntranetip6Binding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('intranetip6') ) { $payload.Add('intranetip6', $intranetip6) }
            if ( $PSBoundParameters.ContainsKey('numaddr') ) { $payload.Add('numaddr', $numaddr) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_intranetip6_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_intranetip6_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupIntranetip6Binding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupIntranetip6Binding: Finished"
    }
}

function Invoke-NSDeleteAaagroupIntranetip6Binding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Intranetip6 
        The Intranet IP6(s) bound to the group. 
    .PARAMETER Numaddr 
        Numbers of ipv6 address bound starting with intranetip6.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupIntranetip6Binding -Groupname <string>
        An example how to delete aaagroup_intranetip6_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupIntranetip6Binding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_intranetip6_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Intranetip6,

        [double]$Numaddr 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupIntranetip6Binding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetip6') ) { $arguments.Add('intranetip6', $Intranetip6) }
            if ( $PSBoundParameters.ContainsKey('Numaddr') ) { $arguments.Add('numaddr', $Numaddr) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupIntranetip6Binding: Finished"
    }
}

function Invoke-NSGetAaagroupIntranetip6Binding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_intranetip6_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_intranetip6_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupIntranetip6Binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupIntranetip6Binding -GetAll 
        Get all aaagroup_intranetip6_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupIntranetip6Binding -Count 
        Get the number of aaagroup_intranetip6_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupIntranetip6Binding -name <string>
        Get aaagroup_intranetip6_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupIntranetip6Binding -Filter @{ 'name'='<value>' }
        Get aaagroup_intranetip6_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupIntranetip6Binding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_intranetip6_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupIntranetip6Binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_intranetip6_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_intranetip6_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_intranetip6_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_intranetip6_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_intranetip6_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupIntranetip6Binding: Ended"
    }
}

function Invoke-NSAddAaagroupIntranetipBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Intranetip 
        The Intranet IP(s) bound to the group. 
    .PARAMETER Netmask 
        The netmask for the Intranet IP. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_intranetip_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupIntranetipBinding -groupname <string>
        An example how to add aaagroup_intranetip_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupIntranetipBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_intranetip_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Intranetip,

        [string]$Netmask,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupIntranetipBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('intranetip') ) { $payload.Add('intranetip', $intranetip) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_intranetip_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_intranetip_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupIntranetipBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupIntranetipBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupIntranetipBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Intranetip 
        The Intranet IP(s) bound to the group. 
    .PARAMETER Netmask 
        The netmask for the Intranet IP.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupIntranetipBinding -Groupname <string>
        An example how to delete aaagroup_intranetip_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupIntranetipBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_intranetip_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Intranetip,

        [string]$Netmask 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupIntranetipBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetip') ) { $arguments.Add('intranetip', $Intranetip) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupIntranetipBinding: Finished"
    }
}

function Invoke-NSGetAaagroupIntranetipBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_intranetip_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_intranetip_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupIntranetipBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupIntranetipBinding -GetAll 
        Get all aaagroup_intranetip_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupIntranetipBinding -Count 
        Get the number of aaagroup_intranetip_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupIntranetipBinding -name <string>
        Get aaagroup_intranetip_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupIntranetipBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_intranetip_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupIntranetipBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_intranetip_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupIntranetipBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_intranetip_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_intranetip_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_intranetip_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_intranetip_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_intranetip_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupIntranetipBinding: Ended"
    }
}

function Invoke-NSAddAaagroupTmsessionpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_tmsessionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupTmsessionpolicyBinding -groupname <string>
        An example how to add aaagroup_tmsessionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupTmsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_tmsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupTmsessionpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_tmsessionpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_tmsessionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupTmsessionpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupTmsessionpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupTmsessionpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupTmsessionpolicyBinding -Groupname <string>
        An example how to delete aaagroup_tmsessionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupTmsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_tmsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupTmsessionpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupTmsessionpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaagroupTmsessionpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_tmsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_tmsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupTmsessionpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupTmsessionpolicyBinding -GetAll 
        Get all aaagroup_tmsessionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupTmsessionpolicyBinding -Count 
        Get the number of aaagroup_tmsessionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupTmsessionpolicyBinding -name <string>
        Get aaagroup_tmsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupTmsessionpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_tmsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupTmsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_tmsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupTmsessionpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_tmsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_tmsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_tmsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_tmsessionpolicy_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_tmsessionpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupTmsessionpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaagroupVpnintranetapplicationBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Intranetapplication 
        Bind the group to the specified intranet VPN application. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnintranetapplication_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupVpnintranetapplicationBinding -groupname <string>
        An example how to add aaagroup_vpnintranetapplication_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupVpnintranetapplicationBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnintranetapplication_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Intranetapplication,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupVpnintranetapplicationBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('intranetapplication') ) { $payload.Add('intranetapplication', $intranetapplication) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_vpnintranetapplication_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnintranetapplication_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupVpnintranetapplicationBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupVpnintranetapplicationBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupVpnintranetapplicationBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Intranetapplication 
        Bind the group to the specified intranet VPN application.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupVpnintranetapplicationBinding -Groupname <string>
        An example how to delete aaagroup_vpnintranetapplication_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupVpnintranetapplicationBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnintranetapplication_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Intranetapplication 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupVpnintranetapplicationBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetapplication') ) { $arguments.Add('intranetapplication', $Intranetapplication) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupVpnintranetapplicationBinding: Finished"
    }
}

function Invoke-NSGetAaagroupVpnintranetapplicationBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_vpnintranetapplication_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnintranetapplication_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnintranetapplicationBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupVpnintranetapplicationBinding -GetAll 
        Get all aaagroup_vpnintranetapplication_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupVpnintranetapplicationBinding -Count 
        Get the number of aaagroup_vpnintranetapplication_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnintranetapplicationBinding -name <string>
        Get aaagroup_vpnintranetapplication_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnintranetapplicationBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_vpnintranetapplication_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupVpnintranetapplicationBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnintranetapplication_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupVpnintranetapplicationBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_vpnintranetapplication_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnintranetapplication_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnintranetapplication_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnintranetapplication_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnintranetapplication_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupVpnintranetapplicationBinding: Ended"
    }
}

function Invoke-NSAddAaagroupVpnsessionpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnsessionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupVpnsessionpolicyBinding -groupname <string>
        An example how to add aaagroup_vpnsessionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupVpnsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupVpnsessionpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_vpnsessionpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnsessionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupVpnsessionpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupVpnsessionpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupVpnsessionpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupVpnsessionpolicyBinding -Groupname <string>
        An example how to delete aaagroup_vpnsessionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupVpnsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupVpnsessionpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupVpnsessionpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaagroupVpnsessionpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_vpnsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnsessionpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupVpnsessionpolicyBinding -GetAll 
        Get all aaagroup_vpnsessionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupVpnsessionpolicyBinding -Count 
        Get the number of aaagroup_vpnsessionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnsessionpolicyBinding -name <string>
        Get aaagroup_vpnsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnsessionpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_vpnsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupVpnsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupVpnsessionpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_vpnsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnsessionpolicy_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnsessionpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupVpnsessionpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaagroupVpntrafficpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpntrafficpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupVpntrafficpolicyBinding -groupname <string>
        An example how to add aaagroup_vpntrafficpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupVpntrafficpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpntrafficpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupVpntrafficpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_vpntrafficpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpntrafficpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupVpntrafficpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupVpntrafficpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupVpntrafficpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupVpntrafficpolicyBinding -Groupname <string>
        An example how to delete aaagroup_vpntrafficpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupVpntrafficpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpntrafficpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupVpntrafficpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupVpntrafficpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaagroupVpntrafficpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_vpntrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_vpntrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpntrafficpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupVpntrafficpolicyBinding -GetAll 
        Get all aaagroup_vpntrafficpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupVpntrafficpolicyBinding -Count 
        Get the number of aaagroup_vpntrafficpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpntrafficpolicyBinding -name <string>
        Get aaagroup_vpntrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpntrafficpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_vpntrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupVpntrafficpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpntrafficpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupVpntrafficpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_vpntrafficpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpntrafficpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpntrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpntrafficpolicy_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpntrafficpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupVpntrafficpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaagroupVpnurlBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Urlname 
        The intranet url. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupVpnurlBinding -groupname <string>
        An example how to add aaagroup_vpnurl_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupVpnurlBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnurl_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Urlname,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupVpnurlBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('urlname') ) { $payload.Add('urlname', $urlname) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_vpnurl_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupVpnurlBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupVpnurlBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupVpnurlBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Urlname 
        The intranet url.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupVpnurlBinding -Groupname <string>
        An example how to delete aaagroup_vpnurl_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupVpnurlBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnurl_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Urlname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupVpnurlBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Urlname') ) { $arguments.Add('urlname', $Urlname) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupVpnurlBinding: Finished"
    }
}

function Invoke-NSGetAaagroupVpnurlBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_vpnurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnurlBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupVpnurlBinding -GetAll 
        Get all aaagroup_vpnurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupVpnurlBinding -Count 
        Get the number of aaagroup_vpnurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnurlBinding -name <string>
        Get aaagroup_vpnurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnurlBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_vpnurl_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupVpnurlBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnurl_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupVpnurlBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_vpnurl_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnurl_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnurl_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnurl_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupVpnurlBinding: Ended"
    }
}

function Invoke-NSAddAaagroupVpnurlpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnurlpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaagroupVpnurlpolicyBinding -groupname <string>
        An example how to add aaagroup_vpnurlpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaagroupVpnurlpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnurlpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaagroupVpnurlpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_vpnurlpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnurlpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaagroupVpnurlpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaagroupVpnurlpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaagroupVpnurlpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaagroupVpnurlpolicyBinding -Groupname <string>
        An example how to delete aaagroup_vpnurlpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaagroupVpnurlpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnurlpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaagroupVpnurlpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaagroupVpnurlpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaagroupVpnurlpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_vpnurlpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnurlpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnurlpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupVpnurlpolicyBinding -GetAll 
        Get all aaagroup_vpnurlpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaagroupVpnurlpolicyBinding -Count 
        Get the number of aaagroup_vpnurlpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnurlpolicyBinding -name <string>
        Get aaagroup_vpnurlpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaagroupVpnurlpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaagroup_vpnurlpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaagroupVpnurlpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaagroup_vpnurlpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaagroupVpnurlpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_vpnurlpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnurlpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnurlpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnurlpolicy_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnurlpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaagroupVpnurlpolicyBinding: Ended"
    }
}

function Invoke-NSCheckAaakcdaccount {
    <#
    .SYNOPSIS
        Check Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Realmstr 
        Kerberos Realm. 
    .PARAMETER Delegateduser 
        Username that can perform kerberos constrained delegation. 
    .PARAMETER Kcdpassword 
        Password for Delegated User. 
    .PARAMETER Servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn. 
    .PARAMETER Userrealm 
        Realm of the user.
    .EXAMPLE
        PS C:\>Invoke-NSCheckAaakcdaccount -realmstr <string> -delegateduser <string> -kcdpassword <string> -servicespn <string>
        An example how to check aaakcdaccount config Object(s).
    .NOTES
        File Name : Invoke-NSCheckAaakcdaccount
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaakcdaccount/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Realmstr,

        [Parameter(Mandatory)]
        [string]$Delegateduser,

        [Parameter(Mandatory)]
        [string]$Kcdpassword,

        [Parameter(Mandatory)]
        [string]$Servicespn,

        [string]$Userrealm 

    )
    begin {
        Write-Verbose "Invoke-NSCheckAaakcdaccount: Starting"
    }
    process {
        try {
            $payload = @{ realmstr = $realmstr
                delegateduser      = $delegateduser
                kcdpassword        = $kcdpassword
                servicespn         = $servicespn
            }
            if ( $PSBoundParameters.ContainsKey('userrealm') ) { $payload.Add('userrealm', $userrealm) }
            if ( $PSCmdlet.ShouldProcess($Name, "Check Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type aaakcdaccount -Action check -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSCheckAaakcdaccount: Finished"
    }
}

function Invoke-NSUnsetAaakcdaccount {
    <#
    .SYNOPSIS
        Unset Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Kcdaccount 
        The name of the KCD account. 
    .PARAMETER Keytab 
        The path to the keytab file. If specified other parameters in this command need not be given. 
    .PARAMETER Usercert 
        SSL Cert (including private key) for Delegated User. 
    .PARAMETER Cacert 
        CA Cert for UserCert or when doing PKINIT backchannel. 
    .PARAMETER Userrealm 
        Realm of the user. 
    .PARAMETER Enterpriserealm 
        Enterprise Realm of the user. This should be given only in certain KDC deployments where KDC expects Enterprise username instead of Principal Name. 
    .PARAMETER Servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAaakcdaccount -kcdaccount <string>
        An example how to unset aaakcdaccount config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAaakcdaccount
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaakcdaccount
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Kcdaccount,

        [Boolean]$keytab,

        [Boolean]$usercert,

        [Boolean]$cacert,

        [Boolean]$userrealm,

        [Boolean]$enterpriserealm,

        [Boolean]$servicespn 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAaakcdaccount: Starting"
    }
    process {
        try {
            $payload = @{ kcdaccount = $kcdaccount }
            if ( $PSBoundParameters.ContainsKey('keytab') ) { $payload.Add('keytab', $keytab) }
            if ( $PSBoundParameters.ContainsKey('usercert') ) { $payload.Add('usercert', $usercert) }
            if ( $PSBoundParameters.ContainsKey('cacert') ) { $payload.Add('cacert', $cacert) }
            if ( $PSBoundParameters.ContainsKey('userrealm') ) { $payload.Add('userrealm', $userrealm) }
            if ( $PSBoundParameters.ContainsKey('enterpriserealm') ) { $payload.Add('enterpriserealm', $enterpriserealm) }
            if ( $PSBoundParameters.ContainsKey('servicespn') ) { $payload.Add('servicespn', $servicespn) }
            if ( $PSCmdlet.ShouldProcess("$kcdaccount", "Unset Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type aaakcdaccount -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUnsetAaakcdaccount: Finished"
    }
}

function Invoke-NSDeleteAaakcdaccount {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Kcdaccount 
        The name of the KCD account.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaakcdaccount -Kcdaccount <string>
        An example how to delete aaakcdaccount config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaakcdaccount
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaakcdaccount/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Kcdaccount 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaakcdaccount: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$kcdaccount", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaakcdaccount -NitroPath nitro/v1/config -Resource $kcdaccount -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaakcdaccount: Finished"
    }
}

function Invoke-NSUpdateAaakcdaccount {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Kcdaccount 
        The name of the KCD account. 
    .PARAMETER Keytab 
        The path to the keytab file. If specified other parameters in this command need not be given. 
    .PARAMETER Realmstr 
        Kerberos Realm. 
    .PARAMETER Delegateduser 
        Username that can perform kerberos constrained delegation. 
    .PARAMETER Kcdpassword 
        Password for Delegated User. 
    .PARAMETER Usercert 
        SSL Cert (including private key) for Delegated User. 
    .PARAMETER Cacert 
        CA Cert for UserCert or when doing PKINIT backchannel. 
    .PARAMETER Userrealm 
        Realm of the user. 
    .PARAMETER Enterpriserealm 
        Enterprise Realm of the user. This should be given only in certain KDC deployments where KDC expects Enterprise username instead of Principal Name. 
    .PARAMETER Servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn. 
    .PARAMETER PassThru 
        Return details about the created aaakcdaccount item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaakcdaccount -kcdaccount <string>
        An example how to update aaakcdaccount config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaakcdaccount
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaakcdaccount/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Kcdaccount,

        [string]$Keytab,

        [string]$Realmstr,

        [string]$Delegateduser,

        [string]$Kcdpassword,

        [string]$Usercert,

        [string]$Cacert,

        [string]$Userrealm,

        [string]$Enterpriserealm,

        [string]$Servicespn,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaakcdaccount: Starting"
    }
    process {
        try {
            $payload = @{ kcdaccount = $kcdaccount }
            if ( $PSBoundParameters.ContainsKey('keytab') ) { $payload.Add('keytab', $keytab) }
            if ( $PSBoundParameters.ContainsKey('realmstr') ) { $payload.Add('realmstr', $realmstr) }
            if ( $PSBoundParameters.ContainsKey('delegateduser') ) { $payload.Add('delegateduser', $delegateduser) }
            if ( $PSBoundParameters.ContainsKey('kcdpassword') ) { $payload.Add('kcdpassword', $kcdpassword) }
            if ( $PSBoundParameters.ContainsKey('usercert') ) { $payload.Add('usercert', $usercert) }
            if ( $PSBoundParameters.ContainsKey('cacert') ) { $payload.Add('cacert', $cacert) }
            if ( $PSBoundParameters.ContainsKey('userrealm') ) { $payload.Add('userrealm', $userrealm) }
            if ( $PSBoundParameters.ContainsKey('enterpriserealm') ) { $payload.Add('enterpriserealm', $enterpriserealm) }
            if ( $PSBoundParameters.ContainsKey('servicespn') ) { $payload.Add('servicespn', $servicespn) }
            if ( $PSCmdlet.ShouldProcess("aaakcdaccount", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaakcdaccount -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaakcdaccount -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaakcdaccount: Finished"
    }
}

function Invoke-NSAddAaakcdaccount {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Kcdaccount 
        The name of the KCD account. 
    .PARAMETER Keytab 
        The path to the keytab file. If specified other parameters in this command need not be given. 
    .PARAMETER Realmstr 
        Kerberos Realm. 
    .PARAMETER Delegateduser 
        Username that can perform kerberos constrained delegation. 
    .PARAMETER Kcdpassword 
        Password for Delegated User. 
    .PARAMETER Usercert 
        SSL Cert (including private key) for Delegated User. 
    .PARAMETER Cacert 
        CA Cert for UserCert or when doing PKINIT backchannel. 
    .PARAMETER Userrealm 
        Realm of the user. 
    .PARAMETER Enterpriserealm 
        Enterprise Realm of the user. This should be given only in certain KDC deployments where KDC expects Enterprise username instead of Principal Name. 
    .PARAMETER Servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn. 
    .PARAMETER PassThru 
        Return details about the created aaakcdaccount item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaakcdaccount -kcdaccount <string>
        An example how to add aaakcdaccount config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaakcdaccount
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaakcdaccount/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Kcdaccount,

        [string]$Keytab,

        [string]$Realmstr,

        [string]$Delegateduser,

        [string]$Kcdpassword,

        [string]$Usercert,

        [string]$Cacert,

        [string]$Userrealm,

        [string]$Enterpriserealm,

        [string]$Servicespn,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaakcdaccount: Starting"
    }
    process {
        try {
            $payload = @{ kcdaccount = $kcdaccount }
            if ( $PSBoundParameters.ContainsKey('keytab') ) { $payload.Add('keytab', $keytab) }
            if ( $PSBoundParameters.ContainsKey('realmstr') ) { $payload.Add('realmstr', $realmstr) }
            if ( $PSBoundParameters.ContainsKey('delegateduser') ) { $payload.Add('delegateduser', $delegateduser) }
            if ( $PSBoundParameters.ContainsKey('kcdpassword') ) { $payload.Add('kcdpassword', $kcdpassword) }
            if ( $PSBoundParameters.ContainsKey('usercert') ) { $payload.Add('usercert', $usercert) }
            if ( $PSBoundParameters.ContainsKey('cacert') ) { $payload.Add('cacert', $cacert) }
            if ( $PSBoundParameters.ContainsKey('userrealm') ) { $payload.Add('userrealm', $userrealm) }
            if ( $PSBoundParameters.ContainsKey('enterpriserealm') ) { $payload.Add('enterpriserealm', $enterpriserealm) }
            if ( $PSBoundParameters.ContainsKey('servicespn') ) { $payload.Add('servicespn', $servicespn) }
            if ( $PSCmdlet.ShouldProcess("aaakcdaccount", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type aaakcdaccount -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaakcdaccount -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaakcdaccount: Finished"
    }
}

function Invoke-NSGetAaakcdaccount {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Kcdaccount 
        The name of the KCD account. 
    .PARAMETER GetAll 
        Retrieve all aaakcdaccount object(s).
    .PARAMETER Count
        If specified, the count of the aaakcdaccount object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaakcdaccount
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaakcdaccount -GetAll 
        Get all aaakcdaccount data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaakcdaccount -Count 
        Get the number of aaakcdaccount objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaakcdaccount -name <string>
        Get aaakcdaccount object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaakcdaccount -Filter @{ 'name'='<value>' }
        Get aaakcdaccount data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaakcdaccount
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaakcdaccount/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Kcdaccount,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetAaakcdaccount: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaakcdaccount objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaakcdaccount objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaakcdaccount objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaakcdaccount configuration for property 'kcdaccount'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Resource $kcdaccount -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaakcdaccount configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaakcdaccount: Ended"
    }
}

function Invoke-NSUnsetAaaldapparams {
    <#
    .SYNOPSIS
        Unset Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for LDAP parameter resource.
    .PARAMETER Serverip 
        IP address of your LDAP server. 
    .PARAMETER Serverport 
        Port number on which the LDAP server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the LDAP server. 
    .PARAMETER Ldapbase 
        Base (the server and location) from which LDAP search commands should start. 
        If the LDAP server is running locally, the default value of base is dc=netscaler, dc=com. 
    .PARAMETER Ldapbinddn 
        Complete distinguished name (DN) string used for binding to the LDAP server. 
    .PARAMETER Ldapbinddnpassword 
        Password for binding to the LDAP server. 
    .PARAMETER Ldaploginname 
        Name attribute that the Citrix ADC uses to query the external LDAP server or an Active Directory. 
    .PARAMETER Searchfilter 
        String to be combined with the default LDAP user search string to form the value to use when executing an LDAP search. 
        For example, the following values: 
        vpnallowed=true, 
        ldaploginame=""samaccount"" 
        when combined with the user-supplied username ""bob"", yield the following LDAP search string: 
        ""(&amp;(vpnallowed=true)(samaccount=bob)"". 
    .PARAMETER Groupattrname 
        Attribute name used for group extraction from the LDAP server. 
    .PARAMETER Subattributename 
        Subattribute name used for group extraction from the LDAP server. 
    .PARAMETER Sectype 
        Type of security used for communications between the Citrix ADC and the LDAP server. For the PLAINTEXT setting, no encryption is required. 
         
        Possible values = PLAINTEXT, TLS, SSL 
    .PARAMETER Svrtype 
        The type of LDAP server. 
         
        Possible values = AD, NDS 
    .PARAMETER Ssonameattribute 
        Attribute used by the Citrix ADC to query an external LDAP server or Active Directory for an alternative username. 
        This alternative username is then used for single sign-on (SSO). 
    .PARAMETER Passwdchange 
        Accept password change requests. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nestedgroupextraction 
        Queries the external LDAP server to determine whether the specified group belongs to another group. 
         
        Possible values = ON, OFF 
    .PARAMETER Maxnestinglevel 
        Number of levels up to which the system can query nested LDAP groups. 
    .PARAMETER Groupnameidentifier 
        LDAP-group attribute that uniquely identifies the group. No two groups on one LDAP server can have the same group name identifier. 
    .PARAMETER Groupsearchattribute 
        LDAP-group attribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
    .PARAMETER Groupsearchsubattribute 
        LDAP-group subattribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
    .PARAMETER Groupsearchfilter 
        Search-expression that can be specified for sending group-search requests to the LDAP server. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAaaldapparams 
        An example how to unset aaaldapparams config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAaaldapparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaldapparams
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$serverip,

        [Boolean]$serverport,

        [Boolean]$authtimeout,

        [Boolean]$ldapbase,

        [Boolean]$ldapbinddn,

        [Boolean]$ldapbinddnpassword,

        [Boolean]$ldaploginname,

        [Boolean]$searchfilter,

        [Boolean]$groupattrname,

        [Boolean]$subattributename,

        [Boolean]$sectype,

        [Boolean]$svrtype,

        [Boolean]$ssonameattribute,

        [Boolean]$passwdchange,

        [Boolean]$nestedgroupextraction,

        [Boolean]$maxnestinglevel,

        [Boolean]$groupnameidentifier,

        [Boolean]$groupsearchattribute,

        [Boolean]$groupsearchsubattribute,

        [Boolean]$groupsearchfilter,

        [Boolean]$defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAaaldapparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('ldapbase') ) { $payload.Add('ldapbase', $ldapbase) }
            if ( $PSBoundParameters.ContainsKey('ldapbinddn') ) { $payload.Add('ldapbinddn', $ldapbinddn) }
            if ( $PSBoundParameters.ContainsKey('ldapbinddnpassword') ) { $payload.Add('ldapbinddnpassword', $ldapbinddnpassword) }
            if ( $PSBoundParameters.ContainsKey('ldaploginname') ) { $payload.Add('ldaploginname', $ldaploginname) }
            if ( $PSBoundParameters.ContainsKey('searchfilter') ) { $payload.Add('searchfilter', $searchfilter) }
            if ( $PSBoundParameters.ContainsKey('groupattrname') ) { $payload.Add('groupattrname', $groupattrname) }
            if ( $PSBoundParameters.ContainsKey('subattributename') ) { $payload.Add('subattributename', $subattributename) }
            if ( $PSBoundParameters.ContainsKey('sectype') ) { $payload.Add('sectype', $sectype) }
            if ( $PSBoundParameters.ContainsKey('svrtype') ) { $payload.Add('svrtype', $svrtype) }
            if ( $PSBoundParameters.ContainsKey('ssonameattribute') ) { $payload.Add('ssonameattribute', $ssonameattribute) }
            if ( $PSBoundParameters.ContainsKey('passwdchange') ) { $payload.Add('passwdchange', $passwdchange) }
            if ( $PSBoundParameters.ContainsKey('nestedgroupextraction') ) { $payload.Add('nestedgroupextraction', $nestedgroupextraction) }
            if ( $PSBoundParameters.ContainsKey('maxnestinglevel') ) { $payload.Add('maxnestinglevel', $maxnestinglevel) }
            if ( $PSBoundParameters.ContainsKey('groupnameidentifier') ) { $payload.Add('groupnameidentifier', $groupnameidentifier) }
            if ( $PSBoundParameters.ContainsKey('groupsearchattribute') ) { $payload.Add('groupsearchattribute', $groupsearchattribute) }
            if ( $PSBoundParameters.ContainsKey('groupsearchsubattribute') ) { $payload.Add('groupsearchsubattribute', $groupsearchsubattribute) }
            if ( $PSBoundParameters.ContainsKey('groupsearchfilter') ) { $payload.Add('groupsearchfilter', $groupsearchfilter) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaaldapparams", "Unset Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type aaaldapparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUnsetAaaldapparams: Finished"
    }
}

function Invoke-NSUpdateAaaldapparams {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for LDAP parameter resource.
    .PARAMETER Serverip 
        IP address of your LDAP server. 
    .PARAMETER Serverport 
        Port number on which the LDAP server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the LDAP server. 
    .PARAMETER Ldapbase 
        Base (the server and location) from which LDAP search commands should start. 
        If the LDAP server is running locally, the default value of base is dc=netscaler, dc=com. 
    .PARAMETER Ldapbinddn 
        Complete distinguished name (DN) string used for binding to the LDAP server. 
    .PARAMETER Ldapbinddnpassword 
        Password for binding to the LDAP server. 
    .PARAMETER Ldaploginname 
        Name attribute that the Citrix ADC uses to query the external LDAP server or an Active Directory. 
    .PARAMETER Searchfilter 
        String to be combined with the default LDAP user search string to form the value to use when executing an LDAP search. 
        For example, the following values: 
        vpnallowed=true, 
        ldaploginame=""samaccount"" 
        when combined with the user-supplied username ""bob"", yield the following LDAP search string: 
        ""(&amp;(vpnallowed=true)(samaccount=bob)"". 
    .PARAMETER Groupattrname 
        Attribute name used for group extraction from the LDAP server. 
    .PARAMETER Subattributename 
        Subattribute name used for group extraction from the LDAP server. 
    .PARAMETER Sectype 
        Type of security used for communications between the Citrix ADC and the LDAP server. For the PLAINTEXT setting, no encryption is required. 
         
        Possible values = PLAINTEXT, TLS, SSL 
    .PARAMETER Svrtype 
        The type of LDAP server. 
         
        Possible values = AD, NDS 
    .PARAMETER Ssonameattribute 
        Attribute used by the Citrix ADC to query an external LDAP server or Active Directory for an alternative username. 
        This alternative username is then used for single sign-on (SSO). 
    .PARAMETER Passwdchange 
        Accept password change requests. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nestedgroupextraction 
        Queries the external LDAP server to determine whether the specified group belongs to another group. 
         
        Possible values = ON, OFF 
    .PARAMETER Maxnestinglevel 
        Number of levels up to which the system can query nested LDAP groups. 
    .PARAMETER Groupnameidentifier 
        LDAP-group attribute that uniquely identifies the group. No two groups on one LDAP server can have the same group name identifier. 
    .PARAMETER Groupsearchattribute 
        LDAP-group attribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
    .PARAMETER Groupsearchsubattribute 
        LDAP-group subattribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
    .PARAMETER Groupsearchfilter 
        Search-expression that can be specified for sending group-search requests to the LDAP server. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaaldapparams 
        An example how to update aaaldapparams config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaaldapparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaldapparams/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Serverip,

        [int]$Serverport,

        [double]$Authtimeout,

        [string]$Ldapbase,

        [string]$Ldapbinddn,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ldapbinddnpassword,

        [string]$Ldaploginname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Searchfilter,

        [string]$Groupattrname,

        [string]$Subattributename,

        [ValidateSet('PLAINTEXT', 'TLS', 'SSL')]
        [string]$Sectype,

        [ValidateSet('AD', 'NDS')]
        [string]$Svrtype,

        [string]$Ssonameattribute,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Passwdchange,

        [ValidateSet('ON', 'OFF')]
        [string]$Nestedgroupextraction,

        [double]$Maxnestinglevel,

        [string]$Groupnameidentifier,

        [string]$Groupsearchattribute,

        [string]$Groupsearchsubattribute,

        [string]$Groupsearchfilter,

        [string]$Defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaaldapparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('ldapbase') ) { $payload.Add('ldapbase', $ldapbase) }
            if ( $PSBoundParameters.ContainsKey('ldapbinddn') ) { $payload.Add('ldapbinddn', $ldapbinddn) }
            if ( $PSBoundParameters.ContainsKey('ldapbinddnpassword') ) { $payload.Add('ldapbinddnpassword', $ldapbinddnpassword) }
            if ( $PSBoundParameters.ContainsKey('ldaploginname') ) { $payload.Add('ldaploginname', $ldaploginname) }
            if ( $PSBoundParameters.ContainsKey('searchfilter') ) { $payload.Add('searchfilter', $searchfilter) }
            if ( $PSBoundParameters.ContainsKey('groupattrname') ) { $payload.Add('groupattrname', $groupattrname) }
            if ( $PSBoundParameters.ContainsKey('subattributename') ) { $payload.Add('subattributename', $subattributename) }
            if ( $PSBoundParameters.ContainsKey('sectype') ) { $payload.Add('sectype', $sectype) }
            if ( $PSBoundParameters.ContainsKey('svrtype') ) { $payload.Add('svrtype', $svrtype) }
            if ( $PSBoundParameters.ContainsKey('ssonameattribute') ) { $payload.Add('ssonameattribute', $ssonameattribute) }
            if ( $PSBoundParameters.ContainsKey('passwdchange') ) { $payload.Add('passwdchange', $passwdchange) }
            if ( $PSBoundParameters.ContainsKey('nestedgroupextraction') ) { $payload.Add('nestedgroupextraction', $nestedgroupextraction) }
            if ( $PSBoundParameters.ContainsKey('maxnestinglevel') ) { $payload.Add('maxnestinglevel', $maxnestinglevel) }
            if ( $PSBoundParameters.ContainsKey('groupnameidentifier') ) { $payload.Add('groupnameidentifier', $groupnameidentifier) }
            if ( $PSBoundParameters.ContainsKey('groupsearchattribute') ) { $payload.Add('groupsearchattribute', $groupsearchattribute) }
            if ( $PSBoundParameters.ContainsKey('groupsearchsubattribute') ) { $payload.Add('groupsearchsubattribute', $groupsearchsubattribute) }
            if ( $PSBoundParameters.ContainsKey('groupsearchfilter') ) { $payload.Add('groupsearchfilter', $groupsearchfilter) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaaldapparams", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaaldapparams -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaaldapparams: Finished"
    }
}

function Invoke-NSGetAaaldapparams {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for LDAP parameter resource.
    .PARAMETER GetAll 
        Retrieve all aaaldapparams object(s).
    .PARAMETER Count
        If specified, the count of the aaaldapparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaldapparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaaldapparams -GetAll 
        Get all aaaldapparams data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaldapparams -name <string>
        Get aaaldapparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaldapparams -Filter @{ 'name'='<value>' }
        Get aaaldapparams data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaaldapparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaldapparams/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaaldapparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaaldapparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaldapparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaldapparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaldapparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaldapparams configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaaldapparams: Ended"
    }
}

function Invoke-NSUpdateAaaotpparameter {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for AAA otpparameter resource.
    .PARAMETER Encryption 
        To encrypt otp secret in AD or not. Default value is OFF. 
         
        Possible values = ON, OFF 
    .PARAMETER Maxotpdevices 
        Maximum number of otp devices user can register. Default value is 4. Max value is 255. 
         
         
        Maximum value = 255
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaaotpparameter 
        An example how to update aaaotpparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaaotpparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaotpparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateSet('ON', 'OFF')]
        [string]$Encryption,

        [double]$Maxotpdevices 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaaotpparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('encryption') ) { $payload.Add('encryption', $encryption) }
            if ( $PSBoundParameters.ContainsKey('maxotpdevices') ) { $payload.Add('maxotpdevices', $maxotpdevices) }
            if ( $PSCmdlet.ShouldProcess("aaaotpparameter", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaaotpparameter -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaaotpparameter: Finished"
    }
}

function Invoke-NSUnsetAaaotpparameter {
    <#
    .SYNOPSIS
        Unset Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for AAA otpparameter resource.
    .PARAMETER Encryption 
        To encrypt otp secret in AD or not. Default value is OFF. 
         
        Possible values = ON, OFF 
    .PARAMETER Maxotpdevices 
        Maximum number of otp devices user can register. Default value is 4. Max value is 255. 
         
         
        Maximum value = 255
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAaaotpparameter 
        An example how to unset aaaotpparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAaaotpparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaotpparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$encryption,

        [Boolean]$maxotpdevices 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAaaotpparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('encryption') ) { $payload.Add('encryption', $encryption) }
            if ( $PSBoundParameters.ContainsKey('maxotpdevices') ) { $payload.Add('maxotpdevices', $maxotpdevices) }
            if ( $PSCmdlet.ShouldProcess("aaaotpparameter", "Unset Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type aaaotpparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUnsetAaaotpparameter: Finished"
    }
}

function Invoke-NSGetAaaotpparameter {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for AAA otpparameter resource.
    .PARAMETER GetAll 
        Retrieve all aaaotpparameter object(s).
    .PARAMETER Count
        If specified, the count of the aaaotpparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaotpparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaaotpparameter -GetAll 
        Get all aaaotpparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaotpparameter -name <string>
        Get aaaotpparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaotpparameter -Filter @{ 'name'='<value>' }
        Get aaaotpparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaaotpparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaotpparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaaotpparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaaotpparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaotpparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaotpparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaotpparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaotpparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaaotpparameter: Ended"
    }
}

function Invoke-NSUnsetAaaparameter {
    <#
    .SYNOPSIS
        Unset Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for AAA parameter resource.
    .PARAMETER Enablestaticpagecaching 
        The default state of VPN Static Page caching. Static Page caching is enabled by default. 
         
        Possible values = YES, NO 
    .PARAMETER Enableenhancedauthfeedback 
        Enhanced auth feedback provides more information to the end user about the reason for an authentication failure. The default value is set to NO. 
         
        Possible values = YES, NO 
    .PARAMETER Defaultauthtype 
        The default authentication server type. 
         
        Possible values = LOCAL, LDAP, RADIUS, TACACS, CERT 
    .PARAMETER Maxaaausers 
        Maximum number of concurrent users allowed to log on to VPN simultaneously. 
    .PARAMETER Aaadnatip 
        Source IP address to use for traffic that is sent to the authentication server. 
    .PARAMETER Maxloginattempts 
        Maximum Number of login Attempts. 
    .PARAMETER Enablesessionstickiness 
        Enables/Disables stickiness to authentication servers. 
         
        Possible values = YES, NO 
    .PARAMETER Maxsamldeflatesize 
        This will set the maximum deflate size in case of SAML Redirect binding. 
    .PARAMETER Persistentloginattempts 
        Persistent storage of unsuccessful user login attempts. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pwdexpirynotificationdays 
        This will set the threshold time in days for password expiry notification. Default value is 0, which means no notification is sent. 
    .PARAMETER Maxkbquestions 
        This will set maximum number of Questions to be asked for KB Validation. Default value is 2, Max Value is 6. 
         
        Maximum value = 6 
    .PARAMETER Aaasessionloglevel 
        Audit log level, which specifies the types of events to log for cli executed commands. 
        Available values function as follows: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
         
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Aaadloglevel 
        AAAD log level, which specifies the types of AAAD events to log in nsvpn.log. 
        Available values function as follows: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
         
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Dynaddr 
        Set by the DHCP client when the IP address was fetched dynamically. 
         
        Possible values = ON, OFF 
    .PARAMETER Ftmode 
        First time user mode determines which configuration options are shown by default when logging in to the GUI. This setting is controlled by the GUI. 
         
        Possible values = ON, HA, OFF 
    .PARAMETER Loginencryption 
        Parameter to encrypt login information for nFactor flow. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Samesite 
        SameSite attribute value for Cookies generated in AAATM context. This attribute value will be appended only for the cookies which are specified in the builtin patset ns_cookies_samesite. 
        Possible values = None, LAX, STRICT 
    .PARAMETER Apitokencache 
        Option to enable/disable API cache feature. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tokenintrospectioninterval 
        Frequency at which a token must be verified at the Authorization Server (AS) despite being found in cache. 
    .PARAMETER Defaultcspheader 
        Parameter to enable/disable default CSP header. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httponlycookie 
        Parameter to set/reset HttpOnly Flag for NSC_AAAC/NSC_TMAS cookies in nfactor. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAaaparameter 
        An example how to unset aaaparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAaaparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$enablestaticpagecaching,

        [Boolean]$enableenhancedauthfeedback,

        [Boolean]$defaultauthtype,

        [Boolean]$maxaaausers,

        [Boolean]$aaadnatip,

        [Boolean]$maxloginattempts,

        [Boolean]$enablesessionstickiness,

        [Boolean]$maxsamldeflatesize,

        [Boolean]$persistentloginattempts,

        [Boolean]$pwdexpirynotificationdays,

        [Boolean]$maxkbquestions,

        [Boolean]$aaasessionloglevel,

        [Boolean]$aaadloglevel,

        [Boolean]$dynaddr,

        [Boolean]$ftmode,

        [Boolean]$loginencryption,

        [Boolean]$samesite,

        [Boolean]$apitokencache,

        [Boolean]$tokenintrospectioninterval,

        [Boolean]$defaultcspheader,

        [Boolean]$httponlycookie 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAaaparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('enablestaticpagecaching') ) { $payload.Add('enablestaticpagecaching', $enablestaticpagecaching) }
            if ( $PSBoundParameters.ContainsKey('enableenhancedauthfeedback') ) { $payload.Add('enableenhancedauthfeedback', $enableenhancedauthfeedback) }
            if ( $PSBoundParameters.ContainsKey('defaultauthtype') ) { $payload.Add('defaultauthtype', $defaultauthtype) }
            if ( $PSBoundParameters.ContainsKey('maxaaausers') ) { $payload.Add('maxaaausers', $maxaaausers) }
            if ( $PSBoundParameters.ContainsKey('aaadnatip') ) { $payload.Add('aaadnatip', $aaadnatip) }
            if ( $PSBoundParameters.ContainsKey('maxloginattempts') ) { $payload.Add('maxloginattempts', $maxloginattempts) }
            if ( $PSBoundParameters.ContainsKey('enablesessionstickiness') ) { $payload.Add('enablesessionstickiness', $enablesessionstickiness) }
            if ( $PSBoundParameters.ContainsKey('maxsamldeflatesize') ) { $payload.Add('maxsamldeflatesize', $maxsamldeflatesize) }
            if ( $PSBoundParameters.ContainsKey('persistentloginattempts') ) { $payload.Add('persistentloginattempts', $persistentloginattempts) }
            if ( $PSBoundParameters.ContainsKey('pwdexpirynotificationdays') ) { $payload.Add('pwdexpirynotificationdays', $pwdexpirynotificationdays) }
            if ( $PSBoundParameters.ContainsKey('maxkbquestions') ) { $payload.Add('maxkbquestions', $maxkbquestions) }
            if ( $PSBoundParameters.ContainsKey('aaasessionloglevel') ) { $payload.Add('aaasessionloglevel', $aaasessionloglevel) }
            if ( $PSBoundParameters.ContainsKey('aaadloglevel') ) { $payload.Add('aaadloglevel', $aaadloglevel) }
            if ( $PSBoundParameters.ContainsKey('dynaddr') ) { $payload.Add('dynaddr', $dynaddr) }
            if ( $PSBoundParameters.ContainsKey('ftmode') ) { $payload.Add('ftmode', $ftmode) }
            if ( $PSBoundParameters.ContainsKey('loginencryption') ) { $payload.Add('loginencryption', $loginencryption) }
            if ( $PSBoundParameters.ContainsKey('samesite') ) { $payload.Add('samesite', $samesite) }
            if ( $PSBoundParameters.ContainsKey('apitokencache') ) { $payload.Add('apitokencache', $apitokencache) }
            if ( $PSBoundParameters.ContainsKey('tokenintrospectioninterval') ) { $payload.Add('tokenintrospectioninterval', $tokenintrospectioninterval) }
            if ( $PSBoundParameters.ContainsKey('defaultcspheader') ) { $payload.Add('defaultcspheader', $defaultcspheader) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSCmdlet.ShouldProcess("aaaparameter", "Unset Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type aaaparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUnsetAaaparameter: Finished"
    }
}

function Invoke-NSUpdateAaaparameter {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for AAA parameter resource.
    .PARAMETER Enablestaticpagecaching 
        The default state of VPN Static Page caching. Static Page caching is enabled by default. 
         
        Possible values = YES, NO 
    .PARAMETER Enableenhancedauthfeedback 
        Enhanced auth feedback provides more information to the end user about the reason for an authentication failure. The default value is set to NO. 
         
        Possible values = YES, NO 
    .PARAMETER Defaultauthtype 
        The default authentication server type. 
         
        Possible values = LOCAL, LDAP, RADIUS, TACACS, CERT 
    .PARAMETER Maxaaausers 
        Maximum number of concurrent users allowed to log on to VPN simultaneously. 
    .PARAMETER Maxloginattempts 
        Maximum Number of login Attempts. 
    .PARAMETER Failedlogintimeout 
        Number of minutes an account will be locked if user exceeds maximum permissible attempts. 
         
        Maximum value = 525600 
    .PARAMETER Aaadnatip 
        Source IP address to use for traffic that is sent to the authentication server. 
    .PARAMETER Enablesessionstickiness 
        Enables/Disables stickiness to authentication servers. 
         
        Possible values = YES, NO 
    .PARAMETER Aaasessionloglevel 
        Audit log level, which specifies the types of events to log for cli executed commands. 
        Available values function as follows: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
         
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Aaadloglevel 
        AAAD log level, which specifies the types of AAAD events to log in nsvpn.log. 
        Available values function as follows: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
         
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Dynaddr 
        Set by the DHCP client when the IP address was fetched dynamically. 
         
        Possible values = ON, OFF 
    .PARAMETER Ftmode 
        First time user mode determines which configuration options are shown by default when logging in to the GUI. This setting is controlled by the GUI. 
         
        Possible values = ON, HA, OFF 
    .PARAMETER Maxsamldeflatesize 
        This will set the maximum deflate size in case of SAML Redirect binding. 
    .PARAMETER Persistentloginattempts 
        Persistent storage of unsuccessful user login attempts. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pwdexpirynotificationdays 
        This will set the threshold time in days for password expiry notification. Default value is 0, which means no notification is sent. 
    .PARAMETER Maxkbquestions 
        This will set maximum number of Questions to be asked for KB Validation. Default value is 2, Max Value is 6. 
         
        Maximum value = 6 
    .PARAMETER Loginencryption 
        Parameter to encrypt login information for nFactor flow. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Samesite 
        SameSite attribute value for Cookies generated in AAATM context. This attribute value will be appended only for the cookies which are specified in the builtin patset ns_cookies_samesite. 
        Possible values = None, LAX, STRICT 
    .PARAMETER Apitokencache 
        Option to enable/disable API cache feature. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tokenintrospectioninterval 
        Frequency at which a token must be verified at the Authorization Server (AS) despite being found in cache. 
    .PARAMETER Defaultcspheader 
        Parameter to enable/disable default CSP header. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httponlycookie 
        Parameter to set/reset HttpOnly Flag for NSC_AAAC/NSC_TMAS cookies in nfactor. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaaparameter 
        An example how to update aaaparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaaparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateSet('YES', 'NO')]
        [string]$Enablestaticpagecaching,

        [ValidateSet('YES', 'NO')]
        [string]$Enableenhancedauthfeedback,

        [ValidateSet('LOCAL', 'LDAP', 'RADIUS', 'TACACS', 'CERT')]
        [string]$Defaultauthtype,

        [double]$Maxaaausers,

        [double]$Maxloginattempts,

        [double]$Failedlogintimeout,

        [string]$Aaadnatip,

        [ValidateSet('YES', 'NO')]
        [string]$Enablesessionstickiness,

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$Aaasessionloglevel,

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$Aaadloglevel,

        [ValidateSet('ON', 'OFF')]
        [string]$Dynaddr,

        [ValidateSet('ON', 'HA', 'OFF')]
        [string]$Ftmode,

        [double]$Maxsamldeflatesize,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Persistentloginattempts,

        [double]$Pwdexpirynotificationdays,

        [double]$Maxkbquestions,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Loginencryption,

        [ValidateSet('None', 'LAX', 'STRICT')]
        [string]$Samesite,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Apitokencache,

        [double]$Tokenintrospectioninterval,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Defaultcspheader,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httponlycookie 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaaparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('enablestaticpagecaching') ) { $payload.Add('enablestaticpagecaching', $enablestaticpagecaching) }
            if ( $PSBoundParameters.ContainsKey('enableenhancedauthfeedback') ) { $payload.Add('enableenhancedauthfeedback', $enableenhancedauthfeedback) }
            if ( $PSBoundParameters.ContainsKey('defaultauthtype') ) { $payload.Add('defaultauthtype', $defaultauthtype) }
            if ( $PSBoundParameters.ContainsKey('maxaaausers') ) { $payload.Add('maxaaausers', $maxaaausers) }
            if ( $PSBoundParameters.ContainsKey('maxloginattempts') ) { $payload.Add('maxloginattempts', $maxloginattempts) }
            if ( $PSBoundParameters.ContainsKey('failedlogintimeout') ) { $payload.Add('failedlogintimeout', $failedlogintimeout) }
            if ( $PSBoundParameters.ContainsKey('aaadnatip') ) { $payload.Add('aaadnatip', $aaadnatip) }
            if ( $PSBoundParameters.ContainsKey('enablesessionstickiness') ) { $payload.Add('enablesessionstickiness', $enablesessionstickiness) }
            if ( $PSBoundParameters.ContainsKey('aaasessionloglevel') ) { $payload.Add('aaasessionloglevel', $aaasessionloglevel) }
            if ( $PSBoundParameters.ContainsKey('aaadloglevel') ) { $payload.Add('aaadloglevel', $aaadloglevel) }
            if ( $PSBoundParameters.ContainsKey('dynaddr') ) { $payload.Add('dynaddr', $dynaddr) }
            if ( $PSBoundParameters.ContainsKey('ftmode') ) { $payload.Add('ftmode', $ftmode) }
            if ( $PSBoundParameters.ContainsKey('maxsamldeflatesize') ) { $payload.Add('maxsamldeflatesize', $maxsamldeflatesize) }
            if ( $PSBoundParameters.ContainsKey('persistentloginattempts') ) { $payload.Add('persistentloginattempts', $persistentloginattempts) }
            if ( $PSBoundParameters.ContainsKey('pwdexpirynotificationdays') ) { $payload.Add('pwdexpirynotificationdays', $pwdexpirynotificationdays) }
            if ( $PSBoundParameters.ContainsKey('maxkbquestions') ) { $payload.Add('maxkbquestions', $maxkbquestions) }
            if ( $PSBoundParameters.ContainsKey('loginencryption') ) { $payload.Add('loginencryption', $loginencryption) }
            if ( $PSBoundParameters.ContainsKey('samesite') ) { $payload.Add('samesite', $samesite) }
            if ( $PSBoundParameters.ContainsKey('apitokencache') ) { $payload.Add('apitokencache', $apitokencache) }
            if ( $PSBoundParameters.ContainsKey('tokenintrospectioninterval') ) { $payload.Add('tokenintrospectioninterval', $tokenintrospectioninterval) }
            if ( $PSBoundParameters.ContainsKey('defaultcspheader') ) { $payload.Add('defaultcspheader', $defaultcspheader) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSCmdlet.ShouldProcess("aaaparameter", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaaparameter -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaaparameter: Finished"
    }
}

function Invoke-NSGetAaaparameter {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for AAA parameter resource.
    .PARAMETER GetAll 
        Retrieve all aaaparameter object(s).
    .PARAMETER Count
        If specified, the count of the aaaparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaaparameter -GetAll 
        Get all aaaparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaparameter -name <string>
        Get aaaparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaparameter -Filter @{ 'name'='<value>' }
        Get aaaparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaaparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaaparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaaparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaaparameter: Ended"
    }
}

function Invoke-NSUnsetAaapreauthenticationaction {
    <#
    .SYNOPSIS
        Unset Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for pre authentication action resource.
    .PARAMETER Name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER Killprocess 
        String specifying the name of a process to be terminated by the endpoint analysis (EPA) tool. 
    .PARAMETER Deletefiles 
        String specifying the path(s) and name(s) of the files to be deleted by the endpoint analysis (EPA) tool. 
    .PARAMETER Defaultepagroup 
        This is the default group that is chosen when the EPA check succeeds.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAaapreauthenticationaction -name <string>
        An example how to unset aaapreauthenticationaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAaapreauthenticationaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationaction
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [Boolean]$killprocess,

        [Boolean]$deletefiles,

        [Boolean]$defaultepagroup 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('killprocess') ) { $payload.Add('killprocess', $killprocess) }
            if ( $PSBoundParameters.ContainsKey('deletefiles') ) { $payload.Add('deletefiles', $deletefiles) }
            if ( $PSBoundParameters.ContainsKey('defaultepagroup') ) { $payload.Add('defaultepagroup', $defaultepagroup) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUnsetAaapreauthenticationaction: Finished"
    }
}

function Invoke-NSDeleteAaapreauthenticationaction {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for pre authentication action resource.
    .PARAMETER Name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaapreauthenticationaction -Name <string>
        An example how to delete aaapreauthenticationaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaapreauthenticationaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaapreauthenticationaction: Finished"
    }
}

function Invoke-NSUpdateAaapreauthenticationaction {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for pre authentication action resource.
    .PARAMETER Name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER Preauthenticationaction 
        Allow or deny logon after endpoint analysis (EPA) results. 
        Possible values = ALLOW, DENY 
    .PARAMETER Killprocess 
        String specifying the name of a process to be terminated by the endpoint analysis (EPA) tool. 
    .PARAMETER Deletefiles 
        String specifying the path(s) and name(s) of the files to be deleted by the endpoint analysis (EPA) tool. 
    .PARAMETER Defaultepagroup 
        This is the default group that is chosen when the EPA check succeeds. 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaapreauthenticationaction -name <string>
        An example how to update aaapreauthenticationaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaapreauthenticationaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Preauthenticationaction,

        [string]$Killprocess,

        [string]$Deletefiles,

        [string]$Defaultepagroup,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('preauthenticationaction') ) { $payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ( $PSBoundParameters.ContainsKey('killprocess') ) { $payload.Add('killprocess', $killprocess) }
            if ( $PSBoundParameters.ContainsKey('deletefiles') ) { $payload.Add('deletefiles', $deletefiles) }
            if ( $PSBoundParameters.ContainsKey('defaultepagroup') ) { $payload.Add('defaultepagroup', $defaultepagroup) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationaction", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaapreauthenticationaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaapreauthenticationaction -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaapreauthenticationaction: Finished"
    }
}

function Invoke-NSAddAaapreauthenticationaction {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for pre authentication action resource.
    .PARAMETER Name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER Preauthenticationaction 
        Allow or deny logon after endpoint analysis (EPA) results. 
        Possible values = ALLOW, DENY 
    .PARAMETER Killprocess 
        String specifying the name of a process to be terminated by the endpoint analysis (EPA) tool. 
    .PARAMETER Deletefiles 
        String specifying the path(s) and name(s) of the files to be deleted by the endpoint analysis (EPA) tool. 
    .PARAMETER Defaultepagroup 
        This is the default group that is chosen when the EPA check succeeds. 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaapreauthenticationaction -name <string>
        An example how to add aaapreauthenticationaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaapreauthenticationaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Preauthenticationaction,

        [string]$Killprocess,

        [string]$Deletefiles,

        [string]$Defaultepagroup,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('preauthenticationaction') ) { $payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ( $PSBoundParameters.ContainsKey('killprocess') ) { $payload.Add('killprocess', $killprocess) }
            if ( $PSBoundParameters.ContainsKey('deletefiles') ) { $payload.Add('deletefiles', $deletefiles) }
            if ( $PSBoundParameters.ContainsKey('defaultepagroup') ) { $payload.Add('defaultepagroup', $defaultepagroup) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationaction", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type aaapreauthenticationaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaapreauthenticationaction -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaapreauthenticationaction: Finished"
    }
}

function Invoke-NSGetAaapreauthenticationaction {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for pre authentication action resource.
    .PARAMETER Name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationaction object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaapreauthenticationaction -GetAll 
        Get all aaapreauthenticationaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaapreauthenticationaction -Count 
        Get the number of aaapreauthenticationaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationaction -name <string>
        Get aaapreauthenticationaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationaction -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaapreauthenticationaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetAaapreauthenticationaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaapreauthenticationaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaapreauthenticationaction: Ended"
    }
}

function Invoke-NSUnsetAaapreauthenticationparameter {
    <#
    .SYNOPSIS
        Unset Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for pre authentication parameter resource.
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, to be evaluated by the EPA tool. 
    .PARAMETER Preauthenticationaction 
        Deny or allow login on the basis of end point analysis results. 
        Possible values = ALLOW, DENY 
    .PARAMETER Killprocess 
        String specifying the name of a process to be terminated by the EPA tool. 
    .PARAMETER Deletefiles 
        String specifying the path(s) to and name(s) of the files to be deleted by the EPA tool, as a string of between 1 and 1023 characters.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAaapreauthenticationparameter 
        An example how to unset aaapreauthenticationparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAaapreauthenticationparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$rule,

        [Boolean]$preauthenticationaction,

        [Boolean]$killprocess,

        [Boolean]$deletefiles 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAaapreauthenticationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('preauthenticationaction') ) { $payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ( $PSBoundParameters.ContainsKey('killprocess') ) { $payload.Add('killprocess', $killprocess) }
            if ( $PSBoundParameters.ContainsKey('deletefiles') ) { $payload.Add('deletefiles', $deletefiles) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationparameter", "Unset Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUnsetAaapreauthenticationparameter: Finished"
    }
}

function Invoke-NSUpdateAaapreauthenticationparameter {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for pre authentication parameter resource.
    .PARAMETER Preauthenticationaction 
        Deny or allow login on the basis of end point analysis results. 
        Possible values = ALLOW, DENY 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, to be evaluated by the EPA tool. 
    .PARAMETER Killprocess 
        String specifying the name of a process to be terminated by the EPA tool. 
    .PARAMETER Deletefiles 
        String specifying the path(s) to and name(s) of the files to be deleted by the EPA tool, as a string of between 1 and 1023 characters.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaapreauthenticationparameter 
        An example how to update aaapreauthenticationparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaapreauthenticationparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Preauthenticationaction,

        [string]$Rule,

        [string]$Killprocess,

        [string]$Deletefiles 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaapreauthenticationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('preauthenticationaction') ) { $payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('killprocess') ) { $payload.Add('killprocess', $killprocess) }
            if ( $PSBoundParameters.ContainsKey('deletefiles') ) { $payload.Add('deletefiles', $deletefiles) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationparameter", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaapreauthenticationparameter -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaapreauthenticationparameter: Finished"
    }
}

function Invoke-NSGetAaapreauthenticationparameter {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for pre authentication parameter resource.
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationparameter object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaapreauthenticationparameter -GetAll 
        Get all aaapreauthenticationparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationparameter -name <string>
        Get aaapreauthenticationparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationparameter -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaapreauthenticationparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaapreauthenticationparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaapreauthenticationparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaapreauthenticationparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaapreauthenticationparameter: Ended"
    }
}

function Invoke-NSDeleteAaapreauthenticationpolicy {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for pre authentication policy resource.
    .PARAMETER Name 
        Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaapreauthenticationpolicy -Name <string>
        An example how to delete aaapreauthenticationpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaapreauthenticationpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaapreauthenticationpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaapreauthenticationpolicy: Finished"
    }
}

function Invoke-NSUpdateAaapreauthenticationpolicy {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for pre authentication policy resource.
    .PARAMETER Name 
        Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, defining connections that match the policy. 
    .PARAMETER Reqaction 
        Name of the action that the policy is to invoke when a connection matches the policy. 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaapreauthenticationpolicy -name <string>
        An example how to update aaapreauthenticationpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaapreauthenticationpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Reqaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaapreauthenticationpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('reqaction') ) { $payload.Add('reqaction', $reqaction) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationpolicy", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaapreauthenticationpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaapreauthenticationpolicy -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaapreauthenticationpolicy: Finished"
    }
}

function Invoke-NSAddAaapreauthenticationpolicy {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for pre authentication policy resource.
    .PARAMETER Name 
        Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, defining connections that match the policy. 
    .PARAMETER Reqaction 
        Name of the action that the policy is to invoke when a connection matches the policy. 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaapreauthenticationpolicy -name <string> -rule <string>
        An example how to add aaapreauthenticationpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaapreauthenticationpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Reqaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaapreauthenticationpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
            }
            if ( $PSBoundParameters.ContainsKey('reqaction') ) { $payload.Add('reqaction', $reqaction) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationpolicy", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type aaapreauthenticationpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaapreauthenticationpolicy -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaapreauthenticationpolicy: Finished"
    }
}

function Invoke-NSGetAaapreauthenticationpolicy {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for pre authentication policy resource.
    .PARAMETER Name 
        Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created. 
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationpolicy object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaapreauthenticationpolicy -GetAll 
        Get all aaapreauthenticationpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaapreauthenticationpolicy -Count 
        Get the number of aaapreauthenticationpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicy -name <string>
        Get aaapreauthenticationpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicy -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaapreauthenticationpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetAaapreauthenticationpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaapreauthenticationpolicy: Ended"
    }
}

function Invoke-NSGetAaapreauthenticationpolicyAaaglobalBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the aaaglobal that can be bound to aaapreauthenticationpolicy.
    .PARAMETER Name 
        Name of the preauthentication policy whose properties you want to view. 
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationpolicy_aaaglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy_aaaglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyAaaglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyAaaglobalBinding -GetAll 
        Get all aaapreauthenticationpolicy_aaaglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyAaaglobalBinding -Count 
        Get the number of aaapreauthenticationpolicy_aaaglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyAaaglobalBinding -name <string>
        Get aaapreauthenticationpolicy_aaaglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyAaaglobalBinding -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationpolicy_aaaglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaapreauthenticationpolicyAaaglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationpolicy_aaaglobal_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaapreauthenticationpolicyAaaglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy_aaaglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy_aaaglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_aaaglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_aaaglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_aaaglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaapreauthenticationpolicyAaaglobalBinding: Ended"
    }
}

function Invoke-NSGetAaapreauthenticationpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to aaapreauthenticationpolicy.
    .PARAMETER Name 
        Name of the preauthentication policy whose properties you want to view. 
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyBinding -GetAll 
        Get all aaapreauthenticationpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyBinding -name <string>
        Get aaapreauthenticationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaapreauthenticationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaapreauthenticationpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaapreauthenticationpolicyBinding: Ended"
    }
}

function Invoke-NSGetAaapreauthenticationpolicyVpnvserverBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to aaapreauthenticationpolicy.
    .PARAMETER Name 
        Name of the preauthentication policy whose properties you want to view. 
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationpolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyVpnvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyVpnvserverBinding -GetAll 
        Get all aaapreauthenticationpolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyVpnvserverBinding -Count 
        Get the number of aaapreauthenticationpolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyVpnvserverBinding -name <string>
        Get aaapreauthenticationpolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaapreauthenticationpolicyVpnvserverBinding -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationpolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaapreauthenticationpolicyVpnvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaapreauthenticationpolicy_vpnvserver_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaapreauthenticationpolicyVpnvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaapreauthenticationpolicyVpnvserverBinding: Ended"
    }
}

function Invoke-NSUnsetAaaradiusparams {
    <#
    .SYNOPSIS
        Unset Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for RADIUS parameter resource.
    .PARAMETER Serverip 
        IP address of your RADIUS server. 
    .PARAMETER Serverport 
        Port number on which the RADIUS server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the RADIUS server. 
    .PARAMETER Radnasip 
        Send the Citrix ADC IP (NSIP) address to the RADIUS server as the Network Access Server IP (NASIP) part of the Radius protocol. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Radnasid 
        Send the Network Access Server ID (NASID) for your Citrix ADC to the RADIUS server as the nasid part of the Radius protocol. 
    .PARAMETER Radvendorid 
        Vendor ID for RADIUS group extraction. 
    .PARAMETER Radattributetype 
        Attribute type for RADIUS group extraction. 
    .PARAMETER Radgroupsprefix 
        Prefix string that precedes group names within a RADIUS attribute for RADIUS group extraction. 
    .PARAMETER Radgroupseparator 
        Group separator string that delimits group names within a RADIUS attribute for RADIUS group extraction. 
    .PARAMETER Passencoding 
        Enable password encoding in RADIUS packets that the Citrix ADC sends to the RADIUS server. 
         
        Possible values = pap, chap, mschapv1, mschapv2 
    .PARAMETER Ipvendorid 
        Vendor ID attribute in the RADIUS response. 
        If the attribute is not vendor-encoded, it is set to 0. 
    .PARAMETER Ipattributetype 
        IP attribute type in the RADIUS response. 
    .PARAMETER Accounting 
        Configure the RADIUS server state to accept or refuse accounting messages. 
        Possible values = ON, OFF 
    .PARAMETER Pwdvendorid 
        Vendor ID of the password in the RADIUS response. Used to extract the user password. 
    .PARAMETER Pwdattributetype 
        Attribute type of the Vendor ID in the RADIUS response. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups. 
    .PARAMETER Callingstationid 
        Send Calling-Station-ID of the client to the RADIUS server. IP Address of the client is sent as its Calling-Station-ID. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Authservretry 
        Number of retry by the Citrix ADC before getting response from the RADIUS server. 
         
         
        Maximum value = 10 
    .PARAMETER Authentication 
        Configure the RADIUS server state to accept or refuse authentication messages. 
         
        Possible values = ON, OFF 
    .PARAMETER Tunnelendpointclientip 
        Send Tunnel Endpoint Client IP address to the RADIUS server. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAaaradiusparams 
        An example how to unset aaaradiusparams config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAaaradiusparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaradiusparams
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$serverip,

        [Boolean]$serverport,

        [Boolean]$authtimeout,

        [Boolean]$radnasip,

        [Boolean]$radnasid,

        [Boolean]$radvendorid,

        [Boolean]$radattributetype,

        [Boolean]$radgroupsprefix,

        [Boolean]$radgroupseparator,

        [Boolean]$passencoding,

        [Boolean]$ipvendorid,

        [Boolean]$ipattributetype,

        [Boolean]$accounting,

        [Boolean]$pwdvendorid,

        [Boolean]$pwdattributetype,

        [Boolean]$defaultauthenticationgroup,

        [Boolean]$callingstationid,

        [Boolean]$authservretry,

        [Boolean]$authentication,

        [Boolean]$tunnelendpointclientip 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAaaradiusparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('radnasip') ) { $payload.Add('radnasip', $radnasip) }
            if ( $PSBoundParameters.ContainsKey('radnasid') ) { $payload.Add('radnasid', $radnasid) }
            if ( $PSBoundParameters.ContainsKey('radvendorid') ) { $payload.Add('radvendorid', $radvendorid) }
            if ( $PSBoundParameters.ContainsKey('radattributetype') ) { $payload.Add('radattributetype', $radattributetype) }
            if ( $PSBoundParameters.ContainsKey('radgroupsprefix') ) { $payload.Add('radgroupsprefix', $radgroupsprefix) }
            if ( $PSBoundParameters.ContainsKey('radgroupseparator') ) { $payload.Add('radgroupseparator', $radgroupseparator) }
            if ( $PSBoundParameters.ContainsKey('passencoding') ) { $payload.Add('passencoding', $passencoding) }
            if ( $PSBoundParameters.ContainsKey('ipvendorid') ) { $payload.Add('ipvendorid', $ipvendorid) }
            if ( $PSBoundParameters.ContainsKey('ipattributetype') ) { $payload.Add('ipattributetype', $ipattributetype) }
            if ( $PSBoundParameters.ContainsKey('accounting') ) { $payload.Add('accounting', $accounting) }
            if ( $PSBoundParameters.ContainsKey('pwdvendorid') ) { $payload.Add('pwdvendorid', $pwdvendorid) }
            if ( $PSBoundParameters.ContainsKey('pwdattributetype') ) { $payload.Add('pwdattributetype', $pwdattributetype) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSBoundParameters.ContainsKey('callingstationid') ) { $payload.Add('callingstationid', $callingstationid) }
            if ( $PSBoundParameters.ContainsKey('authservretry') ) { $payload.Add('authservretry', $authservretry) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('tunnelendpointclientip') ) { $payload.Add('tunnelendpointclientip', $tunnelendpointclientip) }
            if ( $PSCmdlet.ShouldProcess("aaaradiusparams", "Unset Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type aaaradiusparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUnsetAaaradiusparams: Finished"
    }
}

function Invoke-NSUpdateAaaradiusparams {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for RADIUS parameter resource.
    .PARAMETER Serverip 
        IP address of your RADIUS server. 
    .PARAMETER Serverport 
        Port number on which the RADIUS server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the RADIUS server. 
    .PARAMETER Radkey 
        The key shared between the RADIUS server and clients. 
        Required for allowing the Citrix ADC to communicate with the RADIUS server. 
    .PARAMETER Radnasip 
        Send the Citrix ADC IP (NSIP) address to the RADIUS server as the Network Access Server IP (NASIP) part of the Radius protocol. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Radnasid 
        Send the Network Access Server ID (NASID) for your Citrix ADC to the RADIUS server as the nasid part of the Radius protocol. 
    .PARAMETER Radvendorid 
        Vendor ID for RADIUS group extraction. 
    .PARAMETER Radattributetype 
        Attribute type for RADIUS group extraction. 
    .PARAMETER Radgroupsprefix 
        Prefix string that precedes group names within a RADIUS attribute for RADIUS group extraction. 
    .PARAMETER Radgroupseparator 
        Group separator string that delimits group names within a RADIUS attribute for RADIUS group extraction. 
    .PARAMETER Passencoding 
        Enable password encoding in RADIUS packets that the Citrix ADC sends to the RADIUS server. 
         
        Possible values = pap, chap, mschapv1, mschapv2 
    .PARAMETER Ipvendorid 
        Vendor ID attribute in the RADIUS response. 
        If the attribute is not vendor-encoded, it is set to 0. 
    .PARAMETER Ipattributetype 
        IP attribute type in the RADIUS response. 
    .PARAMETER Accounting 
        Configure the RADIUS server state to accept or refuse accounting messages. 
        Possible values = ON, OFF 
    .PARAMETER Pwdvendorid 
        Vendor ID of the password in the RADIUS response. Used to extract the user password. 
    .PARAMETER Pwdattributetype 
        Attribute type of the Vendor ID in the RADIUS response. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups. 
    .PARAMETER Callingstationid 
        Send Calling-Station-ID of the client to the RADIUS server. IP Address of the client is sent as its Calling-Station-ID. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Authservretry 
        Number of retry by the Citrix ADC before getting response from the RADIUS server. 
         
         
        Maximum value = 10 
    .PARAMETER Authentication 
        Configure the RADIUS server state to accept or refuse authentication messages. 
         
        Possible values = ON, OFF 
    .PARAMETER Tunnelendpointclientip 
        Send Tunnel Endpoint Client IP address to the RADIUS server. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaaradiusparams -radkey <string>
        An example how to update aaaradiusparams config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaaradiusparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaradiusparams/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Serverip,

        [int]$Serverport,

        [double]$Authtimeout,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radkey,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Radnasip,

        [string]$Radnasid,

        [double]$Radvendorid,

        [double]$Radattributetype,

        [string]$Radgroupsprefix,

        [string]$Radgroupseparator,

        [ValidateSet('pap', 'chap', 'mschapv1', 'mschapv2')]
        [string]$Passencoding,

        [double]$Ipvendorid,

        [double]$Ipattributetype,

        [ValidateSet('ON', 'OFF')]
        [string]$Accounting,

        [double]$Pwdvendorid,

        [double]$Pwdattributetype,

        [string]$Defaultauthenticationgroup,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Callingstationid,

        [double]$Authservretry,

        [ValidateSet('ON', 'OFF')]
        [string]$Authentication,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Tunnelendpointclientip 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaaradiusparams: Starting"
    }
    process {
        try {
            $payload = @{ radkey = $radkey }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('radnasip') ) { $payload.Add('radnasip', $radnasip) }
            if ( $PSBoundParameters.ContainsKey('radnasid') ) { $payload.Add('radnasid', $radnasid) }
            if ( $PSBoundParameters.ContainsKey('radvendorid') ) { $payload.Add('radvendorid', $radvendorid) }
            if ( $PSBoundParameters.ContainsKey('radattributetype') ) { $payload.Add('radattributetype', $radattributetype) }
            if ( $PSBoundParameters.ContainsKey('radgroupsprefix') ) { $payload.Add('radgroupsprefix', $radgroupsprefix) }
            if ( $PSBoundParameters.ContainsKey('radgroupseparator') ) { $payload.Add('radgroupseparator', $radgroupseparator) }
            if ( $PSBoundParameters.ContainsKey('passencoding') ) { $payload.Add('passencoding', $passencoding) }
            if ( $PSBoundParameters.ContainsKey('ipvendorid') ) { $payload.Add('ipvendorid', $ipvendorid) }
            if ( $PSBoundParameters.ContainsKey('ipattributetype') ) { $payload.Add('ipattributetype', $ipattributetype) }
            if ( $PSBoundParameters.ContainsKey('accounting') ) { $payload.Add('accounting', $accounting) }
            if ( $PSBoundParameters.ContainsKey('pwdvendorid') ) { $payload.Add('pwdvendorid', $pwdvendorid) }
            if ( $PSBoundParameters.ContainsKey('pwdattributetype') ) { $payload.Add('pwdattributetype', $pwdattributetype) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSBoundParameters.ContainsKey('callingstationid') ) { $payload.Add('callingstationid', $callingstationid) }
            if ( $PSBoundParameters.ContainsKey('authservretry') ) { $payload.Add('authservretry', $authservretry) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('tunnelendpointclientip') ) { $payload.Add('tunnelendpointclientip', $tunnelendpointclientip) }
            if ( $PSCmdlet.ShouldProcess("aaaradiusparams", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaaradiusparams -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaaradiusparams: Finished"
    }
}

function Invoke-NSGetAaaradiusparams {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for RADIUS parameter resource.
    .PARAMETER GetAll 
        Retrieve all aaaradiusparams object(s).
    .PARAMETER Count
        If specified, the count of the aaaradiusparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaradiusparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaaradiusparams -GetAll 
        Get all aaaradiusparams data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaradiusparams -name <string>
        Get aaaradiusparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaaradiusparams -Filter @{ 'name'='<value>' }
        Get aaaradiusparams data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaaradiusparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaaradiusparams/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaaradiusparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaaradiusparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaradiusparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaradiusparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaradiusparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaradiusparams configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaaradiusparams: Ended"
    }
}

function Invoke-NSKillAaasession {
    <#
    .SYNOPSIS
        Kill Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for active connection resource.
    .PARAMETER Username 
        Name of the AAA user. 
    .PARAMETER Groupname 
        Name of the AAA group. 
    .PARAMETER Iip 
        IP address or the first address in the intranet IP range. 
    .PARAMETER Netmask 
        Subnet mask for the intranet IP range. 
    .PARAMETER Sessionkey 
        Show aaa session associated with given session key. 
    .PARAMETER All 
        Terminate all active AAA-TM/VPN sessions.
    .EXAMPLE
        PS C:\>Invoke-NSKillAaasession 
        An example how to kill aaasession config Object(s).
    .NOTES
        File Name : Invoke-NSKillAaasession
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaasession/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Iip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Netmask,

        [ValidateLength(1, 127)]
        [string]$Sessionkey,

        [boolean]$All 

    )
    begin {
        Write-Verbose "Invoke-NSKillAaasession: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('groupname') ) { $payload.Add('groupname', $groupname) }
            if ( $PSBoundParameters.ContainsKey('iip') ) { $payload.Add('iip', $iip) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('sessionkey') ) { $payload.Add('sessionkey', $sessionkey) }
            if ( $PSBoundParameters.ContainsKey('all') ) { $payload.Add('all', $all) }
            if ( $PSCmdlet.ShouldProcess($Name, "Kill Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type aaasession -Action kill -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSKillAaasession: Finished"
    }
}

function Invoke-NSGetAaasession {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for active connection resource.
    .PARAMETER Username 
        Name of the AAA user. 
    .PARAMETER Groupname 
        Name of the AAA group. 
    .PARAMETER Iip 
        IP address or the first address in the intranet IP range. 
    .PARAMETER Netmask 
        Subnet mask for the intranet IP range. 
    .PARAMETER Sessionkey 
        Show aaa session associated with given session key. 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all aaasession object(s).
    .PARAMETER Count
        If specified, the count of the aaasession object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaasession
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaasession -GetAll 
        Get all aaasession data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaasession -Count 
        Get the number of aaasession objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaasession -name <string>
        Get aaasession object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaasession -Filter @{ 'name'='<value>' }
        Get aaasession data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaasession
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaasession/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Iip,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Netmask,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateLength(1, 127)]
        [string]$Sessionkey,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double]$Nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetAaasession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaasession objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaasession objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaasession objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('username') ) { $arguments.Add('username', $username) } 
                if ( $PSBoundParameters.ContainsKey('groupname') ) { $arguments.Add('groupname', $groupname) } 
                if ( $PSBoundParameters.ContainsKey('iip') ) { $arguments.Add('iip', $iip) } 
                if ( $PSBoundParameters.ContainsKey('netmask') ) { $arguments.Add('netmask', $netmask) } 
                if ( $PSBoundParameters.ContainsKey('sessionkey') ) { $arguments.Add('sessionkey', $sessionkey) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaasession configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaasession configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaasession: Ended"
    }
}

function Invoke-NSUpdateAaassoprofile {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for aaa sso profile resource.
    .PARAMETER Name 
        Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created. 
         
        The following requirement applies only to the NetScaler CLI: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER Password 
        Password with which the user logs on. Required for Single sign on to external server. 
    .PARAMETER PassThru 
        Return details about the created aaassoprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaassoprofile -name <string>
        An example how to update aaassoprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaassoprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaassoprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaassoprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess("aaassoprofile", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaassoprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaassoprofile -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaassoprofile: Finished"
    }
}

function Invoke-NSDeleteAaassoprofile {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for aaa sso profile resource.
    .PARAMETER Name 
        Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created. 
         
        The following requirement applies only to the NetScaler CLI: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action').
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaassoprofile -Name <string>
        An example how to delete aaassoprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaassoprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaassoprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaassoprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaassoprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaassoprofile: Finished"
    }
}

function Invoke-NSAddAaassoprofile {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for aaa sso profile resource.
    .PARAMETER Name 
        Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created. 
         
        The following requirement applies only to the NetScaler CLI: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER Password 
        Password with which the user logs on. Required for Single sign on to external server. 
    .PARAMETER PassThru 
        Return details about the created aaassoprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaassoprofile -name <string> -username <string> -password <string>
        An example how to add aaassoprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaassoprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaassoprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaassoprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                username       = $username
                password       = $password
            }

            if ( $PSCmdlet.ShouldProcess("aaassoprofile", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type aaassoprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaassoprofile -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaassoprofile: Finished"
    }
}

function Invoke-NSGetAaassoprofile {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for aaa sso profile resource.
    .PARAMETER Name 
        Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created. 
         
        The following requirement applies only to the NetScaler CLI: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER GetAll 
        Retrieve all aaassoprofile object(s).
    .PARAMETER Count
        If specified, the count of the aaassoprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaassoprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaassoprofile -GetAll 
        Get all aaassoprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaassoprofile -Count 
        Get the number of aaassoprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaassoprofile -name <string>
        Get aaassoprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaassoprofile -Filter @{ 'name'='<value>' }
        Get aaassoprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaassoprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaassoprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetAaassoprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaassoprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaassoprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaassoprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaassoprofile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaassoprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaassoprofile: Ended"
    }
}

function Invoke-NSUnsetAaatacacsparams {
    <#
    .SYNOPSIS
        Unset Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for tacacs parameters resource.
    .PARAMETER Serverip 
        IP address of your TACACS+ server. 
    .PARAMETER Serverport 
        Port number on which the TACACS+ server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the TACACS+ server. 
    .PARAMETER Tacacssecret 
        Key shared between the TACACS+ server and clients. Required for allowing the Citrix ADC to communicate with the TACACS+ server. 
    .PARAMETER Authorization 
        Use streaming authorization on the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Accounting 
        Send accounting messages to the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Auditfailedcmds 
        The option for sending accounting messages to the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Groupattrname 
        TACACS+ group attribute name.Used for group extraction on the TACACS+ server. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAaatacacsparams 
        An example how to unset aaatacacsparams config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAaatacacsparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaatacacsparams
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$serverip,

        [Boolean]$serverport,

        [Boolean]$authtimeout,

        [Boolean]$tacacssecret,

        [Boolean]$authorization,

        [Boolean]$accounting,

        [Boolean]$auditfailedcmds,

        [Boolean]$groupattrname,

        [Boolean]$defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAaatacacsparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('tacacssecret') ) { $payload.Add('tacacssecret', $tacacssecret) }
            if ( $PSBoundParameters.ContainsKey('authorization') ) { $payload.Add('authorization', $authorization) }
            if ( $PSBoundParameters.ContainsKey('accounting') ) { $payload.Add('accounting', $accounting) }
            if ( $PSBoundParameters.ContainsKey('auditfailedcmds') ) { $payload.Add('auditfailedcmds', $auditfailedcmds) }
            if ( $PSBoundParameters.ContainsKey('groupattrname') ) { $payload.Add('groupattrname', $groupattrname) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaatacacsparams", "Unset Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type aaatacacsparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUnsetAaatacacsparams: Finished"
    }
}

function Invoke-NSUpdateAaatacacsparams {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for tacacs parameters resource.
    .PARAMETER Serverip 
        IP address of your TACACS+ server. 
    .PARAMETER Serverport 
        Port number on which the TACACS+ server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the TACACS+ server. 
    .PARAMETER Tacacssecret 
        Key shared between the TACACS+ server and clients. Required for allowing the Citrix ADC to communicate with the TACACS+ server. 
    .PARAMETER Authorization 
        Use streaming authorization on the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Accounting 
        Send accounting messages to the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Auditfailedcmds 
        The option for sending accounting messages to the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Groupattrname 
        TACACS+ group attribute name.Used for group extraction on the TACACS+ server. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaatacacsparams 
        An example how to update aaatacacsparams config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaatacacsparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaatacacsparams/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Serverip,

        [int]$Serverport,

        [double]$Authtimeout,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Tacacssecret,

        [ValidateSet('ON', 'OFF')]
        [string]$Authorization,

        [ValidateSet('ON', 'OFF')]
        [string]$Accounting,

        [ValidateSet('ON', 'OFF')]
        [string]$Auditfailedcmds,

        [string]$Groupattrname,

        [string]$Defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaatacacsparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('tacacssecret') ) { $payload.Add('tacacssecret', $tacacssecret) }
            if ( $PSBoundParameters.ContainsKey('authorization') ) { $payload.Add('authorization', $authorization) }
            if ( $PSBoundParameters.ContainsKey('accounting') ) { $payload.Add('accounting', $accounting) }
            if ( $PSBoundParameters.ContainsKey('auditfailedcmds') ) { $payload.Add('auditfailedcmds', $auditfailedcmds) }
            if ( $PSBoundParameters.ContainsKey('groupattrname') ) { $payload.Add('groupattrname', $groupattrname) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaatacacsparams", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaatacacsparams -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaatacacsparams: Finished"
    }
}

function Invoke-NSGetAaatacacsparams {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for tacacs parameters resource.
    .PARAMETER GetAll 
        Retrieve all aaatacacsparams object(s).
    .PARAMETER Count
        If specified, the count of the aaatacacsparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaatacacsparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaatacacsparams -GetAll 
        Get all aaatacacsparams data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaatacacsparams -name <string>
        Get aaatacacsparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaatacacsparams -Filter @{ 'name'='<value>' }
        Get aaatacacsparams data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaatacacsparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaatacacsparams/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaatacacsparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaatacacsparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaatacacsparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaatacacsparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaatacacsparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaatacacsparams configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaatacacsparams: Ended"
    }
}

function Invoke-NSUnlockAaauser {
    <#
    .SYNOPSIS
        Unlock Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for AAA user resource.
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added.
    .EXAMPLE
        PS C:\>Invoke-NSUnlockAaauser -username <string>
        An example how to unlock aaauser config Object(s).
    .NOTES
        File Name : Invoke-NSUnlockAaauser
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username 

    )
    begin {
        Write-Verbose "Invoke-NSUnlockAaauser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }

            if ( $PSCmdlet.ShouldProcess($Name, "Unlock Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type aaauser -Action unlock -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUnlockAaauser: Finished"
    }
}

function Invoke-NSAddAaauser {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for AAA user resource.
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
    .PARAMETER Password 
        Password with which the user logs on. Required for any user account that does not exist on an external authentication server. 
        If you are not using an external authentication server, all user accounts must have a password. If you are using an external authentication server, you must provide a password for local user accounts that do not exist on the authentication server. 
    .PARAMETER PassThru 
        Return details about the created aaauser item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauser -username <string>
        An example how to add aaauser config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauser
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess("aaauser", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type aaauser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauser -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauser: Finished"
    }
}

function Invoke-NSDeleteAaauser {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for AAA user resource.
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauser -Username <string>
        An example how to delete aaauser config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauser
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauser: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauser: Finished"
    }
}

function Invoke-NSUpdateAaauser {
    <#
    .SYNOPSIS
        Update Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Configuration for AAA user resource.
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
    .PARAMETER Password 
        Password with which the user logs on. Required for any user account that does not exist on an external authentication server. 
        If you are not using an external authentication server, all user accounts must have a password. If you are using an external authentication server, you must provide a password for local user accounts that do not exist on the authentication server. 
    .PARAMETER PassThru 
        Return details about the created aaauser item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAaauser -username <string> -password <string>
        An example how to update aaauser config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAaauser
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAaauser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username
                password           = $password
            }

            if ( $PSCmdlet.ShouldProcess("aaauser", "Update Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauser -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSUpdateAaauser: Finished"
    }
}

function Invoke-NSGetAaauser {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Configuration for AAA user resource.
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
    .PARAMETER GetAll 
        Retrieve all aaauser object(s).
    .PARAMETER Count
        If specified, the count of the aaauser object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauser
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauser -GetAll 
        Get all aaauser data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauser -Count 
        Get the number of aaauser objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauser -name <string>
        Get aaauser object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauser -Filter @{ 'name'='<value>' }
        Get aaauser data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauser
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetAaauser: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaauser objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauser: Ended"
    }
}

function Invoke-NSGetAaauserAaagroupBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the aaagroup that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAaagroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserAaagroupBinding -GetAll 
        Get all aaauser_aaagroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserAaagroupBinding -Count 
        Get the number of aaauser_aaagroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAaagroupBinding -name <string>
        Get aaauser_aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAaagroupBinding -Filter @{ 'name'='<value>' }
        Get aaauser_aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserAaagroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_aaagroup_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserAaagroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_aaagroup_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_aaagroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserAaagroupBinding: Ended"
    }
}

function Invoke-NSAddAaauserAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserAuditnslogpolicyBinding -username <string>
        An example how to add aaauser_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_auditnslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_auditnslogpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserAuditnslogpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaauserAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserAuditnslogpolicyBinding -Username <string>
        An example how to delete aaauser_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_auditnslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaauserAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAuditnslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserAuditnslogpolicyBinding -GetAll 
        Get all aaauser_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserAuditnslogpolicyBinding -Count 
        Get the number of aaauser_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAuditnslogpolicyBinding -name <string>
        Get aaauser_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAuditnslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaauser_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_auditnslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserAuditnslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_auditnslogpolicy_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_auditnslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserAuditnslogpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaauserAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserAuditsyslogpolicyBinding -username <string>
        An example how to add aaauser_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_auditsyslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_auditsyslogpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserAuditsyslogpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaauserAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserAuditsyslogpolicyBinding -Username <string>
        An example how to delete aaauser_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_auditsyslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaauserAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAuditsyslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserAuditsyslogpolicyBinding -GetAll 
        Get all aaauser_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserAuditsyslogpolicyBinding -Count 
        Get the number of aaauser_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAuditsyslogpolicyBinding -name <string>
        Get aaauser_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAuditsyslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaauser_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_auditsyslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserAuditsyslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_auditsyslogpolicy_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserAuditsyslogpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaauserAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaauser_authorizationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserAuthorizationpolicyBinding -username <string>
        An example how to add aaauser_authorizationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserAuthorizationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_authorizationpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserAuthorizationpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_authorizationpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_authorizationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserAuthorizationpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserAuthorizationpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaauserAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserAuthorizationpolicyBinding -Username <string>
        An example how to delete aaauser_authorizationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserAuthorizationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_authorizationpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserAuthorizationpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserAuthorizationpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaauserAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_authorizationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_authorizationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAuthorizationpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserAuthorizationpolicyBinding -GetAll 
        Get all aaauser_authorizationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserAuthorizationpolicyBinding -Count 
        Get the number of aaauser_authorizationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAuthorizationpolicyBinding -name <string>
        Get aaauser_authorizationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserAuthorizationpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaauser_authorizationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserAuthorizationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_authorizationpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserAuthorizationpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_authorizationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_authorizationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_authorizationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_authorizationpolicy_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_authorizationpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserAuthorizationpolicyBinding: Ended"
    }
}

function Invoke-NSGetAaauserBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to aaauser.
    .PARAMETER Username 
        Name of the user who has the account. 
    .PARAMETER GetAll 
        Retrieve all aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserBinding -GetAll 
        Get all aaauser_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserBinding -name <string>
        Get aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserBinding -Filter @{ 'name'='<value>' }
        Get aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserBinding: Ended"
    }
}

function Invoke-NSAddAaauserIntranetip6Binding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Intranetip6 
        The Intranet IP6 bound to the user. 
    .PARAMETER Numaddr 
        Numbers of ipv6 address bound starting with intranetip6. 
    .PARAMETER PassThru 
        Return details about the created aaauser_intranetip6_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserIntranetip6Binding -username <string>
        An example how to add aaauser_intranetip6_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserIntranetip6Binding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_intranetip6_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Gotopriorityexpression,

        [string]$Intranetip6,

        [double]$Numaddr,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserIntranetip6Binding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('intranetip6') ) { $payload.Add('intranetip6', $intranetip6) }
            if ( $PSBoundParameters.ContainsKey('numaddr') ) { $payload.Add('numaddr', $numaddr) }
            if ( $PSCmdlet.ShouldProcess("aaauser_intranetip6_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_intranetip6_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserIntranetip6Binding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserIntranetip6Binding: Finished"
    }
}

function Invoke-NSDeleteAaauserIntranetip6Binding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Intranetip6 
        The Intranet IP6 bound to the user. 
    .PARAMETER Numaddr 
        Numbers of ipv6 address bound starting with intranetip6.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserIntranetip6Binding -Username <string>
        An example how to delete aaauser_intranetip6_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserIntranetip6Binding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_intranetip6_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Intranetip6,

        [double]$Numaddr 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserIntranetip6Binding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetip6') ) { $arguments.Add('intranetip6', $Intranetip6) }
            if ( $PSBoundParameters.ContainsKey('Numaddr') ) { $arguments.Add('numaddr', $Numaddr) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserIntranetip6Binding: Finished"
    }
}

function Invoke-NSGetAaauserIntranetip6Binding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_intranetip6_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_intranetip6_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserIntranetip6Binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserIntranetip6Binding -GetAll 
        Get all aaauser_intranetip6_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserIntranetip6Binding -Count 
        Get the number of aaauser_intranetip6_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserIntranetip6Binding -name <string>
        Get aaauser_intranetip6_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserIntranetip6Binding -Filter @{ 'name'='<value>' }
        Get aaauser_intranetip6_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserIntranetip6Binding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_intranetip6_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserIntranetip6Binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_intranetip6_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_intranetip6_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_intranetip6_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_intranetip6_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_intranetip6_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserIntranetip6Binding: Ended"
    }
}

function Invoke-NSAddAaauserIntranetipBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Intranetip 
        The Intranet IP bound to the user. 
    .PARAMETER Netmask 
        The netmask for the Intranet IP. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_intranetip_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserIntranetipBinding -username <string>
        An example how to add aaauser_intranetip_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserIntranetipBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_intranetip_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Intranetip,

        [string]$Netmask,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserIntranetipBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('intranetip') ) { $payload.Add('intranetip', $intranetip) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_intranetip_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_intranetip_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserIntranetipBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserIntranetipBinding: Finished"
    }
}

function Invoke-NSDeleteAaauserIntranetipBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Intranetip 
        The Intranet IP bound to the user. 
    .PARAMETER Netmask 
        The netmask for the Intranet IP.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserIntranetipBinding -Username <string>
        An example how to delete aaauser_intranetip_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserIntranetipBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_intranetip_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Intranetip,

        [string]$Netmask 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserIntranetipBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetip') ) { $arguments.Add('intranetip', $Intranetip) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserIntranetipBinding: Finished"
    }
}

function Invoke-NSGetAaauserIntranetipBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_intranetip_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_intranetip_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserIntranetipBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserIntranetipBinding -GetAll 
        Get all aaauser_intranetip_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserIntranetipBinding -Count 
        Get the number of aaauser_intranetip_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserIntranetipBinding -name <string>
        Get aaauser_intranetip_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserIntranetipBinding -Filter @{ 'name'='<value>' }
        Get aaauser_intranetip_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserIntranetipBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_intranetip_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserIntranetipBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_intranetip_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_intranetip_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_intranetip_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_intranetip_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_intranetip_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserIntranetipBinding: Ended"
    }
}

function Invoke-NSAddAaauserTmsessionpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaauser_tmsessionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserTmsessionpolicyBinding -username <string>
        An example how to add aaauser_tmsessionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserTmsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_tmsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserTmsessionpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_tmsessionpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_tmsessionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserTmsessionpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserTmsessionpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaauserTmsessionpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserTmsessionpolicyBinding -Username <string>
        An example how to delete aaauser_tmsessionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserTmsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_tmsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserTmsessionpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserTmsessionpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaauserTmsessionpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_tmsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_tmsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserTmsessionpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserTmsessionpolicyBinding -GetAll 
        Get all aaauser_tmsessionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserTmsessionpolicyBinding -Count 
        Get the number of aaauser_tmsessionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserTmsessionpolicyBinding -name <string>
        Get aaauser_tmsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserTmsessionpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaauser_tmsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserTmsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_tmsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserTmsessionpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_tmsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_tmsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_tmsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_tmsessionpolicy_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_tmsessionpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserTmsessionpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaauserVpnintranetapplicationBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Intranetapplication 
        Name of the intranet VPN application to which the policy applies. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnintranetapplication_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserVpnintranetapplicationBinding -username <string>
        An example how to add aaauser_vpnintranetapplication_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserVpnintranetapplicationBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnintranetapplication_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Intranetapplication,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserVpnintranetapplicationBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('intranetapplication') ) { $payload.Add('intranetapplication', $intranetapplication) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_vpnintranetapplication_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnintranetapplication_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserVpnintranetapplicationBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserVpnintranetapplicationBinding: Finished"
    }
}

function Invoke-NSDeleteAaauserVpnintranetapplicationBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Intranetapplication 
        Name of the intranet VPN application to which the policy applies.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserVpnintranetapplicationBinding -Username <string>
        An example how to delete aaauser_vpnintranetapplication_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserVpnintranetapplicationBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnintranetapplication_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Intranetapplication 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserVpnintranetapplicationBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetapplication') ) { $arguments.Add('intranetapplication', $Intranetapplication) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserVpnintranetapplicationBinding: Finished"
    }
}

function Invoke-NSGetAaauserVpnintranetapplicationBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_vpnintranetapplication_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_vpnintranetapplication_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnintranetapplicationBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserVpnintranetapplicationBinding -GetAll 
        Get all aaauser_vpnintranetapplication_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserVpnintranetapplicationBinding -Count 
        Get the number of aaauser_vpnintranetapplication_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnintranetapplicationBinding -name <string>
        Get aaauser_vpnintranetapplication_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnintranetapplicationBinding -Filter @{ 'name'='<value>' }
        Get aaauser_vpnintranetapplication_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserVpnintranetapplicationBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnintranetapplication_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserVpnintranetapplicationBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_vpnintranetapplication_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnintranetapplication_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnintranetapplication_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnintranetapplication_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnintranetapplication_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserVpnintranetapplicationBinding: Ended"
    }
}

function Invoke-NSAddAaauserVpnsessionpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnsessionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserVpnsessionpolicyBinding -username <string>
        An example how to add aaauser_vpnsessionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserVpnsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserVpnsessionpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_vpnsessionpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnsessionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserVpnsessionpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserVpnsessionpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaauserVpnsessionpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserVpnsessionpolicyBinding -Username <string>
        An example how to delete aaauser_vpnsessionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserVpnsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserVpnsessionpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserVpnsessionpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaauserVpnsessionpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_vpnsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_vpnsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnsessionpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserVpnsessionpolicyBinding -GetAll 
        Get all aaauser_vpnsessionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserVpnsessionpolicyBinding -Count 
        Get the number of aaauser_vpnsessionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnsessionpolicyBinding -name <string>
        Get aaauser_vpnsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnsessionpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaauser_vpnsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserVpnsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserVpnsessionpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_vpnsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnsessionpolicy_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnsessionpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserVpnsessionpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaauserVpntrafficpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpntrafficpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserVpntrafficpolicyBinding -username <string>
        An example how to add aaauser_vpntrafficpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserVpntrafficpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpntrafficpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserVpntrafficpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_vpntrafficpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpntrafficpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserVpntrafficpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserVpntrafficpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaauserVpntrafficpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserVpntrafficpolicyBinding -Username <string>
        An example how to delete aaauser_vpntrafficpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserVpntrafficpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpntrafficpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserVpntrafficpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserVpntrafficpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaauserVpntrafficpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_vpntrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_vpntrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpntrafficpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserVpntrafficpolicyBinding -GetAll 
        Get all aaauser_vpntrafficpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserVpntrafficpolicyBinding -Count 
        Get the number of aaauser_vpntrafficpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpntrafficpolicyBinding -name <string>
        Get aaauser_vpntrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpntrafficpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaauser_vpntrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserVpntrafficpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpntrafficpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserVpntrafficpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_vpntrafficpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpntrafficpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpntrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpntrafficpolicy_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpntrafficpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserVpntrafficpolicyBinding: Ended"
    }
}

function Invoke-NSAddAaauserVpnurlBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Urlname 
        The intranet url. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserVpnurlBinding -username <string>
        An example how to add aaauser_vpnurl_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserVpnurlBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnurl_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Urlname,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserVpnurlBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('urlname') ) { $payload.Add('urlname', $urlname) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_vpnurl_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserVpnurlBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserVpnurlBinding: Finished"
    }
}

function Invoke-NSDeleteAaauserVpnurlBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Urlname 
        The intranet url.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserVpnurlBinding -Username <string>
        An example how to delete aaauser_vpnurl_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserVpnurlBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnurl_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Urlname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserVpnurlBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Urlname') ) { $arguments.Add('urlname', $Urlname) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserVpnurlBinding: Finished"
    }
}

function Invoke-NSGetAaauserVpnurlBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_vpnurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_vpnurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnurlBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserVpnurlBinding -GetAll 
        Get all aaauser_vpnurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserVpnurlBinding -Count 
        Get the number of aaauser_vpnurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnurlBinding -name <string>
        Get aaauser_vpnurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnurlBinding -Filter @{ 'name'='<value>' }
        Get aaauser_vpnurl_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserVpnurlBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnurl_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserVpnurlBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_vpnurl_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnurl_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnurl_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnurl_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserVpnurlBinding: Ended"
    }
}

function Invoke-NSAddAaauserVpnurlpolicyBinding {
    <#
    .SYNOPSIS
        Add Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
         
        Maximum value = 2147483647 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnurlpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAaauserVpnurlpolicyBinding -username <string>
        An example how to add aaauser_vpnurlpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAaauserVpnurlpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnurlpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [string]$Policy,

        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAaauserVpnurlpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_vpnurlpolicy_binding", "Add Authentication, authorization, and accounting service configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnurlpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAaauserVpnurlpolicyBinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddAaauserVpnurlpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAaauserVpnurlpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authentication, authorization, and accounting service configuration. config Object.
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
         
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAaauserVpnurlpolicyBinding -Username <string>
        An example how to delete aaauser_vpnurlpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAaauserVpnurlpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnurlpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAaauserVpnurlpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete Authentication, authorization, and accounting service configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSDeleteAaauserVpnurlpolicyBinding: Finished"
    }
}

function Invoke-NSGetAaauserVpnurlpolicyBinding {
    <#
    .SYNOPSIS
        Get Authentication, authorization, and accounting service configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_vpnurlpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_vpnurlpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnurlpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserVpnurlpolicyBinding -GetAll 
        Get all aaauser_vpnurlpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAaauserVpnurlpolicyBinding -Count 
        Get the number of aaauser_vpnurlpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnurlpolicyBinding -name <string>
        Get aaauser_vpnurlpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAaauserVpnurlpolicyBinding -Filter @{ 'name'='<value>' }
        Get aaauser_vpnurlpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAaauserVpnurlpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/aaa/aaauser_vpnurlpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAaauserVpnurlpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_vpnurlpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnurlpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnurlpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnurlpolicy_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnurlpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAaauserVpnurlpolicyBinding: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCnOdMQG4Wqo9Ex
# 7rN3D1PzKSIwhYKlZmuu3vn0YnNSz6CCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
# i/247uUvWN5TMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAkdCMRswGQYDVQQI
# ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoT
# D1NlY3RpZ28gTGltaXRlZDEkMCIGA1UEAxMbU2VjdGlnbyBSU0EgQ29kZSBTaWdu
# aW5nIENBMB4XDTIxMDUwNTAwMDAwMFoXDTI0MDUwNDIzNTk1OVowWzELMAkGA1UE
# BhMCTkwxEjAQBgNVBAcMCVZlbGRob3ZlbjEbMBkGA1UECgwSSm9oYW5uZXMgQmls
# bGVrZW5zMRswGQYDVQQDDBJKb2hhbm5lcyBCaWxsZWtlbnMwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQCsfgRG81keOHalHfCUgxOa1Qy4VNOnGxB8SL8e
# rjP9SfcF13McP7F1HGka5Be495pTZ+duGbaQMNozwg/5Dg9IRJEeBabeSSJJCbZo
# SNpmUu7NNRRfidQxlPC81LxTVHxJ7In0MEfCVm7rWcri28MRCAuafqOfSE+hyb1Z
# /tKyCyQ5RUq3kjs/CF+VfMHsJn6ZT63YqewRkwHuc7UogTTZKjhPJ9prGLTer8UX
# UgvsGRbvhYZXIEuy+bmx/iJ1yRl1kX4nj6gUYzlhemOnlSDD66YOrkLDhXPMXLym
# AN7h0/W5Bo//R5itgvdGBkXkWCKRASnq/9PTcoxW6mwtgU8xAgMBAAGjggGQMIIB
# jDAfBgNVHSMEGDAWgBQO4TqoUzox1Yq+wbutZxoDha00DjAdBgNVHQ4EFgQUZWMy
# gC0i1u2NZ1msk2Mm5nJm5AswDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMwEQYJYIZIAYb4QgEBBAQDAgQQMEoGA1UdIARD
# MEEwNQYMKwYBBAGyMQECAQMCMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
# by5jb20vQ1BTMAgGBmeBDAEEATBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
# LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDb2RlU2lnbmluZ0NBLmNybDBzBggrBgEF
# BQcBAQRnMGUwPgYIKwYBBQUHMAKGMmh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2Vj
# dGlnb1JTQUNvZGVTaWduaW5nQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2Nz
# cC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEARjv9ieRocb1DXRWm3XtY
# jjuSRjlvkoPd9wS6DNfsGlSU42BFd9LCKSyRREZVu8FDq7dN0PhD4bBTT+k6AgrY
# KG6f/8yUponOdxskv850SjN2S2FeVuR20pqActMrpd1+GCylG8mj8RGjdrLQ3QuX
# qYKS68WJ39WWYdVB/8Ftajir5p6sAfwHErLhbJS6WwmYjGI/9SekossvU8mZjZwo
# Gbu+fjZhPc4PhjbEh0ABSsPMfGjQQsg5zLFjg/P+cS6hgYI7qctToo0TexGe32DY
# fFWHrHuBErW2qXEJvzSqM5OtLRD06a4lH5ZkhojhMOX9S8xDs/ArDKgX1j1Xm4Tu
# DjCCBYEwggRpoAMCAQICEDlyRDr5IrdR19NsEN0xNZUwDQYJKoZIhvcNAQEMBQAw
# ezELMAkGA1UEBhMCR0IxGzAZBgNVBAgMEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
# A1UEBwwHU2FsZm9yZDEaMBgGA1UECgwRQ29tb2RvIENBIExpbWl0ZWQxITAfBgNV
# BAMMGEFBQSBDZXJ0aWZpY2F0ZSBTZXJ2aWNlczAeFw0xOTAzMTIwMDAwMDBaFw0y
# ODEyMzEyMzU5NTlaMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNl
# eTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1Qg
# TmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1
# dGhvcml0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIASZRc2DsPb
# CLPQrFcNdu3NJ9NMrVCDYeKqIE0JLWQJ3M6Jn8w9qez2z8Hc8dOx1ns3KBErR9o5
# xrw6GbRfpr19naNjQrZ28qk7K5H44m/Q7BYgkAk+4uh0yRi0kdRiZNt/owbxiBhq
# kCI8vP4T8IcUe/bkH47U5FHGEWdGCFHLhhRUP7wz/n5snP8WnRi9UY41pqdmyHJn
# 2yFmsdSbeAPAUDrozPDcvJ5M/q8FljUfV1q3/875PbcstvZU3cjnEjpNrkyKt1ya
# tLcgPcp/IjSufjtoZgFE5wFORlObM2D3lL5TN5BzQ/Myw1Pv26r+dE5px2uMYJPe
# xMcM3+EyrsyTO1F4lWeL7j1W/gzQaQ8bD/MlJmszbfduR/pzQ+V+DqVmsSl8MoRj
# VYnEDcGTVDAZE6zTfTen6106bDVc20HXEtqpSQvf2ICKCZNijrVmzyWIzYS4sT+k
# OQ/ZAp7rEkyVfPNrBaleFoPMuGfi6BOdzFuC00yz7Vv/3uVzrCM7LQC/NVV0CUnY
# SVgaf5I25lGSDvMmfRxNF7zJ7EMm0L9BX0CpRET0medXh55QH1dUqD79dGMvsVBl
# CeZYQi5DGky08CVHWfoEHpPUJkZKUIGy3r54t/xnFeHJV4QeD2PW6WK61l9VLupc
# xigIBCU5uA4rqfJMlxwHPw1S9e3vL4IPAgMBAAGjgfIwge8wHwYDVR0jBBgwFoAU
# oBEKIz6W8Qfs4q8p74Klf9AwpLQwHQYDVR0OBBYEFFN5v1qqK0rPVIDh2JvAnfKy
# A2bLMA4GA1UdDwEB/wQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MBEGA1UdIAQKMAgw
# BgYEVR0gADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNv
# bS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2VzLmNybDA0BggrBgEFBQcBAQQoMCYwJAYI
# KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
# AAOCAQEAGIdR3HQhPZyK4Ce3M9AuzOzw5steEd4ib5t1jp5y/uTW/qofnJYt7wNK
# fq70jW9yPEM7wD/ruN9cqqnGrvL82O6je0P2hjZ8FODN9Pc//t64tIrwkZb+/UNk
# fv3M0gGhfX34GRnJQisTv1iLuqSiZgR2iJFODIkUzqJNyTKzuugUGrxx8VvwQQuY
# AAoiAxDlDLH5zZI3Ge078eQ6tvlFEyZ1r7uq7z97dzvSxAKRPRkA0xdcOds/exgN
# Rc2ThZYvXd9ZFk8/Ub3VRRg/7UqO6AZhdCMWtQ1QcydER38QXYkqa4UxFMToqWpM
# gLxqeM+4f452cpkMnf7XkQgWoaNflTCCBfUwggPdoAMCAQICEB2iSDBvmyYY0ILg
# ln0z02owDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpO
# ZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVT
# RVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmlj
# YXRpb24gQXV0aG9yaXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMwMTIzMTIzNTk1OVow
# fDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
# A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQD
# ExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0EwggEiMA0GCSqGSIb3DQEBAQUA
# A4IBDwAwggEKAoIBAQCGIo0yhXoYn0nwli9jCB4t3HyfFM/jJrYlZilAhlRGdDFi
# xRDtsocnppnLlTDAVvWkdcapDlBipVGREGrgS2Ku/fD4GKyn/+4uMyD6DBmJqGx7
# rQDDYaHcaWVtH24nlteXUYam9CflfGqLlR5bYNV+1xaSnAAvaPeX7Wpyvjg7Y96P
# v25MQV0SIAhZ6DnNj9LWzwa0VwW2TqE+V2sfmLzEYtYbC43HZhtKn52BxHJAteJf
# 7wtF/6POF6YtVbC3sLxUap28jVZTxvC6eVBJLPcDuf4vZTXyIuosB69G2flGHNyM
# fHEo8/6nxhTdVZFuihEN3wYklX0Pp6F8OtqGNWHTAgMBAAGjggFkMIIBYDAfBgNV
# HSMEGDAWgBRTeb9aqitKz1SA4dibwJ3ysgNmyzAdBgNVHQ4EFgQUDuE6qFM6MdWK
# vsG7rWcaA4WtNA4wDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAw
# HQYDVR0lBBYwFAYIKwYBBQUHAwMGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAE1jUO1HNEphpNveaiqMm/EA
# AB4dYns61zLC9rPgY7P7YQCImhttEAcET7646ol4IusPRuzzRl5ARokS9At3Wpwq
# QTr81vTr5/cVlTPDoYMot94v5JT3hTODLUpASL+awk9KsY8k9LOBN9O3ZLCmI2pZ
# aFJCX/8E6+F0ZXkI9amT3mtxQJmWunjxucjiwwgWsatjWsgVgG10Xkp1fqW4w2y1
# z99KeYdcx0BNYzX2MNPPtQoOCwR/oEuuu6Ol0IQAkz5TXTSlADVpbL6fICUQDRn7
# UJBhvjmPeo5N9p8OHv4HURJmgyYZSJXOSsnBf/M6BZv5b9+If8AjntIeQ3pFMcGc
# TanwWbJZGehqjSkEAnd8S0vNcL46slVaeD68u28DECV3FTSK+TbMQ5Lkuk/xYpMo
# JVcp+1EZx6ElQGqEV8aynbG8HArafGd+fS7pKEwYfsR7MUFxmksp7As9V1DSyt39
# ngVR5UR43QHesXWYDVQk/fBO4+L4g71yuss9Ou7wXheSaG3IYfmm8SoKC6W59J7u
# mDIFhZ7r+YMp08Ysfb06dy6LN0KgaoLtO0qqlBCk4Q34F8W2WnkzGJLjtXX4oemO
# CiUe5B7xn1qHI/+fpFGe+zmAEc3btcSnqIBv5VPU4OOiwtJbGvoyJi1qV3AcPKRY
# LqPzW0sH3DJZ84enGm1YMIIG7DCCBNSgAwIBAgIQMA9vrN1mmHR8qUY2p3gtuTAN
# BgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJz
# ZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
# IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBB
# dXRob3JpdHkwHhcNMTkwNTAyMDAwMDAwWhcNMzgwMTE4MjM1OTU5WjB9MQswCQYD
# VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
# YWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3Rp
# Z28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
# ggIKAoICAQDIGwGv2Sx+iJl9AZg/IJC9nIAhVJO5z6A+U++zWsB21hoEpc5Hg7Xr
# xMxJNMvzRWW5+adkFiYJ+9UyUnkuyWPCE5u2hj8BBZJmbyGr1XEQeYf0RirNxFrJ
# 29ddSU1yVg/cyeNTmDoqHvzOWEnTv/M5u7mkI0Ks0BXDf56iXNc48RaycNOjxN+z
# xXKsLgp3/A2UUrf8H5VzJD0BKLwPDU+zkQGObp0ndVXRFzs0IXuXAZSvf4DP0REK
# V4TJf1bgvUacgr6Unb+0ILBgfrhN9Q0/29DqhYyKVnHRLZRMyIw80xSinL0m/9NT
# IMdgaZtYClT0Bef9Maz5yIUXx7gpGaQpL0bj3duRX58/Nj4OMGcrRrc1r5a+2kxg
# zKi7nw0U1BjEMJh0giHPYla1IXMSHv2qyghYh3ekFesZVf/QOVQtJu5FGjpvzdeE
# 8NfwKMVPZIMC1Pvi3vG8Aij0bdonigbSlofe6GsO8Ft96XZpkyAcSpcsdxkrk5WY
# nJee647BeFbGRCXfBhKaBi2fA179g6JTZ8qx+o2hZMmIklnLqEbAyfKm/31X2xJ2
# +opBJNQb/HKlFKLUrUMcpEmLQTkUAx4p+hulIq6lw02C0I3aa7fb9xhAV3PwcaP7
# Sn1FNsH3jYL6uckNU4B9+rY5WDLvbxhQiddPnTO9GrWdod6VQXqngwIDAQABo4IB
# WjCCAVYwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYE
# FBqh+GEZIA/DQXdFKI7RNV8GEgRVMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8E
# CDAGAQH/AgEAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAG1UgaUzXRbhtVOBkXXfA3oy
# Cy0lhBGysNsqfSoF9bw7J/RaoLlJWZApbGHLtVDb4n35nwDvQMOt0+LkVvlYQc/x
# QuUQff+wdB+PxlwJ+TNe6qAcJlhc87QRD9XVw+K81Vh4v0h24URnbY+wQxAPjeT5
# OGK/EwHFhaNMxcyyUzCVpNb0llYIuM1cfwGWvnJSajtCN3wWeDmTk5SbsdyybUFt
# Z83Jb5A9f0VywRsj1sJVhGbks8VmBvbz1kteraMrQoohkv6ob1olcGKBc2NeoLvY
# 3NdK0z2vgwY4Eh0khy3k/ALWPncEvAQ2ted3y5wujSMYuaPCRx3wXdahc1cFaJqn
# yTdlHb7qvNhCg0MFpYumCf/RoZSmTqo9CfUFbLfSZFrYKiLCS53xOV5M3kg9mzSW
# mglfjv33sVKRzj+J9hyhtal1H3G/W0NdZT1QgW6r8NDT/LKzH7aZlib0PHmLXGTM
# ze4nmuWgwAxyh8FuTVrTHurwROYybxzrF06Uw3hlIDsPQaof6aFBnf6xuKBlKjTg
# 3qj5PObBMLvAoGMs/FwWAKjQxH/qEZ0eBsambTJdtDgJK0kHqv3sMNrxpy/Pt/36
# 0KOE2See+wFmd7lWEOEgbsausfm2usg1XTN2jvF8IAwqd661ogKGuinutFoAsYyr
# 4/kKyVRd1LlqdJ69SK6YMIIG9TCCBN2gAwIBAgIQOUwl4XygbSeoZeI72R0i1DAN
# BgkqhkiG9w0BAQwFADB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBN
# YW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExp
# bWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EwHhcN
# MjMwNTAzMDAwMDAwWhcNMzQwODAyMjM1OTU5WjBqMQswCQYDVQQGEwJHQjETMBEG
# A1UECBMKTWFuY2hlc3RlcjEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSwwKgYD
# VQQDDCNTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIFNpZ25lciAjNDCCAiIwDQYJ
# KoZIhvcNAQEBBQADggIPADCCAgoCggIBAKSTKFJLzyeHdqQpHJk4wOcO1NEc7GjL
# AWTkis13sHFlgryf/Iu7u5WY+yURjlqICWYRFFiyuiJb5vYy8V0twHqiDuDgVmTt
# oeWBIHIgZEFsx8MI+vN9Xe8hmsJ+1yzDuhGYHvzTIAhCs1+/f4hYMqsws9iMepZK
# GRNcrPznq+kcFi6wsDiVSs+FUKtnAyWhuzjpD2+pWpqRKBM1uR/zPeEkyGuxmegN
# 77tN5T2MVAOR0Pwtz1UzOHoJHAfRIuBjhqe+/dKDcxIUm5pMCUa9NLzhS1B7cuBb
# /Rm7HzxqGXtuuy1EKr48TMysigSTxleGoHM2K4GX+hubfoiH2FJ5if5udzfXu1Cf
# +hglTxPyXnypsSBaKaujQod34PRMAkjdWKVTpqOg7RmWZRUpxe0zMCXmloOBmvZg
# ZpBYB4DNQnWs+7SR0MXdAUBqtqgQ7vaNereeda/TpUsYoQyfV7BeJUeRdM11EtGc
# b+ReDZvsdSbu/tP1ki9ShejaRFEqoswAyodmQ6MbAO+itZadYq0nC/IbSsnDlEI3
# iCCEqIeuw7ojcnv4VO/4ayewhfWnQ4XYKzl021p3AtGk+vXNnD3MH65R0Hts2B0t
# EUJTcXTC5TWqLVIS2SXP8NPQkUMS1zJ9mGzjd0HI/x8kVO9urcY+VXvxXIc6ZPFg
# SwVP77kv7AkTAgMBAAGjggGCMIIBfjAfBgNVHSMEGDAWgBQaofhhGSAPw0F3RSiO
# 0TVfBhIEVTAdBgNVHQ4EFgQUAw8xyJEqk71j89FdTaQ0D9KVARgwDgYDVR0PAQH/
# BAQDAgbAMAwGA1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwSgYD
# VR0gBEMwQTA1BgwrBgEEAbIxAQIBAwgwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9z
# ZWN0aWdvLmNvbS9DUFMwCAYGZ4EMAQQCMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6
# Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNybDB0
# BggrBgEFBQcBAQRoMGYwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQuc2VjdGlnby5j
# b20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNydDAjBggrBgEFBQcwAYYXaHR0
# cDovL29jc3Auc2VjdGlnby5jb20wDQYJKoZIhvcNAQEMBQADggIBAEybZVj64HnP
# 7xXDMm3eM5Hrd1ji673LSjx13n6UbcMixwSV32VpYRMM9gye9YkgXsGHxwMkysel
# 8Cbf+PgxZQ3g621RV6aMhFIIRhwqwt7y2opF87739i7Efu347Wi/elZI6WHlmjl3
# vL66kWSIdf9dhRY0J9Ipy//tLdr/vpMM7G2iDczD8W69IZEaIwBSrZfUYngqhHmo
# 1z2sIY9wwyR5OpfxDaOjW1PYqwC6WPs1gE9fKHFsGV7Cg3KQruDG2PKZ++q0kmV8
# B3w1RB2tWBhrYvvebMQKqWzTIUZw3C+NdUwjwkHQepY7w0vdzZImdHZcN6CaJJ5O
# X07Tjw/lE09ZRGVLQ2TPSPhnZ7lNv8wNsTow0KE9SK16ZeTs3+AB8LMqSjmswaT5
# qX010DJAoLEZKhghssh9BXEaSyc2quCYHIN158d+S4RDzUP7kJd2KhKsQMFwW5kK
# QPqAbZRhe8huuchnZyRcUI0BIN4H9wHU+C4RzZ2D5fjKJRxEPSflsIZHKgsbhHZ9
# e2hPjbf3E7TtoC3ucw/ZELqdmSx813UfjxDElOZ+JOWVSoiMJ9aFZh35rmR2kehI
# /shVCu0pwx/eOKbAFPsyPfipg2I2yMO+AIccq/pKQhyJA9z1XHxw2V14Tu6fXiDm
# CWp8KwijSPUV/ARP380hHHrl9Y4a1LlAMYIFkjCCBY4CAQEwgZAwfDELMAkGA1UE
# BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
# Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdv
# IFJTQSBDb2RlIFNpZ25pbmcgQ0ECECwnTfNkELSL/bju5S9Y3lMwDQYJYIZIAWUD
# BAIBBQCggYQwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMx
# DAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkq
# hkiG9w0BCQQxIgQgVSJSJhRhOTLmY1oIlICV/wenF4jM+E4WHBcWdc+0gQkwDQYJ
# KoZIhvcNAQEBBQAEggEABteaTvr8DJdH9f702tqDZOIjYujN/k8mHpXlRmdNJ2JS
# pe7DSLQiriNzr4mvK3r3erMjl1fKMM5kZ7mYIiSgBTpLSZddsHzM2hu/1Mh6H1TI
# od2pkh2Ndv/DoHtAsHb6BWTGwQJcQfah5Ny+X+kzerY5Afd+AtPNvNgFzCxsHu15
# R8OvnDaPjMN0YqP5PoRIUGQqlLakgrOd/NXZWvZ+lUgrMEZLQ36kdAaEkK9BuYt7
# lBfNV5Hd9d0OoQFbr+Lawnd4dOU5KdMIWAl9vlvk1inqFYFhJVP3N04Wdfx72QIz
# 1C10aRnMC4aouKP7QjcZ2T/Bl/I1c1a3/lxkdKlIRqGCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQxMDRaMD8GCSqG
# SIb3DQEJBDEyBDDjhFzJPj0Bs4xcL3wAO3Y4yOTv251umBapaz6BIRonScj+QXvu
# G6VjQgnGzNL2ZkgwDQYJKoZIhvcNAQEBBQAEggIAoGnv4/JhS2pD5shEkXV45q+5
# tQAYcNryxO1YuLgaYj7uX3wbUEYtBbaoM738ojgE6WdgU4ng5pnycdRcd/oeaPLs
# to1s95tWNJr8Yzm9yNKjf0Jn2IMgO2y6yCiKUI+YpjJjTWc/SqYgOuqXwKs8G2O9
# 1NVxfKt0BRsRi6qZVwRk5u+kbpYTm7rTHdXnmt4zsdIjpv512HI8C3U5hKxpwAH1
# M874l7CD5xM6DSfvYL74Lmm1mtCWA7jX3Qc4Hdvi0PqLwdzLMbTqVAXM/sinbt8y
# Ow2WpO4qJkkJJ4rp+AiKuH88twvNAmVTqavt/4fshBN+YxqMY7lLNCZfHI7ZvidF
# QklqQ6dh4u9e9xUzfUgvi0FkOMivEVphUB1Wvi9voR6yLww809isfNWXSUulUB29
# jeF3CI0d7p1kR4v6rcrVMjTFULN7bNvFPXfemf+htkTfspYNa5FZAO+I1os6AJzp
# ArrOCKvkeLODt7y7g714gekvd++TkxVBbFrNl7HxjZugCHKFacICHajrhBqD9Zcb
# 6ofJI0W2mGs7mbSHRd/HTboP8skneqHIGN+zIdPDv/nIfco0W0aAm96PF83MGsHg
# IdYMLYURpPiOh4xJSZfmB5ImltzC3GDEjKBfhl11FVq/9Ce0m/wJFZIOmWYtBwYv
# LfZxQAUVhMhY+KTvBiU=
# SIG # End signature block
