function Invoke-NSSyncGslbconfig {
    <#
    .SYNOPSIS
        Sync Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for gslb config resource.
    .PARAMETER Preview 
        Do not synchronize the GSLB sites, but display the commands that would be applied on the slave node upon synchronization. Mutually exclusive with the Save Configuration option. 
    .PARAMETER DebugOutput 
        Generate verbose output when synchronizing the GSLB sites. The Debug option generates more verbose output than the sync gslb config command in which the option is not used, and is useful for analyzing synchronization issues. 
    .PARAMETER Forcesync 
        Force synchronization of the specified site even if a dependent configuration on the remote site is preventing synchronization or if one or more GSLB entities on the remote site have the same name but are of a different type. You can specify either the name of the remote site that you want to synchronize with the local site, or you can specify All Sites in the configuration utility (the string all-sites in the CLI). If you specify All Sites, all the sites in the GSLB setup are synchronized with the site on the master node. 
        Note: If you select the Force Sync option, the synchronization starts without displaying the commands that are going to be executed. 
    .PARAMETER Nowarn 
        Suppress the warning and the confirmation prompt that are displayed before site synchronization begins. This option can be used in automation scripts that must not be interrupted by a prompt. 
    .PARAMETER Saveconfig 
        Save the configuration on all the nodes participating in the synchronization process, automatically. The master saves its configuration immediately before synchronization begins. Slave nodes save their configurations after the process of synchronization is complete. A slave node saves its configuration only if the configuration difference was successfully applied to it. Mutually exclusive with the Preview option. 
    .PARAMETER Command 
        Run the specified command on the master node and then on all the slave nodes. You cannot use this option with the force sync and preview options.
    .EXAMPLE
        PS C:\>Invoke-NSSyncGslbconfig 
        An example how to sync gslbconfig config Object(s).
    .NOTES
        File Name : Invoke-NSSyncGslbconfig
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbconfig/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [boolean]$Preview,

        [boolean]$DebugOutput,

        [string]$Forcesync,

        [boolean]$Nowarn,

        [boolean]$Saveconfig,

        [string]$Command 

    )
    begin {
        Write-Verbose "Invoke-NSSyncGslbconfig: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('preview') ) { $payload.Add('preview', $preview) }
            if ( $PSBoundParameters.ContainsKey('DebugOutput') ) { $payload.Add('debug', $DebugOutput) }
            if ( $PSBoundParameters.ContainsKey('forcesync') ) { $payload.Add('forcesync', $forcesync) }
            if ( $PSBoundParameters.ContainsKey('nowarn') ) { $payload.Add('nowarn', $nowarn) }
            if ( $PSBoundParameters.ContainsKey('saveconfig') ) { $payload.Add('saveconfig', $saveconfig) }
            if ( $PSBoundParameters.ContainsKey('command') ) { $payload.Add('command', $command) }
            if ( $PSCmdlet.ShouldProcess($Name, "Sync Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbconfig -Action sync -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSSyncGslbconfig: Finished"
    }
}

function Invoke-NSGetGslbdomain {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Configuration for GSLB domain resource.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomain
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomain -GetAll 
        Get all gslbdomain data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomain -Count 
        Get the number of gslbdomain objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomain -name <string>
        Get gslbdomain object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomain -Filter @{ 'name'='<value>' }
        Get gslbdomain data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbdomain
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbdomain/
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
        Write-Verbose "Invoke-NSGetGslbdomain: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbdomain objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbdomain: Ended"
    }
}

function Invoke-NSGetGslbdomainBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainBinding -GetAll 
        Get all gslbdomain_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainBinding -name <string>
        Get gslbdomain_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainBinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbdomainBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbdomain_binding/
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
        Write-Verbose "Invoke-NSGetGslbdomainBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbdomainBinding: Ended"
    }
}

function Invoke-NSGetGslbdomainGslbserviceBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbserviceBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainGslbserviceBinding -GetAll 
        Get all gslbdomain_gslbservice_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainGslbserviceBinding -Count 
        Get the number of gslbdomain_gslbservice_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbserviceBinding -name <string>
        Get gslbdomain_gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbserviceBinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbdomainGslbserviceBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbdomain_gslbservice_binding/
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
        Write-Verbose "Invoke-NSGetGslbdomainGslbserviceBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservice_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbservice_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbdomainGslbserviceBinding: Ended"
    }
}

function Invoke-NSGetGslbdomainGslbservicegroupBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbservicegroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainGslbservicegroupBinding -GetAll 
        Get all gslbdomain_gslbservicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainGslbservicegroupBinding -Count 
        Get the number of gslbdomain_gslbservicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbservicegroupBinding -name <string>
        Get gslbdomain_gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbservicegroupBinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbdomainGslbservicegroupBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbdomain_gslbservicegroup_binding/
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
        Write-Verbose "Invoke-NSGetGslbdomainGslbservicegroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_gslbservicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbservicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroup_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbdomainGslbservicegroupBinding: Ended"
    }
}

function Invoke-NSGetGslbdomainGslbservicegroupmemberBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_gslbservicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbservicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbservicegroupmemberBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainGslbservicegroupmemberBinding -GetAll 
        Get all gslbdomain_gslbservicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainGslbservicegroupmemberBinding -Count 
        Get the number of gslbdomain_gslbservicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbservicegroupmemberBinding -name <string>
        Get gslbdomain_gslbservicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbservicegroupmemberBinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_gslbservicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbdomainGslbservicegroupmemberBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbdomain_gslbservicegroupmember_binding/
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
        Write-Verbose "Invoke-NSGetGslbdomainGslbservicegroupmemberBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_gslbservicegroupmember_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbservicegroupmember_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroupmember_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbdomainGslbservicegroupmemberBinding: Ended"
    }
}

function Invoke-NSGetGslbdomainGslbvserverBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_gslbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainGslbvserverBinding -GetAll 
        Get all gslbdomain_gslbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainGslbvserverBinding -Count 
        Get the number of gslbdomain_gslbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbvserverBinding -name <string>
        Get gslbdomain_gslbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainGslbvserverBinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_gslbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbdomainGslbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbdomain_gslbvserver_binding/
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
        Write-Verbose "Invoke-NSGetGslbdomainGslbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_gslbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbdomainGslbvserverBinding: Ended"
    }
}

function Invoke-NSGetGslbdomainLbmonitorBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainLbmonitorBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainLbmonitorBinding -GetAll 
        Get all gslbdomain_lbmonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbdomainLbmonitorBinding -Count 
        Get the number of gslbdomain_lbmonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainLbmonitorBinding -name <string>
        Get gslbdomain_lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbdomainLbmonitorBinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbdomainLbmonitorBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbdomain_lbmonitor_binding/
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
        Write-Verbose "Invoke-NSGetGslbdomainLbmonitorBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_lbmonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_lbmonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_lbmonitor_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_lbmonitor_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbdomainLbmonitorBinding: Ended"
    }
}

function Invoke-NSClearGslbldnsentries {
    <#
    .SYNOPSIS
        Clear Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for LDNS entry resource.
    .EXAMPLE
        PS C:\>Invoke-NSClearGslbldnsentries 
        An example how to clear gslbldnsentries config Object(s).
    .NOTES
        File Name : Invoke-NSClearGslbldnsentries
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbldnsentries/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession) 

    )
    begin {
        Write-Verbose "Invoke-NSClearGslbldnsentries: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbldnsentries -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSClearGslbldnsentries: Finished"
    }
}

function Invoke-NSGetGslbldnsentries {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Configuration for LDNS entry resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all gslbldnsentries object(s).
    .PARAMETER Count
        If specified, the count of the gslbldnsentries object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbldnsentries
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbldnsentries -GetAll 
        Get all gslbldnsentries data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbldnsentries -Count 
        Get the number of gslbldnsentries objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbldnsentries -name <string>
        Get gslbldnsentries object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbldnsentries -Filter @{ 'name'='<value>' }
        Get gslbldnsentries data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbldnsentries
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbldnsentries/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetGslbldnsentries: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbldnsentries objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbldnsentries objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbldnsentries objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbldnsentries configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbldnsentries configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbldnsentries: Ended"
    }
}

function Invoke-NSDeleteGslbldnsentry {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for LDNS entry resource.
    .PARAMETER Ipaddress 
        IP address of the LDNS server.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbldnsentry 
        An example how to delete gslbldnsentry config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbldnsentry
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbldnsentry/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Ipaddress 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbldnsentry: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ipaddress') ) { $arguments.Add('ipaddress', $Ipaddress) }
            if ( $PSCmdlet.ShouldProcess("gslbldnsentry", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbldnsentry -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbldnsentry: Finished"
    }
}

function Invoke-NSUpdateGslbparameter {
    <#
    .SYNOPSIS
        Update Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB parameter resource.
    .PARAMETER Ldnsentrytimeout 
        Time, in seconds, after which an inactive LDNS entry is removed. 
         
         
        Maximum value = 65534 
    .PARAMETER Rtttolerance 
        Tolerance, in milliseconds, for newly learned round-trip time (RTT) values. If the difference between the old RTT value and the newly computed RTT value is less than or equal to the specified tolerance value, the LDNS entry in the network metric table is not updated with the new RTT value. Prevents the exchange of metrics when variations in RTT values are negligible. 
         
         
        Maximum value = 100 
    .PARAMETER Ldnsmask 
        The IPv4 network mask with which to create LDNS entries. 
    .PARAMETER V6ldnsmasklen 
        Mask for creating LDNS entries for IPv6 source addresses. The mask is defined as the number of leading bits to consider, in the source IP address, when creating an LDNS entry. 
         
         
        Maximum value = 128 
    .PARAMETER Ldnsprobeorder 
        Order in which monitors should be initiated to calculate RTT. 
        Possible values = PING, DNS, TCP 
    .PARAMETER Dropldnsreq 
        Drop LDNS requests if round-trip time (RTT) information is not available. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbsvcstatedelaytime 
        Amount of delay in updating the state of GSLB service to DOWN when MEP goes down. 
        This parameter is applicable only if monitors are not bound to GSLB services. 
         
         
        Maximum value = 3600 
    .PARAMETER Svcstatelearningtime 
        Time (in seconds) within which local or child site services remain in learning phase. GSLB site will enter the learning phase after reboot, HA failover, Cluster GSLB owner node changes or MEP being enabled on local node. Backup parent (if configured) will selectively move the adopted children's GSLB services to learning phase when primary parent goes down. While a service is in learning period, remote site will not honour the state and stats got through MEP for that service. State can be learnt from health monitor if bound explicitly. 
         
         
        Maximum value = 3600 
    .PARAMETER Automaticconfigsync 
        GSLB configuration will be synced automatically to remote gslb sites if enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mepkeepalivetimeout 
        Time duartion (in seconds) during which if no new packets received by Local gslb site from Remote gslb site then mark the MEP connection DOWN. 
    .PARAMETER Gslbsyncinterval 
        Time duartion (in seconds) for which the gslb sync process will wait before checking for config changes. 
    .PARAMETER Gslbsyncmode 
        Mode in which configuration will be synced from master site to remote sites. 
         
        Possible values = IncrementalSync, FullSync 
    .PARAMETER Gslbsynclocfiles 
        If disabled, Location files will not be synced to the remote sites as part of automatic sync. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbconfigsyncmonitor 
        If enabled, remote gslb site's rsync port will be monitored and site is considered for configuration sync only when the monitor is successful. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbsyncsaveconfigcommand 
        If enabled, 'save ns config' command will be treated as other GSLB commands and synced to GSLB nodes when auto gslb sync option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Undefaction 
        Action to perform when policy evaluation creates an UNDEF condition. Available settings function as follows: 
        * NOLBACTION - Does not consider LB action in making LB decision. 
        * RESET - Reset the request and notify the user, so that the user can resend the request. 
        * DROP - Drop the request without sending a response to the user.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateGslbparameter 
        An example how to update gslbparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateGslbparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [double]$Ldnsentrytimeout,

        [double]$Rtttolerance,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ldnsmask,

        [double]$V6ldnsmasklen,

        [ValidateSet('PING', 'DNS', 'TCP')]
        [string[]]$Ldnsprobeorder,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dropldnsreq,

        [double]$Gslbsvcstatedelaytime,

        [double]$Svcstatelearningtime,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Automaticconfigsync,

        [double]$Mepkeepalivetimeout,

        [double]$Gslbsyncinterval,

        [ValidateSet('IncrementalSync', 'FullSync')]
        [string]$Gslbsyncmode,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Gslbsynclocfiles,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Gslbconfigsyncmonitor,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Gslbsyncsaveconfigcommand,

        [string]$Undefaction 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateGslbparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ldnsentrytimeout') ) { $payload.Add('ldnsentrytimeout', $ldnsentrytimeout) }
            if ( $PSBoundParameters.ContainsKey('rtttolerance') ) { $payload.Add('rtttolerance', $rtttolerance) }
            if ( $PSBoundParameters.ContainsKey('ldnsmask') ) { $payload.Add('ldnsmask', $ldnsmask) }
            if ( $PSBoundParameters.ContainsKey('v6ldnsmasklen') ) { $payload.Add('v6ldnsmasklen', $v6ldnsmasklen) }
            if ( $PSBoundParameters.ContainsKey('ldnsprobeorder') ) { $payload.Add('ldnsprobeorder', $ldnsprobeorder) }
            if ( $PSBoundParameters.ContainsKey('dropldnsreq') ) { $payload.Add('dropldnsreq', $dropldnsreq) }
            if ( $PSBoundParameters.ContainsKey('gslbsvcstatedelaytime') ) { $payload.Add('gslbsvcstatedelaytime', $gslbsvcstatedelaytime) }
            if ( $PSBoundParameters.ContainsKey('svcstatelearningtime') ) { $payload.Add('svcstatelearningtime', $svcstatelearningtime) }
            if ( $PSBoundParameters.ContainsKey('automaticconfigsync') ) { $payload.Add('automaticconfigsync', $automaticconfigsync) }
            if ( $PSBoundParameters.ContainsKey('mepkeepalivetimeout') ) { $payload.Add('mepkeepalivetimeout', $mepkeepalivetimeout) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncinterval') ) { $payload.Add('gslbsyncinterval', $gslbsyncinterval) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncmode') ) { $payload.Add('gslbsyncmode', $gslbsyncmode) }
            if ( $PSBoundParameters.ContainsKey('gslbsynclocfiles') ) { $payload.Add('gslbsynclocfiles', $gslbsynclocfiles) }
            if ( $PSBoundParameters.ContainsKey('gslbconfigsyncmonitor') ) { $payload.Add('gslbconfigsyncmonitor', $gslbconfigsyncmonitor) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncsaveconfigcommand') ) { $payload.Add('gslbsyncsaveconfigcommand', $gslbsyncsaveconfigcommand) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSCmdlet.ShouldProcess("gslbparameter", "Update Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateGslbparameter: Finished"
    }
}

