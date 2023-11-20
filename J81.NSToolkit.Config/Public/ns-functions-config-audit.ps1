function Invoke-NSUnsetAuditmessageaction {
    <#
    .SYNOPSIS
        Unset Audit configuration. config Object.
    .DESCRIPTION
        Configuration for message action resource.
    .PARAMETER Name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER Logtonewnslog 
        Send the message to the new nslog. 
        Possible values = YES, NO 
    .PARAMETER Bypasssafetycheck 
        Bypass the safety check and allow unsafe expressions. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAuditmessageaction -name <string>
        An example how to unset auditmessageaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAuditmessageaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditmessageaction
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

        [Boolean]$logtonewnslog,

        [Boolean]$bypasssafetycheck 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAuditmessageaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('logtonewnslog') ) { $payload.Add('logtonewnslog', $logtonewnslog) }
            if ( $PSBoundParameters.ContainsKey('bypasssafetycheck') ) { $payload.Add('bypasssafetycheck', $bypasssafetycheck) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type auditmessageaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAuditmessageaction: Finished"
    }
}

function Invoke-NSDeleteAuditmessageaction {
    <#
    .SYNOPSIS
        Delete Audit configuration. config Object.
    .DESCRIPTION
        Configuration for message action resource.
    .PARAMETER Name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAuditmessageaction -Name <string>
        An example how to delete auditmessageaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAuditmessageaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditmessageaction/
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
        Write-Verbose "Invoke-NSDeleteAuditmessageaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type auditmessageaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAuditmessageaction: Finished"
    }
}

function Invoke-NSUpdateAuditmessageaction {
    <#
    .SYNOPSIS
        Update Audit configuration. config Object.
    .DESCRIPTION
        Configuration for message action resource.
    .PARAMETER Name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the severity level of the log message being generated.. 
        The following loglevels are valid: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Stringbuilderexpr 
        Default-syntax expression that defines the format and content of the log message. 
    .PARAMETER Logtonewnslog 
        Send the message to the new nslog. 
        Possible values = YES, NO 
    .PARAMETER Bypasssafetycheck 
        Bypass the safety check and allow unsafe expressions. 
         
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created auditmessageaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAuditmessageaction -name <string>
        An example how to update auditmessageaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAuditmessageaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditmessageaction/
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

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$Loglevel,

        [string]$Stringbuilderexpr,

        [ValidateSet('YES', 'NO')]
        [string]$Logtonewnslog,

        [ValidateSet('YES', 'NO')]
        [string]$Bypasssafetycheck,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAuditmessageaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('stringbuilderexpr') ) { $payload.Add('stringbuilderexpr', $stringbuilderexpr) }
            if ( $PSBoundParameters.ContainsKey('logtonewnslog') ) { $payload.Add('logtonewnslog', $logtonewnslog) }
            if ( $PSBoundParameters.ContainsKey('bypasssafetycheck') ) { $payload.Add('bypasssafetycheck', $bypasssafetycheck) }
            if ( $PSCmdlet.ShouldProcess("auditmessageaction", "Update Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type auditmessageaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditmessageaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAuditmessageaction: Finished"
    }
}

function Invoke-NSAddAuditmessageaction {
    <#
    .SYNOPSIS
        Add Audit configuration. config Object.
    .DESCRIPTION
        Configuration for message action resource.
    .PARAMETER Name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the severity level of the log message being generated.. 
        The following loglevels are valid: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Stringbuilderexpr 
        Default-syntax expression that defines the format and content of the log message. 
    .PARAMETER Logtonewnslog 
        Send the message to the new nslog. 
        Possible values = YES, NO 
    .PARAMETER Bypasssafetycheck 
        Bypass the safety check and allow unsafe expressions. 
         
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created auditmessageaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAuditmessageaction -name <string> -loglevel <string> -stringbuilderexpr <string>
        An example how to add auditmessageaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddAuditmessageaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditmessageaction/
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
        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$Loglevel,

        [Parameter(Mandatory)]
        [string]$Stringbuilderexpr,

        [ValidateSet('YES', 'NO')]
        [string]$Logtonewnslog,

        [ValidateSet('YES', 'NO')]
        [string]$Bypasssafetycheck = 'NO',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAuditmessageaction: Starting"
    }
    process {
        try {
            $payload = @{ name    = $name
                loglevel          = $loglevel
                stringbuilderexpr = $stringbuilderexpr
            }
            if ( $PSBoundParameters.ContainsKey('logtonewnslog') ) { $payload.Add('logtonewnslog', $logtonewnslog) }
            if ( $PSBoundParameters.ContainsKey('bypasssafetycheck') ) { $payload.Add('bypasssafetycheck', $bypasssafetycheck) }
            if ( $PSCmdlet.ShouldProcess("auditmessageaction", "Add Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type auditmessageaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditmessageaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAuditmessageaction: Finished"
    }
}

function Invoke-NSGetAuditmessageaction {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Configuration for message action resource.
    .PARAMETER Name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER GetAll 
        Retrieve all auditmessageaction object(s).
    .PARAMETER Count
        If specified, the count of the auditmessageaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditmessageaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditmessageaction -GetAll 
        Get all auditmessageaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditmessageaction -Count 
        Get the number of auditmessageaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditmessageaction -name <string>
        Get auditmessageaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditmessageaction -Filter @{ 'name'='<value>' }
        Get auditmessageaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditmessageaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditmessageaction/
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
        Write-Verbose "Invoke-NSGetAuditmessageaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditmessageaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditmessageaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditmessageaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditmessageaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditmessageaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditmessageaction: Ended"
    }
}

function Invoke-NSGetAuditmessages {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Configuration for audit message resource.
    .PARAMETER Loglevel 
        Audit log level filter, which specifies the types of events to display. 
        The following loglevels are valid: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Numofmesgs 
        Number of log messages to be displayed. 
         
         
        Maximum value = 256 
    .PARAMETER GetAll 
        Retrieve all auditmessages object(s).
    .PARAMETER Count
        If specified, the count of the auditmessages object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditmessages
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditmessages -GetAll 
        Get all auditmessages data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditmessages -Count 
        Get the number of auditmessages objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditmessages -name <string>
        Get auditmessages object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditmessages -Filter @{ 'name'='<value>' }
        Get auditmessages data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditmessages
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditmessages/
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
        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string[]]$Loglevel,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double]$Numofmesgs,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetAuditmessages: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditmessages objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditmessages objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditmessages objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('loglevel') ) { $arguments.Add('loglevel', $loglevel) } 
                if ( $PSBoundParameters.ContainsKey('numofmesgs') ) { $arguments.Add('numofmesgs', $numofmesgs) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditmessages configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditmessages configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditmessages: Ended"
    }
}

