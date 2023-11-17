function Invoke-NSAddCsaction {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER Targetlbvserver 
        Name of the load balancing virtual server to which the content is switched. 
    .PARAMETER Targetvserver 
        Name of the VPN, GSLB or Authentication virtual server to which the content is switched. 
    .PARAMETER Targetvserverexpr 
        Information about this content switching action. 
    .PARAMETER Comment 
        Comments associated with this cs action. 
    .PARAMETER PassThru 
        Return details about the created csaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsaction -name <string>
        An example how to add csaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csaction/
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Name,

        [string]$Targetlbvserver,

        [string]$Targetvserver,

        [string]$Targetvserverexpr,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('targetvserverexpr') ) { $payload.Add('targetvserverexpr', $targetvserverexpr) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("csaction", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type csaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsaction: Finished"
    }
}

function Invoke-NSDeleteCsaction {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsaction -Name <string>
        An example how to delete csaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csaction/
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
        Write-Verbose "Invoke-NSDeleteCsaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsaction: Finished"
    }
}

function Invoke-NSUpdateCsaction {
    <#
    .SYNOPSIS
        Update Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER Targetlbvserver 
        Name of the load balancing virtual server to which the content is switched. 
    .PARAMETER Targetvserver 
        Name of the VPN, GSLB or Authentication virtual server to which the content is switched. 
    .PARAMETER Targetvserverexpr 
        Information about this content switching action. 
    .PARAMETER Comment 
        Comments associated with this cs action. 
    .PARAMETER PassThru 
        Return details about the created csaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCsaction -name <string>
        An example how to update csaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csaction/
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Name,

        [string]$Targetlbvserver,

        [string]$Targetvserver,

        [string]$Targetvserverexpr,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCsaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('targetvserverexpr') ) { $payload.Add('targetvserverexpr', $targetvserverexpr) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("csaction", "Update Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCsaction: Finished"
    }
}

function Invoke-NSUnsetCsaction {
    <#
    .SYNOPSIS
        Unset Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER Comment 
        Comments associated with this cs action.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCsaction -name <string>
        An example how to unset csaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csaction
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

        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Name,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCsaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type csaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCsaction: Finished"
    }
}

function Invoke-NSRenameCsaction {
    <#
    .SYNOPSIS
        Rename Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER Newname 
        New name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created csaction item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCsaction -name <string> -newname <string>
        An example how to rename csaction config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csaction/
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameCsaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("csaction", "Rename Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type csaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsaction -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCsaction: Finished"
    }
}

function Invoke-NSGetCsaction {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER GetAll 
        Retrieve all csaction object(s).
    .PARAMETER Count
        If specified, the count of the csaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsaction -GetAll 
        Get all csaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsaction -Count 
        Get the number of csaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsaction -name <string>
        Get csaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsaction -Filter @{ 'name'='<value>' }
        Get csaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csaction/
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
        Write-Verbose "Invoke-NSGetCsaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all csaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsaction: Ended"
    }
}

function Invoke-NSUpdateCsparameter {
    <#
    .SYNOPSIS
        Update Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS parameter resource.
    .PARAMETER Stateupdate 
        Specifies whether the virtual server checks the attached load balancing server for state information. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCsparameter 
        An example how to update csparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCsparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csparameter/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Stateupdate 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCsparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('stateupdate') ) { $payload.Add('stateupdate', $stateupdate) }
            if ( $PSCmdlet.ShouldProcess("csparameter", "Update Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateCsparameter: Finished"
    }
}

function Invoke-NSUnsetCsparameter {
    <#
    .SYNOPSIS
        Unset Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS parameter resource.
    .PARAMETER Stateupdate 
        Specifies whether the virtual server checks the attached load balancing server for state information. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCsparameter 
        An example how to unset csparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCsparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csparameter
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

        [Boolean]$stateupdate 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCsparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('stateupdate') ) { $payload.Add('stateupdate', $stateupdate) }
            if ( $PSCmdlet.ShouldProcess("csparameter", "Unset Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type csparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCsparameter: Finished"
    }
}

function Invoke-NSGetCsparameter {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Configuration for CS parameter resource.
    .PARAMETER GetAll 
        Retrieve all csparameter object(s).
    .PARAMETER Count
        If specified, the count of the csparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsparameter -GetAll 
        Get all csparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsparameter -name <string>
        Get csparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsparameter -Filter @{ 'name'='<value>' }
        Get csparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csparameter/
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
        Write-Verbose "Invoke-NSGetCsparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all csparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving csparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsparameter: Ended"
    }
}

function Invoke-NSAddCspolicy {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Content switching action that names the target load balancing virtual server to which the traffic is switched. 
    .PARAMETER Logaction 
        The log action associated with the content switching policy. 
    .PARAMETER PassThru 
        Return details about the created cspolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCspolicy -policyname <string> -rule <string>
        An example how to add cspolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddCspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicy/
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
        [string]$Policyname,

        [Parameter(Mandatory)]
        [string]$Rule,

        [string]$Action,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCspolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                rule                 = $rule
            }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("cspolicy", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cspolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCspolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCspolicy: Finished"
    }
}

function Invoke-NSDeleteCspolicy {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCspolicy -Policyname <string>
        An example how to delete cspolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicy/
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
        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCspolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$policyname", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cspolicy -NitroPath nitro/v1/config -Resource $policyname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCspolicy: Finished"
    }
}

function Invoke-NSUpdateCspolicy {
    <#
    .SYNOPSIS
        Update Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Content switching action that names the target load balancing virtual server to which the traffic is switched. 
    .PARAMETER Logaction 
        The log action associated with the content switching policy. 
    .PARAMETER PassThru 
        Return details about the created cspolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCspolicy -policyname <string>
        An example how to update cspolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicy/
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
        [string]$Policyname,

        [string]$Rule,

        [string]$Action,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCspolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("cspolicy", "Update Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cspolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCspolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCspolicy: Finished"
    }
}

function Invoke-NSUnsetCspolicy {
    <#
    .SYNOPSIS
        Unset Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER Logaction 
        The log action associated with the content switching policy.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCspolicy -policyname <string>
        An example how to unset cspolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicy
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Policyname,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCspolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$policyname", "Unset Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type cspolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCspolicy: Finished"
    }
}

function Invoke-NSRenameCspolicy {
    <#
    .SYNOPSIS
        Rename Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER Newname 
        The new name of the content switching policy. 
    .PARAMETER PassThru 
        Return details about the created cspolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCspolicy -policyname <string> -newname <string>
        An example how to rename cspolicy config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicy/
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
        [string]$Policyname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameCspolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                newname              = $newname
            }

            if ( $PSCmdlet.ShouldProcess("cspolicy", "Rename Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cspolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCspolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCspolicy: Finished"
    }
}

function Invoke-NSGetCspolicy {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER GetAll 
        Retrieve all cspolicy object(s).
    .PARAMETER Count
        If specified, the count of the cspolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicy -GetAll 
        Get all cspolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicy -Count 
        Get the number of cspolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicy -name <string>
        Get cspolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicy -Filter @{ 'name'='<value>' }
        Get cspolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetCspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicy/
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
        [string]$Policyname,

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
        Write-Verbose "Invoke-NSGetCspolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cspolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCspolicy: Ended"
    }
}

function Invoke-NSGetCspolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to cspolicy.
    .PARAMETER Policyname 
        Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all cspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicyBinding -GetAll 
        Get all cspolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyBinding -name <string>
        Get cspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyBinding -Filter @{ 'name'='<value>' }
        Get cspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicy_binding/
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
        [string]$Policyname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCspolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCspolicyBinding: Ended"
    }
}

function Invoke-NSGetCspolicyCrvserverBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to cspolicy.
    .PARAMETER Policyname 
        Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all cspolicy_crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicy_crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyCrvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicyCrvserverBinding -GetAll 
        Get all cspolicy_crvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicyCrvserverBinding -Count 
        Get the number of cspolicy_crvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyCrvserverBinding -name <string>
        Get cspolicy_crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyCrvserverBinding -Filter @{ 'name'='<value>' }
        Get cspolicy_crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCspolicyCrvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicy_crvserver_binding/
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
        [string]$Policyname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCspolicyCrvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicy_crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_crvserver_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_crvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCspolicyCrvserverBinding: Ended"
    }
}

function Invoke-NSGetCspolicyCspolicylabelBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the cspolicylabel that can be bound to cspolicy.
    .PARAMETER Policyname 
        Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all cspolicy_cspolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicy_cspolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyCspolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicyCspolicylabelBinding -GetAll 
        Get all cspolicy_cspolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicyCspolicylabelBinding -Count 
        Get the number of cspolicy_cspolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyCspolicylabelBinding -name <string>
        Get cspolicy_cspolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyCspolicylabelBinding -Filter @{ 'name'='<value>' }
        Get cspolicy_cspolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCspolicyCspolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicy_cspolicylabel_binding/
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
        [string]$Policyname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCspolicyCspolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicy_cspolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_cspolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_cspolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_cspolicylabel_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_cspolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCspolicyCspolicylabelBinding: Ended"
    }
}

function Invoke-NSGetCspolicyCsvserverBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to cspolicy.
    .PARAMETER Policyname 
        Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all cspolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicyCsvserverBinding -GetAll 
        Get all cspolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicyCsvserverBinding -Count 
        Get the number of cspolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyCsvserverBinding -name <string>
        Get cspolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicyCsvserverBinding -Filter @{ 'name'='<value>' }
        Get cspolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCspolicyCsvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicy_csvserver_binding/
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
        [string]$Policyname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCspolicyCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_csvserver_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCspolicyCsvserverBinding: Ended"
    }
}

