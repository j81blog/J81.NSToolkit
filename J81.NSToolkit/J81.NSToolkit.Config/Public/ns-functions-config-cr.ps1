function Invoke-NSGetCraction {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Configuration for cache redirection action resource.
    .PARAMETER Name 
        Name of the action for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all craction object(s).
    .PARAMETER Count
        If specified, the count of the craction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCraction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCraction -GetAll 
        Get all craction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCraction -Count 
        Get the number of craction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCraction -name <string>
        Get craction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCraction -Filter @{ 'name'='<value>' }
        Get craction data with a filter.
    .NOTES
        File Name : Invoke-NSGetCraction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/craction/
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
        Write-Verbose "Invoke-NSGetCraction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all craction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type craction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for craction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type craction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving craction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type craction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving craction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type craction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving craction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type craction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCraction: Ended"
    }
}

function Invoke-NSAddCrpolicy {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the built-in cache redirection action: CACHE/ORIGIN. 
    .PARAMETER Logaction 
        The log action associated with the cache redirection policy. 
    .PARAMETER PassThru 
        Return details about the created crpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrpolicy -policyname <string> -rule <string>
        An example how to add crpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crpolicy/
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
        Write-Verbose "Invoke-NSAddCrpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                rule                 = $rule
            }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("crpolicy", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type crpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrpolicy: Finished"
    }
}

function Invoke-NSDeleteCrpolicy {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrpolicy -Policyname <string>
        An example how to delete crpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crpolicy/
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
        Write-Verbose "Invoke-NSDeleteCrpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$policyname", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crpolicy -NitroPath nitro/v1/config -Resource $policyname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrpolicy: Finished"
    }
}

function Invoke-NSUpdateCrpolicy {
    <#
    .SYNOPSIS
        Update Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the built-in cache redirection action: CACHE/ORIGIN. 
    .PARAMETER Logaction 
        The log action associated with the cache redirection policy. 
    .PARAMETER PassThru 
        Return details about the created crpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCrpolicy -policyname <string>
        An example how to update crpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCrpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crpolicy/
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
        Write-Verbose "Invoke-NSUpdateCrpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("crpolicy", "Update Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCrpolicy: Finished"
    }
}

function Invoke-NSUnsetCrpolicy {
    <#
    .SYNOPSIS
        Unset Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Logaction 
        The log action associated with the cache redirection policy.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCrpolicy -policyname <string>
        An example how to unset crpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCrpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crpolicy
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
        Write-Verbose "Invoke-NSUnsetCrpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$policyname", "Unset Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type crpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCrpolicy: Finished"
    }
}

function Invoke-NSRenameCrpolicy {
    <#
    .SYNOPSIS
        Rename Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Newname 
        The new name of the content switching policy. 
    .PARAMETER PassThru 
        Return details about the created crpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCrpolicy -policyname <string> -newname <string>
        An example how to rename crpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCrpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crpolicy/
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
        Write-Verbose "Invoke-NSRenameCrpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                newname              = $newname
            }

            if ( $PSCmdlet.ShouldProcess("crpolicy", "Rename Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type crpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCrpolicy: Finished"
    }
}

function Invoke-NSGetCrpolicy {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER GetAll 
        Retrieve all crpolicy object(s).
    .PARAMETER Count
        If specified, the count of the crpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrpolicy -GetAll 
        Get all crpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrpolicy -Count 
        Get the number of crpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrpolicy -name <string>
        Get crpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrpolicy -Filter @{ 'name'='<value>' }
        Get crpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crpolicy/
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
        Write-Verbose "Invoke-NSGetCrpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all crpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crpolicy configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrpolicy: Ended"
    }
}

function Invoke-NSGetCrpolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to crpolicy.
    .PARAMETER Policyname 
        Name of the cache redirection policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all crpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrpolicyBinding -GetAll 
        Get all crpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrpolicyBinding -name <string>
        Get crpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrpolicyBinding -Filter @{ 'name'='<value>' }
        Get crpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crpolicy_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrpolicyBinding: Ended"
    }
}

function Invoke-NSGetCrpolicyCrvserverBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to crpolicy.
    .PARAMETER Policyname 
        Name of the cache redirection policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all crpolicy_crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the crpolicy_crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrpolicyCrvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrpolicyCrvserverBinding -GetAll 
        Get all crpolicy_crvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrpolicyCrvserverBinding -Count 
        Get the number of crpolicy_crvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrpolicyCrvserverBinding -name <string>
        Get crpolicy_crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrpolicyCrvserverBinding -Filter @{ 'name'='<value>' }
        Get crpolicy_crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrpolicyCrvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crpolicy_crvserver_binding/
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
        Write-Verbose "Invoke-NSGetCrpolicyCrvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crpolicy_crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crpolicy_crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crpolicy_crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy_crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crpolicy_crvserver_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy_crvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crpolicy_crvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crpolicy_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrpolicyCrvserverBinding: Ended"
    }
}

