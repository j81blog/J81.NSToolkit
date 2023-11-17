function Invoke-NSAddDnsaaaarec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for IPv6 address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER Ipv6address 
        One or more IPv6 addresses to assign to the domain name. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsaaaarec -hostname <string> -ipv6address <string>
        An example how to add dnsaaaarec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsaaaarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaaaarec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Hostname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipv6address,

        [double]$Ttl = '3600' 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsaaaarec: Starting"
    }
    process {
        try {
            $payload = @{ hostname = $hostname
                ipv6address        = $ipv6address
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsaaaarec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsaaaarec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddDnsaaaarec: Finished"
    }
}

function Invoke-NSDeleteDnsaaaarec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for IPv6 address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached records need to be removed. 
    .PARAMETER Ipv6address 
        One or more IPv6 addresses to assign to the domain name.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsaaaarec -Hostname <string>
        An example how to delete dnsaaaarec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsaaaarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaaaarec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Hostname,

        [string]$Ecssubnet,

        [string]$Ipv6address 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsaaaarec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSBoundParameters.ContainsKey('Ipv6address') ) { $arguments.Add('ipv6address', $Ipv6address) }
            if ( $PSCmdlet.ShouldProcess("$hostname", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsaaaarec -NitroPath nitro/v1/config -Resource $hostname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsaaaarec: Finished"
    }
}

function Invoke-NSGetDnsaaaarec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for IPv6 address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER Ipv6address 
        One or more IPv6 addresses to assign to the domain name. 
    .PARAMETER Type 
        Type of records to display. Available settings function as follows: 
        * ADNS - Display all authoritative address records. 
        * PROXY - Display all proxy address records. 
        * ALL - Display all address records. 
        Possible values = ALL, ADNS, PROXY 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all dnsaaaarec object(s).
    .PARAMETER Count
        If specified, the count of the dnsaaaarec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaaaarec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsaaaarec -GetAll 
        Get all dnsaaaarec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsaaaarec -Count 
        Get the number of dnsaaaarec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaaaarec -name <string>
        Get dnsaaaarec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaaaarec -Filter @{ 'name'='<value>' }
        Get dnsaaaarec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsaaaarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaaaarec/
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
        [string]$Hostname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipv6address,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ALL', 'ADNS', 'PROXY')]
        [string]$Type,

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
        Write-Verbose "Invoke-NSGetDnsaaaarec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsaaaarec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaaaarec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaaaarec objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('hostname') ) { $arguments.Add('hostname', $hostname) } 
                if ( $PSBoundParameters.ContainsKey('ipv6address') ) { $arguments.Add('ipv6address', $ipv6address) } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaaaarec configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsaaaarec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsaaaarec: Ended"
    }
}

function Invoke-NSAddDnsaction {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS action resource.
    .PARAMETER Actionname 
        Name of the dns action. 
    .PARAMETER Actiontype 
        The type of DNS action that is being configured. 
        Possible values = ViewName, GslbPrefLoc, noop, Drop, Cache_Bypass, Rewrite_Response 
    .PARAMETER Ipaddress 
        List of IP address to be returned in case of rewrite_response actiontype. They can be of IPV4 or IPV6 type. 
        In case of set command We will remove all the IP address previously present in the action and will add new once given in set dns action command. 
    .PARAMETER Ttl 
        Time to live, in seconds. 
         
         
        Maximum value = 2147483647 
    .PARAMETER Viewname 
        The view name that must be used for the given action. 
    .PARAMETER Preferredloclist 
        The location list in priority order used for the given action. 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the transaction for which the action is chosen. 
    .PARAMETER PassThru 
        Return details about the created dnsaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsaction -actionname <string> -actiontype <string>
        An example how to add dnsaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Actionname,

        [Parameter(Mandatory)]
        [ValidateSet('ViewName', 'GslbPrefLoc', 'noop', 'Drop', 'Cache_Bypass', 'Rewrite_Response')]
        [string]$Actiontype,

        [string[]]$Ipaddress,

        [double]$Ttl = '3600',

        [string]$Viewname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Preferredloclist,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsaction: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname
                actiontype           = $actiontype
            }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('preferredloclist') ) { $payload.Add('preferredloclist', $preferredloclist) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSCmdlet.ShouldProcess("dnsaction", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnsaction: Finished"
    }
}

function Invoke-NSDeleteDnsaction {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS action resource.
    .PARAMETER Actionname 
        Name of the dns action.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsaction -Actionname <string>
        An example how to delete dnsaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Actionname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$actionname", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsaction -NitroPath nitro/v1/config -Resource $actionname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsaction: Finished"
    }
}

function Invoke-NSUpdateDnsaction {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS action resource.
    .PARAMETER Actionname 
        Name of the dns action. 
    .PARAMETER Ipaddress 
        List of IP address to be returned in case of rewrite_response actiontype. They can be of IPV4 or IPV6 type. 
        In case of set command We will remove all the IP address previously present in the action and will add new once given in set dns action command. 
    .PARAMETER Ttl 
        Time to live, in seconds. 
         
         
        Maximum value = 2147483647 
    .PARAMETER Viewname 
        The view name that must be used for the given action. 
    .PARAMETER Preferredloclist 
        The location list in priority order used for the given action. 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the transaction for which the action is chosen. 
    .PARAMETER PassThru 
        Return details about the created dnsaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnsaction -actionname <string>
        An example how to update dnsaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Actionname,

        [string[]]$Ipaddress,

        [double]$Ttl,

        [string]$Viewname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Preferredloclist,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnsaction: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('preferredloclist') ) { $payload.Add('preferredloclist', $preferredloclist) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSCmdlet.ShouldProcess("dnsaction", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnsaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateDnsaction: Finished"
    }
}

function Invoke-NSUnsetDnsaction {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS action resource.
    .PARAMETER Actionname 
        Name of the dns action. 
    .PARAMETER Ttl 
        Time to live, in seconds. 
         
         
        Maximum value = 2147483647 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the transaction for which the action is chosen.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnsaction -actionname <string>
        An example how to unset dnsaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaction
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Actionname,

        [Boolean]$ttl,

        [Boolean]$dnsprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnsaction: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSCmdlet.ShouldProcess("$actionname", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnsaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnsaction: Finished"
    }
}

function Invoke-NSGetDnsaction {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for DNS action resource.
    .PARAMETER Actionname 
        Name of the dns action. 
    .PARAMETER GetAll 
        Retrieve all dnsaction object(s).
    .PARAMETER Count
        If specified, the count of the dnsaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsaction -GetAll 
        Get all dnsaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsaction -Count 
        Get the number of dnsaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaction -name <string>
        Get dnsaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaction -Filter @{ 'name'='<value>' }
        Get dnsaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaction/
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
        [string]$Actionname,

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
        Write-Verbose "Invoke-NSGetDnsaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaction configuration for property 'actionname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Resource $actionname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsaction: Ended"
    }
}

function Invoke-NSAddDnsaction64 {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns64 action resource.
    .PARAMETER Actionname 
        Name of the dns64 action. 
    .PARAMETER Prefix 
        The dns64 prefix to be used if the after evaluating the rules. 
    .PARAMETER Mappedrule 
        The expression to select the criteria for ipv4 addresses to be used for synthesis. 
        Only if the mappedrule is evaluated to true the corresponding ipv4 address is used for synthesis using respective prefix, 
        otherwise the A RR is discarded. 
    .PARAMETER Excluderule 
        The expression to select the criteria for eliminating the corresponding ipv6 addresses from the response. 
    .PARAMETER PassThru 
        Return details about the created dnsaction64 item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsaction64 -actionname <string> -prefix <string>
        An example how to add dnsaction64 config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsaction64
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaction64/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Actionname,

        [Parameter(Mandatory)]
        [string]$Prefix,

        [string]$Mappedrule,

        [string]$Excluderule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsaction64: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname
                prefix               = $prefix
            }
            if ( $PSBoundParameters.ContainsKey('mappedrule') ) { $payload.Add('mappedrule', $mappedrule) }
            if ( $PSBoundParameters.ContainsKey('excluderule') ) { $payload.Add('excluderule', $excluderule) }
            if ( $PSCmdlet.ShouldProcess("dnsaction64", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsaction64 -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsaction64 -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnsaction64: Finished"
    }
}

function Invoke-NSDeleteDnsaction64 {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns64 action resource.
    .PARAMETER Actionname 
        Name of the dns64 action.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsaction64 -Actionname <string>
        An example how to delete dnsaction64 config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsaction64
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaction64/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Actionname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsaction64: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$actionname", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsaction64 -NitroPath nitro/v1/config -Resource $actionname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsaction64: Finished"
    }
}

function Invoke-NSUpdateDnsaction64 {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns64 action resource.
    .PARAMETER Actionname 
        Name of the dns64 action. 
    .PARAMETER Prefix 
        The dns64 prefix to be used if the after evaluating the rules. 
    .PARAMETER Mappedrule 
        The expression to select the criteria for ipv4 addresses to be used for synthesis. 
        Only if the mappedrule is evaluated to true the corresponding ipv4 address is used for synthesis using respective prefix, 
        otherwise the A RR is discarded. 
    .PARAMETER Excluderule 
        The expression to select the criteria for eliminating the corresponding ipv6 addresses from the response. 
    .PARAMETER PassThru 
        Return details about the created dnsaction64 item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnsaction64 -actionname <string>
        An example how to update dnsaction64 config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnsaction64
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaction64/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Actionname,

        [string]$Prefix,

        [string]$Mappedrule,

        [string]$Excluderule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnsaction64: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname }
            if ( $PSBoundParameters.ContainsKey('prefix') ) { $payload.Add('prefix', $prefix) }
            if ( $PSBoundParameters.ContainsKey('mappedrule') ) { $payload.Add('mappedrule', $mappedrule) }
            if ( $PSBoundParameters.ContainsKey('excluderule') ) { $payload.Add('excluderule', $excluderule) }
            if ( $PSCmdlet.ShouldProcess("dnsaction64", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnsaction64 -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsaction64 -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateDnsaction64: Finished"
    }
}

function Invoke-NSUnsetDnsaction64 {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns64 action resource.
    .PARAMETER Actionname 
        Name of the dns64 action. 
    .PARAMETER Prefix 
        The dns64 prefix to be used if the after evaluating the rules. 
    .PARAMETER Mappedrule 
        The expression to select the criteria for ipv4 addresses to be used for synthesis. 
        Only if the mappedrule is evaluated to true the corresponding ipv4 address is used for synthesis using respective prefix, 
        otherwise the A RR is discarded. 
    .PARAMETER Excluderule 
        The expression to select the criteria for eliminating the corresponding ipv6 addresses from the response.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnsaction64 -actionname <string>
        An example how to unset dnsaction64 config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnsaction64
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaction64
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Actionname,

        [Boolean]$prefix,

        [Boolean]$mappedrule,

        [Boolean]$excluderule 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnsaction64: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname }
            if ( $PSBoundParameters.ContainsKey('prefix') ) { $payload.Add('prefix', $prefix) }
            if ( $PSBoundParameters.ContainsKey('mappedrule') ) { $payload.Add('mappedrule', $mappedrule) }
            if ( $PSBoundParameters.ContainsKey('excluderule') ) { $payload.Add('excluderule', $excluderule) }
            if ( $PSCmdlet.ShouldProcess("$actionname", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnsaction64 -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnsaction64: Finished"
    }
}

function Invoke-NSGetDnsaction64 {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for dns64 action resource.
    .PARAMETER Actionname 
        Name of the dns64 action. 
    .PARAMETER GetAll 
        Retrieve all dnsaction64 object(s).
    .PARAMETER Count
        If specified, the count of the dnsaction64 object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaction64
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsaction64 -GetAll 
        Get all dnsaction64 data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsaction64 -Count 
        Get the number of dnsaction64 objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaction64 -name <string>
        Get dnsaction64 object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaction64 -Filter @{ 'name'='<value>' }
        Get dnsaction64 data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsaction64
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaction64/
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
        [string]$Actionname,

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
        Write-Verbose "Invoke-NSGetDnsaction64: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsaction64 objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaction64 objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaction64 objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaction64 configuration for property 'actionname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Resource $actionname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsaction64 configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsaction64: Ended"
    }
}

function Invoke-NSAddDnsaddrec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER Ipaddress 
        One or more IPv4 addresses to assign to the domain name. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsaddrec item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsaddrec -hostname <string> -ipaddress <string>
        An example how to add dnsaddrec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsaddrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaddrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Hostname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipaddress,

        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsaddrec: Starting"
    }
    process {
        try {
            $payload = @{ hostname = $hostname
                ipaddress          = $ipaddress
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsaddrec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsaddrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsaddrec -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnsaddrec: Finished"
    }
}

function Invoke-NSDeleteDnsaddrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached address records need to be removed. 
    .PARAMETER Ipaddress 
        One or more IPv4 addresses to assign to the domain name.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsaddrec -Hostname <string>
        An example how to delete dnsaddrec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsaddrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaddrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Hostname,

        [string]$Ecssubnet,

        [string]$Ipaddress 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsaddrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSBoundParameters.ContainsKey('Ipaddress') ) { $arguments.Add('ipaddress', $Ipaddress) }
            if ( $PSCmdlet.ShouldProcess("$hostname", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsaddrec -NitroPath nitro/v1/config -Resource $hostname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsaddrec: Finished"
    }
}

function Invoke-NSGetDnsaddrec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER GetAll 
        Retrieve all dnsaddrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsaddrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaddrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsaddrec -GetAll 
        Get all dnsaddrec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsaddrec -Count 
        Get the number of dnsaddrec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaddrec -name <string>
        Get dnsaddrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsaddrec -Filter @{ 'name'='<value>' }
        Get dnsaddrec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsaddrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsaddrec/
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
        [string]$Hostname,

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
        Write-Verbose "Invoke-NSGetDnsaddrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsaddrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaddrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaddrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaddrec configuration for property 'hostname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Resource $hostname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsaddrec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsaddrec: Ended"
    }
}

function Invoke-NSAddDnscaarec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for CAA record resource.
    .PARAMETER Domain 
        Domain name of the CAA record. 
    .PARAMETER Valuestring 
        Value associated with the chosen property tag in the CAA resource record. Enclose the string in single or double quotation marks. 
    .PARAMETER Tag 
        String that represents the identifier of the property represented by the CAA record. The RFC currently defines three available tags - issue, issuwild and iodef. 
    .PARAMETER Flag 
        Flag associated with the CAA record. 
         
        Possible values = NONE, CRITICAL 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnscaarec item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnscaarec -domain <string> -valuestring <string>
        An example how to add dnscaarec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnscaarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnscaarec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Domain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Valuestring,

        [ValidateLength(1, 255)]
        [string]$Tag = '"issue"',

        [ValidateSet('NONE', 'CRITICAL')]
        [string]$Flag = '5',

        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnscaarec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                valuestring      = $valuestring
            }
            if ( $PSBoundParameters.ContainsKey('tag') ) { $payload.Add('tag', $tag) }
            if ( $PSBoundParameters.ContainsKey('flag') ) { $payload.Add('flag', $flag) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnscaarec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnscaarec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnscaarec -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnscaarec: Finished"
    }
}

function Invoke-NSDeleteDnscaarec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for CAA record resource.
    .PARAMETER Domain 
        Domain name of the CAA record. 
    .PARAMETER Valuestring 
        Value associated with the chosen property tag in the CAA resource record. Enclose the string in single or double quotation marks. 
    .PARAMETER Recordid 
        Unique, internally generated record ID. View the details of the CAA record to obtain its record ID. Records can be removedby either specifying the domain name and record id OR by specifying domain name and all other CAA record attributes as was supplied during the add command. 
         
        Maximum value = 65535 
    .PARAMETER Tag 
        String that represents the identifier of the property represented by the CAA record. The RFC currently defines three available tags - issue, issuwild and iodef. 
    .PARAMETER Flag 
        Flag associated with the CAA record. 
         
        Possible values = NONE, CRITICAL 
    .PARAMETER Ecssubnet 
        Subnet for which the cached CAA record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnscaarec -Domain <string>
        An example how to delete dnscaarec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnscaarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnscaarec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string]$Valuestring,

        [double]$Recordid,

        [string]$Tag,

        [string]$Flag,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnscaarec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Valuestring') ) { $arguments.Add('valuestring', $Valuestring) }
            if ( $PSBoundParameters.ContainsKey('Recordid') ) { $arguments.Add('recordid', $Recordid) }
            if ( $PSBoundParameters.ContainsKey('Tag') ) { $arguments.Add('tag', $Tag) }
            if ( $PSBoundParameters.ContainsKey('Flag') ) { $arguments.Add('flag', $Flag) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnscaarec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnscaarec: Finished"
    }
}

