function Invoke-NSUnsetAppqoeaction {
    <#
    .SYNOPSIS
        Unset Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for AppQoS action resource.
    .PARAMETER Name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER Priority 
        Priority for queuing the request. If server resources are not available for a request that matches the configured rule, this option specifies a priority for queuing the request until the server resources are available again. If priority is not configured then Lowest priority will be used to queue the request. 
        Possible values = HIGH, MEDIUM, LOW, LOWEST 
    .PARAMETER Altcontentsvcname 
        Name of the alternative content service to be used in the ACS. 
    .PARAMETER Altcontentpath 
        Path to the alternative content service to be used in the ACS. 
    .PARAMETER Polqdepth 
        Policy queue depth threshold value. When the policy queue size (number of requests queued for the policy binding this action is attached to) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level. 
         
        Maximum value = 4294967294 
    .PARAMETER Priqdepth 
        Queue depth threshold value per priorirty level. If the queue size (number of requests in the queue of that particular priorirty) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level. 
         
        Maximum value = 4294967294 
    .PARAMETER Maxconn 
        Maximum number of concurrent connections that can be open for requests that matches with rule. 
         
        Maximum value = 4294967294 
    .PARAMETER Delay 
        Delay threshold, in microseconds, for requests that match the policy's rule. If the delay statistics gathered for the matching request exceed the specified delay, configured action triggered for that request, if there is no action then requests are dropped to the lowest priority level. 
         
        Maximum value = 599999999 
    .PARAMETER Dosaction 
        DoS Action to take when vserver will be considered under DoS attack and corresponding rule matches. Mandatory if AppQoE actions are to be used for DoS attack prevention. 
        Possible values = SimpleResponse, HICResponse 
    .PARAMETER Tcpprofile 
        Bind TCP Profile based on L2/L3/L7 parameters. 
    .PARAMETER Retryonreset 
        Retry on TCP Reset. 
         
        Possible values = YES, NO 
    .PARAMETER Retryontimeout 
        Retry on request Timeout(in millisec) upon sending request to backend servers. 
         
        Maximum value = 2000 
    .PARAMETER Numretries 
        Retry count. 
         
         
        Maximum value = 7
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAppqoeaction -name <string>
        An example how to unset appqoeaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAppqoeaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoeaction
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

        [string]$Name,

        [Boolean]$priority,

        [Boolean]$altcontentsvcname,

        [Boolean]$altcontentpath,

        [Boolean]$polqdepth,

        [Boolean]$priqdepth,

        [Boolean]$maxconn,

        [Boolean]$delay,

        [Boolean]$dosaction,

        [Boolean]$tcpprofile,

        [Boolean]$retryonreset,

        [Boolean]$retryontimeout,

        [Boolean]$numretries 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAppqoeaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('altcontentsvcname') ) { $payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ( $PSBoundParameters.ContainsKey('altcontentpath') ) { $payload.Add('altcontentpath', $altcontentpath) }
            if ( $PSBoundParameters.ContainsKey('polqdepth') ) { $payload.Add('polqdepth', $polqdepth) }
            if ( $PSBoundParameters.ContainsKey('priqdepth') ) { $payload.Add('priqdepth', $priqdepth) }
            if ( $PSBoundParameters.ContainsKey('maxconn') ) { $payload.Add('maxconn', $maxconn) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('dosaction') ) { $payload.Add('dosaction', $dosaction) }
            if ( $PSBoundParameters.ContainsKey('tcpprofile') ) { $payload.Add('tcpprofile', $tcpprofile) }
            if ( $PSBoundParameters.ContainsKey('retryonreset') ) { $payload.Add('retryonreset', $retryonreset) }
            if ( $PSBoundParameters.ContainsKey('retryontimeout') ) { $payload.Add('retryontimeout', $retryontimeout) }
            if ( $PSBoundParameters.ContainsKey('numretries') ) { $payload.Add('numretries', $numretries) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Application Level Quality of Experience configuration config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type appqoeaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAppqoeaction: Finished"
    }
}

function Invoke-NSDeleteAppqoeaction {
    <#
    .SYNOPSIS
        Delete Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for AppQoS action resource.
    .PARAMETER Name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAppqoeaction -Name <string>
        An example how to delete appqoeaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAppqoeaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoeaction/
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
        Write-Verbose "Invoke-NSDeleteAppqoeaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Level Quality of Experience configuration config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type appqoeaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAppqoeaction: Finished"
    }
}

