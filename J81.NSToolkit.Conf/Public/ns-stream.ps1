function Invoke-NSAddStreamidentifier {
    <#
    .SYNOPSIS
        Add Stream configuration. config Object.
    .DESCRIPTION
        Configuration for identifier resource.
    .PARAMETER Name 
        The name of stream identifier. 
    .PARAMETER Selectorname 
        Name of the selector to use with the stream identifier. 
    .PARAMETER Interval 
        Number of minutes of data to use when calculating session statistics (number of requests, bandwidth, and response times). The interval is a moving window that keeps the most recently collected data. Older data is discarded at regular intervals. 
    .PARAMETER Samplecount 
        Size of the sample from which to select a request for evaluation. The smaller the sample count, the more accurate is the statistical data. To evaluate all requests, set the sample count to 1. However, such a low setting can result in excessive consumption of memory and processing resources. 
         
         
        Maximum value = 65535 
    .PARAMETER Sort 
        Sort stored records by the specified statistics column, in descending order. Performed during data collection, the sorting enables real-time data evaluation through Citrix ADC policies (for example, compression and caching policies) that use functions such as IS_TOP(n). 
         
        Possible values = REQUESTS, CONNECTIONS, RESPTIME, BANDWIDTH, RESPTIME_BREACHES, NONE 
    .PARAMETER Snmptrap 
        Enable/disable SNMP trap for stream identifier. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Appflowlog 
        Enable/disable Appflow logging for stream identifier. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trackackonlypackets 
        Track ack only packets as well. This setting is applicable only when packet rate limiting is being used. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tracktransactions 
        Track transactions exceeding configured threshold. Transaction tracking can be enabled for following metric: ResponseTime. 
        By default transaction tracking is disabled. 
         
        Possible values = RESPTIME, NONE 
    .PARAMETER Maxtransactionthreshold 
        Maximum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Mintransactionthreshold 
        Minimum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Acceptancethreshold 
        Non-Breaching transactions to Total transactions threshold expressed in percent. 
        Maximum of 6 decimal places is supported. 
    .PARAMETER Breachthreshold 
        Breaching transactions threshold calculated over interval. 
    .PARAMETER PassThru 
        Return details about the created streamidentifier item.
    .EXAMPLE
        PS C:\>Invoke-NSAddStreamidentifier -name <string> -selectorname <string>
        An example how to add streamidentifier config Object(s).
    .NOTES
        File Name : Invoke-NSAddStreamidentifier
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamidentifier/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Selectorname,

        [double]$Interval = '1',

        [double]$Samplecount = '1',

        [ValidateSet('REQUESTS', 'CONNECTIONS', 'RESPTIME', 'BANDWIDTH', 'RESPTIME_BREACHES', 'NONE')]
        [string]$Sort = 'REQUESTS',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Snmptrap = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Trackackonlypackets = 'DISABLED',

        [ValidateSet('RESPTIME', 'NONE')]
        [string]$Tracktransactions = 'NONE',

        [double]$Maxtransactionthreshold = '0',

        [double]$Mintransactionthreshold = '0',

        [string]$Acceptancethreshold = '0.000000',

        [double]$Breachthreshold = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddStreamidentifier: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                selectorname   = $selectorname
            }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('samplecount') ) { $payload.Add('samplecount', $samplecount) }
            if ( $PSBoundParameters.ContainsKey('sort') ) { $payload.Add('sort', $sort) }
            if ( $PSBoundParameters.ContainsKey('snmptrap') ) { $payload.Add('snmptrap', $snmptrap) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('trackackonlypackets') ) { $payload.Add('trackackonlypackets', $trackackonlypackets) }
            if ( $PSBoundParameters.ContainsKey('tracktransactions') ) { $payload.Add('tracktransactions', $tracktransactions) }
            if ( $PSBoundParameters.ContainsKey('maxtransactionthreshold') ) { $payload.Add('maxtransactionthreshold', $maxtransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('mintransactionthreshold') ) { $payload.Add('mintransactionthreshold', $mintransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('acceptancethreshold') ) { $payload.Add('acceptancethreshold', $acceptancethreshold) }
            if ( $PSBoundParameters.ContainsKey('breachthreshold') ) { $payload.Add('breachthreshold', $breachthreshold) }
            if ( $PSCmdlet.ShouldProcess("streamidentifier", "Add Stream configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type streamidentifier -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetStreamidentifier -Filter $payload)
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
        Write-Verbose "Invoke-NSAddStreamidentifier: Finished"
    }
}

function Invoke-NSUpdateStreamidentifier {
    <#
    .SYNOPSIS
        Update Stream configuration. config Object.
    .DESCRIPTION
        Configuration for identifier resource.
    .PARAMETER Name 
        The name of stream identifier. 
    .PARAMETER Selectorname 
        Name of the selector to use with the stream identifier. 
    .PARAMETER Interval 
        Number of minutes of data to use when calculating session statistics (number of requests, bandwidth, and response times). The interval is a moving window that keeps the most recently collected data. Older data is discarded at regular intervals. 
    .PARAMETER Samplecount 
        Size of the sample from which to select a request for evaluation. The smaller the sample count, the more accurate is the statistical data. To evaluate all requests, set the sample count to 1. However, such a low setting can result in excessive consumption of memory and processing resources. 
         
         
        Maximum value = 65535 
    .PARAMETER Sort 
        Sort stored records by the specified statistics column, in descending order. Performed during data collection, the sorting enables real-time data evaluation through Citrix ADC policies (for example, compression and caching policies) that use functions such as IS_TOP(n). 
         
        Possible values = REQUESTS, CONNECTIONS, RESPTIME, BANDWIDTH, RESPTIME_BREACHES, NONE 
    .PARAMETER Snmptrap 
        Enable/disable SNMP trap for stream identifier. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Appflowlog 
        Enable/disable Appflow logging for stream identifier. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trackackonlypackets 
        Track ack only packets as well. This setting is applicable only when packet rate limiting is being used. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tracktransactions 
        Track transactions exceeding configured threshold. Transaction tracking can be enabled for following metric: ResponseTime. 
        By default transaction tracking is disabled. 
         
        Possible values = RESPTIME, NONE 
    .PARAMETER Maxtransactionthreshold 
        Maximum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Mintransactionthreshold 
        Minimum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Acceptancethreshold 
        Non-Breaching transactions to Total transactions threshold expressed in percent. 
        Maximum of 6 decimal places is supported. 
    .PARAMETER Breachthreshold 
        Breaching transactions threshold calculated over interval. 
    .PARAMETER PassThru 
        Return details about the created streamidentifier item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateStreamidentifier -name <string>
        An example how to update streamidentifier config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateStreamidentifier
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamidentifier/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Selectorname,

        [double]$Interval,

        [double]$Samplecount,

        [ValidateSet('REQUESTS', 'CONNECTIONS', 'RESPTIME', 'BANDWIDTH', 'RESPTIME_BREACHES', 'NONE')]
        [string]$Sort,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Snmptrap,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Trackackonlypackets,

        [ValidateSet('RESPTIME', 'NONE')]
        [string]$Tracktransactions,

        [double]$Maxtransactionthreshold,

        [double]$Mintransactionthreshold,

        [string]$Acceptancethreshold,

        [double]$Breachthreshold,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateStreamidentifier: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('selectorname') ) { $payload.Add('selectorname', $selectorname) }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('samplecount') ) { $payload.Add('samplecount', $samplecount) }
            if ( $PSBoundParameters.ContainsKey('sort') ) { $payload.Add('sort', $sort) }
            if ( $PSBoundParameters.ContainsKey('snmptrap') ) { $payload.Add('snmptrap', $snmptrap) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('trackackonlypackets') ) { $payload.Add('trackackonlypackets', $trackackonlypackets) }
            if ( $PSBoundParameters.ContainsKey('tracktransactions') ) { $payload.Add('tracktransactions', $tracktransactions) }
            if ( $PSBoundParameters.ContainsKey('maxtransactionthreshold') ) { $payload.Add('maxtransactionthreshold', $maxtransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('mintransactionthreshold') ) { $payload.Add('mintransactionthreshold', $mintransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('acceptancethreshold') ) { $payload.Add('acceptancethreshold', $acceptancethreshold) }
            if ( $PSBoundParameters.ContainsKey('breachthreshold') ) { $payload.Add('breachthreshold', $breachthreshold) }
            if ( $PSCmdlet.ShouldProcess("streamidentifier", "Update Stream configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type streamidentifier -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetStreamidentifier -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateStreamidentifier: Finished"
    }
}

function Invoke-NSUnsetStreamidentifier {
    <#
    .SYNOPSIS
        Unset Stream configuration. config Object.
    .DESCRIPTION
        Configuration for identifier resource.
    .PARAMETER Name 
        The name of stream identifier. 
    .PARAMETER Selectorname 
        Name of the selector to use with the stream identifier. 
    .PARAMETER Interval 
        Number of minutes of data to use when calculating session statistics (number of requests, bandwidth, and response times). The interval is a moving window that keeps the most recently collected data. Older data is discarded at regular intervals. 
    .PARAMETER Samplecount 
        Size of the sample from which to select a request for evaluation. The smaller the sample count, the more accurate is the statistical data. To evaluate all requests, set the sample count to 1. However, such a low setting can result in excessive consumption of memory and processing resources. 
         
         
        Maximum value = 65535 
    .PARAMETER Sort 
        Sort stored records by the specified statistics column, in descending order. Performed during data collection, the sorting enables real-time data evaluation through Citrix ADC policies (for example, compression and caching policies) that use functions such as IS_TOP(n). 
         
        Possible values = REQUESTS, CONNECTIONS, RESPTIME, BANDWIDTH, RESPTIME_BREACHES, NONE 
    .PARAMETER Snmptrap 
        Enable/disable SNMP trap for stream identifier. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Appflowlog 
        Enable/disable Appflow logging for stream identifier. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trackackonlypackets 
        Track ack only packets as well. This setting is applicable only when packet rate limiting is being used. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tracktransactions 
        Track transactions exceeding configured threshold. Transaction tracking can be enabled for following metric: ResponseTime. 
        By default transaction tracking is disabled. 
         
        Possible values = RESPTIME, NONE 
    .PARAMETER Maxtransactionthreshold 
        Maximum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Mintransactionthreshold 
        Minimum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Acceptancethreshold 
        Non-Breaching transactions to Total transactions threshold expressed in percent. 
        Maximum of 6 decimal places is supported. 
    .PARAMETER Breachthreshold 
        Breaching transactions threshold calculated over interval.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetStreamidentifier -name <string>
        An example how to unset streamidentifier config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetStreamidentifier
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamidentifier
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

        [Boolean]$selectorname,

        [Boolean]$interval,

        [Boolean]$samplecount,

        [Boolean]$sort,

        [Boolean]$snmptrap,

        [Boolean]$appflowlog,

        [Boolean]$trackackonlypackets,

        [Boolean]$tracktransactions,

        [Boolean]$maxtransactionthreshold,

        [Boolean]$mintransactionthreshold,

        [Boolean]$acceptancethreshold,

        [Boolean]$breachthreshold 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetStreamidentifier: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('selectorname') ) { $payload.Add('selectorname', $selectorname) }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('samplecount') ) { $payload.Add('samplecount', $samplecount) }
            if ( $PSBoundParameters.ContainsKey('sort') ) { $payload.Add('sort', $sort) }
            if ( $PSBoundParameters.ContainsKey('snmptrap') ) { $payload.Add('snmptrap', $snmptrap) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('trackackonlypackets') ) { $payload.Add('trackackonlypackets', $trackackonlypackets) }
            if ( $PSBoundParameters.ContainsKey('tracktransactions') ) { $payload.Add('tracktransactions', $tracktransactions) }
            if ( $PSBoundParameters.ContainsKey('maxtransactionthreshold') ) { $payload.Add('maxtransactionthreshold', $maxtransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('mintransactionthreshold') ) { $payload.Add('mintransactionthreshold', $mintransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('acceptancethreshold') ) { $payload.Add('acceptancethreshold', $acceptancethreshold) }
            if ( $PSBoundParameters.ContainsKey('breachthreshold') ) { $payload.Add('breachthreshold', $breachthreshold) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Stream configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type streamidentifier -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetStreamidentifier: Finished"
    }
}

function Invoke-NSDeleteStreamidentifier {
    <#
    .SYNOPSIS
        Delete Stream configuration. config Object.
    .DESCRIPTION
        Configuration for identifier resource.
    .PARAMETER Name 
        The name of stream identifier.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteStreamidentifier -Name <string>
        An example how to delete streamidentifier config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteStreamidentifier
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamidentifier/
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
        Write-Verbose "Invoke-NSDeleteStreamidentifier: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Stream configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type streamidentifier -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteStreamidentifier: Finished"
    }
}

function Invoke-NSGetStreamidentifier {
    <#
    .SYNOPSIS
        Get Stream configuration. config object(s).
    .DESCRIPTION
        Configuration for identifier resource.
    .PARAMETER Name 
        The name of stream identifier. 
    .PARAMETER GetAll 
        Retrieve all streamidentifier object(s).
    .PARAMETER Count
        If specified, the count of the streamidentifier object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamidentifier
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetStreamidentifier -GetAll 
        Get all streamidentifier data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetStreamidentifier -Count 
        Get the number of streamidentifier objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamidentifier -name <string>
        Get streamidentifier object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamidentifier -Filter @{ 'name'='<value>' }
        Get streamidentifier data with a filter.
    .NOTES
        File Name : Invoke-NSGetStreamidentifier
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamidentifier/
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
        Write-Verbose "Invoke-NSGetStreamidentifier: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all streamidentifier objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamidentifier objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamidentifier objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamidentifier configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving streamidentifier configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetStreamidentifier: Ended"
    }
}

function Invoke-NSGetStreamidentifierBinding {
    <#
    .SYNOPSIS
        Get Stream configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to streamidentifier.
    .PARAMETER Name 
        The name of stream identifier. 
    .PARAMETER GetAll 
        Retrieve all streamidentifier_binding object(s).
    .PARAMETER Count
        If specified, the count of the streamidentifier_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamidentifierBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetStreamidentifierBinding -GetAll 
        Get all streamidentifier_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamidentifierBinding -name <string>
        Get streamidentifier_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamidentifierBinding -Filter @{ 'name'='<value>' }
        Get streamidentifier_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetStreamidentifierBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamidentifier_binding/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetStreamidentifierBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all streamidentifier_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamidentifier_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamidentifier_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamidentifier_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving streamidentifier_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetStreamidentifierBinding: Ended"
    }
}