function Invoke-NSGetDnscaarec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for CAA record resource.
    .PARAMETER Domain 
        Domain name of the CAA record. 
    .PARAMETER GetAll 
        Retrieve all dnscaarec object(s).
    .PARAMETER Count
        If specified, the count of the dnscaarec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnscaarec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnscaarec -GetAll 
        Get all dnscaarec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnscaarec -Count 
        Get the number of dnscaarec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnscaarec -name <string>
        Get dnscaarec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnscaarec -Filter @{ 'name'='<value>' }
        Get dnscaarec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnscaarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnscaarec/
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
        [string]$Domain,

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
        Write-Verbose "Invoke-NSGetDnscaarec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnscaarec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnscaarec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnscaarec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnscaarec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnscaarec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnscaarec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnscaarec configuration for property 'domain'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnscaarec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnscaarec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnscaarec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnscaarec: Ended"
    }
}

function Invoke-NSAddDnscnamerec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for CNAME record resource.
    .PARAMETER Aliasname 
        Alias for the canonical domain name. 
    .PARAMETER Canonicalname 
        Canonical domain name. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnscnamerec item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnscnamerec -aliasname <string> -canonicalname <string>
        An example how to add dnscnamerec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnscnamerec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnscnamerec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Aliasname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Canonicalname,

        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnscnamerec: Starting"
    }
    process {
        try {
            $payload = @{ aliasname = $aliasname
                canonicalname       = $canonicalname
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnscnamerec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnscnamerec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnscnamerec -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnscnamerec: Finished"
    }
}

function Invoke-NSDeleteDnscnamerec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for CNAME record resource.
    .PARAMETER Aliasname 
        Alias for the canonical domain name. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached CNAME record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnscnamerec -Aliasname <string>
        An example how to delete dnscnamerec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnscnamerec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnscnamerec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Aliasname,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnscnamerec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$aliasname", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnscnamerec -NitroPath nitro/v1/config -Resource $aliasname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnscnamerec: Finished"
    }
}

function Invoke-NSGetDnscnamerec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for CNAME record resource.
    .PARAMETER Aliasname 
        Alias for the canonical domain name. 
    .PARAMETER GetAll 
        Retrieve all dnscnamerec object(s).
    .PARAMETER Count
        If specified, the count of the dnscnamerec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnscnamerec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnscnamerec -GetAll 
        Get all dnscnamerec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnscnamerec -Count 
        Get the number of dnscnamerec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnscnamerec -name <string>
        Get dnscnamerec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnscnamerec -Filter @{ 'name'='<value>' }
        Get dnscnamerec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnscnamerec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnscnamerec/
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
        [string]$Aliasname,

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
        Write-Verbose "Invoke-NSGetDnscnamerec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnscnamerec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnscnamerec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnscnamerec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnscnamerec configuration for property 'aliasname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Resource $aliasname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnscnamerec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnscnamerec: Ended"
    }
}

function Invoke-NSGetDnsglobalBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnsglobal.
    .PARAMETER GetAll 
        Retrieve all dnsglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnsglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsglobalBinding -GetAll 
        Get all dnsglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsglobalBinding -name <string>
        Get dnsglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsglobalBinding -Filter @{ 'name'='<value>' }
        Get dnsglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsglobalBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsglobal_binding/
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
        Write-Verbose "Invoke-NSGetDnsglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnsglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsglobalBinding: Ended"
    }
}

function Invoke-NSAddDnsglobalDnspolicyBinding {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnsglobal.
    .PARAMETER Policyname 
        Name of the dns policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy with which it is bound. Maximum allowed priority should be less than 65535. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Type 
        Type of global bind point for which to show bound policies. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        Type of policy label invocation. 
        Possible values = policylabel 
    .PARAMETER Labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created dnsglobal_dnspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsglobalDnspolicyBinding -policyname <string> -priority <double>
        An example how to add dnsglobal_dnspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsglobalDnspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsglobal_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsglobalDnspolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("dnsglobal_dnspolicy_binding", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnsglobal_dnspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsglobalDnspolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnsglobalDnspolicyBinding: Finished"
    }
}

function Invoke-NSDeleteDnsglobalDnspolicyBinding {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnsglobal.
    .PARAMETER Policyname 
        Name of the dns policy. 
    .PARAMETER Type 
        Type of global bind point for which to show bound policies. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsglobalDnspolicyBinding 
        An example how to delete dnsglobal_dnspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsglobalDnspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsglobal_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsglobalDnspolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("dnsglobal_dnspolicy_binding", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsglobalDnspolicyBinding: Finished"
    }
}

function Invoke-NSGetDnsglobalDnspolicyBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnsglobal.
    .PARAMETER Type 
        Type of global bind point for which to show bound policies. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER GetAll 
        Retrieve all dnsglobal_dnspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnsglobal_dnspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsglobalDnspolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsglobalDnspolicyBinding -GetAll 
        Get all dnsglobal_dnspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsglobalDnspolicyBinding -Count 
        Get the number of dnsglobal_dnspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsglobalDnspolicyBinding -name <string>
        Get dnsglobal_dnspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsglobalDnspolicyBinding -Filter @{ 'name'='<value>' }
        Get dnsglobal_dnspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsglobalDnspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsglobal_dnspolicy_binding/
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
        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$Type,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetDnsglobalDnspolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnsglobal_dnspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsglobal_dnspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsglobal_dnspolicy_binding objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsglobal_dnspolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsglobal_dnspolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsglobalDnspolicyBinding: Ended"
    }
}

function Invoke-NSAddDnskey {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER Publickey 
        File name of the public key. 
    .PARAMETER Privatekey 
        File name of the private key. 
    .PARAMETER Expires 
        Time period for which to consider the key valid, after the key is used to sign a zone. 
         
         
        Maximum value = 32767 
    .PARAMETER Units1 
        Units for the expiry period. 
         
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Notificationperiod 
        Time at which to generate notification of key expiration, specified as number of days, hours, or minutes before expiry. Must be less than the expiry period. The notification is an SNMP trap sent to an SNMP manager. To enable the appliance to send the trap, enable the DNSKEY-EXPIRY SNMP alarm. 
         
         
        Maximum value = 32767 
    .PARAMETER Units2 
        Units for the notification period. 
         
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the DNSKEY resource record created in the zone. TTL is the time for which the record must be cached by the DNS proxies. If the TTL is not specified, either the DNS zone's minimum TTL or the default value of 3600 is used. 
         
         
        Maximum value = 2147483647 
    .PARAMETER Password 
        Passphrase for reading the encrypted public/private DNS keys. 
    .PARAMETER PassThru 
        Return details about the created dnskey item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnskey -keyname <string> -publickey <string> -privatekey <string>
        An example how to add dnskey config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnskey
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Keyname,

        [Parameter(Mandatory)]
        [string]$Publickey,

        [Parameter(Mandatory)]
        [string]$Privatekey,

        [double]$Expires = '120',

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$Units1 = 'DAYS',

        [double]$Notificationperiod = '7',

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$Units2 = 'DAYS',

        [double]$Ttl = '3600',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnskey: Starting"
    }
    process {
        try {
            $payload = @{ keyname = $keyname
                publickey         = $publickey
                privatekey        = $privatekey
            }
            if ( $PSBoundParameters.ContainsKey('expires') ) { $payload.Add('expires', $expires) }
            if ( $PSBoundParameters.ContainsKey('units1') ) { $payload.Add('units1', $units1) }
            if ( $PSBoundParameters.ContainsKey('notificationperiod') ) { $payload.Add('notificationperiod', $notificationperiod) }
            if ( $PSBoundParameters.ContainsKey('units2') ) { $payload.Add('units2', $units2) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess("dnskey", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnskey -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnskey -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnskey: Finished"
    }
}

function Invoke-NSCreateDnskey {
    <#
    .SYNOPSIS
        Create Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Zonename 
        Name of the zone for which to create a key. 
    .PARAMETER Keytype 
        Type of key to create. 
         
        Possible values = KSK, KeySigningKey, ZSK, ZoneSigningKey 
    .PARAMETER Algorithm 
        Algorithm to generate for zone signing. 
         
        Possible values = RSASHA1, RSASHA256, RSASHA512 
    .PARAMETER Keysize 
        Size of the key, in bits. 
         
         
        Maximum value = 4096 
    .PARAMETER Filenameprefix 
        Common prefix for the names of the generated public and private key files and the Delegation Signer (DS) resource record. During key generation, the .key, .private, and .ds suffixes are appended automatically to the file name prefix to produce the names of the public key, the private key, and the DS record, respectively. 
    .PARAMETER Password 
        Passphrase for reading the encrypted public/private DNS keys.
    .EXAMPLE
        PS C:\>Invoke-NSCreateDnskey -zonename <string> -keytype <string> -algorithm <string> -keysize <double> -filenameprefix <string>
        An example how to create dnskey config Object(s).
    .NOTES
        File Name : Invoke-NSCreateDnskey
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Zonename,

        [Parameter(Mandatory)]
        [ValidateSet('KSK', 'KeySigningKey', 'ZSK', 'ZoneSigningKey')]
        [string]$Keytype,

        [Parameter(Mandatory)]
        [ValidateSet('RSASHA1', 'RSASHA256', 'RSASHA512')]
        [string]$Algorithm,

        [Parameter(Mandatory)]
        [double]$Keysize,

        [Parameter(Mandatory)]
        [string]$Filenameprefix,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password 

    )
    begin {
        Write-Verbose "Invoke-NSCreateDnskey: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename
                keytype            = $keytype
                algorithm          = $algorithm
                keysize            = $keysize
                filenameprefix     = $filenameprefix
            }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess($Name, "Create Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnskey -Action create -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSCreateDnskey: Finished"
    }
}

function Invoke-NSUpdateDnskey {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER Expires 
        Time period for which to consider the key valid, after the key is used to sign a zone. 
         
         
        Maximum value = 32767 
    .PARAMETER Units1 
        Units for the expiry period. 
         
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Notificationperiod 
        Time at which to generate notification of key expiration, specified as number of days, hours, or minutes before expiry. Must be less than the expiry period. The notification is an SNMP trap sent to an SNMP manager. To enable the appliance to send the trap, enable the DNSKEY-EXPIRY SNMP alarm. 
         
         
        Maximum value = 32767 
    .PARAMETER Units2 
        Units for the notification period. 
         
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the DNSKEY resource record created in the zone. TTL is the time for which the record must be cached by the DNS proxies. If the TTL is not specified, either the DNS zone's minimum TTL or the default value of 3600 is used. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnskey item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnskey -keyname <string>
        An example how to update dnskey config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnskey
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Keyname,

        [double]$Expires,

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$Units1,

        [double]$Notificationperiod,

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$Units2,

        [double]$Ttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnskey: Starting"
    }
    process {
        try {
            $payload = @{ keyname = $keyname }
            if ( $PSBoundParameters.ContainsKey('expires') ) { $payload.Add('expires', $expires) }
            if ( $PSBoundParameters.ContainsKey('units1') ) { $payload.Add('units1', $units1) }
            if ( $PSBoundParameters.ContainsKey('notificationperiod') ) { $payload.Add('notificationperiod', $notificationperiod) }
            if ( $PSBoundParameters.ContainsKey('units2') ) { $payload.Add('units2', $units2) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnskey", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnskey -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnskey -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateDnskey: Finished"
    }
}

function Invoke-NSUnsetDnskey {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER Expires 
        Time period for which to consider the key valid, after the key is used to sign a zone. 
         
         
        Maximum value = 32767 
    .PARAMETER Units1 
        Units for the expiry period. 
         
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Notificationperiod 
        Time at which to generate notification of key expiration, specified as number of days, hours, or minutes before expiry. Must be less than the expiry period. The notification is an SNMP trap sent to an SNMP manager. To enable the appliance to send the trap, enable the DNSKEY-EXPIRY SNMP alarm. 
         
         
        Maximum value = 32767 
    .PARAMETER Units2 
        Units for the notification period. 
         
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the DNSKEY resource record created in the zone. TTL is the time for which the record must be cached by the DNS proxies. If the TTL is not specified, either the DNS zone's minimum TTL or the default value of 3600 is used. 
         
         
        Maximum value = 2147483647
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnskey -keyname <string>
        An example how to unset dnskey config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnskey
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnskey
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Keyname,

        [Boolean]$expires,

        [Boolean]$units1,

        [Boolean]$notificationperiod,

        [Boolean]$units2,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnskey: Starting"
    }
    process {
        try {
            $payload = @{ keyname = $keyname }
            if ( $PSBoundParameters.ContainsKey('expires') ) { $payload.Add('expires', $expires) }
            if ( $PSBoundParameters.ContainsKey('units1') ) { $payload.Add('units1', $units1) }
            if ( $PSBoundParameters.ContainsKey('notificationperiod') ) { $payload.Add('notificationperiod', $notificationperiod) }
            if ( $PSBoundParameters.ContainsKey('units2') ) { $payload.Add('units2', $units2) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("$keyname", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnskey -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnskey: Finished"
    }
}

function Invoke-NSDeleteDnskey {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnskey -Keyname <string>
        An example how to delete dnskey config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnskey
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Keyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnskey: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$keyname", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnskey -NitroPath nitro/v1/config -Resource $keyname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnskey: Finished"
    }
}

function Invoke-NSImportDnskey {
    <#
    .SYNOPSIS
        Import Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER Src 
        URL (protocol, host, path, and file name) from where the DNS key file will be imported. NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. This is a mandatory argument.
    .EXAMPLE
        PS C:\>Invoke-NSImportDnskey -keyname <string> -src <string>
        An example how to import dnskey config Object(s).
    .NOTES
        File Name : Invoke-NSImportDnskey
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Keyname,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Src 

    )
    begin {
        Write-Verbose "Invoke-NSImportDnskey: Starting"
    }
    process {
        try {
            $payload = @{ keyname = $keyname
                src               = $src
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Import Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnskey -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSImportDnskey: Finished"
    }
}

function Invoke-NSGetDnskey {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER GetAll 
        Retrieve all dnskey object(s).
    .PARAMETER Count
        If specified, the count of the dnskey object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnskey
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnskey -GetAll 
        Get all dnskey data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnskey -Count 
        Get the number of dnskey objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnskey -name <string>
        Get dnskey object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnskey -Filter @{ 'name'='<value>' }
        Get dnskey data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnskey
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnskey/
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
        [string]$Keyname,

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
        Write-Verbose "Invoke-NSGetDnskey: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnskey objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnskey objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnskey objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnskey configuration for property 'keyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Resource $keyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnskey configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnskey: Ended"
    }
}

function Invoke-NSAddDnsmxrec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for MX record resource.
    .PARAMETER Domain 
        Domain name for which to add the MX record. 
    .PARAMETER Mx 
        Host name of the mail exchange server. 
    .PARAMETER Pref 
        Priority number to assign to the mail exchange server. A domain name can have multiple mail servers, with a priority number assigned to each server. The lower the priority number, the higher the mail server's priority. When other mail servers have to deliver mail to the specified domain, they begin with the mail server with the lowest priority number, and use other configured mail servers, in priority order, as backups. 
         
        Maximum value = 65535 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsmxrec item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsmxrec -domain <string> -mx <string> -pref <double>
        An example how to add dnsmxrec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsmxrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsmxrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Domain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Mx,

        [Parameter(Mandatory)]
        [double]$Pref,

        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsmxrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                mx               = $mx
                pref             = $pref
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsmxrec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsmxrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsmxrec -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnsmxrec: Finished"
    }
}

function Invoke-NSDeleteDnsmxrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for MX record resource.
    .PARAMETER Domain 
        Domain name for which to add the MX record. 
    .PARAMETER Mx 
        Host name of the mail exchange server. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached MX record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsmxrec -Domain <string>
        An example how to delete dnsmxrec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsmxrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsmxrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string]$Mx,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsmxrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Mx') ) { $arguments.Add('mx', $Mx) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsmxrec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsmxrec: Finished"
    }
}

