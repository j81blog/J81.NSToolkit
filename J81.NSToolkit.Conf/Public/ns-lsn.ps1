function Invoke-NSAddLsnappsattributes {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Application Attributes resource.
    .PARAMETER Name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Transportprotocol 
        Name of the protocol(TCP,UDP) for which the parameters of this LSN application port ATTRIBUTES applies. 
        Possible values = TCP, UDP, ICMP 
    .PARAMETER Port 
        This is used for Displaying Port/Port range in CLI/Nitro.Lowport, Highport values are populated and used for displaying.Port numbers or range of port numbers to match against the destination port of the incoming packet from a subscriber. When the destination port is matched, the LSN application profile is applied for the LSN session. Separate a range of ports with a hyphen. For example, 40-90. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. 
         
         
        Maximum value = 600 
    .PARAMETER PassThru 
        Return details about the created lsnappsattributes item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnappsattributes -name <string> -transportprotocol <string>
        An example how to add lsnappsattributes config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnappsattributes
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsattributes/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('TCP', 'UDP', 'ICMP')]
        [string]$Transportprotocol,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Port,

        [double]$Sessiontimeout = '30',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnappsattributes: Starting"
    }
    process {
        try {
            $payload = @{ name    = $name
                transportprotocol = $transportprotocol
            }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSCmdlet.ShouldProcess("lsnappsattributes", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnappsattributes -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnappsattributes -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnappsattributes: Finished"
    }
}

function Invoke-NSDeleteLsnappsattributes {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Application Attributes resource.
    .PARAMETER Name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnappsattributes -Name <string>
        An example how to delete lsnappsattributes config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnappsattributes
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsattributes/
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
        Write-Verbose "Invoke-NSDeleteLsnappsattributes: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnappsattributes -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnappsattributes: Finished"
    }
}

function Invoke-NSUpdateLsnappsattributes {
    <#
    .SYNOPSIS
        Update Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Application Attributes resource.
    .PARAMETER Name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. 
         
         
        Maximum value = 600 
    .PARAMETER PassThru 
        Return details about the created lsnappsattributes item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLsnappsattributes -name <string>
        An example how to update lsnappsattributes config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLsnappsattributes
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsattributes/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [double]$Sessiontimeout,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLsnappsattributes: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSCmdlet.ShouldProcess("lsnappsattributes", "Update Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsattributes -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnappsattributes -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateLsnappsattributes: Finished"
    }
}

function Invoke-NSUnsetLsnappsattributes {
    <#
    .SYNOPSIS
        Unset Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Application Attributes resource.
    .PARAMETER Name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. 
         
         
        Maximum value = 600
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLsnappsattributes -name <string>
        An example how to unset lsnappsattributes config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLsnappsattributes
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsattributes
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [Boolean]$sessiontimeout 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLsnappsattributes: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type lsnappsattributes -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLsnappsattributes: Finished"
    }
}

function Invoke-NSGetLsnappsattributes {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN Application Attributes resource.
    .PARAMETER Name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnappsattributes object(s).
    .PARAMETER Count
        If specified, the count of the lsnappsattributes object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsattributes
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnappsattributes -GetAll 
        Get all lsnappsattributes data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnappsattributes -Count 
        Get the number of lsnappsattributes objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsattributes -name <string>
        Get lsnappsattributes object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsattributes -Filter @{ 'name'='<value>' }
        Get lsnappsattributes data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnappsattributes
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsattributes/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-NSGetLsnappsattributes: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnappsattributes objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsattributes objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsattributes objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsattributes configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsattributes configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnappsattributes: Ended"
    }
}

function Invoke-NSAddLsnappsprofile {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Application Profile resource.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Transportprotocol 
        Name of the protocol for which the parameters of this LSN application profile applies. 
        Possible values = TCP, UDP, ICMP 
    .PARAMETER Ippooling 
        NAT IP address allocation options for sessions associated with the same subscriber. 
         
        Available options function as follows: 
        * Paired - The Citrix ADC allocates the same NAT IP address for all sessions associated with the same subscriber. When all the ports of a NAT IP address are used in LSN sessions (for same or multiple subscribers), the Citrix ADC ADC drops any new connection from the subscriber. 
        * Random - The Citrix ADC allocates random NAT IP addresses, from the pool, for different sessions associated with the same subscriber. 
         
        This parameter is applicable to dynamic NAT allocation only. 
         
        Possible values = PAIRED, RANDOM 
    .PARAMETER Mapping 
        Type of LSN mapping to apply to subsequent packets originating from the same subscriber IP address and port. 
         
        Consider an example of an LSN mapping that includes the mapping of the subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
         
        Available options function as follows: 
         
        * ENDPOINT-INDEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to any external IP address and port. 
         
        * ADDRESS-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to the same external IP address (Y), regardless of the external port. 
         
        * ADDRESS-PORT-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same internal IP address and port (X:x) to the same external IP address and port (Y:y) while the mapping is still active. 
         
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Filtering 
        Type of filter to apply to packets originating from external hosts. 
         
        Consider an example of an LSN mapping that includes the mapping of subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
         
        Available options function as follows: 
        * ENDPOINT INDEPENDENT - Filters out only packets not destined to the subscriber IP address and port X:x, regardless of the external host IP address and port source (Z:z). The Citrix ADC forwards any packets destined to X:x. In other words, sending packets from the subscriber to any external IP address is sufficient to allow packets from any external hosts to the subscriber. 
         
        * ADDRESS DEPENDENT - Filters out packets not destined to subscriber IP address and port X:x. In addition, the ADC filters out packets from Y:y destined for the subscriber (X:x) if the client has not previously sent packets to Y:anyport (external port independent). In other words, receiving packets from a specific external host requires that the subscriber first send packets to that specific external host's IP address. 
         
        * ADDRESS PORT DEPENDENT (the default) - Filters out packets not destined to subscriber IP address and port (X:x). In addition, the Citrix ADC filters out packets from Y:y destined for the subscriber (X:x) if the subscriber has not previously sent packets to Y:y. In other words, receiving packets from a specific external host requires that the subscriber first send packets first to that external IP address and port. 
         
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Tcpproxy 
        Enable TCP proxy, which enables the Citrix ADC to optimize the TCP traffic by using Layer 4 features. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Td 
        ID of the traffic domain through which the Citrix ADC sends the outbound traffic after performing LSN. 
         
        If you do not specify an ID, the ADC sends the outbound traffic through the default traffic domain, which has an ID of 0. 
    .PARAMETER L2info 
        Enable l2info by creating natpcbs for LSN, which enables the Citrix ADC to use L2CONN/MBF with LSN. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnappsprofile -appsprofilename <string> -transportprotocol <string>
        An example how to add lsnappsprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnappsprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile/
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
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [Parameter(Mandatory)]
        [ValidateSet('TCP', 'UDP', 'ICMP')]
        [string]$Transportprotocol,

        [ValidateSet('PAIRED', 'RANDOM')]
        [string]$Ippooling = 'RANDOM',

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$Mapping = 'ADDRESS-PORT-DEPENDENT',

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$Filtering = 'ADDRESS-PORT-DEPENDENT',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Tcpproxy = 'DISABLED',

        [double]$Td = '4095',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$L2info = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnappsprofile: Starting"
    }
    process {
        try {
            $payload = @{ appsprofilename = $appsprofilename
                transportprotocol         = $transportprotocol
            }
            if ( $PSBoundParameters.ContainsKey('ippooling') ) { $payload.Add('ippooling', $ippooling) }
            if ( $PSBoundParameters.ContainsKey('mapping') ) { $payload.Add('mapping', $mapping) }
            if ( $PSBoundParameters.ContainsKey('filtering') ) { $payload.Add('filtering', $filtering) }
            if ( $PSBoundParameters.ContainsKey('tcpproxy') ) { $payload.Add('tcpproxy', $tcpproxy) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('l2info') ) { $payload.Add('l2info', $l2info) }
            if ( $PSCmdlet.ShouldProcess("lsnappsprofile", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnappsprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnappsprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnappsprofile: Finished"
    }
}

function Invoke-NSDeleteLsnappsprofile {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Application Profile resource.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnappsprofile -Appsprofilename <string>
        An example how to delete lsnappsprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnappsprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile/
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
        [string]$Appsprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnappsprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$appsprofilename", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnappsprofile -NitroPath nitro/v1/config -Resource $appsprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnappsprofile: Finished"
    }
}

function Invoke-NSUpdateLsnappsprofile {
    <#
    .SYNOPSIS
        Update Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Application Profile resource.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Ippooling 
        NAT IP address allocation options for sessions associated with the same subscriber. 
         
        Available options function as follows: 
        * Paired - The Citrix ADC allocates the same NAT IP address for all sessions associated with the same subscriber. When all the ports of a NAT IP address are used in LSN sessions (for same or multiple subscribers), the Citrix ADC ADC drops any new connection from the subscriber. 
        * Random - The Citrix ADC allocates random NAT IP addresses, from the pool, for different sessions associated with the same subscriber. 
         
        This parameter is applicable to dynamic NAT allocation only. 
         
        Possible values = PAIRED, RANDOM 
    .PARAMETER Mapping 
        Type of LSN mapping to apply to subsequent packets originating from the same subscriber IP address and port. 
         
        Consider an example of an LSN mapping that includes the mapping of the subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
         
        Available options function as follows: 
         
        * ENDPOINT-INDEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to any external IP address and port. 
         
        * ADDRESS-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to the same external IP address (Y), regardless of the external port. 
         
        * ADDRESS-PORT-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same internal IP address and port (X:x) to the same external IP address and port (Y:y) while the mapping is still active. 
         
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Filtering 
        Type of filter to apply to packets originating from external hosts. 
         
        Consider an example of an LSN mapping that includes the mapping of subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
         
        Available options function as follows: 
        * ENDPOINT INDEPENDENT - Filters out only packets not destined to the subscriber IP address and port X:x, regardless of the external host IP address and port source (Z:z). The Citrix ADC forwards any packets destined to X:x. In other words, sending packets from the subscriber to any external IP address is sufficient to allow packets from any external hosts to the subscriber. 
         
        * ADDRESS DEPENDENT - Filters out packets not destined to subscriber IP address and port X:x. In addition, the ADC filters out packets from Y:y destined for the subscriber (X:x) if the client has not previously sent packets to Y:anyport (external port independent). In other words, receiving packets from a specific external host requires that the subscriber first send packets to that specific external host's IP address. 
         
        * ADDRESS PORT DEPENDENT (the default) - Filters out packets not destined to subscriber IP address and port (X:x). In addition, the Citrix ADC filters out packets from Y:y destined for the subscriber (X:x) if the subscriber has not previously sent packets to Y:y. In other words, receiving packets from a specific external host requires that the subscriber first send packets first to that external IP address and port. 
         
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Tcpproxy 
        Enable TCP proxy, which enables the Citrix ADC to optimize the TCP traffic by using Layer 4 features. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Td 
        ID of the traffic domain through which the Citrix ADC sends the outbound traffic after performing LSN. 
         
        If you do not specify an ID, the ADC sends the outbound traffic through the default traffic domain, which has an ID of 0. 
    .PARAMETER L2info 
        Enable l2info by creating natpcbs for LSN, which enables the Citrix ADC to use L2CONN/MBF with LSN. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLsnappsprofile -appsprofilename <string>
        An example how to update lsnappsprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLsnappsprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile/
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
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [ValidateSet('PAIRED', 'RANDOM')]
        [string]$Ippooling,

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$Mapping,

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$Filtering,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Tcpproxy,

        [double]$Td,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$L2info,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLsnappsprofile: Starting"
    }
    process {
        try {
            $payload = @{ appsprofilename = $appsprofilename }
            if ( $PSBoundParameters.ContainsKey('ippooling') ) { $payload.Add('ippooling', $ippooling) }
            if ( $PSBoundParameters.ContainsKey('mapping') ) { $payload.Add('mapping', $mapping) }
            if ( $PSBoundParameters.ContainsKey('filtering') ) { $payload.Add('filtering', $filtering) }
            if ( $PSBoundParameters.ContainsKey('tcpproxy') ) { $payload.Add('tcpproxy', $tcpproxy) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('l2info') ) { $payload.Add('l2info', $l2info) }
            if ( $PSCmdlet.ShouldProcess("lsnappsprofile", "Update Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnappsprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateLsnappsprofile: Finished"
    }
}

function Invoke-NSUnsetLsnappsprofile {
    <#
    .SYNOPSIS
        Unset Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Application Profile resource.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Ippooling 
        NAT IP address allocation options for sessions associated with the same subscriber. 
         
        Available options function as follows: 
        * Paired - The Citrix ADC allocates the same NAT IP address for all sessions associated with the same subscriber. When all the ports of a NAT IP address are used in LSN sessions (for same or multiple subscribers), the Citrix ADC ADC drops any new connection from the subscriber. 
        * Random - The Citrix ADC allocates random NAT IP addresses, from the pool, for different sessions associated with the same subscriber. 
         
        This parameter is applicable to dynamic NAT allocation only. 
         
        Possible values = PAIRED, RANDOM 
    .PARAMETER Mapping 
        Type of LSN mapping to apply to subsequent packets originating from the same subscriber IP address and port. 
         
        Consider an example of an LSN mapping that includes the mapping of the subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
         
        Available options function as follows: 
         
        * ENDPOINT-INDEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to any external IP address and port. 
         
        * ADDRESS-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to the same external IP address (Y), regardless of the external port. 
         
        * ADDRESS-PORT-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same internal IP address and port (X:x) to the same external IP address and port (Y:y) while the mapping is still active. 
         
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Filtering 
        Type of filter to apply to packets originating from external hosts. 
         
        Consider an example of an LSN mapping that includes the mapping of subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
         
        Available options function as follows: 
        * ENDPOINT INDEPENDENT - Filters out only packets not destined to the subscriber IP address and port X:x, regardless of the external host IP address and port source (Z:z). The Citrix ADC forwards any packets destined to X:x. In other words, sending packets from the subscriber to any external IP address is sufficient to allow packets from any external hosts to the subscriber. 
         
        * ADDRESS DEPENDENT - Filters out packets not destined to subscriber IP address and port X:x. In addition, the ADC filters out packets from Y:y destined for the subscriber (X:x) if the client has not previously sent packets to Y:anyport (external port independent). In other words, receiving packets from a specific external host requires that the subscriber first send packets to that specific external host's IP address. 
         
        * ADDRESS PORT DEPENDENT (the default) - Filters out packets not destined to subscriber IP address and port (X:x). In addition, the Citrix ADC filters out packets from Y:y destined for the subscriber (X:x) if the subscriber has not previously sent packets to Y:y. In other words, receiving packets from a specific external host requires that the subscriber first send packets first to that external IP address and port. 
         
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Tcpproxy 
        Enable TCP proxy, which enables the Citrix ADC to optimize the TCP traffic by using Layer 4 features. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Td 
        ID of the traffic domain through which the Citrix ADC sends the outbound traffic after performing LSN. 
         
        If you do not specify an ID, the ADC sends the outbound traffic through the default traffic domain, which has an ID of 0. 
    .PARAMETER L2info 
        Enable l2info by creating natpcbs for LSN, which enables the Citrix ADC to use L2CONN/MBF with LSN. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLsnappsprofile -appsprofilename <string>
        An example how to unset lsnappsprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLsnappsprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile
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
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [Boolean]$ippooling,

        [Boolean]$mapping,

        [Boolean]$filtering,

        [Boolean]$tcpproxy,

        [Boolean]$td,

        [Boolean]$l2info 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLsnappsprofile: Starting"
    }
    process {
        try {
            $payload = @{ appsprofilename = $appsprofilename }
            if ( $PSBoundParameters.ContainsKey('ippooling') ) { $payload.Add('ippooling', $ippooling) }
            if ( $PSBoundParameters.ContainsKey('mapping') ) { $payload.Add('mapping', $mapping) }
            if ( $PSBoundParameters.ContainsKey('filtering') ) { $payload.Add('filtering', $filtering) }
            if ( $PSBoundParameters.ContainsKey('tcpproxy') ) { $payload.Add('tcpproxy', $tcpproxy) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('l2info') ) { $payload.Add('l2info', $l2info) }
            if ( $PSCmdlet.ShouldProcess("$appsprofilename", "Unset Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type lsnappsprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLsnappsprofile: Finished"
    }
}

function Invoke-NSGetLsnappsprofile {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN Application Profile resource.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnappsprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsnappsprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnappsprofile -GetAll 
        Get all lsnappsprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnappsprofile -Count 
        Get the number of lsnappsprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofile -name <string>
        Get lsnappsprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofile -Filter @{ 'name'='<value>' }
        Get lsnappsprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnappsprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile/
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
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

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
        Write-Verbose "Invoke-NSGetLsnappsprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnappsprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile configuration for property 'appsprofilename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnappsprofile: Ended"
    }
}

function Invoke-NSGetLsnappsprofileBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnappsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnappsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnappsprofileBinding -GetAll 
        Get all lsnappsprofile_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofileBinding -name <string>
        Get lsnappsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofileBinding -Filter @{ 'name'='<value>' }
        Get lsnappsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnappsprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnappsprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnappsprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile_binding configuration for property 'appsprofilename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnappsprofileBinding: Ended"
    }
}

function Invoke-NSAddLsnappsprofileLsnappsattributesBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnappsattributes that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Appsattributesname 
        Name of the LSN application port ATTRIBUTES command to bind to the specified LSN Appsprofile. Properties of the Appsprofile will be applicable to this APPSATTRIBUTES. 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile_lsnappsattributes_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnappsprofileLsnappsattributesBinding -appsprofilename <string>
        An example how to add lsnappsprofile_lsnappsattributes_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnappsprofileLsnappsattributesBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile_lsnappsattributes_binding/
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
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [string]$Appsattributesname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnappsprofileLsnappsattributesBinding: Starting"
    }
    process {
        try {
            $payload = @{ appsprofilename = $appsprofilename }
            if ( $PSBoundParameters.ContainsKey('appsattributesname') ) { $payload.Add('appsattributesname', $appsattributesname) }
            if ( $PSCmdlet.ShouldProcess("lsnappsprofile_lsnappsattributes_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsprofile_lsnappsattributes_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnappsprofileLsnappsattributesBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnappsprofileLsnappsattributesBinding: Finished"
    }
}

function Invoke-NSDeleteLsnappsprofileLsnappsattributesBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnappsattributes that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Appsattributesname 
        Name of the LSN application port ATTRIBUTES command to bind to the specified LSN Appsprofile. Properties of the Appsprofile will be applicable to this APPSATTRIBUTES.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnappsprofileLsnappsattributesBinding -Appsprofilename <string>
        An example how to delete lsnappsprofile_lsnappsattributes_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnappsprofileLsnappsattributesBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile_lsnappsattributes_binding/
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
        [string]$Appsprofilename,

        [string]$Appsattributesname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnappsprofileLsnappsattributesBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Appsattributesname') ) { $arguments.Add('appsattributesname', $Appsattributesname) }
            if ( $PSCmdlet.ShouldProcess("$appsprofilename", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnappsprofileLsnappsattributesBinding: Finished"
    }
}

function Invoke-NSGetLsnappsprofileLsnappsattributesBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the lsnappsattributes that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnappsprofile_lsnappsattributes_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnappsprofile_lsnappsattributes_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofileLsnappsattributesBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnappsprofileLsnappsattributesBinding -GetAll 
        Get all lsnappsprofile_lsnappsattributes_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnappsprofileLsnappsattributesBinding -Count 
        Get the number of lsnappsprofile_lsnappsattributes_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofileLsnappsattributesBinding -name <string>
        Get lsnappsprofile_lsnappsattributes_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofileLsnappsattributesBinding -Filter @{ 'name'='<value>' }
        Get lsnappsprofile_lsnappsattributes_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnappsprofileLsnappsattributesBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile_lsnappsattributes_binding/
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
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnappsprofileLsnappsattributesBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnappsprofile_lsnappsattributes_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile_lsnappsattributes_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile_lsnappsattributes_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile_lsnappsattributes_binding configuration for property 'appsprofilename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile_lsnappsattributes_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnappsprofileLsnappsattributesBinding: Ended"
    }
}

function Invoke-NSAddLsnappsprofilePortBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the port that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Lsnport 
        Port numbers or range of port numbers to match against the destination port of the incoming packet from a subscriber. When the destination port is matched, the LSN application profile is applied for the LSN session. Separate a range of ports with a hyphen. For example, 40-90. 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile_port_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnappsprofilePortBinding -appsprofilename <string>
        An example how to add lsnappsprofile_port_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnappsprofilePortBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile_port_binding/
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
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Lsnport,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnappsprofilePortBinding: Starting"
    }
    process {
        try {
            $payload = @{ appsprofilename = $appsprofilename }
            if ( $PSBoundParameters.ContainsKey('lsnport') ) { $payload.Add('lsnport', $lsnport) }
            if ( $PSCmdlet.ShouldProcess("lsnappsprofile_port_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsprofile_port_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnappsprofilePortBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnappsprofilePortBinding: Finished"
    }
}

function Invoke-NSDeleteLsnappsprofilePortBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the port that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Lsnport 
        Port numbers or range of port numbers to match against the destination port of the incoming packet from a subscriber. When the destination port is matched, the LSN application profile is applied for the LSN session. Separate a range of ports with a hyphen. For example, 40-90.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnappsprofilePortBinding -Appsprofilename <string>
        An example how to delete lsnappsprofile_port_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnappsprofilePortBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile_port_binding/
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
        [string]$Appsprofilename,

        [string]$Lsnport 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnappsprofilePortBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Lsnport') ) { $arguments.Add('lsnport', $Lsnport) }
            if ( $PSCmdlet.ShouldProcess("$appsprofilename", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnappsprofilePortBinding: Finished"
    }
}

function Invoke-NSGetLsnappsprofilePortBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the port that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnappsprofile_port_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnappsprofile_port_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofilePortBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnappsprofilePortBinding -GetAll 
        Get all lsnappsprofile_port_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnappsprofilePortBinding -Count 
        Get the number of lsnappsprofile_port_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofilePortBinding -name <string>
        Get lsnappsprofile_port_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnappsprofilePortBinding -Filter @{ 'name'='<value>' }
        Get lsnappsprofile_port_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnappsprofilePortBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnappsprofile_port_binding/
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
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnappsprofilePortBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnappsprofile_port_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile_port_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile_port_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile_port_binding configuration for property 'appsprofilename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile_port_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnappsprofilePortBinding: Ended"
    }
}