function Invoke-NSUnsetGslbparameter {
    <#
    .SYNOPSIS
        Unset Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB parameter resource.
    .PARAMETER Ldnsentrytimeout 
        Time, in seconds, after which an inactive LDNS entry is removed. 
         
         
        Maximum value = 65534 
    .PARAMETER Rtttolerance 
        Tolerance, in milliseconds, for newly learned round-trip time (RTT) values. If the difference between the old RTT value and the newly computed RTT value is less than or equal to the specified tolerance value, the LDNS entry in the network metric table is not updated with the new RTT value. Prevents the exchange of metrics when variations in RTT values are negligible. 
         
         
        Maximum value = 100 
    .PARAMETER Ldnsmask 
        The IPv4 network mask with which to create LDNS entries. 
    .PARAMETER V6ldnsmasklen 
        Mask for creating LDNS entries for IPv6 source addresses. The mask is defined as the number of leading bits to consider, in the source IP address, when creating an LDNS entry. 
         
         
        Maximum value = 128 
    .PARAMETER Ldnsprobeorder 
        Order in which monitors should be initiated to calculate RTT. 
        Possible values = PING, DNS, TCP 
    .PARAMETER Dropldnsreq 
        Drop LDNS requests if round-trip time (RTT) information is not available. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbsvcstatedelaytime 
        Amount of delay in updating the state of GSLB service to DOWN when MEP goes down. 
        This parameter is applicable only if monitors are not bound to GSLB services. 
         
         
        Maximum value = 3600 
    .PARAMETER Svcstatelearningtime 
        Time (in seconds) within which local or child site services remain in learning phase. GSLB site will enter the learning phase after reboot, HA failover, Cluster GSLB owner node changes or MEP being enabled on local node. Backup parent (if configured) will selectively move the adopted children's GSLB services to learning phase when primary parent goes down. While a service is in learning period, remote site will not honour the state and stats got through MEP for that service. State can be learnt from health monitor if bound explicitly. 
         
         
        Maximum value = 3600 
    .PARAMETER Automaticconfigsync 
        GSLB configuration will be synced automatically to remote gslb sites if enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mepkeepalivetimeout 
        Time duartion (in seconds) during which if no new packets received by Local gslb site from Remote gslb site then mark the MEP connection DOWN. 
    .PARAMETER Gslbsyncinterval 
        Time duartion (in seconds) for which the gslb sync process will wait before checking for config changes. 
    .PARAMETER Gslbsyncmode 
        Mode in which configuration will be synced from master site to remote sites. 
         
        Possible values = IncrementalSync, FullSync 
    .PARAMETER Gslbsynclocfiles 
        If disabled, Location files will not be synced to the remote sites as part of automatic sync. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbconfigsyncmonitor 
        If enabled, remote gslb site's rsync port will be monitored and site is considered for configuration sync only when the monitor is successful. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbsyncsaveconfigcommand 
        If enabled, 'save ns config' command will be treated as other GSLB commands and synced to GSLB nodes when auto gslb sync option is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Undefaction 
        Action to perform when policy evaluation creates an UNDEF condition. Available settings function as follows: 
        * NOLBACTION - Does not consider LB action in making LB decision. 
        * RESET - Reset the request and notify the user, so that the user can resend the request. 
        * DROP - Drop the request without sending a response to the user.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetGslbparameter 
        An example how to unset gslbparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetGslbparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$ldnsentrytimeout,

        [Boolean]$rtttolerance,

        [Boolean]$ldnsmask,

        [Boolean]$v6ldnsmasklen,

        [Boolean]$ldnsprobeorder,

        [Boolean]$dropldnsreq,

        [Boolean]$gslbsvcstatedelaytime,

        [Boolean]$svcstatelearningtime,

        [Boolean]$automaticconfigsync,

        [Boolean]$mepkeepalivetimeout,

        [Boolean]$gslbsyncinterval,

        [Boolean]$gslbsyncmode,

        [Boolean]$gslbsynclocfiles,

        [Boolean]$gslbconfigsyncmonitor,

        [Boolean]$gslbsyncsaveconfigcommand,

        [Boolean]$undefaction 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetGslbparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ldnsentrytimeout') ) { $payload.Add('ldnsentrytimeout', $ldnsentrytimeout) }
            if ( $PSBoundParameters.ContainsKey('rtttolerance') ) { $payload.Add('rtttolerance', $rtttolerance) }
            if ( $PSBoundParameters.ContainsKey('ldnsmask') ) { $payload.Add('ldnsmask', $ldnsmask) }
            if ( $PSBoundParameters.ContainsKey('v6ldnsmasklen') ) { $payload.Add('v6ldnsmasklen', $v6ldnsmasklen) }
            if ( $PSBoundParameters.ContainsKey('ldnsprobeorder') ) { $payload.Add('ldnsprobeorder', $ldnsprobeorder) }
            if ( $PSBoundParameters.ContainsKey('dropldnsreq') ) { $payload.Add('dropldnsreq', $dropldnsreq) }
            if ( $PSBoundParameters.ContainsKey('gslbsvcstatedelaytime') ) { $payload.Add('gslbsvcstatedelaytime', $gslbsvcstatedelaytime) }
            if ( $PSBoundParameters.ContainsKey('svcstatelearningtime') ) { $payload.Add('svcstatelearningtime', $svcstatelearningtime) }
            if ( $PSBoundParameters.ContainsKey('automaticconfigsync') ) { $payload.Add('automaticconfigsync', $automaticconfigsync) }
            if ( $PSBoundParameters.ContainsKey('mepkeepalivetimeout') ) { $payload.Add('mepkeepalivetimeout', $mepkeepalivetimeout) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncinterval') ) { $payload.Add('gslbsyncinterval', $gslbsyncinterval) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncmode') ) { $payload.Add('gslbsyncmode', $gslbsyncmode) }
            if ( $PSBoundParameters.ContainsKey('gslbsynclocfiles') ) { $payload.Add('gslbsynclocfiles', $gslbsynclocfiles) }
            if ( $PSBoundParameters.ContainsKey('gslbconfigsyncmonitor') ) { $payload.Add('gslbconfigsyncmonitor', $gslbconfigsyncmonitor) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncsaveconfigcommand') ) { $payload.Add('gslbsyncsaveconfigcommand', $gslbsyncsaveconfigcommand) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSCmdlet.ShouldProcess("gslbparameter", "Unset Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type gslbparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetGslbparameter: Finished"
    }
}

function Invoke-NSGetGslbparameter {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Configuration for GSLB parameter resource.
    .PARAMETER GetAll 
        Retrieve all gslbparameter object(s).
    .PARAMETER Count
        If specified, the count of the gslbparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbparameter -GetAll 
        Get all gslbparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbparameter -name <string>
        Get gslbparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbparameter -Filter @{ 'name'='<value>' }
        Get gslbparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbparameter/
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
        Write-Verbose "Invoke-NSGetGslbparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbparameter: Ended"
    }
}

function Invoke-NSGetGslbrunningconfig {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Configuration for running GSLB configuration resource.
    .PARAMETER GetAll 
        Retrieve all gslbrunningconfig object(s).
    .PARAMETER Count
        If specified, the count of the gslbrunningconfig object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbrunningconfig
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbrunningconfig -GetAll 
        Get all gslbrunningconfig data.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbrunningconfig -name <string>
        Get gslbrunningconfig object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbrunningconfig -Filter @{ 'name'='<value>' }
        Get gslbrunningconfig data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbrunningconfig
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbrunningconfig/
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
        Write-Verbose "Invoke-NSGetGslbrunningconfig: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbrunningconfig objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbrunningconfig objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbrunningconfig objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbrunningconfig configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbrunningconfig configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbrunningconfig: Ended"
    }
}

function Invoke-NSAddGslbservice {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
    .PARAMETER Cnameentry 
        Canonical name of the GSLB service. Used in CNAME-based GSLB. 
    .PARAMETER Ip 
        IP address for the GSLB service. Should represent a load balancing, content switching, or VPN virtual server on the Citrix ADC, or the IP address of another load balancing device. 
    .PARAMETER Servername 
        Name of the server hosting the GSLB service. 
    .PARAMETER Servicetype 
        Type of service to create. 
         
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, NNTP, ANY, SIP_UDP, SIP_TCP, SIP_SSL, RADIUS, RDP, RTSP, MYSQL, MSSQL, ORACLE 
    .PARAMETER Port 
        Port on which the load balancing entity represented by this GSLB service listens. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Maxclient 
        The maximum number of open connections that the service can support at any given time. A GSLB service whose connection count reaches the maximum is not considered when a GSLB decision is made, until the connection count drops below the maximum. 
         
        Maximum value = 4294967294 
    .PARAMETER Healthmonitor 
        Monitor the health of the GSLB service. 
         
        Possible values = YES, NO 
    .PARAMETER Sitename 
        Name of the GSLB site to which the service belongs. 
    .PARAMETER State 
        Enable or disable the service. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cip 
        In the request that is forwarded to the GSLB service, insert a header that stores the client's IP address. Client IP header insertion is used in connection-proxy based site persistence. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name for the HTTP header that stores the client's IP address. Used with the Client IP option. If client IP header insertion is enabled on the service and a name is not specified for the header, the Citrix ADC uses the name specified by the cipHeader parameter in the set ns param command or, in the GUI, the Client IP Header parameter in the Configure HTTP Parameters dialog box. 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL GSLB services. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER Cookietimeout 
        Timeout value, in minutes, for the cookie, when cookie based site persistence is enabled. 
         
        Maximum value = 1440 
    .PARAMETER Siteprefix 
        The site's prefix string. When the service is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound service-domain pair by concatenating the site prefix of the service and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which a client connection is terminated. Applicable if connection proxy based site persistence is used. 
         
        Maximum value = 31536000 
    .PARAMETER Svrtimeout 
        Idle time, in seconds, after which a server connection is terminated. Applicable if connection proxy based site persistence is used. 
         
        Maximum value = 31536000 
    .PARAMETER Maxbandwidth 
        Integer specifying the maximum bandwidth allowed for the service. A GSLB service whose bandwidth reaches the maximum is not considered when a GSLB decision is made, until its bandwidth consumption drops below the maximum. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with the GSLB service when its state transitions from UP to DOWN. Do not enable this option for services that must complete their transactions. Applicable if connection proxy based site persistence is used. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxaaausers 
        Maximum number of SSL VPN users that can be logged on concurrently to the VPN virtual server that is represented by this GSLB service. A GSLB service whose user count reaches the maximum is not considered when a GSLB decision is made, until the count drops below the maximum. 
         
        Maximum value = 65535 
    .PARAMETER Monthreshold 
        Monitoring threshold value for the GSLB service. If the sum of the weights of the monitors that are bound to this GSLB service and are in the UP state is not equal to or greater than this threshold value, the service is marked as DOWN. 
         
        Maximum value = 65535 
    .PARAMETER Hashid 
        Unique hash identifier for the GSLB service, used by hash based load balancing methods. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB service. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Naptrreplacement 
        The replacement domain name for this NAPTR. 
    .PARAMETER Naptrorder 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
         
         
        Maximum value = 65535 
    .PARAMETER Naptrservices 
        Service Parameters applicable to this delegation path. 
    .PARAMETER Naptrdomainttl 
        Modify the TTL of the internally created naptr domain. 
    .PARAMETER Naptrpreference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
         
         
        Maximum value = 65535 
    .PARAMETER PassThru 
        Return details about the created gslbservice item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbservice -servicename <string> -sitename <string>
        An example how to add gslbservice config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbservice
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cnameentry,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'NNTP', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'RADIUS', 'RDP', 'RTSP', 'MYSQL', 'MSSQL', 'ORACLE')]
        [string]$Servicetype = 'NSSVC_SERVICE_UNKNOWN',

        [ValidateRange(1, 65535)]
        [int]$Port,

        [string]$Publicip,

        [int]$Publicport,

        [double]$Maxclient,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor = 'YES',

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sitename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip = 'DISABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$Sitepersistence,

        [double]$Cookietimeout,

        [string]$Siteprefix,

        [double]$Clttimeout,

        [double]$Svrtimeout,

        [double]$Maxbandwidth,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [double]$Maxaaausers,

        [double]$Monthreshold,

        [double]$Hashid,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [string]$Naptrreplacement,

        [double]$Naptrorder = '1',

        [string]$Naptrservices,

        [double]$Naptrdomainttl = '3600',

        [double]$Naptrpreference = '1',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbservice: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename
                sitename              = $sitename
            }
            if ( $PSBoundParameters.ContainsKey('cnameentry') ) { $payload.Add('cnameentry', $cnameentry) }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('servicetype') ) { $payload.Add('servicetype', $servicetype) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSBoundParameters.ContainsKey('cookietimeout') ) { $payload.Add('cookietimeout', $cookietimeout) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('maxaaausers') ) { $payload.Add('maxaaausers', $maxaaausers) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacement') ) { $payload.Add('naptrreplacement', $naptrreplacement) }
            if ( $PSBoundParameters.ContainsKey('naptrorder') ) { $payload.Add('naptrorder', $naptrorder) }
            if ( $PSBoundParameters.ContainsKey('naptrservices') ) { $payload.Add('naptrservices', $naptrservices) }
            if ( $PSBoundParameters.ContainsKey('naptrdomainttl') ) { $payload.Add('naptrdomainttl', $naptrdomainttl) }
            if ( $PSBoundParameters.ContainsKey('naptrpreference') ) { $payload.Add('naptrpreference', $naptrpreference) }
            if ( $PSCmdlet.ShouldProcess("gslbservice", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbservice -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbservice -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbservice: Finished"
    }
}

function Invoke-NSDeleteGslbservice {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc').
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbservice -Servicename <string>
        An example how to delete gslbservice config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbservice
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Servicename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbservice: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$servicename", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbservice -NitroPath nitro/v1/config -Resource $servicename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbservice: Finished"
    }
}