function Invoke-NSUpdateDnsmxrec {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for MX record resource.
    .PARAMETER Domain 
        Domain name for which to add the MX record. 
    .PARAMETER Mx 
        Host name of the mail exchange server. 
    .PARAMETER Pref 
        Priority number to assign to the mail exchange server. A domain name can have multiple mail servers, with a priority number assigned to each server. The lower the priority number, the higher the mail server's priority. When other mail servers have to deliver mail to the specified domain, they begin with the mail server with the lowest priority number, and use other configured mail servers, in priority order, as backups. 
         
        Maximum value = 65535 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsmxrec item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnsmxrec -domain <string> -mx <string>
        An example how to update dnsmxrec config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnsmxrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsmxrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Domain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Mx,

        [double]$Pref,

        [double]$Ttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnsmxrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                mx               = $mx
            }
            if ( $PSBoundParameters.ContainsKey('pref') ) { $payload.Add('pref', $pref) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsmxrec", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnsmxrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsmxrec -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateDnsmxrec: Finished"
    }
}

function Invoke-NSUnsetDnsmxrec {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for MX record resource.
    .PARAMETER Domain 
        Domain name for which to add the MX record. 
    .PARAMETER Mx 
        Host name of the mail exchange server. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnsmxrec -domain <string> -mx <string>
        An example how to unset dnsmxrec config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnsmxrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsmxrec
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Domain,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Mx,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnsmxrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                mx               = $mx
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("$domain mx", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnsmxrec -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnsmxrec: Finished"
    }
}

function Invoke-NSGetDnsmxrec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for MX record resource.
    .PARAMETER Domain 
        Domain name for which to add the MX record. 
    .PARAMETER GetAll 
        Retrieve all dnsmxrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsmxrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsmxrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsmxrec -GetAll 
        Get all dnsmxrec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsmxrec -Count 
        Get the number of dnsmxrec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsmxrec -name <string>
        Get dnsmxrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsmxrec -Filter @{ 'name'='<value>' }
        Get dnsmxrec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsmxrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsmxrec/
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
        [string]$Domain,

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
        Write-Verbose "Invoke-NSGetDnsmxrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsmxrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsmxrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsmxrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsmxrec configuration for property 'domain'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsmxrec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsmxrec: Ended"
    }
}

function Invoke-NSAddDnsnameserver {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC. 
    .PARAMETER Local 
        Mark the IP address as one that belongs to a local recursive DNS server on the Citrix ADC. The appliance recursively resolves queries received on an IP address that is marked as being local. For recursive resolution to work, the global DNS parameter, Recursion, must also be set. 
         
        If no name server is marked as being local, the appliance functions as a stub resolver and load balances the name servers. 
    .PARAMETER State 
        Administrative state of the name server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
         
        Possible values = UDP, TCP, UDP_TCP 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the name server.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsnameserver 
        An example how to add dnsnameserver config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsnameserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsvservername,

        [boolean]$Local,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$Type = 'UDP',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsnameserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('local') ) { $payload.Add('local', $local) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSCmdlet.ShouldProcess("dnsnameserver", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsnameserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddDnsnameserver: Finished"
    }
}

function Invoke-NSUpdateDnsnameserver {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the name server. 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
         
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnsnameserver -ip <string>
        An example how to update dnsnameserver config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnsnameserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsprofilename,

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnsnameserver: Starting"
    }
    process {
        try {
            $payload = @{ ip = $ip }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess("dnsnameserver", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnsnameserver -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateDnsnameserver: Finished"
    }
}

function Invoke-NSUnsetDnsnameserver {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the name server. 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
         
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnsnameserver -ip <string>
        An example how to unset dnsnameserver config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnsnameserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnameserver
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Ip,

        [Boolean]$dnsprofilename,

        [Boolean]$type 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnsnameserver: Starting"
    }
    process {
        try {
            $payload = @{ ip = $ip }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess("$ip", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnsnameserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnsnameserver: Finished"
    }
}

function Invoke-NSDeleteDnsnameserver {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC. 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
         
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsnameserver -Ip <string>
        An example how to delete dnsnameserver config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsnameserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Ip,

        [string]$Dnsvservername,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsnameserver: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Dnsvservername') ) { $arguments.Add('dnsvservername', $Dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$ip", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsnameserver -NitroPath nitro/v1/config -Resource $ip -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsnameserver: Finished"
    }
}

function Invoke-NSEnableDnsnameserver {
    <#
    .SYNOPSIS
        Enable Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC. 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
         
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        PS C:\>Invoke-NSEnableDnsnameserver 
        An example how to enable dnsnameserver config Object(s).
    .NOTES
        File Name : Invoke-NSEnableDnsnameserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsvservername,

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$Type 

    )
    begin {
        Write-Verbose "Invoke-NSEnableDnsnameserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess($Name, "Enable Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsnameserver -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableDnsnameserver: Finished"
    }
}

function Invoke-NSDisableDnsnameserver {
    <#
    .SYNOPSIS
        Disable Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC. 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
         
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        PS C:\>Invoke-NSDisableDnsnameserver 
        An example how to disable dnsnameserver config Object(s).
    .NOTES
        File Name : Invoke-NSDisableDnsnameserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsvservername,

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$Type 

    )
    begin {
        Write-Verbose "Invoke-NSDisableDnsnameserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsnameserver -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableDnsnameserver: Finished"
    }
}

function Invoke-NSGetDnsnameserver {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER GetAll 
        Retrieve all dnsnameserver object(s).
    .PARAMETER Count
        If specified, the count of the dnsnameserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnameserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsnameserver -GetAll 
        Get all dnsnameserver data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsnameserver -Count 
        Get the number of dnsnameserver objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnameserver -name <string>
        Get dnsnameserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnameserver -Filter @{ 'name'='<value>' }
        Get dnsnameserver data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsnameserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnameserver/
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
        Write-Verbose "Invoke-NSGetDnsnameserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsnameserver objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnameserver objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnameserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnameserver configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsnameserver configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsnameserver: Ended"
    }
}

function Invoke-NSAddDnsnaptrrec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for NAPTR record resource.
    .PARAMETER Domain 
        Name of the domain for the NAPTR record. 
    .PARAMETER Order 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
         
        Maximum value = 65535 
    .PARAMETER Preference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
         
        Maximum value = 65535 
    .PARAMETER Flags 
        flags for this NAPTR. 
    .PARAMETER Services 
        Service Parameters applicable to this delegation path. 
    .PARAMETER Regexp 
        The regular expression, that specifies the substitution expression for this NAPTR. 
    .PARAMETER Replacement 
        The replacement domain name for this NAPTR. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsnaptrrec item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsnaptrrec -domain <string> -order <double> -preference <double>
        An example how to add dnsnaptrrec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsnaptrrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnaptrrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Domain,

        [Parameter(Mandatory)]
        [double]$Order,

        [Parameter(Mandatory)]
        [double]$Preference,

        [string]$Flags,

        [string]$Services,

        [string]$Regexp,

        [string]$Replacement,

        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsnaptrrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                order            = $order
                preference       = $preference
            }
            if ( $PSBoundParameters.ContainsKey('flags') ) { $payload.Add('flags', $flags) }
            if ( $PSBoundParameters.ContainsKey('services') ) { $payload.Add('services', $services) }
            if ( $PSBoundParameters.ContainsKey('regexp') ) { $payload.Add('regexp', $regexp) }
            if ( $PSBoundParameters.ContainsKey('replacement') ) { $payload.Add('replacement', $replacement) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsnaptrrec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsnaptrrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsnaptrrec -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnsnaptrrec: Finished"
    }
}

function Invoke-NSDeleteDnsnaptrrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for NAPTR record resource.
    .PARAMETER Domain 
        Name of the domain for the NAPTR record. 
    .PARAMETER Order 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
         
        Maximum value = 65535 
    .PARAMETER Recordid 
        Unique, internally generated record ID. View the details of the naptr record to obtain its record ID. Records can be removed by either specifying the domain name and record id OR by specifying 
        domain name and all other naptr record attributes as was supplied during the add command. 
         
        Maximum value = 65535 
    .PARAMETER Ecssubnet 
        Subnet for which the cached NAPTR record need to be removed. 
    .PARAMETER Preference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
         
        Maximum value = 65535 
    .PARAMETER Flags 
        flags for this NAPTR. 
    .PARAMETER Services 
        Service Parameters applicable to this delegation path. 
    .PARAMETER Regexp 
        The regular expression, that specifies the substitution expression for this NAPTR. 
    .PARAMETER Replacement 
        The replacement domain name for this NAPTR.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsnaptrrec -Domain <string>
        An example how to delete dnsnaptrrec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsnaptrrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnaptrrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [double]$Order,

        [double]$Recordid,

        [string]$Ecssubnet,

        [double]$Preference,

        [string]$Flags,

        [string]$Services,

        [string]$Regexp,

        [string]$Replacement 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsnaptrrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Order') ) { $arguments.Add('order', $Order) }
            if ( $PSBoundParameters.ContainsKey('Recordid') ) { $arguments.Add('recordid', $Recordid) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSBoundParameters.ContainsKey('Preference') ) { $arguments.Add('preference', $Preference) }
            if ( $PSBoundParameters.ContainsKey('Flags') ) { $arguments.Add('flags', $Flags) }
            if ( $PSBoundParameters.ContainsKey('Services') ) { $arguments.Add('services', $Services) }
            if ( $PSBoundParameters.ContainsKey('Regexp') ) { $arguments.Add('regexp', $Regexp) }
            if ( $PSBoundParameters.ContainsKey('Replacement') ) { $arguments.Add('replacement', $Replacement) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsnaptrrec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsnaptrrec: Finished"
    }
}

function Invoke-NSGetDnsnaptrrec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for NAPTR record resource.
    .PARAMETER Domain 
        Name of the domain for the NAPTR record. 
    .PARAMETER GetAll 
        Retrieve all dnsnaptrrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsnaptrrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnaptrrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsnaptrrec -GetAll 
        Get all dnsnaptrrec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsnaptrrec -Count 
        Get the number of dnsnaptrrec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnaptrrec -name <string>
        Get dnsnaptrrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnaptrrec -Filter @{ 'name'='<value>' }
        Get dnsnaptrrec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsnaptrrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnaptrrec/
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
        [string]$Domain,

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
        Write-Verbose "Invoke-NSGetDnsnaptrrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsnaptrrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnaptrrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnaptrrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnaptrrec configuration for property 'domain'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsnaptrrec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsnaptrrec: Ended"
    }
}

function Invoke-NSGetDnsnsecrec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Hostname 
        Name of the domain. 
    .PARAMETER GetAll 
        Retrieve all dnsnsecrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsnsecrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnsecrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsnsecrec -GetAll 
        Get all dnsnsecrec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsnsecrec -Count 
        Get the number of dnsnsecrec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnsecrec -name <string>
        Get dnsnsecrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnsecrec -Filter @{ 'name'='<value>' }
        Get dnsnsecrec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsnsecrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnsecrec/
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
        [string]$Hostname,

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
        Write-Verbose "Invoke-NSGetDnsnsecrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsnsecrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnsecrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnsecrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnsecrec configuration for property 'hostname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Resource $hostname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsnsecrec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsnsecrec: Ended"
    }
}

function Invoke-NSAddDnsnsrec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for name server record resource.
    .PARAMETER Domain 
        Domain name. 
    .PARAMETER Nameserver 
        Host name of the name server to add to the domain. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsnsrec item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsnsrec -domain <string> -nameserver <string>
        An example how to add dnsnsrec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsnsrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnsrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Domain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Nameserver,

        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsnsrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                nameserver       = $nameserver
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsnsrec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsnsrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsnsrec -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnsnsrec: Finished"
    }
}

function Invoke-NSDeleteDnsnsrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for name server record resource.
    .PARAMETER Domain 
        Domain name. 
    .PARAMETER Nameserver 
        Host name of the name server to add to the domain. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached name server record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsnsrec -Domain <string>
        An example how to delete dnsnsrec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsnsrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnsrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string]$Nameserver,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsnsrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Nameserver') ) { $arguments.Add('nameserver', $Nameserver) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsnsrec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsnsrec: Finished"
    }
}

function Invoke-NSGetDnsnsrec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for name server record resource.
    .PARAMETER Domain 
        Domain name. 
    .PARAMETER GetAll 
        Retrieve all dnsnsrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsnsrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnsrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsnsrec -GetAll 
        Get all dnsnsrec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsnsrec -Count 
        Get the number of dnsnsrec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnsrec -name <string>
        Get dnsnsrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsnsrec -Filter @{ 'name'='<value>' }
        Get dnsnsrec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsnsrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsnsrec/
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
        [string]$Domain,

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
        Write-Verbose "Invoke-NSGetDnsnsrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsnsrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnsrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnsrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnsrec configuration for property 'domain'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsnsrec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsnsrec: Ended"
    }
}