function Invoke-NSAddLsnclient {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for lsn client resource.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER PassThru 
        Return details about the created lsnclient item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnclient -clientname <string>
        An example how to add lsnclient config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnclient
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnclient: Starting"
    }
    process {
        try {
            $payload = @{ clientname = $clientname }

            if ( $PSCmdlet.ShouldProcess("lsnclient", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnclient -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnclient -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnclient: Finished"
    }
}

function Invoke-NSDeleteLsnclient {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for lsn client resource.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnclient -Clientname <string>
        An example how to delete lsnclient config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnclient
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient/
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
        [string]$Clientname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnclient: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$clientname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnclient -NitroPath nitro/v1/config -Resource $clientname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnclient: Finished"
    }
}

function Invoke-NSGetLsnclient {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for lsn client resource.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclient
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclient -GetAll 
        Get all lsnclient data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclient -Count 
        Get the number of lsnclient objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclient -name <string>
        Get lsnclient object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclient -Filter @{ 'name'='<value>' }
        Get lsnclient data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnclient
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,

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
        Write-Verbose "Invoke-NSGetLsnclient: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnclient objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient configuration for property 'clientname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnclient: Ended"
    }
}

function Invoke-NSGetLsnclientBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclientBinding -GetAll 
        Get all lsnclient_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientBinding -name <string>
        Get lsnclient_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientBinding -Filter @{ 'name'='<value>' }
        Get lsnclient_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnclientBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_binding/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnclientBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnclient_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_binding configuration for property 'clientname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnclientBinding: Ended"
    }
}

function Invoke-NSAddLsnclientNetwork6Binding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the network6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Network 
        IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Netmask 
        Subnet mask for the IPv4 address specified in the Network parameter. 
    .PARAMETER Network6 
        IPv6 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
         
         
        Maximum value = 4094 
    .PARAMETER PassThru 
        Return details about the created lsnclient_network6_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnclientNetwork6Binding -clientname <string>
        An example how to add lsnclient_network6_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnclientNetwork6Binding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_network6_binding/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Network,

        [string]$Netmask,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Network6,

        [double]$Td = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnclientNetwork6Binding: Starting"
    }
    process {
        try {
            $payload = @{ clientname = $clientname }
            if ( $PSBoundParameters.ContainsKey('network') ) { $payload.Add('network', $network) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('network6') ) { $payload.Add('network6', $network6) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSCmdlet.ShouldProcess("lsnclient_network6_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_network6_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnclientNetwork6Binding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnclientNetwork6Binding: Finished"
    }
}

function Invoke-NSDeleteLsnclientNetwork6Binding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the network6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Network 
        IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Netmask 
        Subnet mask for the IPv4 address specified in the Network parameter. 
    .PARAMETER Network6 
        IPv6 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
         
         
        Maximum value = 4094
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnclientNetwork6Binding -Clientname <string>
        An example how to delete lsnclient_network6_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnclientNetwork6Binding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_network6_binding/
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
        [string]$Clientname,

        [string]$Network,

        [string]$Netmask,

        [string]$Network6,

        [double]$Td 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnclientNetwork6Binding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Network') ) { $arguments.Add('network', $Network) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSBoundParameters.ContainsKey('Network6') ) { $arguments.Add('network6', $Network6) }
            if ( $PSBoundParameters.ContainsKey('Td') ) { $arguments.Add('td', $Td) }
            if ( $PSCmdlet.ShouldProcess("$clientname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnclientNetwork6Binding: Finished"
    }
}

function Invoke-NSGetLsnclientNetwork6Binding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the network6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient_network6_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient_network6_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNetwork6Binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclientNetwork6Binding -GetAll 
        Get all lsnclient_network6_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclientNetwork6Binding -Count 
        Get the number of lsnclient_network6_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNetwork6Binding -name <string>
        Get lsnclient_network6_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNetwork6Binding -Filter @{ 'name'='<value>' }
        Get lsnclient_network6_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnclientNetwork6Binding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_network6_binding/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnclientNetwork6Binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnclient_network6_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_network6_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_network6_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_network6_binding configuration for property 'clientname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_network6_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnclientNetwork6Binding: Ended"
    }
}

function Invoke-NSAddLsnclientNetworkBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the network that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Network 
        IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Netmask 
        Subnet mask for the IPv4 address specified in the Network parameter. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
         
         
        Maximum value = 4094 
    .PARAMETER PassThru 
        Return details about the created lsnclient_network_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnclientNetworkBinding -clientname <string>
        An example how to add lsnclient_network_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnclientNetworkBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_network_binding/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Network,

        [string]$Netmask,

        [double]$Td = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnclientNetworkBinding: Starting"
    }
    process {
        try {
            $payload = @{ clientname = $clientname }
            if ( $PSBoundParameters.ContainsKey('network') ) { $payload.Add('network', $network) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSCmdlet.ShouldProcess("lsnclient_network_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_network_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnclientNetworkBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnclientNetworkBinding: Finished"
    }
}

function Invoke-NSDeleteLsnclientNetworkBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the network that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Network 
        IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Netmask 
        Subnet mask for the IPv4 address specified in the Network parameter. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
         
         
        Maximum value = 4094
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnclientNetworkBinding -Clientname <string>
        An example how to delete lsnclient_network_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnclientNetworkBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_network_binding/
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
        [string]$Clientname,

        [string]$Network,

        [string]$Netmask,

        [double]$Td 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnclientNetworkBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Network') ) { $arguments.Add('network', $Network) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSBoundParameters.ContainsKey('Td') ) { $arguments.Add('td', $Td) }
            if ( $PSCmdlet.ShouldProcess("$clientname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnclient_network_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnclientNetworkBinding: Finished"
    }
}

function Invoke-NSGetLsnclientNetworkBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the network that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient_network_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient_network_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNetworkBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclientNetworkBinding -GetAll 
        Get all lsnclient_network_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclientNetworkBinding -Count 
        Get the number of lsnclient_network_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNetworkBinding -name <string>
        Get lsnclient_network_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNetworkBinding -Filter @{ 'name'='<value>' }
        Get lsnclient_network_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnclientNetworkBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_network_binding/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnclientNetworkBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnclient_network_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_network_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_network_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_network_binding configuration for property 'clientname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_network_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnclientNetworkBinding: Ended"
    }
}

function Invoke-NSAddLsnclientNsacl6Binding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the nsacl6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Acl6name 
        Name of any configured extended ACL6 whose action is ALLOW. The condition specified in the extended ACL6 rule is used as the condition for the LSN client. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
         
         
        Maximum value = 4094 
    .PARAMETER PassThru 
        Return details about the created lsnclient_nsacl6_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnclientNsacl6Binding -clientname <string>
        An example how to add lsnclient_nsacl6_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnclientNsacl6Binding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_nsacl6_binding/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Acl6name,

        [double]$Td = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnclientNsacl6Binding: Starting"
    }
    process {
        try {
            $payload = @{ clientname = $clientname }
            if ( $PSBoundParameters.ContainsKey('acl6name') ) { $payload.Add('acl6name', $acl6name) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSCmdlet.ShouldProcess("lsnclient_nsacl6_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_nsacl6_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnclientNsacl6Binding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnclientNsacl6Binding: Finished"
    }
}

function Invoke-NSDeleteLsnclientNsacl6Binding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the nsacl6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Acl6name 
        Name of any configured extended ACL6 whose action is ALLOW. The condition specified in the extended ACL6 rule is used as the condition for the LSN client. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
         
         
        Maximum value = 4094
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnclientNsacl6Binding -Clientname <string>
        An example how to delete lsnclient_nsacl6_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnclientNsacl6Binding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_nsacl6_binding/
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
        [string]$Clientname,

        [string]$Acl6name,

        [double]$Td 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnclientNsacl6Binding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Acl6name') ) { $arguments.Add('acl6name', $Acl6name) }
            if ( $PSBoundParameters.ContainsKey('Td') ) { $arguments.Add('td', $Td) }
            if ( $PSCmdlet.ShouldProcess("$clientname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnclientNsacl6Binding: Finished"
    }
}

function Invoke-NSGetLsnclientNsacl6Binding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the nsacl6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient_nsacl6_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient_nsacl6_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNsacl6Binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclientNsacl6Binding -GetAll 
        Get all lsnclient_nsacl6_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclientNsacl6Binding -Count 
        Get the number of lsnclient_nsacl6_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNsacl6Binding -name <string>
        Get lsnclient_nsacl6_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNsacl6Binding -Filter @{ 'name'='<value>' }
        Get lsnclient_nsacl6_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnclientNsacl6Binding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_nsacl6_binding/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnclientNsacl6Binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnclient_nsacl6_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_nsacl6_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_nsacl6_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_nsacl6_binding configuration for property 'clientname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_nsacl6_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnclientNsacl6Binding: Ended"
    }
}

function Invoke-NSAddLsnclientNsaclBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the nsacl that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Aclname 
        Name(s) of any configured extended ACL(s) whose action is ALLOW. The condition specified in the extended ACL rule identifies the traffic from an LSN subscriber for which the Citrix ADC is to perform large scale NAT. . 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
         
         
        Maximum value = 4094 
    .PARAMETER PassThru 
        Return details about the created lsnclient_nsacl_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnclientNsaclBinding -clientname <string>
        An example how to add lsnclient_nsacl_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnclientNsaclBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_nsacl_binding/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Aclname,

        [double]$Td = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnclientNsaclBinding: Starting"
    }
    process {
        try {
            $payload = @{ clientname = $clientname }
            if ( $PSBoundParameters.ContainsKey('aclname') ) { $payload.Add('aclname', $aclname) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSCmdlet.ShouldProcess("lsnclient_nsacl_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_nsacl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnclientNsaclBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnclientNsaclBinding: Finished"
    }
}

function Invoke-NSDeleteLsnclientNsaclBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the nsacl that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Aclname 
        Name(s) of any configured extended ACL(s) whose action is ALLOW. The condition specified in the extended ACL rule identifies the traffic from an LSN subscriber for which the Citrix ADC is to perform large scale NAT. . 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
         
         
        Maximum value = 4094
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnclientNsaclBinding -Clientname <string>
        An example how to delete lsnclient_nsacl_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnclientNsaclBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_nsacl_binding/
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
        [string]$Clientname,

        [string]$Aclname,

        [double]$Td 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnclientNsaclBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Aclname') ) { $arguments.Add('aclname', $Aclname) }
            if ( $PSBoundParameters.ContainsKey('Td') ) { $arguments.Add('td', $Td) }
            if ( $PSCmdlet.ShouldProcess("$clientname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnclientNsaclBinding: Finished"
    }
}

function Invoke-NSGetLsnclientNsaclBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the nsacl that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient_nsacl_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient_nsacl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNsaclBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclientNsaclBinding -GetAll 
        Get all lsnclient_nsacl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnclientNsaclBinding -Count 
        Get the number of lsnclient_nsacl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNsaclBinding -name <string>
        Get lsnclient_nsacl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnclientNsaclBinding -Filter @{ 'name'='<value>' }
        Get lsnclient_nsacl_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnclientNsaclBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnclient_nsacl_binding/
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
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnclientNsaclBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnclient_nsacl_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_nsacl_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_nsacl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_nsacl_binding configuration for property 'clientname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_nsacl_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnclientNsaclBinding: Ended"
    }
}

function Invoke-NSGetLsndeterministicnat {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for deterministic NAT resource.
    .PARAMETER Clientname 
        The name of the LSN Client. 
    .PARAMETER Network6 
        IPv6 address of the LSN subscriber or B4 device. 
    .PARAMETER Subscrip 
        The Client IP address. 
    .PARAMETER Td 
        The LSN client TD. 
         
         
        Maximum value = 4094 
    .PARAMETER Natip 
        The NAT IP address. 
    .PARAMETER GetAll 
        Retrieve all lsndeterministicnat object(s).
    .PARAMETER Count
        If specified, the count of the lsndeterministicnat object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsndeterministicnat
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsndeterministicnat -GetAll 
        Get all lsndeterministicnat data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsndeterministicnat -Count 
        Get the number of lsndeterministicnat objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsndeterministicnat -name <string>
        Get lsndeterministicnat object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsndeterministicnat -Filter @{ 'name'='<value>' }
        Get lsndeterministicnat data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsndeterministicnat
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsndeterministicnat/
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
        [string]$Clientname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Network6,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Subscrip,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double]$Td,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Natip,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetLsndeterministicnat: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsndeterministicnat objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsndeterministicnat objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsndeterministicnat objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('clientname') ) { $arguments.Add('clientname', $clientname) } 
                if ( $PSBoundParameters.ContainsKey('network6') ) { $arguments.Add('network6', $network6) } 
                if ( $PSBoundParameters.ContainsKey('subscrip') ) { $arguments.Add('subscrip', $subscrip) } 
                if ( $PSBoundParameters.ContainsKey('td') ) { $arguments.Add('td', $td) } 
                if ( $PSBoundParameters.ContainsKey('natip') ) { $arguments.Add('natip', $natip) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsndeterministicnat configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsndeterministicnat configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsndeterministicnat: Ended"
    }
}