function Invoke-NSUnsetAuditnslogaction {
    <#
    .SYNOPSIS
        Unset Audit configuration. config Object.
    .DESCRIPTION
        Configuration for ns log action resource.
    .PARAMETER Name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER Serverport 
        Port on which the nslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Available settings function as follows: 
        * GMT_TIME. Coordinated Universal Time. 
        * LOCAL_TIME. The server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to nslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAuditnslogaction -name <string>
        An example how to unset auditnslogaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAuditnslogaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogaction
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

        [Boolean]$serverport,

        [Boolean]$loglevel,

        [Boolean]$dateformat,

        [Boolean]$logfacility,

        [Boolean]$tcp,

        [Boolean]$acl,

        [Boolean]$timezone,

        [Boolean]$userdefinedauditlog,

        [Boolean]$appflowexport,

        [Boolean]$lsn,

        [Boolean]$alg,

        [Boolean]$subscriberlog,

        [Boolean]$sslinterception,

        [Boolean]$contentinspectionlog,

        [Boolean]$urlfiltering 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAuditnslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type auditnslogaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAuditnslogaction: Finished"
    }
}

function Invoke-NSUpdateAuditnslogaction {
    <#
    .SYNOPSIS
        Update Audit configuration. config Object.
    .DESCRIPTION
        Configuration for ns log action resource.
    .PARAMETER Name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER Serverip 
        IP address of the nslog server. 
    .PARAMETER Serverdomainname 
        Auditserver name as a FQDN. Mutually exclusive with serverIP. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the audit server if the last query failed. 
         
         
        Maximum value = 20939 
    .PARAMETER Domainresolvenow 
        Immediately send a DNS query to resolve the server's domain name. 
    .PARAMETER Serverport 
        Port on which the nslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Available settings function as follows: 
        * GMT_TIME. Coordinated Universal Time. 
        * LOCAL_TIME. The server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to nslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditnslogaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAuditnslogaction -name <string>
        An example how to update auditnslogaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAuditnslogaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogaction/
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
        [string]$Serverip,

        [ValidateLength(1, 255)]
        [string]$Serverdomainname,

        [int]$Domainresolveretry,

        [boolean]$Domainresolvenow,

        [int]$Serverport,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAuditnslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverdomainname') ) { $payload.Add('serverdomainname', $serverdomainname) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('domainresolvenow') ) { $payload.Add('domainresolvenow', $domainresolvenow) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSCmdlet.ShouldProcess("auditnslogaction", "Update Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditnslogaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAuditnslogaction: Finished"
    }
}

function Invoke-NSDeleteAuditnslogaction {
    <#
    .SYNOPSIS
        Delete Audit configuration. config Object.
    .DESCRIPTION
        Configuration for ns log action resource.
    .PARAMETER Name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAuditnslogaction -Name <string>
        An example how to delete auditnslogaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAuditnslogaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogaction/
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
        Write-Verbose "Invoke-NSDeleteAuditnslogaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type auditnslogaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAuditnslogaction: Finished"
    }
}

function Invoke-NSAddAuditnslogaction {
    <#
    .SYNOPSIS
        Add Audit configuration. config Object.
    .DESCRIPTION
        Configuration for ns log action resource.
    .PARAMETER Name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER Serverip 
        IP address of the nslog server. 
    .PARAMETER Serverdomainname 
        Auditserver name as a FQDN. Mutually exclusive with serverIP. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the audit server if the last query failed. 
         
         
        Maximum value = 20939 
    .PARAMETER Serverport 
        Port on which the nslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Available settings function as follows: 
        * GMT_TIME. Coordinated Universal Time. 
        * LOCAL_TIME. The server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to nslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditnslogaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAuditnslogaction -name <string> -loglevel <string[]>
        An example how to add auditnslogaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddAuditnslogaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogaction/
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
        [string]$Serverip,

        [ValidateLength(1, 255)]
        [string]$Serverdomainname,

        [int]$Domainresolveretry = '5',

        [int]$Serverport,

        [Parameter(Mandatory)]
        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAuditnslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                loglevel       = $loglevel
            }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverdomainname') ) { $payload.Add('serverdomainname', $serverdomainname) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSCmdlet.ShouldProcess("auditnslogaction", "Add Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type auditnslogaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditnslogaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAuditnslogaction: Finished"
    }
}

function Invoke-NSGetAuditnslogaction {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Configuration for ns log action resource.
    .PARAMETER Name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER GetAll 
        Retrieve all auditnslogaction object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogaction -GetAll 
        Get all auditnslogaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogaction -Count 
        Get the number of auditnslogaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogaction -name <string>
        Get auditnslogaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogaction -Filter @{ 'name'='<value>' }
        Get auditnslogaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogaction/
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
        Write-Verbose "Invoke-NSGetAuditnslogaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditnslogaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogaction: Ended"
    }
}

function Invoke-NSAddAuditnslogglobalAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Add Audit configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to auditnslogglobal.
    .PARAMETER Policyname 
        Name of the audit nslog policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
         
        Maximum value = 2147483647 
    .PARAMETER Globalbindtype 
        . 
         
        Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL, APPFW_GLOBAL 
    .PARAMETER PassThru 
        Return details about the created auditnslogglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAuditnslogglobalAuditnslogpolicyBinding -policyname <string> -priority <double>
        An example how to add auditnslogglobal_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAuditnslogglobalAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogglobal_auditnslogpolicy_binding/
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
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [ValidateSet('SYSTEM_GLOBAL', 'VPN_GLOBAL', 'RNAT_GLOBAL', 'APPFW_GLOBAL')]
        [string]$Globalbindtype = 'SYSTEM_GLOBAL',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAuditnslogglobalAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('globalbindtype') ) { $payload.Add('globalbindtype', $globalbindtype) }
            if ( $PSCmdlet.ShouldProcess("auditnslogglobal_auditnslogpolicy_binding", "Add Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogglobal_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditnslogglobalAuditnslogpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAuditnslogglobalAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAuditnslogglobalAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete Audit configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to auditnslogglobal.
    .PARAMETER Policyname 
        Name of the audit nslog policy. 
    .PARAMETER Globalbindtype 
        . 
         
        Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL, APPFW_GLOBAL
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAuditnslogglobalAuditnslogpolicyBinding 
        An example how to delete auditnslogglobal_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAuditnslogglobalAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogglobal_auditnslogpolicy_binding/
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

        [string]$Policyname,

        [string]$Globalbindtype 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAuditnslogglobalAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Globalbindtype') ) { $arguments.Add('globalbindtype', $Globalbindtype) }
            if ( $PSCmdlet.ShouldProcess("auditnslogglobal_auditnslogpolicy_binding", "Delete Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAuditnslogglobalAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetAuditnslogglobalAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to auditnslogglobal.
    .PARAMETER GetAll 
        Retrieve all auditnslogglobal_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogglobal_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogglobalAuditnslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogglobalAuditnslogpolicyBinding -GetAll 
        Get all auditnslogglobal_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogglobalAuditnslogpolicyBinding -Count 
        Get the number of auditnslogglobal_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogglobalAuditnslogpolicyBinding -name <string>
        Get auditnslogglobal_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogglobalAuditnslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get auditnslogglobal_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogglobalAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogglobalAuditnslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogglobal_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogglobal_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogglobal_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditnslogglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogglobalAuditnslogpolicyBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to auditnslogglobal.
    .PARAMETER GetAll 
        Retrieve all auditnslogglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogglobalBinding -GetAll 
        Get all auditnslogglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogglobalBinding -name <string>
        Get auditnslogglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogglobalBinding -Filter @{ 'name'='<value>' }
        Get auditnslogglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditnslogglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogglobalBinding: Ended"
    }
}

function Invoke-NSUnsetAuditnslogparams {
    <#
    .SYNOPSIS
        Unset Audit configuration. config Object.
    .DESCRIPTION
        Configuration for ns log parameters resource.
    .PARAMETER Serverip 
        IP address of the nslog server. 
    .PARAMETER Serverport 
        Port on which the nslog server accepts connections. 
    .PARAMETER Loglevel 
        Types of information to be logged. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Configure auditing to log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Configure auditing to log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Supported settings are: 
        * GMT_TIME - Coordinated Universal Time. 
        * LOCAL_TIME - Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to nslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAuditnslogparams 
        An example how to unset auditnslogparams config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAuditnslogparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogparams
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

        [Boolean]$loglevel,

        [Boolean]$dateformat,

        [Boolean]$logfacility,

        [Boolean]$tcp,

        [Boolean]$acl,

        [Boolean]$timezone,

        [Boolean]$userdefinedauditlog,

        [Boolean]$appflowexport,

        [Boolean]$lsn,

        [Boolean]$alg,

        [Boolean]$subscriberlog,

        [Boolean]$sslinterception,

        [Boolean]$urlfiltering,

        [Boolean]$contentinspectionlog 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAuditnslogparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSCmdlet.ShouldProcess("auditnslogparams", "Unset Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type auditnslogparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAuditnslogparams: Finished"
    }
}

function Invoke-NSUpdateAuditnslogparams {
    <#
    .SYNOPSIS
        Update Audit configuration. config Object.
    .DESCRIPTION
        Configuration for ns log parameters resource.
    .PARAMETER Serverip 
        IP address of the nslog server. 
    .PARAMETER Serverport 
        Port on which the nslog server accepts connections. 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Loglevel 
        Types of information to be logged. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Configure auditing to log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Configure auditing to log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Supported settings are: 
        * GMT_TIME - Coordinated Universal Time. 
        * LOCAL_TIME - Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to nslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAuditnslogparams 
        An example how to update auditnslogparams config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAuditnslogparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogparams/
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

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAuditnslogparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSCmdlet.ShouldProcess("auditnslogparams", "Update Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogparams -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateAuditnslogparams: Finished"
    }
}

function Invoke-NSGetAuditnslogparams {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Configuration for ns log parameters resource.
    .PARAMETER GetAll 
        Retrieve all auditnslogparams object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogparams -GetAll 
        Get all auditnslogparams data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogparams -name <string>
        Get auditnslogparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogparams -Filter @{ 'name'='<value>' }
        Get auditnslogparams data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogparams/
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
        Write-Verbose "Invoke-NSGetAuditnslogparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditnslogparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditnslogparams configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogparams: Ended"
    }
}

function Invoke-NSDeleteAuditnslogpolicy {
    <#
    .SYNOPSIS
        Delete Audit configuration. config Object.
    .DESCRIPTION
        Configuration for ns log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAuditnslogpolicy -Name <string>
        An example how to delete auditnslogpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAuditnslogpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy/
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
        Write-Verbose "Invoke-NSDeleteAuditnslogpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type auditnslogpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAuditnslogpolicy: Finished"
    }
}

function Invoke-NSUpdateAuditnslogpolicy {
    <#
    .SYNOPSIS
        Update Audit configuration. config Object.
    .DESCRIPTION
        Configuration for ns log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the nslog server. 
    .PARAMETER Action 
        Nslog server action that is performed when this policy matches. 
        NOTE: An nslog server action must be associated with an nslog audit policy. 
    .PARAMETER PassThru 
        Return details about the created auditnslogpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAuditnslogpolicy -name <string>
        An example how to update auditnslogpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAuditnslogpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy/
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
        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAuditnslogpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("auditnslogpolicy", "Update Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditnslogpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAuditnslogpolicy: Finished"
    }
}