function Invoke-NSUpdateDnsparameter {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS parameter resource.
    .PARAMETER Retries 
        Maximum number of retry attempts when no response is received for a query sent to a name server. Applies to end resolver and forwarder configurations. 
         
         
        Maximum value = 5 
    .PARAMETER Minttl 
        Minimum permissible time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is lower than the value configured for minTTL, the TTL of the record is set to the value of minTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
         
        Maximum value = 604800 
    .PARAMETER Maxttl 
        Maximum time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxTTL, the TTL of the record is set to the value of maxTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
         
         
        Maximum value = 604800 
    .PARAMETER Cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again. 
         
        Possible values = YES, NO 
    .PARAMETER Namelookuppriority 
        Type of lookup (DNS or WINS) to attempt first. If the first-priority lookup fails, the second-priority lookup is attempted. Used only by the SSL VPN feature. 
         
        Possible values = WINS, DNS 
    .PARAMETER Recursion 
        Function as an end resolver and recursively resolve queries for domains that are not hosted on the Citrix ADC. Also resolve queries recursively when the external name servers configured on the appliance (for a forwarder configuration) are unavailable. When external name servers are unavailable, the appliance queries a root server and resolves the request recursively, as it does for an end resolver configuration. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Resolutionorder 
        Type of DNS queries (A, AAAA, or both) to generate during the routine functioning of certain Citrix ADC features, such as SSL VPN, cache redirection, and the integrated cache. The queries are sent to the external name servers that are configured for the forwarder function. If you specify both query types, you can also specify the order. Available settings function as follows: 
        * OnlyAQuery. Send queries for IPv4 address records (A records) only. 
        * OnlyAAAAQuery. Send queries for IPv6 address records (AAAA records) instead of queries for IPv4 address records (A records). 
        * AThenAAAAQuery. Send a query for an A record, and then send a query for an AAAA record if the query for the A record results in a NODATA response from the name server. 
        * AAAAThenAQuery. Send a query for an AAAA record, and then send a query for an A record if the query for the AAAA record results in a NODATA response from the name server. 
         
        Possible values = OnlyAQuery, OnlyAAAAQuery, AThenAAAAQuery, AAAAThenAQuery 
    .PARAMETER Dnssec 
        Enable or disable the Domain Name System Security Extensions (DNSSEC) feature on the appliance. Note: Even when the DNSSEC feature is enabled, forwarder configurations (used by internal Citrix ADC features such as SSL VPN and Cache Redirection for name resolution) do not support the DNSSEC OK (DO) bit in the EDNS0 OPT header. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxpipeline 
        Maximum number of concurrent DNS requests to allow on a single client connection, which is identified by the &lt;clientip:port&gt;-&lt;vserver ip:port&gt; tuple. A value of 0 (zero) applies no limit to the number of concurrent DNS requests allowed on a single client connection. 
    .PARAMETER Dnsrootreferral 
        Send a root referral if a client queries a domain name that is unrelated to the domains configured/cached on the Citrix ADC. If the setting is disabled, the appliance sends a blank response instead of a root referral. Applicable to domains for which the appliance is authoritative. Disable the parameter when the appliance is under attack from a client that is sending a flood of queries for unrelated domains. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dns64timeout 
        While doing DNS64 resolution, this parameter specifies the time to wait before sending an A query if no response is received from backend DNS server for AAAA query. 
         
        Maximum value = 10000 
    .PARAMETER Ecsmaxsubnets 
        Maximum number of subnets that can be cached corresponding to a single domain. Subnet caching will occur for responses with EDNS Client Subnet (ECS) option. Caching of such responses can be disabled using DNS profile settings. A value of zero indicates that the number of subnets cached is limited only by existing memory constraints. The default value is zero. 
         
         
        Maximum value = 1280 
    .PARAMETER Maxnegcachettl 
        Maximum time to live (TTL) for all negative records ( NXDONAIN and NODATA ) cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxnegcacheTTL, the TTL of the record is set to the value of maxnegcacheTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
         
         
        Maximum value = 604800 
    .PARAMETER Cachehitbypass 
        This parameter is applicable only in proxy mode and if this parameter is enabled we will forward all the client requests to the backend DNS server and the response served will be cached on Citrix ADC. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxcachesize 
        Maximum memory, in megabytes, that can be used for dns caching per Packet Engine. 
    .PARAMETER Maxnegativecachesize 
        Maximum memory, in megabytes, that can be used for caching of negative DNS responses per packet engine. 
    .PARAMETER Cachenoexpire 
        If this flag is set to YES, the existing entries in cache do not age out. On reaching the max limit the cache records are frozen. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Splitpktqueryprocessing 
        Processing requests split across multiple packets. 
         
        Possible values = ALLOW, DROP 
    .PARAMETER Cacheecszeroprefix 
        Cache ECS responses with a Scope Prefix length of zero. Such a cached response will be used for all queries with this domain name and any subnet. When disabled, ECS responses with Scope Prefix length of zero will be cached, but not tied to any subnet. This option has no effect if caching of ECS responses is disabled in the corresponding DNS profile. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxudppacketsize 
        Maximum UDP packet size that can be handled by Citrix ADC. This is the value advertised by Citrix ADC when responding as an authoritative server and it is also used when Citrix ADC queries other name servers as a forwarder. When acting as a proxy, requests from clients are limited by this parameter - if a request contains a size greater than this value in the OPT record, it will be replaced. 
         
         
        Maximum value = 16384 
    .PARAMETER Nxdomainratelimitthreshold 
        Rate limit threshold for Non-Existant domain (NXDOMAIN) responses generated from Citrix ADC. Once the threshold is breached, DNS queries leading to NXDOMAIN response will be dropped. This threshold will not be applied for NXDOMAIN responses got from the backend. The threshold will be applied per packet engine and per second.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnsparameter 
        An example how to update dnsparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnsparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [double]$Retries,

        [double]$Minttl,

        [double]$Maxttl,

        [ValidateSet('YES', 'NO')]
        [string]$Cacherecords,

        [ValidateSet('WINS', 'DNS')]
        [string]$Namelookuppriority,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Recursion,

        [ValidateSet('OnlyAQuery', 'OnlyAAAAQuery', 'AThenAAAAQuery', 'AAAAThenAQuery')]
        [string]$Resolutionorder,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnssec,

        [double]$Maxpipeline,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsrootreferral,

        [double]$Dns64timeout,

        [double]$Ecsmaxsubnets,

        [double]$Maxnegcachettl,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cachehitbypass,

        [double]$Maxcachesize,

        [double]$Maxnegativecachesize,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cachenoexpire,

        [ValidateSet('ALLOW', 'DROP')]
        [string]$Splitpktqueryprocessing,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacheecszeroprefix,

        [double]$Maxudppacketsize,

        [double]$Nxdomainratelimitthreshold 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnsparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('retries') ) { $payload.Add('retries', $retries) }
            if ( $PSBoundParameters.ContainsKey('minttl') ) { $payload.Add('minttl', $minttl) }
            if ( $PSBoundParameters.ContainsKey('maxttl') ) { $payload.Add('maxttl', $maxttl) }
            if ( $PSBoundParameters.ContainsKey('cacherecords') ) { $payload.Add('cacherecords', $cacherecords) }
            if ( $PSBoundParameters.ContainsKey('namelookuppriority') ) { $payload.Add('namelookuppriority', $namelookuppriority) }
            if ( $PSBoundParameters.ContainsKey('recursion') ) { $payload.Add('recursion', $recursion) }
            if ( $PSBoundParameters.ContainsKey('resolutionorder') ) { $payload.Add('resolutionorder', $resolutionorder) }
            if ( $PSBoundParameters.ContainsKey('dnssec') ) { $payload.Add('dnssec', $dnssec) }
            if ( $PSBoundParameters.ContainsKey('maxpipeline') ) { $payload.Add('maxpipeline', $maxpipeline) }
            if ( $PSBoundParameters.ContainsKey('dnsrootreferral') ) { $payload.Add('dnsrootreferral', $dnsrootreferral) }
            if ( $PSBoundParameters.ContainsKey('dns64timeout') ) { $payload.Add('dns64timeout', $dns64timeout) }
            if ( $PSBoundParameters.ContainsKey('ecsmaxsubnets') ) { $payload.Add('ecsmaxsubnets', $ecsmaxsubnets) }
            if ( $PSBoundParameters.ContainsKey('maxnegcachettl') ) { $payload.Add('maxnegcachettl', $maxnegcachettl) }
            if ( $PSBoundParameters.ContainsKey('cachehitbypass') ) { $payload.Add('cachehitbypass', $cachehitbypass) }
            if ( $PSBoundParameters.ContainsKey('maxcachesize') ) { $payload.Add('maxcachesize', $maxcachesize) }
            if ( $PSBoundParameters.ContainsKey('maxnegativecachesize') ) { $payload.Add('maxnegativecachesize', $maxnegativecachesize) }
            if ( $PSBoundParameters.ContainsKey('cachenoexpire') ) { $payload.Add('cachenoexpire', $cachenoexpire) }
            if ( $PSBoundParameters.ContainsKey('splitpktqueryprocessing') ) { $payload.Add('splitpktqueryprocessing', $splitpktqueryprocessing) }
            if ( $PSBoundParameters.ContainsKey('cacheecszeroprefix') ) { $payload.Add('cacheecszeroprefix', $cacheecszeroprefix) }
            if ( $PSBoundParameters.ContainsKey('maxudppacketsize') ) { $payload.Add('maxudppacketsize', $maxudppacketsize) }
            if ( $PSBoundParameters.ContainsKey('nxdomainratelimitthreshold') ) { $payload.Add('nxdomainratelimitthreshold', $nxdomainratelimitthreshold) }
            if ( $PSCmdlet.ShouldProcess("dnsparameter", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnsparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateDnsparameter: Finished"
    }
}

function Invoke-NSUnsetDnsparameter {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS parameter resource.
    .PARAMETER Retries 
        Maximum number of retry attempts when no response is received for a query sent to a name server. Applies to end resolver and forwarder configurations. 
         
         
        Maximum value = 5 
    .PARAMETER Minttl 
        Minimum permissible time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is lower than the value configured for minTTL, the TTL of the record is set to the value of minTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
         
        Maximum value = 604800 
    .PARAMETER Maxttl 
        Maximum time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxTTL, the TTL of the record is set to the value of maxTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
         
         
        Maximum value = 604800 
    .PARAMETER Cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again. 
         
        Possible values = YES, NO 
    .PARAMETER Namelookuppriority 
        Type of lookup (DNS or WINS) to attempt first. If the first-priority lookup fails, the second-priority lookup is attempted. Used only by the SSL VPN feature. 
         
        Possible values = WINS, DNS 
    .PARAMETER Recursion 
        Function as an end resolver and recursively resolve queries for domains that are not hosted on the Citrix ADC. Also resolve queries recursively when the external name servers configured on the appliance (for a forwarder configuration) are unavailable. When external name servers are unavailable, the appliance queries a root server and resolves the request recursively, as it does for an end resolver configuration. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Resolutionorder 
        Type of DNS queries (A, AAAA, or both) to generate during the routine functioning of certain Citrix ADC features, such as SSL VPN, cache redirection, and the integrated cache. The queries are sent to the external name servers that are configured for the forwarder function. If you specify both query types, you can also specify the order. Available settings function as follows: 
        * OnlyAQuery. Send queries for IPv4 address records (A records) only. 
        * OnlyAAAAQuery. Send queries for IPv6 address records (AAAA records) instead of queries for IPv4 address records (A records). 
        * AThenAAAAQuery. Send a query for an A record, and then send a query for an AAAA record if the query for the A record results in a NODATA response from the name server. 
        * AAAAThenAQuery. Send a query for an AAAA record, and then send a query for an A record if the query for the AAAA record results in a NODATA response from the name server. 
         
        Possible values = OnlyAQuery, OnlyAAAAQuery, AThenAAAAQuery, AAAAThenAQuery 
    .PARAMETER Dnssec 
        Enable or disable the Domain Name System Security Extensions (DNSSEC) feature on the appliance. Note: Even when the DNSSEC feature is enabled, forwarder configurations (used by internal Citrix ADC features such as SSL VPN and Cache Redirection for name resolution) do not support the DNSSEC OK (DO) bit in the EDNS0 OPT header. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxpipeline 
        Maximum number of concurrent DNS requests to allow on a single client connection, which is identified by the &lt;clientip:port&gt;-&lt;vserver ip:port&gt; tuple. A value of 0 (zero) applies no limit to the number of concurrent DNS requests allowed on a single client connection. 
    .PARAMETER Dnsrootreferral 
        Send a root referral if a client queries a domain name that is unrelated to the domains configured/cached on the Citrix ADC. If the setting is disabled, the appliance sends a blank response instead of a root referral. Applicable to domains for which the appliance is authoritative. Disable the parameter when the appliance is under attack from a client that is sending a flood of queries for unrelated domains. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dns64timeout 
        While doing DNS64 resolution, this parameter specifies the time to wait before sending an A query if no response is received from backend DNS server for AAAA query. 
         
        Maximum value = 10000 
    .PARAMETER Ecsmaxsubnets 
        Maximum number of subnets that can be cached corresponding to a single domain. Subnet caching will occur for responses with EDNS Client Subnet (ECS) option. Caching of such responses can be disabled using DNS profile settings. A value of zero indicates that the number of subnets cached is limited only by existing memory constraints. The default value is zero. 
         
         
        Maximum value = 1280 
    .PARAMETER Maxnegcachettl 
        Maximum time to live (TTL) for all negative records ( NXDONAIN and NODATA ) cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxnegcacheTTL, the TTL of the record is set to the value of maxnegcacheTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
         
         
        Maximum value = 604800 
    .PARAMETER Cachehitbypass 
        This parameter is applicable only in proxy mode and if this parameter is enabled we will forward all the client requests to the backend DNS server and the response served will be cached on Citrix ADC. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxcachesize 
        Maximum memory, in megabytes, that can be used for dns caching per Packet Engine. 
    .PARAMETER Maxnegativecachesize 
        Maximum memory, in megabytes, that can be used for caching of negative DNS responses per packet engine. 
    .PARAMETER Cachenoexpire 
        If this flag is set to YES, the existing entries in cache do not age out. On reaching the max limit the cache records are frozen. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Splitpktqueryprocessing 
        Processing requests split across multiple packets. 
         
        Possible values = ALLOW, DROP 
    .PARAMETER Cacheecszeroprefix 
        Cache ECS responses with a Scope Prefix length of zero. Such a cached response will be used for all queries with this domain name and any subnet. When disabled, ECS responses with Scope Prefix length of zero will be cached, but not tied to any subnet. This option has no effect if caching of ECS responses is disabled in the corresponding DNS profile. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxudppacketsize 
        Maximum UDP packet size that can be handled by Citrix ADC. This is the value advertised by Citrix ADC when responding as an authoritative server and it is also used when Citrix ADC queries other name servers as a forwarder. When acting as a proxy, requests from clients are limited by this parameter - if a request contains a size greater than this value in the OPT record, it will be replaced. 
         
         
        Maximum value = 16384 
    .PARAMETER Nxdomainratelimitthreshold 
        Rate limit threshold for Non-Existant domain (NXDOMAIN) responses generated from Citrix ADC. Once the threshold is breached, DNS queries leading to NXDOMAIN response will be dropped. This threshold will not be applied for NXDOMAIN responses got from the backend. The threshold will be applied per packet engine and per second.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnsparameter 
        An example how to unset dnsparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnsparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$retries,

        [Boolean]$minttl,

        [Boolean]$maxttl,

        [Boolean]$cacherecords,

        [Boolean]$namelookuppriority,

        [Boolean]$recursion,

        [Boolean]$resolutionorder,

        [Boolean]$dnssec,

        [Boolean]$maxpipeline,

        [Boolean]$dnsrootreferral,

        [Boolean]$dns64timeout,

        [Boolean]$ecsmaxsubnets,

        [Boolean]$maxnegcachettl,

        [Boolean]$cachehitbypass,

        [Boolean]$maxcachesize,

        [Boolean]$maxnegativecachesize,

        [Boolean]$cachenoexpire,

        [Boolean]$splitpktqueryprocessing,

        [Boolean]$cacheecszeroprefix,

        [Boolean]$maxudppacketsize,

        [Boolean]$nxdomainratelimitthreshold 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnsparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('retries') ) { $payload.Add('retries', $retries) }
            if ( $PSBoundParameters.ContainsKey('minttl') ) { $payload.Add('minttl', $minttl) }
            if ( $PSBoundParameters.ContainsKey('maxttl') ) { $payload.Add('maxttl', $maxttl) }
            if ( $PSBoundParameters.ContainsKey('cacherecords') ) { $payload.Add('cacherecords', $cacherecords) }
            if ( $PSBoundParameters.ContainsKey('namelookuppriority') ) { $payload.Add('namelookuppriority', $namelookuppriority) }
            if ( $PSBoundParameters.ContainsKey('recursion') ) { $payload.Add('recursion', $recursion) }
            if ( $PSBoundParameters.ContainsKey('resolutionorder') ) { $payload.Add('resolutionorder', $resolutionorder) }
            if ( $PSBoundParameters.ContainsKey('dnssec') ) { $payload.Add('dnssec', $dnssec) }
            if ( $PSBoundParameters.ContainsKey('maxpipeline') ) { $payload.Add('maxpipeline', $maxpipeline) }
            if ( $PSBoundParameters.ContainsKey('dnsrootreferral') ) { $payload.Add('dnsrootreferral', $dnsrootreferral) }
            if ( $PSBoundParameters.ContainsKey('dns64timeout') ) { $payload.Add('dns64timeout', $dns64timeout) }
            if ( $PSBoundParameters.ContainsKey('ecsmaxsubnets') ) { $payload.Add('ecsmaxsubnets', $ecsmaxsubnets) }
            if ( $PSBoundParameters.ContainsKey('maxnegcachettl') ) { $payload.Add('maxnegcachettl', $maxnegcachettl) }
            if ( $PSBoundParameters.ContainsKey('cachehitbypass') ) { $payload.Add('cachehitbypass', $cachehitbypass) }
            if ( $PSBoundParameters.ContainsKey('maxcachesize') ) { $payload.Add('maxcachesize', $maxcachesize) }
            if ( $PSBoundParameters.ContainsKey('maxnegativecachesize') ) { $payload.Add('maxnegativecachesize', $maxnegativecachesize) }
            if ( $PSBoundParameters.ContainsKey('cachenoexpire') ) { $payload.Add('cachenoexpire', $cachenoexpire) }
            if ( $PSBoundParameters.ContainsKey('splitpktqueryprocessing') ) { $payload.Add('splitpktqueryprocessing', $splitpktqueryprocessing) }
            if ( $PSBoundParameters.ContainsKey('cacheecszeroprefix') ) { $payload.Add('cacheecszeroprefix', $cacheecszeroprefix) }
            if ( $PSBoundParameters.ContainsKey('maxudppacketsize') ) { $payload.Add('maxudppacketsize', $maxudppacketsize) }
            if ( $PSBoundParameters.ContainsKey('nxdomainratelimitthreshold') ) { $payload.Add('nxdomainratelimitthreshold', $nxdomainratelimitthreshold) }
            if ( $PSCmdlet.ShouldProcess("dnsparameter", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnsparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnsparameter: Finished"
    }
}

function Invoke-NSGetDnsparameter {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for DNS parameter resource.
    .PARAMETER GetAll 
        Retrieve all dnsparameter object(s).
    .PARAMETER Count
        If specified, the count of the dnsparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsparameter -GetAll 
        Get all dnsparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsparameter -name <string>
        Get dnsparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsparameter -Filter @{ 'name'='<value>' }
        Get dnsparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsparameter/
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
        Write-Verbose "Invoke-NSGetDnsparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsparameter: Ended"
    }
}