function Invoke-NSUpdateGslbservice {
    <#
    .SYNOPSIS
        Update Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
    .PARAMETER Ipaddress 
        The new IP address of the service. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Cip 
        In the request that is forwarded to the GSLB service, insert a header that stores the client's IP address. Client IP header insertion is used in connection-proxy based site persistence. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name for the HTTP header that stores the client's IP address. Used with the Client IP option. If client IP header insertion is enabled on the service and a name is not specified for the header, the Citrix ADC uses the name specified by the cipHeader parameter in the set ns param command or, in the GUI, the Client IP Header parameter in the Configure HTTP Parameters dialog box. 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL GSLB services. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER Siteprefix 
        The site's prefix string. When the service is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound service-domain pair by concatenating the site prefix of the service and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Maxclient 
        The maximum number of open connections that the service can support at any given time. A GSLB service whose connection count reaches the maximum is not considered when a GSLB decision is made, until the connection count drops below the maximum. 
         
        Maximum value = 4294967294 
    .PARAMETER Healthmonitor 
        Monitor the health of the GSLB service. 
         
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Integer specifying the maximum bandwidth allowed for the service. A GSLB service whose bandwidth reaches the maximum is not considered when a GSLB decision is made, until its bandwidth consumption drops below the maximum. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with the GSLB service when its state transitions from UP to DOWN. Do not enable this option for services that must complete their transactions. Applicable if connection proxy based site persistence is used. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxaaausers 
        Maximum number of SSL VPN users that can be logged on concurrently to the VPN virtual server that is represented by this GSLB service. A GSLB service whose user count reaches the maximum is not considered when a GSLB decision is made, until the count drops below the maximum. 
         
        Maximum value = 65535 
    .PARAMETER Viewname 
        Name of the DNS view of the service. A DNS view is used in global server load balancing (GSLB) to return a predetermined IP address to a specific group of clients, which are identified by using a DNS policy. 
    .PARAMETER Viewip 
        IP address to be used for the given view. 
    .PARAMETER Monthreshold 
        Monitoring threshold value for the GSLB service. If the sum of the weights of the monitors that are bound to this GSLB service and are in the UP state is not equal to or greater than this threshold value, the service is marked as DOWN. 
         
        Maximum value = 65535 
    .PARAMETER Weight 
        Weight to assign to the monitor-service binding. A larger number specifies a greater weight. Contributes to the monitoring threshold, which determines the state of the service. 
         
        Maximum value = 100 
    .PARAMETER Monitor_name_svc 
        Name of the monitor to bind to the service. 
    .PARAMETER Hashid 
        Unique hash identifier for the GSLB service, used by hash based load balancing methods. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB service. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Naptrorder 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
         
         
        Maximum value = 65535 
    .PARAMETER Naptrpreference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
         
         
        Maximum value = 65535 
    .PARAMETER Naptrservices 
        Service Parameters applicable to this delegation path. 
    .PARAMETER Naptrreplacement 
        The replacement domain name for this NAPTR. 
    .PARAMETER Naptrdomainttl 
        Modify the TTL of the internally created naptr domain. 
    .PARAMETER PassThru 
        Return details about the created gslbservice item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateGslbservice -servicename <string>
        An example how to update gslbservice config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateGslbservice
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicename,

        [string]$Ipaddress,

        [string]$Publicip,

        [int]$Publicport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$Sitepersistence,

        [string]$Siteprefix,

        [double]$Maxclient,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor,

        [double]$Maxbandwidth,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [double]$Maxaaausers,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Viewname,

        [string]$Viewip,

        [double]$Monthreshold,

        [double]$Weight,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Monitor_name_svc,

        [double]$Hashid,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [double]$Naptrorder,

        [double]$Naptrpreference,

        [string]$Naptrservices,

        [string]$Naptrreplacement,

        [double]$Naptrdomainttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateGslbservice: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('maxaaausers') ) { $payload.Add('maxaaausers', $maxaaausers) }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('viewip') ) { $payload.Add('viewip', $viewip) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('naptrorder') ) { $payload.Add('naptrorder', $naptrorder) }
            if ( $PSBoundParameters.ContainsKey('naptrpreference') ) { $payload.Add('naptrpreference', $naptrpreference) }
            if ( $PSBoundParameters.ContainsKey('naptrservices') ) { $payload.Add('naptrservices', $naptrservices) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacement') ) { $payload.Add('naptrreplacement', $naptrreplacement) }
            if ( $PSBoundParameters.ContainsKey('naptrdomainttl') ) { $payload.Add('naptrdomainttl', $naptrdomainttl) }
            if ( $PSCmdlet.ShouldProcess("gslbservice", "Update Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbservice -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbservice -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateGslbservice: Finished"
    }
}

function Invoke-NSUnsetGslbservice {
    <#
    .SYNOPSIS
        Unset Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Cip 
        In the request that is forwarded to the GSLB service, insert a header that stores the client's IP address. Client IP header insertion is used in connection-proxy based site persistence. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name for the HTTP header that stores the client's IP address. Used with the Client IP option. If client IP header insertion is enabled on the service and a name is not specified for the header, the Citrix ADC uses the name specified by the cipHeader parameter in the set ns param command or, in the GUI, the Client IP Header parameter in the Configure HTTP Parameters dialog box. 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL GSLB services. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER Siteprefix 
        The site's prefix string. When the service is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound service-domain pair by concatenating the site prefix of the service and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Maxclient 
        The maximum number of open connections that the service can support at any given time. A GSLB service whose connection count reaches the maximum is not considered when a GSLB decision is made, until the connection count drops below the maximum. 
         
        Maximum value = 4294967294 
    .PARAMETER Healthmonitor 
        Monitor the health of the GSLB service. 
         
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Integer specifying the maximum bandwidth allowed for the service. A GSLB service whose bandwidth reaches the maximum is not considered when a GSLB decision is made, until its bandwidth consumption drops below the maximum. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with the GSLB service when its state transitions from UP to DOWN. Do not enable this option for services that must complete their transactions. Applicable if connection proxy based site persistence is used. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxaaausers 
        Maximum number of SSL VPN users that can be logged on concurrently to the VPN virtual server that is represented by this GSLB service. A GSLB service whose user count reaches the maximum is not considered when a GSLB decision is made, until the count drops below the maximum. 
         
        Maximum value = 65535 
    .PARAMETER Monthreshold 
        Monitoring threshold value for the GSLB service. If the sum of the weights of the monitors that are bound to this GSLB service and are in the UP state is not equal to or greater than this threshold value, the service is marked as DOWN. 
         
        Maximum value = 65535 
    .PARAMETER Hashid 
        Unique hash identifier for the GSLB service, used by hash based load balancing methods. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB service. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Naptrorder 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
         
         
        Maximum value = 65535 
    .PARAMETER Naptrpreference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
         
         
        Maximum value = 65535 
    .PARAMETER Naptrservices 
        Service Parameters applicable to this delegation path. 
    .PARAMETER Naptrreplacement 
        The replacement domain name for this NAPTR. 
    .PARAMETER Naptrdomainttl 
        Modify the TTL of the internally created naptr domain.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetGslbservice -servicename <string>
        An example how to unset gslbservice config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetGslbservice
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Servicename,

        [Boolean]$publicip,

        [Boolean]$publicport,

        [Boolean]$cip,

        [Boolean]$cipheader,

        [Boolean]$sitepersistence,

        [Boolean]$siteprefix,

        [Boolean]$maxclient,

        [Boolean]$healthmonitor,

        [Boolean]$maxbandwidth,

        [Boolean]$downstateflush,

        [Boolean]$maxaaausers,

        [Boolean]$monthreshold,

        [Boolean]$hashid,

        [Boolean]$comment,

        [Boolean]$appflowlog,

        [Boolean]$naptrorder,

        [Boolean]$naptrpreference,

        [Boolean]$naptrservices,

        [Boolean]$naptrreplacement,

        [Boolean]$naptrdomainttl 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetGslbservice: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('maxaaausers') ) { $payload.Add('maxaaausers', $maxaaausers) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('naptrorder') ) { $payload.Add('naptrorder', $naptrorder) }
            if ( $PSBoundParameters.ContainsKey('naptrpreference') ) { $payload.Add('naptrpreference', $naptrpreference) }
            if ( $PSBoundParameters.ContainsKey('naptrservices') ) { $payload.Add('naptrservices', $naptrservices) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacement') ) { $payload.Add('naptrreplacement', $naptrreplacement) }
            if ( $PSBoundParameters.ContainsKey('naptrdomainttl') ) { $payload.Add('naptrdomainttl', $naptrdomainttl) }
            if ( $PSCmdlet.ShouldProcess("$servicename", "Unset Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type gslbservice -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetGslbservice: Finished"
    }
}

function Invoke-NSRenameGslbservice {
    <#
    .SYNOPSIS
        Rename Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
    .PARAMETER Newname 
        New name for the GSLB service. 
    .PARAMETER PassThru 
        Return details about the created gslbservice item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameGslbservice -servicename <string> -newname <string>
        An example how to rename gslbservice config Object(s).
    .NOTES
        File Name : Invoke-NSRenameGslbservice
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicename,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameGslbservice: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename
                newname               = $newname
            }

            if ( $PSCmdlet.ShouldProcess("gslbservice", "Rename Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbservice -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbservice -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameGslbservice: Finished"
    }
}

function Invoke-NSGetGslbservice {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
    .PARAMETER GetAll 
        Retrieve all gslbservice object(s).
    .PARAMETER Count
        If specified, the count of the gslbservice object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservice
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservice -GetAll 
        Get all gslbservice data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservice -Count 
        Get the number of gslbservice objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservice -name <string>
        Get gslbservice object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservice -Filter @{ 'name'='<value>' }
        Get gslbservice data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbservice
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice/
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
        [string]$Servicename,

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
        Write-Verbose "Invoke-NSGetGslbservice: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbservice objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice configuration for property 'servicename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbservice: Ended"
    }
}

function Invoke-NSGetGslbserviceBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER GetAll 
        Retrieve all gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbserviceBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbserviceBinding -GetAll 
        Get all gslbservice_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbserviceBinding -name <string>
        Get gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbserviceBinding -Filter @{ 'name'='<value>' }
        Get gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbserviceBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice_binding/
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
        [string]$Servicename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbserviceBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice_binding configuration for property 'servicename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbserviceBinding: Ended"
    }
}

function Invoke-NSAddGslbserviceDnsviewBinding {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the dnsview that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER Viewname 
        Name of the DNS view of the service. A DNS view is used in global server load balancing (GSLB) to return a predetermined IP address to a specific group of clients, which are identified by using a DNS policy. 
    .PARAMETER Viewip 
        IP address to be used for the given view. 
    .PARAMETER PassThru 
        Return details about the created gslbservice_dnsview_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbserviceDnsviewBinding -servicename <string>
        An example how to add gslbservice_dnsview_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbserviceDnsviewBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice_dnsview_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Viewname,

        [string]$Viewip,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbserviceDnsviewBinding: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('viewip') ) { $payload.Add('viewip', $viewip) }
            if ( $PSCmdlet.ShouldProcess("gslbservice_dnsview_binding", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbservice_dnsview_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbserviceDnsviewBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbserviceDnsviewBinding: Finished"
    }
}

function Invoke-NSDeleteGslbserviceDnsviewBinding {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the dnsview that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER Viewname 
        Name of the DNS view of the service. A DNS view is used in global server load balancing (GSLB) to return a predetermined IP address to a specific group of clients, which are identified by using a DNS policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbserviceDnsviewBinding -Servicename <string>
        An example how to delete gslbservice_dnsview_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbserviceDnsviewBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice_dnsview_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Servicename,

        [string]$Viewname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbserviceDnsviewBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Viewname') ) { $arguments.Add('viewname', $Viewname) }
            if ( $PSCmdlet.ShouldProcess("$servicename", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Resource $servicename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbserviceDnsviewBinding: Finished"
    }
}

function Invoke-NSGetGslbserviceDnsviewBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the dnsview that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER GetAll 
        Retrieve all gslbservice_dnsview_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservice_dnsview_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbserviceDnsviewBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbserviceDnsviewBinding -GetAll 
        Get all gslbservice_dnsview_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbserviceDnsviewBinding -Count 
        Get the number of gslbservice_dnsview_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbserviceDnsviewBinding -name <string>
        Get gslbservice_dnsview_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbserviceDnsviewBinding -Filter @{ 'name'='<value>' }
        Get gslbservice_dnsview_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbserviceDnsviewBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice_dnsview_binding/
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
        [string]$Servicename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbserviceDnsviewBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservice_dnsview_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice_dnsview_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice_dnsview_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice_dnsview_binding configuration for property 'servicename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice_dnsview_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbserviceDnsviewBinding: Ended"
    }
}

function Invoke-NSAddGslbserviceLbmonitorBinding {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER Monitor_name 
        Monitor name. 
    .PARAMETER Monstate 
        State of the monitor bound to gslb service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Weight 
        Weight to assign to the monitor-service binding. A larger number specifies a greater weight. Contributes to the monitoring threshold, which determines the state of the service. 
         
        Maximum value = 100 
    .PARAMETER PassThru 
        Return details about the created gslbservice_lbmonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbserviceLbmonitorBinding -servicename <string>
        An example how to add gslbservice_lbmonitor_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbserviceLbmonitorBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice_lbmonitor_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicename,

        [string]$Monitor_name,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Monstate,

        [double]$Weight,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbserviceLbmonitorBinding: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename }
            if ( $PSBoundParameters.ContainsKey('monitor_name') ) { $payload.Add('monitor_name', $monitor_name) }
            if ( $PSBoundParameters.ContainsKey('monstate') ) { $payload.Add('monstate', $monstate) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSCmdlet.ShouldProcess("gslbservice_lbmonitor_binding", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbservice_lbmonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbserviceLbmonitorBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbserviceLbmonitorBinding: Finished"
    }
}

function Invoke-NSDeleteGslbserviceLbmonitorBinding {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER Monitor_name 
        Monitor name.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbserviceLbmonitorBinding -Servicename <string>
        An example how to delete gslbservice_lbmonitor_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbserviceLbmonitorBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice_lbmonitor_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Servicename,

        [string]$Monitor_name 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbserviceLbmonitorBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Monitor_name') ) { $arguments.Add('monitor_name', $Monitor_name) }
            if ( $PSCmdlet.ShouldProcess("$servicename", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbserviceLbmonitorBinding: Finished"
    }
}

function Invoke-NSGetGslbserviceLbmonitorBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER GetAll 
        Retrieve all gslbservice_lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservice_lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbserviceLbmonitorBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbserviceLbmonitorBinding -GetAll 
        Get all gslbservice_lbmonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbserviceLbmonitorBinding -Count 
        Get the number of gslbservice_lbmonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbserviceLbmonitorBinding -name <string>
        Get gslbservice_lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbserviceLbmonitorBinding -Filter @{ 'name'='<value>' }
        Get gslbservice_lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbserviceLbmonitorBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservice_lbmonitor_binding/
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
        [string]$Servicename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbserviceLbmonitorBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservice_lbmonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice_lbmonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice_lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice_lbmonitor_binding configuration for property 'servicename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice_lbmonitor_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbserviceLbmonitorBinding: Ended"
    }
}

function Invoke-NSAddGslbservicegroup {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servicetype 
        Protocol used to exchange data with the GSLB service. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, NNTP, ANY, SIP_UDP, SIP_TCP, SIP_SSL, RADIUS, RDP, RTSP, MYSQL, MSSQL, ORACLE 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the GSLB service group. 
         
        Maximum value = 4294967294 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the GSLB service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Healthmonitor 
        Monitor the health of this GSLB service.Available settings function are as follows: 
        YES - Send probes to check the health of the GSLB service. 
        NO - Do not send probes to check the health of the GSLB service. With the NO option, the appliance shows the service as UP at all times. 
         
        Possible values = YES, NO 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
         
        Maximum value = 31536000 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the GSLB service group. 
         
        Maximum value = 4294967287 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this GSLB service. Used to determine whether to mark a GSLB service as UP or DOWN. 
         
        Maximum value = 65535 
    .PARAMETER State 
        Initial state of the GSLB service group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the GSLB service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any information about the GSLB service group. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified GSLB service group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Autoscale 
        Auto scale option for a GSLB servicegroup. 
         
        Possible values = DISABLED, DNS 
    .PARAMETER Autodelayedtrofs 
        Indicates graceful movement of the service to TROFS. System will wait for monitor response time out before moving to TROFS. 
         
        Possible values = YES, NO 
    .PARAMETER Sitename 
        Name of the GSLB site to which the service group belongs. 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL non-autoscale enabled GSLB servicegroups. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbservicegroup -servicegroupname <string> -servicetype <string> -sitename <string>
        An example how to add gslbservicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbservicegroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicegroupname,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'NNTP', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'RADIUS', 'RDP', 'RTSP', 'MYSQL', 'MSSQL', 'ORACLE')]
        [string]$Servicetype,

        [double]$Maxclient,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor = 'YES',

        [double]$Clttimeout,

        [double]$Svrtimeout,

        [double]$Maxbandwidth,

        [double]$Monthreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateSet('DISABLED', 'DNS')]
        [string]$Autoscale = 'DISABLED',

        [ValidateSet('YES', 'NO')]
        [string]$Autodelayedtrofs = 'NO',

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sitename,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$Sitepersistence,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname
                servicetype                = $servicetype
                sitename                   = $sitename
            }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('autoscale') ) { $payload.Add('autoscale', $autoscale) }
            if ( $PSBoundParameters.ContainsKey('autodelayedtrofs') ) { $payload.Add('autodelayedtrofs', $autodelayedtrofs) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSCmdlet.ShouldProcess("gslbservicegroup", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbservicegroup -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbservicegroup: Finished"
    }
}