function Invoke-NSGetStreamidentifierStreamsessionBinding {
    <#
    .SYNOPSIS
        Get Stream configuration. config object(s).
    .DESCRIPTION
        Binding object showing the streamsession that can be bound to streamidentifier.
    .PARAMETER GetAll 
        Retrieve all streamidentifier_streamsession_binding object(s).
    .PARAMETER Count
        If specified, the count of the streamidentifier_streamsession_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamidentifierStreamsessionBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetStreamidentifierStreamsessionBinding -GetAll 
        Get all streamidentifier_streamsession_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetStreamidentifierStreamsessionBinding -Count 
        Get the number of streamidentifier_streamsession_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamidentifierStreamsessionBinding -name <string>
        Get streamidentifier_streamsession_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamidentifierStreamsessionBinding -Filter @{ 'name'='<value>' }
        Get streamidentifier_streamsession_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetStreamidentifierStreamsessionBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamidentifier_streamsession_binding/
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
        Write-Verbose "Invoke-NSGetStreamidentifierStreamsessionBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all streamidentifier_streamsession_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamidentifier_streamsession_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamidentifier_streamsession_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamidentifier_streamsession_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving streamidentifier_streamsession_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetStreamidentifierStreamsessionBinding: Ended"
    }
}

function Invoke-NSAddStreamselector {
    <#
    .SYNOPSIS
        Add Stream configuration. config Object.
    .DESCRIPTION
        Configuration for selector resource.
    .PARAMETER Name 
        Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector'). 
    .PARAMETER Rule 
        Set of up to five expressions. Maximum length: 7499 characters. Each expression must identify a specific request characteristic, such as the client's IP address (with CLIENT.IP.SRC) or requested server resource (with HTTP.REQ.URL). 
        Note: If two or more selectors contain the same expressions in different order, a separate set of records is created for each selector. 
    .PARAMETER PassThru 
        Return details about the created streamselector item.
    .EXAMPLE
        PS C:\>Invoke-NSAddStreamselector -name <string>
        An example how to add streamselector config Object(s).
    .NOTES
        File Name : Invoke-NSAddStreamselector
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamselector/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Rule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddStreamselector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSCmdlet.ShouldProcess("streamselector", "Add Stream configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type streamselector -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetStreamselector -Filter $payload)
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
        Write-Verbose "Invoke-NSAddStreamselector: Finished"
    }
}