function Invoke-NSUpdateAppqoeaction {
    <#
    .SYNOPSIS
        Update Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for AppQoS action resource.
    .PARAMETER Name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER Priority 
        Priority for queuing the request. If server resources are not available for a request that matches the configured rule, this option specifies a priority for queuing the request until the server resources are available again. If priority is not configured then Lowest priority will be used to queue the request. 
        Possible values = HIGH, MEDIUM, LOW, LOWEST 
    .PARAMETER Altcontentsvcname 
        Name of the alternative content service to be used in the ACS. 
    .PARAMETER Altcontentpath 
        Path to the alternative content service to be used in the ACS. 
    .PARAMETER Polqdepth 
        Policy queue depth threshold value. When the policy queue size (number of requests queued for the policy binding this action is attached to) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level. 
         
        Maximum value = 4294967294 
    .PARAMETER Priqdepth 
        Queue depth threshold value per priorirty level. If the queue size (number of requests in the queue of that particular priorirty) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level. 
         
        Maximum value = 4294967294 
    .PARAMETER Maxconn 
        Maximum number of concurrent connections that can be open for requests that matches with rule. 
         
        Maximum value = 4294967294 
    .PARAMETER Delay 
        Delay threshold, in microseconds, for requests that match the policy's rule. If the delay statistics gathered for the matching request exceed the specified delay, configured action triggered for that request, if there is no action then requests are dropped to the lowest priority level. 
         
        Maximum value = 599999999 
    .PARAMETER Dostrigexpression 
        Optional expression to add second level check to trigger DoS actions. Specifically used for Analytics based DoS response generation. 
    .PARAMETER Dosaction 
        DoS Action to take when vserver will be considered under DoS attack and corresponding rule matches. Mandatory if AppQoE actions are to be used for DoS attack prevention. 
        Possible values = SimpleResponse, HICResponse 
    .PARAMETER Tcpprofile 
        Bind TCP Profile based on L2/L3/L7 parameters. 
    .PARAMETER Retryonreset 
        Retry on TCP Reset. 
         
        Possible values = YES, NO 
    .PARAMETER Retryontimeout 
        Retry on request Timeout(in millisec) upon sending request to backend servers. 
         
        Maximum value = 2000 
    .PARAMETER Numretries 
        Retry count. 
         
         
        Maximum value = 7 
    .PARAMETER PassThru 
        Return details about the created appqoeaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAppqoeaction -name <string>
        An example how to update appqoeaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAppqoeaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoeaction/
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

        [ValidateSet('HIGH', 'MEDIUM', 'LOW', 'LOWEST')]
        [string]$Priority,

        [ValidateLength(1, 127)]
        [string]$Altcontentsvcname,

        [ValidateLength(4, 127)]
        [string]$Altcontentpath,

        [double]$Polqdepth,

        [double]$Priqdepth,

        [double]$Maxconn,

        [double]$Delay,

        [string]$Dostrigexpression,

        [ValidateSet('SimpleResponse', 'HICResponse')]
        [string]$Dosaction,

        [ValidateLength(1, 127)]
        [string]$Tcpprofile,

        [ValidateSet('YES', 'NO')]
        [string]$Retryonreset,

        [double]$Retryontimeout,

        [double]$Numretries,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAppqoeaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('altcontentsvcname') ) { $payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ( $PSBoundParameters.ContainsKey('altcontentpath') ) { $payload.Add('altcontentpath', $altcontentpath) }
            if ( $PSBoundParameters.ContainsKey('polqdepth') ) { $payload.Add('polqdepth', $polqdepth) }
            if ( $PSBoundParameters.ContainsKey('priqdepth') ) { $payload.Add('priqdepth', $priqdepth) }
            if ( $PSBoundParameters.ContainsKey('maxconn') ) { $payload.Add('maxconn', $maxconn) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('dostrigexpression') ) { $payload.Add('dostrigexpression', $dostrigexpression) }
            if ( $PSBoundParameters.ContainsKey('dosaction') ) { $payload.Add('dosaction', $dosaction) }
            if ( $PSBoundParameters.ContainsKey('tcpprofile') ) { $payload.Add('tcpprofile', $tcpprofile) }
            if ( $PSBoundParameters.ContainsKey('retryonreset') ) { $payload.Add('retryonreset', $retryonreset) }
            if ( $PSBoundParameters.ContainsKey('retryontimeout') ) { $payload.Add('retryontimeout', $retryontimeout) }
            if ( $PSBoundParameters.ContainsKey('numretries') ) { $payload.Add('numretries', $numretries) }
            if ( $PSCmdlet.ShouldProcess("appqoeaction", "Update Application Level Quality of Experience configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type appqoeaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppqoeaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAppqoeaction: Finished"
    }
}

function Invoke-NSAddAppqoeaction {
    <#
    .SYNOPSIS
        Add Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for AppQoS action resource.
    .PARAMETER Name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER Priority 
        Priority for queuing the request. If server resources are not available for a request that matches the configured rule, this option specifies a priority for queuing the request until the server resources are available again. If priority is not configured then Lowest priority will be used to queue the request. 
        Possible values = HIGH, MEDIUM, LOW, LOWEST 
    .PARAMETER Respondwith 
        Responder action to be taken when the threshold is reached. Available settings function as follows: 
        ACS - Serve content from an alternative content service 
        Threshold : maxConn or delay 
        NS - Serve from the Citrix ADC (built-in response) 
        Threshold : maxConn or delay. 
        Possible values = ACS, NS 
    .PARAMETER Customfile 
        name of the HTML page object to use as the response. 
    .PARAMETER Altcontentsvcname 
        Name of the alternative content service to be used in the ACS. 
    .PARAMETER Altcontentpath 
        Path to the alternative content service to be used in the ACS. 
    .PARAMETER Polqdepth 
        Policy queue depth threshold value. When the policy queue size (number of requests queued for the policy binding this action is attached to) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level. 
         
        Maximum value = 4294967294 
    .PARAMETER Priqdepth 
        Queue depth threshold value per priorirty level. If the queue size (number of requests in the queue of that particular priorirty) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level. 
         
        Maximum value = 4294967294 
    .PARAMETER Maxconn 
        Maximum number of concurrent connections that can be open for requests that matches with rule. 
         
        Maximum value = 4294967294 
    .PARAMETER Delay 
        Delay threshold, in microseconds, for requests that match the policy's rule. If the delay statistics gathered for the matching request exceed the specified delay, configured action triggered for that request, if there is no action then requests are dropped to the lowest priority level. 
         
        Maximum value = 599999999 
    .PARAMETER Dostrigexpression 
        Optional expression to add second level check to trigger DoS actions. Specifically used for Analytics based DoS response generation. 
    .PARAMETER Dosaction 
        DoS Action to take when vserver will be considered under DoS attack and corresponding rule matches. Mandatory if AppQoE actions are to be used for DoS attack prevention. 
        Possible values = SimpleResponse, HICResponse 
    .PARAMETER Tcpprofile 
        Bind TCP Profile based on L2/L3/L7 parameters. 
    .PARAMETER Retryonreset 
        Retry on TCP Reset. 
         
        Possible values = YES, NO 
    .PARAMETER Retryontimeout 
        Retry on request Timeout(in millisec) upon sending request to backend servers. 
         
        Maximum value = 2000 
    .PARAMETER Numretries 
        Retry count. 
         
         
        Maximum value = 7 
    .PARAMETER PassThru 
        Return details about the created appqoeaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAppqoeaction -name <string>
        An example how to add appqoeaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddAppqoeaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoeaction/
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

        [ValidateSet('HIGH', 'MEDIUM', 'LOW', 'LOWEST')]
        [string]$Priority,

        [ValidateSet('ACS', 'NS')]
        [string]$Respondwith,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Customfile,

        [ValidateLength(1, 127)]
        [string]$Altcontentsvcname,

        [ValidateLength(4, 127)]
        [string]$Altcontentpath,

        [double]$Polqdepth,

        [double]$Priqdepth,

        [double]$Maxconn,

        [double]$Delay,

        [string]$Dostrigexpression,

        [ValidateSet('SimpleResponse', 'HICResponse')]
        [string]$Dosaction,

        [ValidateLength(1, 127)]
        [string]$Tcpprofile,

        [ValidateSet('YES', 'NO')]
        [string]$Retryonreset = 'NO',

        [double]$Retryontimeout,

        [double]$Numretries = '3',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAppqoeaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('respondwith') ) { $payload.Add('respondwith', $respondwith) }
            if ( $PSBoundParameters.ContainsKey('customfile') ) { $payload.Add('customfile', $customfile) }
            if ( $PSBoundParameters.ContainsKey('altcontentsvcname') ) { $payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ( $PSBoundParameters.ContainsKey('altcontentpath') ) { $payload.Add('altcontentpath', $altcontentpath) }
            if ( $PSBoundParameters.ContainsKey('polqdepth') ) { $payload.Add('polqdepth', $polqdepth) }
            if ( $PSBoundParameters.ContainsKey('priqdepth') ) { $payload.Add('priqdepth', $priqdepth) }
            if ( $PSBoundParameters.ContainsKey('maxconn') ) { $payload.Add('maxconn', $maxconn) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('dostrigexpression') ) { $payload.Add('dostrigexpression', $dostrigexpression) }
            if ( $PSBoundParameters.ContainsKey('dosaction') ) { $payload.Add('dosaction', $dosaction) }
            if ( $PSBoundParameters.ContainsKey('tcpprofile') ) { $payload.Add('tcpprofile', $tcpprofile) }
            if ( $PSBoundParameters.ContainsKey('retryonreset') ) { $payload.Add('retryonreset', $retryonreset) }
            if ( $PSBoundParameters.ContainsKey('retryontimeout') ) { $payload.Add('retryontimeout', $retryontimeout) }
            if ( $PSBoundParameters.ContainsKey('numretries') ) { $payload.Add('numretries', $numretries) }
            if ( $PSCmdlet.ShouldProcess("appqoeaction", "Add Application Level Quality of Experience configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appqoeaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppqoeaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAppqoeaction: Finished"
    }
}

function Invoke-NSGetAppqoeaction {
    <#
    .SYNOPSIS
        Get Application Level Quality of Experience configuration config object(s).
    .DESCRIPTION
        Configuration for AppQoS action resource.
    .PARAMETER Name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER GetAll 
        Retrieve all appqoeaction object(s).
    .PARAMETER Count
        If specified, the count of the appqoeaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoeaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppqoeaction -GetAll 
        Get all appqoeaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppqoeaction -Count 
        Get the number of appqoeaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoeaction -name <string>
        Get appqoeaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoeaction -Filter @{ 'name'='<value>' }
        Get appqoeaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppqoeaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoeaction/
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
        Write-Verbose "Invoke-NSGetAppqoeaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appqoeaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoeaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoeaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoeaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoeaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppqoeaction: Ended"
    }
}

function Invoke-NSChangeAppqoecustomresp {
    <#
    .SYNOPSIS
        Change Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for AppQoE custom response page resource.
    .PARAMETER Name 
        Indicates name of the custom response HTML page to import/update.
    .EXAMPLE
        PS C:\>Invoke-NSChangeAppqoecustomresp -name <string>
        An example how to change appqoecustomresp config Object(s).
    .NOTES
        File Name : Invoke-NSChangeAppqoecustomresp
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoecustomresp/
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
        [ValidateLength(1, 31)]
        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-NSChangeAppqoecustomresp: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess("appqoecustomresp", "Change Application Level Quality of Experience configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appqoecustomresp -Action update -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSChangeAppqoecustomresp: Finished"
    }
}

function Invoke-NSImportAppqoecustomresp {
    <#
    .SYNOPSIS
        Import Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for AppQoE custom response page resource.
    .PARAMETER Src 
        . 
    .PARAMETER Name 
        Indicates name of the custom response HTML page to import/update.
    .EXAMPLE
        PS C:\>Invoke-NSImportAppqoecustomresp -name <string>
        An example how to import appqoecustomresp config Object(s).
    .NOTES
        File Name : Invoke-NSImportAppqoecustomresp
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoecustomresp/
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

        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateLength(1, 31)]
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-NSImportAppqoecustomresp: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('src') ) { $payload.Add('src', $src) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Application Level Quality of Experience configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appqoecustomresp -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSImportAppqoecustomresp: Finished"
    }
}