function Invoke-NSAddCrvserver {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
         
        Maximum value = 4094 
    .PARAMETER Servicetype 
        Protocol (type of service) handled by the virtual server. 
        Possible values = HTTP, SSL, NNTP, HDX 
    .PARAMETER Ipv46 
        IPv4 or IPv6 address of the cache redirection virtual server. Usually a public IP address. Clients send connection requests to this IP address. 
        Note: For a transparent cache redirection virtual server, use an asterisk (*) to specify a wildcard virtual server address. 
    .PARAMETER Port 
        Port number of the virtual server. 
         
         
        Maximum value = 65534 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cr vserver. 
    .PARAMETER Range 
        Number of consecutive IP addresses, starting with the address specified by the IPAddress parameter, to include in a range of addresses assigned to this virtual server. 
         
         
        Maximum value = 254 
    .PARAMETER Cachetype 
        Mode of operation for the cache redirection virtual server. Available settings function as follows: 
        * TRANSPARENT - Intercept all traffic flowing to the appliance and apply cache redirection policies to determine whether content should be served from the cache or from the origin server. 
        * FORWARD - Resolve the hostname of the incoming request, by using a DNS server, and forward requests for non-cacheable content to the resolved origin servers. Cacheable requests are sent to the configured cache servers. 
        * REVERSE - Configure reverse proxy caches for specific origin servers. Incoming traffic directed to the reverse proxy can either be served from a cache server or be sent to the origin server with or without modification to the URL. 
        The default value for cache type is TRANSPARENT if service is HTTP or SSL whereas the default cache type is FORWARD if the service is HDX. 
        Possible values = TRANSPARENT, REVERSE, FORWARD 
    .PARAMETER Redirect 
        Type of cache server to which to redirect HTTP requests. Available settings function as follows: 
        * CACHE - Direct all requests to the cache. 
        * POLICY - Apply the cache redirection policy to determine whether the request should be directed to the cache or to the origin. 
        * ORIGIN - Direct all requests to the origin server. 
         
        Possible values = CACHE, POLICY, ORIGIN 
    .PARAMETER Onpolicymatch 
        Redirect requests that match the policy to either the cache or the origin server, as specified. 
        Note: For this option to work, you must set the cache redirection type to POLICY. 
         
        Possible values = CACHE, ORIGIN 
    .PARAMETER Redirecturl 
        URL of the server to which to redirect traffic if the cache redirection virtual server configured on the Citrix ADC becomes unavailable. 
    .PARAMETER Clttimeout 
        Time-out value, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Precedence 
        Type of policy (URL or RULE) that takes precedence on the cache redirection virtual server. Applies only to cache redirection virtual servers that have both URL and RULE based policies. If you specify URL, URL based policies are applied first, in the following order: 
        1. Domain and exact URL 
        2. Domain, prefix and suffix 
        3. Domain and suffix 
        4. Domain and prefix 
        5. Domain only 
        6. Exact URL 
        7. Prefix and suffix 
        8. Suffix only 
        9. Prefix only 
        10. Default 
        If you specify RULE, the rule based policies are applied before URL based policies are applied. 
         
        Possible values = RULE, URL 
    .PARAMETER Arp 
        Use ARP to determine the destination MAC address. 
        Possible values = ON, OFF 
    .PARAMETER Ghost 
        . 
        Possible values = ON, OFF 
    .PARAMETER Map 
        Obsolete. 
        Possible values = ON, OFF 
    .PARAMETER Format 
        . 
        Possible values = ON, OFF 
    .PARAMETER Via 
        Insert a via header in each HTTP request. In the case of a cache miss, the request is redirected from the cache server to the origin server. This header indicates whether the request is being sent from a cache server. 
         
        Possible values = ON, OFF 
    .PARAMETER Cachevserver 
        Name of the default cache virtual server to which to redirect requests (the default target of the cache redirection virtual server). 
    .PARAMETER Dnsvservername 
        Name of the DNS virtual server that resolves domain names arriving at the forward proxy virtual server. 
        Note: This parameter applies only to forward proxy virtual servers, not reverse or transparent. 
    .PARAMETER Destinationvserver 
        Destination virtual server for a transparent or forward proxy cache redirection virtual server. 
    .PARAMETER Domain 
        Default domain for reverse proxies. Domains are configured to direct an incoming request from a specified source domain to a specified target domain. There can be several configured pairs of source and target domains. You can select one pair to be the default. If the host header or URL of an incoming request does not include a source domain, this option sends the request to the specified target domain. 
    .PARAMETER Sopersistencetimeout 
        Time-out, in minutes, for spillover persistence. 
         
        Maximum value = 24 
    .PARAMETER Sothreshold 
        For CONNECTION (or) DYNAMICCONNECTION spillover, the number of connections above which the virtual server enters spillover mode. For BANDWIDTH spillover, the amount of incoming and outgoing traffic (in Kbps) before spillover. For HEALTH spillover, the percentage of active services (by weight) below which spillover occurs. 
    .PARAMETER Reuse 
        Reuse TCP connections to the origin server across client connections. Do not set this parameter unless the Service Type parameter is set to HTTP. If you set this parameter to OFF, the possible settings of the Redirect parameter function as follows: 
        * CACHE - TCP connections to the cache servers are not reused. 
        * ORIGIN - TCP connections to the origin servers are not reused. 
        * POLICY - TCP connections to the origin servers are not reused. 
        If you set the Reuse parameter to ON, connections to origin servers and connections to cache servers are reused. 
         
        Possible values = ON, OFF 
    .PARAMETER State 
        Initial state of the cache redirection virtual server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Perform delayed cleanup of connections to this virtual server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Backupvserver 
        Name of the backup virtual server to which traffic is forwarded if the active server becomes unavailable. 
    .PARAMETER Disableprimaryondown 
        Continue sending traffic to a backup virtual server even after the primary virtual server comes UP from the DOWN state. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER L2conn 
        Use L2 parameters, such as MAC, VLAN, and channel to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Backendssl 
        Decides whether the backend connection made by Citrix ADC to the origin server will be HTTP or SSL. Applicable only for SSL type CR Forward proxy vserver. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the cache redirection virtual server. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Listenpriority 
        Priority of the listen policy specified by the Listen Policy parameter. The lower the number, higher the priority. 
         
         
        Maximum value = 100 
    .PARAMETER Tcpprofilename 
        Name of the profile containing TCP configuration information for the cache redirection virtual server. 
    .PARAMETER Httpprofilename 
        Name of the profile containing HTTP configuration information for cache redirection virtual server. 
    .PARAMETER Comment 
        Comments associated with this virtual server. 
    .PARAMETER Srcipexpr 
        Expression used to extract the source IP addresses from the requests originating from the cache. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Originusip 
        Use the client's IP address as the source IP address in requests sent to the origin server. 
        Note: You can enable this parameter to implement fully transparent CR deployment. 
        Possible values = ON, OFF 
    .PARAMETER Useportrange 
        Use a port number from the port range (set by using the set ns param command, or in the Create Virtual Server (Cache Redirection) dialog box) as the source port in the requests sent to the origin server. 
         
        Possible values = ON, OFF 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile containing network configurations for the cache redirection virtual server. 
    .PARAMETER Icmpvsrresponse 
        Criterion for responding to PING requests sent to this virtual server. If ACTIVE, respond only if the virtual server is available. If PASSIVE, respond even if the virtual server is not available. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Useoriginipportforcache 
        Use origin ip/port while forwarding request to the cache. Change the destination IP, destination port of the request came to CR vserver to Origin IP and Origin Port and forward it to Cache. 
         
        Possible values = YES, NO 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case. 
    .PARAMETER Probeport 
        Citrix ADC provides support for external health check of the vserver status. Select port for HTTP/TCP monitring. 
    .PARAMETER Disallowserviceaccess 
        This is effective when a FORWARD type cr vserver is added. By default, this parameter is DISABLED. When it is ENABLED, backend services cannot be accessed through a FORWARD type cr vserver. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created crvserver item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserver -name <string> -servicetype <string>
        An example how to add crvserver config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver/
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
        [ValidateSet('HTTP', 'SSL', 'NNTP', 'HDX')]
        [string]$Servicetype,

        [string]$Ipv46,

        [int]$Port = '80',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipset,

        [double]$Range = '1',

        [ValidateSet('TRANSPARENT', 'REVERSE', 'FORWARD')]
        [string]$Cachetype,

        [ValidateSet('CACHE', 'POLICY', 'ORIGIN')]
        [string]$Redirect = 'POLICY',

        [ValidateSet('CACHE', 'ORIGIN')]
        [string]$Onpolicymatch = 'ORIGIN',

        [ValidateLength(1, 128)]
        [string]$Redirecturl,

        [double]$Clttimeout,

        [ValidateSet('RULE', 'URL')]
        [string]$Precedence = 'RULE',

        [ValidateSet('ON', 'OFF')]
        [string]$Arp,

        [ValidateSet('ON', 'OFF')]
        [string]$Ghost,

        [ValidateSet('ON', 'OFF')]
        [string]$Map,

        [ValidateSet('ON', 'OFF')]
        [string]$Format,

        [ValidateSet('ON', 'OFF')]
        [string]$Via = 'ON',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cachevserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsvservername,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Destinationvserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [double]$Sopersistencetimeout,

        [double]$Sothreshold,

        [ValidateSet('ON', 'OFF')]
        [string]$Reuse = 'ON',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupvserver,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown = 'DISABLED',

        [ValidateSet('ON', 'OFF')]
        [string]$L2conn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Backendssl = 'DISABLED',

        [string]$Listenpolicy = '"NONE"',

        [double]$Listenpriority = '101',

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [string]$Comment,

        [ValidateLength(1, 1500)]
        [string]$Srcipexpr,

        [ValidateSet('ON', 'OFF')]
        [string]$Originusip,

        [ValidateSet('ON', 'OFF')]
        [string]$Useportrange = 'OFF',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Icmpvsrresponse = 'PASSIVE',

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Rhistate = 'PASSIVE',

        [ValidateSet('YES', 'NO')]
        [string]$Useoriginipportforcache = 'NO',

        [ValidateRange(1, 65535)]
        [int]$Tcpprobeport,

        [ValidateSet('TCP', 'HTTP')]
        [string]$Probeprotocol,

        [ValidateLength(1, 64)]
        [string]$Probesuccessresponsecode = '"200 OK"',

        [ValidateRange(1, 65535)]
        [int]$Probeport = '0',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disallowserviceaccess = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                servicetype    = $servicetype
            }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('ipv46') ) { $payload.Add('ipv46', $ipv46) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('range') ) { $payload.Add('range', $range) }
            if ( $PSBoundParameters.ContainsKey('cachetype') ) { $payload.Add('cachetype', $cachetype) }
            if ( $PSBoundParameters.ContainsKey('redirect') ) { $payload.Add('redirect', $redirect) }
            if ( $PSBoundParameters.ContainsKey('onpolicymatch') ) { $payload.Add('onpolicymatch', $onpolicymatch) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('arp') ) { $payload.Add('arp', $arp) }
            if ( $PSBoundParameters.ContainsKey('ghost') ) { $payload.Add('ghost', $ghost) }
            if ( $PSBoundParameters.ContainsKey('map') ) { $payload.Add('map', $map) }
            if ( $PSBoundParameters.ContainsKey('format') ) { $payload.Add('format', $format) }
            if ( $PSBoundParameters.ContainsKey('via') ) { $payload.Add('via', $via) }
            if ( $PSBoundParameters.ContainsKey('cachevserver') ) { $payload.Add('cachevserver', $cachevserver) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('destinationvserver') ) { $payload.Add('destinationvserver', $destinationvserver) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('reuse') ) { $payload.Add('reuse', $reuse) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('backendssl') ) { $payload.Add('backendssl', $backendssl) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('srcipexpr') ) { $payload.Add('srcipexpr', $srcipexpr) }
            if ( $PSBoundParameters.ContainsKey('originusip') ) { $payload.Add('originusip', $originusip) }
            if ( $PSBoundParameters.ContainsKey('useportrange') ) { $payload.Add('useportrange', $useportrange) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('useoriginipportforcache') ) { $payload.Add('useoriginipportforcache', $useoriginipportforcache) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSBoundParameters.ContainsKey('probeport') ) { $payload.Add('probeport', $probeport) }
            if ( $PSBoundParameters.ContainsKey('disallowserviceaccess') ) { $payload.Add('disallowserviceaccess', $disallowserviceaccess) }
            if ( $PSCmdlet.ShouldProcess("crvserver", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type crvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserver -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserver: Finished"
    }
}