function Invoke-NSAddAuditnslogpolicy {
    <#
    .SYNOPSIS
        Add Audit configuration. config Object.
    .DESCRIPTION
        Configuration for ns log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the nslog server. 
    .PARAMETER Action 
        Nslog server action that is performed when this policy matches. 
        NOTE: An nslog server action must be associated with an nslog audit policy. 
    .PARAMETER PassThru 
        Return details about the created auditnslogpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAuditnslogpolicy -name <string> -rule <string> -action <string>
        An example how to add auditnslogpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddAuditnslogpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy/
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
        [string]$Rule,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAuditnslogpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("auditnslogpolicy", "Add Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type auditnslogpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditnslogpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAuditnslogpolicy: Finished"
    }
}

function Invoke-NSGetAuditnslogpolicy {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Configuration for ns log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicy -GetAll 
        Get all auditnslogpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicy -Count 
        Get the number of auditnslogpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicy -name <string>
        Get auditnslogpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicy -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditnslogpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicy: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyAaagroupBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the aaagroup that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAaagroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyAaagroupBinding -GetAll 
        Get all auditnslogpolicy_aaagroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyAaagroupBinding -Count 
        Get the number of auditnslogpolicy_aaagroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAaagroupBinding -name <string>
        Get auditnslogpolicy_aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAaagroupBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyAaagroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_aaagroup_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyAaagroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaagroup_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_aaagroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyAaagroupBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyAaauserBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAaauserBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyAaauserBinding -GetAll 
        Get all auditnslogpolicy_aaauser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyAaauserBinding -Count 
        Get the number of auditnslogpolicy_aaauser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAaauserBinding -name <string>
        Get auditnslogpolicy_aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAaauserBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyAaauserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_aaauser_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyAaauserBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaauser_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_aaauser_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyAaauserBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyAppfwglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the appfwglobal that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_appfwglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_appfwglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAppfwglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyAppfwglobalBinding -GetAll 
        Get all auditnslogpolicy_appfwglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyAppfwglobalBinding -Count 
        Get the number of auditnslogpolicy_appfwglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAppfwglobalBinding -name <string>
        Get auditnslogpolicy_appfwglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAppfwglobalBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_appfwglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyAppfwglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_appfwglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyAppfwglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_appfwglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_appfwglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_appfwglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_appfwglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_appfwglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyAppfwglobalBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyAuditnslogglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditnslogglobal that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_auditnslogglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_auditnslogglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAuditnslogglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyAuditnslogglobalBinding -GetAll 
        Get all auditnslogpolicy_auditnslogglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyAuditnslogglobalBinding -Count 
        Get the number of auditnslogpolicy_auditnslogglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAuditnslogglobalBinding -name <string>
        Get auditnslogpolicy_auditnslogglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAuditnslogglobalBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_auditnslogglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyAuditnslogglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_auditnslogglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyAuditnslogglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_auditnslogglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_auditnslogglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_auditnslogglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_auditnslogglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_auditnslogglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyAuditnslogglobalBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyAuthenticationvserverBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_authenticationvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_authenticationvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAuthenticationvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyAuthenticationvserverBinding -GetAll 
        Get all auditnslogpolicy_authenticationvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyAuthenticationvserverBinding -Count 
        Get the number of auditnslogpolicy_authenticationvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAuthenticationvserverBinding -name <string>
        Get auditnslogpolicy_authenticationvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyAuthenticationvserverBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_authenticationvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyAuthenticationvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_authenticationvserver_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyAuthenticationvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_authenticationvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_authenticationvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_authenticationvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyAuthenticationvserverBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyBinding -GetAll 
        Get all auditnslogpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyBinding -name <string>
        Get auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyCsvserverBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyCsvserverBinding -GetAll 
        Get all auditnslogpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyCsvserverBinding -Count 
        Get the number of auditnslogpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyCsvserverBinding -name <string>
        Get auditnslogpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyCsvserverBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyCsvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyCsvserverBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyLbvserverBinding -GetAll 
        Get all auditnslogpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyLbvserverBinding -Count 
        Get the number of auditnslogpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyLbvserverBinding -name <string>
        Get auditnslogpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyLbvserverBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicySystemglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the systemglobal that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_systemglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_systemglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicySystemglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicySystemglobalBinding -GetAll 
        Get all auditnslogpolicy_systemglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicySystemglobalBinding -Count 
        Get the number of auditnslogpolicy_systemglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicySystemglobalBinding -name <string>
        Get auditnslogpolicy_systemglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicySystemglobalBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_systemglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicySystemglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_systemglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicySystemglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_systemglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_systemglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_systemglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_systemglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_systemglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicySystemglobalBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyTmglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the tmglobal that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_tmglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_tmglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyTmglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyTmglobalBinding -GetAll 
        Get all auditnslogpolicy_tmglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyTmglobalBinding -Count 
        Get the number of auditnslogpolicy_tmglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyTmglobalBinding -name <string>
        Get auditnslogpolicy_tmglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyTmglobalBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_tmglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyTmglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyTmglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_tmglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_tmglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_tmglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_tmglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyTmglobalBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyVpnglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnglobal that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_vpnglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_vpnglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyVpnglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyVpnglobalBinding -GetAll 
        Get all auditnslogpolicy_vpnglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyVpnglobalBinding -Count 
        Get the number of auditnslogpolicy_vpnglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyVpnglobalBinding -name <string>
        Get auditnslogpolicy_vpnglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyVpnglobalBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_vpnglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyVpnglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_vpnglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyVpnglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_vpnglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_vpnglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_vpnglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyVpnglobalBinding: Ended"
    }
}

function Invoke-NSGetAuditnslogpolicyVpnvserverBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyVpnvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyVpnvserverBinding -GetAll 
        Get all auditnslogpolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditnslogpolicyVpnvserverBinding -Count 
        Get the number of auditnslogpolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyVpnvserverBinding -name <string>
        Get auditnslogpolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditnslogpolicyVpnvserverBinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditnslogpolicyVpnvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditnslogpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-NSGetAuditnslogpolicyVpnvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditnslogpolicyVpnvserverBinding: Ended"
    }
}

