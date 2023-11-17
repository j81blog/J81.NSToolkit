function Invoke-NSGetAuthorizationaction {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Configuration for authorization action resource.
    .PARAMETER Name 
        Name of authorization action. 
    .PARAMETER GetAll 
        Retrieve all authorizationaction object(s).
    .PARAMETER Count
        If specified, the count of the authorizationaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationaction -GetAll 
        Get all authorizationaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationaction -Count 
        Get the number of authorizationaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationaction -name <string>
        Get authorizationaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationaction -Filter @{ 'name'='<value>' }
        Get authorizationaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationaction/
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
        Write-Verbose "Invoke-NSGetAuthorizationaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all authorizationaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationaction: Ended"
    }
}

function Invoke-NSAddAuthorizationpolicy {
    <#
    .SYNOPSIS
        Add Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object.
    .DESCRIPTION
        Configuration for authorization policy resource.
    .PARAMETER Name 
        Name for the new authorization policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the authorization policy is added. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, that the policy uses to perform the authentication. 
    .PARAMETER Action 
        Action to perform if the policy matches: either allow or deny the request. 
    .PARAMETER PassThru 
        Return details about the created authorizationpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAuthorizationpolicy -name <string> -rule <string> -action <string>
        An example how to add authorizationpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddAuthorizationpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAuthorizationpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("authorizationpolicy", "Add Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type authorizationpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuthorizationpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAuthorizationpolicy: Finished"
    }
}

function Invoke-NSDeleteAuthorizationpolicy {
    <#
    .SYNOPSIS
        Delete Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object.
    .DESCRIPTION
        Configuration for authorization policy resource.
    .PARAMETER Name 
        Name for the new authorization policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the authorization policy is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAuthorizationpolicy -Name <string>
        An example how to delete authorizationpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAuthorizationpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy/
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
        Write-Verbose "Invoke-NSDeleteAuthorizationpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type authorizationpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAuthorizationpolicy: Finished"
    }
}

function Invoke-NSUpdateAuthorizationpolicy {
    <#
    .SYNOPSIS
        Update Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object.
    .DESCRIPTION
        Configuration for authorization policy resource.
    .PARAMETER Name 
        Name for the new authorization policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the authorization policy is added. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, that the policy uses to perform the authentication. 
    .PARAMETER Action 
        Action to perform if the policy matches: either allow or deny the request. 
    .PARAMETER PassThru 
        Return details about the created authorizationpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAuthorizationpolicy -name <string>
        An example how to update authorizationpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAuthorizationpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy/
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
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAuthorizationpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("authorizationpolicy", "Update Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type authorizationpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuthorizationpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAuthorizationpolicy: Finished"
    }
}

function Invoke-NSRenameAuthorizationpolicy {
    <#
    .SYNOPSIS
        Rename Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object.
    .DESCRIPTION
        Configuration for authorization policy resource.
    .PARAMETER Name 
        Name for the new authorization policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the authorization policy is added. 
    .PARAMETER Newname 
        The new name of the author policy. 
    .PARAMETER PassThru 
        Return details about the created authorizationpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameAuthorizationpolicy -name <string> -newname <string>
        An example how to rename authorizationpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSRenameAuthorizationpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameAuthorizationpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("authorizationpolicy", "Rename Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type authorizationpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuthorizationpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameAuthorizationpolicy: Finished"
    }
}

function Invoke-NSGetAuthorizationpolicy {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Configuration for authorization policy resource.
    .PARAMETER Name 
        Name for the new authorization policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the authorization policy is added. 
    .PARAMETER GetAll 
        Retrieve all authorizationpolicy object(s).
    .PARAMETER Count
        If specified, the count of the authorizationpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicy -GetAll 
        Get all authorizationpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicy -Count 
        Get the number of authorizationpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicy -name <string>
        Get authorizationpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicy -Filter @{ 'name'='<value>' }
        Get authorizationpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy/
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
        Write-Verbose "Invoke-NSGetAuthorizationpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all authorizationpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationpolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationpolicy: Ended"
    }
}