function Invoke-NSUpdateStreamselector {
    <#
    .SYNOPSIS
        Update Stream configuration. config Object.
    .DESCRIPTION
        Configuration for selector resource.
    .PARAMETER Name 
        Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector'). 
    .PARAMETER Rule 
        Set of up to five expressions. Maximum length: 7499 characters. Each expression must identify a specific request characteristic, such as the client's IP address (with CLIENT.IP.SRC) or requested server resource (with HTTP.REQ.URL). 
        Note: If two or more selectors contain the same expressions in different order, a separate set of records is created for each selector. 
    .PARAMETER PassThru 
        Return details about the created streamselector item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateStreamselector -name <string>
        An example how to update streamselector config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateStreamselector
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamselector/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Rule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateStreamselector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSCmdlet.ShouldProcess("streamselector", "Update Stream configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type streamselector -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetStreamselector -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateStreamselector: Finished"
    }
}

function Invoke-NSDeleteStreamselector {
    <#
    .SYNOPSIS
        Delete Stream configuration. config Object.
    .DESCRIPTION
        Configuration for selector resource.
    .PARAMETER Name 
        Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector').
    .EXAMPLE
        PS C:\>Invoke-NSDeleteStreamselector -Name <string>
        An example how to delete streamselector config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteStreamselector
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamselector/
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
        Write-Verbose "Invoke-NSDeleteStreamselector: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Stream configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type streamselector -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteStreamselector: Finished"
    }
}