function Invoke-NSDeleteCrvserver {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserver -Name <string>
        An example how to delete crvserver config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver/
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
        Write-Verbose "Invoke-NSDeleteCrvserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserver: Finished"
    }
}

function Invoke-NSUpdateCrvserver {
    <#
    .SYNOPSIS
        Update Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER Ipv46 
        IPv4 or IPv6 address of the cache redirection virtual server. Usually a public IP address. Clients send connection requests to this IP address. 
        Note: For a transparent cache redirection virtual server, use an asterisk (*) to specify a wildcard virtual server address. 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cr vserver. 
    .PARAMETER Redirect 
        Type of cache server to which to redirect HTTP requests. Available settings function as follows: 
        * CACHE - Direct all requests to the cache. 
        * POLICY - Apply the cache redirection policy to determine whether the request should be directed to the cache or to the origin. 
        * ORIGIN - Direct all requests to the origin server. 
         
        Possible values = CACHE, POLICY, ORIGIN 
    .PARAMETER Onpolicymatch 
        Redirect requests that match the policy to either the cache or the origin server, as specified. 
        Note: For this option to work, you must set the cache redirection type to POLICY. 
         
        Possible values = CACHE, ORIGIN 
    .PARAMETER Precedence 
        Type of policy (URL or RULE) that takes precedence on the cache redirection virtual server. Applies only to cache redirection virtual servers that have both URL and RULE based policies. If you specify URL, URL based policies are applied first, in the following order: 
        1. Domain and exact URL 
        2. Domain, prefix and suffix 
        3. Domain and suffix 
        4. Domain and prefix 
        5. Domain only 
        6. Exact URL 
        7. Prefix and suffix 
        8. Suffix only 
        9. Prefix only 
        10. Default 
        If you specify RULE, the rule based policies are applied before URL based policies are applied. 
         
        Possible values = RULE, URL 
    .PARAMETER Arp 
        Use ARP to determine the destination MAC address. 
        Possible values = ON, OFF 
    .PARAMETER Via 
        Insert a via header in each HTTP request. In the case of a cache miss, the request is redirected from the cache server to the origin server. This header indicates whether the request is being sent from a cache server. 
         
        Possible values = ON, OFF 
    .PARAMETER Cachevserver 
        Name of the default cache virtual server to which to redirect requests (the default target of the cache redirection virtual server). 
    .PARAMETER Dnsvservername 
        Name of the DNS virtual server that resolves domain names arriving at the forward proxy virtual server. 
        Note: This parameter applies only to forward proxy virtual servers, not reverse or transparent. 
    .PARAMETER Destinationvserver 
        Destination virtual server for a transparent or forward proxy cache redirection virtual server. 
    .PARAMETER Domain 
        Default domain for reverse proxies. Domains are configured to direct an incoming request from a specified source domain to a specified target domain. There can be several configured pairs of source and target domains. You can select one pair to be the default. If the host header or URL of an incoming request does not include a source domain, this option sends the request to the specified target domain. 
    .PARAMETER Reuse 
        Reuse TCP connections to the origin server across client connections. Do not set this parameter unless the Service Type parameter is set to HTTP. If you set this parameter to OFF, the possible settings of the Redirect parameter function as follows: 
        * CACHE - TCP connections to the cache servers are not reused. 
        * ORIGIN - TCP connections to the origin servers are not reused. 
        * POLICY - TCP connections to the origin servers are not reused. 
        If you set the Reuse parameter to ON, connections to origin servers and connections to cache servers are reused. 
         
        Possible values = ON, OFF 
    .PARAMETER Backupvserver 
        Name of the backup virtual server to which traffic is forwarded if the active server becomes unavailable. 
    .PARAMETER Disableprimaryondown 
        Continue sending traffic to a backup virtual server even after the primary virtual server comes UP from the DOWN state. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Redirecturl 
        URL of the server to which to redirect traffic if the cache redirection virtual server configured on the Citrix ADC becomes unavailable. 
    .PARAMETER Clttimeout 
        Time-out value, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Downstateflush 
        Perform delayed cleanup of connections to this virtual server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER L2conn 
        Use L2 parameters, such as MAC, VLAN, and channel to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Backendssl 
        Decides whether the backend connection made by Citrix ADC to the origin server will be HTTP or SSL. Applicable only for SSL type CR Forward proxy vserver. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the cache redirection virtual server. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Listenpriority 
        Priority of the listen policy specified by the Listen Policy parameter. The lower the number, higher the priority. 
         
         
        Maximum value = 100 
    .PARAMETER Tcpprofilename 
        Name of the profile containing TCP configuration information for the cache redirection virtual server. 
    .PARAMETER Httpprofilename 
        Name of the profile containing HTTP configuration information for cache redirection virtual server. 
    .PARAMETER Netprofile 
        Name of the network profile containing network configurations for the cache redirection virtual server. 
    .PARAMETER Comment 
        Comments associated with this virtual server. 
    .PARAMETER Srcipexpr 
        Expression used to extract the source IP addresses from the requests originating from the cache. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Originusip 
        Use the client's IP address as the source IP address in requests sent to the origin server. 
        Note: You can enable this parameter to implement fully transparent CR deployment. 
        Possible values = ON, OFF 
    .PARAMETER Useportrange 
        Use a port number from the port range (set by using the set ns param command, or in the Create Virtual Server (Cache Redirection) dialog box) as the source port in the requests sent to the origin server. 
         
        Possible values = ON, OFF 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Icmpvsrresponse 
        Criterion for responding to PING requests sent to this virtual server. If ACTIVE, respond only if the virtual server is available. If PASSIVE, respond even if the virtual server is not available. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Useoriginipportforcache 
        Use origin ip/port while forwarding request to the cache. Change the destination IP, destination port of the request came to CR vserver to Origin IP and Origin Port and forward it to Cache. 
         
        Possible values = YES, NO 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case. 
    .PARAMETER Probeport 
        Citrix ADC provides support for external health check of the vserver status. Select port for HTTP/TCP monitring. 
    .PARAMETER Disallowserviceaccess 
        This is effective when a FORWARD type cr vserver is added. By default, this parameter is DISABLED. When it is ENABLED, backend services cannot be accessed through a FORWARD type cr vserver. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created crvserver item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCrvserver -name <string>
        An example how to update crvserver config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCrvserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver/
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

        [string]$Ipv46,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipset,

        [ValidateSet('CACHE', 'POLICY', 'ORIGIN')]
        [string]$Redirect,

        [ValidateSet('CACHE', 'ORIGIN')]
        [string]$Onpolicymatch,

        [ValidateSet('RULE', 'URL')]
        [string]$Precedence,

        [ValidateSet('ON', 'OFF')]
        [string]$Arp,

        [ValidateSet('ON', 'OFF')]
        [string]$Via,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cachevserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsvservername,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Destinationvserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [ValidateSet('ON', 'OFF')]
        [string]$Reuse,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupvserver,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown,

        [ValidateLength(1, 128)]
        [string]$Redirecturl,

        [double]$Clttimeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateSet('ON', 'OFF')]
        [string]$L2conn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Backendssl,

        [string]$Listenpolicy,

        [double]$Listenpriority,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [string]$Comment,

        [ValidateLength(1, 1500)]
        [string]$Srcipexpr,

        [ValidateSet('ON', 'OFF')]
        [string]$Originusip,

        [ValidateSet('ON', 'OFF')]
        [string]$Useportrange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Icmpvsrresponse,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Rhistate,

        [ValidateSet('YES', 'NO')]
        [string]$Useoriginipportforcache,

        [ValidateRange(1, 65535)]
        [int]$Tcpprobeport,

        [ValidateSet('TCP', 'HTTP')]
        [string]$Probeprotocol,

        [ValidateLength(1, 64)]
        [string]$Probesuccessresponsecode,

        [ValidateRange(1, 65535)]
        [int]$Probeport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disallowserviceaccess,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipv46') ) { $payload.Add('ipv46', $ipv46) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('redirect') ) { $payload.Add('redirect', $redirect) }
            if ( $PSBoundParameters.ContainsKey('onpolicymatch') ) { $payload.Add('onpolicymatch', $onpolicymatch) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('arp') ) { $payload.Add('arp', $arp) }
            if ( $PSBoundParameters.ContainsKey('via') ) { $payload.Add('via', $via) }
            if ( $PSBoundParameters.ContainsKey('cachevserver') ) { $payload.Add('cachevserver', $cachevserver) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('destinationvserver') ) { $payload.Add('destinationvserver', $destinationvserver) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('reuse') ) { $payload.Add('reuse', $reuse) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('backendssl') ) { $payload.Add('backendssl', $backendssl) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('srcipexpr') ) { $payload.Add('srcipexpr', $srcipexpr) }
            if ( $PSBoundParameters.ContainsKey('originusip') ) { $payload.Add('originusip', $originusip) }
            if ( $PSBoundParameters.ContainsKey('useportrange') ) { $payload.Add('useportrange', $useportrange) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('useoriginipportforcache') ) { $payload.Add('useoriginipportforcache', $useoriginipportforcache) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSBoundParameters.ContainsKey('probeport') ) { $payload.Add('probeport', $probeport) }
            if ( $PSBoundParameters.ContainsKey('disallowserviceaccess') ) { $payload.Add('disallowserviceaccess', $disallowserviceaccess) }
            if ( $PSCmdlet.ShouldProcess("crvserver", "Update Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserver -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCrvserver: Finished"
    }
}