function Invoke-NSDeleteAppqoecustomresp {
    <#
    .SYNOPSIS
        Delete Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for AppQoE custom response page resource.
    .PARAMETER Name 
        Indicates name of the custom response HTML page to import/update.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAppqoecustomresp -Name <string>
        An example how to delete appqoecustomresp config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAppqoecustomresp
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoecustomresp/
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
        Write-Verbose "Invoke-NSDeleteAppqoecustomresp: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Level Quality of Experience configuration config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type appqoecustomresp -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAppqoecustomresp: Finished"
    }
}

function Invoke-NSGetAppqoecustomresp {
    <#
    .SYNOPSIS
        Get Application Level Quality of Experience configuration config object(s).
    .DESCRIPTION
        Configuration for AppQoE custom response page resource.
    .PARAMETER GetAll 
        Retrieve all appqoecustomresp object(s).
    .PARAMETER Count
        If specified, the count of the appqoecustomresp object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoecustomresp
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppqoecustomresp -GetAll 
        Get all appqoecustomresp data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppqoecustomresp -Count 
        Get the number of appqoecustomresp objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoecustomresp -name <string>
        Get appqoecustomresp object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoecustomresp -Filter @{ 'name'='<value>' }
        Get appqoecustomresp data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppqoecustomresp
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoecustomresp/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetAppqoecustomresp: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appqoecustomresp objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoecustomresp objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoecustomresp objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoecustomresp configuration for property ''"

            } else {
                Write-Verbose "Retrieving appqoecustomresp configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppqoecustomresp: Ended"
    }
}