function Invoke-NSUnsetAuditsyslogaction {
    <#
    .SYNOPSIS
        Unset Audit configuration. config Object.
    .DESCRIPTION
        Configuration for system log action resource.
    .PARAMETER Name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER Serverport 
        Port on which the syslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available values function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY. -U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Supported settings are: 
        * GMT_TIME. Coordinated Universal time. 
        * LOCAL_TIME. Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to syslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log lsn info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log alg info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the audit server info to tune the TCP connection parameters. 
    .PARAMETER Maxlogdatasizetohold 
        Max size of log data that can be held in NSB chain of server info. 
         
         
        Maximum value = 25600 
    .PARAMETER Dns 
        Log DNS related syslog messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile. 
        The SNIP configured in the network profile will be used as source IP while sending log messages. 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAuditsyslogaction -name <string>
        An example how to unset auditsyslogaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAuditsyslogaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogaction
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

        [Boolean]$serverport,

        [Boolean]$loglevel,

        [Boolean]$dateformat,

        [Boolean]$logfacility,

        [Boolean]$tcp,

        [Boolean]$acl,

        [Boolean]$timezone,

        [Boolean]$userdefinedauditlog,

        [Boolean]$appflowexport,

        [Boolean]$lsn,

        [Boolean]$alg,

        [Boolean]$subscriberlog,

        [Boolean]$tcpprofilename,

        [Boolean]$maxlogdatasizetohold,

        [Boolean]$dns,

        [Boolean]$contentinspectionlog,

        [Boolean]$netprofile,

        [Boolean]$sslinterception,

        [Boolean]$urlfiltering 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAuditsyslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('maxlogdatasizetohold') ) { $payload.Add('maxlogdatasizetohold', $maxlogdatasizetohold) }
            if ( $PSBoundParameters.ContainsKey('dns') ) { $payload.Add('dns', $dns) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type auditsyslogaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAuditsyslogaction: Finished"
    }
}

function Invoke-NSDeleteAuditsyslogaction {
    <#
    .SYNOPSIS
        Delete Audit configuration. config Object.
    .DESCRIPTION
        Configuration for system log action resource.
    .PARAMETER Name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAuditsyslogaction -Name <string>
        An example how to delete auditsyslogaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAuditsyslogaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogaction/
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
        Write-Verbose "Invoke-NSDeleteAuditsyslogaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type auditsyslogaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAuditsyslogaction: Finished"
    }
}

function Invoke-NSUpdateAuditsyslogaction {
    <#
    .SYNOPSIS
        Update Audit configuration. config Object.
    .DESCRIPTION
        Configuration for system log action resource.
    .PARAMETER Name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER Serverip 
        IP address of the syslog server. 
    .PARAMETER Serverdomainname 
        SYSLOG server name as a FQDN. Mutually exclusive with serverIP/lbVserverName. 
    .PARAMETER Lbvservername 
        Name of the LB vserver. Mutually exclusive with syslog serverIP/serverName. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the syslog server if the last query failed. 
         
         
        Maximum value = 20939 
    .PARAMETER Domainresolvenow 
        Immediately send a DNS query to resolve the server's domain name. 
    .PARAMETER Serverport 
        Port on which the syslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available values function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY. -U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Supported settings are: 
        * GMT_TIME. Coordinated Universal time. 
        * LOCAL_TIME. Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to syslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log lsn info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log alg info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the audit server info to tune the TCP connection parameters. 
    .PARAMETER Maxlogdatasizetohold 
        Max size of log data that can be held in NSB chain of server info. 
         
         
        Maximum value = 25600 
    .PARAMETER Dns 
        Log DNS related syslog messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile. 
        The SNIP configured in the network profile will be used as source IP while sending log messages. 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditsyslogaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAuditsyslogaction -name <string>
        An example how to update auditsyslogaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAuditsyslogaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogaction/
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
        [string]$Serverip,

        [ValidateLength(1, 255)]
        [string]$Serverdomainname,

        [ValidateLength(1, 127)]
        [string]$Lbvservername,

        [int]$Domainresolveretry,

        [boolean]$Domainresolvenow,

        [int]$Serverport,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [double]$Maxlogdatasizetohold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dns,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAuditsyslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverdomainname') ) { $payload.Add('serverdomainname', $serverdomainname) }
            if ( $PSBoundParameters.ContainsKey('lbvservername') ) { $payload.Add('lbvservername', $lbvservername) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('domainresolvenow') ) { $payload.Add('domainresolvenow', $domainresolvenow) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('maxlogdatasizetohold') ) { $payload.Add('maxlogdatasizetohold', $maxlogdatasizetohold) }
            if ( $PSBoundParameters.ContainsKey('dns') ) { $payload.Add('dns', $dns) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogaction", "Update Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditsyslogaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAuditsyslogaction: Finished"
    }
}