function Invoke-NSAddDnspolicy {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS policy resource.
    .PARAMETER Name 
        Name for the DNS policy. 
    .PARAMETER Rule 
        Expression against which DNS traffic is evaluated. 
        Note: 
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks. 
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
        Example: CLIENT.UDP.DNS.DOMAIN.EQ("domainname"). 
    .PARAMETER Viewname 
        The view name that must be used for the given policy. 
    .PARAMETER Preferredlocation 
        The location used for the given policy. This is deprecated attribute. Please use -prefLocList. 
    .PARAMETER Preferredloclist 
        The location list in priority order used for the given policy. 
    .PARAMETER Drop 
        The dns packet must be dropped. 
        Possible values = YES, NO 
    .PARAMETER Cachebypass 
        By pass dns cache for this. 
        Possible values = YES, NO 
    .PARAMETER Actionname 
        Name of the DNS action to perform when the rule evaluates to TRUE. The built in actions function as follows: 
        * dns_default_act_Drop. Drop the DNS request. 
        * dns_default_act_Cachebypass. Bypass the DNS cache and forward the request to the name server. 
        You can create custom actions by using the add dns action command in the CLI or the DNS &gt; Actions &gt; Create DNS Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnspolicy -name <string> -rule <string>
        An example how to add dnspolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Rule,

        [string]$Viewname,

        [string]$Preferredlocation,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Preferredloclist,

        [ValidateSet('YES', 'NO')]
        [string]$Drop,

        [ValidateSet('YES', 'NO')]
        [string]$Cachebypass,

        [string]$Actionname,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnspolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
            }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('preferredlocation') ) { $payload.Add('preferredlocation', $preferredlocation) }
            if ( $PSBoundParameters.ContainsKey('preferredloclist') ) { $payload.Add('preferredloclist', $preferredloclist) }
            if ( $PSBoundParameters.ContainsKey('drop') ) { $payload.Add('drop', $drop) }
            if ( $PSBoundParameters.ContainsKey('cachebypass') ) { $payload.Add('cachebypass', $cachebypass) }
            if ( $PSBoundParameters.ContainsKey('actionname') ) { $payload.Add('actionname', $actionname) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("dnspolicy", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnspolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnspolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnspolicy: Finished"
    }
}

function Invoke-NSDeleteDnspolicy {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS policy resource.
    .PARAMETER Name 
        Name for the DNS policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnspolicy -Name <string>
        An example how to delete dnspolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteDnspolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnspolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnspolicy: Finished"
    }
}

function Invoke-NSUpdateDnspolicy {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS policy resource.
    .PARAMETER Name 
        Name for the DNS policy. 
    .PARAMETER Rule 
        Expression against which DNS traffic is evaluated. 
        Note: 
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks. 
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
        Example: CLIENT.UDP.DNS.DOMAIN.EQ("domainname"). 
    .PARAMETER Viewname 
        The view name that must be used for the given policy. 
    .PARAMETER Preferredlocation 
        The location used for the given policy. This is deprecated attribute. Please use -prefLocList. 
    .PARAMETER Preferredloclist 
        The location list in priority order used for the given policy. 
    .PARAMETER Drop 
        The dns packet must be dropped. 
        Possible values = YES, NO 
    .PARAMETER Cachebypass 
        By pass dns cache for this. 
        Possible values = YES, NO 
    .PARAMETER Actionname 
        Name of the DNS action to perform when the rule evaluates to TRUE. The built in actions function as follows: 
        * dns_default_act_Drop. Drop the DNS request. 
        * dns_default_act_Cachebypass. Bypass the DNS cache and forward the request to the name server. 
        You can create custom actions by using the add dns action command in the CLI or the DNS &gt; Actions &gt; Create DNS Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnspolicy -name <string>
        An example how to update dnspolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Rule,

        [string]$Viewname,

        [string]$Preferredlocation,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Preferredloclist,

        [ValidateSet('YES', 'NO')]
        [string]$Drop,

        [ValidateSet('YES', 'NO')]
        [string]$Cachebypass,

        [string]$Actionname,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnspolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('preferredlocation') ) { $payload.Add('preferredlocation', $preferredlocation) }
            if ( $PSBoundParameters.ContainsKey('preferredloclist') ) { $payload.Add('preferredloclist', $preferredloclist) }
            if ( $PSBoundParameters.ContainsKey('drop') ) { $payload.Add('drop', $drop) }
            if ( $PSBoundParameters.ContainsKey('cachebypass') ) { $payload.Add('cachebypass', $cachebypass) }
            if ( $PSBoundParameters.ContainsKey('actionname') ) { $payload.Add('actionname', $actionname) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("dnspolicy", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnspolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnspolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateDnspolicy: Finished"
    }
}

function Invoke-NSUnsetDnspolicy {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS policy resource.
    .PARAMETER Name 
        Name for the DNS policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnspolicy -name <string>
        An example how to unset dnspolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnspolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnspolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnspolicy: Finished"
    }
}

function Invoke-NSGetDnspolicy {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for DNS policy resource.
    .PARAMETER Name 
        Name for the DNS policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicy -GetAll 
        Get all dnspolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicy -Count 
        Get the number of dnspolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy -name <string>
        Get dnspolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy -Filter @{ 'name'='<value>' }
        Get dnspolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy/
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
        Write-Verbose "Invoke-NSGetDnspolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnspolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicy: Ended"
    }
}

function Invoke-NSAddDnspolicy64 {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns64 policy resource.
    .PARAMETER Name 
        Name for the DNS64 policy. 
    .PARAMETER Rule 
        Expression against which DNS traffic is evaluated. 
        Note: 
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks. 
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
        Example: CLIENT.IP.SRC.IN_SUBENT(23.34.0.0/16). 
    .PARAMETER Action 
        Name of the DNS64 action to perform when the rule evaluates to TRUE. The built in actions function as follows: 
        * A default dns64 action with prefix &lt;default prefix&gt; and mapped and exclude are any 
        You can create custom actions by using the add dns action command in the CLI or the DNS64 &gt; Actions &gt; Create DNS64 Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy64 item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnspolicy64 -name <string> -rule <string>
        An example how to add dnspolicy64 config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnspolicy64
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy64/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Rule,

        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnspolicy64: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
            }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("dnspolicy64", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnspolicy64 -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnspolicy64 -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnspolicy64: Finished"
    }
}

function Invoke-NSDeleteDnspolicy64 {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns64 policy resource.
    .PARAMETER Name 
        Name for the DNS64 policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnspolicy64 -Name <string>
        An example how to delete dnspolicy64 config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnspolicy64
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy64/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteDnspolicy64: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnspolicy64 -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnspolicy64: Finished"
    }
}

function Invoke-NSUpdateDnspolicy64 {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns64 policy resource.
    .PARAMETER Name 
        Name for the DNS64 policy. 
    .PARAMETER Rule 
        Expression against which DNS traffic is evaluated. 
        Note: 
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks. 
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
        Example: CLIENT.IP.SRC.IN_SUBENT(23.34.0.0/16). 
    .PARAMETER Action 
        Name of the DNS64 action to perform when the rule evaluates to TRUE. The built in actions function as follows: 
        * A default dns64 action with prefix &lt;default prefix&gt; and mapped and exclude are any 
        You can create custom actions by using the add dns action command in the CLI or the DNS64 &gt; Actions &gt; Create DNS64 Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy64 item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnspolicy64 -name <string>
        An example how to update dnspolicy64 config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnspolicy64
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy64/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Rule,

        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnspolicy64: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("dnspolicy64", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnspolicy64 -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnspolicy64 -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateDnspolicy64: Finished"
    }
}

function Invoke-NSGetDnspolicy64 {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for dns64 policy resource.
    .PARAMETER Name 
        Name for the DNS64 policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy64 object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy64 object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy64
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicy64 -GetAll 
        Get all dnspolicy64 data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicy64 -Count 
        Get the number of dnspolicy64 objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy64 -name <string>
        Get dnspolicy64 object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy64 -Filter @{ 'name'='<value>' }
        Get dnspolicy64 data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicy64
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy64/
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
        Write-Verbose "Invoke-NSGetDnspolicy64: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnspolicy64 objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy64 objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy64 objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy64 configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy64 configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicy64: Ended"
    }
}

function Invoke-NSGetDnspolicy64Binding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnspolicy64.
    .PARAMETER Name 
        Name of the DNS64 policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy64_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy64_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy64Binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicy64Binding -GetAll 
        Get all dnspolicy64_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy64Binding -name <string>
        Get dnspolicy64_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy64Binding -Filter @{ 'name'='<value>' }
        Get dnspolicy64_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicy64Binding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy64_binding/
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
        Write-Verbose "Invoke-NSGetDnspolicy64Binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicy64_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy64_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy64_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy64_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy64_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicy64Binding: Ended"
    }
}

function Invoke-NSGetDnspolicy64LbvserverBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to dnspolicy64.
    .PARAMETER Name 
        Name of the DNS64 policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy64_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy64_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy64LbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicy64LbvserverBinding -GetAll 
        Get all dnspolicy64_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicy64LbvserverBinding -Count 
        Get the number of dnspolicy64_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy64LbvserverBinding -name <string>
        Get dnspolicy64_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicy64LbvserverBinding -Filter @{ 'name'='<value>' }
        Get dnspolicy64_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicy64LbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy64_lbvserver_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetDnspolicy64LbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicy64_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy64_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy64_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy64_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy64_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicy64LbvserverBinding: Ended"
    }
}

function Invoke-NSGetDnspolicyBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnspolicy.
    .PARAMETER Name 
        Name of the DNS policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicyBinding -GetAll 
        Get all dnspolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicyBinding -name <string>
        Get dnspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicyBinding -Filter @{ 'name'='<value>' }
        Get dnspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy_binding/
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
        Write-Verbose "Invoke-NSGetDnspolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicyBinding: Ended"
    }
}

function Invoke-NSGetDnspolicyDnsglobalBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object showing the dnsglobal that can be bound to dnspolicy.
    .PARAMETER Name 
        Name of the DNS policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy_dnsglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy_dnsglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicyDnsglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicyDnsglobalBinding -GetAll 
        Get all dnspolicy_dnsglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicyDnsglobalBinding -Count 
        Get the number of dnspolicy_dnsglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicyDnsglobalBinding -name <string>
        Get dnspolicy_dnsglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicyDnsglobalBinding -Filter @{ 'name'='<value>' }
        Get dnspolicy_dnsglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicyDnsglobalBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy_dnsglobal_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetDnspolicyDnsglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicy_dnsglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy_dnsglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy_dnsglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy_dnsglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy_dnsglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicyDnsglobalBinding: Ended"
    }
}

function Invoke-NSGetDnspolicyDnspolicylabelBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object showing the dnspolicylabel that can be bound to dnspolicy.
    .PARAMETER Name 
        Name of the DNS policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy_dnspolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy_dnspolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicyDnspolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicyDnspolicylabelBinding -GetAll 
        Get all dnspolicy_dnspolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicyDnspolicylabelBinding -Count 
        Get the number of dnspolicy_dnspolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicyDnspolicylabelBinding -name <string>
        Get dnspolicy_dnspolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicyDnspolicylabelBinding -Filter @{ 'name'='<value>' }
        Get dnspolicy_dnspolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicyDnspolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicy_dnspolicylabel_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetDnspolicyDnspolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicy_dnspolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy_dnspolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy_dnspolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy_dnspolicylabel_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy_dnspolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicyDnspolicylabelBinding: Ended"
    }
}

function Invoke-NSAddDnspolicylabel {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns policy label resource.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER Transform 
        The type of transformations allowed by the policies bound to the label. 
        Possible values = dns_req, dns_res 
    .PARAMETER PassThru 
        Return details about the created dnspolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnspolicylabel -labelname <string> -transform <string>
        An example how to add dnspolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnspolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [ValidateSet('dns_req', 'dns_res')]
        [string]$Transform,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnspolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                transform           = $transform
            }

            if ( $PSCmdlet.ShouldProcess("dnspolicylabel", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnspolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnspolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnspolicylabel: Finished"
    }
}

function Invoke-NSDeleteDnspolicylabel {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns policy label resource.
    .PARAMETER Labelname 
        Name of the dns policy label.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnspolicylabel -Labelname <string>
        An example how to delete dnspolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnspolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteDnspolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnspolicylabel: Finished"
    }
}

function Invoke-NSRenameDnspolicylabel {
    <#
    .SYNOPSIS
        Rename Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for dns policy label resource.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER Newname 
        The new name of the dns policylabel. 
    .PARAMETER PassThru 
        Return details about the created dnspolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameDnspolicylabel -labelname <string> -newname <string>
        An example how to rename dnspolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSRenameDnspolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSRenameDnspolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("dnspolicylabel", "Rename Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnspolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnspolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameDnspolicylabel: Finished"
    }
}

function Invoke-NSGetDnspolicylabel {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for dns policy label resource.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER GetAll 
        Retrieve all dnspolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicylabel -GetAll 
        Get all dnspolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicylabel -Count 
        Get the number of dnspolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabel -name <string>
        Get dnspolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabel -Filter @{ 'name'='<value>' }
        Get dnspolicylabel data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicylabel/
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
        Write-Verbose "Invoke-NSGetDnspolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnspolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicylabel: Ended"
    }
}

function Invoke-NSGetDnspolicylabelBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnspolicylabel.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER GetAll 
        Retrieve all dnspolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicylabelBinding -GetAll 
        Get all dnspolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabelBinding -name <string>
        Get dnspolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabelBinding -Filter @{ 'name'='<value>' }
        Get dnspolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetDnspolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicylabelBinding: Ended"
    }
}

function Invoke-NSAddDnspolicylabelDnspolicyBinding {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnspolicylabel.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER Policyname 
        The dns policy name. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        Type of policy label invocation. 
        Possible values = policylabel 
    .PARAMETER Invoke_labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created dnspolicylabel_dnspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnspolicylabelDnspolicyBinding -labelname <string> -policyname <string> -priority <double>
        An example how to add dnspolicylabel_dnspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnspolicylabelDnspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicylabel_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnspolicylabelDnspolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("dnspolicylabel_dnspolicy_binding", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnspolicylabel_dnspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnspolicylabelDnspolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnspolicylabelDnspolicyBinding: Finished"
    }
}

function Invoke-NSDeleteDnspolicylabelDnspolicyBinding {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnspolicylabel.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER Policyname 
        The dns policy name. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnspolicylabelDnspolicyBinding -Labelname <string>
        An example how to delete dnspolicylabel_dnspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnspolicylabelDnspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicylabel_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteDnspolicylabelDnspolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnspolicylabelDnspolicyBinding: Finished"
    }
}

function Invoke-NSGetDnspolicylabelDnspolicyBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnspolicylabel.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER GetAll 
        Retrieve all dnspolicylabel_dnspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicylabel_dnspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabelDnspolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicylabelDnspolicyBinding -GetAll 
        Get all dnspolicylabel_dnspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicylabelDnspolicyBinding -Count 
        Get the number of dnspolicylabel_dnspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabelDnspolicyBinding -name <string>
        Get dnspolicylabel_dnspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabelDnspolicyBinding -Filter @{ 'name'='<value>' }
        Get dnspolicylabel_dnspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicylabelDnspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicylabel_dnspolicy_binding/
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
        Write-Verbose "Invoke-NSGetDnspolicylabelDnspolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicylabel_dnspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel_dnspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel_dnspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel_dnspolicy_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel_dnspolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicylabelDnspolicyBinding: Ended"
    }
}

function Invoke-NSGetDnspolicylabelPolicybindingBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to dnspolicylabel.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER GetAll 
        Retrieve all dnspolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabelPolicybindingBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicylabelPolicybindingBinding -GetAll 
        Get all dnspolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnspolicylabelPolicybindingBinding -Count 
        Get the number of dnspolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabelPolicybindingBinding -name <string>
        Get dnspolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnspolicylabelPolicybindingBinding -Filter @{ 'name'='<value>' }
        Get dnspolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnspolicylabelPolicybindingBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnspolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-NSGetDnspolicylabelPolicybindingBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel_policybinding_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnspolicylabelPolicybindingBinding: Ended"
    }
}