function Invoke-NSUnsetAppqoeparameter {
    <#
    .SYNOPSIS
        Unset Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for QOS parameter resource.
    .PARAMETER Sessionlife 
        Time, in seconds, between the first time and the next time the AppQoE alternative content window is displayed. The alternative content window is displayed only once during a session for the same browser accessing a configured URL, so this parameter determines the length of a session. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Avgwaitingclient 
        average number of client connections, that can sit in service waiting queue. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Maxaltrespbandwidth 
        maximum bandwidth which will determine whether to send alternate content response. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Dosattackthresh 
        average number of client connection that can queue up on vserver level without triggering DoS mitigation module. 
         
         
        Maximum value = 4294967294
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAppqoeparameter 
        An example how to unset appqoeparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAppqoeparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoeparameter
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

        [Boolean]$sessionlife,

        [Boolean]$avgwaitingclient,

        [Boolean]$maxaltrespbandwidth,

        [Boolean]$dosattackthresh 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAppqoeparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sessionlife') ) { $payload.Add('sessionlife', $sessionlife) }
            if ( $PSBoundParameters.ContainsKey('avgwaitingclient') ) { $payload.Add('avgwaitingclient', $avgwaitingclient) }
            if ( $PSBoundParameters.ContainsKey('maxaltrespbandwidth') ) { $payload.Add('maxaltrespbandwidth', $maxaltrespbandwidth) }
            if ( $PSBoundParameters.ContainsKey('dosattackthresh') ) { $payload.Add('dosattackthresh', $dosattackthresh) }
            if ( $PSCmdlet.ShouldProcess("appqoeparameter", "Unset Application Level Quality of Experience configuration config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type appqoeparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAppqoeparameter: Finished"
    }
}

function Invoke-NSUpdateAppqoeparameter {
    <#
    .SYNOPSIS
        Update Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for QOS parameter resource.
    .PARAMETER Sessionlife 
        Time, in seconds, between the first time and the next time the AppQoE alternative content window is displayed. The alternative content window is displayed only once during a session for the same browser accessing a configured URL, so this parameter determines the length of a session. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Avgwaitingclient 
        average number of client connections, that can sit in service waiting queue. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Maxaltrespbandwidth 
        maximum bandwidth which will determine whether to send alternate content response. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Dosattackthresh 
        average number of client connection that can queue up on vserver level without triggering DoS mitigation module. 
         
         
        Maximum value = 4294967294
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAppqoeparameter 
        An example how to update appqoeparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAppqoeparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoeparameter/
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

        [double]$Sessionlife,

        [double]$Avgwaitingclient,

        [double]$Maxaltrespbandwidth,

        [double]$Dosattackthresh 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAppqoeparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sessionlife') ) { $payload.Add('sessionlife', $sessionlife) }
            if ( $PSBoundParameters.ContainsKey('avgwaitingclient') ) { $payload.Add('avgwaitingclient', $avgwaitingclient) }
            if ( $PSBoundParameters.ContainsKey('maxaltrespbandwidth') ) { $payload.Add('maxaltrespbandwidth', $maxaltrespbandwidth) }
            if ( $PSBoundParameters.ContainsKey('dosattackthresh') ) { $payload.Add('dosattackthresh', $dosattackthresh) }
            if ( $PSCmdlet.ShouldProcess("appqoeparameter", "Update Application Level Quality of Experience configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type appqoeparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateAppqoeparameter: Finished"
    }
}

function Invoke-NSGetAppqoeparameter {
    <#
    .SYNOPSIS
        Get Application Level Quality of Experience configuration config object(s).
    .DESCRIPTION
        Configuration for QOS parameter resource.
    .PARAMETER GetAll 
        Retrieve all appqoeparameter object(s).
    .PARAMETER Count
        If specified, the count of the appqoeparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoeparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppqoeparameter -GetAll 
        Get all appqoeparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoeparameter -name <string>
        Get appqoeparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoeparameter -Filter @{ 'name'='<value>' }
        Get appqoeparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppqoeparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoeparameter/
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
        Write-Verbose "Invoke-NSGetAppqoeparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appqoeparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoeparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoeparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoeparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving appqoeparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppqoeparameter: Ended"
    }
}

function Invoke-NSUpdateAppqoepolicy {
    <#
    .SYNOPSIS
        Update Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for AppQoS policy resource.
    .PARAMETER Name 
        . 
    .PARAMETER Rule 
        Expression or name of a named expression, against which the request is evaluated. The policy is applied if the rule evaluates to true. 
    .PARAMETER Action 
        Configured AppQoE action to trigger. 
    .PARAMETER PassThru 
        Return details about the created appqoepolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAppqoepolicy -name <string>
        An example how to update appqoepolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAppqoepolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoepolicy/
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
        Write-Verbose "Invoke-NSUpdateAppqoepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("appqoepolicy", "Update Application Level Quality of Experience configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type appqoepolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppqoepolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAppqoepolicy: Finished"
    }
}