function Invoke-NSAddAuditsyslogaction {
    <#
    .SYNOPSIS
        Add Audit configuration. config Object.
    .DESCRIPTION
        Configuration for system log action resource.
    .PARAMETER Name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER Serverip 
        IP address of the syslog server. 
    .PARAMETER Serverdomainname 
        SYSLOG server name as a FQDN. Mutually exclusive with serverIP/lbVserverName. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the syslog server if the last query failed. 
         
         
        Maximum value = 20939 
    .PARAMETER Lbvservername 
        Name of the LB vserver. Mutually exclusive with syslog serverIP/serverName. 
    .PARAMETER Serverport 
        Port on which the syslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available values function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY. -U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Supported settings are: 
        * GMT_TIME. Coordinated Universal time. 
        * LOCAL_TIME. Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to syslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log lsn info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log alg info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Transport 
        Transport type used to send auditlogs to syslog server. Default type is UDP. 
        Possible values = TCP, UDP 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the audit server info to tune the TCP connection parameters. 
    .PARAMETER Maxlogdatasizetohold 
        Max size of log data that can be held in NSB chain of server info. 
         
         
        Maximum value = 25600 
    .PARAMETER Dns 
        Log DNS related syslog messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile. 
        The SNIP configured in the network profile will be used as source IP while sending log messages. 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditsyslogaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAuditsyslogaction -name <string> -loglevel <string[]>
        An example how to add auditsyslogaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddAuditsyslogaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogaction/
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
        [string]$Serverip,

        [ValidateLength(1, 255)]
        [string]$Serverdomainname,

        [int]$Domainresolveretry = '5',

        [ValidateLength(1, 127)]
        [string]$Lbvservername,

        [int]$Serverport,

        [Parameter(Mandatory)]
        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateSet('TCP', 'UDP')]
        [string]$Transport,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [double]$Maxlogdatasizetohold = '500',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dns,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAuditsyslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                loglevel       = $loglevel
            }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverdomainname') ) { $payload.Add('serverdomainname', $serverdomainname) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('lbvservername') ) { $payload.Add('lbvservername', $lbvservername) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('transport') ) { $payload.Add('transport', $transport) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('maxlogdatasizetohold') ) { $payload.Add('maxlogdatasizetohold', $maxlogdatasizetohold) }
            if ( $PSBoundParameters.ContainsKey('dns') ) { $payload.Add('dns', $dns) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogaction", "Add Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type auditsyslogaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditsyslogaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAuditsyslogaction: Finished"
    }
}

function Invoke-NSGetAuditsyslogaction {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Configuration for system log action resource.
    .PARAMETER Name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogaction object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogaction -GetAll 
        Get all auditsyslogaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogaction -Count 
        Get the number of auditsyslogaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogaction -name <string>
        Get auditsyslogaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogaction -Filter @{ 'name'='<value>' }
        Get auditsyslogaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogaction/
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
        Write-Verbose "Invoke-NSGetAuditsyslogaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditsyslogaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogaction: Ended"
    }
}

function Invoke-NSAddAuditsyslogglobalAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Add Audit configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to auditsyslogglobal.
    .PARAMETER Policyname 
        Name of the audit syslog policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
         
        Maximum value = 2147483647 
    .PARAMETER Globalbindtype 
        . 
         
        Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL, APPFW_GLOBAL 
    .PARAMETER PassThru 
        Return details about the created auditsyslogglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAuditsyslogglobalAuditsyslogpolicyBinding -policyname <string> -priority <double>
        An example how to add auditsyslogglobal_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAuditsyslogglobalAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogglobal_auditsyslogpolicy_binding/
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
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [ValidateSet('SYSTEM_GLOBAL', 'VPN_GLOBAL', 'RNAT_GLOBAL', 'APPFW_GLOBAL')]
        [string]$Globalbindtype = 'SYSTEM_GLOBAL',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAuditsyslogglobalAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('globalbindtype') ) { $payload.Add('globalbindtype', $globalbindtype) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogglobal_auditsyslogpolicy_binding", "Add Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogglobal_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditsyslogglobalAuditsyslogpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAuditsyslogglobalAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAuditsyslogglobalAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete Audit configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to auditsyslogglobal.
    .PARAMETER Policyname 
        Name of the audit syslog policy. 
    .PARAMETER Globalbindtype 
        . 
         
        Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL, APPFW_GLOBAL
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAuditsyslogglobalAuditsyslogpolicyBinding 
        An example how to delete auditsyslogglobal_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAuditsyslogglobalAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogglobal_auditsyslogpolicy_binding/
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

        [string]$Policyname,

        [string]$Globalbindtype 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAuditsyslogglobalAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Globalbindtype') ) { $arguments.Add('globalbindtype', $Globalbindtype) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogglobal_auditsyslogpolicy_binding", "Delete Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAuditsyslogglobalAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetAuditsyslogglobalAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to auditsyslogglobal.
    .PARAMETER GetAll 
        Retrieve all auditsyslogglobal_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogglobal_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogglobalAuditsyslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogglobalAuditsyslogpolicyBinding -GetAll 
        Get all auditsyslogglobal_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogglobalAuditsyslogpolicyBinding -Count 
        Get the number of auditsyslogglobal_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogglobalAuditsyslogpolicyBinding -name <string>
        Get auditsyslogglobal_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogglobalAuditsyslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogglobal_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogglobalAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogglobalAuditsyslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogglobal_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditsyslogglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogglobalAuditsyslogpolicyBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to auditsyslogglobal.
    .PARAMETER GetAll 
        Retrieve all auditsyslogglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogglobalBinding -GetAll 
        Get all auditsyslogglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogglobalBinding -name <string>
        Get auditsyslogglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogglobalBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditsyslogglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogglobalBinding: Ended"
    }
}

function Invoke-NSUnsetAuditsyslogparams {
    <#
    .SYNOPSIS
        Unset Audit configuration. config Object.
    .DESCRIPTION
        Configuration for system log parameters resource.
    .PARAMETER Serverip 
        IP address of the syslog server. 
    .PARAMETER Serverport 
        Port on which the syslog server accepts connections. 
    .PARAMETER Loglevel 
        Types of information to be logged. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY. European style -date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Available settings function as follows: 
        * GMT_TIME - Coordinated Universal Time. 
        * LOCAL_TIME Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to syslog. 
        Setting this parameter to NO causes audit to ignore all user-configured message actions. Setting this parameter to YES causes audit to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dns 
        Log DNS related syslog messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event ifnormation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interceptionn event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAuditsyslogparams 
        An example how to unset auditsyslogparams config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAuditsyslogparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogparams
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

        [Boolean]$loglevel,

        [Boolean]$dateformat,

        [Boolean]$logfacility,

        [Boolean]$tcp,

        [Boolean]$acl,

        [Boolean]$timezone,

        [Boolean]$userdefinedauditlog,

        [Boolean]$appflowexport,

        [Boolean]$lsn,

        [Boolean]$alg,

        [Boolean]$subscriberlog,

        [Boolean]$dns,

        [Boolean]$contentinspectionlog,

        [Boolean]$sslinterception,

        [Boolean]$urlfiltering 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAuditsyslogparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('dns') ) { $payload.Add('dns', $dns) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogparams", "Unset Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type auditsyslogparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAuditsyslogparams: Finished"
    }
}