function Invoke-NSAddDnsprofile {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS profile resource.
    .PARAMETER Dnsprofilename 
        Name of the DNS profile. 
    .PARAMETER Dnsquerylogging 
        DNS query logging; if enabled, DNS query information such as DNS query id, DNS query flags, DNS domain name and DNS query type will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsanswerseclogging 
        DNS answer section; if enabled, answer section in the response will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsextendedlogging 
        DNS extended logging; if enabled, authority and additional section in the response will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnserrorlogging 
        DNS error logging; if enabled, whenever error is encountered in DNS module reason for the error will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cachenegativeresponses 
        Cache negative responses in the DNS cache. When disabled, the appliance stops caching negative responses except referral records. This applies to all configurations - proxy, end resolver, and forwarder. However, cached responses are not flushed. The appliance does not serve negative responses from the cache until this parameter is enabled again. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dropmultiqueryrequest 
        Drop the DNS requests containing multiple queries. When enabled, DNS requests containing multiple queries will be dropped. In case of proxy configuration by default the DNS request containing multiple queries is forwarded to the backend and in case of ADNS and Resolver configuration NOCODE error response will be sent to the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacheecsresponses 
        Cache DNS responses with EDNS Client Subnet(ECS) option in the DNS cache. When disabled, the appliance stops caching responses with ECS option. This is relevant to proxy configuration. Enabling/disabling support of ECS option when Citrix ADC is authoritative for a GSLB domain is supported using a knob in GSLB vserver. In all other modes, ECS option is ignored. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnsprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsprofile -dnsprofilename <string>
        An example how to add dnsprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Dnsprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsquerylogging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsanswerseclogging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsextendedlogging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnserrorlogging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacherecords = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cachenegativeresponses = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dropmultiqueryrequest = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacheecsresponses = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsprofile: Starting"
    }
    process {
        try {
            $payload = @{ dnsprofilename = $dnsprofilename }
            if ( $PSBoundParameters.ContainsKey('dnsquerylogging') ) { $payload.Add('dnsquerylogging', $dnsquerylogging) }
            if ( $PSBoundParameters.ContainsKey('dnsanswerseclogging') ) { $payload.Add('dnsanswerseclogging', $dnsanswerseclogging) }
            if ( $PSBoundParameters.ContainsKey('dnsextendedlogging') ) { $payload.Add('dnsextendedlogging', $dnsextendedlogging) }
            if ( $PSBoundParameters.ContainsKey('dnserrorlogging') ) { $payload.Add('dnserrorlogging', $dnserrorlogging) }
            if ( $PSBoundParameters.ContainsKey('cacherecords') ) { $payload.Add('cacherecords', $cacherecords) }
            if ( $PSBoundParameters.ContainsKey('cachenegativeresponses') ) { $payload.Add('cachenegativeresponses', $cachenegativeresponses) }
            if ( $PSBoundParameters.ContainsKey('dropmultiqueryrequest') ) { $payload.Add('dropmultiqueryrequest', $dropmultiqueryrequest) }
            if ( $PSBoundParameters.ContainsKey('cacheecsresponses') ) { $payload.Add('cacheecsresponses', $cacheecsresponses) }
            if ( $PSCmdlet.ShouldProcess("dnsprofile", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnsprofile: Finished"
    }
}

function Invoke-NSUpdateDnsprofile {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS profile resource.
    .PARAMETER Dnsprofilename 
        Name of the DNS profile. 
    .PARAMETER Dnsquerylogging 
        DNS query logging; if enabled, DNS query information such as DNS query id, DNS query flags, DNS domain name and DNS query type will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsanswerseclogging 
        DNS answer section; if enabled, answer section in the response will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsextendedlogging 
        DNS extended logging; if enabled, authority and additional section in the response will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnserrorlogging 
        DNS error logging; if enabled, whenever error is encountered in DNS module reason for the error will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cachenegativeresponses 
        Cache negative responses in the DNS cache. When disabled, the appliance stops caching negative responses except referral records. This applies to all configurations - proxy, end resolver, and forwarder. However, cached responses are not flushed. The appliance does not serve negative responses from the cache until this parameter is enabled again. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dropmultiqueryrequest 
        Drop the DNS requests containing multiple queries. When enabled, DNS requests containing multiple queries will be dropped. In case of proxy configuration by default the DNS request containing multiple queries is forwarded to the backend and in case of ADNS and Resolver configuration NOCODE error response will be sent to the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacheecsresponses 
        Cache DNS responses with EDNS Client Subnet(ECS) option in the DNS cache. When disabled, the appliance stops caching responses with ECS option. This is relevant to proxy configuration. Enabling/disabling support of ECS option when Citrix ADC is authoritative for a GSLB domain is supported using a knob in GSLB vserver. In all other modes, ECS option is ignored. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnsprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnsprofile -dnsprofilename <string>
        An example how to update dnsprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnsprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Dnsprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsquerylogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsanswerseclogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsextendedlogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnserrorlogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacherecords,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cachenegativeresponses,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dropmultiqueryrequest,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacheecsresponses,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnsprofile: Starting"
    }
    process {
        try {
            $payload = @{ dnsprofilename = $dnsprofilename }
            if ( $PSBoundParameters.ContainsKey('dnsquerylogging') ) { $payload.Add('dnsquerylogging', $dnsquerylogging) }
            if ( $PSBoundParameters.ContainsKey('dnsanswerseclogging') ) { $payload.Add('dnsanswerseclogging', $dnsanswerseclogging) }
            if ( $PSBoundParameters.ContainsKey('dnsextendedlogging') ) { $payload.Add('dnsextendedlogging', $dnsextendedlogging) }
            if ( $PSBoundParameters.ContainsKey('dnserrorlogging') ) { $payload.Add('dnserrorlogging', $dnserrorlogging) }
            if ( $PSBoundParameters.ContainsKey('cacherecords') ) { $payload.Add('cacherecords', $cacherecords) }
            if ( $PSBoundParameters.ContainsKey('cachenegativeresponses') ) { $payload.Add('cachenegativeresponses', $cachenegativeresponses) }
            if ( $PSBoundParameters.ContainsKey('dropmultiqueryrequest') ) { $payload.Add('dropmultiqueryrequest', $dropmultiqueryrequest) }
            if ( $PSBoundParameters.ContainsKey('cacheecsresponses') ) { $payload.Add('cacheecsresponses', $cacheecsresponses) }
            if ( $PSCmdlet.ShouldProcess("dnsprofile", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnsprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateDnsprofile: Finished"
    }
}

function Invoke-NSUnsetDnsprofile {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS profile resource.
    .PARAMETER Dnsprofilename 
        Name of the DNS profile. 
    .PARAMETER Dnsquerylogging 
        DNS query logging; if enabled, DNS query information such as DNS query id, DNS query flags, DNS domain name and DNS query type will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsanswerseclogging 
        DNS answer section; if enabled, answer section in the response will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsextendedlogging 
        DNS extended logging; if enabled, authority and additional section in the response will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnserrorlogging 
        DNS error logging; if enabled, whenever error is encountered in DNS module reason for the error will be logged. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cachenegativeresponses 
        Cache negative responses in the DNS cache. When disabled, the appliance stops caching negative responses except referral records. This applies to all configurations - proxy, end resolver, and forwarder. However, cached responses are not flushed. The appliance does not serve negative responses from the cache until this parameter is enabled again. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dropmultiqueryrequest 
        Drop the DNS requests containing multiple queries. When enabled, DNS requests containing multiple queries will be dropped. In case of proxy configuration by default the DNS request containing multiple queries is forwarded to the backend and in case of ADNS and Resolver configuration NOCODE error response will be sent to the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacheecsresponses 
        Cache DNS responses with EDNS Client Subnet(ECS) option in the DNS cache. When disabled, the appliance stops caching responses with ECS option. This is relevant to proxy configuration. Enabling/disabling support of ECS option when Citrix ADC is authoritative for a GSLB domain is supported using a knob in GSLB vserver. In all other modes, ECS option is ignored. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnsprofile -dnsprofilename <string>
        An example how to unset dnsprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnsprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsprofile
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Dnsprofilename,

        [Boolean]$dnsquerylogging,

        [Boolean]$dnsanswerseclogging,

        [Boolean]$dnsextendedlogging,

        [Boolean]$dnserrorlogging,

        [Boolean]$cacherecords,

        [Boolean]$cachenegativeresponses,

        [Boolean]$dropmultiqueryrequest,

        [Boolean]$cacheecsresponses 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnsprofile: Starting"
    }
    process {
        try {
            $payload = @{ dnsprofilename = $dnsprofilename }
            if ( $PSBoundParameters.ContainsKey('dnsquerylogging') ) { $payload.Add('dnsquerylogging', $dnsquerylogging) }
            if ( $PSBoundParameters.ContainsKey('dnsanswerseclogging') ) { $payload.Add('dnsanswerseclogging', $dnsanswerseclogging) }
            if ( $PSBoundParameters.ContainsKey('dnsextendedlogging') ) { $payload.Add('dnsextendedlogging', $dnsextendedlogging) }
            if ( $PSBoundParameters.ContainsKey('dnserrorlogging') ) { $payload.Add('dnserrorlogging', $dnserrorlogging) }
            if ( $PSBoundParameters.ContainsKey('cacherecords') ) { $payload.Add('cacherecords', $cacherecords) }
            if ( $PSBoundParameters.ContainsKey('cachenegativeresponses') ) { $payload.Add('cachenegativeresponses', $cachenegativeresponses) }
            if ( $PSBoundParameters.ContainsKey('dropmultiqueryrequest') ) { $payload.Add('dropmultiqueryrequest', $dropmultiqueryrequest) }
            if ( $PSBoundParameters.ContainsKey('cacheecsresponses') ) { $payload.Add('cacheecsresponses', $cacheecsresponses) }
            if ( $PSCmdlet.ShouldProcess("$dnsprofilename", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnsprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnsprofile: Finished"
    }
}

function Invoke-NSDeleteDnsprofile {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS profile resource.
    .PARAMETER Dnsprofilename 
        Name of the DNS profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsprofile -Dnsprofilename <string>
        An example how to delete dnsprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Dnsprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$dnsprofilename", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsprofile -NitroPath nitro/v1/config -Resource $dnsprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsprofile: Finished"
    }
}

function Invoke-NSGetDnsprofile {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for DNS profile resource.
    .PARAMETER Dnsprofilename 
        Name of the DNS profile. 
    .PARAMETER GetAll 
        Retrieve all dnsprofile object(s).
    .PARAMETER Count
        If specified, the count of the dnsprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsprofile -GetAll 
        Get all dnsprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsprofile -Count 
        Get the number of dnsprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsprofile -name <string>
        Get dnsprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsprofile -Filter @{ 'name'='<value>' }
        Get dnsprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsprofile/
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
        [string]$Dnsprofilename,

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
        Write-Verbose "Invoke-NSGetDnsprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsprofile configuration for property 'dnsprofilename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Resource $dnsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsprofile: Ended"
    }
}

function Invoke-NSFlushDnsproxyrecords {
    <#
    .SYNOPSIS
        Flush Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for proxy record resource.
    .PARAMETER Type 
        Filter the DNS records to be flushed.e.g flush dns proxyRecords -type A will flush only the A records from the cache. . 
        Possible values = A, NS, CNAME, SOA, MX, AAAA, SRV, RRSIG, NSEC, DNSKEY, PTR, TXT, NAPTR, CAA 
    .PARAMETER Negrectype 
        Filter the Negative DNS records i.e NXDOMAIN and NODATA entries to be flushed. e.g flush dns proxyRecords NXDOMAIN will flush only the NXDOMAIN entries from the cache. 
        Possible values = NXDOMAIN, NODATA
    .EXAMPLE
        PS C:\>Invoke-NSFlushDnsproxyrecords 
        An example how to flush dnsproxyrecords config Object(s).
    .NOTES
        File Name : Invoke-NSFlushDnsproxyrecords
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsproxyrecords/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateSet('A', 'NS', 'CNAME', 'SOA', 'MX', 'AAAA', 'SRV', 'RRSIG', 'NSEC', 'DNSKEY', 'PTR', 'TXT', 'NAPTR', 'CAA')]
        [string]$Type,

        [ValidateSet('NXDOMAIN', 'NODATA')]
        [string]$Negrectype 

    )
    begin {
        Write-Verbose "Invoke-NSFlushDnsproxyrecords: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('negrectype') ) { $payload.Add('negrectype', $negrectype) }
            if ( $PSCmdlet.ShouldProcess($Name, "Flush Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsproxyrecords -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSFlushDnsproxyrecords: Finished"
    }
}

function Invoke-NSAddDnsptrrec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for PTR record resource.
    .PARAMETER Reversedomain 
        Reversed domain name representation of the IPv4 or IPv6 address for which to create the PTR record. Use the "in-addr.arpa." suffix for IPv4 addresses and the "ip6.arpa." suffix for IPv6 addresses. 
    .PARAMETER Domain 
        Domain name for which to configure reverse mapping. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsptrrec item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsptrrec -reversedomain <string> -domain <string>
        An example how to add dnsptrrec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsptrrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsptrrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Reversedomain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsptrrec: Starting"
    }
    process {
        try {
            $payload = @{ reversedomain = $reversedomain
                domain                  = $domain
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsptrrec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsptrrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsptrrec -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnsptrrec: Finished"
    }
}

function Invoke-NSDeleteDnsptrrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for PTR record resource.
    .PARAMETER Reversedomain 
        Reversed domain name representation of the IPv4 or IPv6 address for which to create the PTR record. Use the "in-addr.arpa." suffix for IPv4 addresses and the "ip6.arpa." suffix for IPv6 addresses. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached PTR record need to be removed. 
    .PARAMETER Domain 
        Domain name for which to configure reverse mapping.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsptrrec -Reversedomain <string>
        An example how to delete dnsptrrec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsptrrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsptrrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Reversedomain,

        [string]$Ecssubnet,

        [string]$Domain 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsptrrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSBoundParameters.ContainsKey('Domain') ) { $arguments.Add('domain', $Domain) }
            if ( $PSCmdlet.ShouldProcess("$reversedomain", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsptrrec -NitroPath nitro/v1/config -Resource $reversedomain -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsptrrec: Finished"
    }
}

function Invoke-NSGetDnsptrrec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for PTR record resource.
    .PARAMETER Reversedomain 
        Reversed domain name representation of the IPv4 or IPv6 address for which to create the PTR record. Use the "in-addr.arpa." suffix for IPv4 addresses and the "ip6.arpa." suffix for IPv6 addresses. 
    .PARAMETER GetAll 
        Retrieve all dnsptrrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsptrrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsptrrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsptrrec -GetAll 
        Get all dnsptrrec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsptrrec -Count 
        Get the number of dnsptrrec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsptrrec -name <string>
        Get dnsptrrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsptrrec -Filter @{ 'name'='<value>' }
        Get dnsptrrec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsptrrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsptrrec/
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
        [string]$Reversedomain,

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
        Write-Verbose "Invoke-NSGetDnsptrrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsptrrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsptrrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsptrrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsptrrec configuration for property 'reversedomain'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Resource $reversedomain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsptrrec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsptrrec: Ended"
    }
}

function Invoke-NSAddDnssoarec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for SOA record resource.
    .PARAMETER Domain 
        Domain name for which to add the SOA record. 
    .PARAMETER Originserver 
        Domain name of the name server that responds authoritatively for the domain. 
    .PARAMETER Contact 
        Email address of the contact to whom domain issues can be addressed. In the email address, replace the @ sign with a period (.). For example, enter domainadmin.example.com instead of domainadmin@example.com. 
    .PARAMETER Serial 
        The secondary server uses this parameter to determine whether it requires a zone transfer from the primary server. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Refresh 
        Time, in seconds, for which a secondary server must wait between successive checks on the value of the serial number. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Retry 
        Time, in seconds, between retries if a secondary server's attempt to contact the primary server for a zone refresh fails. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Expire 
        Time, in seconds, after which the zone data on a secondary name server can no longer be considered authoritative because all refresh and retry attempts made during the period have failed. After the expiry period, the secondary server stops serving the zone. Typically one week. Not used by the primary server. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Minimum 
        Default time to live (TTL) for all records in the zone. Can be overridden for individual records. 
         
         
        Maximum value = 2147483647 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnssoarec item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnssoarec -domain <string> -originserver <string> -contact <string>
        An example how to add dnssoarec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnssoarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssoarec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Domain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Originserver,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Contact,

        [double]$Serial = '100',

        [double]$Refresh = '3600',

        [double]$Retry = '3',

        [double]$Expire = '3600',

        [double]$Minimum = '5',

        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnssoarec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                originserver     = $originserver
                contact          = $contact
            }
            if ( $PSBoundParameters.ContainsKey('serial') ) { $payload.Add('serial', $serial) }
            if ( $PSBoundParameters.ContainsKey('refresh') ) { $payload.Add('refresh', $refresh) }
            if ( $PSBoundParameters.ContainsKey('retry') ) { $payload.Add('retry', $retry) }
            if ( $PSBoundParameters.ContainsKey('expire') ) { $payload.Add('expire', $expire) }
            if ( $PSBoundParameters.ContainsKey('minimum') ) { $payload.Add('minimum', $minimum) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnssoarec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnssoarec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnssoarec -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnssoarec: Finished"
    }
}