function Invoke-NSAddCspolicylabel {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        The label name must be unique within the list of policy labels for content switching. 
    .PARAMETER Cspolicylabeltype 
        Protocol supported by the policy label. All policies bound to the policy label must either match the specified protocol or be a subtype of that protocol. Available settings function as follows: 
        * HTTP - Supports policies that process HTTP traffic. Used to access unencrypted Web sites. (The default.) 
        * SSL - Supports policies that process HTTPS/SSL encrypted traffic. Used to access encrypted Web sites. 
        * TCP - Supports policies that process any type of TCP traffic, including HTTP. 
        * SSL_TCP - Supports policies that process SSL-encrypted TCP traffic, including SSL. 
        * UDP - Supports policies that process any type of UDP-based traffic, including DNS. 
        * DNS - Supports policies that process DNS traffic. 
        * ANY - Supports all types of policies except HTTP, SSL, and TCP. 
        * SIP_UDP - Supports policies that process UDP based Session Initiation Protocol (SIP) traffic. SIP initiates, manages, and terminates multimedia communications sessions, and has emerged as the standard for Internet telephony (VoIP). 
        * RTSP - Supports policies that process Real Time Streaming Protocol (RTSP) traffic. RTSP provides delivery of multimedia and other streaming data, such as audio, video, and other types of streamed media. 
        * RADIUS - Supports policies that process Remote Authentication Dial In User Service (RADIUS) traffic. RADIUS supports combined authentication, authorization, and auditing services for network management. 
        * MYSQL - Supports policies that process MYSQL traffic. 
        * MSSQL - Supports policies that process Microsoft SQL traffic. 
        Possible values = HTTP, TCP, RTSP, SSL, SSL_TCP, UDP, DNS, SIP_UDP, SIP_TCP, ANY, RADIUS, RDP, MYSQL, MSSQL, ORACLE, DIAMETER, SSL_DIAMETER, FTP, DNS_TCP, SMPP, MQTT, MQTT_TLS, HTTP_QUIC 
    .PARAMETER PassThru 
        Return details about the created cspolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCspolicylabel -labelname <string> -cspolicylabeltype <string>
        An example how to add cspolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSAddCspolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicylabel/
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'TCP', 'RTSP', 'SSL', 'SSL_TCP', 'UDP', 'DNS', 'SIP_UDP', 'SIP_TCP', 'ANY', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'ORACLE', 'DIAMETER', 'SSL_DIAMETER', 'FTP', 'DNS_TCP', 'SMPP', 'MQTT', 'MQTT_TLS', 'HTTP_QUIC')]
        [string]$Cspolicylabeltype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCspolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                cspolicylabeltype   = $cspolicylabeltype
            }

            if ( $PSCmdlet.ShouldProcess("cspolicylabel", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cspolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCspolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCspolicylabel: Finished"
    }
}

function Invoke-NSDeleteCspolicylabel {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        The label name must be unique within the list of policy labels for content switching.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCspolicylabel -Labelname <string>
        An example how to delete cspolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCspolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicylabel/
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
        Write-Verbose "Invoke-NSDeleteCspolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCspolicylabel: Finished"
    }
}

function Invoke-NSRenameCspolicylabel {
    <#
    .SYNOPSIS
        Rename Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        The label name must be unique within the list of policy labels for content switching. 
    .PARAMETER Newname 
        The new name of the content switching policylabel. 
    .PARAMETER PassThru 
        Return details about the created cspolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCspolicylabel -labelname <string> -newname <string>
        An example how to rename cspolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCspolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicylabel/
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameCspolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("cspolicylabel", "Rename Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cspolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCspolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCspolicylabel: Finished"
    }
}

function Invoke-NSGetCspolicylabel {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Configuration for CS policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        The label name must be unique within the list of policy labels for content switching. 
    .PARAMETER GetAll 
        Retrieve all cspolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the cspolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicylabel -GetAll 
        Get all cspolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicylabel -Count 
        Get the number of cspolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicylabel -name <string>
        Get cspolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicylabel -Filter @{ 'name'='<value>' }
        Get cspolicylabel data with a filter.
    .NOTES
        File Name : Invoke-NSGetCspolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicylabel/
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
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
        Write-Verbose "Invoke-NSGetCspolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cspolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicylabel configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicylabel configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCspolicylabel: Ended"
    }
}

function Invoke-NSGetCspolicylabelBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to cspolicylabel.
    .PARAMETER Labelname 
        Name of the content switching policy label to display. 
    .PARAMETER GetAll 
        Retrieve all cspolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicylabelBinding -GetAll 
        Get all cspolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicylabelBinding -name <string>
        Get cspolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicylabelBinding -Filter @{ 'name'='<value>' }
        Get cspolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCspolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetCspolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCspolicylabelBinding: Ended"
    }
}

function Invoke-NSAddCspolicylabelCspolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to cspolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind a content switching policy. 
    .PARAMETER Policyname 
        Name of the content switching policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which to forward requests that match the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        . 
    .PARAMETER Labeltype 
        Type of policy label invocation. 
        Possible values = policylabel 
    .PARAMETER Invoke_labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created cspolicylabel_cspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCspolicylabelCspolicyBinding -labelname <string> -policyname <string> -priority <double>
        An example how to add cspolicylabel_cspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCspolicylabelCspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicylabel_cspolicy_binding/
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

        [string]$Targetvserver,

        [string]$Gotopriorityexpression,

        [boolean]$Invoke,

        [ValidateSet('policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCspolicylabelCspolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                policyname          = $policyname
                priority            = $priority
            }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('invoke_labelname') ) { $payload.Add('invoke_labelname', $invoke_labelname) }
            if ( $PSCmdlet.ShouldProcess("cspolicylabel_cspolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cspolicylabel_cspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCspolicylabelCspolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCspolicylabelCspolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCspolicylabelCspolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to cspolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind a content switching policy. 
    .PARAMETER Policyname 
        Name of the content switching policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCspolicylabelCspolicyBinding -Labelname <string>
        An example how to delete cspolicylabel_cspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCspolicylabelCspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicylabel_cspolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCspolicylabelCspolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCspolicylabelCspolicyBinding: Finished"
    }
}

function Invoke-NSGetCspolicylabelCspolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to cspolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind a content switching policy. 
    .PARAMETER GetAll 
        Retrieve all cspolicylabel_cspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicylabel_cspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicylabelCspolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicylabelCspolicyBinding -GetAll 
        Get all cspolicylabel_cspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCspolicylabelCspolicyBinding -Count 
        Get the number of cspolicylabel_cspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicylabelCspolicyBinding -name <string>
        Get cspolicylabel_cspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCspolicylabelCspolicyBinding -Filter @{ 'name'='<value>' }
        Get cspolicylabel_cspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCspolicylabelCspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/cspolicylabel_cspolicy_binding/
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
        Write-Verbose "Invoke-NSGetCspolicylabelCspolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicylabel_cspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicylabel_cspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicylabel_cspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicylabel_cspolicy_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicylabel_cspolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCspolicylabelCspolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserver {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
         
        Maximum value = 4094 
    .PARAMETER Servicetype 
        Protocol used by the virtual server. 
        Possible values = HTTP, SSL, TCP, FTP, RTSP, SSL_TCP, UDP, DNS, SIP_UDP, SIP_TCP, SIP_SSL, ANY, RADIUS, RDP, MYSQL, MSSQL, DIAMETER, SSL_DIAMETER, DNS_TCP, ORACLE, SMPP, PROXY, MONGO, MONGO_TLS, MQTT, MQTT_TLS, HTTP_QUIC 
    .PARAMETER Ipv46 
        IP address of the content switching virtual server. 
    .PARAMETER Targettype 
        Virtual server target type. 
        Possible values = GSLB 
    .PARAMETER Dnsrecordtype 
        . 
         
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Persistenceid 
        . 
         
        Maximum value = 65535 
    .PARAMETER Ippattern 
        IP address pattern, in dotted decimal notation, for identifying packets to be accepted by the virtual server. The IP Mask parameter specifies which part of the destination IP address is matched against the pattern. Mutually exclusive with the IP Address parameter. 
        For example, if the IP pattern assigned to the virtual server is 198.51.100.0 and the IP mask is 255.255.240.0 (a forward mask), the first 20 bits in the destination IP addresses are matched with the first 20 bits in the pattern. The virtual server accepts requests with IP addresses that range from 198.51.96.1 to 198.51.111.254. You can also use a pattern such as 0.0.2.2 and a mask such as 0.0.255.255 (a reverse mask). 
        If a destination IP address matches more than one IP pattern, the pattern with the longest match is selected, and the associated virtual server processes the request. For example, if the virtual servers, vs1 and vs2, have the same IP pattern, 0.0.100.128, but different IP masks of 0.0.255.255 and 0.0.224.255, a destination IP address of 198.51.100.128 has the longest match with the IP pattern of vs1. If a destination IP address matches two or more virtual servers to the same extent, the request is processed by the virtual server whose port number matches the port number in the request. 
    .PARAMETER Ipmask 
        IP mask, in dotted decimal notation, for the IP Pattern parameter. Can have leading or trailing non-zero octets (for example, 255.255.240.0 or 0.0.255.255). Accordingly, the mask specifies whether the first n bits or the last n bits of the destination IP address in a client request are to be matched with the corresponding bits in the IP pattern. The former is called a forward mask. The latter is called a reverse mask. 
    .PARAMETER Range 
        Number of consecutive IP addresses, starting with the address specified by the IP Address parameter, to include in a range of addresses assigned to this virtual server. 
         
         
        Maximum value = 254 
    .PARAMETER Port 
        Port number for content switching virtual server. 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cs vserver. 
    .PARAMETER State 
        Initial state of the load balancing virtual server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Stateupdate 
        Enable state updates for a specific content switching virtual server. By default, the Content Switching virtual server is always UP, regardless of the state of the Load Balancing virtual servers bound to it. This parameter interacts with the global setting as follows: 
        Global Level | Vserver Level | Result 
        ENABLED ENABLED ENABLED 
        ENABLED DISABLED ENABLED 
        DISABLED ENABLED ENABLED 
        DISABLED DISABLED DISABLED 
        If you want to enable state updates for only some content switching virtual servers, be sure to disable the state update parameter. 
         
        Possible values = ENABLED, DISABLED, UPDATEONBACKENDUPDATE 
    .PARAMETER Cacheable 
        Use this option to specify whether a virtual server, used for load balancing or content switching, routes requests to the cache redirection virtual server before sending it to the configured servers. 
         
        Possible values = YES, NO 
    .PARAMETER Redirecturl 
        URL to which traffic is redirected if the virtual server becomes unavailable. The service type of the virtual server should be either HTTP or SSL. 
        Caution: Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which the client connection is terminated. The default values are: 
        180 seconds for HTTP/SSL-based services. 
        9000 seconds for other TCP-based services. 
        120 seconds for DNS-based services. 
        120 seconds for other UDP-based services. 
         
        Maximum value = 31536000 
    .PARAMETER Precedence 
        Type of precedence to use for both RULE-based and URL-based policies on the content switching virtual server. With the default (RULE) setting, incoming requests are evaluated against the rule-based content switching policies. If none of the rules match, the URL in the request is evaluated against the URL-based content switching policies. 
         
        Possible values = RULE, URL 
    .PARAMETER Casesensitive 
        Consider case in URLs (for policies that use URLs instead of RULES). For example, with the ON setting, the URLs /a/1.html and /A/1.HTML are treated differently and can have different targets (set by content switching policies). With the OFF setting, /a/1.html and /A/1.HTML are switched to the same target. 
         
        Possible values = ON, OFF 
    .PARAMETER Somethod 
        Type of spillover used to divert traffic to the backup virtual server when the primary virtual server reaches the spillover threshold. Connection spillover is based on the number of connections. Bandwidth spillover is based on the total Kbps of incoming and outgoing traffic. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        Maintain source-IP based persistence on primary and backup virtual servers. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Time-out value, in minutes, for spillover persistence. 
         
         
        Maximum value = 1440 
    .PARAMETER Sothreshold 
        Depending on the spillover method, the maximum number of connections or the maximum total bandwidth (Kbps) that a virtual server can handle before spillover occurs. 
         
        Maximum value = 4294967287 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Redirectportrewrite 
        State of port rewrite while performing HTTP redirect. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Backupvserver 
        Name of the backup virtual server that you are configuring. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the backup virtual server is created. You can assign a different backup virtual server or rename the existing virtual server. 
    .PARAMETER Disableprimaryondown 
        Continue forwarding the traffic to backup virtual server even after the primary server comes UP from the DOWN state. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Insertvserveripport 
        Insert the virtual server's VIP address and port number in the request header. Available values function as follows: 
        VIPADDR - Header contains the vserver's IP address and port number without any translation. 
        OFF - The virtual IP and port header insertion option is disabled. 
        V6TOV4MAPPING - Header contains the mapped IPv4 address corresponding to the IPv6 address of the vserver and the port number. An IPv6 address can be mapped to a user-specified IPv4 address using the set ns ip6 command. 
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER Vipheader 
        Name of virtual server IP and port header, for use with the VServer IP Port Insertion parameter. 
    .PARAMETER Rtspnat 
        Enable network address translation (NAT) for real-time streaming protocol (RTSP) connections. 
         
        Possible values = ON, OFF 
    .PARAMETER Authenticationhost 
        FQDN of the authentication virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Authentication 
        Authenticate users who request a connection to the content switching virtual server. 
         
        Possible values = ON, OFF 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the content switching virtual server. Can be either the name of an existing expression or an in-line expression. 
    .PARAMETER Listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
         
         
        Maximum value = 100 
    .PARAMETER Authn401 
        Enable HTTP 401-response based authentication. 
         
        Possible values = ON, OFF 
    .PARAMETER Authnvsname 
        Name of authentication virtual server that authenticates the incoming user requests to this content switching virtual server. . 
    .PARAMETER Push 
        Process traffic with the push virtual server that is bound to this content switching virtual server (specified by the Push VServer parameter). The service type of the push virtual server should be either HTTP or SSL. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the client-facing load balancing virtual server. 
    .PARAMETER Pushlabel 
        Expression for extracting the label from the response received from server. This string can be either an existing rule name or an inline expression. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates. 
         
        Possible values = YES, NO 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile containing TCP configuration settings for the virtual server. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile containing HTTP configuration settings for the virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Dbprofilename 
        Name of the DB profile. 
    .PARAMETER Oracleserverversion 
        Oracle server version. 
         
        Possible values = 10G, 11G 
    .PARAMETER Comment 
        Information about this virtual server. 
    .PARAMETER Mssqlserverversion 
        The version of the MSSQL server. 
         
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER L2conn 
        Use L2 Parameters to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Mysqlprotocolversion 
        The protocol version returned by the mysql vserver. 
    .PARAMETER Mysqlserverversion 
        The server version string returned by the mysql vserver. 
    .PARAMETER Mysqlcharacterset 
        The character set returned by the mysql vserver. 
    .PARAMETER Mysqlservercapabilities 
        The server capabilities returned by the mysql vserver. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        The name of the network profile. 
    .PARAMETER Icmpvsrresponse 
        Can be active or passive. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
    .PARAMETER Dtls 
        This option starts/stops the dtls service on the vserver. 
         
        Possible values = ON, OFF 
    .PARAMETER Persistencetype 
        Type of persistence for the virtual server. Available settings function as follows: 
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session. 
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session. 
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session. 
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, NONE 
    .PARAMETER Persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers. 
    .PARAMETER V6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers. 
         
         
        Maximum value = 128 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
         
         
        Maximum value = 1440 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER Persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period for which backup persistence is in effect. 
         
         
        Maximum value = 1440 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case. 
    .PARAMETER Probeport 
        Citrix ADC provides support for external health check of the vserver status. Select port for HTTP/TCP monitring. 
    .PARAMETER Quicprofilename 
        Name of QUIC profile which will be attached to the Content Switching VServer. 
    .PARAMETER Redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect. 
    .PARAMETER Httpsredirecturl 
        URL to which all HTTP traffic received on the port specified in the -redirectFromPort parameter is redirected. 
    .PARAMETER PassThru 
        Return details about the created csvserver item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserver -name <string> -servicetype <string>
        An example how to add csvserver config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver/
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

        [double]$Td,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'SSL', 'TCP', 'FTP', 'RTSP', 'SSL_TCP', 'UDP', 'DNS', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'ANY', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'DIAMETER', 'SSL_DIAMETER', 'DNS_TCP', 'ORACLE', 'SMPP', 'PROXY', 'MONGO', 'MONGO_TLS', 'MQTT', 'MQTT_TLS', 'HTTP_QUIC')]
        [string]$Servicetype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipv46,

        [ValidateSet('GSLB')]
        [string]$Targettype,

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$Dnsrecordtype = 'NSGSLB_IPV4',

        [double]$Persistenceid,

        [string]$Ippattern,

        [string]$Ipmask,

        [double]$Range = '1',

        [ValidateRange(1, 65535)]
        [int]$Port,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipset,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED', 'UPDATEONBACKENDUPDATE')]
        [string]$Stateupdate = 'DISABLED',

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable = 'NO',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Redirecturl,

        [double]$Clttimeout,

        [ValidateSet('RULE', 'URL')]
        [string]$Precedence = 'RULE',

        [ValidateSet('ON', 'OFF')]
        [string]$Casesensitive = 'ON',

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence = 'DISABLED',

        [double]$Sopersistencetimeout = '2',

        [double]$Sothreshold,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$Sobackupaction,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Redirectportrewrite = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Backupvserver,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown = 'DISABLED',

        [ValidateSet('OFF', 'VIPADDR', 'V6TOV4MAPPING')]
        [string]$Insertvserveripport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vipheader,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspnat = 'OFF',

        [ValidateLength(3, 252)]
        [string]$Authenticationhost,

        [ValidateSet('ON', 'OFF')]
        [string]$Authentication = 'OFF',

        [string]$Listenpolicy = '"NONE"',

        [double]$Listenpriority = '101',

        [ValidateSet('ON', 'OFF')]
        [string]$Authn401 = 'OFF',

        [ValidateLength(1, 252)]
        [string]$Authnvsname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Push = 'DISABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Pushvserver,

        [string]$Pushlabel = '"none"',

        [ValidateSet('YES', 'NO')]
        [string]$Pushmulticlients = 'NO',

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Dbprofilename,

        [ValidateSet('10G', '11G')]
        [string]$Oracleserverversion = '10G',

        [string]$Comment,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$Mssqlserverversion = '2008R2',

        [ValidateSet('ON', 'OFF')]
        [string]$L2conn,

        [double]$Mysqlprotocolversion = '10',

        [ValidateLength(1, 31)]
        [string]$Mysqlserverversion,

        [double]$Mysqlcharacterset = '8',

        [double]$Mysqlservercapabilities = '41613',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Icmpvsrresponse = 'PASSIVE',

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Rhistate = 'PASSIVE',

        [string]$Authnprofile,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [ValidateSet('ON', 'OFF')]
        [string]$Dtls = 'OFF',

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'SSLSESSION', 'NONE')]
        [string]$Persistencetype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [double]$V6persistmasklen = '128',

        [double]$Timeout = '2',

        [string]$Cookiename,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencebackup,

        [double]$Backuppersistencetimeout = '2',

        [ValidateRange(1, 65535)]
        [int]$Tcpprobeport,

        [ValidateSet('TCP', 'HTTP')]
        [string]$Probeprotocol,

        [ValidateLength(1, 64)]
        [string]$Probesuccessresponsecode = '"200 OK"',

        [ValidateRange(1, 65535)]
        [int]$Probeport = '0',

        [ValidateLength(1, 255)]
        [string]$Quicprofilename,

        [ValidateRange(1, 65535)]
        [int]$Redirectfromport,

        [string]$Httpsredirecturl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                servicetype    = $servicetype
            }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('ipv46') ) { $payload.Add('ipv46', $ipv46) }
            if ( $PSBoundParameters.ContainsKey('targettype') ) { $payload.Add('targettype', $targettype) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('ippattern') ) { $payload.Add('ippattern', $ippattern) }
            if ( $PSBoundParameters.ContainsKey('ipmask') ) { $payload.Add('ipmask', $ipmask) }
            if ( $PSBoundParameters.ContainsKey('range') ) { $payload.Add('range', $range) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('stateupdate') ) { $payload.Add('stateupdate', $stateupdate) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('casesensitive') ) { $payload.Add('casesensitive', $casesensitive) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('redirectportrewrite') ) { $payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('insertvserveripport') ) { $payload.Add('insertvserveripport', $insertvserveripport) }
            if ( $PSBoundParameters.ContainsKey('vipheader') ) { $payload.Add('vipheader', $vipheader) }
            if ( $PSBoundParameters.ContainsKey('rtspnat') ) { $payload.Add('rtspnat', $rtspnat) }
            if ( $PSBoundParameters.ContainsKey('authenticationhost') ) { $payload.Add('authenticationhost', $authenticationhost) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('authn401') ) { $payload.Add('authn401', $authn401) }
            if ( $PSBoundParameters.ContainsKey('authnvsname') ) { $payload.Add('authnvsname', $authnvsname) }
            if ( $PSBoundParameters.ContainsKey('push') ) { $payload.Add('push', $push) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSBoundParameters.ContainsKey('pushlabel') ) { $payload.Add('pushlabel', $pushlabel) }
            if ( $PSBoundParameters.ContainsKey('pushmulticlients') ) { $payload.Add('pushmulticlients', $pushmulticlients) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('dbprofilename') ) { $payload.Add('dbprofilename', $dbprofilename) }
            if ( $PSBoundParameters.ContainsKey('oracleserverversion') ) { $payload.Add('oracleserverversion', $oracleserverversion) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('mssqlserverversion') ) { $payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('mysqlprotocolversion') ) { $payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlserverversion') ) { $payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlcharacterset') ) { $payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ( $PSBoundParameters.ContainsKey('mysqlservercapabilities') ) { $payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('authnprofile') ) { $payload.Add('authnprofile', $authnprofile) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('dtls') ) { $payload.Add('dtls', $dtls) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSBoundParameters.ContainsKey('probeport') ) { $payload.Add('probeport', $probeport) }
            if ( $PSBoundParameters.ContainsKey('quicprofilename') ) { $payload.Add('quicprofilename', $quicprofilename) }
            if ( $PSBoundParameters.ContainsKey('redirectfromport') ) { $payload.Add('redirectfromport', $redirectfromport) }
            if ( $PSBoundParameters.ContainsKey('httpsredirecturl') ) { $payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ( $PSCmdlet.ShouldProcess("csvserver", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserver -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserver: Finished"
    }
}

function Invoke-NSDeleteCsvserver {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserver -Name <string>
        An example how to delete csvserver config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-NSDeleteCsvserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserver: Finished"
    }
}

function Invoke-NSUpdateCsvserver {
    <#
    .SYNOPSIS
        Update Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER Ipv46 
        IP address of the content switching virtual server. 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cs vserver. 
    .PARAMETER Ippattern 
        IP address pattern, in dotted decimal notation, for identifying packets to be accepted by the virtual server. The IP Mask parameter specifies which part of the destination IP address is matched against the pattern. Mutually exclusive with the IP Address parameter. 
        For example, if the IP pattern assigned to the virtual server is 198.51.100.0 and the IP mask is 255.255.240.0 (a forward mask), the first 20 bits in the destination IP addresses are matched with the first 20 bits in the pattern. The virtual server accepts requests with IP addresses that range from 198.51.96.1 to 198.51.111.254. You can also use a pattern such as 0.0.2.2 and a mask such as 0.0.255.255 (a reverse mask). 
        If a destination IP address matches more than one IP pattern, the pattern with the longest match is selected, and the associated virtual server processes the request. For example, if the virtual servers, vs1 and vs2, have the same IP pattern, 0.0.100.128, but different IP masks of 0.0.255.255 and 0.0.224.255, a destination IP address of 198.51.100.128 has the longest match with the IP pattern of vs1. If a destination IP address matches two or more virtual servers to the same extent, the request is processed by the virtual server whose port number matches the port number in the request. 
    .PARAMETER Ipmask 
        IP mask, in dotted decimal notation, for the IP Pattern parameter. Can have leading or trailing non-zero octets (for example, 255.255.240.0 or 0.0.255.255). Accordingly, the mask specifies whether the first n bits or the last n bits of the destination IP address in a client request are to be matched with the corresponding bits in the IP pattern. The former is called a forward mask. The latter is called a reverse mask. 
    .PARAMETER Stateupdate 
        Enable state updates for a specific content switching virtual server. By default, the Content Switching virtual server is always UP, regardless of the state of the Load Balancing virtual servers bound to it. This parameter interacts with the global setting as follows: 
        Global Level | Vserver Level | Result 
        ENABLED ENABLED ENABLED 
        ENABLED DISABLED ENABLED 
        DISABLED ENABLED ENABLED 
        DISABLED DISABLED DISABLED 
        If you want to enable state updates for only some content switching virtual servers, be sure to disable the state update parameter. 
         
        Possible values = ENABLED, DISABLED, UPDATEONBACKENDUPDATE 
    .PARAMETER Precedence 
        Type of precedence to use for both RULE-based and URL-based policies on the content switching virtual server. With the default (RULE) setting, incoming requests are evaluated against the rule-based content switching policies. If none of the rules match, the URL in the request is evaluated against the URL-based content switching policies. 
         
        Possible values = RULE, URL 
    .PARAMETER Casesensitive 
        Consider case in URLs (for policies that use URLs instead of RULES). For example, with the ON setting, the URLs /a/1.html and /A/1.HTML are treated differently and can have different targets (set by content switching policies). With the OFF setting, /a/1.html and /A/1.HTML are switched to the same target. 
         
        Possible values = ON, OFF 
    .PARAMETER Backupvserver 
        Name of the backup virtual server that you are configuring. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the backup virtual server is created. You can assign a different backup virtual server or rename the existing virtual server. 
    .PARAMETER Redirecturl 
        URL to which traffic is redirected if the virtual server becomes unavailable. The service type of the virtual server should be either HTTP or SSL. 
        Caution: Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
    .PARAMETER Cacheable 
        Use this option to specify whether a virtual server, used for load balancing or content switching, routes requests to the cache redirection virtual server before sending it to the configured servers. 
         
        Possible values = YES, NO 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which the client connection is terminated. The default values are: 
        180 seconds for HTTP/SSL-based services. 
        9000 seconds for other TCP-based services. 
        120 seconds for DNS-based services. 
        120 seconds for other UDP-based services. 
         
        Maximum value = 31536000 
    .PARAMETER Somethod 
        Type of spillover used to divert traffic to the backup virtual server when the primary virtual server reaches the spillover threshold. Connection spillover is based on the number of connections. Bandwidth spillover is based on the total Kbps of incoming and outgoing traffic. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        Maintain source-IP based persistence on primary and backup virtual servers. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Time-out value, in minutes, for spillover persistence. 
         
         
        Maximum value = 1440 
    .PARAMETER Sothreshold 
        Depending on the spillover method, the maximum number of connections or the maximum total bandwidth (Kbps) that a virtual server can handle before spillover occurs. 
         
        Maximum value = 4294967287 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Redirectportrewrite 
        State of port rewrite while performing HTTP redirect. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disableprimaryondown 
        Continue forwarding the traffic to backup virtual server even after the primary server comes UP from the DOWN state. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Insertvserveripport 
        Insert the virtual server's VIP address and port number in the request header. Available values function as follows: 
        VIPADDR - Header contains the vserver's IP address and port number without any translation. 
        OFF - The virtual IP and port header insertion option is disabled. 
        V6TOV4MAPPING - Header contains the mapped IPv4 address corresponding to the IPv6 address of the vserver and the port number. An IPv6 address can be mapped to a user-specified IPv4 address using the set ns ip6 command. 
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER Vipheader 
        Name of virtual server IP and port header, for use with the VServer IP Port Insertion parameter. 
    .PARAMETER Rtspnat 
        Enable network address translation (NAT) for real-time streaming protocol (RTSP) connections. 
         
        Possible values = ON, OFF 
    .PARAMETER Authenticationhost 
        FQDN of the authentication virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Authentication 
        Authenticate users who request a connection to the content switching virtual server. 
         
        Possible values = ON, OFF 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the content switching virtual server. Can be either the name of an existing expression or an in-line expression. 
    .PARAMETER Listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
         
         
        Maximum value = 100 
    .PARAMETER Authn401 
        Enable HTTP 401-response based authentication. 
         
        Possible values = ON, OFF 
    .PARAMETER Authnvsname 
        Name of authentication virtual server that authenticates the incoming user requests to this content switching virtual server. . 
    .PARAMETER Push 
        Process traffic with the push virtual server that is bound to this content switching virtual server (specified by the Push VServer parameter). The service type of the push virtual server should be either HTTP or SSL. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the client-facing load balancing virtual server. 
    .PARAMETER Pushlabel 
        Expression for extracting the label from the response received from server. This string can be either an existing rule name or an inline expression. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates. 
         
        Possible values = YES, NO 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile containing TCP configuration settings for the virtual server. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile containing HTTP configuration settings for the virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Dbprofilename 
        Name of the DB profile. 
    .PARAMETER Comment 
        Information about this virtual server. 
    .PARAMETER L2conn 
        Use L2 Parameters to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Mssqlserverversion 
        The version of the MSSQL server. 
         
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Mysqlprotocolversion 
        The protocol version returned by the mysql vserver. 
    .PARAMETER Oracleserverversion 
        Oracle server version. 
         
        Possible values = 10G, 11G 
    .PARAMETER Mysqlserverversion 
        The server version string returned by the mysql vserver. 
    .PARAMETER Mysqlcharacterset 
        The character set returned by the mysql vserver. 
    .PARAMETER Mysqlservercapabilities 
        The server capabilities returned by the mysql vserver. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        The name of the network profile. 
    .PARAMETER Authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER Icmpvsrresponse 
        Can be active or passive. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
    .PARAMETER Dnsrecordtype 
        . 
         
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Persistenceid 
        . 
         
        Maximum value = 65535 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Ttl 
        . 
    .PARAMETER Backupip 
        . 
    .PARAMETER Cookiedomain 
        . 
    .PARAMETER Cookietimeout 
        . 
         
        Maximum value = 1440 
    .PARAMETER Sitedomainttl 
        . 
    .PARAMETER Dtls 
        This option starts/stops the dtls service on the vserver. 
         
        Possible values = ON, OFF 
    .PARAMETER Persistencetype 
        Type of persistence for the virtual server. Available settings function as follows: 
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session. 
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session. 
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session. 
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, NONE 
    .PARAMETER Persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers. 
    .PARAMETER V6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers. 
         
         
        Maximum value = 128 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
         
         
        Maximum value = 1440 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER Persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period for which backup persistence is in effect. 
         
         
        Maximum value = 1440 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case. 
    .PARAMETER Probeport 
        Citrix ADC provides support for external health check of the vserver status. Select port for HTTP/TCP monitring. 
    .PARAMETER Quicprofilename 
        Name of QUIC profile which will be attached to the Content Switching VServer. 
    .PARAMETER Redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect. 
    .PARAMETER Httpsredirecturl 
        URL to which all HTTP traffic received on the port specified in the -redirectFromPort parameter is redirected. 
    .PARAMETER PassThru 
        Return details about the created csvserver item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCsvserver -name <string>
        An example how to update csvserver config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCsvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver/
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
        [string]$Ipv46,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipset,

        [string]$Ippattern,

        [string]$Ipmask,

        [ValidateSet('ENABLED', 'DISABLED', 'UPDATEONBACKENDUPDATE')]
        [string]$Stateupdate,

        [ValidateSet('RULE', 'URL')]
        [string]$Precedence,

        [ValidateSet('ON', 'OFF')]
        [string]$Casesensitive,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Backupvserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Redirecturl,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable,

        [double]$Clttimeout,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence,

        [double]$Sopersistencetimeout,

        [double]$Sothreshold,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$Sobackupaction,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Redirectportrewrite,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown,

        [ValidateSet('OFF', 'VIPADDR', 'V6TOV4MAPPING')]
        [string]$Insertvserveripport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vipheader,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspnat,

        [ValidateLength(3, 252)]
        [string]$Authenticationhost,

        [ValidateSet('ON', 'OFF')]
        [string]$Authentication,

        [string]$Listenpolicy,

        [double]$Listenpriority,

        [ValidateSet('ON', 'OFF')]
        [string]$Authn401,

        [ValidateLength(1, 252)]
        [string]$Authnvsname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Push,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Pushvserver,

        [string]$Pushlabel,

        [ValidateSet('YES', 'NO')]
        [string]$Pushmulticlients,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Dbprofilename,

        [string]$Comment,

        [ValidateSet('ON', 'OFF')]
        [string]$L2conn,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$Mssqlserverversion,

        [double]$Mysqlprotocolversion,

        [ValidateSet('10G', '11G')]
        [string]$Oracleserverversion,

        [ValidateLength(1, 31)]
        [string]$Mysqlserverversion,

        [double]$Mysqlcharacterset,

        [double]$Mysqlservercapabilities,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [string]$Authnprofile,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Icmpvsrresponse,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Rhistate,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$Dnsrecordtype,

        [double]$Persistenceid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domainname,

        [double]$Ttl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookiedomain,

        [double]$Cookietimeout,

        [double]$Sitedomainttl,

        [ValidateSet('ON', 'OFF')]
        [string]$Dtls,

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'SSLSESSION', 'NONE')]
        [string]$Persistencetype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [double]$V6persistmasklen,

        [double]$Timeout,

        [string]$Cookiename,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencebackup,

        [double]$Backuppersistencetimeout,

        [ValidateRange(1, 65535)]
        [int]$Tcpprobeport,

        [ValidateSet('TCP', 'HTTP')]
        [string]$Probeprotocol,

        [ValidateLength(1, 64)]
        [string]$Probesuccessresponsecode,

        [ValidateRange(1, 65535)]
        [int]$Probeport,

        [ValidateLength(1, 255)]
        [string]$Quicprofilename,

        [ValidateRange(1, 65535)]
        [int]$Redirectfromport,

        [string]$Httpsredirecturl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipv46') ) { $payload.Add('ipv46', $ipv46) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('ippattern') ) { $payload.Add('ippattern', $ippattern) }
            if ( $PSBoundParameters.ContainsKey('ipmask') ) { $payload.Add('ipmask', $ipmask) }
            if ( $PSBoundParameters.ContainsKey('stateupdate') ) { $payload.Add('stateupdate', $stateupdate) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('casesensitive') ) { $payload.Add('casesensitive', $casesensitive) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('redirectportrewrite') ) { $payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('insertvserveripport') ) { $payload.Add('insertvserveripport', $insertvserveripport) }
            if ( $PSBoundParameters.ContainsKey('vipheader') ) { $payload.Add('vipheader', $vipheader) }
            if ( $PSBoundParameters.ContainsKey('rtspnat') ) { $payload.Add('rtspnat', $rtspnat) }
            if ( $PSBoundParameters.ContainsKey('authenticationhost') ) { $payload.Add('authenticationhost', $authenticationhost) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('authn401') ) { $payload.Add('authn401', $authn401) }
            if ( $PSBoundParameters.ContainsKey('authnvsname') ) { $payload.Add('authnvsname', $authnvsname) }
            if ( $PSBoundParameters.ContainsKey('push') ) { $payload.Add('push', $push) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSBoundParameters.ContainsKey('pushlabel') ) { $payload.Add('pushlabel', $pushlabel) }
            if ( $PSBoundParameters.ContainsKey('pushmulticlients') ) { $payload.Add('pushmulticlients', $pushmulticlients) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('dbprofilename') ) { $payload.Add('dbprofilename', $dbprofilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('mssqlserverversion') ) { $payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlprotocolversion') ) { $payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('oracleserverversion') ) { $payload.Add('oracleserverversion', $oracleserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlserverversion') ) { $payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlcharacterset') ) { $payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ( $PSBoundParameters.ContainsKey('mysqlservercapabilities') ) { $payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('authnprofile') ) { $payload.Add('authnprofile', $authnprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('domainname') ) { $payload.Add('domainname', $domainname) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('backupip') ) { $payload.Add('backupip', $backupip) }
            if ( $PSBoundParameters.ContainsKey('cookiedomain') ) { $payload.Add('cookiedomain', $cookiedomain) }
            if ( $PSBoundParameters.ContainsKey('cookietimeout') ) { $payload.Add('cookietimeout', $cookietimeout) }
            if ( $PSBoundParameters.ContainsKey('sitedomainttl') ) { $payload.Add('sitedomainttl', $sitedomainttl) }
            if ( $PSBoundParameters.ContainsKey('dtls') ) { $payload.Add('dtls', $dtls) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSBoundParameters.ContainsKey('probeport') ) { $payload.Add('probeport', $probeport) }
            if ( $PSBoundParameters.ContainsKey('quicprofilename') ) { $payload.Add('quicprofilename', $quicprofilename) }
            if ( $PSBoundParameters.ContainsKey('redirectfromport') ) { $payload.Add('redirectfromport', $redirectfromport) }
            if ( $PSBoundParameters.ContainsKey('httpsredirecturl') ) { $payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ( $PSCmdlet.ShouldProcess("csvserver", "Update Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserver -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCsvserver: Finished"
    }
}

function Invoke-NSUnsetCsvserver {
    <#
    .SYNOPSIS
        Unset Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER Casesensitive 
        Consider case in URLs (for policies that use URLs instead of RULES). For example, with the ON setting, the URLs /a/1.html and /A/1.HTML are treated differently and can have different targets (set by content switching policies). With the OFF setting, /a/1.html and /A/1.HTML are switched to the same target. 
         
        Possible values = ON, OFF 
    .PARAMETER Backupvserver 
        Name of the backup virtual server that you are configuring. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the backup virtual server is created. You can assign a different backup virtual server or rename the existing virtual server. 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which the client connection is terminated. The default values are: 
        180 seconds for HTTP/SSL-based services. 
        9000 seconds for other TCP-based services. 
        120 seconds for DNS-based services. 
        120 seconds for other UDP-based services. 
         
        Maximum value = 31536000 
    .PARAMETER Redirecturl 
        URL to which traffic is redirected if the virtual server becomes unavailable. The service type of the virtual server should be either HTTP or SSL. 
        Caution: Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
    .PARAMETER Authn401 
        Enable HTTP 401-response based authentication. 
         
        Possible values = ON, OFF 
    .PARAMETER Authentication 
        Authenticate users who request a connection to the content switching virtual server. 
         
        Possible values = ON, OFF 
    .PARAMETER Authenticationhost 
        FQDN of the authentication virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Authnvsname 
        Name of authentication virtual server that authenticates the incoming user requests to this content switching virtual server. . 
    .PARAMETER Pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the client-facing load balancing virtual server. 
    .PARAMETER Pushlabel 
        Expression for extracting the label from the response received from server. This string can be either an existing rule name or an inline expression. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile containing TCP configuration settings for the virtual server. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile containing HTTP configuration settings for the virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Dbprofilename 
        Name of the DB profile. 
    .PARAMETER L2conn 
        Use L2 Parameters to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Mysqlprotocolversion 
        The protocol version returned by the mysql vserver. 
    .PARAMETER Mysqlserverversion 
        The server version string returned by the mysql vserver. 
    .PARAMETER Mysqlcharacterset 
        The character set returned by the mysql vserver. 
    .PARAMETER Mysqlservercapabilities 
        The server capabilities returned by the mysql vserver. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        The name of the network profile. 
    .PARAMETER Icmpvsrresponse 
        Can be active or passive. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER Sothreshold 
        Depending on the spillover method, the maximum number of connections or the maximum total bandwidth (Kbps) that a virtual server can handle before spillover occurs. 
         
        Maximum value = 4294967287 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Quicprofilename 
        Name of QUIC profile which will be attached to the Content Switching VServer. 
    .PARAMETER Redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect. 
    .PARAMETER Httpsredirecturl 
        URL to which all HTTP traffic received on the port specified in the -redirectFromPort parameter is redirected. 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cs vserver. 
    .PARAMETER Stateupdate 
        Enable state updates for a specific content switching virtual server. By default, the Content Switching virtual server is always UP, regardless of the state of the Load Balancing virtual servers bound to it. This parameter interacts with the global setting as follows: 
        Global Level | Vserver Level | Result 
        ENABLED ENABLED ENABLED 
        ENABLED DISABLED ENABLED 
        DISABLED ENABLED ENABLED 
        DISABLED DISABLED DISABLED 
        If you want to enable state updates for only some content switching virtual servers, be sure to disable the state update parameter. 
         
        Possible values = ENABLED, DISABLED, UPDATEONBACKENDUPDATE 
    .PARAMETER Precedence 
        Type of precedence to use for both RULE-based and URL-based policies on the content switching virtual server. With the default (RULE) setting, incoming requests are evaluated against the rule-based content switching policies. If none of the rules match, the URL in the request is evaluated against the URL-based content switching policies. 
         
        Possible values = RULE, URL 
    .PARAMETER Cacheable 
        Use this option to specify whether a virtual server, used for load balancing or content switching, routes requests to the cache redirection virtual server before sending it to the configured servers. 
         
        Possible values = YES, NO 
    .PARAMETER Somethod 
        Type of spillover used to divert traffic to the backup virtual server when the primary virtual server reaches the spillover threshold. Connection spillover is based on the number of connections. Bandwidth spillover is based on the total Kbps of incoming and outgoing traffic. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        Maintain source-IP based persistence on primary and backup virtual servers. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Time-out value, in minutes, for spillover persistence. 
         
         
        Maximum value = 1440 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Redirectportrewrite 
        State of port rewrite while performing HTTP redirect. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disableprimaryondown 
        Continue forwarding the traffic to backup virtual server even after the primary server comes UP from the DOWN state. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Insertvserveripport 
        Insert the virtual server's VIP address and port number in the request header. Available values function as follows: 
        VIPADDR - Header contains the vserver's IP address and port number without any translation. 
        OFF - The virtual IP and port header insertion option is disabled. 
        V6TOV4MAPPING - Header contains the mapped IPv4 address corresponding to the IPv6 address of the vserver and the port number. An IPv6 address can be mapped to a user-specified IPv4 address using the set ns ip6 command. 
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER Vipheader 
        Name of virtual server IP and port header, for use with the VServer IP Port Insertion parameter. 
    .PARAMETER Rtspnat 
        Enable network address translation (NAT) for real-time streaming protocol (RTSP) connections. 
         
        Possible values = ON, OFF 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the content switching virtual server. Can be either the name of an existing expression or an in-line expression. 
    .PARAMETER Listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
         
         
        Maximum value = 100 
    .PARAMETER Push 
        Process traffic with the push virtual server that is bound to this content switching virtual server (specified by the Push VServer parameter). The service type of the push virtual server should be either HTTP or SSL. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates. 
         
        Possible values = YES, NO 
    .PARAMETER Comment 
        Information about this virtual server. 
    .PARAMETER Mssqlserverversion 
        The version of the MSSQL server. 
         
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Oracleserverversion 
        Oracle server version. 
         
        Possible values = 10G, 11G 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Dnsrecordtype 
        . 
         
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Persistenceid 
        . 
         
        Maximum value = 65535 
    .PARAMETER Dtls 
        This option starts/stops the dtls service on the vserver. 
         
        Possible values = ON, OFF 
    .PARAMETER Persistencetype 
        Type of persistence for the virtual server. Available settings function as follows: 
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session. 
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session. 
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session. 
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, NONE 
    .PARAMETER Persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers. 
    .PARAMETER V6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers. 
         
         
        Maximum value = 128 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
         
         
        Maximum value = 1440 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER Persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period for which backup persistence is in effect. 
         
         
        Maximum value = 1440 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCsvserver -name <string>
        An example how to unset csvserver config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCsvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Name,

        [Boolean]$casesensitive,

        [Boolean]$backupvserver,

        [Boolean]$clttimeout,

        [Boolean]$redirecturl,

        [Boolean]$authn401,

        [Boolean]$authentication,

        [Boolean]$authenticationhost,

        [Boolean]$authnvsname,

        [Boolean]$pushvserver,

        [Boolean]$pushlabel,

        [Boolean]$tcpprofilename,

        [Boolean]$httpprofilename,

        [Boolean]$dbprofilename,

        [Boolean]$l2conn,

        [Boolean]$mysqlprotocolversion,

        [Boolean]$mysqlserverversion,

        [Boolean]$mysqlcharacterset,

        [Boolean]$mysqlservercapabilities,

        [Boolean]$appflowlog,

        [Boolean]$netprofile,

        [Boolean]$icmpvsrresponse,

        [Boolean]$authnprofile,

        [Boolean]$sothreshold,

        [Boolean]$dnsprofilename,

        [Boolean]$tcpprobeport,

        [Boolean]$probeprotocol,

        [Boolean]$quicprofilename,

        [Boolean]$redirectfromport,

        [Boolean]$httpsredirecturl,

        [Boolean]$ipset,

        [Boolean]$stateupdate,

        [Boolean]$precedence,

        [Boolean]$cacheable,

        [Boolean]$somethod,

        [Boolean]$sopersistence,

        [Boolean]$sopersistencetimeout,

        [Boolean]$sobackupaction,

        [Boolean]$redirectportrewrite,

        [Boolean]$downstateflush,

        [Boolean]$disableprimaryondown,

        [Boolean]$insertvserveripport,

        [Boolean]$vipheader,

        [Boolean]$rtspnat,

        [Boolean]$listenpolicy,

        [Boolean]$listenpriority,

        [Boolean]$push,

        [Boolean]$pushmulticlients,

        [Boolean]$comment,

        [Boolean]$mssqlserverversion,

        [Boolean]$oracleserverversion,

        [Boolean]$rhistate,

        [Boolean]$dnsrecordtype,

        [Boolean]$persistenceid,

        [Boolean]$dtls,

        [Boolean]$persistencetype,

        [Boolean]$persistmask,

        [Boolean]$v6persistmasklen,

        [Boolean]$timeout,

        [Boolean]$cookiename,

        [Boolean]$persistencebackup,

        [Boolean]$backuppersistencetimeout,

        [Boolean]$probesuccessresponsecode 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('casesensitive') ) { $payload.Add('casesensitive', $casesensitive) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('authn401') ) { $payload.Add('authn401', $authn401) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('authenticationhost') ) { $payload.Add('authenticationhost', $authenticationhost) }
            if ( $PSBoundParameters.ContainsKey('authnvsname') ) { $payload.Add('authnvsname', $authnvsname) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSBoundParameters.ContainsKey('pushlabel') ) { $payload.Add('pushlabel', $pushlabel) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('dbprofilename') ) { $payload.Add('dbprofilename', $dbprofilename) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('mysqlprotocolversion') ) { $payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlserverversion') ) { $payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlcharacterset') ) { $payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ( $PSBoundParameters.ContainsKey('mysqlservercapabilities') ) { $payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('authnprofile') ) { $payload.Add('authnprofile', $authnprofile) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('quicprofilename') ) { $payload.Add('quicprofilename', $quicprofilename) }
            if ( $PSBoundParameters.ContainsKey('redirectfromport') ) { $payload.Add('redirectfromport', $redirectfromport) }
            if ( $PSBoundParameters.ContainsKey('httpsredirecturl') ) { $payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('stateupdate') ) { $payload.Add('stateupdate', $stateupdate) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('redirectportrewrite') ) { $payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('insertvserveripport') ) { $payload.Add('insertvserveripport', $insertvserveripport) }
            if ( $PSBoundParameters.ContainsKey('vipheader') ) { $payload.Add('vipheader', $vipheader) }
            if ( $PSBoundParameters.ContainsKey('rtspnat') ) { $payload.Add('rtspnat', $rtspnat) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('push') ) { $payload.Add('push', $push) }
            if ( $PSBoundParameters.ContainsKey('pushmulticlients') ) { $payload.Add('pushmulticlients', $pushmulticlients) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('mssqlserverversion') ) { $payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('oracleserverversion') ) { $payload.Add('oracleserverversion', $oracleserverversion) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('dtls') ) { $payload.Add('dtls', $dtls) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type csvserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCsvserver: Finished"
    }
}

function Invoke-NSEnableCsvserver {
    <#
    .SYNOPSIS
        Enable Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-NSEnableCsvserver -name <string>
        An example how to enable csvserver config Object(s).
    .NOTES
        File Name : Invoke-NSEnableCsvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver/
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
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-NSEnableCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableCsvserver: Finished"
    }
}