function Invoke-NSUnsetCrvserver {
    <#
    .SYNOPSIS
        Unset Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER Cachevserver 
        Name of the default cache virtual server to which to redirect requests (the default target of the cache redirection virtual server). 
    .PARAMETER Dnsvservername 
        Name of the DNS virtual server that resolves domain names arriving at the forward proxy virtual server. 
        Note: This parameter applies only to forward proxy virtual servers, not reverse or transparent. 
    .PARAMETER Destinationvserver 
        Destination virtual server for a transparent or forward proxy cache redirection virtual server. 
    .PARAMETER Domain 
        Default domain for reverse proxies. Domains are configured to direct an incoming request from a specified source domain to a specified target domain. There can be several configured pairs of source and target domains. You can select one pair to be the default. If the host header or URL of an incoming request does not include a source domain, this option sends the request to the specified target domain. 
    .PARAMETER Backupvserver 
        Name of the backup virtual server to which traffic is forwarded if the active server becomes unavailable. 
    .PARAMETER Clttimeout 
        Time-out value, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Redirecturl 
        URL of the server to which to redirect traffic if the cache redirection virtual server configured on the Citrix ADC becomes unavailable. 
    .PARAMETER L2conn 
        Use L2 parameters, such as MAC, VLAN, and channel to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Backendssl 
        Decides whether the backend connection made by Citrix ADC to the origin server will be HTTP or SSL. Applicable only for SSL type CR Forward proxy vserver. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Originusip 
        Use the client's IP address as the source IP address in requests sent to the origin server. 
        Note: You can enable this parameter to implement fully transparent CR deployment. 
        Possible values = ON, OFF 
    .PARAMETER Useportrange 
        Use a port number from the port range (set by using the set ns param command, or in the Create Virtual Server (Cache Redirection) dialog box) as the source port in the requests sent to the origin server. 
         
        Possible values = ON, OFF 
    .PARAMETER Srcipexpr 
        Expression used to extract the source IP addresses from the requests originating from the cache. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Tcpprofilename 
        Name of the profile containing TCP configuration information for the cache redirection virtual server. 
    .PARAMETER Httpprofilename 
        Name of the profile containing HTTP configuration information for cache redirection virtual server. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile containing network configurations for the cache redirection virtual server. 
    .PARAMETER Icmpvsrresponse 
        Criterion for responding to PING requests sent to this virtual server. If ACTIVE, respond only if the virtual server is available. If PASSIVE, respond even if the virtual server is not available. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cr vserver. 
    .PARAMETER Redirect 
        Type of cache server to which to redirect HTTP requests. Available settings function as follows: 
        * CACHE - Direct all requests to the cache. 
        * POLICY - Apply the cache redirection policy to determine whether the request should be directed to the cache or to the origin. 
        * ORIGIN - Direct all requests to the origin server. 
         
        Possible values = CACHE, POLICY, ORIGIN 
    .PARAMETER Onpolicymatch 
        Redirect requests that match the policy to either the cache or the origin server, as specified. 
        Note: For this option to work, you must set the cache redirection type to POLICY. 
         
        Possible values = CACHE, ORIGIN 
    .PARAMETER Precedence 
        Type of policy (URL or RULE) that takes precedence on the cache redirection virtual server. Applies only to cache redirection virtual servers that have both URL and RULE based policies. If you specify URL, URL based policies are applied first, in the following order: 
        1. Domain and exact URL 
        2. Domain, prefix and suffix 
        3. Domain and suffix 
        4. Domain and prefix 
        5. Domain only 
        6. Exact URL 
        7. Prefix and suffix 
        8. Suffix only 
        9. Prefix only 
        10. Default 
        If you specify RULE, the rule based policies are applied before URL based policies are applied. 
         
        Possible values = RULE, URL 
    .PARAMETER Arp 
        Use ARP to determine the destination MAC address. 
        Possible values = ON, OFF 
    .PARAMETER Via 
        Insert a via header in each HTTP request. In the case of a cache miss, the request is redirected from the cache server to the origin server. This header indicates whether the request is being sent from a cache server. 
         
        Possible values = ON, OFF 
    .PARAMETER Reuse 
        Reuse TCP connections to the origin server across client connections. Do not set this parameter unless the Service Type parameter is set to HTTP. If you set this parameter to OFF, the possible settings of the Redirect parameter function as follows: 
        * CACHE - TCP connections to the cache servers are not reused. 
        * ORIGIN - TCP connections to the origin servers are not reused. 
        * POLICY - TCP connections to the origin servers are not reused. 
        If you set the Reuse parameter to ON, connections to origin servers and connections to cache servers are reused. 
         
        Possible values = ON, OFF 
    .PARAMETER Disableprimaryondown 
        Continue sending traffic to a backup virtual server even after the primary virtual server comes UP from the DOWN state. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Perform delayed cleanup of connections to this virtual server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the cache redirection virtual server. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Listenpriority 
        Priority of the listen policy specified by the Listen Policy parameter. The lower the number, higher the priority. 
         
         
        Maximum value = 100 
    .PARAMETER Comment 
        Comments associated with this virtual server. 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
         
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Useoriginipportforcache 
        Use origin ip/port while forwarding request to the cache. Change the destination IP, destination port of the request came to CR vserver to Origin IP and Origin Port and forward it to Cache. 
         
        Possible values = YES, NO 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case. 
    .PARAMETER Disallowserviceaccess 
        This is effective when a FORWARD type cr vserver is added. By default, this parameter is DISABLED. When it is ENABLED, backend services cannot be accessed through a FORWARD type cr vserver. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCrvserver -name <string>
        An example how to unset crvserver config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCrvserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver
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

        [Boolean]$cachevserver,

        [Boolean]$dnsvservername,

        [Boolean]$destinationvserver,

        [Boolean]$domain,

        [Boolean]$backupvserver,

        [Boolean]$clttimeout,

        [Boolean]$redirecturl,

        [Boolean]$l2conn,

        [Boolean]$backendssl,

        [Boolean]$originusip,

        [Boolean]$useportrange,

        [Boolean]$srcipexpr,

        [Boolean]$tcpprofilename,

        [Boolean]$httpprofilename,

        [Boolean]$appflowlog,

        [Boolean]$netprofile,

        [Boolean]$icmpvsrresponse,

        [Boolean]$tcpprobeport,

        [Boolean]$probeprotocol,

        [Boolean]$ipset,

        [Boolean]$redirect,

        [Boolean]$onpolicymatch,

        [Boolean]$precedence,

        [Boolean]$arp,

        [Boolean]$via,

        [Boolean]$reuse,

        [Boolean]$disableprimaryondown,

        [Boolean]$downstateflush,

        [Boolean]$listenpolicy,

        [Boolean]$listenpriority,

        [Boolean]$comment,

        [Boolean]$rhistate,

        [Boolean]$useoriginipportforcache,

        [Boolean]$probesuccessresponsecode,

        [Boolean]$disallowserviceaccess 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('cachevserver') ) { $payload.Add('cachevserver', $cachevserver) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('destinationvserver') ) { $payload.Add('destinationvserver', $destinationvserver) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('backendssl') ) { $payload.Add('backendssl', $backendssl) }
            if ( $PSBoundParameters.ContainsKey('originusip') ) { $payload.Add('originusip', $originusip) }
            if ( $PSBoundParameters.ContainsKey('useportrange') ) { $payload.Add('useportrange', $useportrange) }
            if ( $PSBoundParameters.ContainsKey('srcipexpr') ) { $payload.Add('srcipexpr', $srcipexpr) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('redirect') ) { $payload.Add('redirect', $redirect) }
            if ( $PSBoundParameters.ContainsKey('onpolicymatch') ) { $payload.Add('onpolicymatch', $onpolicymatch) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('arp') ) { $payload.Add('arp', $arp) }
            if ( $PSBoundParameters.ContainsKey('via') ) { $payload.Add('via', $via) }
            if ( $PSBoundParameters.ContainsKey('reuse') ) { $payload.Add('reuse', $reuse) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('useoriginipportforcache') ) { $payload.Add('useoriginipportforcache', $useoriginipportforcache) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSBoundParameters.ContainsKey('disallowserviceaccess') ) { $payload.Add('disallowserviceaccess', $disallowserviceaccess) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type crvserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCrvserver: Finished"
    }
}