function Invoke-NSGetAuthorizationpolicyAaagroupBinding {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Binding object showing the aaagroup that can be bound to authorizationpolicy.
    .PARAMETER Name 
        Name of the authorization policy. 
    .PARAMETER GetAll 
        Retrieve all authorizationpolicy_aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the authorizationpolicy_aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyAaagroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyAaagroupBinding -GetAll 
        Get all authorizationpolicy_aaagroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyAaagroupBinding -Count 
        Get the number of authorizationpolicy_aaagroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyAaagroupBinding -name <string>
        Get authorizationpolicy_aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyAaagroupBinding -Filter @{ 'name'='<value>' }
        Get authorizationpolicy_aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationpolicyAaagroupBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy_aaagroup_binding/
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
        Write-Verbose "Invoke-NSGetAuthorizationpolicyAaagroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all authorizationpolicy_aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationpolicy_aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationpolicy_aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationpolicy_aaagroup_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_aaagroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationpolicy_aaagroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationpolicyAaagroupBinding: Ended"
    }
}

function Invoke-NSGetAuthorizationpolicyAaauserBinding {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to authorizationpolicy.
    .PARAMETER Name 
        Name of the authorization policy. 
    .PARAMETER GetAll 
        Retrieve all authorizationpolicy_aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the authorizationpolicy_aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyAaauserBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyAaauserBinding -GetAll 
        Get all authorizationpolicy_aaauser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyAaauserBinding -Count 
        Get the number of authorizationpolicy_aaauser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyAaauserBinding -name <string>
        Get authorizationpolicy_aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyAaauserBinding -Filter @{ 'name'='<value>' }
        Get authorizationpolicy_aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationpolicyAaauserBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy_aaauser_binding/
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
        Write-Verbose "Invoke-NSGetAuthorizationpolicyAaauserBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all authorizationpolicy_aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationpolicy_aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationpolicy_aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationpolicy_aaauser_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_aaauser_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationpolicy_aaauser_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationpolicyAaauserBinding: Ended"
    }
}

function Invoke-NSGetAuthorizationpolicyAuthorizationpolicylabelBinding {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Binding object showing the authorizationpolicylabel that can be bound to authorizationpolicy.
    .PARAMETER Name 
        Name of the authorization policy. 
    .PARAMETER GetAll 
        Retrieve all authorizationpolicy_authorizationpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the authorizationpolicy_authorizationpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyAuthorizationpolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyAuthorizationpolicylabelBinding -GetAll 
        Get all authorizationpolicy_authorizationpolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyAuthorizationpolicylabelBinding -Count 
        Get the number of authorizationpolicy_authorizationpolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyAuthorizationpolicylabelBinding -name <string>
        Get authorizationpolicy_authorizationpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyAuthorizationpolicylabelBinding -Filter @{ 'name'='<value>' }
        Get authorizationpolicy_authorizationpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationpolicyAuthorizationpolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy_authorizationpolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetAuthorizationpolicyAuthorizationpolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all authorizationpolicy_authorizationpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_authorizationpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationpolicy_authorizationpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_authorizationpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationpolicy_authorizationpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_authorizationpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationpolicy_authorizationpolicylabel_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_authorizationpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationpolicy_authorizationpolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_authorizationpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationpolicyAuthorizationpolicylabelBinding: Ended"
    }
}

function Invoke-NSGetAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to authorizationpolicy.
    .PARAMETER Name 
        Name of the authorization policy. 
    .PARAMETER GetAll 
        Retrieve all authorizationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the authorizationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyBinding -GetAll 
        Get all authorizationpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyBinding -name <string>
        Get authorizationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyBinding -Filter @{ 'name'='<value>' }
        Get authorizationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy_binding/
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
        Write-Verbose "Invoke-NSGetAuthorizationpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all authorizationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationpolicyBinding: Ended"
    }
}

function Invoke-NSGetAuthorizationpolicyCsvserverBinding {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to authorizationpolicy.
    .PARAMETER Name 
        Name of the authorization policy. 
    .PARAMETER GetAll 
        Retrieve all authorizationpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the authorizationpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyCsvserverBinding -GetAll 
        Get all authorizationpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyCsvserverBinding -Count 
        Get the number of authorizationpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyCsvserverBinding -name <string>
        Get authorizationpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyCsvserverBinding -Filter @{ 'name'='<value>' }
        Get authorizationpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationpolicyCsvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-NSGetAuthorizationpolicyCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all authorizationpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationpolicy_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationpolicyCsvserverBinding: Ended"
    }
}