function Invoke-NSDeleteGslbservicegroup {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbservicegroup -Servicegroupname <string>
        An example how to delete gslbservicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbservicegroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbservicegroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbservicegroup -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbservicegroup: Finished"
    }
}

function Invoke-NSUpdateGslbservicegroup {
    <#
    .SYNOPSIS
        Update Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
         
        Maximum value = 100 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Order 
        Order number to be assigned to the gslb servicegroup member. 
         
        Maximum value = 8192 
    .PARAMETER Monitor_name_svc 
        Name of the monitor bound to the GSLB service group. Used to assign a weight to the monitor. 
    .PARAMETER Dup_weight 
        weight of the monitor that is bound to GSLB servicegroup. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the GSLB service group. 
         
        Maximum value = 4294967294 
    .PARAMETER Healthmonitor 
        Monitor the health of this GSLB service.Available settings function are as follows: 
        YES - Send probes to check the health of the GSLB service. 
        NO - Do not send probes to check the health of the GSLB service. With the NO option, the appliance shows the service as UP at all times. 
         
        Possible values = YES, NO 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the GSLB service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
         
        Maximum value = 31536000 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the GSLB service group. 
         
        Maximum value = 4294967287 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this GSLB service. Used to determine whether to mark a GSLB service as UP or DOWN. 
         
        Maximum value = 65535 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the GSLB service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any information about the GSLB service group. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified GSLB service group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL non-autoscale enabled GSLB servicegroups. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateGslbservicegroup -servicegroupname <string>
        An example how to update gslbservicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateGslbservicegroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [double]$Weight,

        [double]$Hashid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Publicip,

        [int]$Publicport,

        [string]$Siteprefix,

        [double]$Order,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Monitor_name_svc,

        [double]$Dup_weight,

        [double]$Maxclient,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [double]$Clttimeout,

        [double]$Svrtimeout,

        [double]$Maxbandwidth,

        [double]$Monthreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$Sitepersistence,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('dup_weight') ) { $payload.Add('dup_weight', $dup_weight) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSCmdlet.ShouldProcess("gslbservicegroup", "Update Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbservicegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbservicegroup -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateGslbservicegroup: Finished"
    }
}

function Invoke-NSUnsetGslbservicegroup {
    <#
    .SYNOPSIS
        Unset Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
         
        Maximum value = 100 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Order 
        Order number to be assigned to the gslb servicegroup member. 
         
        Maximum value = 8192 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the GSLB service group. 
         
        Maximum value = 4294967294 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the GSLB service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
         
        Maximum value = 31536000 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the GSLB service group. 
         
        Maximum value = 4294967287 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this GSLB service. Used to determine whether to mark a GSLB service as UP or DOWN. 
         
        Maximum value = 65535 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified GSLB service group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL non-autoscale enabled GSLB servicegroups. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER Monitor_name_svc 
        Name of the monitor bound to the GSLB service group. Used to assign a weight to the monitor. 
    .PARAMETER Dup_weight 
        weight of the monitor that is bound to GSLB servicegroup. 
    .PARAMETER Healthmonitor 
        Monitor the health of this GSLB service.Available settings function are as follows: 
        YES - Send probes to check the health of the GSLB service. 
        NO - Do not send probes to check the health of the GSLB service. With the NO option, the appliance shows the service as UP at all times. 
         
        Possible values = YES, NO 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the GSLB service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any information about the GSLB service group.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetGslbservicegroup -servicegroupname <string>
        An example how to unset gslbservicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetGslbservicegroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Servicegroupname,

        [Boolean]$servername,

        [Boolean]$port,

        [Boolean]$weight,

        [Boolean]$hashid,

        [Boolean]$publicip,

        [Boolean]$publicport,

        [Boolean]$siteprefix,

        [Boolean]$order,

        [Boolean]$maxclient,

        [Boolean]$cip,

        [Boolean]$clttimeout,

        [Boolean]$svrtimeout,

        [Boolean]$maxbandwidth,

        [Boolean]$monthreshold,

        [Boolean]$appflowlog,

        [Boolean]$sitepersistence,

        [Boolean]$monitor_name_svc,

        [Boolean]$dup_weight,

        [Boolean]$healthmonitor,

        [Boolean]$cipheader,

        [Boolean]$downstateflush,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('dup_weight') ) { $payload.Add('dup_weight', $dup_weight) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Unset Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type gslbservicegroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetGslbservicegroup: Finished"
    }
}

function Invoke-NSEnableGslbservicegroup {
    <#
    .SYNOPSIS
        Enable Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number.
    .EXAMPLE
        PS C:\>Invoke-NSEnableGslbservicegroup -servicegroupname <string>
        An example how to enable gslbservicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSEnableGslbservicegroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port 

    )
    begin {
        Write-Verbose "Invoke-NSEnableGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSCmdlet.ShouldProcess($Name, "Enable Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableGslbservicegroup: Finished"
    }
}

function Invoke-NSDisableGslbservicegroup {
    <#
    .SYNOPSIS
        Disable Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
    .PARAMETER Delay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER Graceful 
        Wait for all existing connections to the service to terminate before shutting down the service. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSDisableGslbservicegroup -servicegroupname <string>
        An example how to disable gslbservicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSDisableGslbservicegroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [double]$Delay,

        [ValidateSet('YES', 'NO')]
        [string]$Graceful 

    )
    begin {
        Write-Verbose "Invoke-NSDisableGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('graceful') ) { $payload.Add('graceful', $graceful) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableGslbservicegroup: Finished"
    }
}

function Invoke-NSRenameGslbservicegroup {
    <#
    .SYNOPSIS
        Rename Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Newname 
        New name for the GSLB service group. 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameGslbservicegroup -servicegroupname <string> -newname <string>
        An example how to rename gslbservicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSRenameGslbservicegroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicegroupname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname
                newname                    = $newname
            }

            if ( $PSCmdlet.ShouldProcess("gslbservicegroup", "Rename Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbservicegroup -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameGslbservicegroup: Finished"
    }
}

function Invoke-NSGetGslbservicegroup {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroup object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservicegroup -GetAll 
        Get all gslbservicegroup data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservicegroup -Count 
        Get the number of gslbservicegroup objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroup -name <string>
        Get gslbservicegroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroup -Filter @{ 'name'='<value>' }
        Get gslbservicegroup data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbservicegroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup/
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
        [string]$Servicegroupname,

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
        Write-Verbose "Invoke-NSGetGslbservicegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbservicegroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbservicegroup: Ended"
    }
}

function Invoke-NSGetGslbservicegroupBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservicegroupBinding -GetAll 
        Get all gslbservicegroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupBinding -name <string>
        Get gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupBinding -Filter @{ 'name'='<value>' }
        Get gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbservicegroupBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup_binding/
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
        [string]$Servicegroupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbservicegroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_binding configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbservicegroupBinding: Ended"
    }
}

function Invoke-NSAddGslbservicegroupGslbservicegroupmemberBinding {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER Ip 
        IP Address. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
         
        Maximum value = 100 
    .PARAMETER State 
        Initial state of the GSLB service group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Order 
        Order number to be assigned to the gslb servicegroup member. 
         
        Maximum value = 8192 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup_gslbservicegroupmember_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbservicegroupGslbservicegroupmemberBinding -servicegroupname <string>
        An example how to add gslbservicegroup_gslbservicegroupmember_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbservicegroupGslbservicegroupmemberBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup_gslbservicegroupmember_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicegroupname,

        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [double]$Weight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [double]$Hashid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Publicip,

        [int]$Publicport,

        [string]$Siteprefix,

        [double]$Order,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbservicegroupGslbservicegroupmemberBinding: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSCmdlet.ShouldProcess("gslbservicegroup_gslbservicegroupmember_binding", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbservicegroup_gslbservicegroupmember_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbservicegroupGslbservicegroupmemberBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbservicegroupGslbservicegroupmemberBinding: Finished"
    }
}

function Invoke-NSDeleteGslbservicegroupGslbservicegroupmemberBinding {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER Ip 
        IP Address. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbservicegroupGslbservicegroupmemberBinding -Servicegroupname <string>
        An example how to delete gslbservicegroup_gslbservicegroupmember_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbservicegroupGslbservicegroupmemberBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup_gslbservicegroupmember_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Servicegroupname,

        [string]$Ip,

        [string]$Servername,

        [int]$Port 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbservicegroupGslbservicegroupmemberBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ip') ) { $arguments.Add('ip', $Ip) }
            if ( $PSBoundParameters.ContainsKey('Servername') ) { $arguments.Add('servername', $Servername) }
            if ( $PSBoundParameters.ContainsKey('Port') ) { $arguments.Add('port', $Port) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbservicegroupGslbservicegroupmemberBinding: Finished"
    }
}

function Invoke-NSGetGslbservicegroupGslbservicegroupmemberBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroup_gslbservicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_gslbservicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupGslbservicegroupmemberBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservicegroupGslbservicegroupmemberBinding -GetAll 
        Get all gslbservicegroup_gslbservicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservicegroupGslbservicegroupmemberBinding -Count 
        Get the number of gslbservicegroup_gslbservicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupGslbservicegroupmemberBinding -name <string>
        Get gslbservicegroup_gslbservicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupGslbservicegroupmemberBinding -Filter @{ 'name'='<value>' }
        Get gslbservicegroup_gslbservicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbservicegroupGslbservicegroupmemberBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup_gslbservicegroupmember_binding/
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
        [string]$Servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbservicegroupGslbservicegroupmemberBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservicegroup_gslbservicegroupmember_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_gslbservicegroupmember_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_gslbservicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_gslbservicegroupmember_binding configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbservicegroupGslbservicegroupmemberBinding: Ended"
    }
}

function Invoke-NSAddGslbservicegroupLbmonitorBinding {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER Port 
        Port number of the GSLB service. Each service must have a unique port number. 
    .PARAMETER Monitor_name 
        Monitor name. 
    .PARAMETER Monstate 
        Monitor state. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Passive 
        Indicates if load monitor is passive. A passive load monitor does not remove service from LB decision when threshold is breached. 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
         
        Maximum value = 100 
    .PARAMETER State 
        Initial state of the service after binding. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Hashid 
        Unique numerical identifier used by hash based load balancing methods to identify a service. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Order 
        Order number to be assigned to the gslb servicegroup member. 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup_lbmonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbservicegroupLbmonitorBinding -servicegroupname <string>
        An example how to add gslbservicegroup_lbmonitor_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbservicegroupLbmonitorBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup_lbmonitor_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicegroupname,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [string]$Monitor_name,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Monstate,

        [boolean]$Passive,

        [double]$Weight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [double]$Hashid,

        [string]$Publicip,

        [int]$Publicport,

        [string]$Siteprefix,

        [double]$Order,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbservicegroupLbmonitorBinding: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('monitor_name') ) { $payload.Add('monitor_name', $monitor_name) }
            if ( $PSBoundParameters.ContainsKey('monstate') ) { $payload.Add('monstate', $monstate) }
            if ( $PSBoundParameters.ContainsKey('passive') ) { $payload.Add('passive', $passive) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSCmdlet.ShouldProcess("gslbservicegroup_lbmonitor_binding", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbservicegroup_lbmonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbservicegroupLbmonitorBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbservicegroupLbmonitorBinding: Finished"
    }
}

function Invoke-NSDeleteGslbservicegroupLbmonitorBinding {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER Port 
        Port number of the GSLB service. Each service must have a unique port number. 
    .PARAMETER Monitor_name 
        Monitor name.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbservicegroupLbmonitorBinding -Servicegroupname <string>
        An example how to delete gslbservicegroup_lbmonitor_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbservicegroupLbmonitorBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup_lbmonitor_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Servicegroupname,

        [int]$Port,

        [string]$Monitor_name 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbservicegroupLbmonitorBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Port') ) { $arguments.Add('port', $Port) }
            if ( $PSBoundParameters.ContainsKey('Monitor_name') ) { $arguments.Add('monitor_name', $Monitor_name) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbservicegroupLbmonitorBinding: Finished"
    }
}

function Invoke-NSGetGslbservicegroupLbmonitorBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroup_lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupLbmonitorBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservicegroupLbmonitorBinding -GetAll 
        Get all gslbservicegroup_lbmonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservicegroupLbmonitorBinding -Count 
        Get the number of gslbservicegroup_lbmonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupLbmonitorBinding -name <string>
        Get gslbservicegroup_lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupLbmonitorBinding -Filter @{ 'name'='<value>' }
        Get gslbservicegroup_lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbservicegroupLbmonitorBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup_lbmonitor_binding/
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
        [string]$Servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbservicegroupLbmonitorBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservicegroup_lbmonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_lbmonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_lbmonitor_binding configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_lbmonitor_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbservicegroupLbmonitorBinding: Ended"
    }
}

function Invoke-NSGetGslbservicegroupServicegroupentitymonbindingsBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the servicegroupentitymonbindings that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroup_servicegroupentitymonbindings_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_servicegroupentitymonbindings_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupServicegroupentitymonbindingsBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservicegroupServicegroupentitymonbindingsBinding -GetAll 
        Get all gslbservicegroup_servicegroupentitymonbindings_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbservicegroupServicegroupentitymonbindingsBinding -Count 
        Get the number of gslbservicegroup_servicegroupentitymonbindings_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupServicegroupentitymonbindingsBinding -name <string>
        Get gslbservicegroup_servicegroupentitymonbindings_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbservicegroupServicegroupentitymonbindingsBinding -Filter @{ 'name'='<value>' }
        Get gslbservicegroup_servicegroupentitymonbindings_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbservicegroupServicegroupentitymonbindingsBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbservicegroup_servicegroupentitymonbindings_binding/
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
        [string]$Servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbservicegroupServicegroupentitymonbindingsBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_servicegroupentitymonbindings_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_servicegroupentitymonbindings_binding configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_servicegroupentitymonbindings_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbservicegroupServicegroupentitymonbindingsBinding: Ended"
    }
}