function Invoke-NSAddLsngroup {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN group resource.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Clientname 
        Name of the LSN client entity to be associated with the LSN group. You can associate only one LSN client entity with an LSN group.You cannot remove this association or replace with another LSN client entity once the LSN group is created. 
    .PARAMETER Nattype 
        Type of NAT IP address and port allocation (from the bound LSN pools) for subscribers: 
         
        Available options function as follows: 
         
        * Deterministic - Allocate a NAT IP address and a block of ports to each subscriber (of the LSN client bound to the LSN group). The Citrix ADC sequentially allocates NAT resources to these subscribers. The Citrix ADC ADC assigns the first block of ports (block size determined by the port block size parameter of the LSN group) on the beginning NAT IP address to the beginning subscriber IP address. The next range of ports is assigned to the next subscriber, and so on, until the NAT address does not have enough ports for the next subscriber. In this case, the first port block on the next NAT address is used for the subscriber, and so on. Because each subscriber now receives a deterministic NAT IP address and a block of ports, a subscriber can be identified without any need for logging. For a connection, a subscriber can be identified based only on the NAT IP address and port, and the destination IP address and port. The maximum number of LSN subscribers allowed, globally, is 1 million. 
         
        * Dynamic - Allocate a random NAT IP address and a port from the LSN NAT pool for a subscriber's connection. If port block allocation is enabled (in LSN pool) and a port block size is specified (in the LSN group), the Citrix ADC allocates a random NAT IP address and a block of ports for a subscriber when it initiates a connection for the first time. The ADC allocates this NAT IP address and a port (from the allocated block of ports) for different connections from this subscriber. If all the ports are allocated (for different subscriber's connections) from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber. 
         
        Possible values = DYNAMIC, DETERMINISTIC 
    .PARAMETER Allocpolicy 
        NAT IP and PORT block allocation policy for Deterministic NAT. Supported Policies are, 
        1: PORTS: Port blocks from single NATIP will be allocated to LSN subscribers sequentially. After all blocks are exhausted, port blocks from next NATIP will be allocated and so on. 
        2: IPADDRS(Default): One port block from each NATIP will be allocated and once all the NATIPs are over second port block from each NATIP will be allocated and so on. 
        To understand better if we assume port blocks of all NAT IPs as two dimensional array, PORTS policy follows "row major order" and IPADDRS policy follows "column major order" while allocating port blocks. 
        Example: 
        Client IPs: 2.2.2.1, 2.2.2.2 and 2.2.2.3 
        NAT IPs and PORT Blocks: 
        4.4.4.1:PB1, PB2, PB3,., PBn 
        4.4.4.2: PB1, PB2, PB3,., PBn 
        PORTS Policy: 
        2.2.2.1 =&gt; 4.4.4.1:PB1 
        2.2.2.2 =&gt; 4.4.4.1:PB2 
        2.2.2.3 =&gt; 4.4.4.1:PB3 
        IPADDRS Policy: 
        2.2.2.1 =&gt; 4.4.4.1:PB1 
        2.2.2.2 =&gt; 4.4.4.2:PB1 
        2.2.2.3 =&gt; 4.4.4.1:PB2. 
         
        Possible values = PORTS, IPADDRS 
    .PARAMETER Portblocksize 
        Size of the NAT port block to be allocated for each subscriber. 
         
        To set this parameter for Dynamic NAT, you must enable the port block allocation parameter in the bound LSN pool. For Deterministic NAT, the port block allocation parameter is always enabled, and you cannot disable it. 
         
        In Dynamic NAT, the Citrix ADC allocates a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber. 
         
        The default port block size is 256 for Deterministic NAT, and 0 for Dynamic NAT. 
         
         
        Maximum value = 65536 
    .PARAMETER Logging 
        Log mapping entries and sessions created or deleted for this LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
         
        The ADC uses its existing syslog and audit log framework to log LSN information. You must enable global level LSN logging by enabling the LSN parameter in the related NSLOG action and SYLOG action entities. When the Logging parameter is enabled, the Citrix ADC generates log messages related to LSN mappings and LSN sessions of this LSN group. The ADC then sends these log messages to servers associated with the NSLOG action and SYSLOG actions entities. 
         
        A log message for an LSN mapping entry consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN mapping entry is created or deleted 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID might be present, depending on the following conditions: 
        ** Destination IP address and port are not logged for Endpoint-Independent mapping 
        ** Only Destination IP address (and not port) is logged for Address-Dependent mapping 
        ** Destination IP address and port are logged for Address-Port-Dependent mapping. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionlogging 
        Log sessions created or deleted for the LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
         
        A log message for an LSN session consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN session is created or removed 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionsync 
        In a high availability (HA) deployment, synchronize information of all LSN sessions related to this LSN group with the secondary node. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary). 
         
        For this setting to work, you must enable the global session synchronization parameter. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Snmptraplimit 
        Maximum number of SNMP Trap messages that can be generated for the LSN group in one minute. 
         
         
        Maximum value = 10000 
    .PARAMETER Ftp 
        Enable Application Layer Gateway (ALG) for the FTP protocol. For some application-layer protocols, the IP addresses and protocol port numbers are usually communicated in the packet's payload. When acting as an ALG, the Citrix ADC changes the packet's payload to ensure that the protocol continues to work over LSN. 
         
        Note: The Citrix ADC also includes ALG for ICMP and TFTP protocols. ALG for the ICMP protocol is enabled by default, and there is no provision to disable it. ALG for the TFTP protocol is disabled by default. ALG is enabled automatically for an LSN group when you bind a UDP LSN application profile, with endpoint-independent-mapping, endpoint-independent filtering, and destination port as 69 (well-known port for TFTP), to the LSN group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pptp 
        Enable the PPTP Application Layer Gateway. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sipalg 
        Enable the SIP ALG. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rtspalg 
        Enable the RTSP ALG. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ip6profile 
        Name of the LSN ip6 profile to associate with the specified LSN group. An ip6 profile can be associated with a group only during group creation. 
         
        By default, no LSN ip6 profile is associated with an LSN group during its creation. Only one ip6profile can be associated with a group. 
    .PARAMETER Ftpcm 
        Enable the FTP connection mirroring for specified LSN group. Connection mirroring (CM or connection failover) refers to keeping active an established TCP or UDP connection when a failover occurs. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsngroup item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsngroup -groupname <string> -clientname <string>
        An example how to add lsngroup config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsngroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(Mandatory)]
        [string]$Clientname,

        [ValidateSet('DYNAMIC', 'DETERMINISTIC')]
        [string]$Nattype = 'DYNAMIC',

        [ValidateSet('PORTS', 'IPADDRS')]
        [string]$Allocpolicy = 'PORTS',

        [double]$Portblocksize = '0',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionlogging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionsync = 'ENABLED',

        [double]$Snmptraplimit = '100',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ftp = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Pptp = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sipalg = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Rtspalg = 'DISABLED',

        [ValidateLength(1, 127)]
        [string]$Ip6profile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ftpcm = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsngroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname
                clientname          = $clientname
            }
            if ( $PSBoundParameters.ContainsKey('nattype') ) { $payload.Add('nattype', $nattype) }
            if ( $PSBoundParameters.ContainsKey('allocpolicy') ) { $payload.Add('allocpolicy', $allocpolicy) }
            if ( $PSBoundParameters.ContainsKey('portblocksize') ) { $payload.Add('portblocksize', $portblocksize) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('sessionlogging') ) { $payload.Add('sessionlogging', $sessionlogging) }
            if ( $PSBoundParameters.ContainsKey('sessionsync') ) { $payload.Add('sessionsync', $sessionsync) }
            if ( $PSBoundParameters.ContainsKey('snmptraplimit') ) { $payload.Add('snmptraplimit', $snmptraplimit) }
            if ( $PSBoundParameters.ContainsKey('ftp') ) { $payload.Add('ftp', $ftp) }
            if ( $PSBoundParameters.ContainsKey('pptp') ) { $payload.Add('pptp', $pptp) }
            if ( $PSBoundParameters.ContainsKey('sipalg') ) { $payload.Add('sipalg', $sipalg) }
            if ( $PSBoundParameters.ContainsKey('rtspalg') ) { $payload.Add('rtspalg', $rtspalg) }
            if ( $PSBoundParameters.ContainsKey('ip6profile') ) { $payload.Add('ip6profile', $ip6profile) }
            if ( $PSBoundParameters.ContainsKey('ftpcm') ) { $payload.Add('ftpcm', $ftpcm) }
            if ( $PSCmdlet.ShouldProcess("lsngroup", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsngroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroup -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsngroup: Finished"
    }
}

function Invoke-NSDeleteLsngroup {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN group resource.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsngroup -Groupname <string>
        An example how to delete lsngroup config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsngroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup/
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
        Write-Verbose "Invoke-NSDeleteLsngroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsngroup -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsngroup: Finished"
    }
}

function Invoke-NSUpdateLsngroup {
    <#
    .SYNOPSIS
        Update Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN group resource.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Portblocksize 
        Size of the NAT port block to be allocated for each subscriber. 
         
        To set this parameter for Dynamic NAT, you must enable the port block allocation parameter in the bound LSN pool. For Deterministic NAT, the port block allocation parameter is always enabled, and you cannot disable it. 
         
        In Dynamic NAT, the Citrix ADC allocates a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber. 
         
        The default port block size is 256 for Deterministic NAT, and 0 for Dynamic NAT. 
         
         
        Maximum value = 65536 
    .PARAMETER Logging 
        Log mapping entries and sessions created or deleted for this LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
         
        The ADC uses its existing syslog and audit log framework to log LSN information. You must enable global level LSN logging by enabling the LSN parameter in the related NSLOG action and SYLOG action entities. When the Logging parameter is enabled, the Citrix ADC generates log messages related to LSN mappings and LSN sessions of this LSN group. The ADC then sends these log messages to servers associated with the NSLOG action and SYSLOG actions entities. 
         
        A log message for an LSN mapping entry consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN mapping entry is created or deleted 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID might be present, depending on the following conditions: 
        ** Destination IP address and port are not logged for Endpoint-Independent mapping 
        ** Only Destination IP address (and not port) is logged for Address-Dependent mapping 
        ** Destination IP address and port are logged for Address-Port-Dependent mapping. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionlogging 
        Log sessions created or deleted for the LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
         
        A log message for an LSN session consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN session is created or removed 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionsync 
        In a high availability (HA) deployment, synchronize information of all LSN sessions related to this LSN group with the secondary node. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary). 
         
        For this setting to work, you must enable the global session synchronization parameter. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Snmptraplimit 
        Maximum number of SNMP Trap messages that can be generated for the LSN group in one minute. 
         
         
        Maximum value = 10000 
    .PARAMETER Ftp 
        Enable Application Layer Gateway (ALG) for the FTP protocol. For some application-layer protocols, the IP addresses and protocol port numbers are usually communicated in the packet's payload. When acting as an ALG, the Citrix ADC changes the packet's payload to ensure that the protocol continues to work over LSN. 
         
        Note: The Citrix ADC also includes ALG for ICMP and TFTP protocols. ALG for the ICMP protocol is enabled by default, and there is no provision to disable it. ALG for the TFTP protocol is disabled by default. ALG is enabled automatically for an LSN group when you bind a UDP LSN application profile, with endpoint-independent-mapping, endpoint-independent filtering, and destination port as 69 (well-known port for TFTP), to the LSN group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pptp 
        Enable the PPTP Application Layer Gateway. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sipalg 
        Enable the SIP ALG. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rtspalg 
        Enable the RTSP ALG. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ftpcm 
        Enable the FTP connection mirroring for specified LSN group. Connection mirroring (CM or connection failover) refers to keeping active an established TCP or UDP connection when a failover occurs. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsngroup item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLsngroup -groupname <string>
        An example how to update lsngroup config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLsngroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [double]$Portblocksize,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionlogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionsync,

        [double]$Snmptraplimit,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ftp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Pptp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sipalg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Rtspalg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ftpcm,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLsngroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('portblocksize') ) { $payload.Add('portblocksize', $portblocksize) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('sessionlogging') ) { $payload.Add('sessionlogging', $sessionlogging) }
            if ( $PSBoundParameters.ContainsKey('sessionsync') ) { $payload.Add('sessionsync', $sessionsync) }
            if ( $PSBoundParameters.ContainsKey('snmptraplimit') ) { $payload.Add('snmptraplimit', $snmptraplimit) }
            if ( $PSBoundParameters.ContainsKey('ftp') ) { $payload.Add('ftp', $ftp) }
            if ( $PSBoundParameters.ContainsKey('pptp') ) { $payload.Add('pptp', $pptp) }
            if ( $PSBoundParameters.ContainsKey('sipalg') ) { $payload.Add('sipalg', $sipalg) }
            if ( $PSBoundParameters.ContainsKey('rtspalg') ) { $payload.Add('rtspalg', $rtspalg) }
            if ( $PSBoundParameters.ContainsKey('ftpcm') ) { $payload.Add('ftpcm', $ftpcm) }
            if ( $PSCmdlet.ShouldProcess("lsngroup", "Update Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroup -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateLsngroup: Finished"
    }
}

function Invoke-NSUnsetLsngroup {
    <#
    .SYNOPSIS
        Unset Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN group resource.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Portblocksize 
        Size of the NAT port block to be allocated for each subscriber. 
         
        To set this parameter for Dynamic NAT, you must enable the port block allocation parameter in the bound LSN pool. For Deterministic NAT, the port block allocation parameter is always enabled, and you cannot disable it. 
         
        In Dynamic NAT, the Citrix ADC allocates a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber. 
         
        The default port block size is 256 for Deterministic NAT, and 0 for Dynamic NAT. 
         
         
        Maximum value = 65536 
    .PARAMETER Logging 
        Log mapping entries and sessions created or deleted for this LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
         
        The ADC uses its existing syslog and audit log framework to log LSN information. You must enable global level LSN logging by enabling the LSN parameter in the related NSLOG action and SYLOG action entities. When the Logging parameter is enabled, the Citrix ADC generates log messages related to LSN mappings and LSN sessions of this LSN group. The ADC then sends these log messages to servers associated with the NSLOG action and SYSLOG actions entities. 
         
        A log message for an LSN mapping entry consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN mapping entry is created or deleted 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID might be present, depending on the following conditions: 
        ** Destination IP address and port are not logged for Endpoint-Independent mapping 
        ** Only Destination IP address (and not port) is logged for Address-Dependent mapping 
        ** Destination IP address and port are logged for Address-Port-Dependent mapping. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionlogging 
        Log sessions created or deleted for the LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
         
        A log message for an LSN session consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN session is created or removed 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionsync 
        In a high availability (HA) deployment, synchronize information of all LSN sessions related to this LSN group with the secondary node. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary). 
         
        For this setting to work, you must enable the global session synchronization parameter. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Snmptraplimit 
        Maximum number of SNMP Trap messages that can be generated for the LSN group in one minute. 
         
         
        Maximum value = 10000 
    .PARAMETER Ftp 
        Enable Application Layer Gateway (ALG) for the FTP protocol. For some application-layer protocols, the IP addresses and protocol port numbers are usually communicated in the packet's payload. When acting as an ALG, the Citrix ADC changes the packet's payload to ensure that the protocol continues to work over LSN. 
         
        Note: The Citrix ADC also includes ALG for ICMP and TFTP protocols. ALG for the ICMP protocol is enabled by default, and there is no provision to disable it. ALG for the TFTP protocol is disabled by default. ALG is enabled automatically for an LSN group when you bind a UDP LSN application profile, with endpoint-independent-mapping, endpoint-independent filtering, and destination port as 69 (well-known port for TFTP), to the LSN group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pptp 
        Enable the PPTP Application Layer Gateway. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sipalg 
        Enable the SIP ALG. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rtspalg 
        Enable the RTSP ALG. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ftpcm 
        Enable the FTP connection mirroring for specified LSN group. Connection mirroring (CM or connection failover) refers to keeping active an established TCP or UDP connection when a failover occurs. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLsngroup -groupname <string>
        An example how to unset lsngroup config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLsngroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Boolean]$portblocksize,

        [Boolean]$logging,

        [Boolean]$sessionlogging,

        [Boolean]$sessionsync,

        [Boolean]$snmptraplimit,

        [Boolean]$ftp,

        [Boolean]$pptp,

        [Boolean]$sipalg,

        [Boolean]$rtspalg,

        [Boolean]$ftpcm 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLsngroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('portblocksize') ) { $payload.Add('portblocksize', $portblocksize) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('sessionlogging') ) { $payload.Add('sessionlogging', $sessionlogging) }
            if ( $PSBoundParameters.ContainsKey('sessionsync') ) { $payload.Add('sessionsync', $sessionsync) }
            if ( $PSBoundParameters.ContainsKey('snmptraplimit') ) { $payload.Add('snmptraplimit', $snmptraplimit) }
            if ( $PSBoundParameters.ContainsKey('ftp') ) { $payload.Add('ftp', $ftp) }
            if ( $PSBoundParameters.ContainsKey('pptp') ) { $payload.Add('pptp', $pptp) }
            if ( $PSBoundParameters.ContainsKey('sipalg') ) { $payload.Add('sipalg', $sipalg) }
            if ( $PSBoundParameters.ContainsKey('rtspalg') ) { $payload.Add('rtspalg', $rtspalg) }
            if ( $PSBoundParameters.ContainsKey('ftpcm') ) { $payload.Add('ftpcm', $ftpcm) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Unset Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type lsngroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLsngroup: Finished"
    }
}

function Invoke-NSGetLsngroup {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN group resource.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroup -GetAll 
        Get all lsngroup data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroup -Count 
        Get the number of lsngroup objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroup -name <string>
        Get lsngroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroup -Filter @{ 'name'='<value>' }
        Get lsngroup data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-NSGetLsngroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsngroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroup: Ended"
    }
}

function Invoke-NSGetLsngroupBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupBinding -GetAll 
        Get all lsngroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupBinding -name <string>
        Get lsngroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupBinding -Filter @{ 'name'='<value>' }
        Get lsngroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroupBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsngroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroupBinding: Ended"
    }
}

function Invoke-NSAddLsngroupIpsecalgprofileBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the ipsecalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Ipsecalgprofile 
        Name of the IPSec ALG profile to bind to the specified LSN group. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_ipsecalgprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsngroupIpsecalgprofileBinding -groupname <string>
        An example how to add lsngroup_ipsecalgprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsngroupIpsecalgprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_ipsecalgprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Ipsecalgprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsngroupIpsecalgprofileBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('ipsecalgprofile') ) { $payload.Add('ipsecalgprofile', $ipsecalgprofile) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_ipsecalgprofile_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_ipsecalgprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroupIpsecalgprofileBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsngroupIpsecalgprofileBinding: Finished"
    }
}

function Invoke-NSDeleteLsngroupIpsecalgprofileBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the ipsecalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Ipsecalgprofile 
        Name of the IPSec ALG profile to bind to the specified LSN group.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsngroupIpsecalgprofileBinding -Groupname <string>
        An example how to delete lsngroup_ipsecalgprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsngroupIpsecalgprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_ipsecalgprofile_binding/
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

        [string]$Ipsecalgprofile 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsngroupIpsecalgprofileBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ipsecalgprofile') ) { $arguments.Add('ipsecalgprofile', $Ipsecalgprofile) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsngroupIpsecalgprofileBinding: Finished"
    }
}

function Invoke-NSGetLsngroupIpsecalgprofileBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the ipsecalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_ipsecalgprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_ipsecalgprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupIpsecalgprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupIpsecalgprofileBinding -GetAll 
        Get all lsngroup_ipsecalgprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupIpsecalgprofileBinding -Count 
        Get the number of lsngroup_ipsecalgprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupIpsecalgprofileBinding -name <string>
        Get lsngroup_ipsecalgprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupIpsecalgprofileBinding -Filter @{ 'name'='<value>' }
        Get lsngroup_ipsecalgprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroupIpsecalgprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_ipsecalgprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsngroupIpsecalgprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_ipsecalgprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_ipsecalgprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_ipsecalgprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_ipsecalgprofile_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_ipsecalgprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroupIpsecalgprofileBinding: Ended"
    }
}

function Invoke-NSAddLsngroupLsnappsprofileBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnappsprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Appsprofilename 
        Name of the LSN application profile to bind to the specified LSN group. For each set of destination ports, bind a profile for each protocol for which you want to specify settings. By default, one LSN application profile with default settings for TCP, UDP, and ICMP protocols for all destination ports is bound to an LSN group during its creation. This profile is called a default application profile. When you bind an LSN application profile, with a specified set of destination ports, to an LSN group, the bound profile overrides the default LSN application profile for that protocol at that set of destination ports. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnappsprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsngroupLsnappsprofileBinding -groupname <string>
        An example how to add lsngroup_lsnappsprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsngroupLsnappsprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnappsprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Appsprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsngroupLsnappsprofileBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('appsprofilename') ) { $payload.Add('appsprofilename', $appsprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnappsprofile_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnappsprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroupLsnappsprofileBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsngroupLsnappsprofileBinding: Finished"
    }
}

function Invoke-NSDeleteLsngroupLsnappsprofileBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnappsprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Appsprofilename 
        Name of the LSN application profile to bind to the specified LSN group. For each set of destination ports, bind a profile for each protocol for which you want to specify settings. By default, one LSN application profile with default settings for TCP, UDP, and ICMP protocols for all destination ports is bound to an LSN group during its creation. This profile is called a default application profile. When you bind an LSN application profile, with a specified set of destination ports, to an LSN group, the bound profile overrides the default LSN application profile for that protocol at that set of destination ports.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsngroupLsnappsprofileBinding -Groupname <string>
        An example how to delete lsngroup_lsnappsprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsngroupLsnappsprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnappsprofile_binding/
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

        [string]$Appsprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsngroupLsnappsprofileBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Appsprofilename') ) { $arguments.Add('appsprofilename', $Appsprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsngroupLsnappsprofileBinding: Finished"
    }
}

function Invoke-NSGetLsngroupLsnappsprofileBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the lsnappsprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnappsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnappsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnappsprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnappsprofileBinding -GetAll 
        Get all lsngroup_lsnappsprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnappsprofileBinding -Count 
        Get the number of lsngroup_lsnappsprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnappsprofileBinding -name <string>
        Get lsngroup_lsnappsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnappsprofileBinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnappsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroupLsnappsprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnappsprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsngroupLsnappsprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnappsprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnappsprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnappsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnappsprofile_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnappsprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroupLsnappsprofileBinding: Ended"
    }
}

function Invoke-NSAddLsngroupLsnhttphdrlogprofileBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnhttphdrlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Httphdrlogprofilename 
        The name of the LSN HTTP header logging Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnhttphdrlogprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsngroupLsnhttphdrlogprofileBinding -groupname <string>
        An example how to add lsngroup_lsnhttphdrlogprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsngroupLsnhttphdrlogprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnhttphdrlogprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Httphdrlogprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsngroupLsnhttphdrlogprofileBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('httphdrlogprofilename') ) { $payload.Add('httphdrlogprofilename', $httphdrlogprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnhttphdrlogprofile_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnhttphdrlogprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroupLsnhttphdrlogprofileBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsngroupLsnhttphdrlogprofileBinding: Finished"
    }
}

