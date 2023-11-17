function Invoke-NSUpdateCallhome {
    <#
    .SYNOPSIS
        Update Utilities. config Object.
    .DESCRIPTION
        Configuration for callhome resource.
    .PARAMETER Mode 
        CallHome mode of operation. 
         
        Possible values = Default, CSP 
    .PARAMETER Emailaddress 
        Email address of the contact administrator. 
    .PARAMETER Hbcustominterval 
        Interval (in days) between CallHome heartbeats. 
         
         
        Maximum value = 30 
    .PARAMETER Proxymode 
        Enables or disables the proxy mode. The proxy server can be set by either specifying the IP address of the server or the name of the service representing the proxy server. 
         
        Possible values = YES, NO 
    .PARAMETER Ipaddress 
        IP address of the proxy server. 
    .PARAMETER Proxyauthservice 
        Name of the service that represents the proxy server. 
    .PARAMETER Port 
        HTTP port on the Proxy server. This is a mandatory parameter for both IP address and service name based configuration.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCallhome 
        An example how to update callhome config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCallhome
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/utility/callhome/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateSet('Default', 'CSP')]
        [string]$Mode,

        [string]$Emailaddress,

        [double]$Hbcustominterval,

        [ValidateSet('YES', 'NO')]
        [string]$Proxymode,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipaddress,

        [string]$Proxyauthservice,

        [ValidateRange(1, 65535)]
        [int]$Port 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCallhome: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('mode') ) { $payload.Add('mode', $mode) }
            if ( $PSBoundParameters.ContainsKey('emailaddress') ) { $payload.Add('emailaddress', $emailaddress) }
            if ( $PSBoundParameters.ContainsKey('hbcustominterval') ) { $payload.Add('hbcustominterval', $hbcustominterval) }
            if ( $PSBoundParameters.ContainsKey('proxymode') ) { $payload.Add('proxymode', $proxymode) }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('proxyauthservice') ) { $payload.Add('proxyauthservice', $proxyauthservice) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSCmdlet.ShouldProcess("callhome", "Update Utilities. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type callhome -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateCallhome: Finished"
    }
}

function Invoke-NSUnsetCallhome {
    <#
    .SYNOPSIS
        Unset Utilities. config Object.
    .DESCRIPTION
        Configuration for callhome resource.
    .PARAMETER Mode 
        CallHome mode of operation. 
         
        Possible values = Default, CSP 
    .PARAMETER Emailaddress 
        Email address of the contact administrator. 
    .PARAMETER Hbcustominterval 
        Interval (in days) between CallHome heartbeats. 
         
         
        Maximum value = 30 
    .PARAMETER Proxymode 
        Enables or disables the proxy mode. The proxy server can be set by either specifying the IP address of the server or the name of the service representing the proxy server. 
         
        Possible values = YES, NO 
    .PARAMETER Ipaddress 
        IP address of the proxy server. 
    .PARAMETER Proxyauthservice 
        Name of the service that represents the proxy server. 
    .PARAMETER Port 
        HTTP port on the Proxy server. This is a mandatory parameter for both IP address and service name based configuration.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCallhome 
        An example how to unset callhome config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCallhome
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/utility/callhome
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$mode,

        [Boolean]$emailaddress,

        [Boolean]$hbcustominterval,

        [Boolean]$proxymode,

        [Boolean]$ipaddress,

        [Boolean]$proxyauthservice,

        [Boolean]$port 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCallhome: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('mode') ) { $payload.Add('mode', $mode) }
            if ( $PSBoundParameters.ContainsKey('emailaddress') ) { $payload.Add('emailaddress', $emailaddress) }
            if ( $PSBoundParameters.ContainsKey('hbcustominterval') ) { $payload.Add('hbcustominterval', $hbcustominterval) }
            if ( $PSBoundParameters.ContainsKey('proxymode') ) { $payload.Add('proxymode', $proxymode) }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('proxyauthservice') ) { $payload.Add('proxyauthservice', $proxyauthservice) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSCmdlet.ShouldProcess("callhome", "Unset Utilities. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type callhome -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCallhome: Finished"
    }
}

function Invoke-NSGetCallhome {
    <#
    .SYNOPSIS
        Get Utilities. config object(s).
    .DESCRIPTION
        Configuration for callhome resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all callhome object(s).
    .PARAMETER Count
        If specified, the count of the callhome object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCallhome
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCallhome -GetAll 
        Get all callhome data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCallhome -name <string>
        Get callhome object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCallhome -Filter @{ 'name'='<value>' }
        Get callhome data with a filter.
    .NOTES
        File Name : Invoke-NSGetCallhome
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/utility/callhome/
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
        [double]$Nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCallhome: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all callhome objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type callhome -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for callhome objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type callhome -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving callhome objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type callhome -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving callhome configuration for property ''"

            } else {
                Write-Verbose "Retrieving callhome configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type callhome -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCallhome: Ended"
    }
}