function Invoke-NSDisableCsvserver {
    <#
    .SYNOPSIS
        Disable Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-NSDisableCsvserver -name <string>
        An example how to disable csvserver config Object(s).
    .NOTES
        File Name : Invoke-NSDisableCsvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver/
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
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-NSDisableCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableCsvserver: Finished"
    }
}

function Invoke-NSRenameCsvserver {
    <#
    .SYNOPSIS
        Rename Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER Newname 
        New name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created csvserver item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCsvserver -name <string> -newname <string>
        An example how to rename csvserver config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCsvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver/
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("csvserver", "Rename Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserver -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCsvserver: Finished"
    }
}

function Invoke-NSGetCsvserver {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER GetAll 
        Retrieve all csvserver object(s).
    .PARAMETER Count
        If specified, the count of the csvserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserver -GetAll 
        Get all csvserver data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserver -Count 
        Get the number of csvserver objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserver -name <string>
        Get csvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserver -Filter @{ 'name'='<value>' }
        Get csvserver data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-NSGetCsvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all csvserver objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserver: Ended"
    }
}

function Invoke-NSAddCsvserverAnalyticsprofileBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound to the LB vserver. 
    .PARAMETER PassThru 
        Return details about the created csvserver_analyticsprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverAnalyticsprofileBinding -name <string>
        An example how to add csvserver_analyticsprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverAnalyticsprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_analyticsprofile_binding/
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

        [string]$Analyticsprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverAnalyticsprofileBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("csvserver_analyticsprofile_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_analyticsprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverAnalyticsprofileBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverAnalyticsprofileBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverAnalyticsprofileBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound to the LB vserver.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverAnalyticsprofileBinding -Name <string>
        An example how to delete csvserver_analyticsprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverAnalyticsprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_analyticsprofile_binding/
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
        [string]$Name,

        [string]$Analyticsprofile 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverAnalyticsprofileBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Analyticsprofile') ) { $arguments.Add('analyticsprofile', $Analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverAnalyticsprofileBinding: Finished"
    }
}