function Invoke-NSDeleteLsngroupLsnhttphdrlogprofileBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnhttphdrlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Httphdrlogprofilename 
        The name of the LSN HTTP header logging Profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsngroupLsnhttphdrlogprofileBinding -Groupname <string>
        An example how to delete lsngroup_lsnhttphdrlogprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsngroupLsnhttphdrlogprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnhttphdrlogprofile_binding/
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

        [string]$Httphdrlogprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsngroupLsnhttphdrlogprofileBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Httphdrlogprofilename') ) { $arguments.Add('httphdrlogprofilename', $Httphdrlogprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsngroupLsnhttphdrlogprofileBinding: Finished"
    }
}

function Invoke-NSGetLsngroupLsnhttphdrlogprofileBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the lsnhttphdrlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnhttphdrlogprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnhttphdrlogprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnhttphdrlogprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnhttphdrlogprofileBinding -GetAll 
        Get all lsngroup_lsnhttphdrlogprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnhttphdrlogprofileBinding -Count 
        Get the number of lsngroup_lsnhttphdrlogprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnhttphdrlogprofileBinding -name <string>
        Get lsngroup_lsnhttphdrlogprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnhttphdrlogprofileBinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnhttphdrlogprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroupLsnhttphdrlogprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnhttphdrlogprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsngroupLsnhttphdrlogprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnhttphdrlogprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnhttphdrlogprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnhttphdrlogprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnhttphdrlogprofile_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnhttphdrlogprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroupLsnhttphdrlogprofileBinding: Ended"
    }
}

function Invoke-NSAddLsngroupLsnlogprofileBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Logprofilename 
        The name of the LSN logging Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnlogprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsngroupLsnlogprofileBinding -groupname <string>
        An example how to add lsngroup_lsnlogprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsngroupLsnlogprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnlogprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Logprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsngroupLsnlogprofileBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('logprofilename') ) { $payload.Add('logprofilename', $logprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnlogprofile_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnlogprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroupLsnlogprofileBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsngroupLsnlogprofileBinding: Finished"
    }
}

function Invoke-NSDeleteLsngroupLsnlogprofileBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Logprofilename 
        The name of the LSN logging Profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsngroupLsnlogprofileBinding -Groupname <string>
        An example how to delete lsngroup_lsnlogprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsngroupLsnlogprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnlogprofile_binding/
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

        [string]$Logprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsngroupLsnlogprofileBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Logprofilename') ) { $arguments.Add('logprofilename', $Logprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsngroupLsnlogprofileBinding: Finished"
    }
}

function Invoke-NSGetLsngroupLsnlogprofileBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the lsnlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnlogprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnlogprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnlogprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnlogprofileBinding -GetAll 
        Get all lsngroup_lsnlogprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnlogprofileBinding -Count 
        Get the number of lsngroup_lsnlogprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnlogprofileBinding -name <string>
        Get lsngroup_lsnlogprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnlogprofileBinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnlogprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroupLsnlogprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnlogprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsngroupLsnlogprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnlogprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnlogprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnlogprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnlogprofile_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnlogprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroupLsnlogprofileBinding: Ended"
    }
}

function Invoke-NSAddLsngroupLsnpoolBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnpool that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Poolname 
        Name of the LSN pool to bind to the specified LSN group. Only LSN Pools and LSN groups with the same NAT type settings can be bound together. Multiples LSN pools can be bound to an LSN group. For Deterministic NAT, pools bound to an LSN group cannot be bound to other LSN groups. For Dynamic NAT, pools bound to an LSN group can be bound to multiple LSN groups. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnpool_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsngroupLsnpoolBinding -groupname <string>
        An example how to add lsngroup_lsnpool_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsngroupLsnpoolBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnpool_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Poolname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsngroupLsnpoolBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('poolname') ) { $payload.Add('poolname', $poolname) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnpool_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnpool_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroupLsnpoolBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsngroupLsnpoolBinding: Finished"
    }
}

function Invoke-NSDeleteLsngroupLsnpoolBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnpool that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Poolname 
        Name of the LSN pool to bind to the specified LSN group. Only LSN Pools and LSN groups with the same NAT type settings can be bound together. Multiples LSN pools can be bound to an LSN group. For Deterministic NAT, pools bound to an LSN group cannot be bound to other LSN groups. For Dynamic NAT, pools bound to an LSN group can be bound to multiple LSN groups.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsngroupLsnpoolBinding -Groupname <string>
        An example how to delete lsngroup_lsnpool_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsngroupLsnpoolBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnpool_binding/
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

        [string]$Poolname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsngroupLsnpoolBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Poolname') ) { $arguments.Add('poolname', $Poolname) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsngroupLsnpoolBinding: Finished"
    }
}

function Invoke-NSGetLsngroupLsnpoolBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the lsnpool that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnpool_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnpool_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnpoolBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnpoolBinding -GetAll 
        Get all lsngroup_lsnpool_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnpoolBinding -Count 
        Get the number of lsngroup_lsnpool_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnpoolBinding -name <string>
        Get lsngroup_lsnpool_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnpoolBinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnpool_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroupLsnpoolBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnpool_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsngroupLsnpoolBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnpool_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnpool_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnpool_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnpool_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnpool_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroupLsnpoolBinding: Ended"
    }
}

function Invoke-NSAddLsngroupLsnrtspalgprofileBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnrtspalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Rtspalgprofilename 
        The name of the LSN RTSP ALG Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnrtspalgprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsngroupLsnrtspalgprofileBinding -groupname <string>
        An example how to add lsngroup_lsnrtspalgprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsngroupLsnrtspalgprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnrtspalgprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Rtspalgprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsngroupLsnrtspalgprofileBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('rtspalgprofilename') ) { $payload.Add('rtspalgprofilename', $rtspalgprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnrtspalgprofile_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnrtspalgprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroupLsnrtspalgprofileBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsngroupLsnrtspalgprofileBinding: Finished"
    }
}

function Invoke-NSDeleteLsngroupLsnrtspalgprofileBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnrtspalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Rtspalgprofilename 
        The name of the LSN RTSP ALG Profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsngroupLsnrtspalgprofileBinding -Groupname <string>
        An example how to delete lsngroup_lsnrtspalgprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsngroupLsnrtspalgprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnrtspalgprofile_binding/
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

        [string]$Rtspalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsngroupLsnrtspalgprofileBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Rtspalgprofilename') ) { $arguments.Add('rtspalgprofilename', $Rtspalgprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsngroupLsnrtspalgprofileBinding: Finished"
    }
}

function Invoke-NSGetLsngroupLsnrtspalgprofileBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the lsnrtspalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnrtspalgprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnrtspalgprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnrtspalgprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnrtspalgprofileBinding -GetAll 
        Get all lsngroup_lsnrtspalgprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnrtspalgprofileBinding -Count 
        Get the number of lsngroup_lsnrtspalgprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnrtspalgprofileBinding -name <string>
        Get lsngroup_lsnrtspalgprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnrtspalgprofileBinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnrtspalgprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroupLsnrtspalgprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnrtspalgprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsngroupLsnrtspalgprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnrtspalgprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnrtspalgprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnrtspalgprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnrtspalgprofile_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnrtspalgprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroupLsnrtspalgprofileBinding: Ended"
    }
}

function Invoke-NSAddLsngroupLsnsipalgprofileBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnsipalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Sipalgprofilename 
        The name of the LSN SIP ALG Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnsipalgprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsngroupLsnsipalgprofileBinding -groupname <string>
        An example how to add lsngroup_lsnsipalgprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsngroupLsnsipalgprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnsipalgprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Sipalgprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsngroupLsnsipalgprofileBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('sipalgprofilename') ) { $payload.Add('sipalgprofilename', $sipalgprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnsipalgprofile_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnsipalgprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroupLsnsipalgprofileBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsngroupLsnsipalgprofileBinding: Finished"
    }
}

function Invoke-NSDeleteLsngroupLsnsipalgprofileBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnsipalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Sipalgprofilename 
        The name of the LSN SIP ALG Profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsngroupLsnsipalgprofileBinding -Groupname <string>
        An example how to delete lsngroup_lsnsipalgprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsngroupLsnsipalgprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnsipalgprofile_binding/
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

        [string]$Sipalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsngroupLsnsipalgprofileBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Sipalgprofilename') ) { $arguments.Add('sipalgprofilename', $Sipalgprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsngroupLsnsipalgprofileBinding: Finished"
    }
}

function Invoke-NSGetLsngroupLsnsipalgprofileBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the lsnsipalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnsipalgprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnsipalgprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnsipalgprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnsipalgprofileBinding -GetAll 
        Get all lsngroup_lsnsipalgprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsnsipalgprofileBinding -Count 
        Get the number of lsngroup_lsnsipalgprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnsipalgprofileBinding -name <string>
        Get lsngroup_lsnsipalgprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsnsipalgprofileBinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnsipalgprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroupLsnsipalgprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsnsipalgprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsngroupLsnsipalgprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnsipalgprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnsipalgprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnsipalgprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnsipalgprofile_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnsipalgprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroupLsnsipalgprofileBinding: Ended"
    }
}

function Invoke-NSAddLsngroupLsntransportprofileBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsntransportprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Transportprofilename 
        Name of the LSN transport profile to bind to the specified LSN group. Bind a profile for each protocol for which you want to specify settings. By default, one LSN transport profile with default settings for TCP, UDP, and ICMP protocols is bound to an LSN group during its creation. This profile is called a default transport. An LSN transport profile that you bind to an LSN group overrides the default LSN transport profile for that protocol. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsntransportprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsngroupLsntransportprofileBinding -groupname <string>
        An example how to add lsngroup_lsntransportprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsngroupLsntransportprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsntransportprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Transportprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsngroupLsntransportprofileBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('transportprofilename') ) { $payload.Add('transportprofilename', $transportprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsntransportprofile_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsntransportprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroupLsntransportprofileBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsngroupLsntransportprofileBinding: Finished"
    }
}

function Invoke-NSDeleteLsngroupLsntransportprofileBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsntransportprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Transportprofilename 
        Name of the LSN transport profile to bind to the specified LSN group. Bind a profile for each protocol for which you want to specify settings. By default, one LSN transport profile with default settings for TCP, UDP, and ICMP protocols is bound to an LSN group during its creation. This profile is called a default transport. An LSN transport profile that you bind to an LSN group overrides the default LSN transport profile for that protocol.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsngroupLsntransportprofileBinding -Groupname <string>
        An example how to delete lsngroup_lsntransportprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsngroupLsntransportprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsntransportprofile_binding/
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

        [string]$Transportprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsngroupLsntransportprofileBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Transportprofilename') ) { $arguments.Add('transportprofilename', $Transportprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsngroupLsntransportprofileBinding: Finished"
    }
}

function Invoke-NSGetLsngroupLsntransportprofileBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the lsntransportprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsntransportprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsntransportprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsntransportprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsntransportprofileBinding -GetAll 
        Get all lsngroup_lsntransportprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupLsntransportprofileBinding -Count 
        Get the number of lsngroup_lsntransportprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsntransportprofileBinding -name <string>
        Get lsngroup_lsntransportprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupLsntransportprofileBinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsntransportprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroupLsntransportprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_lsntransportprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsngroupLsntransportprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsntransportprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsntransportprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsntransportprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsntransportprofile_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsntransportprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroupLsntransportprofileBinding: Ended"
    }
}

function Invoke-NSAddLsngroupPcpserverBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the pcpserver that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Pcpserver 
        Name of the PCP server to be associated with lsn group. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_pcpserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsngroupPcpserverBinding -groupname <string>
        An example how to add lsngroup_pcpserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsngroupPcpserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_pcpserver_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Pcpserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsngroupPcpserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('pcpserver') ) { $payload.Add('pcpserver', $pcpserver) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_pcpserver_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_pcpserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsngroupPcpserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsngroupPcpserverBinding: Finished"
    }
}

function Invoke-NSDeleteLsngroupPcpserverBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the pcpserver that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Pcpserver 
        Name of the PCP server to be associated with lsn group.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsngroupPcpserverBinding -Groupname <string>
        An example how to delete lsngroup_pcpserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsngroupPcpserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_pcpserver_binding/
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

        [string]$Pcpserver 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsngroupPcpserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Pcpserver') ) { $arguments.Add('pcpserver', $Pcpserver) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsngroupPcpserverBinding: Finished"
    }
}

function Invoke-NSGetLsngroupPcpserverBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the pcpserver that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_pcpserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_pcpserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupPcpserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupPcpserverBinding -GetAll 
        Get all lsngroup_pcpserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsngroupPcpserverBinding -Count 
        Get the number of lsngroup_pcpserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupPcpserverBinding -name <string>
        Get lsngroup_pcpserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsngroupPcpserverBinding -Filter @{ 'name'='<value>' }
        Get lsngroup_pcpserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsngroupPcpserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsngroup_pcpserver_binding/
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
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsngroupPcpserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_pcpserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_pcpserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_pcpserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_pcpserver_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_pcpserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsngroupPcpserverBinding: Ended"
    }
}

function Invoke-NSAddLsnhttphdrlogprofile {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN HTTP header logging Profile resource.
    .PARAMETER Httphdrlogprofilename 
        The name of the HTTP header logging Profile. 
    .PARAMETER Logurl 
        URL information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logmethod 
        HTTP method information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logversion 
        Version information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Loghost 
        Host information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnhttphdrlogprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnhttphdrlogprofile -httphdrlogprofilename <string>
        An example how to add lsnhttphdrlogprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnhttphdrlogprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnhttphdrlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Httphdrlogprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logurl = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logmethod = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logversion = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Loghost = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ httphdrlogprofilename = $httphdrlogprofilename }
            if ( $PSBoundParameters.ContainsKey('logurl') ) { $payload.Add('logurl', $logurl) }
            if ( $PSBoundParameters.ContainsKey('logmethod') ) { $payload.Add('logmethod', $logmethod) }
            if ( $PSBoundParameters.ContainsKey('logversion') ) { $payload.Add('logversion', $logversion) }
            if ( $PSBoundParameters.ContainsKey('loghost') ) { $payload.Add('loghost', $loghost) }
            if ( $PSCmdlet.ShouldProcess("lsnhttphdrlogprofile", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnhttphdrlogprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnhttphdrlogprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnhttphdrlogprofile: Finished"
    }
}

function Invoke-NSDeleteLsnhttphdrlogprofile {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN HTTP header logging Profile resource.
    .PARAMETER Httphdrlogprofilename 
        The name of the HTTP header logging Profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnhttphdrlogprofile -Httphdrlogprofilename <string>
        An example how to delete lsnhttphdrlogprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnhttphdrlogprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnhttphdrlogprofile/
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
        [string]$Httphdrlogprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$httphdrlogprofilename", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Resource $httphdrlogprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnhttphdrlogprofile: Finished"
    }
}

function Invoke-NSUpdateLsnhttphdrlogprofile {
    <#
    .SYNOPSIS
        Update Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN HTTP header logging Profile resource.
    .PARAMETER Httphdrlogprofilename 
        The name of the HTTP header logging Profile. 
    .PARAMETER Logurl 
        URL information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logmethod 
        HTTP method information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logversion 
        Version information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Loghost 
        Host information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnhttphdrlogprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLsnhttphdrlogprofile -httphdrlogprofilename <string>
        An example how to update lsnhttphdrlogprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLsnhttphdrlogprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnhttphdrlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Httphdrlogprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logurl,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logmethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logversion,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Loghost,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ httphdrlogprofilename = $httphdrlogprofilename }
            if ( $PSBoundParameters.ContainsKey('logurl') ) { $payload.Add('logurl', $logurl) }
            if ( $PSBoundParameters.ContainsKey('logmethod') ) { $payload.Add('logmethod', $logmethod) }
            if ( $PSBoundParameters.ContainsKey('logversion') ) { $payload.Add('logversion', $logversion) }
            if ( $PSBoundParameters.ContainsKey('loghost') ) { $payload.Add('loghost', $loghost) }
            if ( $PSCmdlet.ShouldProcess("lsnhttphdrlogprofile", "Update Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnhttphdrlogprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnhttphdrlogprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateLsnhttphdrlogprofile: Finished"
    }
}

function Invoke-NSUnsetLsnhttphdrlogprofile {
    <#
    .SYNOPSIS
        Unset Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN HTTP header logging Profile resource.
    .PARAMETER Httphdrlogprofilename 
        The name of the HTTP header logging Profile. 
    .PARAMETER Logurl 
        URL information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logmethod 
        HTTP method information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logversion 
        Version information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Loghost 
        Host information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLsnhttphdrlogprofile -httphdrlogprofilename <string>
        An example how to unset lsnhttphdrlogprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLsnhttphdrlogprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnhttphdrlogprofile
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

        [ValidateLength(1, 127)]
        [string]$Httphdrlogprofilename,

        [Boolean]$logurl,

        [Boolean]$logmethod,

        [Boolean]$logversion,

        [Boolean]$loghost 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ httphdrlogprofilename = $httphdrlogprofilename }
            if ( $PSBoundParameters.ContainsKey('logurl') ) { $payload.Add('logurl', $logurl) }
            if ( $PSBoundParameters.ContainsKey('logmethod') ) { $payload.Add('logmethod', $logmethod) }
            if ( $PSBoundParameters.ContainsKey('logversion') ) { $payload.Add('logversion', $logversion) }
            if ( $PSBoundParameters.ContainsKey('loghost') ) { $payload.Add('loghost', $loghost) }
            if ( $PSCmdlet.ShouldProcess("$httphdrlogprofilename", "Unset Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLsnhttphdrlogprofile: Finished"
    }
}

function Invoke-NSGetLsnhttphdrlogprofile {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN HTTP header logging Profile resource.
    .PARAMETER Httphdrlogprofilename 
        The name of the HTTP header logging Profile. 
    .PARAMETER GetAll 
        Retrieve all lsnhttphdrlogprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsnhttphdrlogprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnhttphdrlogprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnhttphdrlogprofile -GetAll 
        Get all lsnhttphdrlogprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnhttphdrlogprofile -Count 
        Get the number of lsnhttphdrlogprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnhttphdrlogprofile -name <string>
        Get lsnhttphdrlogprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnhttphdrlogprofile -Filter @{ 'name'='<value>' }
        Get lsnhttphdrlogprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnhttphdrlogprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnhttphdrlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Httphdrlogprofilename,

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
        Write-Verbose "Invoke-NSGetLsnhttphdrlogprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnhttphdrlogprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnhttphdrlogprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnhttphdrlogprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnhttphdrlogprofile configuration for property 'httphdrlogprofilename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Resource $httphdrlogprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnhttphdrlogprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnhttphdrlogprofile: Ended"
    }
}