function Invoke-NSDeleteDnssoarec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for SOA record resource.
    .PARAMETER Domain 
        Domain name for which to add the SOA record. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached SOA record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnssoarec -Domain <string>
        An example how to delete dnssoarec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnssoarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssoarec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnssoarec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnssoarec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnssoarec: Finished"
    }
}

function Invoke-NSUpdateDnssoarec {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for SOA record resource.
    .PARAMETER Domain 
        Domain name for which to add the SOA record. 
    .PARAMETER Originserver 
        Domain name of the name server that responds authoritatively for the domain. 
    .PARAMETER Contact 
        Email address of the contact to whom domain issues can be addressed. In the email address, replace the @ sign with a period (.). For example, enter domainadmin.example.com instead of domainadmin@example.com. 
    .PARAMETER Serial 
        The secondary server uses this parameter to determine whether it requires a zone transfer from the primary server. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Refresh 
        Time, in seconds, for which a secondary server must wait between successive checks on the value of the serial number. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Retry 
        Time, in seconds, between retries if a secondary server's attempt to contact the primary server for a zone refresh fails. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Expire 
        Time, in seconds, after which the zone data on a secondary name server can no longer be considered authoritative because all refresh and retry attempts made during the period have failed. After the expiry period, the secondary server stops serving the zone. Typically one week. Not used by the primary server. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Minimum 
        Default time to live (TTL) for all records in the zone. Can be overridden for individual records. 
         
         
        Maximum value = 2147483647 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnssoarec item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnssoarec -domain <string>
        An example how to update dnssoarec config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnssoarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssoarec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Domain,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Originserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Contact,

        [double]$Serial,

        [double]$Refresh,

        [double]$Retry,

        [double]$Expire,

        [double]$Minimum,

        [double]$Ttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnssoarec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain }
            if ( $PSBoundParameters.ContainsKey('originserver') ) { $payload.Add('originserver', $originserver) }
            if ( $PSBoundParameters.ContainsKey('contact') ) { $payload.Add('contact', $contact) }
            if ( $PSBoundParameters.ContainsKey('serial') ) { $payload.Add('serial', $serial) }
            if ( $PSBoundParameters.ContainsKey('refresh') ) { $payload.Add('refresh', $refresh) }
            if ( $PSBoundParameters.ContainsKey('retry') ) { $payload.Add('retry', $retry) }
            if ( $PSBoundParameters.ContainsKey('expire') ) { $payload.Add('expire', $expire) }
            if ( $PSBoundParameters.ContainsKey('minimum') ) { $payload.Add('minimum', $minimum) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnssoarec", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnssoarec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnssoarec -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateDnssoarec: Finished"
    }
}

function Invoke-NSUnsetDnssoarec {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for SOA record resource.
    .PARAMETER Domain 
        Domain name for which to add the SOA record. 
    .PARAMETER Serial 
        The secondary server uses this parameter to determine whether it requires a zone transfer from the primary server. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Refresh 
        Time, in seconds, for which a secondary server must wait between successive checks on the value of the serial number. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Retry 
        Time, in seconds, between retries if a secondary server's attempt to contact the primary server for a zone refresh fails. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Expire 
        Time, in seconds, after which the zone data on a secondary name server can no longer be considered authoritative because all refresh and retry attempts made during the period have failed. After the expiry period, the secondary server stops serving the zone. Typically one week. Not used by the primary server. 
         
         
        Maximum value = 4294967294 
    .PARAMETER Minimum 
        Default time to live (TTL) for all records in the zone. Can be overridden for individual records. 
         
         
        Maximum value = 2147483647 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnssoarec -domain <string>
        An example how to unset dnssoarec config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnssoarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssoarec
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Domain,

        [Boolean]$serial,

        [Boolean]$refresh,

        [Boolean]$retry,

        [Boolean]$expire,

        [Boolean]$minimum,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnssoarec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain }
            if ( $PSBoundParameters.ContainsKey('serial') ) { $payload.Add('serial', $serial) }
            if ( $PSBoundParameters.ContainsKey('refresh') ) { $payload.Add('refresh', $refresh) }
            if ( $PSBoundParameters.ContainsKey('retry') ) { $payload.Add('retry', $retry) }
            if ( $PSBoundParameters.ContainsKey('expire') ) { $payload.Add('expire', $expire) }
            if ( $PSBoundParameters.ContainsKey('minimum') ) { $payload.Add('minimum', $minimum) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnssoarec -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnssoarec: Finished"
    }
}

function Invoke-NSGetDnssoarec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for SOA record resource.
    .PARAMETER Domain 
        Domain name for which to add the SOA record. 
    .PARAMETER GetAll 
        Retrieve all dnssoarec object(s).
    .PARAMETER Count
        If specified, the count of the dnssoarec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssoarec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnssoarec -GetAll 
        Get all dnssoarec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnssoarec -Count 
        Get the number of dnssoarec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssoarec -name <string>
        Get dnssoarec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssoarec -Filter @{ 'name'='<value>' }
        Get dnssoarec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnssoarec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssoarec/
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
        [string]$Domain,

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
        Write-Verbose "Invoke-NSGetDnssoarec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnssoarec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssoarec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssoarec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssoarec configuration for property 'domain'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnssoarec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnssoarec: Ended"
    }
}

function Invoke-NSAddDnssrvrec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for server record resource.
    .PARAMETER Domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER Target 
        Target host for the specified service. 
    .PARAMETER Priority 
        Integer specifying the priority of the target host. The lower the number, the higher the priority. If multiple target hosts have the same priority, selection is based on the Weight parameter. 
         
        Maximum value = 65535 
    .PARAMETER Weight 
        Weight for the target host. Aids host selection when two or more hosts have the same priority. A larger number indicates greater weight. 
         
        Maximum value = 65535 
    .PARAMETER Port 
        Port on which the target host listens for client requests. 
         
        Maximum value = 65535 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647
    .EXAMPLE
        PS C:\>Invoke-NSAddDnssrvrec -domain <string> -target <string> -priority <double> -weight <double> -port <double>
        An example how to add dnssrvrec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnssrvrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssrvrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Domain,

        [Parameter(Mandatory)]
        [string]$Target,

        [Parameter(Mandatory)]
        [double]$Priority,

        [Parameter(Mandatory)]
        [double]$Weight,

        [Parameter(Mandatory)]
        [double]$Port,

        [double]$Ttl = '3600' 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnssrvrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                target           = $target
                priority         = $priority
                weight           = $weight
                port             = $port
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnssrvrec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnssrvrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-NSAddDnssrvrec: Finished"
    }
}

function Invoke-NSDeleteDnssrvrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for server record resource.
    .PARAMETER Domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER Target 
        Target host for the specified service. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached SRV record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnssrvrec -Domain <string>
        An example how to delete dnssrvrec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnssrvrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssrvrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string]$Target,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnssrvrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Target') ) { $arguments.Add('target', $Target) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnssrvrec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnssrvrec: Finished"
    }
}

function Invoke-NSUpdateDnssrvrec {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for server record resource.
    .PARAMETER Domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER Target 
        Target host for the specified service. 
    .PARAMETER Priority 
        Integer specifying the priority of the target host. The lower the number, the higher the priority. If multiple target hosts have the same priority, selection is based on the Weight parameter. 
         
        Maximum value = 65535 
    .PARAMETER Weight 
        Weight for the target host. Aids host selection when two or more hosts have the same priority. A larger number indicates greater weight. 
         
        Maximum value = 65535 
    .PARAMETER Port 
        Port on which the target host listens for client requests. 
         
        Maximum value = 65535 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnssrvrec -domain <string> -target <string>
        An example how to update dnssrvrec config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnssrvrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssrvrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Domain,

        [Parameter(Mandatory)]
        [string]$Target,

        [double]$Priority,

        [double]$Weight,

        [double]$Port,

        [double]$Ttl 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnssrvrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                target           = $target
            }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnssrvrec", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnssrvrec -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateDnssrvrec: Finished"
    }
}

function Invoke-NSUnsetDnssrvrec {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for server record resource.
    .PARAMETER Domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER Target 
        Target host for the specified service. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnssrvrec -domain <string> -target <string>
        An example how to unset dnssrvrec config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnssrvrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssrvrec
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Domain,

        [string]$Target,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnssrvrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                target           = $target
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("$domain target", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnssrvrec -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnssrvrec: Finished"
    }
}

function Invoke-NSGetDnssrvrec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for server record resource.
    .PARAMETER Domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER Target 
        Target host for the specified service. 
    .PARAMETER Type 
        Type of records to display. Available settings function as follows: 
        * ADNS - Display all authoritative address records. 
        * PROXY - Display all proxy address records. 
        * ALL - Display all address records. 
        Possible values = ALL, ADNS, PROXY 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all dnssrvrec object(s).
    .PARAMETER Count
        If specified, the count of the dnssrvrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssrvrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnssrvrec -GetAll 
        Get all dnssrvrec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnssrvrec -Count 
        Get the number of dnssrvrec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssrvrec -name <string>
        Get dnssrvrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssrvrec -Filter @{ 'name'='<value>' }
        Get dnssrvrec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnssrvrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssrvrec/
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
        [string]$Domain,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Target,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ALL', 'ADNS', 'PROXY')]
        [string]$Type,

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
        Write-Verbose "Invoke-NSGetDnssrvrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnssrvrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssrvrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssrvrec objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('domain') ) { $arguments.Add('domain', $domain) } 
                if ( $PSBoundParameters.ContainsKey('target') ) { $arguments.Add('target', $target) } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssrvrec configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnssrvrec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnssrvrec: Ended"
    }
}

function Invoke-NSFlushDnssubnetcache {
    <#
    .SYNOPSIS
        Flush Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for subnet cache resource.
    .PARAMETER Ecssubnet 
        ECS Subnet. 
    .PARAMETER All 
        Flush all the ECS subnets from the DNS cache.
    .EXAMPLE
        PS C:\>Invoke-NSFlushDnssubnetcache 
        An example how to flush dnssubnetcache config Object(s).
    .NOTES
        File Name : Invoke-NSFlushDnssubnetcache
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssubnetcache/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Ecssubnet,

        [boolean]$All 

    )
    begin {
        Write-Verbose "Invoke-NSFlushDnssubnetcache: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ecssubnet') ) { $payload.Add('ecssubnet', $ecssubnet) }
            if ( $PSBoundParameters.ContainsKey('all') ) { $payload.Add('all', $all) }
            if ( $PSCmdlet.ShouldProcess($Name, "Flush Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnssubnetcache -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSFlushDnssubnetcache: Finished"
    }
}

function Invoke-NSGetDnssubnetcache {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for subnet cache resource.
    .PARAMETER Ecssubnet 
        ECS Subnet. 
    .PARAMETER GetAll 
        Retrieve all dnssubnetcache object(s).
    .PARAMETER Count
        If specified, the count of the dnssubnetcache object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssubnetcache
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnssubnetcache -GetAll 
        Get all dnssubnetcache data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnssubnetcache -Count 
        Get the number of dnssubnetcache objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssubnetcache -name <string>
        Get dnssubnetcache object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssubnetcache -Filter @{ 'name'='<value>' }
        Get dnssubnetcache data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnssubnetcache
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssubnetcache/
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
        [string]$Ecssubnet,

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
        Write-Verbose "Invoke-NSGetDnssubnetcache: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnssubnetcache objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssubnetcache objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssubnetcache objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssubnetcache configuration for property 'ecssubnet'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Resource $ecssubnet -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnssubnetcache configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnssubnetcache: Ended"
    }
}

function Invoke-NSAddDnssuffix {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS suffix resource.
    .PARAMETER Dnssuffix 
        Suffix to be appended when resolving domain names that are not fully qualified. 
    .PARAMETER PassThru 
        Return details about the created dnssuffix item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnssuffix -Dnssuffix <string>
        An example how to add dnssuffix config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnssuffix
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssuffix/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Dnssuffix,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnssuffix: Starting"
    }
    process {
        try {
            $payload = @{ Dnssuffix = $Dnssuffix }

            if ( $PSCmdlet.ShouldProcess("dnssuffix", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnssuffix -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnssuffix -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnssuffix: Finished"
    }
}

function Invoke-NSDeleteDnssuffix {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS suffix resource.
    .PARAMETER Dnssuffix 
        Suffix to be appended when resolving domain names that are not fully qualified.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnssuffix -Dnssuffix <string>
        An example how to delete dnssuffix config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnssuffix
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssuffix/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Dnssuffix 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnssuffix: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$Dnssuffix", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnssuffix -NitroPath nitro/v1/config -Resource $Dnssuffix -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnssuffix: Finished"
    }
}

function Invoke-NSGetDnssuffix {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for DNS suffix resource.
    .PARAMETER Dnssuffix 
        Suffix to be appended when resolving domain names that are not fully qualified. 
    .PARAMETER GetAll 
        Retrieve all dnssuffix object(s).
    .PARAMETER Count
        If specified, the count of the dnssuffix object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssuffix
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnssuffix -GetAll 
        Get all dnssuffix data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnssuffix -Count 
        Get the number of dnssuffix objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssuffix -name <string>
        Get dnssuffix object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnssuffix -Filter @{ 'name'='<value>' }
        Get dnssuffix data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnssuffix
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnssuffix/
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
        [string]$Dnssuffix,

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
        Write-Verbose "Invoke-NSGetDnssuffix: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnssuffix objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssuffix objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssuffix objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssuffix configuration for property 'Dnssuffix'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Resource $Dnssuffix -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnssuffix configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnssuffix: Ended"
    }
}

function Invoke-NSAddDnstxtrec {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for TXT record resource.
    .PARAMETER Domain 
        Name of the domain for the TXT record. 
    .PARAMETER String 
        Information to store in the TXT resource record. Enclose the string in single or double quotation marks. A TXT resource record can contain up to six strings, each of which can contain up to 255 characters. If you want to add a string of more than 255 characters, evaluate whether splitting it into two or more smaller strings, subject to the six-string limit, works for you. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
         
         
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnstxtrec item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnstxtrec -domain <string> -String <string[]>
        An example how to add dnstxtrec config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnstxtrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnstxtrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Domain,

        [Parameter(Mandatory)]
        [string[]]$String,

        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnstxtrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                String           = $String
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnstxtrec", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnstxtrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnstxtrec -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnstxtrec: Finished"
    }
}

function Invoke-NSDeleteDnstxtrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for TXT record resource.
    .PARAMETER Domain 
        Name of the domain for the TXT record. 
    .PARAMETER String 
        Information to store in the TXT resource record. Enclose the string in single or double quotation marks. A TXT resource record can contain up to six strings, each of which can contain up to 255 characters. If you want to add a string of more than 255 characters, evaluate whether splitting it into two or more smaller strings, subject to the six-string limit, works for you. 
    .PARAMETER Recordid 
        Unique, internally generated record ID. View the details of the TXT record to obtain its record ID. Mutually exclusive with the string parameter. 
         
        Maximum value = 65535 
    .PARAMETER Ecssubnet 
        Subnet for which the cached TXT record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnstxtrec -Domain <string>
        An example how to delete dnstxtrec config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnstxtrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnstxtrec/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string[]]$String,

        [double]$Recordid,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnstxtrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('String') ) { $arguments.Add('String', $String) }
            if ( $PSBoundParameters.ContainsKey('Recordid') ) { $arguments.Add('recordid', $Recordid) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnstxtrec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnstxtrec: Finished"
    }
}