function Invoke-NSUpdateAuditsyslogparams {
    <#
    .SYNOPSIS
        Update Audit configuration. config Object.
    .DESCRIPTION
        Configuration for system log parameters resource.
    .PARAMETER Serverip 
        IP address of the syslog server. 
    .PARAMETER Serverport 
        Port on which the syslog server accepts connections. 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY. European style -date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Loglevel 
        Types of information to be logged. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Available settings function as follows: 
        * GMT_TIME - Coordinated Universal Time. 
        * LOCAL_TIME Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to syslog. 
        Setting this parameter to NO causes audit to ignore all user-configured message actions. Setting this parameter to YES causes audit to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dns 
        Log DNS related syslog messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interceptionn event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event ifnormation. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAuditsyslogparams 
        An example how to update auditsyslogparams config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAuditsyslogparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogparams/
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

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dns,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAuditsyslogparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('dns') ) { $payload.Add('dns', $dns) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogparams", "Update Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogparams -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateAuditsyslogparams: Finished"
    }
}

function Invoke-NSGetAuditsyslogparams {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Configuration for system log parameters resource.
    .PARAMETER GetAll 
        Retrieve all auditsyslogparams object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogparams -GetAll 
        Get all auditsyslogparams data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogparams -name <string>
        Get auditsyslogparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogparams -Filter @{ 'name'='<value>' }
        Get auditsyslogparams data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogparams
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogparams/
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
        Write-Verbose "Invoke-NSGetAuditsyslogparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditsyslogparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogparams objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditsyslogparams configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogparams: Ended"
    }
}

function Invoke-NSDeleteAuditsyslogpolicy {
    <#
    .SYNOPSIS
        Delete Audit configuration. config Object.
    .DESCRIPTION
        Configuration for system log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAuditsyslogpolicy -Name <string>
        An example how to delete auditsyslogpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAuditsyslogpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy/
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
        Write-Verbose "Invoke-NSDeleteAuditsyslogpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Audit configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type auditsyslogpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAuditsyslogpolicy: Finished"
    }
}

function Invoke-NSUpdateAuditsyslogpolicy {
    <#
    .SYNOPSIS
        Update Audit configuration. config Object.
    .DESCRIPTION
        Configuration for system log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the syslog server. 
    .PARAMETER Action 
        Syslog server action to perform when this policy matches traffic. 
        NOTE: A syslog server action must be associated with a syslog audit policy. 
    .PARAMETER PassThru 
        Return details about the created auditsyslogpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAuditsyslogpolicy -name <string>
        An example how to update auditsyslogpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAuditsyslogpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy/
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
        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAuditsyslogpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogpolicy", "Update Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditsyslogpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAuditsyslogpolicy: Finished"
    }
}

function Invoke-NSAddAuditsyslogpolicy {
    <#
    .SYNOPSIS
        Add Audit configuration. config Object.
    .DESCRIPTION
        Configuration for system log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the syslog server. 
    .PARAMETER Action 
        Syslog server action to perform when this policy matches traffic. 
        NOTE: A syslog server action must be associated with a syslog audit policy. 
    .PARAMETER PassThru 
        Return details about the created auditsyslogpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAuditsyslogpolicy -name <string> -rule <string> -action <string>
        An example how to add auditsyslogpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddAuditsyslogpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy/
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
        [string]$Rule,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAuditsyslogpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("auditsyslogpolicy", "Add Audit configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type auditsyslogpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAuditsyslogpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAuditsyslogpolicy: Finished"
    }
}

function Invoke-NSGetAuditsyslogpolicy {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Configuration for system log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicy -GetAll 
        Get all auditsyslogpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicy -Count 
        Get the number of auditsyslogpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicy -name <string>
        Get auditsyslogpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicy -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditsyslogpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicy: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyAaagroupBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the aaagroup that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAaagroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyAaagroupBinding -GetAll 
        Get all auditsyslogpolicy_aaagroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyAaagroupBinding -Count 
        Get the number of auditsyslogpolicy_aaagroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAaagroupBinding -name <string>
        Get auditsyslogpolicy_aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAaagroupBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyAaagroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_aaagroup_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyAaagroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaagroup_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_aaagroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyAaagroupBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyAaauserBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAaauserBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyAaauserBinding -GetAll 
        Get all auditsyslogpolicy_aaauser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyAaauserBinding -Count 
        Get the number of auditsyslogpolicy_aaauser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAaauserBinding -name <string>
        Get auditsyslogpolicy_aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAaauserBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyAaauserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_aaauser_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyAaauserBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaauser_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_aaauser_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyAaauserBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyAuditsyslogglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogglobal that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_auditsyslogglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_auditsyslogglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAuditsyslogglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyAuditsyslogglobalBinding -GetAll 
        Get all auditsyslogpolicy_auditsyslogglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyAuditsyslogglobalBinding -Count 
        Get the number of auditsyslogpolicy_auditsyslogglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAuditsyslogglobalBinding -name <string>
        Get auditsyslogpolicy_auditsyslogglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAuditsyslogglobalBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_auditsyslogglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyAuditsyslogglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_auditsyslogglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyAuditsyslogglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_auditsyslogglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_auditsyslogglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_auditsyslogglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_auditsyslogglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_auditsyslogglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyAuditsyslogglobalBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyAuthenticationvserverBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_authenticationvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_authenticationvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAuthenticationvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyAuthenticationvserverBinding -GetAll 
        Get all auditsyslogpolicy_authenticationvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyAuthenticationvserverBinding -Count 
        Get the number of auditsyslogpolicy_authenticationvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAuthenticationvserverBinding -name <string>
        Get auditsyslogpolicy_authenticationvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyAuthenticationvserverBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_authenticationvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyAuthenticationvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_authenticationvserver_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyAuthenticationvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_authenticationvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_authenticationvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_authenticationvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyAuthenticationvserverBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyBinding -GetAll 
        Get all auditsyslogpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyBinding -name <string>
        Get auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyCsvserverBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyCsvserverBinding -GetAll 
        Get all auditsyslogpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyCsvserverBinding -Count 
        Get the number of auditsyslogpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyCsvserverBinding -name <string>
        Get auditsyslogpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyCsvserverBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyCsvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyCsvserverBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyLbvserverBinding -GetAll 
        Get all auditsyslogpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyLbvserverBinding -Count 
        Get the number of auditsyslogpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyLbvserverBinding -name <string>
        Get auditsyslogpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyLbvserverBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyRnatglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the rnatglobal that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_rnatglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_rnatglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyRnatglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyRnatglobalBinding -GetAll 
        Get all auditsyslogpolicy_rnatglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyRnatglobalBinding -Count 
        Get the number of auditsyslogpolicy_rnatglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyRnatglobalBinding -name <string>
        Get auditsyslogpolicy_rnatglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyRnatglobalBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_rnatglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyRnatglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_rnatglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyRnatglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_rnatglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_rnatglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_rnatglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_rnatglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_rnatglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyRnatglobalBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicySystemglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the systemglobal that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_systemglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_systemglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicySystemglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicySystemglobalBinding -GetAll 
        Get all auditsyslogpolicy_systemglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicySystemglobalBinding -Count 
        Get the number of auditsyslogpolicy_systemglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicySystemglobalBinding -name <string>
        Get auditsyslogpolicy_systemglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicySystemglobalBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_systemglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicySystemglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_systemglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicySystemglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_systemglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_systemglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_systemglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_systemglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_systemglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicySystemglobalBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyTmglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the tmglobal that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_tmglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_tmglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyTmglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyTmglobalBinding -GetAll 
        Get all auditsyslogpolicy_tmglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyTmglobalBinding -Count 
        Get the number of auditsyslogpolicy_tmglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyTmglobalBinding -name <string>
        Get auditsyslogpolicy_tmglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyTmglobalBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_tmglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyTmglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyTmglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_tmglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_tmglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_tmglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_tmglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyTmglobalBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyVpnglobalBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnglobal that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_vpnglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_vpnglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyVpnglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyVpnglobalBinding -GetAll 
        Get all auditsyslogpolicy_vpnglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyVpnglobalBinding -Count 
        Get the number of auditsyslogpolicy_vpnglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyVpnglobalBinding -name <string>
        Get auditsyslogpolicy_vpnglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyVpnglobalBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_vpnglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyVpnglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_vpnglobal_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyVpnglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_vpnglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_vpnglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyVpnglobalBinding: Ended"
    }
}