function Invoke-NSAddLsnip6profile {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN ip6 Profile resource.
    .PARAMETER Name 
        Name for the LSN ip6 profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN ip6 profile is created. 
    .PARAMETER Type 
        IPv6 translation type for which to set the LSN IP6 profile parameters. 
        Possible values = DS-Lite, NAT64 
    .PARAMETER Natprefix 
        IPv6 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Network6 
        IPv6 address of the Citrix ADC AFTR device. 
    .PARAMETER PassThru 
        Return details about the created lsnip6profile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnip6profile -name <string> -type <string>
        An example how to add lsnip6profile config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnip6profile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnip6profile/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('DS-Lite', 'NAT64')]
        [string]$Type,

        [string]$Natprefix,

        [string]$Network6,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnip6profile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
            }
            if ( $PSBoundParameters.ContainsKey('natprefix') ) { $payload.Add('natprefix', $natprefix) }
            if ( $PSBoundParameters.ContainsKey('network6') ) { $payload.Add('network6', $network6) }
            if ( $PSCmdlet.ShouldProcess("lsnip6profile", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnip6profile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnip6profile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnip6profile: Finished"
    }
}

function Invoke-NSDeleteLsnip6profile {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN ip6 Profile resource.
    .PARAMETER Name 
        Name for the LSN ip6 profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN ip6 profile is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnip6profile -Name <string>
        An example how to delete lsnip6profile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnip6profile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnip6profile/
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
        Write-Verbose "Invoke-NSDeleteLsnip6profile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnip6profile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnip6profile: Finished"
    }
}

function Invoke-NSGetLsnip6profile {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN ip6 Profile resource.
    .PARAMETER Name 
        Name for the LSN ip6 profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN ip6 profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnip6profile object(s).
    .PARAMETER Count
        If specified, the count of the lsnip6profile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnip6profile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnip6profile -GetAll 
        Get all lsnip6profile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnip6profile -Count 
        Get the number of lsnip6profile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnip6profile -name <string>
        Get lsnip6profile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnip6profile -Filter @{ 'name'='<value>' }
        Get lsnip6profile data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnip6profile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnip6profile/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-NSGetLsnip6profile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnip6profile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnip6profile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnip6profile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnip6profile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnip6profile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnip6profile: Ended"
    }
}

function Invoke-NSAddLsnlogprofile {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN logging Profile resource.
    .PARAMETER Logprofilename 
        The name of the logging Profile. 
    .PARAMETER Logsubscrinfo 
        Subscriber ID information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logcompact 
        Logs in Compact Logging format if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logipfix 
        Logs in IPFIX format if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Analyticsprofile 
        Name of the Analytics Profile attached to this lsn profile. 
    .PARAMETER Logsessdeletion 
        LSN Session deletion will not be logged if disabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnlogprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnlogprofile -logprofilename <string>
        An example how to add lsnlogprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnlogprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Logprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logsubscrinfo = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logcompact = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logipfix = 'DISABLED',

        [string]$Analyticsprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logsessdeletion = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ logprofilename = $logprofilename }
            if ( $PSBoundParameters.ContainsKey('logsubscrinfo') ) { $payload.Add('logsubscrinfo', $logsubscrinfo) }
            if ( $PSBoundParameters.ContainsKey('logcompact') ) { $payload.Add('logcompact', $logcompact) }
            if ( $PSBoundParameters.ContainsKey('logipfix') ) { $payload.Add('logipfix', $logipfix) }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSBoundParameters.ContainsKey('logsessdeletion') ) { $payload.Add('logsessdeletion', $logsessdeletion) }
            if ( $PSCmdlet.ShouldProcess("lsnlogprofile", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnlogprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnlogprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnlogprofile: Finished"
    }
}

function Invoke-NSDeleteLsnlogprofile {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN logging Profile resource.
    .PARAMETER Logprofilename 
        The name of the logging Profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnlogprofile -Logprofilename <string>
        An example how to delete lsnlogprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnlogprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnlogprofile/
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
        [string]$Logprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnlogprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$logprofilename", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnlogprofile -NitroPath nitro/v1/config -Resource $logprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnlogprofile: Finished"
    }
}

function Invoke-NSUpdateLsnlogprofile {
    <#
    .SYNOPSIS
        Update Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN logging Profile resource.
    .PARAMETER Logprofilename 
        The name of the logging Profile. 
    .PARAMETER Logsubscrinfo 
        Subscriber ID information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logcompact 
        Logs in Compact Logging format if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logipfix 
        Logs in IPFIX format if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Analyticsprofile 
        Name of the Analytics Profile attached to this lsn profile. 
    .PARAMETER Logsessdeletion 
        LSN Session deletion will not be logged if disabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnlogprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLsnlogprofile -logprofilename <string>
        An example how to update lsnlogprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLsnlogprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Logprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logsubscrinfo,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logcompact,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logipfix,

        [string]$Analyticsprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logsessdeletion,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLsnlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ logprofilename = $logprofilename }
            if ( $PSBoundParameters.ContainsKey('logsubscrinfo') ) { $payload.Add('logsubscrinfo', $logsubscrinfo) }
            if ( $PSBoundParameters.ContainsKey('logcompact') ) { $payload.Add('logcompact', $logcompact) }
            if ( $PSBoundParameters.ContainsKey('logipfix') ) { $payload.Add('logipfix', $logipfix) }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSBoundParameters.ContainsKey('logsessdeletion') ) { $payload.Add('logsessdeletion', $logsessdeletion) }
            if ( $PSCmdlet.ShouldProcess("lsnlogprofile", "Update Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnlogprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnlogprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateLsnlogprofile: Finished"
    }
}

function Invoke-NSUnsetLsnlogprofile {
    <#
    .SYNOPSIS
        Unset Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN logging Profile resource.
    .PARAMETER Logprofilename 
        The name of the logging Profile. 
    .PARAMETER Logsubscrinfo 
        Subscriber ID information is logged if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logcompact 
        Logs in Compact Logging format if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logipfix 
        Logs in IPFIX format if option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Analyticsprofile 
        Name of the Analytics Profile attached to this lsn profile. 
    .PARAMETER Logsessdeletion 
        LSN Session deletion will not be logged if disabled. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLsnlogprofile -logprofilename <string>
        An example how to unset lsnlogprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLsnlogprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnlogprofile
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

        [ValidateLength(1, 127)]
        [string]$Logprofilename,

        [Boolean]$logsubscrinfo,

        [Boolean]$logcompact,

        [Boolean]$logipfix,

        [Boolean]$analyticsprofile,

        [Boolean]$logsessdeletion 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLsnlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ logprofilename = $logprofilename }
            if ( $PSBoundParameters.ContainsKey('logsubscrinfo') ) { $payload.Add('logsubscrinfo', $logsubscrinfo) }
            if ( $PSBoundParameters.ContainsKey('logcompact') ) { $payload.Add('logcompact', $logcompact) }
            if ( $PSBoundParameters.ContainsKey('logipfix') ) { $payload.Add('logipfix', $logipfix) }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSBoundParameters.ContainsKey('logsessdeletion') ) { $payload.Add('logsessdeletion', $logsessdeletion) }
            if ( $PSCmdlet.ShouldProcess("$logprofilename", "Unset Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type lsnlogprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLsnlogprofile: Finished"
    }
}

function Invoke-NSGetLsnlogprofile {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN logging Profile resource.
    .PARAMETER Logprofilename 
        The name of the logging Profile. 
    .PARAMETER GetAll 
        Retrieve all lsnlogprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsnlogprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnlogprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnlogprofile -GetAll 
        Get all lsnlogprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnlogprofile -Count 
        Get the number of lsnlogprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnlogprofile -name <string>
        Get lsnlogprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnlogprofile -Filter @{ 'name'='<value>' }
        Get lsnlogprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnlogprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Logprofilename,

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
        Write-Verbose "Invoke-NSGetLsnlogprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnlogprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnlogprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnlogprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnlogprofile configuration for property 'logprofilename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Resource $logprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnlogprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnlogprofile: Ended"
    }
}

function Invoke-NSUpdateLsnparameter {
    <#
    .SYNOPSIS
        Update Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN parameter resource.
    .PARAMETER Memlimit 
        Amount of Citrix ADC memory to reserve for the LSN feature, in multiples of 2MB. 
         
        Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory. 
        This command is deprecated, use 'set extendedmemoryparam -memlimit' instead. 
    .PARAMETER Sessionsync 
        Synchronize all LSN sessions with the secondary node in a high availability (HA) deployment (global synchronization). After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary). 
         
        The global session synchronization parameter and session synchronization parameters (group level) of all LSN groups are enabled by default. 
         
        For a group, when both the global level and the group level LSN session synchronization parameters are enabled, the primary node synchronizes information of all LSN sessions related to this LSN group with the secondary node. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscrsessionremoval 
        LSN global setting for controlling subscriber aware session removal, when this is enabled, when ever the subscriber info is deleted from subscriber database, sessions corresponding to that subscriber will be removed. if this setting is disabled, subscriber sessions will be timed out as per the idle time out settings. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLsnparameter 
        An example how to update lsnparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLsnparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnparameter/
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

        [double]$Memlimit,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionsync,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscrsessionremoval 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLsnparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSBoundParameters.ContainsKey('sessionsync') ) { $payload.Add('sessionsync', $sessionsync) }
            if ( $PSBoundParameters.ContainsKey('subscrsessionremoval') ) { $payload.Add('subscrsessionremoval', $subscrsessionremoval) }
            if ( $PSCmdlet.ShouldProcess("lsnparameter", "Update Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateLsnparameter: Finished"
    }
}

function Invoke-NSUnsetLsnparameter {
    <#
    .SYNOPSIS
        Unset Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN parameter resource.
    .PARAMETER Memlimit 
        Amount of Citrix ADC memory to reserve for the LSN feature, in multiples of 2MB. 
         
        Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory. 
        This command is deprecated, use 'set extendedmemoryparam -memlimit' instead. 
    .PARAMETER Sessionsync 
        Synchronize all LSN sessions with the secondary node in a high availability (HA) deployment (global synchronization). After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary). 
         
        The global session synchronization parameter and session synchronization parameters (group level) of all LSN groups are enabled by default. 
         
        For a group, when both the global level and the group level LSN session synchronization parameters are enabled, the primary node synchronizes information of all LSN sessions related to this LSN group with the secondary node. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscrsessionremoval 
        LSN global setting for controlling subscriber aware session removal, when this is enabled, when ever the subscriber info is deleted from subscriber database, sessions corresponding to that subscriber will be removed. if this setting is disabled, subscriber sessions will be timed out as per the idle time out settings. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLsnparameter 
        An example how to unset lsnparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLsnparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnparameter
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

        [Boolean]$memlimit,

        [Boolean]$sessionsync,

        [Boolean]$subscrsessionremoval 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLsnparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSBoundParameters.ContainsKey('sessionsync') ) { $payload.Add('sessionsync', $sessionsync) }
            if ( $PSBoundParameters.ContainsKey('subscrsessionremoval') ) { $payload.Add('subscrsessionremoval', $subscrsessionremoval) }
            if ( $PSCmdlet.ShouldProcess("lsnparameter", "Unset Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type lsnparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLsnparameter: Finished"
    }
}

function Invoke-NSGetLsnparameter {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN parameter resource.
    .PARAMETER GetAll 
        Retrieve all lsnparameter object(s).
    .PARAMETER Count
        If specified, the count of the lsnparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnparameter -GetAll 
        Get all lsnparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnparameter -name <string>
        Get lsnparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnparameter -Filter @{ 'name'='<value>' }
        Get lsnparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnparameter/
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
        Write-Verbose "Invoke-NSGetLsnparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsnparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnparameter: Ended"
    }
}