function Invoke-NSInstall {
    <#
    .SYNOPSIS
        Install Utilities. config Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Url 
        Url for the build file. Must be in the following formats: 
        http://[user]:[password]@host/path/to/file 
        https://[user]:[password]@host/path/to/file 
        sftp://[user]:[password]@host/path/to/file 
        scp://[user]:[password]@host/path/to/file 
        ftp://[user]:[password]@host/path/to/file 
        file://path/to/file. 
    .PARAMETER Y 
        Do not prompt for yes/no before rebooting. 
    .PARAMETER L 
        Use this flag to enable callhome. 
    .PARAMETER A 
        Use this flag to enable Citrix ADM Service Connect. This feature helps you discover your Citrix ADC instances effortlessly on Citrix ADM service and get insights and curated machine learning based recommendations for applications and Citrix ADC infrastructure. This feature lets the Citrix ADC instance automatically send system, usage and telemetry data to Citrix ADM service. View here [https://docs.citrix.com/en-us/citrix-adc/13/data-governance.html] to learn more about this feature. Use of this feature is subject to the Citrix End User ServiceAgreement. View here [https://www.citrix.com/buy/licensing/agreements.html]. 
    .PARAMETER Enhancedupgrade 
        Use this flag for upgrading from/to enhancement mode. 
    .PARAMETER Resizeswapvar 
        Use this flag to change swap size on ONLY 64bit nCore/MCNS/VMPE systems NON-VPX systems. 
    .PARAMETER Async 
        Use this flag to return the install id when the nitro api request is sent. 
        The id can be used later to track the installation progress via show ns job &lt;id&gt; command. 
        For the cli request of install the flag is by default set as false as the installation progress details can be tracked via cli.
    .EXAMPLE
        PS C:\>Invoke-NSInstall -url <string>
        An example how to install install config Object(s).
    .NOTES
        File Name : Invoke-NSInstall
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/utility/install/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Url,

        [boolean]$Y,

        [boolean]$L,

        [boolean]$A,

        [boolean]$Enhancedupgrade,

        [boolean]$Resizeswapvar,

        [boolean]$Async 

    )
    begin {
        Write-Verbose "Invoke-NSInstall: Starting"
    }
    process {
        try {
            $payload = @{ url = $url }
            if ( $PSBoundParameters.ContainsKey('y') ) { $payload.Add('y', $y) }
            if ( $PSBoundParameters.ContainsKey('l') ) { $payload.Add('l', $l) }
            if ( $PSBoundParameters.ContainsKey('a') ) { $payload.Add('a', $a) }
            if ( $PSBoundParameters.ContainsKey('enhancedupgrade') ) { $payload.Add('enhancedupgrade', $enhancedupgrade) }
            if ( $PSBoundParameters.ContainsKey('resizeswapvar') ) { $payload.Add('resizeswapvar', $resizeswapvar) }
            if ( $PSBoundParameters.ContainsKey('async') ) { $payload.Add('async', $async) }
            if ( $PSCmdlet.ShouldProcess($Name, "Install Utilities. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type install -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSInstall: Finished"
    }
}

function Invoke-NSGetRaid {
    <#
    .SYNOPSIS
        Get Utilities. config object(s).
    .DESCRIPTION
        Configuration for raid support resource.
    .PARAMETER GetAll 
        Retrieve all raid object(s).
    .PARAMETER Count
        If specified, the count of the raid object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetRaid
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetRaid -GetAll 
        Get all raid data.
    .EXAMPLE
        PS C:\>Invoke-NSGetRaid -name <string>
        Get raid object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetRaid -Filter @{ 'name'='<value>' }
        Get raid data with a filter.
    .NOTES
        File Name : Invoke-NSGetRaid
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/utility/raid/
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
        Write-Verbose "Invoke-NSGetRaid: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all raid objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type raid -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for raid objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type raid -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving raid objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type raid -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving raid configuration for property ''"

            } else {
                Write-Verbose "Retrieving raid configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type raid -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetRaid: Ended"
    }
}

function Invoke-NSGetTechsupport {
    <#
    .SYNOPSIS
        Get Utilities. config object(s).
    .DESCRIPTION
        Configuration for tech support resource.
    .PARAMETER Scope 
        Use this option to gather data on the present node, all cluster nodes, or for the specified partitions. The CLUSTER scope generates smaller abbreviated archives for all nodes. The PARTITION scope collects the admin partition in addition to those specified. The partitionName option is only required for the PARTITION scope. 
         
        Possible values = NODE, CLUSTER, PARTITION 
    .PARAMETER Partitionname 
        Name of the partition. 
    .PARAMETER Upload 
        Securely upload the collector archive to Citrix Technical Support using SSL. MyCitrix credentials will be required. If used with the -file option, no new collector archive is generated. Instead, the specified archive is uploaded. Note that the upload operation time depends on the size of the archive file, and the connection bandwidth. 
    .PARAMETER Proxy 
        Specifies the proxy server to be used when uploading a collector archive. Use this parameter if the Citrix ADC does not have direct internet connectivity. The basic format of the proxy string is: "proxy_IP:&lt;proxy_port&gt;" (without quotes). If the proxy requires authentication the format is: "username:password@proxy_IP:&lt;proxy_port&gt;". 
    .PARAMETER Casenumber 
        Specifies the associated case or service request number if it has already been opened with Citrix Technical Support. 
    .PARAMETER File 
        Specifies the name (with full path) of the collector archive file to be uploaded. If this is specified, no new collector archive is generated. 
    .PARAMETER Description 
        Provides a text description for the the upload, and can be used for logging purposes. 
    .PARAMETER Authtoken 
        Specifies the Authentication Token, which is used to login to Citrix upload server. Please copy/paste the URL https://cis.citrix.com/auth/api/create_identity_v2/?expiration=3600 in a browser to complete the two factor authentication and generate it. The token is valid for 3600 seconds (1 hour). 
    .PARAMETER Time 
        Specifies the time in common log format, ie. DD/MMM/YYYY:HH:MM:SS, to be used for locating the newnslog file. With this option at most four newnslog log files are collected. First is the newnslog file, spanning the given time. Second is the one, created just prior to the first (if it exists). Third is the one, created just later than the first (if it exists). And the fourth is the latest newnslog directory. In case, the scope is cluster, then second and third type is skipped on all nodes. 
    .PARAMETER Adss 
        Option for collecting showtechsupport bundle on ADSS cluster/node. 
    .PARAMETER Nodes 
        Use this option to collect showtechsupport bundle only from the nodes given as a list to this option. If -file option is used, it will collect the files from the given nodes back to the cco and will upload the compressed folder containing the files from there. 
         
        Maximum value = 255 
    .PARAMETER GetAll 
        Retrieve all techsupport object(s).
    .PARAMETER Count
        If specified, the count of the techsupport object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTechsupport
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTechsupport -GetAll 
        Get all techsupport data.
    .EXAMPLE
        PS C:\>Invoke-NSGetTechsupport -name <string>
        Get techsupport object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTechsupport -Filter @{ 'name'='<value>' }
        Get techsupport data with a filter.
    .NOTES
        File Name : Invoke-NSGetTechsupport
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/utility/techsupport/
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
        [ValidateSet('NODE', 'CLUSTER', 'PARTITION')]
        [string]$Scope,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Partitionname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [boolean]$Upload,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Proxy,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Casenumber,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$File,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Description,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Authtoken,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateLength(20, 20)]
        [string]$Time,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [boolean]$Adss,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double[]]$Nodes,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetTechsupport: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all techsupport objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for techsupport objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving techsupport objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('scope') ) { $arguments.Add('scope', $scope) } 
                if ( $PSBoundParameters.ContainsKey('partitionname') ) { $arguments.Add('partitionname', $partitionname) } 
                if ( $PSBoundParameters.ContainsKey('upload') ) { $arguments.Add('upload', $upload) } 
                if ( $PSBoundParameters.ContainsKey('proxy') ) { $arguments.Add('proxy', $proxy) } 
                if ( $PSBoundParameters.ContainsKey('casenumber') ) { $arguments.Add('casenumber', $casenumber) } 
                if ( $PSBoundParameters.ContainsKey('file') ) { $arguments.Add('file', $file) } 
                if ( $PSBoundParameters.ContainsKey('description') ) { $arguments.Add('description', $description) } 
                if ( $PSBoundParameters.ContainsKey('authtoken') ) { $arguments.Add('authtoken', $authtoken) } 
                if ( $PSBoundParameters.ContainsKey('time') ) { $arguments.Add('time', $time) } 
                if ( $PSBoundParameters.ContainsKey('adss') ) { $arguments.Add('adss', $adss) } 
                if ( $PSBoundParameters.ContainsKey('nodes') ) { $arguments.Add('nodes', $nodes) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving techsupport configuration for property ''"

            } else {
                Write-Verbose "Retrieving techsupport configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTechsupport: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAlhG640WLPh+fv
# 9NGTsoLJVykGe8c3BsRiA2RDEqy/haCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgVgdat86enfU7L86ywj/bplPbOtxAyEiw4S9402JrTq0wDQYJKoZIhvcNAQEB
# BQAEggEANKSerf1IN6Vy4Zv+4P40wcEHTvt++iVZW52nT9OxFV4wYzd5U6pLf8Ub
# d6TknTZgEndw5Pb4f10V/6TEL5zktzCBUcDIzyQPX7mqdX9DpcnQt7C6wxtHlGl4
# qpeV1MNQ1tQpfWhBuV8/DnQsomZ5eApprxx53eZwVcKUhxfOIP8zXisYyaUvKKSD
# NcubdcMh8/gnm6leWiglG1WEl48XGjgdXYv+4Ft1e9LM+mBNofdgbmTLi+FRuHG+
# m9k0Via9Qx/W9xw2K3+JcvKkwlWHC7lJmVQ4m5FOs5mR+77S156+UizxN67FMnNd
# zJ7j9J4C1m+c1hqmbTd7o1+D9/n8sw==
# SIG # End signature block