function Invoke-NSAddGslbsite {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB site resource.
    .PARAMETER Sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite'). 
    .PARAMETER Sitetype 
        Type of site to create. If the type is not specified, the appliance automatically detects and sets the type on the basis of the IP address being assigned to the site. If the specified site IP address is owned by the appliance (for example, a MIP address or SNIP address), the site is a local site. Otherwise, it is a remote site. 
         
        Possible values = REMOTE, LOCAL 
    .PARAMETER Siteipaddress 
        IP address for the GSLB site. The GSLB site uses this IP address to communicate with other GSLB sites. For a local site, use any IP address that is owned by the appliance (for example, a SNIP or MIP address, or the IP address of the ADNS service). 
    .PARAMETER Publicip 
        Public IP address for the local site. Required only if the appliance is deployed in a private address space and the site has a public IP address hosted on an external firewall or a NAT device. 
    .PARAMETER Metricexchange 
        Exchange metrics with other sites. Metrics are exchanged by using Metric Exchange Protocol (MEP). The appliances in the GSLB setup exchange health information once every second. 
         
        If you disable metrics exchange, you can use only static load balancing methods (such as round robin, static proximity, or the hash-based methods), and if you disable metrics exchange when a dynamic load balancing method (such as least connection) is in operation, the appliance falls back to round robin. Also, if you disable metrics exchange, you must use a monitor to determine the state of GSLB services. Otherwise, the service is marked as DOWN. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nwmetricexchange 
        Exchange, with other GSLB sites, network metrics such as round-trip time (RTT), learned from communications with various local DNS (LDNS) servers used by clients. RTT information is used in the dynamic RTT load balancing method, and is exchanged every 5 seconds. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionexchange 
        Exchange persistent session entries with other GSLB sites every five seconds. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Triggermonitor 
        Specify the conditions under which the GSLB service must be monitored by a monitor, if one is bound. Available settings function as follows: 
        * ALWAYS - Monitor the GSLB service at all times. 
        * MEPDOWN - Monitor the GSLB service only when the exchange of metrics through the Metrics Exchange Protocol (MEP) is disabled. 
        MEPDOWN_SVCDOWN - Monitor the service in either of the following situations: 
        * The exchange of metrics through MEP is disabled. 
        * The exchange of metrics through MEP is enabled but the status of the service, learned through metrics exchange, is DOWN. 
         
        Possible values = ALWAYS, MEPDOWN, MEPDOWN_SVCDOWN 
    .PARAMETER Parentsite 
        Parent site of the GSLB site, in a parent-child topology. 
    .PARAMETER Clip 
        Cluster IP address. Specify this parameter to connect to the remote cluster site for GSLB auto-sync. Note: The cluster IP address is defined when creating the cluster. 
    .PARAMETER Publicclip 
        IP address to be used to globally access the remote cluster when it is deployed behind a NAT. It can be same as the normal cluster IP address. 
    .PARAMETER Naptrreplacementsuffix 
        The naptr replacement suffix configured here will be used to construct the naptr replacement field in NAPTR record. 
    .PARAMETER Backupparentlist 
        The list of backup gslb sites configured in preferred order. Need to be parent gsb sites. 
    .PARAMETER PassThru 
        Return details about the created gslbsite item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbsite -sitename <string> -siteipaddress <string>
        An example how to add gslbsite config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbsite
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbsite/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Sitename,

        [ValidateSet('REMOTE', 'LOCAL')]
        [string]$Sitetype = 'NONE',

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Siteipaddress,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Publicip,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Metricexchange = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Nwmetricexchange = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionexchange = 'ENABLED',

        [ValidateSet('ALWAYS', 'MEPDOWN', 'MEPDOWN_SVCDOWN')]
        [string]$Triggermonitor = 'ALWAYS',

        [string]$Parentsite,

        [string]$Clip,

        [string]$Publicclip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Naptrreplacementsuffix,

        [string[]]$Backupparentlist = '"None"',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbsite: Starting"
    }
    process {
        try {
            $payload = @{ sitename = $sitename
                siteipaddress      = $siteipaddress
            }
            if ( $PSBoundParameters.ContainsKey('sitetype') ) { $payload.Add('sitetype', $sitetype) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('metricexchange') ) { $payload.Add('metricexchange', $metricexchange) }
            if ( $PSBoundParameters.ContainsKey('nwmetricexchange') ) { $payload.Add('nwmetricexchange', $nwmetricexchange) }
            if ( $PSBoundParameters.ContainsKey('sessionexchange') ) { $payload.Add('sessionexchange', $sessionexchange) }
            if ( $PSBoundParameters.ContainsKey('triggermonitor') ) { $payload.Add('triggermonitor', $triggermonitor) }
            if ( $PSBoundParameters.ContainsKey('parentsite') ) { $payload.Add('parentsite', $parentsite) }
            if ( $PSBoundParameters.ContainsKey('clip') ) { $payload.Add('clip', $clip) }
            if ( $PSBoundParameters.ContainsKey('publicclip') ) { $payload.Add('publicclip', $publicclip) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacementsuffix') ) { $payload.Add('naptrreplacementsuffix', $naptrreplacementsuffix) }
            if ( $PSBoundParameters.ContainsKey('backupparentlist') ) { $payload.Add('backupparentlist', $backupparentlist) }
            if ( $PSCmdlet.ShouldProcess("gslbsite", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbsite -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbsite -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbsite: Finished"
    }
}

function Invoke-NSDeleteGslbsite {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB site resource.
    .PARAMETER Sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite').
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbsite -Sitename <string>
        An example how to delete gslbsite config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbsite
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbsite/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Sitename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbsite: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$sitename", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbsite -NitroPath nitro/v1/config -Resource $sitename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbsite: Finished"
    }
}

function Invoke-NSUpdateGslbsite {
    <#
    .SYNOPSIS
        Update Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB site resource.
    .PARAMETER Sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite'). 
    .PARAMETER Metricexchange 
        Exchange metrics with other sites. Metrics are exchanged by using Metric Exchange Protocol (MEP). The appliances in the GSLB setup exchange health information once every second. 
         
        If you disable metrics exchange, you can use only static load balancing methods (such as round robin, static proximity, or the hash-based methods), and if you disable metrics exchange when a dynamic load balancing method (such as least connection) is in operation, the appliance falls back to round robin. Also, if you disable metrics exchange, you must use a monitor to determine the state of GSLB services. Otherwise, the service is marked as DOWN. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nwmetricexchange 
        Exchange, with other GSLB sites, network metrics such as round-trip time (RTT), learned from communications with various local DNS (LDNS) servers used by clients. RTT information is used in the dynamic RTT load balancing method, and is exchanged every 5 seconds. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionexchange 
        Exchange persistent session entries with other GSLB sites every five seconds. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Triggermonitor 
        Specify the conditions under which the GSLB service must be monitored by a monitor, if one is bound. Available settings function as follows: 
        * ALWAYS - Monitor the GSLB service at all times. 
        * MEPDOWN - Monitor the GSLB service only when the exchange of metrics through the Metrics Exchange Protocol (MEP) is disabled. 
        MEPDOWN_SVCDOWN - Monitor the service in either of the following situations: 
        * The exchange of metrics through MEP is disabled. 
        * The exchange of metrics through MEP is enabled but the status of the service, learned through metrics exchange, is DOWN. 
         
        Possible values = ALWAYS, MEPDOWN, MEPDOWN_SVCDOWN 
    .PARAMETER Naptrreplacementsuffix 
        The naptr replacement suffix configured here will be used to construct the naptr replacement field in NAPTR record. 
    .PARAMETER Backupparentlist 
        The list of backup gslb sites configured in preferred order. Need to be parent gsb sites. 
    .PARAMETER PassThru 
        Return details about the created gslbsite item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateGslbsite -sitename <string>
        An example how to update gslbsite config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateGslbsite
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbsite/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Sitename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Metricexchange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Nwmetricexchange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionexchange,

        [ValidateSet('ALWAYS', 'MEPDOWN', 'MEPDOWN_SVCDOWN')]
        [string]$Triggermonitor,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Naptrreplacementsuffix,

        [string[]]$Backupparentlist,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateGslbsite: Starting"
    }
    process {
        try {
            $payload = @{ sitename = $sitename }
            if ( $PSBoundParameters.ContainsKey('metricexchange') ) { $payload.Add('metricexchange', $metricexchange) }
            if ( $PSBoundParameters.ContainsKey('nwmetricexchange') ) { $payload.Add('nwmetricexchange', $nwmetricexchange) }
            if ( $PSBoundParameters.ContainsKey('sessionexchange') ) { $payload.Add('sessionexchange', $sessionexchange) }
            if ( $PSBoundParameters.ContainsKey('triggermonitor') ) { $payload.Add('triggermonitor', $triggermonitor) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacementsuffix') ) { $payload.Add('naptrreplacementsuffix', $naptrreplacementsuffix) }
            if ( $PSBoundParameters.ContainsKey('backupparentlist') ) { $payload.Add('backupparentlist', $backupparentlist) }
            if ( $PSCmdlet.ShouldProcess("gslbsite", "Update Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbsite -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbsite -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateGslbsite: Finished"
    }
}

function Invoke-NSUnsetGslbsite {
    <#
    .SYNOPSIS
        Unset Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for GSLB site resource.
    .PARAMETER Sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite'). 
    .PARAMETER Metricexchange 
        Exchange metrics with other sites. Metrics are exchanged by using Metric Exchange Protocol (MEP). The appliances in the GSLB setup exchange health information once every second. 
         
        If you disable metrics exchange, you can use only static load balancing methods (such as round robin, static proximity, or the hash-based methods), and if you disable metrics exchange when a dynamic load balancing method (such as least connection) is in operation, the appliance falls back to round robin. Also, if you disable metrics exchange, you must use a monitor to determine the state of GSLB services. Otherwise, the service is marked as DOWN. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nwmetricexchange 
        Exchange, with other GSLB sites, network metrics such as round-trip time (RTT), learned from communications with various local DNS (LDNS) servers used by clients. RTT information is used in the dynamic RTT load balancing method, and is exchanged every 5 seconds. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionexchange 
        Exchange persistent session entries with other GSLB sites every five seconds. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Triggermonitor 
        Specify the conditions under which the GSLB service must be monitored by a monitor, if one is bound. Available settings function as follows: 
        * ALWAYS - Monitor the GSLB service at all times. 
        * MEPDOWN - Monitor the GSLB service only when the exchange of metrics through the Metrics Exchange Protocol (MEP) is disabled. 
        MEPDOWN_SVCDOWN - Monitor the service in either of the following situations: 
        * The exchange of metrics through MEP is disabled. 
        * The exchange of metrics through MEP is enabled but the status of the service, learned through metrics exchange, is DOWN. 
         
        Possible values = ALWAYS, MEPDOWN, MEPDOWN_SVCDOWN 
    .PARAMETER Naptrreplacementsuffix 
        The naptr replacement suffix configured here will be used to construct the naptr replacement field in NAPTR record. 
    .PARAMETER Backupparentlist 
        The list of backup gslb sites configured in preferred order. Need to be parent gsb sites.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetGslbsite -sitename <string>
        An example how to unset gslbsite config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetGslbsite
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbsite
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Sitename,

        [Boolean]$metricexchange,

        [Boolean]$nwmetricexchange,

        [Boolean]$sessionexchange,

        [Boolean]$triggermonitor,

        [Boolean]$naptrreplacementsuffix,

        [Boolean]$backupparentlist 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetGslbsite: Starting"
    }
    process {
        try {
            $payload = @{ sitename = $sitename }
            if ( $PSBoundParameters.ContainsKey('metricexchange') ) { $payload.Add('metricexchange', $metricexchange) }
            if ( $PSBoundParameters.ContainsKey('nwmetricexchange') ) { $payload.Add('nwmetricexchange', $nwmetricexchange) }
            if ( $PSBoundParameters.ContainsKey('sessionexchange') ) { $payload.Add('sessionexchange', $sessionexchange) }
            if ( $PSBoundParameters.ContainsKey('triggermonitor') ) { $payload.Add('triggermonitor', $triggermonitor) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacementsuffix') ) { $payload.Add('naptrreplacementsuffix', $naptrreplacementsuffix) }
            if ( $PSBoundParameters.ContainsKey('backupparentlist') ) { $payload.Add('backupparentlist', $backupparentlist) }
            if ( $PSCmdlet.ShouldProcess("$sitename", "Unset Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type gslbsite -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetGslbsite: Finished"
    }
}

function Invoke-NSGetGslbsite {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Configuration for GSLB site resource.
    .PARAMETER Sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite'). 
    .PARAMETER GetAll 
        Retrieve all gslbsite object(s).
    .PARAMETER Count
        If specified, the count of the gslbsite object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsite
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbsite -GetAll 
        Get all gslbsite data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbsite -Count 
        Get the number of gslbsite objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsite -name <string>
        Get gslbsite object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsite -Filter @{ 'name'='<value>' }
        Get gslbsite data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbsite
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbsite/
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
        [string]$Sitename,

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
        Write-Verbose "Invoke-NSGetGslbsite: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbsite objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite configuration for property 'sitename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbsite: Ended"
    }
}

function Invoke-NSGetGslbsiteBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to gslbsite.
    .PARAMETER Sitename 
        Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retrieve all gslbsite_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbsite_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbsiteBinding -GetAll 
        Get all gslbsite_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteBinding -name <string>
        Get gslbsite_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteBinding -Filter @{ 'name'='<value>' }
        Get gslbsite_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbsiteBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbsite_binding/
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
        [string]$Sitename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbsiteBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbsite_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_binding configuration for property 'sitename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbsiteBinding: Ended"
    }
}

function Invoke-NSGetGslbsiteGslbserviceBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to gslbsite.
    .PARAMETER Sitename 
        Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retrieve all gslbsite_gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbsite_gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteGslbserviceBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbsiteGslbserviceBinding -GetAll 
        Get all gslbsite_gslbservice_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbsiteGslbserviceBinding -Count 
        Get the number of gslbsite_gslbservice_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteGslbserviceBinding -name <string>
        Get gslbsite_gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteGslbserviceBinding -Filter @{ 'name'='<value>' }
        Get gslbsite_gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbsiteGslbserviceBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbsite_gslbservice_binding/
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
        [string]$Sitename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbsiteGslbserviceBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbsite_gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_gslbservice_binding configuration for property 'sitename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_gslbservice_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbsiteGslbserviceBinding: Ended"
    }
}

function Invoke-NSGetGslbsiteGslbservicegroupBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to gslbsite.
    .PARAMETER Sitename 
        Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retrieve all gslbsite_gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbsite_gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteGslbservicegroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbsiteGslbservicegroupBinding -GetAll 
        Get all gslbsite_gslbservicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbsiteGslbservicegroupBinding -Count 
        Get the number of gslbsite_gslbservicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteGslbservicegroupBinding -name <string>
        Get gslbsite_gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteGslbservicegroupBinding -Filter @{ 'name'='<value>' }
        Get gslbsite_gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbsiteGslbservicegroupBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbsite_gslbservicegroup_binding/
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
        [string]$Sitename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbsiteGslbservicegroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbsite_gslbservicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_gslbservicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroup_binding configuration for property 'sitename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_gslbservicegroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbsiteGslbservicegroupBinding: Ended"
    }
}

function Invoke-NSGetGslbsiteGslbservicegroupmemberBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbsite.
    .PARAMETER Sitename 
        Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retrieve all gslbsite_gslbservicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbsite_gslbservicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteGslbservicegroupmemberBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbsiteGslbservicegroupmemberBinding -GetAll 
        Get all gslbsite_gslbservicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbsiteGslbservicegroupmemberBinding -Count 
        Get the number of gslbsite_gslbservicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteGslbservicegroupmemberBinding -name <string>
        Get gslbsite_gslbservicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsiteGslbservicegroupmemberBinding -Filter @{ 'name'='<value>' }
        Get gslbsite_gslbservicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbsiteGslbservicegroupmemberBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbsite_gslbservicegroupmember_binding/
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
        [string]$Sitename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbsiteGslbservicegroupmemberBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbsite_gslbservicegroupmember_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_gslbservicegroupmember_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroupmember_binding configuration for property 'sitename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbsiteGslbservicegroupmemberBinding: Ended"
    }
}