function Invoke-NSGetStreamselector {
    <#
    .SYNOPSIS
        Get Stream configuration. config object(s).
    .DESCRIPTION
        Configuration for selector resource.
    .PARAMETER Name 
        Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector'). 
    .PARAMETER GetAll 
        Retrieve all streamselector object(s).
    .PARAMETER Count
        If specified, the count of the streamselector object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamselector
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetStreamselector -GetAll 
        Get all streamselector data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetStreamselector -Count 
        Get the number of streamselector objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamselector -name <string>
        Get streamselector object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetStreamselector -Filter @{ 'name'='<value>' }
        Get streamselector data with a filter.
    .NOTES
        File Name : Invoke-NSGetStreamselector
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamselector/
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
        Write-Verbose "Invoke-NSGetStreamselector: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all streamselector objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamselector objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamselector objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamselector configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving streamselector configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetStreamselector: Ended"
    }
}

function Invoke-NSClearStreamsession {
    <#
    .SYNOPSIS
        Clear Stream configuration. config Object.
    .DESCRIPTION
        Configuration for active connection resource.
    .PARAMETER Name 
        Name of the stream identifier.
    .EXAMPLE
        PS C:\>Invoke-NSClearStreamsession -name <string>
        An example how to clear streamsession config Object(s).
    .NOTES
        File Name : Invoke-NSClearStreamsession
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/stream/streamsession/
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
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-NSClearStreamsession: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear Stream configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type streamsession -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSClearStreamsession: Finished"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBCJRO1pixsI10/
# 2xlyM7taRq3rbpns99pSjwmiSVCVyaCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgti/OmBx/F4q1K14mD+o6BgJQn4Y6T2W/do1AJiS1boAwDQYJKoZIhvcNAQEB
# BQAEggEABV853XNOMpcZC4Mnza4kflS779LpplEVWDK3ggwXF3BB9alNFIbboL+p
# w2dZgE4m8+2Dtxxag/U/qVZ+5X0G5Gbu66ao4S3G+ZmfsXG9PgJGSf4QZ+QDMGdc
# WFvfgbN1kZrvSwE7ZmXu7mA90JW+jn9WcTaE2Ak7GYQSPmt9ZOQCrwcz1HZnOb3O
# mCe/SRxqqaxDNaSXE+QeuCbjbeqojQWljrdjvkWtYEvxWM80rlzbdgDzsbsfOlrJ
# oF7eXpiYDovepHlFeVbxG4Ir/in/Zi1i46h1UgNW7tOGrrMUOvE+fzQdHijpoMtu
# Ar0a3zuQo67bG5k7GB4oIDpxehWdtA==
# SIG # End signature block