function Invoke-NSAddLsnpool {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN pool resource.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER Nattype 
        Type of NAT IP address and port allocation (from the LSN pools bound to an LSN group) for subscribers (of the LSN client entity bound to the LSN group): 
         
        Available options function as follows: 
         
        * Deterministic - Allocate a NAT IP address and a block of ports to each subscriber (of the LSN client bound to the LSN group). The Citrix ADC sequentially allocates NAT resources to these subscribers. The Citrix ADC ADC assigns the first block of ports (block size determined by the port block size parameter of the LSN group) on the beginning NAT IP address to the beginning subscriber IP address. The next range of ports is assigned to the next subscriber, and so on, until the NAT address does not have enough ports for the next subscriber. In this case, the first port block on the next NAT address is used for the subscriber, and so on. Because each subscriber now receives a deterministic NAT IP address and a block of ports, a subscriber can be identified without any need for logging. For a connection, a subscriber can be identified based only on the NAT IP address and port, and the destination IP address and port. 
         
        * Dynamic - Allocate a random NAT IP address and a port from the LSN NAT pool for a subscriber's connection. If port block allocation is enabled (in LSN pool) and a port block size is specified (in the LSN group), the Citrix ADC allocates a random NAT IP address and a block of ports for a subscriber when it initiates a connection for the first time. The ADC allocates this NAT IP address and a port (from the allocated block of ports) for different connections from this subscriber. If all the ports are allocated (for different subscriber's connections) from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber. 
        Only LSN Pools and LSN groups with the same NAT type settings can be bound together. Multiples LSN pools can be bound to an LSN group. A maximum of 16 LSN pools can be bound to an LSN group. . 
         
        Possible values = DYNAMIC, DETERMINISTIC 
    .PARAMETER Portblockallocation 
        Allocate a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber when the NAT allocation is set as Dynamic NAT. For any connection initiated from a subscriber, the Citrix ADC allocates a NAT port from the subscriber's allocated NAT port block to create the LSN session. 
         
        You must set the port block size in the bound LSN group. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the Citrix ADC allocates a new random port block for the subscriber. 
         
        For Deterministic NAT, this parameter is enabled by default, and you cannot disable it. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Portrealloctimeout 
        The waiting time, in seconds, between deallocating LSN NAT ports (when an LSN mapping is removed) and reallocating them for a new LSN session. This parameter is necessary in order to prevent collisions between old and new mappings and sessions. It ensures that all established sessions are broken instead of redirected to a different subscriber. This is not applicable for ports used in: 
        * Deterministic NAT 
        * Address-Dependent filtering and Address-Port-Dependent filtering 
        * Dynamic NAT with port block allocation 
        In these cases, ports are immediately reallocated. 
         
         
        Maximum value = 600 
    .PARAMETER Maxportrealloctmq 
        Maximum number of ports for which the port reallocation timeout applies for each NAT IP address. In other words, the maximum deallocated-port queue size for which the reallocation timeout applies for each NAT IP address. 
         
        When the queue size is full, the next port deallocated is reallocated immediately for a new LSN session. 
         
         
        Maximum value = 65536 
    .PARAMETER PassThru 
        Return details about the created lsnpool item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnpool -poolname <string>
        An example how to add lsnpool config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnpool
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnpool/
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
        [ValidateLength(1, 127)]
        [string]$Poolname,

        [ValidateSet('DYNAMIC', 'DETERMINISTIC')]
        [string]$Nattype = 'DYNAMIC',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Portblockallocation = 'DISABLED',

        [double]$Portrealloctimeout = '0',

        [double]$Maxportrealloctmq = '65536',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnpool: Starting"
    }
    process {
        try {
            $payload = @{ poolname = $poolname }
            if ( $PSBoundParameters.ContainsKey('nattype') ) { $payload.Add('nattype', $nattype) }
            if ( $PSBoundParameters.ContainsKey('portblockallocation') ) { $payload.Add('portblockallocation', $portblockallocation) }
            if ( $PSBoundParameters.ContainsKey('portrealloctimeout') ) { $payload.Add('portrealloctimeout', $portrealloctimeout) }
            if ( $PSBoundParameters.ContainsKey('maxportrealloctmq') ) { $payload.Add('maxportrealloctmq', $maxportrealloctmq) }
            if ( $PSCmdlet.ShouldProcess("lsnpool", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnpool -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnpool -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnpool: Finished"
    }
}

function Invoke-NSDeleteLsnpool {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN pool resource.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnpool -Poolname <string>
        An example how to delete lsnpool config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnpool
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnpool/
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
        [string]$Poolname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnpool: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$poolname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnpool -NitroPath nitro/v1/config -Resource $poolname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnpool: Finished"
    }
}

function Invoke-NSUpdateLsnpool {
    <#
    .SYNOPSIS
        Update Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN pool resource.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER Portrealloctimeout 
        The waiting time, in seconds, between deallocating LSN NAT ports (when an LSN mapping is removed) and reallocating them for a new LSN session. This parameter is necessary in order to prevent collisions between old and new mappings and sessions. It ensures that all established sessions are broken instead of redirected to a different subscriber. This is not applicable for ports used in: 
        * Deterministic NAT 
        * Address-Dependent filtering and Address-Port-Dependent filtering 
        * Dynamic NAT with port block allocation 
        In these cases, ports are immediately reallocated. 
         
         
        Maximum value = 600 
    .PARAMETER Maxportrealloctmq 
        Maximum number of ports for which the port reallocation timeout applies for each NAT IP address. In other words, the maximum deallocated-port queue size for which the reallocation timeout applies for each NAT IP address. 
         
        When the queue size is full, the next port deallocated is reallocated immediately for a new LSN session. 
         
         
        Maximum value = 65536 
    .PARAMETER PassThru 
        Return details about the created lsnpool item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLsnpool -poolname <string>
        An example how to update lsnpool config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLsnpool
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnpool/
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
        [ValidateLength(1, 127)]
        [string]$Poolname,

        [double]$Portrealloctimeout,

        [double]$Maxportrealloctmq,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLsnpool: Starting"
    }
    process {
        try {
            $payload = @{ poolname = $poolname }
            if ( $PSBoundParameters.ContainsKey('portrealloctimeout') ) { $payload.Add('portrealloctimeout', $portrealloctimeout) }
            if ( $PSBoundParameters.ContainsKey('maxportrealloctmq') ) { $payload.Add('maxportrealloctmq', $maxportrealloctmq) }
            if ( $PSCmdlet.ShouldProcess("lsnpool", "Update Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnpool -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnpool -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateLsnpool: Finished"
    }
}

function Invoke-NSUnsetLsnpool {
    <#
    .SYNOPSIS
        Unset Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN pool resource.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER Portrealloctimeout 
        The waiting time, in seconds, between deallocating LSN NAT ports (when an LSN mapping is removed) and reallocating them for a new LSN session. This parameter is necessary in order to prevent collisions between old and new mappings and sessions. It ensures that all established sessions are broken instead of redirected to a different subscriber. This is not applicable for ports used in: 
        * Deterministic NAT 
        * Address-Dependent filtering and Address-Port-Dependent filtering 
        * Dynamic NAT with port block allocation 
        In these cases, ports are immediately reallocated. 
         
         
        Maximum value = 600 
    .PARAMETER Maxportrealloctmq 
        Maximum number of ports for which the port reallocation timeout applies for each NAT IP address. In other words, the maximum deallocated-port queue size for which the reallocation timeout applies for each NAT IP address. 
         
        When the queue size is full, the next port deallocated is reallocated immediately for a new LSN session. 
         
         
        Maximum value = 65536
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLsnpool -poolname <string>
        An example how to unset lsnpool config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLsnpool
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnpool
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
        [ValidateLength(1, 127)]
        [string]$Poolname,

        [Boolean]$portrealloctimeout,

        [Boolean]$maxportrealloctmq 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLsnpool: Starting"
    }
    process {
        try {
            $payload = @{ poolname = $poolname }
            if ( $PSBoundParameters.ContainsKey('portrealloctimeout') ) { $payload.Add('portrealloctimeout', $portrealloctimeout) }
            if ( $PSBoundParameters.ContainsKey('maxportrealloctmq') ) { $payload.Add('maxportrealloctmq', $maxportrealloctmq) }
            if ( $PSCmdlet.ShouldProcess("$poolname", "Unset Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type lsnpool -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLsnpool: Finished"
    }
}

function Invoke-NSGetLsnpool {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN pool resource.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER GetAll 
        Retrieve all lsnpool object(s).
    .PARAMETER Count
        If specified, the count of the lsnpool object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnpool
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnpool -GetAll 
        Get all lsnpool data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnpool -Count 
        Get the number of lsnpool objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnpool -name <string>
        Get lsnpool object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnpool -Filter @{ 'name'='<value>' }
        Get lsnpool data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnpool
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnpool/
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
        [ValidateLength(1, 127)]
        [string]$Poolname,

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
        Write-Verbose "Invoke-NSGetLsnpool: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnpool objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnpool objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnpool objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnpool configuration for property 'poolname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Resource $poolname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnpool configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnpool: Ended"
    }
}

function Invoke-NSGetLsnpoolBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsnpool.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER GetAll 
        Retrieve all lsnpool_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnpool_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnpoolBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnpoolBinding -GetAll 
        Get all lsnpool_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnpoolBinding -name <string>
        Get lsnpool_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnpoolBinding -Filter @{ 'name'='<value>' }
        Get lsnpool_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnpoolBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnpool_binding/
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
        [ValidateLength(1, 127)]
        [string]$Poolname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnpoolBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnpool_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnpool_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnpool_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnpool_binding configuration for property 'poolname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Resource $poolname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnpool_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnpoolBinding: Ended"
    }
}

function Invoke-NSAddLsnpoolLsnipBinding {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnip that can be bound to lsnpool.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER Ownernode 
        ID(s) of cluster node(s) on which command is to be executed. 
         
        Maximum value = 31 
    .PARAMETER Lsnip 
        IPv4 address or a range of IPv4 addresses to be used as NAT IP address(es) for LSN. After the pool is created, these IPv4 addresses are added to the Citrix ADC as Citrix ADC owned IP address of type LSN. A maximum of 4096 IP addresses can be bound to an LSN pool. An LSN IP address associated with an LSN pool cannot be shared with other LSN pools. IP addresses specified for this parameter must not already exist on the Citrix ADC as any Citrix ADC owned IP addresses. In the command line interface, separate the range with a hyphen. For example: 10.102.29.30-10.102.29.189. You can later remove some or all the LSN IP addresses from the pool, and add IP addresses to the LSN pool. By default, arp is enabled on LSN IP address but, you can disable it using command - "set ns ip" . 
    .PARAMETER PassThru 
        Return details about the created lsnpool_lsnip_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnpoolLsnipBinding -poolname <string>
        An example how to add lsnpool_lsnip_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnpoolLsnipBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnpool_lsnip_binding/
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
        [ValidateLength(1, 127)]
        [string]$Poolname,

        [double]$Ownernode,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Lsnip,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnpoolLsnipBinding: Starting"
    }
    process {
        try {
            $payload = @{ poolname = $poolname }
            if ( $PSBoundParameters.ContainsKey('ownernode') ) { $payload.Add('ownernode', $ownernode) }
            if ( $PSBoundParameters.ContainsKey('lsnip') ) { $payload.Add('lsnip', $lsnip) }
            if ( $PSCmdlet.ShouldProcess("lsnpool_lsnip_binding", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnpool_lsnip_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnpoolLsnipBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnpoolLsnipBinding: Finished"
    }
}

function Invoke-NSDeleteLsnpoolLsnipBinding {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Binding object showing the lsnip that can be bound to lsnpool.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER Ownernode 
        ID(s) of cluster node(s) on which command is to be executed. 
         
        Maximum value = 31 
    .PARAMETER Lsnip 
        IPv4 address or a range of IPv4 addresses to be used as NAT IP address(es) for LSN. After the pool is created, these IPv4 addresses are added to the Citrix ADC as Citrix ADC owned IP address of type LSN. A maximum of 4096 IP addresses can be bound to an LSN pool. An LSN IP address associated with an LSN pool cannot be shared with other LSN pools. IP addresses specified for this parameter must not already exist on the Citrix ADC as any Citrix ADC owned IP addresses. In the command line interface, separate the range with a hyphen. For example: 10.102.29.30-10.102.29.189. You can later remove some or all the LSN IP addresses from the pool, and add IP addresses to the LSN pool. By default, arp is enabled on LSN IP address but, you can disable it using command - "set ns ip" .
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnpoolLsnipBinding -Poolname <string>
        An example how to delete lsnpool_lsnip_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnpoolLsnipBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnpool_lsnip_binding/
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
        [string]$Poolname,

        [double]$Ownernode,

        [string]$Lsnip 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnpoolLsnipBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ownernode') ) { $arguments.Add('ownernode', $Ownernode) }
            if ( $PSBoundParameters.ContainsKey('Lsnip') ) { $arguments.Add('lsnip', $Lsnip) }
            if ( $PSCmdlet.ShouldProcess("$poolname", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Resource $poolname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnpoolLsnipBinding: Finished"
    }
}

function Invoke-NSGetLsnpoolLsnipBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the lsnip that can be bound to lsnpool.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER GetAll 
        Retrieve all lsnpool_lsnip_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnpool_lsnip_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnpoolLsnipBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnpoolLsnipBinding -GetAll 
        Get all lsnpool_lsnip_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnpoolLsnipBinding -Count 
        Get the number of lsnpool_lsnip_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnpoolLsnipBinding -name <string>
        Get lsnpool_lsnip_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnpoolLsnipBinding -Filter @{ 'name'='<value>' }
        Get lsnpool_lsnip_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnpoolLsnipBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnpool_lsnip_binding/
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
        [ValidateLength(1, 127)]
        [string]$Poolname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnpoolLsnipBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnpool_lsnip_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnpool_lsnip_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnpool_lsnip_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnpool_lsnip_binding configuration for property 'poolname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Resource $poolname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnpool_lsnip_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnpoolLsnipBinding: Ended"
    }
}

function Invoke-NSAddLsnrtspalgprofile {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN RTSPALG Profile resource.
    .PARAMETER Rtspalgprofilename 
        The name of the RTSPALG Profile. 
    .PARAMETER Rtspidletimeout 
        Idle timeout for the rtsp sessions in seconds. 
    .PARAMETER Rtspportrange 
        port for the RTSP. 
    .PARAMETER Rtsptransportprotocol 
        RTSP ALG Profile transport protocol type. 
         
        Possible values = TCP, UDP 
    .PARAMETER PassThru 
        Return details about the created lsnrtspalgprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnrtspalgprofile -rtspalgprofilename <string> -rtspportrange <string>
        An example how to add lsnrtspalgprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnrtspalgprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnrtspalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Rtspalgprofilename,

        [double]$Rtspidletimeout = '120',

        [Parameter(Mandatory)]
        [string]$Rtspportrange,

        [ValidateSet('TCP', 'UDP')]
        [string]$Rtsptransportprotocol = 'TCP',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ rtspalgprofilename = $rtspalgprofilename
                rtspportrange                = $rtspportrange
            }
            if ( $PSBoundParameters.ContainsKey('rtspidletimeout') ) { $payload.Add('rtspidletimeout', $rtspidletimeout) }
            if ( $PSBoundParameters.ContainsKey('rtsptransportprotocol') ) { $payload.Add('rtsptransportprotocol', $rtsptransportprotocol) }
            if ( $PSCmdlet.ShouldProcess("lsnrtspalgprofile", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnrtspalgprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnrtspalgprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnrtspalgprofile: Finished"
    }
}

function Invoke-NSUpdateLsnrtspalgprofile {
    <#
    .SYNOPSIS
        Update Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN RTSPALG Profile resource.
    .PARAMETER Rtspalgprofilename 
        The name of the RTSPALG Profile. 
    .PARAMETER Rtspidletimeout 
        Idle timeout for the rtsp sessions in seconds. 
    .PARAMETER Rtspportrange 
        port for the RTSP. 
    .PARAMETER Rtsptransportprotocol 
        RTSP ALG Profile transport protocol type. 
         
        Possible values = TCP, UDP 
    .PARAMETER PassThru 
        Return details about the created lsnrtspalgprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLsnrtspalgprofile -rtspalgprofilename <string>
        An example how to update lsnrtspalgprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLsnrtspalgprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnrtspalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Rtspalgprofilename,

        [double]$Rtspidletimeout,

        [string]$Rtspportrange,

        [ValidateSet('TCP', 'UDP')]
        [string]$Rtsptransportprotocol,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ rtspalgprofilename = $rtspalgprofilename }
            if ( $PSBoundParameters.ContainsKey('rtspidletimeout') ) { $payload.Add('rtspidletimeout', $rtspidletimeout) }
            if ( $PSBoundParameters.ContainsKey('rtspportrange') ) { $payload.Add('rtspportrange', $rtspportrange) }
            if ( $PSBoundParameters.ContainsKey('rtsptransportprotocol') ) { $payload.Add('rtsptransportprotocol', $rtsptransportprotocol) }
            if ( $PSCmdlet.ShouldProcess("lsnrtspalgprofile", "Update Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnrtspalgprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnrtspalgprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateLsnrtspalgprofile: Finished"
    }
}

function Invoke-NSUnsetLsnrtspalgprofile {
    <#
    .SYNOPSIS
        Unset Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN RTSPALG Profile resource.
    .PARAMETER Rtspalgprofilename 
        The name of the RTSPALG Profile. 
    .PARAMETER Rtspidletimeout 
        Idle timeout for the rtsp sessions in seconds. 
    .PARAMETER Rtspportrange 
        port for the RTSP. 
    .PARAMETER Rtsptransportprotocol 
        RTSP ALG Profile transport protocol type. 
         
        Possible values = TCP, UDP
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLsnrtspalgprofile -rtspalgprofilename <string>
        An example how to unset lsnrtspalgprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLsnrtspalgprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnrtspalgprofile
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

        [ValidateLength(1, 127)]
        [string]$Rtspalgprofilename,

        [Boolean]$rtspidletimeout,

        [Boolean]$rtspportrange,

        [Boolean]$rtsptransportprotocol 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ rtspalgprofilename = $rtspalgprofilename }
            if ( $PSBoundParameters.ContainsKey('rtspidletimeout') ) { $payload.Add('rtspidletimeout', $rtspidletimeout) }
            if ( $PSBoundParameters.ContainsKey('rtspportrange') ) { $payload.Add('rtspportrange', $rtspportrange) }
            if ( $PSBoundParameters.ContainsKey('rtsptransportprotocol') ) { $payload.Add('rtsptransportprotocol', $rtsptransportprotocol) }
            if ( $PSCmdlet.ShouldProcess("$rtspalgprofilename", "Unset Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLsnrtspalgprofile: Finished"
    }
}

function Invoke-NSDeleteLsnrtspalgprofile {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN RTSPALG Profile resource.
    .PARAMETER Rtspalgprofilename 
        The name of the RTSPALG Profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnrtspalgprofile -Rtspalgprofilename <string>
        An example how to delete lsnrtspalgprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnrtspalgprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnrtspalgprofile/
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
        [string]$Rtspalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$rtspalgprofilename", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Resource $rtspalgprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnrtspalgprofile: Finished"
    }
}

function Invoke-NSGetLsnrtspalgprofile {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN RTSPALG Profile resource.
    .PARAMETER Rtspalgprofilename 
        The name of the RTSPALG Profile. 
    .PARAMETER GetAll 
        Retrieve all lsnrtspalgprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsnrtspalgprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnrtspalgprofile -GetAll 
        Get all lsnrtspalgprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnrtspalgprofile -Count 
        Get the number of lsnrtspalgprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgprofile -name <string>
        Get lsnrtspalgprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgprofile -Filter @{ 'name'='<value>' }
        Get lsnrtspalgprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnrtspalgprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnrtspalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Rtspalgprofilename,

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
        Write-Verbose "Invoke-NSGetLsnrtspalgprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnrtspalgprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgprofile configuration for property 'rtspalgprofilename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Resource $rtspalgprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnrtspalgprofile: Ended"
    }
}

function Invoke-NSFlushLsnrtspalgsession {
    <#
    .SYNOPSIS
        Flush Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN RTSPALG session resource.
    .PARAMETER Sessionid 
        Session ID for the RTSP call.
    .EXAMPLE
        PS C:\>Invoke-NSFlushLsnrtspalgsession -sessionid <string>
        An example how to flush lsnrtspalgsession config Object(s).
    .NOTES
        File Name : Invoke-NSFlushLsnrtspalgsession
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnrtspalgsession/
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
        [string]$Sessionid 

    )
    begin {
        Write-Verbose "Invoke-NSFlushLsnrtspalgsession: Starting"
    }
    process {
        try {
            $payload = @{ sessionid = $sessionid }

            if ( $PSCmdlet.ShouldProcess($Name, "Flush Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnrtspalgsession -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSFlushLsnrtspalgsession: Finished"
    }
}

function Invoke-NSGetLsnrtspalgsession {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN RTSPALG session resource.
    .PARAMETER Sessionid 
        Session ID for the RTSP call. 
    .PARAMETER GetAll 
        Retrieve all lsnrtspalgsession object(s).
    .PARAMETER Count
        If specified, the count of the lsnrtspalgsession object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgsession
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnrtspalgsession -GetAll 
        Get all lsnrtspalgsession data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnrtspalgsession -Count 
        Get the number of lsnrtspalgsession objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgsession -name <string>
        Get lsnrtspalgsession object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgsession -Filter @{ 'name'='<value>' }
        Get lsnrtspalgsession data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnrtspalgsession
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnrtspalgsession/
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
        [string]$Sessionid,

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
        Write-Verbose "Invoke-NSGetLsnrtspalgsession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnrtspalgsession objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgsession objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgsession objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgsession configuration for property 'sessionid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Resource $sessionid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgsession configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnrtspalgsession: Ended"
    }
}

function Invoke-NSGetLsnrtspalgsessionBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsnrtspalgsession.
    .PARAMETER Sessionid 
        Session ID for the RTSP call. 
    .PARAMETER GetAll 
        Retrieve all lsnrtspalgsession_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnrtspalgsession_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgsessionBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnrtspalgsessionBinding -GetAll 
        Get all lsnrtspalgsession_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgsessionBinding -name <string>
        Get lsnrtspalgsession_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgsessionBinding -Filter @{ 'name'='<value>' }
        Get lsnrtspalgsession_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnrtspalgsessionBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnrtspalgsession_binding/
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
        [string]$Sessionid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnrtspalgsessionBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnrtspalgsession_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgsession_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_binding configuration for property 'sessionid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Resource $sessionid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgsession_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnrtspalgsessionBinding: Ended"
    }
}

function Invoke-NSGetLsnrtspalgsessionDatachannelBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the datachannel that can be bound to lsnrtspalgsession.
    .PARAMETER Sessionid 
        Session ID for the RTSP call. 
    .PARAMETER GetAll 
        Retrieve all lsnrtspalgsession_datachannel_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnrtspalgsession_datachannel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgsessionDatachannelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnrtspalgsessionDatachannelBinding -GetAll 
        Get all lsnrtspalgsession_datachannel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnrtspalgsessionDatachannelBinding -Count 
        Get the number of lsnrtspalgsession_datachannel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgsessionDatachannelBinding -name <string>
        Get lsnrtspalgsession_datachannel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnrtspalgsessionDatachannelBinding -Filter @{ 'name'='<value>' }
        Get lsnrtspalgsession_datachannel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnrtspalgsessionDatachannelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnrtspalgsession_datachannel_binding/
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
        [string]$Sessionid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnrtspalgsessionDatachannelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnrtspalgsession_datachannel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgsession_datachannel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_datachannel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_datachannel_binding configuration for property 'sessionid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Resource $sessionid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgsession_datachannel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnrtspalgsessionDatachannelBinding: Ended"
    }
}

function Invoke-NSFlushLsnsession {
    <#
    .SYNOPSIS
        Flush Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for lsn session resource.
    .PARAMETER Nattype 
        Type of sessions to be displayed. 
         
        Possible values = NAT44, DS-Lite, NAT64 
    .PARAMETER Clientname 
        Name of the LSN Client entity. 
    .PARAMETER Network 
        IP address or network address of subscriber(s). 
    .PARAMETER Netmask 
        Subnet mask for the IP address specified by the network parameter. 
    .PARAMETER Network6 
        IPv6 address of the LSN subscriber or B4 device. 
    .PARAMETER Td 
        Traffic domain ID of the LSN client entity. 
         
         
        Maximum value = 4094 
    .PARAMETER Natip 
        Mapped NAT IP address used in LSN sessions. 
    .PARAMETER Natport2 
        Mapped NAT port used in the LSN sessions. 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31
    .EXAMPLE
        PS C:\>Invoke-NSFlushLsnsession 
        An example how to flush lsnsession config Object(s).
    .NOTES
        File Name : Invoke-NSFlushLsnsession
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsession/
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

        [ValidateSet('NAT44', 'DS-Lite', 'NAT64')]
        [string]$Nattype,

        [string]$Clientname,

        [string]$Network,

        [string]$Netmask,

        [string]$Network6,

        [double]$Td,

        [string]$Natip,

        [int]$Natport2,

        [double]$Nodeid 

    )
    begin {
        Write-Verbose "Invoke-NSFlushLsnsession: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('nattype') ) { $payload.Add('nattype', $nattype) }
            if ( $PSBoundParameters.ContainsKey('clientname') ) { $payload.Add('clientname', $clientname) }
            if ( $PSBoundParameters.ContainsKey('network') ) { $payload.Add('network', $network) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('network6') ) { $payload.Add('network6', $network6) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('natip') ) { $payload.Add('natip', $natip) }
            if ( $PSBoundParameters.ContainsKey('natport2') ) { $payload.Add('natport2', $natport2) }
            if ( $PSBoundParameters.ContainsKey('nodeid') ) { $payload.Add('nodeid', $nodeid) }
            if ( $PSCmdlet.ShouldProcess($Name, "Flush Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnsession -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSFlushLsnsession: Finished"
    }
}

function Invoke-NSGetLsnsession {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for lsn session resource.
    .PARAMETER Nattype 
        Type of sessions to be displayed. 
         
        Possible values = NAT44, DS-Lite, NAT64 
    .PARAMETER Clientname 
        Name of the LSN Client entity. 
    .PARAMETER Network 
        IP address or network address of subscriber(s). 
    .PARAMETER Netmask 
        Subnet mask for the IP address specified by the network parameter. 
    .PARAMETER Network6 
        IPv6 address of the LSN subscriber or B4 device. 
    .PARAMETER Td 
        Traffic domain ID of the LSN client entity. 
         
         
        Maximum value = 4094 
    .PARAMETER Natip 
        Mapped NAT IP address used in LSN sessions. 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all lsnsession object(s).
    .PARAMETER Count
        If specified, the count of the lsnsession object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsession
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsession -GetAll 
        Get all lsnsession data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsession -Count 
        Get the number of lsnsession objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsession -name <string>
        Get lsnsession object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsession -Filter @{ 'name'='<value>' }
        Get lsnsession data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnsession
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsession/
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
        [ValidateSet('NAT44', 'DS-Lite', 'NAT64')]
        [string]$Nattype,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Network,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Netmask,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Network6,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double]$Td,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Natip,

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
        Write-Verbose "Invoke-NSGetLsnsession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnsession objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsession objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsession objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nattype') ) { $arguments.Add('nattype', $nattype) } 
                if ( $PSBoundParameters.ContainsKey('clientname') ) { $arguments.Add('clientname', $clientname) } 
                if ( $PSBoundParameters.ContainsKey('network') ) { $arguments.Add('network', $network) } 
                if ( $PSBoundParameters.ContainsKey('netmask') ) { $arguments.Add('netmask', $netmask) } 
                if ( $PSBoundParameters.ContainsKey('network6') ) { $arguments.Add('network6', $network6) } 
                if ( $PSBoundParameters.ContainsKey('td') ) { $arguments.Add('td', $td) } 
                if ( $PSBoundParameters.ContainsKey('natip') ) { $arguments.Add('natip', $natip) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsession configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsnsession configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnsession: Ended"
    }
}