function Invoke-NSGetGslbsyncstatus {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Configuration for sync status resource.
    .PARAMETER Summary 
        sync status summary to be displayed in one line (Success/Failure), in case of Failure stating reason for failure. 
    .PARAMETER GetAll 
        Retrieve all gslbsyncstatus object(s).
    .PARAMETER Count
        If specified, the count of the gslbsyncstatus object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsyncstatus
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbsyncstatus -GetAll 
        Get all gslbsyncstatus data.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsyncstatus -name <string>
        Get gslbsyncstatus object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbsyncstatus -Filter @{ 'name'='<value>' }
        Get gslbsyncstatus data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbsyncstatus
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbsyncstatus/
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
        [boolean]$Summary,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetGslbsyncstatus: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbsyncstatus objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsyncstatus objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsyncstatus objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('summary') ) { $arguments.Add('summary', $summary) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsyncstatus configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbsyncstatus configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbsyncstatus: Ended"
    }
}

function Invoke-NSAddGslbvserver {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
         
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
    .PARAMETER Servicetype 
        Protocol used by services bound to the virtual server. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, NNTP, ANY, SIP_UDP, SIP_TCP, SIP_SSL, RADIUS, RDP, RTSP, MYSQL, MSSQL, ORACLE 
    .PARAMETER Iptype 
        The IP type for this GSLB vserver. 
         
        Possible values = IPV4, IPV6 
    .PARAMETER Dnsrecordtype 
        DNS record type to associate with the GSLB virtual server's domain name. 
         
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Lbmethod 
        Load balancing method for the GSLB virtual server. 
         
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Backupsessiontimeout 
        A non zero value enables the feature whose minimum value is 2 minutes. The feature can be disabled by setting the value to zero. The created session is in effect for a specific client per domain. 
         
        Maximum value = 1440 
    .PARAMETER Backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing method fails or cannot be used. Valid only if the primary method is based on either round-trip time (RTT) or static proximity. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Netmask 
        IPv4 network mask for use in the SOURCEIPHASH load balancing method. 
    .PARAMETER V6netmasklen 
        Number of bits to consider, in an IPv6 source IP address, for creating the hash that is required by the SOURCEIPHASH load balancing method. 
         
         
        Maximum value = 128 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        This field is applicable only if gslb method or gslb backup method are set to API. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Tolerance 
        Tolerance in milliseconds. Tolerance value is used in deciding which sites in a GSLB configuration must be considered for implementing the RTT load balancing method. The sites having the RTT value less than or equal to the sum of the lowest RTT and tolerance value are considered. NetScaler implements the round robin method of global server load balancing among these considered sites. The sites that have RTT value greater than this value are not considered. The logic is applied for each LDNS and based on the LDNS, the sites that are considered might change. For example, a site that is considered for requests coming from LDNS1 might not be considered for requests coming from LDNS2. 
         
        Maximum value = 100 
    .PARAMETER Persistencetype 
        Use source IP address based persistence for the virtual server. 
        After the load balancing method selects a service for the first packet, the IP address received in response to the DNS query is used for subsequent requests from the same client. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Persistenceid 
        The persistence ID for the GSLB virtual server. The ID is a positive integer that enables GSLB sites to identify the GSLB virtual server, and is required if source IP address based or spill over based persistence is enabled on the virtual server. 
         
        Maximum value = 65535 
    .PARAMETER Persistmask 
        The optional IPv4 network mask applied to IPv4 addresses to establish source IP address based persistence. 
    .PARAMETER V6persistmasklen 
        Number of bits to consider in an IPv6 source IP address when creating source IP address based persistence sessions. 
         
         
        Maximum value = 128 
    .PARAMETER Timeout 
        Idle time, in minutes, after which a persistence entry is cleared. 
         
         
        Maximum value = 1440 
    .PARAMETER Edr 
        Send clients an empty DNS response when the GSLB virtual server is DOWN. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecs 
        If enabled, respond with EDNS Client Subnet (ECS) option in the response for a DNS query with ECS. The ECS address will be used for persistence and spillover persistence (if enabled) instead of the LDNS address. Persistence mask is ignored if ECS is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecsaddrvalidation 
        Validate if ECS address is a private or unroutable address and in such cases, use the LDNS IP. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mir 
        Include multiple IP addresses in the DNS responses sent to clients. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disableprimaryondown 
        Continue to direct traffic to the backup chain even after the primary GSLB virtual server returns to the UP state. Used when spillover is configured for the virtual server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dynamicweight 
        Specify if the appliance should consider the service count, service weights, or ignore both when using weight-based load balancing methods. The state of the number of services bound to the virtual server help the appliance to select the service. 
         
        Possible values = SERVICECOUNT, SERVICEWEIGHT, DISABLED 
    .PARAMETER State 
        State of the GSLB virtual server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Considereffectivestate 
        If the primary state of all bound GSLB services is DOWN, consider the effective states of all the GSLB services, obtained through the Metrics Exchange Protocol (MEP), when determining the state of the GSLB virtual server. To consider the effective state, set the parameter to STATE_ONLY. To disregard the effective state, set the parameter to NONE. 
         
        The effective state of a GSLB service is the ability of the corresponding virtual server to serve traffic. The effective state of the load balancing virtual server, which is transferred to the GSLB service, is UP even if only one virtual server in the backup chain of virtual servers is in the UP state. 
         
        Possible values = NONE, STATE_ONLY 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB virtual server. 
    .PARAMETER Somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows: 
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold. 
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the GSLB virtual server exceeds the sum of the maximum client (Max Clients) settings for bound GSLB services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of the bound GSLB services. 
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the GSLB virtual server's incoming and outgoing traffic exceeds the threshold. 
        * HEALTH - Spillover occurs when the percentage of weights of the GSLB services that are UP drops below the threshold. For example, if services gslbSvc1, gslbSvc2, and gslbSvc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if gslbSvc1 and gslbSvc3 or gslbSvc2 and gslbSvc3 transition to DOWN. 
        * NONE - Spillover does not occur. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup GSLB virtual servers. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Timeout for spillover persistence, in minutes. 
         
         
        Maximum value = 1440 
    .PARAMETER Sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
         
        Maximum value = 4294967287 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Toggleorder 
        Configure this option to toggle order preference. 
         
        Possible values = ASCENDING, DESCENDING 
    .PARAMETER Orderthreshold 
        This option is used to to specify the threshold of minimum number of services to be UP in an order, for it to be considered in Lb decision. 
         
         
        Maximum value = 100 
    .PARAMETER PassThru 
        Return details about the created gslbvserver item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbvserver -name <string> -servicetype <string>
        An example how to add gslbvserver config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'NNTP', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'RADIUS', 'RDP', 'RTSP', 'MYSQL', 'MSSQL', 'ORACLE')]
        [string]$Servicetype,

        [ValidateSet('IPV4', 'IPV6')]
        [string]$Iptype = 'IPV4',

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$Dnsrecordtype = 'A',

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$Lbmethod = 'LEASTCONNECTION',

        [double]$Backupsessiontimeout,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$Backuplbmethod,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Netmask,

        [double]$V6netmasklen = '128',

        [string]$Rule = '"none"',

        [double]$Tolerance,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencetype,

        [double]$Persistenceid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [double]$V6persistmasklen = '128',

        [double]$Timeout = '2',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Edr = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ecs = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ecsaddrvalidation = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Mir = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown = 'DISABLED',

        [ValidateSet('SERVICECOUNT', 'SERVICEWEIGHT', 'DISABLED')]
        [string]$Dynamicweight = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('NONE', 'STATE_ONLY')]
        [string]$Considereffectivestate = 'NONE',

        [string]$Comment,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence = 'DISABLED',

        [double]$Sopersistencetimeout = '2',

        [double]$Sothreshold,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$Sobackupaction,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateSet('ASCENDING', 'DESCENDING')]
        [string]$Toggleorder = 'ASCENDING',

        [double]$Orderthreshold = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                servicetype    = $servicetype
            }
            if ( $PSBoundParameters.ContainsKey('iptype') ) { $payload.Add('iptype', $iptype) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('lbmethod') ) { $payload.Add('lbmethod', $lbmethod) }
            if ( $PSBoundParameters.ContainsKey('backupsessiontimeout') ) { $payload.Add('backupsessiontimeout', $backupsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('backuplbmethod') ) { $payload.Add('backuplbmethod', $backuplbmethod) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('v6netmasklen') ) { $payload.Add('v6netmasklen', $v6netmasklen) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('tolerance') ) { $payload.Add('tolerance', $tolerance) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('edr') ) { $payload.Add('edr', $edr) }
            if ( $PSBoundParameters.ContainsKey('ecs') ) { $payload.Add('ecs', $ecs) }
            if ( $PSBoundParameters.ContainsKey('ecsaddrvalidation') ) { $payload.Add('ecsaddrvalidation', $ecsaddrvalidation) }
            if ( $PSBoundParameters.ContainsKey('mir') ) { $payload.Add('mir', $mir) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('dynamicweight') ) { $payload.Add('dynamicweight', $dynamicweight) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('considereffectivestate') ) { $payload.Add('considereffectivestate', $considereffectivestate) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('toggleorder') ) { $payload.Add('toggleorder', $toggleorder) }
            if ( $PSBoundParameters.ContainsKey('orderthreshold') ) { $payload.Add('orderthreshold', $orderthreshold) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbvserver -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbvserver: Finished"
    }
}

function Invoke-NSDeleteGslbvserver {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
         
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbvserver -Name <string>
        An example how to delete gslbvserver config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteGslbvserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbvserver -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbvserver: Finished"
    }
}