function Invoke-NSGetAuditsyslogpolicyVpnvserverBinding {
    <#
    .SYNOPSIS
        Get Audit configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyVpnvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyVpnvserverBinding -GetAll 
        Get all auditsyslogpolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAuditsyslogpolicyVpnvserverBinding -Count 
        Get the number of auditsyslogpolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyVpnvserverBinding -name <string>
        Get auditsyslogpolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAuditsyslogpolicyVpnvserverBinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAuditsyslogpolicyVpnvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/audit/auditsyslogpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyVpnvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAuditsyslogpolicyVpnvserverBinding: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA+haEL728z035N
# p8XdcLubYY8og0v+j2TfzX6udHNNGKCCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQg88AFauWF0KkZn1w2P1sacLbufO2bhzfl7kIHiB12RHMwDQYJ
# KoZIhvcNAQEBBQAEggEAeg3f2bJt05R1Tgk7BUpqK7eyWrLHLIdKSGVGVuII1ztl
# PYHK5VarhrPvJbVOFeOeE27V9dQpvH6etJN5kbJT2K0eVivcTZi5pvb7S+J+1tnz
# GVHiLI3fFLVSKAh1TvFCXyGa/auwtITtwTsZej44NKeGKIGkklRu19JN+SQvTyWC
# cXbxyyVpU7at8Uhp9jAcXaf6NmOAtK4n6UKZKOIU0iFC2fE64xTOYvGYO3P7EbeF
# miBhRw/AgnK/drY6orek2XWz0DOB2h3+F2ha8vwmeJv9gR9NNlJrK32m+jV352di
# 4ELxOe96VwzeoYwE3OtKHzz/T5HGmN2rd3kw/HXFhaGCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQxMjhaMD8GCSqG
# SIb3DQEJBDEyBDAwre+NhzcdWRQQ4AW/EjBluhfyPN8BFWdCWKUAiuX5mNC5eX6F
# nSHSRE/6EN7wszEwDQYJKoZIhvcNAQEBBQAEggIAHZ38X86GnU9KypOCHv8kqWBH
# bGJg8D3Hyqg3W97ZUJfXeSUyZhz/KFKU/gKoMDoA8huAYFPdPv87d1o/C4jLL3Z1
# RogIswAAK7pHDvltzeix6othD5TBljmVeNBX7QTravBVnvjW+gSFh+XwaNg3xEEm
# PoFEmQkhY9a9Megt0dGR4U3S4qQ/SSs8W+YpymauKgu/Fgx96HLyx2V2GIm7W1Gf
# oyHEcdido6bjovMH8+fLhy+xniNCWimo3CQetqCNf8K8otdxPjTo6SO+n4NqHNAc
# //qmeKo35hxq4CBQhExAhqCxZvEZNr/9gCvM5e2/s3CXef4uNQkouZodC7X/wjEq
# 75czqRqiGHB1t1oxDatvsNryVsZet9I3rej3K1kkj1ATpjO8CTW9oAokfGvVf3X8
# pat5Di/HJYr6qrtT2EmPn/JMp0e658c6jHDgFridBdost/sCYApl7fyd1PX7NzJX
# VjZpgfR+rpmVHCI5iPHQSby1PhpPJzUGKablaUJLIEEutAWIwdrPkhxHFp/m6NIP
# ECJJdLq/yGF1JOds3U5ZLZC62QEnpfB6eGH2N70En/1N5En5uLp8M2zDyDAHWYMQ
# 3XTVycv9UNxhwYZYJ9RM6qb/99d/3P4LBUvc9vz+8tvi427GyJL58UyPZ6Zs+X4S
# 58fVzqvnIXCSk1/vrXs=
# SIG # End signature block