function Invoke-NSGetCsvserverAnalyticsprofileBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_analyticsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_analyticsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAnalyticsprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAnalyticsprofileBinding -GetAll 
        Get all csvserver_analyticsprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAnalyticsprofileBinding -Count 
        Get the number of csvserver_analyticsprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAnalyticsprofileBinding -name <string>
        Get csvserver_analyticsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAnalyticsprofileBinding -Filter @{ 'name'='<value>' }
        Get csvserver_analyticsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverAnalyticsprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_analyticsprofile_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverAnalyticsprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_analyticsprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_analyticsprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_analyticsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_analyticsprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverAnalyticsprofileBinding: Ended"
    }
}

function Invoke-NSAddCsvserverAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_appflowpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverAppflowpolicyBinding -name <string>
        An example how to add csvserver_appflowpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverAppflowpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_appflowpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverAppflowpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_appflowpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_appflowpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverAppflowpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverAppflowpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverAppflowpolicyBinding -Name <string>
        An example how to delete csvserver_appflowpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverAppflowpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_appflowpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverAppflowpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverAppflowpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAppflowpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAppflowpolicyBinding -GetAll 
        Get all csvserver_appflowpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAppflowpolicyBinding -Count 
        Get the number of csvserver_appflowpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAppflowpolicyBinding -name <string>
        Get csvserver_appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAppflowpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverAppflowpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_appflowpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverAppflowpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_appflowpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_appflowpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_appflowpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverAppflowpolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverAppfwpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_appfwpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverAppfwpolicyBinding -name <string>
        An example how to add csvserver_appfwpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverAppfwpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_appfwpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverAppfwpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_appfwpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_appfwpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverAppfwpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverAppfwpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverAppfwpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverAppfwpolicyBinding -Name <string>
        An example how to delete csvserver_appfwpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverAppfwpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_appfwpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverAppfwpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverAppfwpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverAppfwpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_appfwpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_appfwpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAppfwpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAppfwpolicyBinding -GetAll 
        Get all csvserver_appfwpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAppfwpolicyBinding -Count 
        Get the number of csvserver_appfwpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAppfwpolicyBinding -name <string>
        Get csvserver_appfwpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAppfwpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_appfwpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverAppfwpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_appfwpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverAppfwpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_appfwpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_appfwpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_appfwpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_appfwpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_appfwpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverAppfwpolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverAppqoepolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_appqoepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverAppqoepolicyBinding -name <string>
        An example how to add csvserver_appqoepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverAppqoepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_appqoepolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverAppqoepolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_appqoepolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_appqoepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverAppqoepolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverAppqoepolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverAppqoepolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverAppqoepolicyBinding -Name <string>
        An example how to delete csvserver_appqoepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverAppqoepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_appqoepolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverAppqoepolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverAppqoepolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverAppqoepolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_appqoepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_appqoepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAppqoepolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAppqoepolicyBinding -GetAll 
        Get all csvserver_appqoepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAppqoepolicyBinding -Count 
        Get the number of csvserver_appqoepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAppqoepolicyBinding -name <string>
        Get csvserver_appqoepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAppqoepolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_appqoepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverAppqoepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_appqoepolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverAppqoepolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_appqoepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_appqoepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_appqoepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_appqoepolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverAppqoepolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverAuditnslogpolicyBinding -name <string>
        An example how to add csvserver_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverAuditnslogpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_auditnslogpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_auditnslogpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverAuditnslogpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverAuditnslogpolicyBinding -Name <string>
        An example how to delete csvserver_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverAuditnslogpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_auditnslogpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAuditnslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAuditnslogpolicyBinding -GetAll 
        Get all csvserver_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAuditnslogpolicyBinding -Count 
        Get the number of csvserver_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAuditnslogpolicyBinding -name <string>
        Get csvserver_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAuditnslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverAuditnslogpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverAuditnslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_auditnslogpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_auditnslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverAuditnslogpolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverAuditsyslogpolicyBinding -name <string>
        An example how to add csvserver_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverAuditsyslogpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_auditsyslogpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_auditsyslogpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverAuditsyslogpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverAuditsyslogpolicyBinding -Name <string>
        An example how to delete csvserver_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverAuditsyslogpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_auditsyslogpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAuditsyslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAuditsyslogpolicyBinding -GetAll 
        Get all csvserver_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAuditsyslogpolicyBinding -Count 
        Get the number of csvserver_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAuditsyslogpolicyBinding -name <string>
        Get csvserver_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAuditsyslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverAuditsyslogpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverAuditsyslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_auditsyslogpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverAuditsyslogpolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_authorizationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverAuthorizationpolicyBinding -name <string>
        An example how to add csvserver_authorizationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverAuthorizationpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_authorizationpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverAuthorizationpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_authorizationpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_authorizationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverAuthorizationpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverAuthorizationpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverAuthorizationpolicyBinding -Name <string>
        An example how to delete csvserver_authorizationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverAuthorizationpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_authorizationpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverAuthorizationpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverAuthorizationpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverAuthorizationpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_authorizationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_authorizationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAuthorizationpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAuthorizationpolicyBinding -GetAll 
        Get all csvserver_authorizationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverAuthorizationpolicyBinding -Count 
        Get the number of csvserver_authorizationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAuthorizationpolicyBinding -name <string>
        Get csvserver_authorizationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverAuthorizationpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_authorizationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverAuthorizationpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_authorizationpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverAuthorizationpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_authorizationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_authorizationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_authorizationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_authorizationpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_authorizationpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverAuthorizationpolicyBinding: Ended"
    }
}