function Invoke-NSUpdateGslbvserver {
    <#
    .SYNOPSIS
        Update Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
         
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
    .PARAMETER Iptype 
        The IP type for this GSLB vserver. 
         
        Possible values = IPV4, IPV6 
    .PARAMETER Dnsrecordtype 
        DNS record type to associate with the GSLB virtual server's domain name. 
         
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Backupvserver 
        Name of the backup GSLB virtual server to which the appliance should to forward requests if the status of the primary GSLB virtual server is down or exceeds its spillover threshold. 
    .PARAMETER Backupsessiontimeout 
        A non zero value enables the feature whose minimum value is 2 minutes. The feature can be disabled by setting the value to zero. The created session is in effect for a specific client per domain. 
         
        Maximum value = 1440 
    .PARAMETER Lbmethod 
        Load balancing method for the GSLB virtual server. 
         
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing method fails or cannot be used. Valid only if the primary method is based on either round-trip time (RTT) or static proximity. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Netmask 
        IPv4 network mask for use in the SOURCEIPHASH load balancing method. 
    .PARAMETER V6netmasklen 
        Number of bits to consider, in an IPv6 source IP address, for creating the hash that is required by the SOURCEIPHASH load balancing method. 
         
         
        Maximum value = 128 
    .PARAMETER Tolerance 
        Tolerance in milliseconds. Tolerance value is used in deciding which sites in a GSLB configuration must be considered for implementing the RTT load balancing method. The sites having the RTT value less than or equal to the sum of the lowest RTT and tolerance value are considered. NetScaler implements the round robin method of global server load balancing among these considered sites. The sites that have RTT value greater than this value are not considered. The logic is applied for each LDNS and based on the LDNS, the sites that are considered might change. For example, a site that is considered for requests coming from LDNS1 might not be considered for requests coming from LDNS2. 
         
        Maximum value = 100 
    .PARAMETER Persistencetype 
        Use source IP address based persistence for the virtual server. 
        After the load balancing method selects a service for the first packet, the IP address received in response to the DNS query is used for subsequent requests from the same client. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Persistenceid 
        The persistence ID for the GSLB virtual server. The ID is a positive integer that enables GSLB sites to identify the GSLB virtual server, and is required if source IP address based or spill over based persistence is enabled on the virtual server. 
         
        Maximum value = 65535 
    .PARAMETER Persistmask 
        The optional IPv4 network mask applied to IPv4 addresses to establish source IP address based persistence. 
    .PARAMETER V6persistmasklen 
        Number of bits to consider in an IPv6 source IP address when creating source IP address based persistence sessions. 
         
         
        Maximum value = 128 
    .PARAMETER Timeout 
        Idle time, in minutes, after which a persistence entry is cleared. 
         
         
        Maximum value = 1440 
    .PARAMETER Edr 
        Send clients an empty DNS response when the GSLB virtual server is DOWN. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecs 
        If enabled, respond with EDNS Client Subnet (ECS) option in the response for a DNS query with ECS. The ECS address will be used for persistence and spillover persistence (if enabled) instead of the LDNS address. Persistence mask is ignored if ECS is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecsaddrvalidation 
        Validate if ECS address is a private or unroutable address and in such cases, use the LDNS IP. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mir 
        Include multiple IP addresses in the DNS responses sent to clients. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disableprimaryondown 
        Continue to direct traffic to the backup chain even after the primary GSLB virtual server returns to the UP state. Used when spillover is configured for the virtual server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dynamicweight 
        Specify if the appliance should consider the service count, service weights, or ignore both when using weight-based load balancing methods. The state of the number of services bound to the virtual server help the appliance to select the service. 
         
        Possible values = SERVICECOUNT, SERVICEWEIGHT, DISABLED 
    .PARAMETER Considereffectivestate 
        If the primary state of all bound GSLB services is DOWN, consider the effective states of all the GSLB services, obtained through the Metrics Exchange Protocol (MEP), when determining the state of the GSLB virtual server. To consider the effective state, set the parameter to STATE_ONLY. To disregard the effective state, set the parameter to NONE. 
         
        The effective state of a GSLB service is the ability of the corresponding virtual server to serve traffic. The effective state of the load balancing virtual server, which is transferred to the GSLB service, is UP even if only one virtual server in the backup chain of virtual servers is in the UP state. 
         
        Possible values = NONE, STATE_ONLY 
    .PARAMETER Somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows: 
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold. 
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the GSLB virtual server exceeds the sum of the maximum client (Max Clients) settings for bound GSLB services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of the bound GSLB services. 
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the GSLB virtual server's incoming and outgoing traffic exceeds the threshold. 
        * HEALTH - Spillover occurs when the percentage of weights of the GSLB services that are UP drops below the threshold. For example, if services gslbSvc1, gslbSvc2, and gslbSvc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if gslbSvc1 and gslbSvc3 or gslbSvc2 and gslbSvc3 transition to DOWN. 
        * NONE - Spillover does not occur. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup GSLB virtual servers. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Timeout for spillover persistence, in minutes. 
         
         
        Maximum value = 1440 
    .PARAMETER Sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
         
        Maximum value = 4294967287 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Servicename 
        Name of the GSLB service for which to change the weight. 
    .PARAMETER Weight 
        Weight for the service. 
         
        Maximum value = 100 
    .PARAMETER Servicegroupname 
        The GSLB service group name bound to the selected GSLB virtual server. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Ttl 
        Time to live (TTL) for the domain. 
    .PARAMETER Backupip 
        The IP address of the backup service for the specified domain name. Used when all the services bound to the domain are down, or when the backup chain of virtual servers is down. 
    .PARAMETER Cookie_domain 
        The cookie domain for the GSLB site. Used when inserting the GSLB site cookie in the HTTP response. 
    .PARAMETER Cookietimeout 
        Timeout, in minutes, for the GSLB site cookie. 
         
        Maximum value = 1440 
    .PARAMETER Sitedomainttl 
        TTL, in seconds, for all internally created site domains (created when a site prefix is configured on a GSLB service) that are associated with this virtual server. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB virtual server. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        This field is applicable only if gslb method or gslb backup method are set to API. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Toggleorder 
        Configure this option to toggle order preference. 
         
        Possible values = ASCENDING, DESCENDING 
    .PARAMETER Orderthreshold 
        This option is used to to specify the threshold of minimum number of services to be UP in an order, for it to be considered in Lb decision. 
         
         
        Maximum value = 100 
    .PARAMETER Order 
        Order number to be assigned to the service when it is bound to the lb vserver. 
         
        Maximum value = 8192 
    .PARAMETER PassThru 
        Return details about the created gslbvserver item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateGslbvserver -name <string>
        An example how to update gslbvserver config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateGslbvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('IPV4', 'IPV6')]
        [string]$Iptype,

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$Dnsrecordtype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupvserver,

        [double]$Backupsessiontimeout,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$Lbmethod,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$Backuplbmethod,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Netmask,

        [double]$V6netmasklen,

        [double]$Tolerance,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencetype,

        [double]$Persistenceid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [double]$V6persistmasklen,

        [double]$Timeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Edr,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ecs,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ecsaddrvalidation,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Mir,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown,

        [ValidateSet('SERVICECOUNT', 'SERVICEWEIGHT', 'DISABLED')]
        [string]$Dynamicweight,

        [ValidateSet('NONE', 'STATE_ONLY')]
        [string]$Considereffectivestate,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence,

        [double]$Sopersistencetimeout,

        [double]$Sothreshold,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$Sobackupaction,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicename,

        [double]$Weight,

        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domainname,

        [double]$Ttl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookie_domain,

        [double]$Cookietimeout,

        [double]$Sitedomainttl,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [string]$Rule,

        [ValidateSet('ASCENDING', 'DESCENDING')]
        [string]$Toggleorder,

        [double]$Orderthreshold,

        [double]$Order,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('iptype') ) { $payload.Add('iptype', $iptype) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('backupsessiontimeout') ) { $payload.Add('backupsessiontimeout', $backupsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('lbmethod') ) { $payload.Add('lbmethod', $lbmethod) }
            if ( $PSBoundParameters.ContainsKey('backuplbmethod') ) { $payload.Add('backuplbmethod', $backuplbmethod) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('v6netmasklen') ) { $payload.Add('v6netmasklen', $v6netmasklen) }
            if ( $PSBoundParameters.ContainsKey('tolerance') ) { $payload.Add('tolerance', $tolerance) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('edr') ) { $payload.Add('edr', $edr) }
            if ( $PSBoundParameters.ContainsKey('ecs') ) { $payload.Add('ecs', $ecs) }
            if ( $PSBoundParameters.ContainsKey('ecsaddrvalidation') ) { $payload.Add('ecsaddrvalidation', $ecsaddrvalidation) }
            if ( $PSBoundParameters.ContainsKey('mir') ) { $payload.Add('mir', $mir) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('dynamicweight') ) { $payload.Add('dynamicweight', $dynamicweight) }
            if ( $PSBoundParameters.ContainsKey('considereffectivestate') ) { $payload.Add('considereffectivestate', $considereffectivestate) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $payload.Add('servicegroupname', $servicegroupname) }
            if ( $PSBoundParameters.ContainsKey('domainname') ) { $payload.Add('domainname', $domainname) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('backupip') ) { $payload.Add('backupip', $backupip) }
            if ( $PSBoundParameters.ContainsKey('cookie_domain') ) { $payload.Add('cookie_domain', $cookie_domain) }
            if ( $PSBoundParameters.ContainsKey('cookietimeout') ) { $payload.Add('cookietimeout', $cookietimeout) }
            if ( $PSBoundParameters.ContainsKey('sitedomainttl') ) { $payload.Add('sitedomainttl', $sitedomainttl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('toggleorder') ) { $payload.Add('toggleorder', $toggleorder) }
            if ( $PSBoundParameters.ContainsKey('orderthreshold') ) { $payload.Add('orderthreshold', $orderthreshold) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver", "Update Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbvserver -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateGslbvserver: Finished"
    }
}

function Invoke-NSUnsetGslbvserver {
    <#
    .SYNOPSIS
        Unset Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
         
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
    .PARAMETER Backupvserver 
        Name of the backup GSLB virtual server to which the appliance should to forward requests if the status of the primary GSLB virtual server is down or exceeds its spillover threshold. 
    .PARAMETER Sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
         
        Maximum value = 4294967287 
    .PARAMETER Servicename 
        Name of the GSLB service for which to change the weight. 
    .PARAMETER Servicegroupname 
        The GSLB service group name bound to the selected GSLB virtual server. 
    .PARAMETER Order 
        Order number to be assigned to the service when it is bound to the lb vserver. 
         
        Maximum value = 8192 
    .PARAMETER Iptype 
        The IP type for this GSLB vserver. 
         
        Possible values = IPV4, IPV6 
    .PARAMETER Dnsrecordtype 
        DNS record type to associate with the GSLB virtual server's domain name. 
         
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Backupsessiontimeout 
        A non zero value enables the feature whose minimum value is 2 minutes. The feature can be disabled by setting the value to zero. The created session is in effect for a specific client per domain. 
         
        Maximum value = 1440 
    .PARAMETER Lbmethod 
        Load balancing method for the GSLB virtual server. 
         
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing method fails or cannot be used. Valid only if the primary method is based on either round-trip time (RTT) or static proximity. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Netmask 
        IPv4 network mask for use in the SOURCEIPHASH load balancing method. 
    .PARAMETER V6netmasklen 
        Number of bits to consider, in an IPv6 source IP address, for creating the hash that is required by the SOURCEIPHASH load balancing method. 
         
         
        Maximum value = 128 
    .PARAMETER Tolerance 
        Tolerance in milliseconds. Tolerance value is used in deciding which sites in a GSLB configuration must be considered for implementing the RTT load balancing method. The sites having the RTT value less than or equal to the sum of the lowest RTT and tolerance value are considered. NetScaler implements the round robin method of global server load balancing among these considered sites. The sites that have RTT value greater than this value are not considered. The logic is applied for each LDNS and based on the LDNS, the sites that are considered might change. For example, a site that is considered for requests coming from LDNS1 might not be considered for requests coming from LDNS2. 
         
        Maximum value = 100 
    .PARAMETER Persistencetype 
        Use source IP address based persistence for the virtual server. 
        After the load balancing method selects a service for the first packet, the IP address received in response to the DNS query is used for subsequent requests from the same client. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Persistenceid 
        The persistence ID for the GSLB virtual server. The ID is a positive integer that enables GSLB sites to identify the GSLB virtual server, and is required if source IP address based or spill over based persistence is enabled on the virtual server. 
         
        Maximum value = 65535 
    .PARAMETER Persistmask 
        The optional IPv4 network mask applied to IPv4 addresses to establish source IP address based persistence. 
    .PARAMETER V6persistmasklen 
        Number of bits to consider in an IPv6 source IP address when creating source IP address based persistence sessions. 
         
         
        Maximum value = 128 
    .PARAMETER Timeout 
        Idle time, in minutes, after which a persistence entry is cleared. 
         
         
        Maximum value = 1440 
    .PARAMETER Edr 
        Send clients an empty DNS response when the GSLB virtual server is DOWN. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecs 
        If enabled, respond with EDNS Client Subnet (ECS) option in the response for a DNS query with ECS. The ECS address will be used for persistence and spillover persistence (if enabled) instead of the LDNS address. Persistence mask is ignored if ECS is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecsaddrvalidation 
        Validate if ECS address is a private or unroutable address and in such cases, use the LDNS IP. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mir 
        Include multiple IP addresses in the DNS responses sent to clients. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disableprimaryondown 
        Continue to direct traffic to the backup chain even after the primary GSLB virtual server returns to the UP state. Used when spillover is configured for the virtual server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dynamicweight 
        Specify if the appliance should consider the service count, service weights, or ignore both when using weight-based load balancing methods. The state of the number of services bound to the virtual server help the appliance to select the service. 
         
        Possible values = SERVICECOUNT, SERVICEWEIGHT, DISABLED 
    .PARAMETER Considereffectivestate 
        If the primary state of all bound GSLB services is DOWN, consider the effective states of all the GSLB services, obtained through the Metrics Exchange Protocol (MEP), when determining the state of the GSLB virtual server. To consider the effective state, set the parameter to STATE_ONLY. To disregard the effective state, set the parameter to NONE. 
         
        The effective state of a GSLB service is the ability of the corresponding virtual server to serve traffic. The effective state of the load balancing virtual server, which is transferred to the GSLB service, is UP even if only one virtual server in the backup chain of virtual servers is in the UP state. 
         
        Possible values = NONE, STATE_ONLY 
    .PARAMETER Somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows: 
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold. 
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the GSLB virtual server exceeds the sum of the maximum client (Max Clients) settings for bound GSLB services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of the bound GSLB services. 
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the GSLB virtual server's incoming and outgoing traffic exceeds the threshold. 
        * HEALTH - Spillover occurs when the percentage of weights of the GSLB services that are UP drops below the threshold. For example, if services gslbSvc1, gslbSvc2, and gslbSvc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if gslbSvc1 and gslbSvc3 or gslbSvc2 and gslbSvc3 transition to DOWN. 
        * NONE - Spillover does not occur. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup GSLB virtual servers. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Timeout for spillover persistence, in minutes. 
         
         
        Maximum value = 1440 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Weight 
        Weight for the service. 
         
        Maximum value = 100 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB virtual server. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        This field is applicable only if gslb method or gslb backup method are set to API. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Toggleorder 
        Configure this option to toggle order preference. 
         
        Possible values = ASCENDING, DESCENDING 
    .PARAMETER Orderthreshold 
        This option is used to to specify the threshold of minimum number of services to be UP in an order, for it to be considered in Lb decision. 
         
         
        Maximum value = 100
    .EXAMPLE
        PS C:\>Invoke-NSUnsetGslbvserver -name <string>
        An example how to unset gslbvserver config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetGslbvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$backupvserver,

        [Boolean]$sothreshold,

        [Boolean]$servicename,

        [Boolean]$servicegroupname,

        [Boolean]$order,

        [Boolean]$iptype,

        [Boolean]$dnsrecordtype,

        [Boolean]$backupsessiontimeout,

        [Boolean]$lbmethod,

        [Boolean]$backuplbmethod,

        [Boolean]$netmask,

        [Boolean]$v6netmasklen,

        [Boolean]$tolerance,

        [Boolean]$persistencetype,

        [Boolean]$persistenceid,

        [Boolean]$persistmask,

        [Boolean]$v6persistmasklen,

        [Boolean]$timeout,

        [Boolean]$edr,

        [Boolean]$ecs,

        [Boolean]$ecsaddrvalidation,

        [Boolean]$mir,

        [Boolean]$disableprimaryondown,

        [Boolean]$dynamicweight,

        [Boolean]$considereffectivestate,

        [Boolean]$somethod,

        [Boolean]$sopersistence,

        [Boolean]$sopersistencetimeout,

        [Boolean]$sobackupaction,

        [Boolean]$weight,

        [Boolean]$comment,

        [Boolean]$appflowlog,

        [Boolean]$rule,

        [Boolean]$toggleorder,

        [Boolean]$orderthreshold 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $payload.Add('servicegroupname', $servicegroupname) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSBoundParameters.ContainsKey('iptype') ) { $payload.Add('iptype', $iptype) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('backupsessiontimeout') ) { $payload.Add('backupsessiontimeout', $backupsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('lbmethod') ) { $payload.Add('lbmethod', $lbmethod) }
            if ( $PSBoundParameters.ContainsKey('backuplbmethod') ) { $payload.Add('backuplbmethod', $backuplbmethod) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('v6netmasklen') ) { $payload.Add('v6netmasklen', $v6netmasklen) }
            if ( $PSBoundParameters.ContainsKey('tolerance') ) { $payload.Add('tolerance', $tolerance) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('edr') ) { $payload.Add('edr', $edr) }
            if ( $PSBoundParameters.ContainsKey('ecs') ) { $payload.Add('ecs', $ecs) }
            if ( $PSBoundParameters.ContainsKey('ecsaddrvalidation') ) { $payload.Add('ecsaddrvalidation', $ecsaddrvalidation) }
            if ( $PSBoundParameters.ContainsKey('mir') ) { $payload.Add('mir', $mir) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('dynamicweight') ) { $payload.Add('dynamicweight', $dynamicweight) }
            if ( $PSBoundParameters.ContainsKey('considereffectivestate') ) { $payload.Add('considereffectivestate', $considereffectivestate) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('toggleorder') ) { $payload.Add('toggleorder', $toggleorder) }
            if ( $PSBoundParameters.ContainsKey('orderthreshold') ) { $payload.Add('orderthreshold', $orderthreshold) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type gslbvserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetGslbvserver: Finished"
    }
}

function Invoke-NSEnableGslbvserver {
    <#
    .SYNOPSIS
        Enable Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
         
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').
    .EXAMPLE
        PS C:\>Invoke-NSEnableGslbvserver -name <string>
        An example how to enable gslbvserver config Object(s).
    .NOTES
        File Name : Invoke-NSEnableGslbvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSEnableGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableGslbvserver: Finished"
    }
}

function Invoke-NSDisableGslbvserver {
    <#
    .SYNOPSIS
        Disable Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
         
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').
    .EXAMPLE
        PS C:\>Invoke-NSDisableGslbvserver -name <string>
        An example how to disable gslbvserver config Object(s).
    .NOTES
        File Name : Invoke-NSDisableGslbvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDisableGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableGslbvserver: Finished"
    }
}

function Invoke-NSRenameGslbvserver {
    <#
    .SYNOPSIS
        Rename Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
         
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
    .PARAMETER Newname 
        New name for the GSLB virtual server. 
    .PARAMETER PassThru 
        Return details about the created gslbvserver item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameGslbvserver -name <string> -newname <string>
        An example how to rename gslbvserver config Object(s).
    .NOTES
        File Name : Invoke-NSRenameGslbvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("gslbvserver", "Rename Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbvserver -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameGslbvserver: Finished"
    }
}

function Invoke-NSGetGslbvserver {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
         
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
    .PARAMETER GetAll 
        Retrieve all gslbvserver object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserver -GetAll 
        Get all gslbvserver data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserver -Count 
        Get the number of gslbvserver objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserver -name <string>
        Get gslbvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserver -Filter @{ 'name'='<value>' }
        Get gslbvserver data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbvserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver/
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
        Write-Verbose "Invoke-NSGetGslbvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbvserver objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbvserver: Ended"
    }
}