function Invoke-NSEnableCrvserver {
    <#
    .SYNOPSIS
        Enable Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-NSEnableCrvserver -name <string>
        An example how to enable crvserver config Object(s).
    .NOTES
        File Name : Invoke-NSEnableCrvserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver/
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
        Write-Verbose "Invoke-NSEnableCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type crvserver -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableCrvserver: Finished"
    }
}

function Invoke-NSDisableCrvserver {
    <#
    .SYNOPSIS
        Disable Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-NSDisableCrvserver -name <string>
        An example how to disable crvserver config Object(s).
    .NOTES
        File Name : Invoke-NSDisableCrvserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver/
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
        Write-Verbose "Invoke-NSDisableCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type crvserver -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableCrvserver: Finished"
    }
}

function Invoke-NSRenameCrvserver {
    <#
    .SYNOPSIS
        Rename Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER Newname 
        New name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my name" or 'my name'). 
    .PARAMETER PassThru 
        Return details about the created crvserver item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCrvserver -name <string> -newname <string>
        An example how to rename crvserver config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCrvserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver/
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
        Write-Verbose "Invoke-NSRenameCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("crvserver", "Rename Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type crvserver -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserver -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCrvserver: Finished"
    }
}

function Invoke-NSGetCrvserver {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER GetAll 
        Retrieve all crvserver object(s).
    .PARAMETER Count
        If specified, the count of the crvserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserver -GetAll 
        Get all crvserver data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserver -Count 
        Get the number of crvserver objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserver -name <string>
        Get crvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserver -Filter @{ 'name'='<value>' }
        Get crvserver data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver/
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
        Write-Verbose "Invoke-NSGetCrvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all crvserver objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserver: Ended"
    }
}