function Invoke-NSGetCsvserverBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to csvserver.
    .PARAMETER Name 
        Name of a content switching virtual server for which to display information, including the policies bound to the virtual server. To display a list of all configured Content Switching virtual servers, do not specify a value for this parameter. 
    .PARAMETER GetAll 
        Retrieve all csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverBinding -GetAll 
        Get all csvserver_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverBinding -name <string>
        Get csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverBinding -Filter @{ 'name'='<value>' }
        Get csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverBinding: Ended"
    }
}

function Invoke-NSAddCsvserverBotpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_botpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverBotpolicyBinding -name <string>
        An example how to add csvserver_botpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverBotpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_botpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverBotpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_botpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_botpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverBotpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverBotpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverBotpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverBotpolicyBinding -Name <string>
        An example how to delete csvserver_botpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverBotpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_botpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverBotpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverBotpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverBotpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_botpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_botpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverBotpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverBotpolicyBinding -GetAll 
        Get all csvserver_botpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverBotpolicyBinding -Count 
        Get the number of csvserver_botpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverBotpolicyBinding -name <string>
        Get csvserver_botpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverBotpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_botpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverBotpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_botpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverBotpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_botpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_botpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_botpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_botpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_botpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverBotpolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverCachepolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_cachepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverCachepolicyBinding -name <string>
        An example how to add csvserver_cachepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverCachepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_cachepolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverCachepolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_cachepolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_cachepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverCachepolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverCachepolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverCachepolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverCachepolicyBinding -Name <string>
        An example how to delete csvserver_cachepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverCachepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_cachepolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverCachepolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverCachepolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverCachepolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_cachepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_cachepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverCachepolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverCachepolicyBinding -GetAll 
        Get all csvserver_cachepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverCachepolicyBinding -Count 
        Get the number of csvserver_cachepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverCachepolicyBinding -name <string>
        Get csvserver_cachepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverCachepolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_cachepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverCachepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_cachepolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverCachepolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_cachepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_cachepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_cachepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_cachepolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_cachepolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverCachepolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverCmppolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_cmppolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverCmppolicyBinding -name <string>
        An example how to add csvserver_cmppolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverCmppolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_cmppolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverCmppolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_cmppolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_cmppolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverCmppolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverCmppolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverCmppolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverCmppolicyBinding -Name <string>
        An example how to delete csvserver_cmppolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverCmppolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_cmppolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverCmppolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverCmppolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverCmppolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_cmppolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_cmppolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverCmppolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverCmppolicyBinding -GetAll 
        Get all csvserver_cmppolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverCmppolicyBinding -Count 
        Get the number of csvserver_cmppolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverCmppolicyBinding -name <string>
        Get csvserver_cmppolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverCmppolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_cmppolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverCmppolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_cmppolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverCmppolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_cmppolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_cmppolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_cmppolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_cmppolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_cmppolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverCmppolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverContentinspectionpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_contentinspectionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverContentinspectionpolicyBinding -name <string>
        An example how to add csvserver_contentinspectionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverContentinspectionpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_contentinspectionpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverContentinspectionpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_contentinspectionpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_contentinspectionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverContentinspectionpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverContentinspectionpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverContentinspectionpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverContentinspectionpolicyBinding -Name <string>
        An example how to delete csvserver_contentinspectionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverContentinspectionpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_contentinspectionpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverContentinspectionpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverContentinspectionpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverContentinspectionpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_contentinspectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_contentinspectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverContentinspectionpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverContentinspectionpolicyBinding -GetAll 
        Get all csvserver_contentinspectionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverContentinspectionpolicyBinding -Count 
        Get the number of csvserver_contentinspectionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverContentinspectionpolicyBinding -name <string>
        Get csvserver_contentinspectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverContentinspectionpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_contentinspectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverContentinspectionpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverContentinspectionpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_contentinspectionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_contentinspectionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_contentinspectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_contentinspectionpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_contentinspectionpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverContentinspectionpolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverCspolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        target vserver name. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_cspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverCspolicyBinding -name <string>
        An example how to add csvserver_cspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverCspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_cspolicy_binding/
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

        [string]$Policyname,

        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverCspolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_cspolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_cspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverCspolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverCspolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverCspolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverCspolicyBinding -Name <string>
        An example how to delete csvserver_cspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverCspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_cspolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverCspolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverCspolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverCspolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_cspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_cspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverCspolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverCspolicyBinding -GetAll 
        Get all csvserver_cspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverCspolicyBinding -Count 
        Get the number of csvserver_cspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverCspolicyBinding -name <string>
        Get csvserver_cspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverCspolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_cspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverCspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_cspolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverCspolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_cspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_cspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_cspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_cspolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_cspolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverCspolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverDomainBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the domain that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Ttl 
        . 
    .PARAMETER Backupip 
        . 
    .PARAMETER Cookiedomain 
        . 
    .PARAMETER Cookietimeout 
        . 
         
        Maximum value = 1440 
    .PARAMETER Sitedomainttl 
        . 
    .PARAMETER PassThru 
        Return details about the created csvserver_domain_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverDomainBinding -name <string>
        An example how to add csvserver_domain_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverDomainBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_domain_binding/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domainname,

        [double]$Ttl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookiedomain,

        [double]$Cookietimeout,

        [double]$Sitedomainttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverDomainBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('domainname') ) { $payload.Add('domainname', $domainname) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('backupip') ) { $payload.Add('backupip', $backupip) }
            if ( $PSBoundParameters.ContainsKey('cookiedomain') ) { $payload.Add('cookiedomain', $cookiedomain) }
            if ( $PSBoundParameters.ContainsKey('cookietimeout') ) { $payload.Add('cookietimeout', $cookietimeout) }
            if ( $PSBoundParameters.ContainsKey('sitedomainttl') ) { $payload.Add('sitedomainttl', $sitedomainttl) }
            if ( $PSCmdlet.ShouldProcess("csvserver_domain_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_domain_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverDomainBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverDomainBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverDomainBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the domain that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverDomainBinding -Name <string>
        An example how to delete csvserver_domain_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverDomainBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_domain_binding/
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
        [string]$Name,

        [string]$Domainname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverDomainBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Domainname') ) { $arguments.Add('domainname', $Domainname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverDomainBinding: Finished"
    }
}

function Invoke-NSGetCsvserverDomainBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the domain that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_domain_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_domain_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverDomainBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverDomainBinding -GetAll 
        Get all csvserver_domain_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverDomainBinding -Count 
        Get the number of csvserver_domain_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverDomainBinding -name <string>
        Get csvserver_domain_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverDomainBinding -Filter @{ 'name'='<value>' }
        Get csvserver_domain_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverDomainBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_domain_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverDomainBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_domain_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_domain_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_domain_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_domain_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_domain_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverDomainBinding: Ended"
    }
}

function Invoke-NSAddCsvserverFeopolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_feopolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverFeopolicyBinding -name <string>
        An example how to add csvserver_feopolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverFeopolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_feopolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverFeopolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_feopolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_feopolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverFeopolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverFeopolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverFeopolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverFeopolicyBinding -Name <string>
        An example how to delete csvserver_feopolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverFeopolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_feopolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverFeopolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverFeopolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverFeopolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_feopolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_feopolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverFeopolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverFeopolicyBinding -GetAll 
        Get all csvserver_feopolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverFeopolicyBinding -Count 
        Get the number of csvserver_feopolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverFeopolicyBinding -name <string>
        Get csvserver_feopolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverFeopolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_feopolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverFeopolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_feopolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverFeopolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_feopolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_feopolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_feopolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_feopolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_feopolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverFeopolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverGslbvserverBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Vserver 
        Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1. 
    .PARAMETER PassThru 
        Return details about the created csvserver_gslbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverGslbvserverBinding -name <string>
        An example how to add csvserver_gslbvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverGslbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_gslbvserver_binding/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverGslbvserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("csvserver_gslbvserver_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_gslbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverGslbvserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverGslbvserverBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverGslbvserverBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Vserver 
        Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverGslbvserverBinding -Name <string>
        An example how to delete csvserver_gslbvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverGslbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_gslbvserver_binding/
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
        [string]$Name,

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverGslbvserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverGslbvserverBinding: Finished"
    }
}