function Invoke-NSAddAppqoepolicy {
    <#
    .SYNOPSIS
        Add Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for AppQoS policy resource.
    .PARAMETER Name 
        . 
    .PARAMETER Rule 
        Expression or name of a named expression, against which the request is evaluated. The policy is applied if the rule evaluates to true. 
    .PARAMETER Action 
        Configured AppQoE action to trigger. 
    .PARAMETER PassThru 
        Return details about the created appqoepolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAppqoepolicy -name <string> -rule <string> -action <string>
        An example how to add appqoepolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddAppqoepolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoepolicy/
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
        Write-Verbose "Invoke-NSAddAppqoepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("appqoepolicy", "Add Application Level Quality of Experience configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appqoepolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppqoepolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAppqoepolicy: Finished"
    }
}

function Invoke-NSDeleteAppqoepolicy {
    <#
    .SYNOPSIS
        Delete Application Level Quality of Experience configuration config Object.
    .DESCRIPTION
        Configuration for AppQoS policy resource.
    .PARAMETER Name 
        .
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAppqoepolicy -Name <string>
        An example how to delete appqoepolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAppqoepolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoepolicy/
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
        Write-Verbose "Invoke-NSDeleteAppqoepolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Level Quality of Experience configuration config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type appqoepolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAppqoepolicy: Finished"
    }
}