function Invoke-NSGetAuthorizationpolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to authorizationpolicy.
    .PARAMETER Name 
        Name of the authorization policy. 
    .PARAMETER GetAll 
        Retrieve all authorizationpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the authorizationpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyLbvserverBinding -GetAll 
        Get all authorizationpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicyLbvserverBinding -Count 
        Get the number of authorizationpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyLbvserverBinding -name <string>
        Get authorizationpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get authorizationpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationpolicyLbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetAuthorizationpolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all authorizationpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationpolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationpolicyLbvserverBinding: Ended"
    }
}

function Invoke-NSAddAuthorizationpolicylabel {
    <#
    .SYNOPSIS
        Add Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object.
    .DESCRIPTION
        Configuration for authorization policy label resource.
    .PARAMETER Labelname 
        Name for the new authorization policy label. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the authorization policy is created. 
    .PARAMETER PassThru 
        Return details about the created authorizationpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAuthorizationpolicylabel -labelname <string>
        An example how to add authorizationpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSAddAuthorizationpolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicylabel/
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
        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAuthorizationpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname }

            if ( $PSCmdlet.ShouldProcess("authorizationpolicylabel", "Add Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type authorizationpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuthorizationpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAuthorizationpolicylabel: Finished"
    }
}

function Invoke-NSDeleteAuthorizationpolicylabel {
    <#
    .SYNOPSIS
        Delete Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object.
    .DESCRIPTION
        Configuration for authorization policy label resource.
    .PARAMETER Labelname 
        Name for the new authorization policy label. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the authorization policy is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAuthorizationpolicylabel -Labelname <string>
        An example how to delete authorizationpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAuthorizationpolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicylabel/
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
        [string]$Labelname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAuthorizationpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type authorizationpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAuthorizationpolicylabel: Finished"
    }
}

function Invoke-NSRenameAuthorizationpolicylabel {
    <#
    .SYNOPSIS
        Rename Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object.
    .DESCRIPTION
        Configuration for authorization policy label resource.
    .PARAMETER Labelname 
        Name for the new authorization policy label. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the authorization policy is created. 
    .PARAMETER Newname 
        The new name of the auth policy label. 
    .PARAMETER PassThru 
        Return details about the created authorizationpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameAuthorizationpolicylabel -labelname <string> -newname <string>
        An example how to rename authorizationpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSRenameAuthorizationpolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicylabel/
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameAuthorizationpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("authorizationpolicylabel", "Rename Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type authorizationpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuthorizationpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameAuthorizationpolicylabel: Finished"
    }
}

function Invoke-NSGetAuthorizationpolicylabel {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Configuration for authorization policy label resource.
    .PARAMETER Labelname 
        Name for the new authorization policy label. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the authorization policy is created. 
    .PARAMETER GetAll 
        Retrieve all authorizationpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the authorizationpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicylabel -GetAll 
        Get all authorizationpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicylabel -Count 
        Get the number of authorizationpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicylabel -name <string>
        Get authorizationpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicylabel -Filter @{ 'name'='<value>' }
        Get authorizationpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationpolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicylabel/
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
        [string]$Labelname,

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
        Write-Verbose "Invoke-NSGetAuthorizationpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all authorizationpolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationpolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationpolicylabel configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationpolicylabel configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationpolicylabel: Ended"
    }
}