function Invoke-NSAddCrvserverAnalyticsprofileBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound to the CR vserver. 
    .PARAMETER PassThru 
        Return details about the created crvserver_analyticsprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverAnalyticsprofileBinding -name <string>
        An example how to add crvserver_analyticsprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverAnalyticsprofileBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_analyticsprofile_binding/
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
        Write-Verbose "Invoke-NSAddCrvserverAnalyticsprofileBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("crvserver_analyticsprofile_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_analyticsprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverAnalyticsprofileBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverAnalyticsprofileBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverAnalyticsprofileBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound to the CR vserver.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverAnalyticsprofileBinding -Name <string>
        An example how to delete crvserver_analyticsprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverAnalyticsprofileBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_analyticsprofile_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverAnalyticsprofileBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Analyticsprofile') ) { $arguments.Add('analyticsprofile', $Analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverAnalyticsprofileBinding: Finished"
    }
}

function Invoke-NSGetCrvserverAnalyticsprofileBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_analyticsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_analyticsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAnalyticsprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverAnalyticsprofileBinding -GetAll 
        Get all crvserver_analyticsprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverAnalyticsprofileBinding -Count 
        Get the number of crvserver_analyticsprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAnalyticsprofileBinding -name <string>
        Get crvserver_analyticsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAnalyticsprofileBinding -Filter @{ 'name'='<value>' }
        Get crvserver_analyticsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverAnalyticsprofileBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_analyticsprofile_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverAnalyticsprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_analyticsprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_analyticsprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_analyticsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_analyticsprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverAnalyticsprofileBinding: Ended"
    }
}

function Invoke-NSAddCrvserverAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_appflowpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverAppflowpolicyBinding -name <string>
        An example how to add crvserver_appflowpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverAppflowpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_appflowpolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverAppflowpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_appflowpolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_appflowpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverAppflowpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverAppflowpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverAppflowpolicyBinding -Name <string>
        An example how to delete crvserver_appflowpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverAppflowpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_appflowpolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverAppflowpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverAppflowpolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAppflowpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverAppflowpolicyBinding -GetAll 
        Get all crvserver_appflowpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverAppflowpolicyBinding -Count 
        Get the number of crvserver_appflowpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAppflowpolicyBinding -name <string>
        Get crvserver_appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAppflowpolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverAppflowpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_appflowpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverAppflowpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_appflowpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_appflowpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_appflowpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverAppflowpolicyBinding: Ended"
    }
}

function Invoke-NSAddCrvserverAppfwpolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_appfwpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverAppfwpolicyBinding -name <string>
        An example how to add crvserver_appfwpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverAppfwpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_appfwpolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverAppfwpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_appfwpolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_appfwpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverAppfwpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverAppfwpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverAppfwpolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverAppfwpolicyBinding -Name <string>
        An example how to delete crvserver_appfwpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverAppfwpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_appfwpolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverAppfwpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverAppfwpolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverAppfwpolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_appfwpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_appfwpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAppfwpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverAppfwpolicyBinding -GetAll 
        Get all crvserver_appfwpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverAppfwpolicyBinding -Count 
        Get the number of crvserver_appfwpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAppfwpolicyBinding -name <string>
        Get crvserver_appfwpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAppfwpolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_appfwpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverAppfwpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_appfwpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverAppfwpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_appfwpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_appfwpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_appfwpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_appfwpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_appfwpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverAppfwpolicyBinding: Ended"
    }
}

function Invoke-NSAddCrvserverAppqoepolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_appqoepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverAppqoepolicyBinding -name <string>
        An example how to add crvserver_appqoepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverAppqoepolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_appqoepolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverAppqoepolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_appqoepolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_appqoepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverAppqoepolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverAppqoepolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverAppqoepolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverAppqoepolicyBinding -Name <string>
        An example how to delete crvserver_appqoepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverAppqoepolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_appqoepolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverAppqoepolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverAppqoepolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverAppqoepolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_appqoepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_appqoepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAppqoepolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverAppqoepolicyBinding -GetAll 
        Get all crvserver_appqoepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverAppqoepolicyBinding -Count 
        Get the number of crvserver_appqoepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAppqoepolicyBinding -name <string>
        Get crvserver_appqoepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverAppqoepolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_appqoepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverAppqoepolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_appqoepolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverAppqoepolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_appqoepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_appqoepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_appqoepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_appqoepolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverAppqoepolicyBinding: Ended"
    }
}

function Invoke-NSGetCrvserverBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to crvserver.
    .PARAMETER Name 
        Name of a cache redirection virtual server about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverBinding -GetAll 
        Get all crvserver_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverBinding -name <string>
        Get crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverBinding -Filter @{ 'name'='<value>' }
        Get crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverBinding: Ended"
    }
}

function Invoke-NSAddCrvserverCachepolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_cachepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverCachepolicyBinding -name <string>
        An example how to add crvserver_cachepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverCachepolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_cachepolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverCachepolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_cachepolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_cachepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverCachepolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverCachepolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverCachepolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverCachepolicyBinding -Name <string>
        An example how to delete crvserver_cachepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverCachepolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_cachepolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverCachepolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverCachepolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverCachepolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_cachepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_cachepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCachepolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverCachepolicyBinding -GetAll 
        Get all crvserver_cachepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverCachepolicyBinding -Count 
        Get the number of crvserver_cachepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCachepolicyBinding -name <string>
        Get crvserver_cachepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCachepolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_cachepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverCachepolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_cachepolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverCachepolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_cachepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_cachepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_cachepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_cachepolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_cachepolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverCachepolicyBinding: Ended"
    }
}

function Invoke-NSAddCrvserverCmppolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_cmppolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverCmppolicyBinding -name <string>
        An example how to add crvserver_cmppolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverCmppolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_cmppolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverCmppolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_cmppolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_cmppolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverCmppolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverCmppolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverCmppolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverCmppolicyBinding -Name <string>
        An example how to delete crvserver_cmppolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverCmppolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_cmppolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverCmppolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverCmppolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverCmppolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_cmppolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_cmppolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCmppolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverCmppolicyBinding -GetAll 
        Get all crvserver_cmppolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverCmppolicyBinding -Count 
        Get the number of crvserver_cmppolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCmppolicyBinding -name <string>
        Get crvserver_cmppolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCmppolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_cmppolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverCmppolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_cmppolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverCmppolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_cmppolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_cmppolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_cmppolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_cmppolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_cmppolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverCmppolicyBinding: Ended"
    }
}

function Invoke-NSAddCrvserverCrpolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the crpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_crpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverCrpolicyBinding -name <string>
        An example how to add crvserver_crpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverCrpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_crpolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverCrpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_crpolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_crpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverCrpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverCrpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverCrpolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the crpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverCrpolicyBinding -Name <string>
        An example how to delete crvserver_crpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverCrpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_crpolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverCrpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverCrpolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverCrpolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the crpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_crpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_crpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCrpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverCrpolicyBinding -GetAll 
        Get all crvserver_crpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverCrpolicyBinding -Count 
        Get the number of crvserver_crpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCrpolicyBinding -name <string>
        Get crvserver_crpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCrpolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_crpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverCrpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_crpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverCrpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_crpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_crpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_crpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_crpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_crpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverCrpolicyBinding: Ended"
    }
}

function Invoke-NSAddCrvserverCspolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        The CSW target server names. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_cspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverCspolicyBinding -name <string>
        An example how to add crvserver_cspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverCspolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_cspolicy_binding/
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

        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverCspolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_cspolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_cspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverCspolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverCspolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverCspolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverCspolicyBinding -Name <string>
        An example how to delete crvserver_cspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverCspolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_cspolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverCspolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverCspolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverCspolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_cspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_cspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCspolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverCspolicyBinding -GetAll 
        Get all crvserver_cspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverCspolicyBinding -Count 
        Get the number of crvserver_cspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCspolicyBinding -name <string>
        Get crvserver_cspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverCspolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_cspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverCspolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_cspolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverCspolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_cspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_cspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_cspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_cspolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_cspolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverCspolicyBinding: Ended"
    }
}

function Invoke-NSAddCrvserverFeopolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_feopolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverFeopolicyBinding -name <string>
        An example how to add crvserver_feopolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverFeopolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_feopolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverFeopolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_feopolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_feopolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverFeopolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverFeopolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverFeopolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverFeopolicyBinding -Name <string>
        An example how to delete crvserver_feopolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverFeopolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_feopolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverFeopolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverFeopolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverFeopolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_feopolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_feopolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverFeopolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverFeopolicyBinding -GetAll 
        Get all crvserver_feopolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverFeopolicyBinding -Count 
        Get the number of crvserver_feopolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverFeopolicyBinding -name <string>
        Get crvserver_feopolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverFeopolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_feopolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverFeopolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_feopolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverFeopolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_feopolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_feopolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_feopolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_feopolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_feopolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverFeopolicyBinding: Ended"
    }
}

function Invoke-NSAddCrvserverIcapolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_icapolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverIcapolicyBinding -name <string>
        An example how to add crvserver_icapolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverIcapolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_icapolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverIcapolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_icapolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_icapolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverIcapolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverIcapolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverIcapolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverIcapolicyBinding -Name <string>
        An example how to delete crvserver_icapolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverIcapolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_icapolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverIcapolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverIcapolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverIcapolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_icapolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_icapolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverIcapolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverIcapolicyBinding -GetAll 
        Get all crvserver_icapolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverIcapolicyBinding -Count 
        Get the number of crvserver_icapolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverIcapolicyBinding -name <string>
        Get crvserver_icapolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverIcapolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_icapolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverIcapolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_icapolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverIcapolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_icapolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_icapolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_icapolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_icapolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_icapolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverIcapolicyBinding: Ended"
    }
}

function Invoke-NSAddCrvserverLbvserverBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Lbvserver 
        The Default target server name. 
    .PARAMETER PassThru 
        Return details about the created crvserver_lbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverLbvserverBinding -name <string>
        An example how to add crvserver_lbvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_lbvserver_binding/
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

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverLbvserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('lbvserver') ) { $payload.Add('lbvserver', $lbvserver) }
            if ( $PSCmdlet.ShouldProcess("crvserver_lbvserver_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_lbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverLbvserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverLbvserverBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverLbvserverBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Lbvserver 
        The Default target server name.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverLbvserverBinding -Name <string>
        An example how to delete crvserver_lbvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_lbvserver_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverLbvserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Lbvserver') ) { $arguments.Add('lbvserver', $Lbvserver) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverLbvserverBinding: Finished"
    }
}

function Invoke-NSGetCrvserverLbvserverBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverLbvserverBinding -GetAll 
        Get all crvserver_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverLbvserverBinding -Count 
        Get the number of crvserver_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverLbvserverBinding -name <string>
        Get crvserver_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverLbvserverBinding -Filter @{ 'name'='<value>' }
        Get crvserver_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverLbvserverBinding: Ended"
    }
}

function Invoke-NSAddCrvserverPolicymapBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the policymap that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        The CSW target server names. 
    .PARAMETER Priority 
        An unsigned integer that determines the priority of the policy relative to other policies bound to this cache redirection virtual server. The lower the value, higher the priority. Note: This option is available only when binding content switching, filtering, and compression policies to a cache redirection virtual server. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), b ut does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number incr ements by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_policymap_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverPolicymapBinding -name <string>
        An example how to add crvserver_policymap_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverPolicymapBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_policymap_binding/
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

        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverPolicymapBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_policymap_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_policymap_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverPolicymapBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverPolicymapBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverPolicymapBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the policymap that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        An unsigned integer that determines the priority of the policy relative to other policies bound to this cache redirection virtual server. The lower the value, higher the priority. Note: This option is available only when binding content switching, filtering, and compression policies to a cache redirection virtual server.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverPolicymapBinding -Name <string>
        An example how to delete crvserver_policymap_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverPolicymapBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_policymap_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverPolicymapBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverPolicymapBinding: Finished"
    }
}

function Invoke-NSGetCrvserverPolicymapBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the policymap that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_policymap_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_policymap_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverPolicymapBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverPolicymapBinding -GetAll 
        Get all crvserver_policymap_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverPolicymapBinding -Count 
        Get the number of crvserver_policymap_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverPolicymapBinding -name <string>
        Get crvserver_policymap_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverPolicymapBinding -Filter @{ 'name'='<value>' }
        Get crvserver_policymap_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverPolicymapBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_policymap_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverPolicymapBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_policymap_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_policymap_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_policymap_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_policymap_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_policymap_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverPolicymapBinding: Ended"
    }
}

function Invoke-NSAddCrvserverResponderpolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_responderpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverResponderpolicyBinding -name <string>
        An example how to add crvserver_responderpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverResponderpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_responderpolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverResponderpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_responderpolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_responderpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverResponderpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverResponderpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverResponderpolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverResponderpolicyBinding -Name <string>
        An example how to delete crvserver_responderpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverResponderpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_responderpolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverResponderpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverResponderpolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverResponderpolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_responderpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_responderpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverResponderpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverResponderpolicyBinding -GetAll 
        Get all crvserver_responderpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverResponderpolicyBinding -Count 
        Get the number of crvserver_responderpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverResponderpolicyBinding -name <string>
        Get crvserver_responderpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverResponderpolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_responderpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverResponderpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_responderpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverResponderpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_responderpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_responderpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_responderpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_responderpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_responderpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverResponderpolicyBinding: Ended"
    }
}

function Invoke-NSAddCrvserverRewritepolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_rewritepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverRewritepolicyBinding -name <string>
        An example how to add crvserver_rewritepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverRewritepolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_rewritepolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverRewritepolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_rewritepolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_rewritepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverRewritepolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverRewritepolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverRewritepolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverRewritepolicyBinding -Name <string>
        An example how to delete crvserver_rewritepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverRewritepolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_rewritepolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverRewritepolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverRewritepolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverRewritepolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_rewritepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_rewritepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverRewritepolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverRewritepolicyBinding -GetAll 
        Get all crvserver_rewritepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverRewritepolicyBinding -Count 
        Get the number of crvserver_rewritepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverRewritepolicyBinding -name <string>
        Get crvserver_rewritepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverRewritepolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_rewritepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverRewritepolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_rewritepolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverRewritepolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_rewritepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_rewritepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_rewritepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_rewritepolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_rewritepolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverRewritepolicyBinding: Ended"
    }
}

function Invoke-NSAddCrvserverSpilloverpolicyBinding {
    <#
    .SYNOPSIS
        Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_spilloverpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCrvserverSpilloverpolicyBinding -name <string>
        An example how to add crvserver_spilloverpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCrvserverSpilloverpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_spilloverpolicy_binding/
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
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCrvserverSpilloverpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_spilloverpolicy_binding", "Add Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_spilloverpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCrvserverSpilloverpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCrvserverSpilloverpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCrvserverSpilloverpolicyBinding {
    <#
    .SYNOPSIS
        Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCrvserverSpilloverpolicyBinding -Name <string>
        An example how to delete crvserver_spilloverpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCrvserverSpilloverpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_spilloverpolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCrvserverSpilloverpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCrvserverSpilloverpolicyBinding: Finished"
    }
}

function Invoke-NSGetCrvserverSpilloverpolicyBinding {
    <#
    .SYNOPSIS
        Get Cache redirection configuration. The cache redirection feature can transparently redirect cacheable HTTP requests to a cache and send non-cacheable or dynamic HTTP requests to the origin server. A cache stores or caches frequently requested web content and serves such web content to a client on behalf of the origin servers, alleviating the load on the origin server farm. config object(s).
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_spilloverpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_spilloverpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverSpilloverpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverSpilloverpolicyBinding -GetAll 
        Get all crvserver_spilloverpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCrvserverSpilloverpolicyBinding -Count 
        Get the number of crvserver_spilloverpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverSpilloverpolicyBinding -name <string>
        Get crvserver_spilloverpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCrvserverSpilloverpolicyBinding -Filter @{ 'name'='<value>' }
        Get crvserver_spilloverpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCrvserverSpilloverpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cr/crvserver_spilloverpolicy_binding/
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
        Write-Verbose "Invoke-NSGetCrvserverSpilloverpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_spilloverpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_spilloverpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_spilloverpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCrvserverSpilloverpolicyBinding: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCWhNjDWm2abgX3
# LgbUcmsu5kXnX4CLYllXiuBZi14TkqCCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQgkNayxo6Ex5tZ6AqCE0PIY/GFQ4TiBywT5vdwaaJ/EFkwDQYJ
# KoZIhvcNAQEBBQAEggEAkFeon7UV6QEDHRbo1nwm2olPgeUWHR4sHjTeFOu1b/RH
# gQ1AMxY2cdT5Pv5/RjQhxzMVIrZ/Y+UvcUyayKcGAEdYrwzqJo5YfKWP/pi5h1ua
# jCosLrdlwuJIT8lsDbLQLjr8FDS4qZu9Ch1XXnRHZ2at0v877Fk8nKh6bDQUKy3L
# dB+ITr7p6sfzNZ++IwF4c/+NWT9HatxTPBOgzuJZmpUynPwOZVlLWqLmQkwWx+hj
# sdWVl9gB/XAhBoc8goIVNIupcrss6FDpRF1dVZafBu+pwa3L3bKvkfxL9pkWT1HT
# nKCAMcxvrvzt/A4FsxrhyIndO3+UTf/StMomdwbKJKGCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQyMTBaMD8GCSqG
# SIb3DQEJBDEyBDAddzQnf4HaOQZArBg6jcsYN5mCRkheR9E12+NiFpoLKeXRmgTM
# sosd9DYl5UQQx3QwDQYJKoZIhvcNAQEBBQAEggIAFeBvTRMW4UPFyXS0myymQ8K2
# IOcV4mOQkP7yczZw+zonLhSiaQDhMVVIaaulLW6xSosyDqJW4KEz31pT0oCpHuXQ
# PMCC9bZD1lCwiByQF0Yl8cV/wPqQa4iEqtt499knBAph1tlqsaJq8sc2hxmngdoT
# cV3/3lSNywW4zrjKIqqi/fU3KY5H20dH4+3qSTbAmagvGqhqcrU1lR4zrsAzV/QA
# rKAHfIC0G8M1nqy+s0qC+7k9yFzqqxeqluZcTZrsxbD7YQj6yxdbgnF2mPE0XRAY
# OeJeZG2DH6qrBOqgISctoJudK12PVS2yhe6ydC/n61Wo7ODl1BfNyGelk3dfLq7v
# sOltM+L5GAYJCpP8hhbr4Q+r/T69lkNiRBBfo3lOWFgqVvMIkNsYtp5B0Z6yPRdU
# 58/uh17ZR1O0t6MN/GRXP1F54qGXW8pwG0yC98zVPfO2HJY+Ei8LHWsp37MLM36x
# CcJ/G2LfMp5Oc8c2bGVrobV5rlzgIuROFPTyQZiLlaiuQr03Ekq5CKFuFHz2Sgys
# cCnTSkCFP11UuN4uWADLaNOumJaOVdhLKR/l4trRZhRzoIr7JQUOg9mM5X01V/X0
# ZgyO1Fe/smEAQ5cHGy1nCyiOGTUI7yrXaiR+r/u0l5QjhjAPQX/HP6OYF8QbEuGW
# OsDIRnJzEnBtG15DUDE=
# SIG # End signature block