function Invoke-NSGetAppqoepolicy {
    <#
    .SYNOPSIS
        Get Application Level Quality of Experience configuration config object(s).
    .DESCRIPTION
        Configuration for AppQoS policy resource.
    .PARAMETER Name 
        . 
    .PARAMETER GetAll 
        Retrieve all appqoepolicy object(s).
    .PARAMETER Count
        If specified, the count of the appqoepolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoepolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppqoepolicy -GetAll 
        Get all appqoepolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppqoepolicy -Count 
        Get the number of appqoepolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoepolicy -name <string>
        Get appqoepolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoepolicy -Filter @{ 'name'='<value>' }
        Get appqoepolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppqoepolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoepolicy/
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
        Write-Verbose "Invoke-NSGetAppqoepolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appqoepolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoepolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoepolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoepolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoepolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppqoepolicy: Ended"
    }
}

function Invoke-NSGetAppqoepolicyBinding {
    <#
    .SYNOPSIS
        Get Application Level Quality of Experience configuration config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appqoepolicy.
    .PARAMETER Name 
        . 
    .PARAMETER GetAll 
        Retrieve all appqoepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appqoepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoepolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppqoepolicyBinding -GetAll 
        Get all appqoepolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoepolicyBinding -name <string>
        Get appqoepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoepolicyBinding -Filter @{ 'name'='<value>' }
        Get appqoepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppqoepolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoepolicy_binding/
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
        Write-Verbose "Invoke-NSGetAppqoepolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appqoepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoepolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppqoepolicyBinding: Ended"
    }
}