function Invoke-NSAddAuthorizationpolicylabelAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Add Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to authorizationpolicylabel.
    .PARAMETER Labelname 
        Name of the authorization policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the authorization policy to bind to the policy label. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then either forward the request or response to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation. Available settings function as follows: * reqvserver - Send the request to the specified request virtual server. * resvserver - Send the response to the specified response virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Invoke_labelname 
        Name of the policy label to invoke if the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is set to Policy Label. 
    .PARAMETER PassThru 
        Return details about the created authorizationpolicylabel_authorizationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAuthorizationpolicylabelAuthorizationpolicyBinding -labelname <string> -policyname <string> -priority <double>
        An example how to add authorizationpolicylabel_authorizationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAuthorizationpolicylabelAuthorizationpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicylabel_authorizationpolicy_binding/
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAuthorizationpolicylabelAuthorizationpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                policyname          = $policyname
                priority            = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('invoke_labelname') ) { $payload.Add('invoke_labelname', $invoke_labelname) }
            if ( $PSCmdlet.ShouldProcess("authorizationpolicylabel_authorizationpolicy_binding", "Add Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type authorizationpolicylabel_authorizationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuthorizationpolicylabelAuthorizationpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAuthorizationpolicylabelAuthorizationpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAuthorizationpolicylabelAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Delete Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to authorizationpolicylabel.
    .PARAMETER Labelname 
        Name of the authorization policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the authorization policy to bind to the policy label. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAuthorizationpolicylabelAuthorizationpolicyBinding -Labelname <string>
        An example how to delete authorizationpolicylabel_authorizationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAuthorizationpolicylabelAuthorizationpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicylabel_authorizationpolicy_binding/
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
        [string]$Labelname,

        [string]$Policyname,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAuthorizationpolicylabelAuthorizationpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type authorizationpolicylabel_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAuthorizationpolicylabelAuthorizationpolicyBinding: Finished"
    }
}

function Invoke-NSGetAuthorizationpolicylabelAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to authorizationpolicylabel.
    .PARAMETER Labelname 
        Name of the authorization policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all authorizationpolicylabel_authorizationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the authorizationpolicylabel_authorizationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicylabelAuthorizationpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicylabelAuthorizationpolicyBinding -GetAll 
        Get all authorizationpolicylabel_authorizationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicylabelAuthorizationpolicyBinding -Count 
        Get the number of authorizationpolicylabel_authorizationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicylabelAuthorizationpolicyBinding -name <string>
        Get authorizationpolicylabel_authorizationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicylabelAuthorizationpolicyBinding -Filter @{ 'name'='<value>' }
        Get authorizationpolicylabel_authorizationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationpolicylabelAuthorizationpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicylabel_authorizationpolicy_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAuthorizationpolicylabelAuthorizationpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all authorizationpolicylabel_authorizationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationpolicylabel_authorizationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationpolicylabel_authorizationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationpolicylabel_authorizationpolicy_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationpolicylabel_authorizationpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationpolicylabelAuthorizationpolicyBinding: Ended"
    }
}

function Invoke-NSGetAuthorizationpolicylabelBinding {
    <#
    .SYNOPSIS
        Get Authorization configuration. Authorization services check which resources users are authorized to access, and grant permissions accordingly. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to authorizationpolicylabel.
    .PARAMETER Labelname 
        Name of the authorization policy label. 
    .PARAMETER GetAll 
        Retrieve all authorizationpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the authorizationpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuthorizationpolicylabelBinding -GetAll 
        Get all authorizationpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicylabelBinding -name <string>
        Get authorizationpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuthorizationpolicylabelBinding -Filter @{ 'name'='<value>' }
        Get authorizationpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuthorizationpolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/authorization/authorizationpolicylabel_binding/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAuthorizationpolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all authorizationpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authorizationpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authorizationpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authorizationpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authorizationpolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type authorizationpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuthorizationpolicylabelBinding: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAfQZ1t2VYZvM3/
# DS2IusrQFunCE6DxmBok+SSN3eB+X6CCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# LqPzW0sH3DJZ84enGm1YMYICQzCCAj8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZ
# BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
# A1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2Rl
# IFNpZ25pbmcgQ0ECECwnTfNkELSL/bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQgK1qCp4uz50auv41ZJM9BNyeBBORTKGsyPPa9iI/1wUMwDQYJKoZIhvcNAQEB
# BQAEggEAfXX0WvFpuJrs49Jh/uynurdVit1VXqniUY0gw9C8lTTeguyk/d6nonGa
# 0PjYxtGjEnTAzKo/6Bs9xT7XOuGvls7leQG5VOCHQkiY1CnWsGugGOY2+1Kbx4b7
# bQNmNrLnj4AwF7DEyQYKi9HcFrbBPF2YGuTFewEkYT3blKedaVUOujqdchXB+n8d
# V+G+831k96+iWueoL7fjtByg9TB1gqRf3iv3IiOPSy6HXlck+9q+ctHUIuiwZD4t
# srsTQM+8QDrttBYgdz3SiHZZYSWJNZZs7cmdxDL8cEfnsWxHfwUisgaHui11TYJP
# YbA/jCmQpnGFFLgk3+eUYAh05vFImQ==
# SIG # End signature block