function Invoke-NSGetDnstxtrec {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for TXT record resource.
    .PARAMETER Domain 
        Name of the domain for the TXT record. 
    .PARAMETER GetAll 
        Retrieve all dnstxtrec object(s).
    .PARAMETER Count
        If specified, the count of the dnstxtrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnstxtrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnstxtrec -GetAll 
        Get all dnstxtrec data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnstxtrec -Count 
        Get the number of dnstxtrec objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnstxtrec -name <string>
        Get dnstxtrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnstxtrec -Filter @{ 'name'='<value>' }
        Get dnstxtrec data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnstxtrec
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnstxtrec/
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
        [string]$Domain,

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
        Write-Verbose "Invoke-NSGetDnstxtrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnstxtrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnstxtrec objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnstxtrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnstxtrec configuration for property 'domain'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnstxtrec configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnstxtrec: Ended"
    }
}

function Invoke-NSAddDnsview {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS view resource.
    .PARAMETER Viewname 
        Name for the DNS view. 
    .PARAMETER PassThru 
        Return details about the created dnsview item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnsview -viewname <string>
        An example how to add dnsview config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnsview
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsview/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Viewname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnsview: Starting"
    }
    process {
        try {
            $payload = @{ viewname = $viewname }

            if ( $PSCmdlet.ShouldProcess("dnsview", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnsview -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnsview -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnsview: Finished"
    }
}

function Invoke-NSDeleteDnsview {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS view resource.
    .PARAMETER Viewname 
        Name for the DNS view.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnsview -Viewname <string>
        An example how to delete dnsview config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnsview
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsview/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Viewname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnsview: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$viewname", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnsview -NitroPath nitro/v1/config -Resource $viewname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnsview: Finished"
    }
}

function Invoke-NSGetDnsview {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for DNS view resource.
    .PARAMETER Viewname 
        Name for the DNS view. 
    .PARAMETER GetAll 
        Retrieve all dnsview object(s).
    .PARAMETER Count
        If specified, the count of the dnsview object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsview
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsview -GetAll 
        Get all dnsview data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsview -Count 
        Get the number of dnsview objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsview -name <string>
        Get dnsview object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsview -Filter @{ 'name'='<value>' }
        Get dnsview data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsview
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsview/
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
        [string]$Viewname,

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
        Write-Verbose "Invoke-NSGetDnsview: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsview objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview configuration for property 'viewname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsview: Ended"
    }
}

function Invoke-NSGetDnsviewBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnsview.
    .PARAMETER Viewname 
        Name of the view to display. 
    .PARAMETER GetAll 
        Retrieve all dnsview_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnsview_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsviewBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsviewBinding -GetAll 
        Get all dnsview_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsviewBinding -name <string>
        Get dnsview_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsviewBinding -Filter @{ 'name'='<value>' }
        Get dnsview_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsviewBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsview_binding/
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
        [string]$Viewname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetDnsviewBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnsview_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview_binding configuration for property 'viewname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsviewBinding: Ended"
    }
}

function Invoke-NSGetDnsviewDnspolicyBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnsview.
    .PARAMETER Viewname 
        Name of the view to display. 
    .PARAMETER GetAll 
        Retrieve all dnsview_dnspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnsview_dnspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsviewDnspolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsviewDnspolicyBinding -GetAll 
        Get all dnsview_dnspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsviewDnspolicyBinding -Count 
        Get the number of dnsview_dnspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsviewDnspolicyBinding -name <string>
        Get dnsview_dnspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsviewDnspolicyBinding -Filter @{ 'name'='<value>' }
        Get dnsview_dnspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsviewDnspolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsview_dnspolicy_binding/
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
        [string]$Viewname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetDnsviewDnspolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnsview_dnspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview_dnspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview_dnspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview_dnspolicy_binding configuration for property 'viewname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview_dnspolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsviewDnspolicyBinding: Ended"
    }
}

function Invoke-NSGetDnsviewGslbserviceBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to dnsview.
    .PARAMETER Viewname 
        Name of the view to display. 
    .PARAMETER GetAll 
        Retrieve all dnsview_gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnsview_gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsviewGslbserviceBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsviewGslbserviceBinding -GetAll 
        Get all dnsview_gslbservice_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnsviewGslbserviceBinding -Count 
        Get the number of dnsview_gslbservice_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsviewGslbserviceBinding -name <string>
        Get dnsview_gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnsviewGslbserviceBinding -Filter @{ 'name'='<value>' }
        Get dnsview_gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnsviewGslbserviceBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnsview_gslbservice_binding/
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
        [string]$Viewname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetDnsviewGslbserviceBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnsview_gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview_gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview_gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview_gslbservice_binding configuration for property 'viewname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview_gslbservice_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnsviewGslbserviceBinding: Ended"
    }
}

function Invoke-NSAddDnszone {
    <#
    .SYNOPSIS
        Add Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER Proxymode 
        Deploy the zone in proxy mode. Enable in the following scenarios: 
        * The load balanced DNS servers are authoritative for the zone and all resource records that are part of the zone. 
        * The load balanced DNS servers are authoritative for the zone, but the Citrix ADC owns a subset of the resource records that belong to the zone (partial zone ownership configuration). Typically seen in global server load balancing (GSLB) configurations, in which the appliance responds authoritatively to queries for GSLB domain names but forwards queries for other domain names in the zone to the load balanced servers. 
        In either scenario, do not create the zone's Start of Authority (SOA) and name server (NS) resource records on the appliance. 
        Disable if the appliance is authoritative for the zone, but make sure that you have created the SOA and NS records on the appliance before you create the zone. 
         
        Possible values = YES, NO 
    .PARAMETER Dnssecoffload 
        Enable dnssec offload for this zone. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nsec 
        Enable nsec generation for dnssec offload. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnszone item.
    .EXAMPLE
        PS C:\>Invoke-NSAddDnszone -zonename <string> -proxymode <string>
        An example how to add dnszone config Object(s).
    .NOTES
        File Name : Invoke-NSAddDnszone
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Zonename,

        [Parameter(Mandatory)]
        [ValidateSet('YES', 'NO')]
        [string]$Proxymode = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnssecoffload = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Nsec = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddDnszone: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename
                proxymode          = $proxymode
            }
            if ( $PSBoundParameters.ContainsKey('dnssecoffload') ) { $payload.Add('dnssecoffload', $dnssecoffload) }
            if ( $PSBoundParameters.ContainsKey('nsec') ) { $payload.Add('nsec', $nsec) }
            if ( $PSCmdlet.ShouldProcess("dnszone", "Add Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnszone -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnszone -Filter $payload)
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
        Write-Verbose "Invoke-NSAddDnszone: Finished"
    }
}

function Invoke-NSUpdateDnszone {
    <#
    .SYNOPSIS
        Update Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER Proxymode 
        Deploy the zone in proxy mode. Enable in the following scenarios: 
        * The load balanced DNS servers are authoritative for the zone and all resource records that are part of the zone. 
        * The load balanced DNS servers are authoritative for the zone, but the Citrix ADC owns a subset of the resource records that belong to the zone (partial zone ownership configuration). Typically seen in global server load balancing (GSLB) configurations, in which the appliance responds authoritatively to queries for GSLB domain names but forwards queries for other domain names in the zone to the load balanced servers. 
        In either scenario, do not create the zone's Start of Authority (SOA) and name server (NS) resource records on the appliance. 
        Disable if the appliance is authoritative for the zone, but make sure that you have created the SOA and NS records on the appliance before you create the zone. 
         
        Possible values = YES, NO 
    .PARAMETER Dnssecoffload 
        Enable dnssec offload for this zone. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nsec 
        Enable nsec generation for dnssec offload. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnszone item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateDnszone -zonename <string>
        An example how to update dnszone config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateDnszone
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Zonename,

        [ValidateSet('YES', 'NO')]
        [string]$Proxymode,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnssecoffload,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Nsec,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateDnszone: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename }
            if ( $PSBoundParameters.ContainsKey('proxymode') ) { $payload.Add('proxymode', $proxymode) }
            if ( $PSBoundParameters.ContainsKey('dnssecoffload') ) { $payload.Add('dnssecoffload', $dnssecoffload) }
            if ( $PSBoundParameters.ContainsKey('nsec') ) { $payload.Add('nsec', $nsec) }
            if ( $PSCmdlet.ShouldProcess("dnszone", "Update Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type dnszone -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetDnszone -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateDnszone: Finished"
    }
}

function Invoke-NSUnsetDnszone {
    <#
    .SYNOPSIS
        Unset Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER Proxymode 
        Deploy the zone in proxy mode. Enable in the following scenarios: 
        * The load balanced DNS servers are authoritative for the zone and all resource records that are part of the zone. 
        * The load balanced DNS servers are authoritative for the zone, but the Citrix ADC owns a subset of the resource records that belong to the zone (partial zone ownership configuration). Typically seen in global server load balancing (GSLB) configurations, in which the appliance responds authoritatively to queries for GSLB domain names but forwards queries for other domain names in the zone to the load balanced servers. 
        In either scenario, do not create the zone's Start of Authority (SOA) and name server (NS) resource records on the appliance. 
        Disable if the appliance is authoritative for the zone, but make sure that you have created the SOA and NS records on the appliance before you create the zone. 
         
        Possible values = YES, NO 
    .PARAMETER Dnssecoffload 
        Enable dnssec offload for this zone. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nsec 
        Enable nsec generation for dnssec offload. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetDnszone -zonename <string>
        An example how to unset dnszone config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetDnszone
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnszone
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Zonename,

        [Boolean]$proxymode,

        [Boolean]$dnssecoffload,

        [Boolean]$nsec 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetDnszone: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename }
            if ( $PSBoundParameters.ContainsKey('proxymode') ) { $payload.Add('proxymode', $proxymode) }
            if ( $PSBoundParameters.ContainsKey('dnssecoffload') ) { $payload.Add('dnssecoffload', $dnssecoffload) }
            if ( $PSBoundParameters.ContainsKey('nsec') ) { $payload.Add('nsec', $nsec) }
            if ( $PSCmdlet.ShouldProcess("$zonename", "Unset Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type dnszone -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetDnszone: Finished"
    }
}

function Invoke-NSDeleteDnszone {
    <#
    .SYNOPSIS
        Delete Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteDnszone -Zonename <string>
        An example how to delete dnszone config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteDnszone
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Zonename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteDnszone: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$zonename", "Delete Domain Name Service(DNS) configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type dnszone -NitroPath nitro/v1/config -Resource $zonename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteDnszone: Finished"
    }
}

function Invoke-NSSignDnszone {
    <#
    .SYNOPSIS
        Sign Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER Keyname 
        Name of the public/private DNS key pair with which to sign the zone. You can sign a zone with up to four keys.
    .EXAMPLE
        PS C:\>Invoke-NSSignDnszone -zonename <string>
        An example how to sign dnszone config Object(s).
    .NOTES
        File Name : Invoke-NSSignDnszone
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Zonename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Keyname 

    )
    begin {
        Write-Verbose "Invoke-NSSignDnszone: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename }
            if ( $PSBoundParameters.ContainsKey('keyname') ) { $payload.Add('keyname', $keyname) }
            if ( $PSCmdlet.ShouldProcess($Name, "Sign Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnszone -Action sign -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSSignDnszone: Finished"
    }
}

function Invoke-NSUnsignDnszone {
    <#
    .SYNOPSIS
        Unsign Domain Name Service(DNS) configuration. config Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER Keyname 
        Name of the public/private DNS key pair with which to sign the zone. You can sign a zone with up to four keys.
    .EXAMPLE
        PS C:\>Invoke-NSUnsignDnszone -zonename <string>
        An example how to unsign dnszone config Object(s).
    .NOTES
        File Name : Invoke-NSUnsignDnszone
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Zonename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Keyname 

    )
    begin {
        Write-Verbose "Invoke-NSUnsignDnszone: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename }
            if ( $PSBoundParameters.ContainsKey('keyname') ) { $payload.Add('keyname', $keyname) }
            if ( $PSCmdlet.ShouldProcess($Name, "Unsign Domain Name Service(DNS) configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dnszone -Action unsign -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsignDnszone: Finished"
    }
}

function Invoke-NSGetDnszone {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER GetAll 
        Retrieve all dnszone object(s).
    .PARAMETER Count
        If specified, the count of the dnszone object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszone
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnszone -GetAll 
        Get all dnszone data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnszone -Count 
        Get the number of dnszone objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszone -name <string>
        Get dnszone object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszone -Filter @{ 'name'='<value>' }
        Get dnszone data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnszone
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnszone/
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
        [string]$Zonename,

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
        Write-Verbose "Invoke-NSGetDnszone: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnszone objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone configuration for property 'zonename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnszone: Ended"
    }
}

function Invoke-NSGetDnszoneBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnszone.
    .PARAMETER Zonename 
        Name of the zone. Mutually exclusive with the type parameter. 
    .PARAMETER GetAll 
        Retrieve all dnszone_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnszone_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszoneBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnszoneBinding -GetAll 
        Get all dnszone_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszoneBinding -name <string>
        Get dnszone_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszoneBinding -Filter @{ 'name'='<value>' }
        Get dnszone_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnszoneBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnszone_binding/
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
        [string]$Zonename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetDnszoneBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnszone_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone_binding configuration for property 'zonename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnszoneBinding: Ended"
    }
}

function Invoke-NSGetDnszoneDnskeyBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object showing the dnskey that can be bound to dnszone.
    .PARAMETER Zonename 
        Name of the zone. Mutually exclusive with the type parameter. 
    .PARAMETER GetAll 
        Retrieve all dnszone_dnskey_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnszone_dnskey_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszoneDnskeyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnszoneDnskeyBinding -GetAll 
        Get all dnszone_dnskey_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnszoneDnskeyBinding -Count 
        Get the number of dnszone_dnskey_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszoneDnskeyBinding -name <string>
        Get dnszone_dnskey_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszoneDnskeyBinding -Filter @{ 'name'='<value>' }
        Get dnszone_dnskey_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnszoneDnskeyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnszone_dnskey_binding/
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
        [string]$Zonename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetDnszoneDnskeyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnszone_dnskey_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone_dnskey_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone_dnskey_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone_dnskey_binding configuration for property 'zonename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone_dnskey_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnszoneDnskeyBinding: Ended"
    }
}

function Invoke-NSGetDnszoneDomainBinding {
    <#
    .SYNOPSIS
        Get Domain Name Service(DNS) configuration. config object(s).
    .DESCRIPTION
        Binding object showing the domain that can be bound to dnszone.
    .PARAMETER Zonename 
        Name of the zone. Mutually exclusive with the type parameter. 
    .PARAMETER GetAll 
        Retrieve all dnszone_domain_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnszone_domain_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszoneDomainBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnszoneDomainBinding -GetAll 
        Get all dnszone_domain_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetDnszoneDomainBinding -Count 
        Get the number of dnszone_domain_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszoneDomainBinding -name <string>
        Get dnszone_domain_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetDnszoneDomainBinding -Filter @{ 'name'='<value>' }
        Get dnszone_domain_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetDnszoneDomainBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/dns/dnszone_domain_binding/
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
        [string]$Zonename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetDnszoneDomainBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnszone_domain_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone_domain_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone_domain_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone_domain_binding configuration for property 'zonename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone_domain_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetDnszoneDomainBinding: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAnK1DRKbB592eB
# +5sL+iQucMEPvUXpgyG0ih18kJAHB6CCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgPWEm6MjpFm/H9UBs8ZHG2VNdfFAdkG3AHytHNtXYSLUwDQYJKoZIhvcNAQEB
# BQAEggEAButTJE2KYB0jFo/uICDq2Ky5rRVogEQ0npbEA0LGZur5boI72hdfEjbM
# ttS4fSWpWTGioeyhnMmDuGi6uPOhas51M8WnOKV1AVoQdxta9LPnZuVNs4+JAmt1
# mVkXMJs8nlQ6kSTAHwE38vdXFJncNMCeMH3zLQ6ZPRgIFcPxVjLd4MhwC9G1BvjD
# xmoTqwYErQmGJjZOWcXU9SRj4337pJWhzV4Qpnu5YY/rMocRs62nXGeXmcPCCsAT
# RH6HTFlhcKEjBXVNUn92tbs/2kac1ETO8xojvt7V5xCLp/yx12cfBwpHdLvq60pA
# LCaUXecDy6BEKVJXCvf50IoZNDuGAQ==
# SIG # End signature block