function Invoke-NSGetGslbvserverBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to gslbvserver.
    .PARAMETER Name 
        Name of the GSLB virtual server. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverBinding -GetAll 
        Get all gslbvserver_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverBinding -name <string>
        Get gslbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverBinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_binding/
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
        Write-Verbose "Invoke-NSGetGslbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbvserverBinding: Ended"
    }
}

function Invoke-NSAddGslbvserverDomainBinding {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the domain that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Ttl 
        Time to live (TTL) for the domain. 
    .PARAMETER Backupip 
        The IP address of the backup service for the specified domain name. Used when all the services bound to the domain are down, or when the backup chain of virtual servers is down. 
    .PARAMETER Cookie_domain 
        The cookie domain for the GSLB site. Used when inserting the GSLB site cookie in the HTTP response. 
    .PARAMETER Cookietimeout 
        Timeout, in minutes, for the GSLB site cookie. 
         
        Maximum value = 1440 
    .PARAMETER Sitedomainttl 
        TTL, in seconds, for all internally created site domains (created when a site prefix is configured on a GSLB service) that are associated with this virtual server. 
    .PARAMETER Order 
        Order number to be assigned to the service when it is bound to the lb vserver. 
         
        Maximum value = 8192 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_domain_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbvserverDomainBinding -name <string>
        An example how to add gslbvserver_domain_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbvserverDomainBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_domain_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Cookie_domain,

        [double]$Cookietimeout,

        [double]$Sitedomainttl,

        [double]$Order,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbvserverDomainBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('domainname') ) { $payload.Add('domainname', $domainname) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('backupip') ) { $payload.Add('backupip', $backupip) }
            if ( $PSBoundParameters.ContainsKey('cookie_domain') ) { $payload.Add('cookie_domain', $cookie_domain) }
            if ( $PSBoundParameters.ContainsKey('cookietimeout') ) { $payload.Add('cookietimeout', $cookietimeout) }
            if ( $PSBoundParameters.ContainsKey('sitedomainttl') ) { $payload.Add('sitedomainttl', $sitedomainttl) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver_domain_binding", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_domain_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbvserverDomainBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbvserverDomainBinding: Finished"
    }
}

function Invoke-NSDeleteGslbvserverDomainBinding {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the domain that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Backupipflag 
        The IP address of the backup service for the specified domain name. Used when all the services bound to the domain are down, or when the backup chain of virtual servers is down. 
    .PARAMETER Cookie_domainflag 
        The cookie domain for the GSLB site. Used when inserting the GSLB site cookie in the HTTP response.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbvserverDomainBinding -Name <string>
        An example how to delete gslbvserver_domain_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbvserverDomainBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_domain_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Domainname,

        [boolean]$Backupipflag,

        [boolean]$Cookie_domainflag 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbvserverDomainBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Domainname') ) { $arguments.Add('domainname', $Domainname) }
            if ( $PSBoundParameters.ContainsKey('Backupipflag') ) { $arguments.Add('backupipflag', $Backupipflag) }
            if ( $PSBoundParameters.ContainsKey('Cookie_domainflag') ) { $arguments.Add('cookie_domainflag', $Cookie_domainflag) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbvserverDomainBinding: Finished"
    }
}

function Invoke-NSGetGslbvserverDomainBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the domain that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_domain_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_domain_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverDomainBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverDomainBinding -GetAll 
        Get all gslbvserver_domain_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverDomainBinding -Count 
        Get the number of gslbvserver_domain_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverDomainBinding -name <string>
        Get gslbvserver_domain_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverDomainBinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_domain_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbvserverDomainBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_domain_binding/
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
        Write-Verbose "Invoke-NSGetGslbvserverDomainBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_domain_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_domain_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_domain_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_domain_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_domain_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbvserverDomainBinding: Ended"
    }
}

function Invoke-NSAddGslbvserverGslbserviceBinding {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Servicename 
        Name of the GSLB service for which to change the weight. 
    .PARAMETER Weight 
        Weight for the service. 
         
        Maximum value = 100 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Order 
        Order number to be assigned to the service when it is bound to the lb vserver. 
         
        Maximum value = 8192 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_gslbservice_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbvserverGslbserviceBinding -name <string>
        An example how to add gslbvserver_gslbservice_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbvserverGslbserviceBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_gslbservice_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Servicename,

        [double]$Weight,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domainname,

        [double]$Order,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbvserverGslbserviceBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('domainname') ) { $payload.Add('domainname', $domainname) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver_gslbservice_binding", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_gslbservice_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbvserverGslbserviceBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbvserverGslbserviceBinding: Finished"
    }
}

function Invoke-NSDeleteGslbvserverGslbserviceBinding {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Servicename 
        Name of the GSLB service for which to change the weight. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbvserverGslbserviceBinding -Name <string>
        An example how to delete gslbvserver_gslbservice_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbvserverGslbserviceBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_gslbservice_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Servicename,

        [string]$Domainname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbvserverGslbserviceBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Servicename') ) { $arguments.Add('servicename', $Servicename) }
            if ( $PSBoundParameters.ContainsKey('Domainname') ) { $arguments.Add('domainname', $Domainname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbvserverGslbserviceBinding: Finished"
    }
}

function Invoke-NSGetGslbvserverGslbserviceBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverGslbserviceBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverGslbserviceBinding -GetAll 
        Get all gslbvserver_gslbservice_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverGslbserviceBinding -Count 
        Get the number of gslbvserver_gslbservice_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverGslbserviceBinding -name <string>
        Get gslbvserver_gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverGslbserviceBinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbvserverGslbserviceBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_gslbservice_binding/
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
        Write-Verbose "Invoke-NSGetGslbvserverGslbserviceBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservice_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_gslbservice_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbvserverGslbserviceBinding: Ended"
    }
}

function Invoke-NSAddGslbvserverGslbservicegroupBinding {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Servicegroupname 
        The GSLB service group name bound to the selected GSLB virtual server. 
    .PARAMETER Order 
        Order number to be assigned to the service when it is bound to the lb vserver. 
         
        Maximum value = 8192 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_gslbservicegroup_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbvserverGslbservicegroupBinding -name <string>
        An example how to add gslbvserver_gslbservicegroup_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbvserverGslbservicegroupBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_gslbservicegroup_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Servicegroupname,

        [double]$Order,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbvserverGslbservicegroupBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $payload.Add('servicegroupname', $servicegroupname) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver_gslbservicegroup_binding", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_gslbservicegroup_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbvserverGslbservicegroupBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbvserverGslbservicegroupBinding: Finished"
    }
}

function Invoke-NSDeleteGslbvserverGslbservicegroupBinding {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Servicegroupname 
        The GSLB service group name bound to the selected GSLB virtual server.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbvserverGslbservicegroupBinding -Name <string>
        An example how to delete gslbvserver_gslbservicegroup_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbvserverGslbservicegroupBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_gslbservicegroup_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbvserverGslbservicegroupBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Servicegroupname') ) { $arguments.Add('servicegroupname', $Servicegroupname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbvserverGslbservicegroupBinding: Finished"
    }
}

function Invoke-NSGetGslbvserverGslbservicegroupBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverGslbservicegroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverGslbservicegroupBinding -GetAll 
        Get all gslbvserver_gslbservicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverGslbservicegroupBinding -Count 
        Get the number of gslbvserver_gslbservicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverGslbservicegroupBinding -name <string>
        Get gslbvserver_gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverGslbservicegroupBinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbvserverGslbservicegroupBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_gslbservicegroup_binding/
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
        Write-Verbose "Invoke-NSGetGslbvserverGslbservicegroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_gslbservicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_gslbservicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroup_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbvserverGslbservicegroupBinding: Ended"
    }
}

function Invoke-NSGetGslbvserverGslbservicegroupmemberBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_gslbservicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_gslbservicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverGslbservicegroupmemberBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverGslbservicegroupmemberBinding -GetAll 
        Get all gslbvserver_gslbservicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverGslbservicegroupmemberBinding -Count 
        Get the number of gslbvserver_gslbservicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverGslbservicegroupmemberBinding -name <string>
        Get gslbvserver_gslbservicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverGslbservicegroupmemberBinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_gslbservicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbvserverGslbservicegroupmemberBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_gslbservicegroupmember_binding/
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
        Write-Verbose "Invoke-NSGetGslbvserverGslbservicegroupmemberBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_gslbservicegroupmember_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_gslbservicegroupmember_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroupmember_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbvserverGslbservicegroupmemberBinding: Ended"
    }
}

function Invoke-NSAddGslbvserverLbpolicyBinding {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the lbpolicy that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Policyname 
        Name of the policy bound to the GSLB vserver. 
    .PARAMETER Priority 
        Priority. 
         
        Maximum value = 2147483647 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. o If gotoPriorityExpression is not present or if it is equal to END then the policy bank evaluation ends here o Else if the gotoPriorityExpression is equal to NEXT then the next policy in the priority order is evaluated. o Else gotoPriorityExpression is evaluated. The result of gotoPriorityExpression (which has to be a number) is processed as follows: - An UNDEF event is triggered if . gotoPriorityExpression cannot be evaluated . gotoPriorityExpression evaluates to number which is smaller than the maximum priority in the policy bank but is not same as any policy's priority . gotoPriorityExpression evaluates to a priority that is smaller than the current policy's priority - If the gotoPriorityExpression evaluates to the priority of the current policy then the next policy in the priority order is evaluated. - If the gotoPriorityExpression evaluates to the priority of a policy further ahead in the list then that policy will be evaluated next. This field is applicable only to rewrite and responder policies. 
    .PARAMETER Type 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Order 
        Order number to be assigned to the service when it is bound to the lb vserver. 
         
        Maximum value = 8192 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_lbpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbvserverLbpolicyBinding -name <string>
        An example how to add gslbvserver_lbpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbvserverLbpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_lbpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Type,

        [double]$Order,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbvserverLbpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver_lbpolicy_binding", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_lbpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbvserverLbpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbvserverLbpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteGslbvserverLbpolicyBinding {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the lbpolicy that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Policyname 
        Name of the policy bound to the GSLB vserver.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbvserverLbpolicyBinding -Name <string>
        An example how to delete gslbvserver_lbpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbvserverLbpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_lbpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbvserverLbpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbvserver_lbpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbvserverLbpolicyBinding: Finished"
    }
}

function Invoke-NSGetGslbvserverLbpolicyBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the lbpolicy that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_lbpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_lbpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverLbpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverLbpolicyBinding -GetAll 
        Get all gslbvserver_lbpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverLbpolicyBinding -Count 
        Get the number of gslbvserver_lbpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverLbpolicyBinding -name <string>
        Get gslbvserver_lbpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverLbpolicyBinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_lbpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbvserverLbpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_lbpolicy_binding/
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
        Write-Verbose "Invoke-NSGetGslbvserverLbpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_lbpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_lbpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_lbpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_lbpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_lbpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_lbpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_lbpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_lbpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_lbpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_lbpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbvserverLbpolicyBinding: Ended"
    }
}

function Invoke-NSAddGslbvserverSpilloverpolicyBinding {
    <#
    .SYNOPSIS
        Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Policyname 
        Name of the policy bound to the GSLB vserver. 
    .PARAMETER Priority 
        Priority. 
         
        Maximum value = 2147483647 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. o If gotoPriorityExpression is not present or if it is equal to END then the policy bank evaluation ends here o Else if the gotoPriorityExpression is equal to NEXT then the next policy in the priority order is evaluated. o Else gotoPriorityExpression is evaluated. The result of gotoPriorityExpression (which has to be a number) is processed as follows: - An UNDEF event is triggered if . gotoPriorityExpression cannot be evaluated . gotoPriorityExpression evaluates to number which is smaller than the maximum priority in the policy bank but is not same as any policy's priority . gotoPriorityExpression evaluates to a priority that is smaller than the current policy's priority - If the gotoPriorityExpression evaluates to the priority of the current policy then the next policy in the priority order is evaluated. - If the gotoPriorityExpression evaluates to the priority of a policy further ahead in the list then that policy will be evaluated next. This field is applicable only to rewrite and responder policies. 
    .PARAMETER Type 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Order 
        Order number to be assigned to the service when it is bound to the lb vserver. 
         
        Maximum value = 8192 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_spilloverpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddGslbvserverSpilloverpolicyBinding -name <string>
        An example how to add gslbvserver_spilloverpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddGslbvserverSpilloverpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_spilloverpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Type,

        [double]$Order,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddGslbvserverSpilloverpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver_spilloverpolicy_binding", "Add Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_spilloverpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetGslbvserverSpilloverpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddGslbvserverSpilloverpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteGslbvserverSpilloverpolicyBinding {
    <#
    .SYNOPSIS
        Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Policyname 
        Name of the policy bound to the GSLB vserver.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteGslbvserverSpilloverpolicyBinding -Name <string>
        An example how to delete gslbvserver_spilloverpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteGslbvserverSpilloverpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_spilloverpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteGslbvserverSpilloverpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteGslbvserverSpilloverpolicyBinding: Finished"
    }
}

function Invoke-NSGetGslbvserverSpilloverpolicyBinding {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing (GSLB) configuration. GSLB feature ensures that client requests are directed to a best performing site available in a global enterprise and distributed Internet environment. config object(s).
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_spilloverpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_spilloverpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverSpilloverpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverSpilloverpolicyBinding -GetAll 
        Get all gslbvserver_spilloverpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetGslbvserverSpilloverpolicyBinding -Count 
        Get the number of gslbvserver_spilloverpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverSpilloverpolicyBinding -name <string>
        Get gslbvserver_spilloverpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetGslbvserverSpilloverpolicyBinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_spilloverpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetGslbvserverSpilloverpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/gslb/gslbvserver_spilloverpolicy_binding/
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
        Write-Verbose "Invoke-NSGetGslbvserverSpilloverpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_spilloverpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_spilloverpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_spilloverpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetGslbvserverSpilloverpolicyBinding: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA3Lln98wVZ2Z1i
# Go72+T73ahFlZYt6Fq6ocFZ+PZgq2aCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQg7YdAAh9CzD5n87M0LXSMzHW9MLu/hrxb//H2mWOyNeQwDQYJKoZIhvcNAQEB
# BQAEggEAAB4LiIFt5gVk31tUiKPdqnQaPmIYNolR9OjN1147k/X0cgQk17nFKrRH
# eSX6ZdO/SyHPCfApmozfGAKLFEFbhoyipY37SUVSXXZa08HRUNUvNe2Ek7STZPi/
# euqeuJalwl8+IZndWUjXkzCiuB9wlS3tus6QReWjYx65KrNI+Ui+OzcRvI/7asBC
# vxZZ69w80ndRLJd3FutDXQNqxwHWRLW+pa8Nzf5lAfrNSjWHZBWDbiQY1cB1xJJQ
# Fg4lshjsAILYTkOky5I2x6/YcNLpCnJEFF54cIzj6VotNGqITtalQu0ccLWjzPN3
# p0llRrRlWgOuYlWNOUlYgh/kTslvtQ==
# SIG # End signature block