function Invoke-NSFlushLsnsipalgcall {
    <#
    .SYNOPSIS
        Flush Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN SIPALG call resource.
    .PARAMETER Callid 
        Call ID for the SIP call.
    .EXAMPLE
        PS C:\>Invoke-NSFlushLsnsipalgcall -callid <string>
        An example how to flush lsnsipalgcall config Object(s).
    .NOTES
        File Name : Invoke-NSFlushLsnsipalgcall
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsipalgcall/
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
        [string]$Callid 

    )
    begin {
        Write-Verbose "Invoke-NSFlushLsnsipalgcall: Starting"
    }
    process {
        try {
            $payload = @{ callid = $callid }

            if ( $PSCmdlet.ShouldProcess($Name, "Flush Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnsipalgcall -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSFlushLsnsipalgcall: Finished"
    }
}

function Invoke-NSGetLsnsipalgcall {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN SIPALG call resource.
    .PARAMETER Callid 
        Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retrieve all lsnsipalgcall object(s).
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcall
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsipalgcall -GetAll 
        Get all lsnsipalgcall data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsipalgcall -Count 
        Get the number of lsnsipalgcall objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcall -name <string>
        Get lsnsipalgcall object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcall -Filter @{ 'name'='<value>' }
        Get lsnsipalgcall data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnsipalgcall
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsipalgcall/
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
        [string]$Callid,

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
        Write-Verbose "Invoke-NSGetLsnsipalgcall: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnsipalgcall objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall configuration for property 'callid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnsipalgcall: Ended"
    }
}

function Invoke-NSGetLsnsipalgcallBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsnsipalgcall.
    .PARAMETER Callid 
        Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retrieve all lsnsipalgcall_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcallBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsipalgcallBinding -GetAll 
        Get all lsnsipalgcall_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcallBinding -name <string>
        Get lsnsipalgcall_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcallBinding -Filter @{ 'name'='<value>' }
        Get lsnsipalgcall_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnsipalgcallBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsipalgcall_binding/
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
        [string]$Callid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnsipalgcallBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnsipalgcall_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall_binding configuration for property 'callid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnsipalgcallBinding: Ended"
    }
}

function Invoke-NSGetLsnsipalgcallControlchannelBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the controlchannel that can be bound to lsnsipalgcall.
    .PARAMETER Callid 
        Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retrieve all lsnsipalgcall_controlchannel_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall_controlchannel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcallControlchannelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsipalgcallControlchannelBinding -GetAll 
        Get all lsnsipalgcall_controlchannel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsipalgcallControlchannelBinding -Count 
        Get the number of lsnsipalgcall_controlchannel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcallControlchannelBinding -name <string>
        Get lsnsipalgcall_controlchannel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcallControlchannelBinding -Filter @{ 'name'='<value>' }
        Get lsnsipalgcall_controlchannel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnsipalgcallControlchannelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsipalgcall_controlchannel_binding/
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
        [string]$Callid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnsipalgcallControlchannelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnsipalgcall_controlchannel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall_controlchannel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall_controlchannel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall_controlchannel_binding configuration for property 'callid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall_controlchannel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnsipalgcallControlchannelBinding: Ended"
    }
}

function Invoke-NSGetLsnsipalgcallDatachannelBinding {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Binding object showing the datachannel that can be bound to lsnsipalgcall.
    .PARAMETER Callid 
        Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retrieve all lsnsipalgcall_datachannel_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall_datachannel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcallDatachannelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsipalgcallDatachannelBinding -GetAll 
        Get all lsnsipalgcall_datachannel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsipalgcallDatachannelBinding -Count 
        Get the number of lsnsipalgcall_datachannel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcallDatachannelBinding -name <string>
        Get lsnsipalgcall_datachannel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgcallDatachannelBinding -Filter @{ 'name'='<value>' }
        Get lsnsipalgcall_datachannel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnsipalgcallDatachannelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsipalgcall_datachannel_binding/
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
        [string]$Callid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetLsnsipalgcallDatachannelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnsipalgcall_datachannel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall_datachannel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall_datachannel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall_datachannel_binding configuration for property 'callid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall_datachannel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnsipalgcallDatachannelBinding: Ended"
    }
}