function Invoke-NSGetAppqoepolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get Application Level Quality of Experience configuration config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to appqoepolicy.
    .PARAMETER Name 
        . 
    .PARAMETER GetAll 
        Retrieve all appqoepolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the appqoepolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoepolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppqoepolicyLbvserverBinding -GetAll 
        Get all appqoepolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppqoepolicyLbvserverBinding -Count 
        Get the number of appqoepolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoepolicyLbvserverBinding -name <string>
        Get appqoepolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppqoepolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get appqoepolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppqoepolicyLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appqoe/appqoepolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetAppqoepolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appqoepolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoepolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoepolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoepolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoepolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppqoepolicyLbvserverBinding: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBI9Jiyyzh0fdb0
# /Gc007iYltsuPFYaS8Gh3LrZ+uqVsaCCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQgJ5hGzw6Vr4276GXKT3zBwTaJtEOSDdrL4/IJ4coYAXYwDQYJ
# KoZIhvcNAQEBBQAEggEAcn6d03T7HOxqLfvjLqL4Kng/0bWHQJu82KtR+S3LZjFi
# M/KONqq+S5kYLRRwpGHSwP24S6m5T6VItkLxzmUyfBE19B8NXJbEchI7hiersLaP
# 4j9ML/TUOa9/9nudQYaCCznYDNEWN8s2FP/5Y1vwAU/+QLOjt1rwzTsyQnuRqeRk
# kk39FjdpktdJUK5qJMJohF9wmOB3J4KhR5cx8JYD+maNf6Pz0G2viaRBqI12CrQ0
# Ry/Iw4hlNmWI8iw2HcPIz0+WjFpsigPvBfj/swsKoTiz8j4Chkq/TxGgonGeNel7
# h4f1GTs4V91wuVx+AbLstA0HhStRPYf5kPemzS5YwKGCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQxMjVaMD8GCSqG
# SIb3DQEJBDEyBDBpcktMQZy5syvzirJ9Hev46vLWx3Xf2F1beKLTd5sEdAGw7JIz
# CX4chqBHSVkGPeQwDQYJKoZIhvcNAQEBBQAEggIAcBhGEwEWlw3ViUaZUJBHlG2I
# 0vYXWRydQpX65o1csXYlWn8ynmKdphIybNzPIpB+HA0sTWUJ02u7GQSmGVuXwmuR
# CXpcoUiltuemQIvG3jMWY8htLhNlG6T6iGwYniU+UAAP+NOdHgQXy6sM82uVtUrA
# mJ8DX7Cu4RfxaIPXDDoKx3xXJdGpFDmK4Tj1ATvx57WkDtIzvAkmx770DP/sqJoe
# OFZxpAWY2c532snKUZ/6KW00w1ucRkx+egXAJvDeAdkBp9DFA14tYeOrDJ6PfFu5
# SFd3JYfugNlbn2lmQs45aGMjfHdS1M/CAK8SE+Nt3rxo6dMA1rpbGTAlX/l5UwEr
# BDf9pDpZ4kS+I/5/aihIUoh1AiLirxdOPwehYlrmV1Dgzoqw40c5dBH9n5X+9FnQ
# OGRlyyzohaTpHXCRAfFVq8z4YMvhAAJyhn7R9IqEADB5NuutgSWbGfqTQ/h5RwLR
# Rj5klZ16Mt6sZeBVjl5l2rYe3yON5aKsqmkW3V40TSCPJtKu8O8RlIh5sMtW7OId
# PJkdpQI0Pi6qxxHFuZQO/1/T0jwe5jfGnLoVfeP5nc4bMXc5ry0KJ7UjeMj+2A90
# hndDAFu933gPAgwL1KXm5uZtS1PQeTB9rPTJ9c9JcL+ZEBwVgSeHtETEhCmbVTqf
# 4hTkTuXUcLw2d/qeGmE=
# SIG # End signature block