function Invoke-NSGetCsvserverGslbvserverBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_gslbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_gslbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverGslbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverGslbvserverBinding -GetAll 
        Get all csvserver_gslbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverGslbvserverBinding -Count 
        Get the number of csvserver_gslbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverGslbvserverBinding -name <string>
        Get csvserver_gslbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverGslbvserverBinding -Filter @{ 'name'='<value>' }
        Get csvserver_gslbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverGslbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_gslbvserver_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverGslbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_gslbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_gslbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_gslbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_gslbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_gslbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverGslbvserverBinding: Ended"
    }
}

function Invoke-NSAddCsvserverLbvserverBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Lbvserver 
        Name of the default lb vserver bound. Use this param for Default binding only. For Example: bind cs vserver cs1 -lbvserver lb1. 
    .PARAMETER Targetvserver 
        The virtual server name (created with the add lb vserver command) to which content will be switched. 
    .PARAMETER PassThru 
        Return details about the created csvserver_lbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverLbvserverBinding -name <string>
        An example how to add csvserver_lbvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverLbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_lbvserver_binding/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Lbvserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverLbvserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('lbvserver') ) { $payload.Add('lbvserver', $lbvserver) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSCmdlet.ShouldProcess("csvserver_lbvserver_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_lbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverLbvserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverLbvserverBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverLbvserverBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Lbvserver 
        Name of the default lb vserver bound. Use this param for Default binding only. For Example: bind cs vserver cs1 -lbvserver lb1.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverLbvserverBinding -Name <string>
        An example how to delete csvserver_lbvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverLbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_lbvserver_binding/
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
        [string]$Name,

        [string]$Lbvserver 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverLbvserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Lbvserver') ) { $arguments.Add('lbvserver', $Lbvserver) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverLbvserverBinding: Finished"
    }
}

function Invoke-NSGetCsvserverLbvserverBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverLbvserverBinding -GetAll 
        Get all csvserver_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverLbvserverBinding -Count 
        Get the number of csvserver_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverLbvserverBinding -name <string>
        Get csvserver_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverLbvserverBinding -Filter @{ 'name'='<value>' }
        Get csvserver_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverLbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverLbvserverBinding: Ended"
    }
}

function Invoke-NSAddCsvserverResponderpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_responderpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverResponderpolicyBinding -name <string>
        An example how to add csvserver_responderpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverResponderpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_responderpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverResponderpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_responderpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_responderpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverResponderpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverResponderpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverResponderpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverResponderpolicyBinding -Name <string>
        An example how to delete csvserver_responderpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverResponderpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_responderpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverResponderpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverResponderpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverResponderpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_responderpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_responderpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverResponderpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverResponderpolicyBinding -GetAll 
        Get all csvserver_responderpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverResponderpolicyBinding -Count 
        Get the number of csvserver_responderpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverResponderpolicyBinding -name <string>
        Get csvserver_responderpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverResponderpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_responderpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverResponderpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_responderpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverResponderpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_responderpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_responderpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_responderpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_responderpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_responderpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverResponderpolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverRewritepolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_rewritepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverRewritepolicyBinding -name <string>
        An example how to add csvserver_rewritepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverRewritepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_rewritepolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverRewritepolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_rewritepolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_rewritepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverRewritepolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverRewritepolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverRewritepolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverRewritepolicyBinding -Name <string>
        An example how to delete csvserver_rewritepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverRewritepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_rewritepolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverRewritepolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverRewritepolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverRewritepolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_rewritepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_rewritepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverRewritepolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverRewritepolicyBinding -GetAll 
        Get all csvserver_rewritepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverRewritepolicyBinding -Count 
        Get the number of csvserver_rewritepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverRewritepolicyBinding -name <string>
        Get csvserver_rewritepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverRewritepolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_rewritepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverRewritepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_rewritepolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverRewritepolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_rewritepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_rewritepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_rewritepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_rewritepolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_rewritepolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverRewritepolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverSpilloverpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_spilloverpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverSpilloverpolicyBinding -name <string>
        An example how to add csvserver_spilloverpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverSpilloverpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_spilloverpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverSpilloverpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_spilloverpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_spilloverpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverSpilloverpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverSpilloverpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverSpilloverpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverSpilloverpolicyBinding -Name <string>
        An example how to delete csvserver_spilloverpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverSpilloverpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_spilloverpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverSpilloverpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverSpilloverpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverSpilloverpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_spilloverpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_spilloverpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverSpilloverpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverSpilloverpolicyBinding -GetAll 
        Get all csvserver_spilloverpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverSpilloverpolicyBinding -Count 
        Get the number of csvserver_spilloverpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverSpilloverpolicyBinding -name <string>
        Get csvserver_spilloverpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverSpilloverpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_spilloverpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverSpilloverpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_spilloverpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverSpilloverpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_spilloverpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_spilloverpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_spilloverpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverSpilloverpolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverTmtrafficpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_tmtrafficpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverTmtrafficpolicyBinding -name <string>
        An example how to add csvserver_tmtrafficpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverTmtrafficpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_tmtrafficpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverTmtrafficpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_tmtrafficpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_tmtrafficpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverTmtrafficpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverTmtrafficpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverTmtrafficpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverTmtrafficpolicyBinding -Name <string>
        An example how to delete csvserver_tmtrafficpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverTmtrafficpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_tmtrafficpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverTmtrafficpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverTmtrafficpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverTmtrafficpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_tmtrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_tmtrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverTmtrafficpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverTmtrafficpolicyBinding -GetAll 
        Get all csvserver_tmtrafficpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverTmtrafficpolicyBinding -Count 
        Get the number of csvserver_tmtrafficpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverTmtrafficpolicyBinding -name <string>
        Get csvserver_tmtrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverTmtrafficpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_tmtrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverTmtrafficpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_tmtrafficpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverTmtrafficpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_tmtrafficpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_tmtrafficpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_tmtrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_tmtrafficpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_tmtrafficpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverTmtrafficpolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverTransformpolicyBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_transformpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverTransformpolicyBinding -name <string>
        An example how to add csvserver_transformpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverTransformpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_transformpolicy_binding/
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

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverTransformpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_transformpolicy_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_transformpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverTransformpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverTransformpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverTransformpolicyBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverTransformpolicyBinding -Name <string>
        An example how to delete csvserver_transformpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverTransformpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_transformpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverTransformpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverTransformpolicyBinding: Finished"
    }
}

function Invoke-NSGetCsvserverTransformpolicyBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_transformpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_transformpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverTransformpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverTransformpolicyBinding -GetAll 
        Get all csvserver_transformpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverTransformpolicyBinding -Count 
        Get the number of csvserver_transformpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverTransformpolicyBinding -name <string>
        Get csvserver_transformpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverTransformpolicyBinding -Filter @{ 'name'='<value>' }
        Get csvserver_transformpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverTransformpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_transformpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverTransformpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_transformpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_transformpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_transformpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_transformpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_transformpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverTransformpolicyBinding: Ended"
    }
}

function Invoke-NSAddCsvserverVpnvserverBinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Vserver 
        Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1. 
    .PARAMETER PassThru 
        Return details about the created csvserver_vpnvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCsvserverVpnvserverBinding -name <string>
        An example how to add csvserver_vpnvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCsvserverVpnvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_vpnvserver_binding/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCsvserverVpnvserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("csvserver_vpnvserver_binding", "Add Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_vpnvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCsvserverVpnvserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCsvserverVpnvserverBinding: Finished"
    }
}

function Invoke-NSDeleteCsvserverVpnvserverBinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object.
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Vserver 
        Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCsvserverVpnvserverBinding -Name <string>
        An example how to delete csvserver_vpnvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCsvserverVpnvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_vpnvserver_binding/
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
        [string]$Name,

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCsvserverVpnvserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCsvserverVpnvserverBinding: Finished"
    }
}

function Invoke-NSGetCsvserverVpnvserverBinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration. Content Switching feature that enables you to direct traffic to servers on the basis of content. config object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverVpnvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverVpnvserverBinding -GetAll 
        Get all csvserver_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCsvserverVpnvserverBinding -Count 
        Get the number of csvserver_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverVpnvserverBinding -name <string>
        Get csvserver_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCsvserverVpnvserverBinding -Filter @{ 'name'='<value>' }
        Get csvserver_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCsvserverVpnvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cs/csvserver_vpnvserver_binding/
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
        Write-Verbose "Invoke-NSGetCsvserverVpnvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_vpnvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCsvserverVpnvserverBinding: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCD78Ahm43b1Ejdq
# 00Y8B2iuvKjo4oiBBKFSzU5DD3K7gKCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQguNeGvEnlNqHbM9L1fd4to4dx0XAainXCOZ3wIdlKL+kwDQYJKoZIhvcNAQEB
# BQAEggEAD5DN7lX4STWBNhm3MxFzx2F5ZLo2xUU/jglKtpOgaYjjJ0WHjzRK2XqY
# 5T8//iQSjBhdpMqeZpxIkSoDGqe+TxjmJrdzCbVo3eLQa6d0lNEoBtaZR6pgTYmO
# W9aFTQh+2kKM15JMqJCTg9DabJXfGj7p6/xbUWZhxy7FYSmKzPE9s0yjJ42ZumdD
# AvqvruJiRDS5ycsA4qVXcbkT3FCury9pPne3kVBxuAug/EaCXvWtwuycZB3pfoLT
# 75PixmR76OFReLUiMFQoRmCjF/qeeibHx4vTyLz7bBoS9o+8aqidRZ2MfnBfevBP
# UCjzxzLrqBm5MBA3oFOy9KlN2cy5Ww==
# SIG # End signature block