function Invoke-NSAddLsnsipalgprofile {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN SIPALG Profile resource.
    .PARAMETER Sipalgprofilename 
        The name of the SIPALG Profile. 
    .PARAMETER Datasessionidletimeout 
        Idle timeout for the data channel sessions in seconds. 
    .PARAMETER Sipsessiontimeout 
        SIP control channel session timeout in seconds. 
    .PARAMETER Registrationtimeout 
        SIP registration timeout in seconds. 
    .PARAMETER Sipsrcportrange 
        Source port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Sipdstportrange 
        Destination port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Openregisterpinhole 
        ENABLE/DISABLE RegisterPinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Opencontactpinhole 
        ENABLE/DISABLE ContactPinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openviapinhole 
        ENABLE/DISABLE ViaPinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openrecordroutepinhole 
        ENABLE/DISABLE RecordRoutePinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Siptransportprotocol 
        SIP ALG Profile transport protocol type. 
        Possible values = TCP, UDP 
    .PARAMETER Openroutepinhole 
        ENABLE/DISABLE RoutePinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rport 
        ENABLE/DISABLE rport. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnsipalgprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnsipalgprofile -sipalgprofilename <string> -siptransportprotocol <string>
        An example how to add lsnsipalgprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnsipalgprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsipalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Sipalgprofilename,

        [double]$Datasessionidletimeout = '120',

        [double]$Sipsessiontimeout = '600',

        [double]$Registrationtimeout = '60',

        [string]$Sipsrcportrange,

        [string]$Sipdstportrange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openregisterpinhole = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Opencontactpinhole = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openviapinhole = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openrecordroutepinhole = 'ENABLED',

        [Parameter(Mandatory)]
        [ValidateSet('TCP', 'UDP')]
        [string]$Siptransportprotocol,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openroutepinhole = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Rport = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnsipalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ sipalgprofilename = $sipalgprofilename
                siptransportprotocol        = $siptransportprotocol
            }
            if ( $PSBoundParameters.ContainsKey('datasessionidletimeout') ) { $payload.Add('datasessionidletimeout', $datasessionidletimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsessiontimeout') ) { $payload.Add('sipsessiontimeout', $sipsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('registrationtimeout') ) { $payload.Add('registrationtimeout', $registrationtimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsrcportrange') ) { $payload.Add('sipsrcportrange', $sipsrcportrange) }
            if ( $PSBoundParameters.ContainsKey('sipdstportrange') ) { $payload.Add('sipdstportrange', $sipdstportrange) }
            if ( $PSBoundParameters.ContainsKey('openregisterpinhole') ) { $payload.Add('openregisterpinhole', $openregisterpinhole) }
            if ( $PSBoundParameters.ContainsKey('opencontactpinhole') ) { $payload.Add('opencontactpinhole', $opencontactpinhole) }
            if ( $PSBoundParameters.ContainsKey('openviapinhole') ) { $payload.Add('openviapinhole', $openviapinhole) }
            if ( $PSBoundParameters.ContainsKey('openrecordroutepinhole') ) { $payload.Add('openrecordroutepinhole', $openrecordroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('openroutepinhole') ) { $payload.Add('openroutepinhole', $openroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('rport') ) { $payload.Add('rport', $rport) }
            if ( $PSCmdlet.ShouldProcess("lsnsipalgprofile", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnsipalgprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnsipalgprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnsipalgprofile: Finished"
    }
}

function Invoke-NSUpdateLsnsipalgprofile {
    <#
    .SYNOPSIS
        Update Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN SIPALG Profile resource.
    .PARAMETER Sipalgprofilename 
        The name of the SIPALG Profile. 
    .PARAMETER Datasessionidletimeout 
        Idle timeout for the data channel sessions in seconds. 
    .PARAMETER Sipsessiontimeout 
        SIP control channel session timeout in seconds. 
    .PARAMETER Registrationtimeout 
        SIP registration timeout in seconds. 
    .PARAMETER Sipsrcportrange 
        Source port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Sipdstportrange 
        Destination port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Openregisterpinhole 
        ENABLE/DISABLE RegisterPinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Opencontactpinhole 
        ENABLE/DISABLE ContactPinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openviapinhole 
        ENABLE/DISABLE ViaPinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openrecordroutepinhole 
        ENABLE/DISABLE RecordRoutePinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Siptransportprotocol 
        SIP ALG Profile transport protocol type. 
        Possible values = TCP, UDP 
    .PARAMETER Openroutepinhole 
        ENABLE/DISABLE RoutePinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rport 
        ENABLE/DISABLE rport. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnsipalgprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLsnsipalgprofile -sipalgprofilename <string>
        An example how to update lsnsipalgprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLsnsipalgprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsipalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Sipalgprofilename,

        [double]$Datasessionidletimeout,

        [double]$Sipsessiontimeout,

        [double]$Registrationtimeout,

        [string]$Sipsrcportrange,

        [string]$Sipdstportrange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openregisterpinhole,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Opencontactpinhole,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openviapinhole,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openrecordroutepinhole,

        [ValidateSet('TCP', 'UDP')]
        [string]$Siptransportprotocol,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openroutepinhole,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Rport,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLsnsipalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ sipalgprofilename = $sipalgprofilename }
            if ( $PSBoundParameters.ContainsKey('datasessionidletimeout') ) { $payload.Add('datasessionidletimeout', $datasessionidletimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsessiontimeout') ) { $payload.Add('sipsessiontimeout', $sipsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('registrationtimeout') ) { $payload.Add('registrationtimeout', $registrationtimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsrcportrange') ) { $payload.Add('sipsrcportrange', $sipsrcportrange) }
            if ( $PSBoundParameters.ContainsKey('sipdstportrange') ) { $payload.Add('sipdstportrange', $sipdstportrange) }
            if ( $PSBoundParameters.ContainsKey('openregisterpinhole') ) { $payload.Add('openregisterpinhole', $openregisterpinhole) }
            if ( $PSBoundParameters.ContainsKey('opencontactpinhole') ) { $payload.Add('opencontactpinhole', $opencontactpinhole) }
            if ( $PSBoundParameters.ContainsKey('openviapinhole') ) { $payload.Add('openviapinhole', $openviapinhole) }
            if ( $PSBoundParameters.ContainsKey('openrecordroutepinhole') ) { $payload.Add('openrecordroutepinhole', $openrecordroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('siptransportprotocol') ) { $payload.Add('siptransportprotocol', $siptransportprotocol) }
            if ( $PSBoundParameters.ContainsKey('openroutepinhole') ) { $payload.Add('openroutepinhole', $openroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('rport') ) { $payload.Add('rport', $rport) }
            if ( $PSCmdlet.ShouldProcess("lsnsipalgprofile", "Update Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsnsipalgprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnsipalgprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateLsnsipalgprofile: Finished"
    }
}

function Invoke-NSUnsetLsnsipalgprofile {
    <#
    .SYNOPSIS
        Unset Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN SIPALG Profile resource.
    .PARAMETER Sipalgprofilename 
        The name of the SIPALG Profile. 
    .PARAMETER Datasessionidletimeout 
        Idle timeout for the data channel sessions in seconds. 
    .PARAMETER Sipsessiontimeout 
        SIP control channel session timeout in seconds. 
    .PARAMETER Registrationtimeout 
        SIP registration timeout in seconds. 
    .PARAMETER Sipsrcportrange 
        Source port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Sipdstportrange 
        Destination port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Openregisterpinhole 
        ENABLE/DISABLE RegisterPinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Opencontactpinhole 
        ENABLE/DISABLE ContactPinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openviapinhole 
        ENABLE/DISABLE ViaPinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openrecordroutepinhole 
        ENABLE/DISABLE RecordRoutePinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Siptransportprotocol 
        SIP ALG Profile transport protocol type. 
        Possible values = TCP, UDP 
    .PARAMETER Openroutepinhole 
        ENABLE/DISABLE RoutePinhole creation. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rport 
        ENABLE/DISABLE rport. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLsnsipalgprofile -sipalgprofilename <string>
        An example how to unset lsnsipalgprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLsnsipalgprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsipalgprofile
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

        [ValidateLength(1, 127)]
        [string]$Sipalgprofilename,

        [Boolean]$datasessionidletimeout,

        [Boolean]$sipsessiontimeout,

        [Boolean]$registrationtimeout,

        [Boolean]$sipsrcportrange,

        [Boolean]$sipdstportrange,

        [Boolean]$openregisterpinhole,

        [Boolean]$opencontactpinhole,

        [Boolean]$openviapinhole,

        [Boolean]$openrecordroutepinhole,

        [Boolean]$siptransportprotocol,

        [Boolean]$openroutepinhole,

        [Boolean]$rport 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLsnsipalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ sipalgprofilename = $sipalgprofilename }
            if ( $PSBoundParameters.ContainsKey('datasessionidletimeout') ) { $payload.Add('datasessionidletimeout', $datasessionidletimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsessiontimeout') ) { $payload.Add('sipsessiontimeout', $sipsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('registrationtimeout') ) { $payload.Add('registrationtimeout', $registrationtimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsrcportrange') ) { $payload.Add('sipsrcportrange', $sipsrcportrange) }
            if ( $PSBoundParameters.ContainsKey('sipdstportrange') ) { $payload.Add('sipdstportrange', $sipdstportrange) }
            if ( $PSBoundParameters.ContainsKey('openregisterpinhole') ) { $payload.Add('openregisterpinhole', $openregisterpinhole) }
            if ( $PSBoundParameters.ContainsKey('opencontactpinhole') ) { $payload.Add('opencontactpinhole', $opencontactpinhole) }
            if ( $PSBoundParameters.ContainsKey('openviapinhole') ) { $payload.Add('openviapinhole', $openviapinhole) }
            if ( $PSBoundParameters.ContainsKey('openrecordroutepinhole') ) { $payload.Add('openrecordroutepinhole', $openrecordroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('siptransportprotocol') ) { $payload.Add('siptransportprotocol', $siptransportprotocol) }
            if ( $PSBoundParameters.ContainsKey('openroutepinhole') ) { $payload.Add('openroutepinhole', $openroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('rport') ) { $payload.Add('rport', $rport) }
            if ( $PSCmdlet.ShouldProcess("$sipalgprofilename", "Unset Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type lsnsipalgprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLsnsipalgprofile: Finished"
    }
}

function Invoke-NSDeleteLsnsipalgprofile {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN SIPALG Profile resource.
    .PARAMETER Sipalgprofilename 
        The name of the SIPALG Profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnsipalgprofile -Sipalgprofilename <string>
        An example how to delete lsnsipalgprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnsipalgprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsipalgprofile/
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
        [string]$Sipalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsnsipalgprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$sipalgprofilename", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnsipalgprofile -NitroPath nitro/v1/config -Resource $sipalgprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnsipalgprofile: Finished"
    }
}

function Invoke-NSGetLsnsipalgprofile {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN SIPALG Profile resource.
    .PARAMETER Sipalgprofilename 
        The name of the SIPALG Profile. 
    .PARAMETER GetAll 
        Retrieve all lsnsipalgprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsnsipalgprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsipalgprofile -GetAll 
        Get all lsnsipalgprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnsipalgprofile -Count 
        Get the number of lsnsipalgprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgprofile -name <string>
        Get lsnsipalgprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnsipalgprofile -Filter @{ 'name'='<value>' }
        Get lsnsipalgprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnsipalgprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnsipalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Sipalgprofilename,

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
        Write-Verbose "Invoke-NSGetLsnsipalgprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnsipalgprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgprofile configuration for property 'sipalgprofilename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Resource $sipalgprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnsipalgprofile: Ended"
    }
}

function Invoke-NSAddLsnstatic {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for static mapping resource.
    .PARAMETER Name 
        Name for the LSN static mapping entry. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Transportprotocol 
        Protocol for the LSN mapping entry. 
        Possible values = TCP, UDP, ICMP, ALL 
    .PARAMETER Subscrip 
        IPv4(NAT44 &amp; DS-Lite)/IPv6(NAT64) address of an LSN subscriber for the LSN static mapping entry. 
    .PARAMETER Subscrport 
        Port of the LSN subscriber for the LSN mapping entry. * represents all ports being used. Used in case of static wildcard. 
         
        Maximum value = 65535 
    .PARAMETER Network6 
        B4 address in DS-Lite setup. 
    .PARAMETER Td 
        ID of the traffic domain to which the subscriber belongs. 
         
        If you do not specify an ID, the subscriber is assumed to be a part of the default traffic domain. 
         
         
        Maximum value = 4094 
    .PARAMETER Natip 
        IPv4 address, already existing on the Citrix ADC as type LSN, to be used as NAT IP address for this mapping entry. 
    .PARAMETER Natport 
        NAT port for this LSN mapping entry. * represents all ports being used. Used in case of static wildcard. 
         
        Maximum value = 65535 
    .PARAMETER Destip 
        Destination IP address for the LSN mapping entry. 
    .PARAMETER Dsttd 
        ID of the traffic domain through which the destination IP address for this LSN mapping entry is reachable from the Citrix ADC. 
         
        If you do not specify an ID, the destination IP address is assumed to be reachable through the default traffic domain, which has an ID of 0. 
         
         
        Maximum value = 4094 
    .PARAMETER PassThru 
        Return details about the created lsnstatic item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsnstatic -name <string> -transportprotocol <string> -subscrip <string> -subscrport <int>
        An example how to add lsnstatic config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsnstatic
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnstatic/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('TCP', 'UDP', 'ICMP', 'ALL')]
        [string]$Transportprotocol,

        [Parameter(Mandatory)]
        [string]$Subscrip,

        [Parameter(Mandatory)]
        [ValidateRange(1, 65535)]
        [int]$Subscrport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Network6,

        [double]$Td = '0',

        [string]$Natip,

        [ValidateRange(1, 65535)]
        [int]$Natport,

        [string]$Destip,

        [double]$Dsttd = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsnstatic: Starting"
    }
    process {
        try {
            $payload = @{ name    = $name
                transportprotocol = $transportprotocol
                subscrip          = $subscrip
                subscrport        = $subscrport
            }
            if ( $PSBoundParameters.ContainsKey('network6') ) { $payload.Add('network6', $network6) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('natip') ) { $payload.Add('natip', $natip) }
            if ( $PSBoundParameters.ContainsKey('natport') ) { $payload.Add('natport', $natport) }
            if ( $PSBoundParameters.ContainsKey('destip') ) { $payload.Add('destip', $destip) }
            if ( $PSBoundParameters.ContainsKey('dsttd') ) { $payload.Add('dsttd', $dsttd) }
            if ( $PSCmdlet.ShouldProcess("lsnstatic", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsnstatic -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsnstatic -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsnstatic: Finished"
    }
}

function Invoke-NSDeleteLsnstatic {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for static mapping resource.
    .PARAMETER Name 
        Name for the LSN static mapping entry. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsnstatic -Name <string>
        An example how to delete lsnstatic config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsnstatic
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnstatic/
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
        Write-Verbose "Invoke-NSDeleteLsnstatic: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsnstatic -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsnstatic: Finished"
    }
}

function Invoke-NSGetLsnstatic {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for static mapping resource.
    .PARAMETER Name 
        Name for the LSN static mapping entry. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsnstatic object(s).
    .PARAMETER Count
        If specified, the count of the lsnstatic object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnstatic
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnstatic -GetAll 
        Get all lsnstatic data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsnstatic -Count 
        Get the number of lsnstatic objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnstatic -name <string>
        Get lsnstatic object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsnstatic -Filter @{ 'name'='<value>' }
        Get lsnstatic data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsnstatic
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsnstatic/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-NSGetLsnstatic: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnstatic objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnstatic objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnstatic objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnstatic configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnstatic configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsnstatic: Ended"
    }
}

function Invoke-NSAddLsntransportprofile {
    <#
    .SYNOPSIS
        Add Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Transport Profile resource.
    .PARAMETER Transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER Transportprotocol 
        Protocol for which to set the LSN transport profile parameters. 
        Possible values = TCP, UDP, ICMP 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session. 
         
        This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. . 
    .PARAMETER Finrsttimeout 
        Timeout, in seconds, for a TCP LSN session after a FIN or RST message is received from one of the endpoints. 
         
        If a TCP LSN session is idle (after the Citrix ADC receives a FIN or RST message) for a time that exceeds this value, the Citrix ADC ADC removes the session. 
         
        Since the LSN feature of the Citrix ADC does not maintain state information of any TCP LSN sessions, this timeout accommodates the transmission of the FIN or RST, and ACK messages from the other endpoint so that both endpoints can properly close the connection. 
    .PARAMETER Stuntimeout 
        STUN protocol timeout. 
         
         
        Maximum value = 1200 
    .PARAMETER Synidletimeout 
        SYN Idle timeout. 
         
         
        Maximum value = 120 
    .PARAMETER Portquota 
        Maximum number of LSN NAT ports to be used at a time by each subscriber for the specified protocol. For example, each subscriber can be limited to a maximum of 500 TCP NAT ports. When the LSN NAT mappings for a subscriber reach the limit, the Citrix ADC does not allocate additional NAT ports for that subscriber. 
         
         
        Maximum value = 65535 
    .PARAMETER Sessionquota 
        Maximum number of concurrent LSN sessions allowed for each subscriber for the specified protocol. 
        When the number of LSN sessions reaches the limit for a subscriber, the Citrix ADC does not allow the subscriber to open additional sessions. 
         
         
        Maximum value = 65535 
    .PARAMETER Groupsessionlimit 
        Maximum number of concurrent LSN sessions(for the specified protocol) allowed for all subscriber of a group to which this profile has bound. This limit will get split across the Citrix ADCs packet engines and rounded down. When the number of LSN sessions reaches the limit for a group in packet engine, the Citrix ADC does not allow the subscriber of that group to open additional sessions through that packet engine. 
    .PARAMETER Portpreserveparity 
        Enable port parity between a subscriber port and its mapped LSN NAT port. For example, if a subscriber initiates a connection from an odd numbered port, the Citrix ADC allocates an odd numbered LSN NAT port for this connection. 
        You must set this parameter for proper functioning of protocols that require the source port to be even or odd numbered, for example, in peer-to-peer applications that use RTP or RTCP protocol. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Portpreserverange 
        If a subscriber initiates a connection from a well-known port (0-1023), allocate a NAT port from the well-known port range (0-1023) for this connection. For example, if a subscriber initiates a connection from port 80, the Citrix ADC can allocate port 100 as the NAT port for this connection. 
         
        This parameter applies to dynamic NAT without port block allocation. It also applies to Deterministic NAT if the range of ports allocated includes well-known ports. 
         
        When all the well-known ports of all the available NAT IP addresses are used in different subscriber's connections (LSN sessions), and a subscriber initiates a connection from a well-known port, the Citrix ADC drops this connection. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncheck 
        Silently drop any non-SYN packets for connections for which there is no LSN-NAT session present on the Citrix ADC. 
         
        If you disable this parameter, the Citrix ADC accepts any non-SYN packets and creates a new LSN session entry for this connection. 
         
        Following are some reasons for the Citrix ADC to receive such packets: 
         
        * LSN session for a connection existed but the Citrix ADC removed this session because the LSN session was idle for a time that exceeded the configured session timeout. 
        * Such packets can be a part of a DoS attack. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsntransportprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLsntransportprofile -transportprofilename <string> -transportprotocol <string>
        An example how to add lsntransportprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddLsntransportprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsntransportprofile/
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
        [ValidateLength(1, 127)]
        [string]$Transportprofilename,

        [Parameter(Mandatory)]
        [ValidateSet('TCP', 'UDP', 'ICMP')]
        [string]$Transportprotocol,

        [double]$Sessiontimeout = '120',

        [double]$Finrsttimeout = '30',

        [double]$Stuntimeout = '600',

        [double]$Synidletimeout = '60',

        [double]$Portquota = '0',

        [double]$Sessionquota = '0',

        [double]$Groupsessionlimit = '0',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Portpreserveparity = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Portpreserverange = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Syncheck = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLsntransportprofile: Starting"
    }
    process {
        try {
            $payload = @{ transportprofilename = $transportprofilename
                transportprotocol              = $transportprotocol
            }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('finrsttimeout') ) { $payload.Add('finrsttimeout', $finrsttimeout) }
            if ( $PSBoundParameters.ContainsKey('stuntimeout') ) { $payload.Add('stuntimeout', $stuntimeout) }
            if ( $PSBoundParameters.ContainsKey('synidletimeout') ) { $payload.Add('synidletimeout', $synidletimeout) }
            if ( $PSBoundParameters.ContainsKey('portquota') ) { $payload.Add('portquota', $portquota) }
            if ( $PSBoundParameters.ContainsKey('sessionquota') ) { $payload.Add('sessionquota', $sessionquota) }
            if ( $PSBoundParameters.ContainsKey('groupsessionlimit') ) { $payload.Add('groupsessionlimit', $groupsessionlimit) }
            if ( $PSBoundParameters.ContainsKey('portpreserveparity') ) { $payload.Add('portpreserveparity', $portpreserveparity) }
            if ( $PSBoundParameters.ContainsKey('portpreserverange') ) { $payload.Add('portpreserverange', $portpreserverange) }
            if ( $PSBoundParameters.ContainsKey('syncheck') ) { $payload.Add('syncheck', $syncheck) }
            if ( $PSCmdlet.ShouldProcess("lsntransportprofile", "Add Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type lsntransportprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsntransportprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLsntransportprofile: Finished"
    }
}

function Invoke-NSDeleteLsntransportprofile {
    <#
    .SYNOPSIS
        Delete Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Transport Profile resource.
    .PARAMETER Transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLsntransportprofile -Transportprofilename <string>
        An example how to delete lsntransportprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLsntransportprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsntransportprofile/
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
        [string]$Transportprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLsntransportprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$transportprofilename", "Delete Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type lsntransportprofile -NitroPath nitro/v1/config -Resource $transportprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLsntransportprofile: Finished"
    }
}

function Invoke-NSUpdateLsntransportprofile {
    <#
    .SYNOPSIS
        Update Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Transport Profile resource.
    .PARAMETER Transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session. 
         
        This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. . 
    .PARAMETER Finrsttimeout 
        Timeout, in seconds, for a TCP LSN session after a FIN or RST message is received from one of the endpoints. 
         
        If a TCP LSN session is idle (after the Citrix ADC receives a FIN or RST message) for a time that exceeds this value, the Citrix ADC ADC removes the session. 
         
        Since the LSN feature of the Citrix ADC does not maintain state information of any TCP LSN sessions, this timeout accommodates the transmission of the FIN or RST, and ACK messages from the other endpoint so that both endpoints can properly close the connection. 
    .PARAMETER Stuntimeout 
        STUN protocol timeout. 
         
         
        Maximum value = 1200 
    .PARAMETER Synidletimeout 
        SYN Idle timeout. 
         
         
        Maximum value = 120 
    .PARAMETER Portquota 
        Maximum number of LSN NAT ports to be used at a time by each subscriber for the specified protocol. For example, each subscriber can be limited to a maximum of 500 TCP NAT ports. When the LSN NAT mappings for a subscriber reach the limit, the Citrix ADC does not allocate additional NAT ports for that subscriber. 
         
         
        Maximum value = 65535 
    .PARAMETER Sessionquota 
        Maximum number of concurrent LSN sessions allowed for each subscriber for the specified protocol. 
        When the number of LSN sessions reaches the limit for a subscriber, the Citrix ADC does not allow the subscriber to open additional sessions. 
         
         
        Maximum value = 65535 
    .PARAMETER Groupsessionlimit 
        Maximum number of concurrent LSN sessions(for the specified protocol) allowed for all subscriber of a group to which this profile has bound. This limit will get split across the Citrix ADCs packet engines and rounded down. When the number of LSN sessions reaches the limit for a group in packet engine, the Citrix ADC does not allow the subscriber of that group to open additional sessions through that packet engine. 
    .PARAMETER Portpreserveparity 
        Enable port parity between a subscriber port and its mapped LSN NAT port. For example, if a subscriber initiates a connection from an odd numbered port, the Citrix ADC allocates an odd numbered LSN NAT port for this connection. 
        You must set this parameter for proper functioning of protocols that require the source port to be even or odd numbered, for example, in peer-to-peer applications that use RTP or RTCP protocol. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Portpreserverange 
        If a subscriber initiates a connection from a well-known port (0-1023), allocate a NAT port from the well-known port range (0-1023) for this connection. For example, if a subscriber initiates a connection from port 80, the Citrix ADC can allocate port 100 as the NAT port for this connection. 
         
        This parameter applies to dynamic NAT without port block allocation. It also applies to Deterministic NAT if the range of ports allocated includes well-known ports. 
         
        When all the well-known ports of all the available NAT IP addresses are used in different subscriber's connections (LSN sessions), and a subscriber initiates a connection from a well-known port, the Citrix ADC drops this connection. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncheck 
        Silently drop any non-SYN packets for connections for which there is no LSN-NAT session present on the Citrix ADC. 
         
        If you disable this parameter, the Citrix ADC accepts any non-SYN packets and creates a new LSN session entry for this connection. 
         
        Following are some reasons for the Citrix ADC to receive such packets: 
         
        * LSN session for a connection existed but the Citrix ADC removed this session because the LSN session was idle for a time that exceeded the configured session timeout. 
        * Such packets can be a part of a DoS attack. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsntransportprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLsntransportprofile -transportprofilename <string>
        An example how to update lsntransportprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLsntransportprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsntransportprofile/
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
        [ValidateLength(1, 127)]
        [string]$Transportprofilename,

        [double]$Sessiontimeout,

        [double]$Finrsttimeout,

        [double]$Stuntimeout,

        [double]$Synidletimeout,

        [double]$Portquota,

        [double]$Sessionquota,

        [double]$Groupsessionlimit,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Portpreserveparity,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Portpreserverange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Syncheck,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLsntransportprofile: Starting"
    }
    process {
        try {
            $payload = @{ transportprofilename = $transportprofilename }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('finrsttimeout') ) { $payload.Add('finrsttimeout', $finrsttimeout) }
            if ( $PSBoundParameters.ContainsKey('stuntimeout') ) { $payload.Add('stuntimeout', $stuntimeout) }
            if ( $PSBoundParameters.ContainsKey('synidletimeout') ) { $payload.Add('synidletimeout', $synidletimeout) }
            if ( $PSBoundParameters.ContainsKey('portquota') ) { $payload.Add('portquota', $portquota) }
            if ( $PSBoundParameters.ContainsKey('sessionquota') ) { $payload.Add('sessionquota', $sessionquota) }
            if ( $PSBoundParameters.ContainsKey('groupsessionlimit') ) { $payload.Add('groupsessionlimit', $groupsessionlimit) }
            if ( $PSBoundParameters.ContainsKey('portpreserveparity') ) { $payload.Add('portpreserveparity', $portpreserveparity) }
            if ( $PSBoundParameters.ContainsKey('portpreserverange') ) { $payload.Add('portpreserverange', $portpreserverange) }
            if ( $PSBoundParameters.ContainsKey('syncheck') ) { $payload.Add('syncheck', $syncheck) }
            if ( $PSCmdlet.ShouldProcess("lsntransportprofile", "Update Large Scale NAT commands config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type lsntransportprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLsntransportprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateLsntransportprofile: Finished"
    }
}

function Invoke-NSUnsetLsntransportprofile {
    <#
    .SYNOPSIS
        Unset Large Scale NAT commands config Object.
    .DESCRIPTION
        Configuration for LSN Transport Profile resource.
    .PARAMETER Transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session. 
         
        This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. . 
    .PARAMETER Finrsttimeout 
        Timeout, in seconds, for a TCP LSN session after a FIN or RST message is received from one of the endpoints. 
         
        If a TCP LSN session is idle (after the Citrix ADC receives a FIN or RST message) for a time that exceeds this value, the Citrix ADC ADC removes the session. 
         
        Since the LSN feature of the Citrix ADC does not maintain state information of any TCP LSN sessions, this timeout accommodates the transmission of the FIN or RST, and ACK messages from the other endpoint so that both endpoints can properly close the connection. 
    .PARAMETER Stuntimeout 
        STUN protocol timeout. 
         
         
        Maximum value = 1200 
    .PARAMETER Synidletimeout 
        SYN Idle timeout. 
         
         
        Maximum value = 120 
    .PARAMETER Portquota 
        Maximum number of LSN NAT ports to be used at a time by each subscriber for the specified protocol. For example, each subscriber can be limited to a maximum of 500 TCP NAT ports. When the LSN NAT mappings for a subscriber reach the limit, the Citrix ADC does not allocate additional NAT ports for that subscriber. 
         
         
        Maximum value = 65535 
    .PARAMETER Sessionquota 
        Maximum number of concurrent LSN sessions allowed for each subscriber for the specified protocol. 
        When the number of LSN sessions reaches the limit for a subscriber, the Citrix ADC does not allow the subscriber to open additional sessions. 
         
         
        Maximum value = 65535 
    .PARAMETER Groupsessionlimit 
        Maximum number of concurrent LSN sessions(for the specified protocol) allowed for all subscriber of a group to which this profile has bound. This limit will get split across the Citrix ADCs packet engines and rounded down. When the number of LSN sessions reaches the limit for a group in packet engine, the Citrix ADC does not allow the subscriber of that group to open additional sessions through that packet engine. 
    .PARAMETER Portpreserveparity 
        Enable port parity between a subscriber port and its mapped LSN NAT port. For example, if a subscriber initiates a connection from an odd numbered port, the Citrix ADC allocates an odd numbered LSN NAT port for this connection. 
        You must set this parameter for proper functioning of protocols that require the source port to be even or odd numbered, for example, in peer-to-peer applications that use RTP or RTCP protocol. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Portpreserverange 
        If a subscriber initiates a connection from a well-known port (0-1023), allocate a NAT port from the well-known port range (0-1023) for this connection. For example, if a subscriber initiates a connection from port 80, the Citrix ADC can allocate port 100 as the NAT port for this connection. 
         
        This parameter applies to dynamic NAT without port block allocation. It also applies to Deterministic NAT if the range of ports allocated includes well-known ports. 
         
        When all the well-known ports of all the available NAT IP addresses are used in different subscriber's connections (LSN sessions), and a subscriber initiates a connection from a well-known port, the Citrix ADC drops this connection. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncheck 
        Silently drop any non-SYN packets for connections for which there is no LSN-NAT session present on the Citrix ADC. 
         
        If you disable this parameter, the Citrix ADC accepts any non-SYN packets and creates a new LSN session entry for this connection. 
         
        Following are some reasons for the Citrix ADC to receive such packets: 
         
        * LSN session for a connection existed but the Citrix ADC removed this session because the LSN session was idle for a time that exceeded the configured session timeout. 
        * Such packets can be a part of a DoS attack. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLsntransportprofile -transportprofilename <string>
        An example how to unset lsntransportprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLsntransportprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsntransportprofile
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
        [ValidateLength(1, 127)]
        [string]$Transportprofilename,

        [Boolean]$sessiontimeout,

        [Boolean]$finrsttimeout,

        [Boolean]$stuntimeout,

        [Boolean]$synidletimeout,

        [Boolean]$portquota,

        [Boolean]$sessionquota,

        [Boolean]$groupsessionlimit,

        [Boolean]$portpreserveparity,

        [Boolean]$portpreserverange,

        [Boolean]$syncheck 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLsntransportprofile: Starting"
    }
    process {
        try {
            $payload = @{ transportprofilename = $transportprofilename }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('finrsttimeout') ) { $payload.Add('finrsttimeout', $finrsttimeout) }
            if ( $PSBoundParameters.ContainsKey('stuntimeout') ) { $payload.Add('stuntimeout', $stuntimeout) }
            if ( $PSBoundParameters.ContainsKey('synidletimeout') ) { $payload.Add('synidletimeout', $synidletimeout) }
            if ( $PSBoundParameters.ContainsKey('portquota') ) { $payload.Add('portquota', $portquota) }
            if ( $PSBoundParameters.ContainsKey('sessionquota') ) { $payload.Add('sessionquota', $sessionquota) }
            if ( $PSBoundParameters.ContainsKey('groupsessionlimit') ) { $payload.Add('groupsessionlimit', $groupsessionlimit) }
            if ( $PSBoundParameters.ContainsKey('portpreserveparity') ) { $payload.Add('portpreserveparity', $portpreserveparity) }
            if ( $PSBoundParameters.ContainsKey('portpreserverange') ) { $payload.Add('portpreserverange', $portpreserverange) }
            if ( $PSBoundParameters.ContainsKey('syncheck') ) { $payload.Add('syncheck', $syncheck) }
            if ( $PSCmdlet.ShouldProcess("$transportprofilename", "Unset Large Scale NAT commands config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type lsntransportprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLsntransportprofile: Finished"
    }
}

function Invoke-NSGetLsntransportprofile {
    <#
    .SYNOPSIS
        Get Large Scale NAT commands config object(s).
    .DESCRIPTION
        Configuration for LSN Transport Profile resource.
    .PARAMETER Transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsntransportprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsntransportprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsntransportprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsntransportprofile -GetAll 
        Get all lsntransportprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLsntransportprofile -Count 
        Get the number of lsntransportprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsntransportprofile -name <string>
        Get lsntransportprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLsntransportprofile -Filter @{ 'name'='<value>' }
        Get lsntransportprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetLsntransportprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/lsn/lsntransportprofile/
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
        [ValidateLength(1, 127)]
        [string]$Transportprofilename,

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
        Write-Verbose "Invoke-NSGetLsntransportprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsntransportprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsntransportprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsntransportprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsntransportprofile configuration for property 'transportprofilename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Resource $transportprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsntransportprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLsntransportprofile: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAi+JMOizQ14Lgc
# RhZgLWwN/WjsugtiUC+wmenRYt4sMKCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgxT74+bwarCx3srZ3wDcAw0fiM0k5VHSMjXkWh7MvshwwDQYJKoZIhvcNAQEB
# BQAEggEAd2wKeWqxSCM7KtCrPde37EeyBg7FuaznS5PuaM7AT9IX1PkY6mrqinXd
# ObV9RTbfxpOfu+1Rerr+WmJteOqeJg1Edgz9I2q4Y2kBtZ2NSwx3HBl7vbTaVoyP
# tQO85gVRYeb1m6f4uQLIFy3mUSh7tGJKCfjMWEuGGGh3vOtQPtklXsftAk8pWev/
# EJUTjNTri9FikcHc0XjNk9Qg63W+BcPcSe02LgGd4CHeKyEm+HQusKb7fy3vyHjF
# LaL0TiWv7WUsmqjcoysThd2cVicdYbFa3/vQQBhvMIE9CebL+O9J4Q/6OjSrOqeF
# 6W85mGTNsV4moUetG3Kp9ab9w2R9BA==
# SIG # End signature block
