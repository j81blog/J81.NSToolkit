function Invoke-NSRestartDbsmonitors {
    <#
    .SYNOPSIS
        Restart Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for DB monitors resource.
    .EXAMPLE
        PS C:\>Invoke-NSRestartDbsmonitors 
        An example how to restart dbsmonitors config Object(s).
    .NOTES
        File Name : Invoke-NSRestartDbsmonitors
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/dbsmonitors/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSRestartDbsmonitors: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Restart Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type dbsmonitors -Action restart -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSRestartDbsmonitors: Finished"
    }
}

function Invoke-NSUnsetExtendedmemoryparam {
    <#
    .SYNOPSIS
        Unset Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for Parameter for extended memory used by LSN and Subscriber Store resource.
    .PARAMETER Memlimit 
        Amount of Citrix ADC memory to reserve for the memory used by LSN and Subscriber Session Store feature, in multiples of 2MB. 
         
        Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetExtendedmemoryparam 
        An example how to unset extendedmemoryparam config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetExtendedmemoryparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/extendedmemoryparam
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$memlimit 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetExtendedmemoryparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSCmdlet.ShouldProcess("extendedmemoryparam", "Unset Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type extendedmemoryparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetExtendedmemoryparam: Finished"
    }
}

function Invoke-NSUpdateExtendedmemoryparam {
    <#
    .SYNOPSIS
        Update Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for Parameter for extended memory used by LSN and Subscriber Store resource.
    .PARAMETER Memlimit 
        Amount of Citrix ADC memory to reserve for the memory used by LSN and Subscriber Session Store feature, in multiples of 2MB. 
         
        Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateExtendedmemoryparam 
        An example how to update extendedmemoryparam config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateExtendedmemoryparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/extendedmemoryparam/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [double]$Memlimit 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateExtendedmemoryparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSCmdlet.ShouldProcess("extendedmemoryparam", "Update Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type extendedmemoryparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateExtendedmemoryparam: Finished"
    }
}

function Invoke-NSGetExtendedmemoryparam {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for Parameter for extended memory used by LSN and Subscriber Store resource.
    .PARAMETER GetAll 
        Retrieve all extendedmemoryparam object(s).
    .PARAMETER Count
        If specified, the count of the extendedmemoryparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetExtendedmemoryparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetExtendedmemoryparam -GetAll 
        Get all extendedmemoryparam data.
    .EXAMPLE
        PS C:\>Invoke-NSGetExtendedmemoryparam -name <string>
        Get extendedmemoryparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetExtendedmemoryparam -Filter @{ 'name'='<value>' }
        Get extendedmemoryparam data with a filter.
    .NOTES
        File Name : Invoke-NSGetExtendedmemoryparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/extendedmemoryparam/
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
        Write-Verbose "Invoke-NSGetExtendedmemoryparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all extendedmemoryparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type extendedmemoryparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for extendedmemoryparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type extendedmemoryparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving extendedmemoryparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type extendedmemoryparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving extendedmemoryparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving extendedmemoryparam configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type extendedmemoryparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetExtendedmemoryparam: Ended"
    }
}

function Invoke-NSAddLocation {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location resource.
    .PARAMETER Ipfrom 
        First IP address in the range, in dotted decimal notation. 
    .PARAMETER Ipto 
        Last IP address in the range, in dotted decimal notation. 
    .PARAMETER Preferredlocation 
        String of qualifiers, in dotted notation, describing the geographical location of the IP address range. Each qualifier is more specific than the one that precedes it, as in continent.country.region.city.isp.organization. For example, "NA.US.CA.San Jose.ATT.citrix". 
        Note: A qualifier that includes a dot (.) or space ( ) must be enclosed in double quotation marks. 
    .PARAMETER Longitude 
        Numerical value, in degrees, specifying the longitude of the geographical location of the IP address-range. 
        Note: Longitude and latitude parameters are used for selecting a service with the static proximity GSLB method. If they are not specified, selection is based on the qualifiers specified for the location. 
         
        Maximum value = 180 
    .PARAMETER Latitude 
        Numerical value, in degrees, specifying the latitude of the geographical location of the IP address-range. 
        Note: Longitude and latitude parameters are used for selecting a service with the static proximity GSLB method. If they are not specified, selection is based on the qualifiers specified for the location. 
         
        Maximum value = 90 
    .PARAMETER PassThru 
        Return details about the created location item.
    .EXAMPLE
        PS C:\>Invoke-NSAddLocation -ipfrom <string> -ipto <string> -preferredlocation <string>
        An example how to add location config Object(s).
    .NOTES
        File Name : Invoke-NSAddLocation
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/location/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Ipfrom,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipto,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Preferredlocation,

        [int]$Longitude,

        [int]$Latitude,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddLocation: Starting"
    }
    process {
        try {
            $payload = @{ ipfrom  = $ipfrom
                ipto              = $ipto
                preferredlocation = $preferredlocation
            }
            if ( $PSBoundParameters.ContainsKey('longitude') ) { $payload.Add('longitude', $longitude) }
            if ( $PSBoundParameters.ContainsKey('latitude') ) { $payload.Add('latitude', $latitude) }
            if ( $PSCmdlet.ShouldProcess("location", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type location -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetLocation -Filter $payload)
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
        Write-Verbose "Invoke-NSAddLocation: Finished"
    }
}

function Invoke-NSDeleteLocation {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location resource.
    .PARAMETER Ipfrom 
        First IP address in the range, in dotted decimal notation. 
    .PARAMETER Ipto 
        Last IP address in the range, in dotted decimal notation.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLocation -Ipfrom <string>
        An example how to delete location config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLocation
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/location/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Ipfrom,

        [string]$Ipto 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteLocation: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ipto') ) { $arguments.Add('ipto', $Ipto) }
            if ( $PSCmdlet.ShouldProcess("$ipfrom", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type location -NitroPath nitro/v1/config -Resource $ipfrom -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLocation: Finished"
    }
}

function Invoke-NSGetLocation {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for location resource.
    .PARAMETER Ipfrom 
        First IP address in the range, in dotted decimal notation. 
    .PARAMETER GetAll 
        Retrieve all location object(s).
    .PARAMETER Count
        If specified, the count of the location object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocation
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLocation -GetAll 
        Get all location data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLocation -Count 
        Get the number of location objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocation -name <string>
        Get location object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocation -Filter @{ 'name'='<value>' }
        Get location data with a filter.
    .NOTES
        File Name : Invoke-NSGetLocation
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/location/
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
        [string]$Ipfrom,

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
        Write-Verbose "Invoke-NSGetLocation: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all location objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type location -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for location objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type location -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving location objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type location -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving location configuration for property 'ipfrom'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type location -NitroPath nitro/v1/config -Resource $ipfrom -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving location configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type location -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLocation: Ended"
    }
}

function Invoke-NSClearLocationdata {
    <#
    .SYNOPSIS
        Clear Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location data resource.
    .EXAMPLE
        PS C:\>Invoke-NSClearLocationdata 
        An example how to clear locationdata config Object(s).
    .NOTES
        File Name : Invoke-NSClearLocationdata
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationdata/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSClearLocationdata: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type locationdata -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSClearLocationdata: Finished"
    }
}

function Invoke-NSImportLocationfile {
    <#
    .SYNOPSIS
        Import Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location file resource.
    .PARAMETER Locationfile 
        Name of the location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs. 
    .PARAMETER Src 
        URL \(protocol, host, path, and file name\) from where the location file will be imported. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        PS C:\>Invoke-NSImportLocationfile -Locationfile <string> -src <string>
        An example how to import locationfile config Object(s).
    .NOTES
        File Name : Invoke-NSImportLocationfile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationfile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Locationfile,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Src 

    )
    begin {
        Write-Verbose "Invoke-NSImportLocationfile: Starting"
    }
    process {
        try {
            $payload = @{ Locationfile = $Locationfile
                src                    = $src
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Import Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type locationfile -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSImportLocationfile: Finished"
    }
}

function Invoke-NSAddLocationfile {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location file resource.
    .PARAMETER Locationfile 
        Name of the location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs. 
    .PARAMETER Format 
        Format of the location file. Required for the Citrix ADC to identify how to read the location file. 
         
        Possible values = netscaler, ip-country, ip-country-isp, ip-country-region-city, ip-country-region-city-isp, geoip-country, geoip-region, geoip-city, geoip-country-org, geoip-country-isp, geoip-city-isp-org
    .EXAMPLE
        PS C:\>Invoke-NSAddLocationfile -Locationfile <string>
        An example how to add locationfile config Object(s).
    .NOTES
        File Name : Invoke-NSAddLocationfile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationfile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Locationfile,

        [ValidateSet('netscaler', 'ip-country', 'ip-country-isp', 'ip-country-region-city', 'ip-country-region-city-isp', 'geoip-country', 'geoip-region', 'geoip-city', 'geoip-country-org', 'geoip-country-isp', 'geoip-city-isp-org')]
        [string]$Format = 'netscaler' 
    )
    begin {
        Write-Verbose "Invoke-NSAddLocationfile: Starting"
    }
    process {
        try {
            $payload = @{ Locationfile = $Locationfile }
            if ( $PSBoundParameters.ContainsKey('format') ) { $payload.Add('format', $format) }
            if ( $PSCmdlet.ShouldProcess("locationfile", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type locationfile -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSAddLocationfile: Finished"
    }
}

function Invoke-NSDeleteLocationfile {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location file resource.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLocationfile 
        An example how to delete locationfile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLocationfile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationfile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSDeleteLocationfile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("locationfile", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type locationfile -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLocationfile: Finished"
    }
}

function Invoke-NSGetLocationfile {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for location file resource.
    .PARAMETER GetAll 
        Retrieve all locationfile object(s).
    .PARAMETER Count
        If specified, the count of the locationfile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocationfile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLocationfile -GetAll 
        Get all locationfile data.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocationfile -name <string>
        Get locationfile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocationfile -Filter @{ 'name'='<value>' }
        Get locationfile data with a filter.
    .NOTES
        File Name : Invoke-NSGetLocationfile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationfile/
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
        Write-Verbose "Invoke-NSGetLocationfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all locationfile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationfile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for locationfile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationfile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving locationfile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationfile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving locationfile configuration for property ''"

            } else {
                Write-Verbose "Retrieving locationfile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationfile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLocationfile: Ended"
    }
}

function Invoke-NSImportLocationfile6 {
    <#
    .SYNOPSIS
        Import Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location file6 resource.
    .PARAMETER Locationfile 
        Name of the IPv6 location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs. 
    .PARAMETER Src 
        URL \(protocol, host, path, and file name\) from where the location file will be imported. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        PS C:\>Invoke-NSImportLocationfile6 -Locationfile <string> -src <string>
        An example how to import locationfile6 config Object(s).
    .NOTES
        File Name : Invoke-NSImportLocationfile6
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationfile6/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Locationfile,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Src 

    )
    begin {
        Write-Verbose "Invoke-NSImportLocationfile6: Starting"
    }
    process {
        try {
            $payload = @{ Locationfile = $Locationfile
                src                    = $src
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Import Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type locationfile6 -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSImportLocationfile6: Finished"
    }
}

function Invoke-NSDeleteLocationfile6 {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location file6 resource.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteLocationfile6 
        An example how to delete locationfile6 config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteLocationfile6
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationfile6/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSDeleteLocationfile6: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("locationfile6", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type locationfile6 -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteLocationfile6: Finished"
    }
}

function Invoke-NSAddLocationfile6 {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location file6 resource.
    .PARAMETER Locationfile 
        Name of the IPv6 location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs. 
    .PARAMETER Format 
        Format of the IPv6 location file. Required for the Citrix ADC to identify how to read the location file. 
         
        Possible values = netscaler6, geoip-country6
    .EXAMPLE
        PS C:\>Invoke-NSAddLocationfile6 -Locationfile <string>
        An example how to add locationfile6 config Object(s).
    .NOTES
        File Name : Invoke-NSAddLocationfile6
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationfile6/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Locationfile,

        [ValidateSet('netscaler6', 'geoip-country6')]
        [string]$Format = 'netscaler6' 
    )
    begin {
        Write-Verbose "Invoke-NSAddLocationfile6: Starting"
    }
    process {
        try {
            $payload = @{ Locationfile = $Locationfile }
            if ( $PSBoundParameters.ContainsKey('format') ) { $payload.Add('format', $format) }
            if ( $PSCmdlet.ShouldProcess("locationfile6", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type locationfile6 -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSAddLocationfile6: Finished"
    }
}

function Invoke-NSGetLocationfile6 {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for location file6 resource.
    .PARAMETER GetAll 
        Retrieve all locationfile6 object(s).
    .PARAMETER Count
        If specified, the count of the locationfile6 object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocationfile6
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLocationfile6 -GetAll 
        Get all locationfile6 data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetLocationfile6 -Count 
        Get the number of locationfile6 objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocationfile6 -name <string>
        Get locationfile6 object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocationfile6 -Filter @{ 'name'='<value>' }
        Get locationfile6 data with a filter.
    .NOTES
        File Name : Invoke-NSGetLocationfile6
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationfile6/
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
        Write-Verbose "Invoke-NSGetLocationfile6: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all locationfile6 objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationfile6 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for locationfile6 objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationfile6 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving locationfile6 objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationfile6 -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving locationfile6 configuration for property ''"

            } else {
                Write-Verbose "Retrieving locationfile6 configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationfile6 -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLocationfile6: Ended"
    }
}

function Invoke-NSUnsetLocationparameter {
    <#
    .SYNOPSIS
        Unset Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location parameter resource.
    .PARAMETER Context 
        Context for describing locations. In geographic context, qualifier labels are assigned by default in the following sequence: Continent.Country.Region.City.ISP.Organization. In custom context, the qualifiers labels can have any meaning that you designate. 
        Possible values = geographic, custom 
    .PARAMETER Q1label 
        Label specifying the meaning of the first qualifier. Can be specified for custom context only. 
    .PARAMETER Q2label 
        Label specifying the meaning of the second qualifier. Can be specified for custom context only. 
    .PARAMETER Q3label 
        Label specifying the meaning of the third qualifier. Can be specified for custom context only. 
    .PARAMETER Q4label 
        Label specifying the meaning of the fourth qualifier. Can be specified for custom context only. 
    .PARAMETER Q5label 
        Label specifying the meaning of the fifth qualifier. Can be specified for custom context only. 
    .PARAMETER Q6label 
        Label specifying the meaning of the sixth qualifier. Can be specified for custom context only. 
    .PARAMETER Matchwildcardtoany 
        Indicates whether wildcard qualifiers should match any other 
        qualifier including non-wildcard while evaluating 
        location based expressions. 
        Possible values: Yes, No, Expression. 
        Yes - Wildcard qualifiers match any other qualifiers. 
        No - Wildcard qualifiers do not match non-wildcard 
        qualifiers, but match other wildcard qualifiers. 
        Expression - Wildcard qualifiers in an expression 
        match any qualifier in an LDNS location, 
        wildcard qualifiers in the LDNS location do not match 
        non-wildcard qualifiers in an expression. 
         
        Possible values = YES, NO, Expression
    .EXAMPLE
        PS C:\>Invoke-NSUnsetLocationparameter 
        An example how to unset locationparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetLocationparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$context,

        [Boolean]$q1label,

        [Boolean]$q2label,

        [Boolean]$q3label,

        [Boolean]$q4label,

        [Boolean]$q5label,

        [Boolean]$q6label,

        [Boolean]$matchwildcardtoany 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetLocationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('context') ) { $payload.Add('context', $context) }
            if ( $PSBoundParameters.ContainsKey('q1label') ) { $payload.Add('q1label', $q1label) }
            if ( $PSBoundParameters.ContainsKey('q2label') ) { $payload.Add('q2label', $q2label) }
            if ( $PSBoundParameters.ContainsKey('q3label') ) { $payload.Add('q3label', $q3label) }
            if ( $PSBoundParameters.ContainsKey('q4label') ) { $payload.Add('q4label', $q4label) }
            if ( $PSBoundParameters.ContainsKey('q5label') ) { $payload.Add('q5label', $q5label) }
            if ( $PSBoundParameters.ContainsKey('q6label') ) { $payload.Add('q6label', $q6label) }
            if ( $PSBoundParameters.ContainsKey('matchwildcardtoany') ) { $payload.Add('matchwildcardtoany', $matchwildcardtoany) }
            if ( $PSCmdlet.ShouldProcess("locationparameter", "Unset Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type locationparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetLocationparameter: Finished"
    }
}

function Invoke-NSUpdateLocationparameter {
    <#
    .SYNOPSIS
        Update Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for location parameter resource.
    .PARAMETER Context 
        Context for describing locations. In geographic context, qualifier labels are assigned by default in the following sequence: Continent.Country.Region.City.ISP.Organization. In custom context, the qualifiers labels can have any meaning that you designate. 
        Possible values = geographic, custom 
    .PARAMETER Q1label 
        Label specifying the meaning of the first qualifier. Can be specified for custom context only. 
    .PARAMETER Q2label 
        Label specifying the meaning of the second qualifier. Can be specified for custom context only. 
    .PARAMETER Q3label 
        Label specifying the meaning of the third qualifier. Can be specified for custom context only. 
    .PARAMETER Q4label 
        Label specifying the meaning of the fourth qualifier. Can be specified for custom context only. 
    .PARAMETER Q5label 
        Label specifying the meaning of the fifth qualifier. Can be specified for custom context only. 
    .PARAMETER Q6label 
        Label specifying the meaning of the sixth qualifier. Can be specified for custom context only. 
    .PARAMETER Matchwildcardtoany 
        Indicates whether wildcard qualifiers should match any other 
        qualifier including non-wildcard while evaluating 
        location based expressions. 
        Possible values: Yes, No, Expression. 
        Yes - Wildcard qualifiers match any other qualifiers. 
        No - Wildcard qualifiers do not match non-wildcard 
        qualifiers, but match other wildcard qualifiers. 
        Expression - Wildcard qualifiers in an expression 
        match any qualifier in an LDNS location, 
        wildcard qualifiers in the LDNS location do not match 
        non-wildcard qualifiers in an expression. 
         
        Possible values = YES, NO, Expression
    .EXAMPLE
        PS C:\>Invoke-NSUpdateLocationparameter 
        An example how to update locationparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateLocationparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateSet('geographic', 'custom')]
        [string]$Context,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q1label,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q2label,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q3label,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q4label,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q5label,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q6label,

        [ValidateSet('YES', 'NO', 'Expression')]
        [string]$Matchwildcardtoany 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateLocationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('context') ) { $payload.Add('context', $context) }
            if ( $PSBoundParameters.ContainsKey('q1label') ) { $payload.Add('q1label', $q1label) }
            if ( $PSBoundParameters.ContainsKey('q2label') ) { $payload.Add('q2label', $q2label) }
            if ( $PSBoundParameters.ContainsKey('q3label') ) { $payload.Add('q3label', $q3label) }
            if ( $PSBoundParameters.ContainsKey('q4label') ) { $payload.Add('q4label', $q4label) }
            if ( $PSBoundParameters.ContainsKey('q5label') ) { $payload.Add('q5label', $q5label) }
            if ( $PSBoundParameters.ContainsKey('q6label') ) { $payload.Add('q6label', $q6label) }
            if ( $PSBoundParameters.ContainsKey('matchwildcardtoany') ) { $payload.Add('matchwildcardtoany', $matchwildcardtoany) }
            if ( $PSCmdlet.ShouldProcess("locationparameter", "Update Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type locationparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateLocationparameter: Finished"
    }
}

function Invoke-NSGetLocationparameter {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for location parameter resource.
    .PARAMETER GetAll 
        Retrieve all locationparameter object(s).
    .PARAMETER Count
        If specified, the count of the locationparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocationparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetLocationparameter -GetAll 
        Get all locationparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocationparameter -name <string>
        Get locationparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetLocationparameter -Filter @{ 'name'='<value>' }
        Get locationparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetLocationparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/locationparameter/
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
        Write-Verbose "Invoke-NSGetLocationparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all locationparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for locationparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving locationparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving locationparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving locationparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type locationparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetLocationparameter: Ended"
    }
}

function Invoke-NSGetNstrace {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for nstrace operations resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all nstrace object(s).
    .PARAMETER Count
        If specified, the count of the nstrace object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetNstrace
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetNstrace -GetAll 
        Get all nstrace data.
    .EXAMPLE
        PS C:\>Invoke-NSGetNstrace -name <string>
        Get nstrace object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetNstrace -Filter @{ 'name'='<value>' }
        Get nstrace data with a filter.
    .NOTES
        File Name : Invoke-NSGetNstrace
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/nstrace/
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
        Write-Verbose "Invoke-NSGetNstrace: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nstrace objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type nstrace -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nstrace objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type nstrace -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nstrace objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type nstrace -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nstrace configuration for property ''"

            } else {
                Write-Verbose "Retrieving nstrace configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type nstrace -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetNstrace: Ended"
    }
}

function Invoke-NSDeleteRadiusnode {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for RADIUS Node resource.
    .PARAMETER Nodeprefix 
        IP address/IP prefix of radius node in CIDR format.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteRadiusnode -Nodeprefix <string>
        An example how to delete radiusnode config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteRadiusnode
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/radiusnode/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Nodeprefix 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteRadiusnode: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$nodeprefix", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type radiusnode -NitroPath nitro/v1/config -Resource $nodeprefix -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteRadiusnode: Finished"
    }
}

function Invoke-NSAddRadiusnode {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for RADIUS Node resource.
    .PARAMETER Nodeprefix 
        IP address/IP prefix of radius node in CIDR format. 
    .PARAMETER Radkey 
        The key shared between the RADIUS server and clients. 
        Required for Citrix ADC to communicate with the RADIUS nodes. 
    .PARAMETER PassThru 
        Return details about the created radiusnode item.
    .EXAMPLE
        PS C:\>Invoke-NSAddRadiusnode -nodeprefix <string> -radkey <string>
        An example how to add radiusnode config Object(s).
    .NOTES
        File Name : Invoke-NSAddRadiusnode
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/radiusnode/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Nodeprefix,

        [Parameter(Mandatory)]
        [string]$Radkey,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddRadiusnode: Starting"
    }
    process {
        try {
            $payload = @{ nodeprefix = $nodeprefix
                radkey               = $radkey
            }

            if ( $PSCmdlet.ShouldProcess("radiusnode", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type radiusnode -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetRadiusnode -Filter $payload)
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
        Write-Verbose "Invoke-NSAddRadiusnode: Finished"
    }
}

function Invoke-NSUpdateRadiusnode {
    <#
    .SYNOPSIS
        Update Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for RADIUS Node resource.
    .PARAMETER Nodeprefix 
        IP address/IP prefix of radius node in CIDR format. 
    .PARAMETER Radkey 
        The key shared between the RADIUS server and clients. 
        Required for Citrix ADC to communicate with the RADIUS nodes. 
    .PARAMETER PassThru 
        Return details about the created radiusnode item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateRadiusnode -nodeprefix <string>
        An example how to update radiusnode config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateRadiusnode
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/radiusnode/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Nodeprefix,

        [string]$Radkey,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateRadiusnode: Starting"
    }
    process {
        try {
            $payload = @{ nodeprefix = $nodeprefix }
            if ( $PSBoundParameters.ContainsKey('radkey') ) { $payload.Add('radkey', $radkey) }
            if ( $PSCmdlet.ShouldProcess("radiusnode", "Update Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type radiusnode -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetRadiusnode -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateRadiusnode: Finished"
    }
}

function Invoke-NSGetRadiusnode {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for RADIUS Node resource.
    .PARAMETER Nodeprefix 
        IP address/IP prefix of radius node in CIDR format. 
    .PARAMETER GetAll 
        Retrieve all radiusnode object(s).
    .PARAMETER Count
        If specified, the count of the radiusnode object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetRadiusnode
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetRadiusnode -GetAll 
        Get all radiusnode data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetRadiusnode -Count 
        Get the number of radiusnode objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetRadiusnode -name <string>
        Get radiusnode object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetRadiusnode -Filter @{ 'name'='<value>' }
        Get radiusnode data with a filter.
    .NOTES
        File Name : Invoke-NSGetRadiusnode
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/radiusnode/
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
        [string]$Nodeprefix,

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
        Write-Verbose "Invoke-NSGetRadiusnode: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all radiusnode objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type radiusnode -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for radiusnode objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type radiusnode -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving radiusnode objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type radiusnode -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving radiusnode configuration for property 'nodeprefix'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type radiusnode -NitroPath nitro/v1/config -Resource $nodeprefix -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving radiusnode configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type radiusnode -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetRadiusnode: Ended"
    }
}

function Invoke-NSEnableReporting {
    <#
    .SYNOPSIS
        Enable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for reporting resource.
    .EXAMPLE
        PS C:\>Invoke-NSEnableReporting 
        An example how to enable reporting config Object(s).
    .NOTES
        File Name : Invoke-NSEnableReporting
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/reporting/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSEnableReporting: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type reporting -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableReporting: Finished"
    }
}

function Invoke-NSDisableReporting {
    <#
    .SYNOPSIS
        Disable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for reporting resource.
    .EXAMPLE
        PS C:\>Invoke-NSDisableReporting 
        An example how to disable reporting config Object(s).
    .NOTES
        File Name : Invoke-NSDisableReporting
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/reporting/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSDisableReporting: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type reporting -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableReporting: Finished"
    }
}

function Invoke-NSGetReporting {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for reporting resource.
    .PARAMETER GetAll 
        Retrieve all reporting object(s).
    .PARAMETER Count
        If specified, the count of the reporting object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetReporting
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetReporting -GetAll 
        Get all reporting data.
    .EXAMPLE
        PS C:\>Invoke-NSGetReporting -name <string>
        Get reporting object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetReporting -Filter @{ 'name'='<value>' }
        Get reporting data with a filter.
    .NOTES
        File Name : Invoke-NSGetReporting
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/reporting/
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
        Write-Verbose "Invoke-NSGetReporting: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all reporting objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type reporting -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for reporting objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type reporting -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving reporting objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type reporting -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving reporting configuration for property ''"

            } else {
                Write-Verbose "Retrieving reporting configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type reporting -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetReporting: Ended"
    }
}

function Invoke-NSDeleteReportingconfig {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for reporting config resource.
    .PARAMETER Entitytypes 
        Object type of the entity. 
        Possible values = appfwpolicy, appfwpolicylabel, appfwprofile, appqoepolicy, authenticationloginschemapolicy, authenticationoauthidppolicy, authenticationpolicy, authenticationpolicylabel, authenticationsamlidppolicy, authenticationvserver, authorizationpolicylabel, botpolicy, botpolicylabel, botprofile, cachecontentgroup, cachepolicy, cachepolicylabel, cmppolicy, cmppolicylabel, contentinspectionpolicy, contentinspectionpolicylabel, crvserver, csvserver, dnspolicylabel, dnsrecords, dospolicy, gslbdomain, gslbservice, gslbservicegroup, gslbservicegroupmember, gslbsite, gslbvserver, inat, inatsession, lbvserver, lldp, nsacl, nsacl6, nslimitidentifier, nsmemory, nspbr, nspbr6, pcpserver, responderpolicy, responderpolicylabel, rewritepolicy, rewritepolicylabel, rnatip, service, servicegroup, servicegroupmember, spilloverpolicy, sslvserver, tmsessionpolicy, tmtrafficpolicy, tunnelip, tunnelip6, uservserver, videooptimizationdetectionpolicy, videooptimizationdetectionpolicylabel, videooptimizationpacingpolicy, videooptimizationpacingpolicylabel, vlan, vxlan 
    .PARAMETER Name 
        Name of the entity.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteReportingconfig -Entitytypes <string>
        An example how to delete reportingconfig config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteReportingconfig
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/reportingconfig/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [string]$Entitytypes,

        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteReportingconfig: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSCmdlet.ShouldProcess("$entitytypes", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type reportingconfig -NitroPath nitro/v1/config -Resource $entitytypes -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteReportingconfig: Finished"
    }
}

function Invoke-NSAddReportingconfig {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for reporting config resource.
    .PARAMETER Entitytypes 
        Object type of the entity. 
        Possible values = appfwpolicy, appfwpolicylabel, appfwprofile, appqoepolicy, authenticationloginschemapolicy, authenticationoauthidppolicy, authenticationpolicy, authenticationpolicylabel, authenticationsamlidppolicy, authenticationvserver, authorizationpolicylabel, botpolicy, botpolicylabel, botprofile, cachecontentgroup, cachepolicy, cachepolicylabel, cmppolicy, cmppolicylabel, contentinspectionpolicy, contentinspectionpolicylabel, crvserver, csvserver, dnspolicylabel, dnsrecords, dospolicy, gslbdomain, gslbservice, gslbservicegroup, gslbservicegroupmember, gslbsite, gslbvserver, inat, inatsession, lbvserver, lldp, nsacl, nsacl6, nslimitidentifier, nsmemory, nspbr, nspbr6, pcpserver, responderpolicy, responderpolicylabel, rewritepolicy, rewritepolicylabel, rnatip, service, servicegroup, servicegroupmember, spilloverpolicy, sslvserver, tmsessionpolicy, tmtrafficpolicy, tunnelip, tunnelip6, uservserver, videooptimizationdetectionpolicy, videooptimizationdetectionpolicylabel, videooptimizationpacingpolicy, videooptimizationpacingpolicylabel, vlan, vxlan 
    .PARAMETER Name 
        Name of the entity. 
    .PARAMETER PassThru 
        Return details about the created reportingconfig item.
    .EXAMPLE
        PS C:\>Invoke-NSAddReportingconfig -entitytypes <string>
        An example how to add reportingconfig config Object(s).
    .NOTES
        File Name : Invoke-NSAddReportingconfig
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/reportingconfig/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Parameter(Mandatory)]
        [ValidateSet('appfwpolicy', 'appfwpolicylabel', 'appfwprofile', 'appqoepolicy', 'authenticationloginschemapolicy', 'authenticationoauthidppolicy', 'authenticationpolicy', 'authenticationpolicylabel', 'authenticationsamlidppolicy', 'authenticationvserver', 'authorizationpolicylabel', 'botpolicy', 'botpolicylabel', 'botprofile', 'cachecontentgroup', 'cachepolicy', 'cachepolicylabel', 'cmppolicy', 'cmppolicylabel', 'contentinspectionpolicy', 'contentinspectionpolicylabel', 'crvserver', 'csvserver', 'dnspolicylabel', 'dnsrecords', 'dospolicy', 'gslbdomain', 'gslbservice', 'gslbservicegroup', 'gslbservicegroupmember', 'gslbsite', 'gslbvserver', 'inat', 'inatsession', 'lbvserver', 'lldp', 'nsacl', 'nsacl6', 'nslimitidentifier', 'nsmemory', 'nspbr', 'nspbr6', 'pcpserver', 'responderpolicy', 'responderpolicylabel', 'rewritepolicy', 'rewritepolicylabel', 'rnatip', 'service', 'servicegroup', 'servicegroupmember', 'spilloverpolicy', 'sslvserver', 'tmsessionpolicy', 'tmtrafficpolicy', 'tunnelip', 'tunnelip6', 'uservserver', 'videooptimizationdetectionpolicy', 'videooptimizationdetectionpolicylabel', 'videooptimizationpacingpolicy', 'videooptimizationpacingpolicylabel', 'vlan', 'vxlan')]
        [string]$Entitytypes,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddReportingconfig: Starting"
    }
    process {
        try {
            $payload = @{ entitytypes = $entitytypes }
            if ( $PSBoundParameters.ContainsKey('name') ) { $payload.Add('name', $name) }
            if ( $PSCmdlet.ShouldProcess("reportingconfig", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type reportingconfig -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetReportingconfig -Filter $payload)
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
        Write-Verbose "Invoke-NSAddReportingconfig: Finished"
    }
}

function Invoke-NSGetReportingconfig {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for reporting config resource.
    .PARAMETER Entitytypes 
        Object type of the entity. 
        Possible values = appfwpolicy, appfwpolicylabel, appfwprofile, appqoepolicy, authenticationloginschemapolicy, authenticationoauthidppolicy, authenticationpolicy, authenticationpolicylabel, authenticationsamlidppolicy, authenticationvserver, authorizationpolicylabel, botpolicy, botpolicylabel, botprofile, cachecontentgroup, cachepolicy, cachepolicylabel, cmppolicy, cmppolicylabel, contentinspectionpolicy, contentinspectionpolicylabel, crvserver, csvserver, dnspolicylabel, dnsrecords, dospolicy, gslbdomain, gslbservice, gslbservicegroup, gslbservicegroupmember, gslbsite, gslbvserver, inat, inatsession, lbvserver, lldp, nsacl, nsacl6, nslimitidentifier, nsmemory, nspbr, nspbr6, pcpserver, responderpolicy, responderpolicylabel, rewritepolicy, rewritepolicylabel, rnatip, service, servicegroup, servicegroupmember, spilloverpolicy, sslvserver, tmsessionpolicy, tmtrafficpolicy, tunnelip, tunnelip6, uservserver, videooptimizationdetectionpolicy, videooptimizationdetectionpolicylabel, videooptimizationpacingpolicy, videooptimizationpacingpolicylabel, vlan, vxlan 
    .PARAMETER GetAll 
        Retrieve all reportingconfig object(s).
    .PARAMETER Count
        If specified, the count of the reportingconfig object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetReportingconfig
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetReportingconfig -GetAll 
        Get all reportingconfig data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetReportingconfig -Count 
        Get the number of reportingconfig objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetReportingconfig -name <string>
        Get reportingconfig object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetReportingconfig -Filter @{ 'name'='<value>' }
        Get reportingconfig data with a filter.
    .NOTES
        File Name : Invoke-NSGetReportingconfig
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/reportingconfig/
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
        [ValidateSet('appfwpolicy', 'appfwpolicylabel', 'appfwprofile', 'appqoepolicy', 'authenticationloginschemapolicy', 'authenticationoauthidppolicy', 'authenticationpolicy', 'authenticationpolicylabel', 'authenticationsamlidppolicy', 'authenticationvserver', 'authorizationpolicylabel', 'botpolicy', 'botpolicylabel', 'botprofile', 'cachecontentgroup', 'cachepolicy', 'cachepolicylabel', 'cmppolicy', 'cmppolicylabel', 'contentinspectionpolicy', 'contentinspectionpolicylabel', 'crvserver', 'csvserver', 'dnspolicylabel', 'dnsrecords', 'dospolicy', 'gslbdomain', 'gslbservice', 'gslbservicegroup', 'gslbservicegroupmember', 'gslbsite', 'gslbvserver', 'inat', 'inatsession', 'lbvserver', 'lldp', 'nsacl', 'nsacl6', 'nslimitidentifier', 'nsmemory', 'nspbr', 'nspbr6', 'pcpserver', 'responderpolicy', 'responderpolicylabel', 'rewritepolicy', 'rewritepolicylabel', 'rnatip', 'service', 'servicegroup', 'servicegroupmember', 'spilloverpolicy', 'sslvserver', 'tmsessionpolicy', 'tmtrafficpolicy', 'tunnelip', 'tunnelip6', 'uservserver', 'videooptimizationdetectionpolicy', 'videooptimizationdetectionpolicylabel', 'videooptimizationpacingpolicy', 'videooptimizationpacingpolicylabel', 'vlan', 'vxlan')]
        [string]$Entitytypes,

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
        Write-Verbose "Invoke-NSGetReportingconfig: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all reportingconfig objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type reportingconfig -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for reportingconfig objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type reportingconfig -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving reportingconfig objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type reportingconfig -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving reportingconfig configuration for property 'entitytypes'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type reportingconfig -NitroPath nitro/v1/config -Resource $entitytypes -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving reportingconfig configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type reportingconfig -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetReportingconfig: Ended"
    }
}

function Invoke-NSRenameServer {
    <#
    .SYNOPSIS
        Rename Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER Newname 
        New name for the server. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created server item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameServer -name <string> -newname <string>
        An example how to rename server config Object(s).
    .NOTES
        File Name : Invoke-NSRenameServer
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSRenameServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("server", "Rename Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type server -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetServer -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameServer: Finished"
    }
}

function Invoke-NSDisableServer {
    <#
    .SYNOPSIS
        Disable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER Delay 
        Time, in seconds, after which all the services configured on the server are disabled. 
    .PARAMETER Graceful 
        Shut down gracefully, without accepting any new connections, and disabling each service when all of its connections are closed. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSDisableServer -name <string>
        An example how to disable server config Object(s).
    .NOTES
        File Name : Invoke-NSDisableServer
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [double]$Delay,

        [ValidateSet('YES', 'NO')]
        [string]$Graceful 

    )
    begin {
        Write-Verbose "Invoke-NSDisableServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('graceful') ) { $payload.Add('graceful', $graceful) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type server -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableServer: Finished"
    }
}

function Invoke-NSEnableServer {
    <#
    .SYNOPSIS
        Enable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created.
    .EXAMPLE
        PS C:\>Invoke-NSEnableServer -name <string>
        An example how to enable server config Object(s).
    .NOTES
        File Name : Invoke-NSEnableServer
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSEnableServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type server -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableServer: Finished"
    }
}

function Invoke-NSUnsetServer {
    <#
    .SYNOPSIS
        Unset Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER Comment 
        Any information about the server.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetServer -name <string>
        An example how to unset server config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetServer
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type server -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetServer: Finished"
    }
}

function Invoke-NSUpdateServer {
    <#
    .SYNOPSIS
        Update Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER Ipaddress 
        IPv4 or IPv6 address of the server. If you create an IP address based server, you can specify the name of the server, instead of its IP address, when creating a service. Note: If you do not create a server entry, the server IP address that you enter when you create a service becomes the name of the server. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC must wait, after DNS resolution fails, before sending the next DNS query to resolve the domain name. 
         
         
        Maximum value = 20939 
    .PARAMETER Translationip 
        IP address used to transform the server's DNS-resolved IP address. 
    .PARAMETER Translationmask 
        The netmask of the translation ip. 
    .PARAMETER Domainresolvenow 
        Immediately send a DNS query to resolve the server's domain name. 
    .PARAMETER Comment 
        Any information about the server. 
    .PARAMETER PassThru 
        Return details about the created server item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateServer -name <string>
        An example how to update server config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateServer
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Ipaddress,

        [int]$Domainresolveretry,

        [string]$Translationip,

        [string]$Translationmask,

        [boolean]$Domainresolvenow,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('translationip') ) { $payload.Add('translationip', $translationip) }
            if ( $PSBoundParameters.ContainsKey('translationmask') ) { $payload.Add('translationmask', $translationmask) }
            if ( $PSBoundParameters.ContainsKey('domainresolvenow') ) { $payload.Add('domainresolvenow', $domainresolvenow) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("server", "Update Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type server -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetServer -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateServer: Finished"
    }
}

function Invoke-NSDeleteServer {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteServer -Name <string>
        An example how to delete server config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteServer
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteServer: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type server -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteServer: Finished"
    }
}

function Invoke-NSAddServer {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER Ipaddress 
        IPv4 or IPv6 address of the server. If you create an IP address based server, you can specify the name of the server, instead of its IP address, when creating a service. Note: If you do not create a server entry, the server IP address that you enter when you create a service becomes the name of the server. 
    .PARAMETER Domain 
        Domain name of the server. For a domain based configuration, you must create the server first. 
    .PARAMETER Translationip 
        IP address used to transform the server's DNS-resolved IP address. 
    .PARAMETER Translationmask 
        The netmask of the translation ip. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC must wait, after DNS resolution fails, before sending the next DNS query to resolve the domain name. 
         
         
        Maximum value = 20939 
    .PARAMETER State 
        Initial state of the server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ipv6address 
        Support IPv6 addressing mode. If you configure a server with the IPv6 addressing mode, you cannot use the server in the IPv4 addressing mode. 
         
        Possible values = YES, NO 
    .PARAMETER Comment 
        Any information about the server. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
         
        Maximum value = 4094 
    .PARAMETER Querytype 
        Specify the type of DNS resolution to be done on the configured domain to get the backend services. Valid query types are A, AAAA and SRV with A being the default querytype. The type of DNS resolution done on the domains in SRV records is inherited from ipv6 argument. 
         
        Possible values = A, AAAA, SRV 
    .PARAMETER PassThru 
        Return details about the created server item.
    .EXAMPLE
        PS C:\>Invoke-NSAddServer -name <string>
        An example how to add server config Object(s).
    .NOTES
        File Name : Invoke-NSAddServer
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Ipaddress,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [string]$Translationip,

        [string]$Translationmask,

        [int]$Domainresolveretry = '5',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('YES', 'NO')]
        [string]$Ipv6address = 'NO',

        [string]$Comment,

        [double]$Td,

        [ValidateSet('A', 'AAAA', 'SRV')]
        [string]$Querytype = 'A',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('translationip') ) { $payload.Add('translationip', $translationip) }
            if ( $PSBoundParameters.ContainsKey('translationmask') ) { $payload.Add('translationmask', $translationmask) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('ipv6address') ) { $payload.Add('ipv6address', $ipv6address) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('querytype') ) { $payload.Add('querytype', $querytype) }
            if ( $PSCmdlet.ShouldProcess("server", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type server -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetServer -Filter $payload)
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
        Write-Verbose "Invoke-NSAddServer: Finished"
    }
}

function Invoke-NSGetServer {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER GetAll 
        Retrieve all server object(s).
    .PARAMETER Count
        If specified, the count of the server object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServer
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServer -GetAll 
        Get all server data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServer -Count 
        Get the number of server objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServer -name <string>
        Get server object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServer -Filter @{ 'name'='<value>' }
        Get server data with a filter.
    .NOTES
        File Name : Invoke-NSGetServer
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server/
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
        Write-Verbose "Invoke-NSGetServer: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all server objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServer: Ended"
    }
}

function Invoke-NSGetServerBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to server.
    .PARAMETER Name 
        Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retrieve all server_binding object(s).
    .PARAMETER Count
        If specified, the count of the server_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServerBinding -GetAll 
        Get all server_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerBinding -name <string>
        Get server_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerBinding -Filter @{ 'name'='<value>' }
        Get server_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServerBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server_binding/
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
        Write-Verbose "Invoke-NSGetServerBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all server_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServerBinding: Ended"
    }
}

function Invoke-NSGetServerGslbserviceBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to server.
    .PARAMETER Name 
        Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retrieve all server_gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the server_gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerGslbserviceBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServerGslbserviceBinding -GetAll 
        Get all server_gslbservice_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServerGslbserviceBinding -Count 
        Get the number of server_gslbservice_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerGslbserviceBinding -name <string>
        Get server_gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerGslbserviceBinding -Filter @{ 'name'='<value>' }
        Get server_gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServerGslbserviceBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server_gslbservice_binding/
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
        Write-Verbose "Invoke-NSGetServerGslbserviceBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all server_gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_gslbservice_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_gslbservice_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_gslbservice_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServerGslbserviceBinding: Ended"
    }
}

function Invoke-NSGetServerGslbservicegroupBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to server.
    .PARAMETER Name 
        Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retrieve all server_gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the server_gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerGslbservicegroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServerGslbservicegroupBinding -GetAll 
        Get all server_gslbservicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServerGslbservicegroupBinding -Count 
        Get the number of server_gslbservicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerGslbservicegroupBinding -name <string>
        Get server_gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerGslbservicegroupBinding -Filter @{ 'name'='<value>' }
        Get server_gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServerGslbservicegroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server_gslbservicegroup_binding/
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
        Write-Verbose "Invoke-NSGetServerGslbservicegroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all server_gslbservicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_gslbservicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_gslbservicegroup_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_gslbservicegroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServerGslbservicegroupBinding: Ended"
    }
}

function Invoke-NSGetServerServiceBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object showing the service that can be bound to server.
    .PARAMETER Name 
        Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retrieve all server_service_binding object(s).
    .PARAMETER Count
        If specified, the count of the server_service_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerServiceBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServerServiceBinding -GetAll 
        Get all server_service_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServerServiceBinding -Count 
        Get the number of server_service_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerServiceBinding -name <string>
        Get server_service_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerServiceBinding -Filter @{ 'name'='<value>' }
        Get server_service_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServerServiceBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server_service_binding/
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
        Write-Verbose "Invoke-NSGetServerServiceBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all server_service_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_service_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_service_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_service_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_service_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_service_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_service_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_service_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServerServiceBinding: Ended"
    }
}

function Invoke-NSGetServerServicegroupBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object showing the servicegroup that can be bound to server.
    .PARAMETER Name 
        Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retrieve all server_servicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the server_servicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerServicegroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServerServicegroupBinding -GetAll 
        Get all server_servicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServerServicegroupBinding -Count 
        Get the number of server_servicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerServicegroupBinding -name <string>
        Get server_servicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServerServicegroupBinding -Filter @{ 'name'='<value>' }
        Get server_servicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServerServicegroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/server_servicegroup_binding/
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
        Write-Verbose "Invoke-NSGetServerServicegroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all server_servicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_servicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_servicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_servicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_servicegroup_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_servicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_servicegroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type server_servicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServerServicegroupBinding: Ended"
    }
}

function Invoke-NSRenameService {
    <#
    .SYNOPSIS
        Rename Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER Newname 
        New name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created service item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameService -name <string> -newname <string>
        An example how to rename service config Object(s).
    .NOTES
        File Name : Invoke-NSRenameService
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSRenameService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("service", "Rename Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type service -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetService -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameService: Finished"
    }
}

function Invoke-NSEnableService {
    <#
    .SYNOPSIS
        Enable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created.
    .EXAMPLE
        PS C:\>Invoke-NSEnableService -name <string>
        An example how to enable service config Object(s).
    .NOTES
        File Name : Invoke-NSEnableService
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSEnableService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type service -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableService: Finished"
    }
}

function Invoke-NSDisableService {
    <#
    .SYNOPSIS
        Disable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER Delay 
        Time, in seconds, allocated to the Citrix ADC for a graceful shutdown of the service. During this period, new requests are sent to the service only for clients who already have persistent sessions on the appliance. Requests from new clients are load balanced among other available services. After the delay time expires, no requests are sent to the service, and the service is marked as unavailable (OUT OF SERVICE). 
    .PARAMETER Graceful 
        Shut down gracefully, not accepting any new connections, and disabling the service when all of its connections are closed. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSDisableService -name <string>
        An example how to disable service config Object(s).
    .NOTES
        File Name : Invoke-NSDisableService
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [double]$Delay,

        [ValidateSet('YES', 'NO')]
        [string]$Graceful 

    )
    begin {
        Write-Verbose "Invoke-NSDisableService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('graceful') ) { $payload.Add('graceful', $graceful) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type service -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableService: Finished"
    }
}

function Invoke-NSUnsetService {
    <#
    .SYNOPSIS
        Unset Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections to the service. 
         
        Maximum value = 4294967294 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service. 
        Note: Connection requests beyond this value are rejected. 
         
        Maximum value = 65535 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward requests to the cache server. 
        Note: Do not specify this parameter if you set the Cache Type parameter. 
         
        Possible values = YES, NO 
    .PARAMETER Cip 
        Before forwarding a request to the service, insert an HTTP header with the client's IPv4 or IPv6 address as its value. Used if the server needs the client's IP address for security, accounting, or other purposes, and setting the Use Source IP parameter is not a viable option. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Usip 
        Use the client's IP address as the source IP address when initiating a connection to the server. When creating a service, if you do not set this parameter, the service inherits the global Use Source IP setting (available in the enable ns mode and disable ns mode CLI commands, or in the System &gt; Settings &gt; Configure modes &gt; Configure Modes dialog box). However, you can override this setting after you create the service. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service. 
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service. 
         
        Possible values = ON, OFF 
    .PARAMETER Customserverid 
        Unique identifier for the service. Used when the persistency type for the virtual server is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER Cka 
        Enable client keep-alive for the service. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated to the service. 
         
        Maximum value = 4294967287 
    .PARAMETER Accessdown 
        Use Layer 2 mode to bridge the packets sent to this service if it is marked as DOWN. If the service is DOWN, and this parameter is disabled, the packets are dropped. 
         
        Possible values = YES, NO 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
         
        Maximum value = 65535 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
         
        Maximum value = 31536000 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service. 
    .PARAMETER Contentinspectionprofilename 
        Name of the ContentInspection profile that contains IPS/IDS communication related setting for the service. 
    .PARAMETER Hashid 
        A numerical identifier that can be used by hash based load balancing methods. Must be unique for each service. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile to use for the service. 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the service. DNS profile properties will applied to the transactions processed by a service. This parameter is valid only for ADNS and ADNS-TCP services. 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
         
        Possible values = RESET, FIN 
    .PARAMETER Cipheader 
        Name for the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If you set the Client IP parameter, and you do not specify a name for the header, the appliance uses the header name specified for the global Client IP Header parameter (the cipHeader parameter in the set ns param CLI command or the Client IP Header parameter in the Configure HTTP Parameters dialog box at System &gt; Settings &gt; Change HTTP parameters). If the global Client IP Header parameter is not specified, the appliance inserts a header with the name "client-ip.". 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
         
        Possible values = YES, NO 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a service whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any information about the service.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetService -name <string>
        An example how to unset service config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetService
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$maxclient,

        [Boolean]$maxreq,

        [Boolean]$cacheable,

        [Boolean]$cip,

        [Boolean]$usip,

        [Boolean]$pathmonitor,

        [Boolean]$pathmonitorindv,

        [Boolean]$useproxyport,

        [Boolean]$sp,

        [Boolean]$rtspsessionidremap,

        [Boolean]$customserverid,

        [Boolean]$serverid,

        [Boolean]$cka,

        [Boolean]$tcpb,

        [Boolean]$cmp,

        [Boolean]$maxbandwidth,

        [Boolean]$accessdown,

        [Boolean]$monthreshold,

        [Boolean]$clttimeout,

        [Boolean]$svrtimeout,

        [Boolean]$tcpprofilename,

        [Boolean]$httpprofilename,

        [Boolean]$contentinspectionprofilename,

        [Boolean]$hashid,

        [Boolean]$appflowlog,

        [Boolean]$netprofile,

        [Boolean]$processlocal,

        [Boolean]$dnsprofilename,

        [Boolean]$monconnectionclose,

        [Boolean]$cipheader,

        [Boolean]$healthmonitor,

        [Boolean]$downstateflush,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('accessdown') ) { $payload.Add('accessdown', $accessdown) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionprofilename') ) { $payload.Add('contentinspectionprofilename', $contentinspectionprofilename) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type service -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetService: Finished"
    }
}

function Invoke-NSDeleteService {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteService -Name <string>
        An example how to delete service config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteService
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteService: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type service -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteService: Finished"
    }
}

function Invoke-NSUpdateService {
    <#
    .SYNOPSIS
        Update Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER Ipaddress 
        The new IP address of the service. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections to the service. 
         
        Maximum value = 4294967294 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service. 
        Note: Connection requests beyond this value are rejected. 
         
        Maximum value = 65535 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward requests to the cache server. 
        Note: Do not specify this parameter if you set the Cache Type parameter. 
         
        Possible values = YES, NO 
    .PARAMETER Cip 
        Before forwarding a request to the service, insert an HTTP header with the client's IPv4 or IPv6 address as its value. Used if the server needs the client's IP address for security, accounting, or other purposes, and setting the Use Source IP parameter is not a viable option. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name for the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If you set the Client IP parameter, and you do not specify a name for the header, the appliance uses the header name specified for the global Client IP Header parameter (the cipHeader parameter in the set ns param CLI command or the Client IP Header parameter in the Configure HTTP Parameters dialog box at System &gt; Settings &gt; Change HTTP parameters). If the global Client IP Header parameter is not specified, the appliance inserts a header with the name "client-ip.". 
    .PARAMETER Usip 
        Use the client's IP address as the source IP address when initiating a connection to the server. When creating a service, if you do not set this parameter, the service inherits the global Use Source IP setting (available in the enable ns mode and disable ns mode CLI commands, or in the System &gt; Settings &gt; Configure modes &gt; Configure Modes dialog box). However, you can override this setting after you create the service. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service. 
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service. 
         
        Possible values = ON, OFF 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
         
        Possible values = YES, NO 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
         
        Maximum value = 31536000 
    .PARAMETER Customserverid 
        Unique identifier for the service. Used when the persistency type for the virtual server is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER Cka 
        Enable client keep-alive for the service. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated to the service. 
         
        Maximum value = 4294967287 
    .PARAMETER Accessdown 
        Use Layer 2 mode to bridge the packets sent to this service if it is marked as DOWN. If the service is DOWN, and this parameter is disabled, the packets are dropped. 
         
        Possible values = YES, NO 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
         
        Maximum value = 65535 
    .PARAMETER Weight 
        Weight to assign to the monitor-service binding. When a monitor is UP, the weight assigned to its binding with the service determines how much the monitor contributes toward keeping the health of the service above the value configured for the Monitor Threshold parameter. 
         
        Maximum value = 100 
    .PARAMETER Monitor_name_svc 
        Name of the monitor bound to the specified service. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a service whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service. 
    .PARAMETER Contentinspectionprofilename 
        Name of the ContentInspection profile that contains IPS/IDS communication related setting for the service. 
    .PARAMETER Hashid 
        A numerical identifier that can be used by hash based load balancing methods. Must be unique for each service. 
    .PARAMETER Comment 
        Any information about the service. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile to use for the service. 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the service. DNS profile properties will applied to the transactions processed by a service. This parameter is valid only for ADNS and ADNS-TCP services. 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
         
        Possible values = RESET, FIN 
    .PARAMETER PassThru 
        Return details about the created service item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateService -name <string>
        An example how to update service config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateService
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Ipaddress,

        [double]$Maxclient,

        [double]$Maxreq,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('YES', 'NO')]
        [string]$Usip,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitor,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitorindv,

        [ValidateSet('YES', 'NO')]
        [string]$Useproxyport,

        [ValidateSet('ON', 'OFF')]
        [string]$Sp,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspsessionidremap,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor,

        [double]$Clttimeout,

        [double]$Svrtimeout,

        [string]$Customserverid,

        [double]$Serverid,

        [ValidateSet('YES', 'NO')]
        [string]$Cka,

        [ValidateSet('YES', 'NO')]
        [string]$Tcpb,

        [ValidateSet('YES', 'NO')]
        [string]$Cmp,

        [double]$Maxbandwidth,

        [ValidateSet('YES', 'NO')]
        [string]$Accessdown,

        [double]$Monthreshold,

        [double]$Weight,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Monitor_name_svc,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Contentinspectionprofilename,

        [double]$Hashid,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [ValidateSet('RESET', 'FIN')]
        [string]$Monconnectionclose,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('accessdown') ) { $payload.Add('accessdown', $accessdown) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionprofilename') ) { $payload.Add('contentinspectionprofilename', $contentinspectionprofilename) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSCmdlet.ShouldProcess("service", "Update Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type service -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetService -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateService: Finished"
    }
}

function Invoke-NSAddService {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER Ip 
        IP to assign to the service. 
    .PARAMETER Servername 
        Name of the server that hosts the service. 
    .PARAMETER Servicetype 
        Protocol in which data is exchanged with the service. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, RPCSVR, DNS, ADNS, SNMP, RTSP, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, ADNS_TCP, MYSQL, MSSQL, ORACLE, MONGO, MONGO_TLS, RADIUS, RADIUSListener, RDP, DIAMETER, SSL_DIAMETER, TFTP, SMPP, PPTP, GRE, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, LOGSTREAM_SSL, MQTT, MQTT_TLS, QUIC_BRIDGE 
    .PARAMETER Port 
        Port number of the service. 
    .PARAMETER Cleartextport 
        Port to which clear text data must be sent after the appliance decrypts incoming SSL traffic. Applicable to transparent SSL services. 
    .PARAMETER Cachetype 
        Cache type supported by the cache server. 
        Possible values = TRANSPARENT, REVERSE, FORWARD 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections to the service. 
         
        Maximum value = 4294967294 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
         
        Possible values = YES, NO 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service. 
        Note: Connection requests beyond this value are rejected. 
         
        Maximum value = 65535 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward requests to the cache server. 
        Note: Do not specify this parameter if you set the Cache Type parameter. 
         
        Possible values = YES, NO 
    .PARAMETER Cip 
        Before forwarding a request to the service, insert an HTTP header with the client's IPv4 or IPv6 address as its value. Used if the server needs the client's IP address for security, accounting, or other purposes, and setting the Use Source IP parameter is not a viable option. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name for the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If you set the Client IP parameter, and you do not specify a name for the header, the appliance uses the header name specified for the global Client IP Header parameter (the cipHeader parameter in the set ns param CLI command or the Client IP Header parameter in the Configure HTTP Parameters dialog box at System &gt; Settings &gt; Change HTTP parameters). If the global Client IP Header parameter is not specified, the appliance inserts a header with the name "client-ip.". 
    .PARAMETER Usip 
        Use the client's IP address as the source IP address when initiating a connection to the server. When creating a service, if you do not set this parameter, the service inherits the global Use Source IP setting (available in the enable ns mode and disable ns mode CLI commands, or in the System &gt; Settings &gt; Configure modes &gt; Configure Modes dialog box). However, you can override this setting after you create the service. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service. 
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service. 
         
        Possible values = ON, OFF 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
         
        Maximum value = 31536000 
    .PARAMETER Customserverid 
        Unique identifier for the service. Used when the persistency type for the virtual server is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER Cka 
        Enable client keep-alive for the service. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated to the service. 
         
        Maximum value = 4294967287 
    .PARAMETER Accessdown 
        Use Layer 2 mode to bridge the packets sent to this service if it is marked as DOWN. If the service is DOWN, and this parameter is disabled, the packets are dropped. 
         
        Possible values = YES, NO 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
         
        Maximum value = 65535 
    .PARAMETER State 
        Initial state of the service. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a service whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service. 
    .PARAMETER Contentinspectionprofilename 
        Name of the ContentInspection profile that contains IPS/IDS communication related setting for the service. 
    .PARAMETER Hashid 
        A numerical identifier that can be used by hash based load balancing methods. Must be unique for each service. 
    .PARAMETER Comment 
        Any information about the service. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile to use for the service. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
         
        Maximum value = 4094 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the service. DNS profile properties will applied to the transactions processed by a service. This parameter is valid only for ADNS and ADNS-TCP services. 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
         
        Possible values = RESET, FIN 
    .PARAMETER PassThru 
        Return details about the created service item.
    .EXAMPLE
        PS C:\>Invoke-NSAddService -name <string> -servicetype <string> -port <int>
        An example how to add service config Object(s).
    .NOTES
        File Name : Invoke-NSAddService
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'RPCSVR', 'DNS', 'ADNS', 'SNMP', 'RTSP', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'ADNS_TCP', 'MYSQL', 'MSSQL', 'ORACLE', 'MONGO', 'MONGO_TLS', 'RADIUS', 'RADIUSListener', 'RDP', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'SMPP', 'PPTP', 'GRE', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'LOGSTREAM_SSL', 'MQTT', 'MQTT_TLS', 'QUIC_BRIDGE')]
        [string]$Servicetype,

        [Parameter(Mandatory)]
        [ValidateRange(1, 65535)]
        [int]$Port,

        [int]$Cleartextport,

        [ValidateSet('TRANSPARENT', 'REVERSE', 'FORWARD')]
        [string]$Cachetype,

        [double]$Maxclient,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor = 'YES',

        [double]$Maxreq,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable = 'NO',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('YES', 'NO')]
        [string]$Usip,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitor,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitorindv,

        [ValidateSet('YES', 'NO')]
        [string]$Useproxyport,

        [ValidateSet('ON', 'OFF')]
        [string]$Sp,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspsessionidremap = 'OFF',

        [double]$Clttimeout,

        [double]$Svrtimeout,

        [string]$Customserverid = '"None"',

        [double]$Serverid,

        [ValidateSet('YES', 'NO')]
        [string]$Cka,

        [ValidateSet('YES', 'NO')]
        [string]$Tcpb,

        [ValidateSet('YES', 'NO')]
        [string]$Cmp,

        [double]$Maxbandwidth,

        [ValidateSet('YES', 'NO')]
        [string]$Accessdown = 'NO',

        [double]$Monthreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Contentinspectionprofilename,

        [double]$Hashid,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [double]$Td,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal = 'DISABLED',

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [ValidateSet('RESET', 'FIN')]
        [string]$Monconnectionclose = 'NONE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                servicetype    = $servicetype
                port           = $port
            }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('cleartextport') ) { $payload.Add('cleartextport', $cleartextport) }
            if ( $PSBoundParameters.ContainsKey('cachetype') ) { $payload.Add('cachetype', $cachetype) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('accessdown') ) { $payload.Add('accessdown', $accessdown) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionprofilename') ) { $payload.Add('contentinspectionprofilename', $contentinspectionprofilename) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSCmdlet.ShouldProcess("service", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type service -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetService -Filter $payload)
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
        Write-Verbose "Invoke-NSAddService: Finished"
    }
}

function Invoke-NSGetService {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER GetAll 
        Retrieve all service object(s).
    .PARAMETER Count
        If specified, the count of the service object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetService
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetService -GetAll 
        Get all service data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetService -Count 
        Get the number of service objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetService -name <string>
        Get service object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetService -Filter @{ 'name'='<value>' }
        Get service data with a filter.
    .NOTES
        File Name : Invoke-NSGetService
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service/
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
        Write-Verbose "Invoke-NSGetService: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all service objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetService: Ended"
    }
}

function Invoke-NSGetServiceBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to service.
    .PARAMETER Name 
        Name of the service for which to display configuration details. 
    .PARAMETER GetAll 
        Retrieve all service_binding object(s).
    .PARAMETER Count
        If specified, the count of the service_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServiceBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServiceBinding -GetAll 
        Get all service_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetServiceBinding -name <string>
        Get service_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServiceBinding -Filter @{ 'name'='<value>' }
        Get service_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServiceBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service_binding/
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
        Write-Verbose "Invoke-NSGetServiceBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all service_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServiceBinding: Ended"
    }
}

function Invoke-NSAddServiceLbmonitorBinding {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a monitor. 
    .PARAMETER Monitor_name 
        The monitor Names. 
    .PARAMETER Monstate 
        The configured state (enable/disable) of the monitor on this server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Weight 
        Weight to assign to the monitor-service binding. When a monitor is UP, the weight assigned to its binding with the service determines how much the monitor contributes toward keeping the health of the service above the value configured for the Monitor Threshold parameter. 
         
        Maximum value = 100 
    .PARAMETER Passive 
        Indicates if load monitor is passive. A passive load monitor does not remove service from LB decision when threshold is breached. 
    .PARAMETER PassThru 
        Return details about the created service_lbmonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddServiceLbmonitorBinding -name <string>
        An example how to add service_lbmonitor_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddServiceLbmonitorBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service_lbmonitor_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Monitor_name,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Monstate,

        [double]$Weight,

        [boolean]$Passive,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddServiceLbmonitorBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('monitor_name') ) { $payload.Add('monitor_name', $monitor_name) }
            if ( $PSBoundParameters.ContainsKey('monstate') ) { $payload.Add('monstate', $monstate) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('passive') ) { $payload.Add('passive', $passive) }
            if ( $PSCmdlet.ShouldProcess("service_lbmonitor_binding", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type service_lbmonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetServiceLbmonitorBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddServiceLbmonitorBinding: Finished"
    }
}

function Invoke-NSDeleteServiceLbmonitorBinding {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a monitor. 
    .PARAMETER Monitor_name 
        The monitor Names.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteServiceLbmonitorBinding -Name <string>
        An example how to delete service_lbmonitor_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteServiceLbmonitorBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service_lbmonitor_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Monitor_name 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteServiceLbmonitorBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Monitor_name') ) { $arguments.Add('monitor_name', $Monitor_name) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteServiceLbmonitorBinding: Finished"
    }
}

function Invoke-NSGetServiceLbmonitorBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a monitor. 
    .PARAMETER GetAll 
        Retrieve all service_lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the service_lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServiceLbmonitorBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServiceLbmonitorBinding -GetAll 
        Get all service_lbmonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServiceLbmonitorBinding -Count 
        Get the number of service_lbmonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServiceLbmonitorBinding -name <string>
        Get service_lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServiceLbmonitorBinding -Filter @{ 'name'='<value>' }
        Get service_lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServiceLbmonitorBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/service_lbmonitor_binding/
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
        Write-Verbose "Invoke-NSGetServiceLbmonitorBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all service_lbmonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service_lbmonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service_lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service_lbmonitor_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service_lbmonitor_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServiceLbmonitorBinding: Ended"
    }
}

function Invoke-NSRenameServicegroup {
    <#
    .SYNOPSIS
        Rename Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Newname 
        New name for the service group. 
    .PARAMETER PassThru 
        Return details about the created servicegroup item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameServicegroup -servicegroupname <string> -newname <string>
        An example how to rename servicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSRenameServicegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSRenameServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname
                newname                    = $newname
            }

            if ( $PSCmdlet.ShouldProcess("servicegroup", "Rename Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type servicegroup -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetServicegroup -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameServicegroup: Finished"
    }
}

function Invoke-NSEnableServicegroup {
    <#
    .SYNOPSIS
        Enable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number.
    .EXAMPLE
        PS C:\>Invoke-NSEnableServicegroup -servicegroupname <string>
        An example how to enable servicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSEnableServicegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSEnableServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type servicegroup -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableServicegroup: Finished"
    }
}

function Invoke-NSDisableServicegroup {
    <#
    .SYNOPSIS
        Disable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
    .PARAMETER Delay 
        Time, in seconds, allocated for a shutdown of the services in the service group. During this period, new requests are sent to the service only for clients who already have persistent sessions on the appliance. Requests from new clients are load balanced among other available services. After the delay time expires, no requests are sent to the service, and the service is marked as unavailable (OUT OF SERVICE). 
    .PARAMETER Graceful 
        Wait for all existing connections to the service to terminate before shutting down the service. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSDisableServicegroup -servicegroupname <string>
        An example how to disable servicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSDisableServicegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDisableServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('graceful') ) { $payload.Add('graceful', $graceful) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type servicegroup -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableServicegroup: Finished"
    }
}

function Invoke-NSUnsetServicegroup {
    <#
    .SYNOPSIS
        Unset Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
         
        Maximum value = 100 
    .PARAMETER Customserverid 
        The identifier for this IP:Port pair. Used when the persistency type is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER Dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
    .PARAMETER Order 
        Order number to be assigned to the servicegroup member. 
         
        Maximum value = 8192 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the service group. 
         
        Maximum value = 4294967294 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service group. 
        Note: Connection requests beyond this value are rejected. 
         
        Maximum value = 65535 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward the request to the cache server. 
        Note: Do not set this parameter if you set the Cache Type. 
         
        Possible values = YES, NO 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Usip 
        Use client's IP address as the source IP address when initiating connection to the server. With the NO setting, which is the default, a mapped IP (MIP) address or subnet IP (SNIP) address is used as the source IP address to initiate server side connections. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service group. 
         
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service group. 
         
        Possible values = ON, OFF 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
         
        Maximum value = 31536000 
    .PARAMETER Cka 
        Enable client keep-alive for the service group. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service group. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the specified service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the service group. 
         
        Maximum value = 4294967287 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
         
        Maximum value = 65535 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service group. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service group. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified service group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile for the service group. 
    .PARAMETER Autodisablegraceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service. 
         
        Possible values = YES, NO 
    .PARAMETER Autodisabledelay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER Monitor_name_svc 
        Name of the monitor bound to the service group. Used to assign a weight to the monitor. 
    .PARAMETER Dup_weight 
        weight of the monitor that is bound to servicegroup. 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
         
        Possible values = YES, NO 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any information about the service group. 
    .PARAMETER Autodelayedtrofs 
        Indicates graceful movement of IP-Port binding/s to TROFS when IP addresses are removed from DNS response. System will wait for monitor response timeout period before moving to TROFS . 
         
        Possible values = YES, NO 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
         
        Possible values = RESET, FIN
    .EXAMPLE
        PS C:\>Invoke-NSUnsetServicegroup -servicegroupname <string>
        An example how to unset servicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetServicegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$customserverid,

        [Boolean]$serverid,

        [Boolean]$hashid,

        [Boolean]$nameserver,

        [Boolean]$dbsttl,

        [Boolean]$order,

        [Boolean]$maxclient,

        [Boolean]$maxreq,

        [Boolean]$cacheable,

        [Boolean]$cip,

        [Boolean]$usip,

        [Boolean]$useproxyport,

        [Boolean]$sp,

        [Boolean]$rtspsessionidremap,

        [Boolean]$clttimeout,

        [Boolean]$svrtimeout,

        [Boolean]$cka,

        [Boolean]$tcpb,

        [Boolean]$cmp,

        [Boolean]$maxbandwidth,

        [Boolean]$monthreshold,

        [Boolean]$tcpprofilename,

        [Boolean]$httpprofilename,

        [Boolean]$appflowlog,

        [Boolean]$netprofile,

        [Boolean]$autodisablegraceful,

        [Boolean]$autodisabledelay,

        [Boolean]$monitor_name_svc,

        [Boolean]$dup_weight,

        [Boolean]$healthmonitor,

        [Boolean]$cipheader,

        [Boolean]$pathmonitor,

        [Boolean]$pathmonitorindv,

        [Boolean]$downstateflush,

        [Boolean]$comment,

        [Boolean]$autodelayedtrofs,

        [Boolean]$monconnectionclose 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('nameserver') ) { $payload.Add('nameserver', $nameserver) }
            if ( $PSBoundParameters.ContainsKey('dbsttl') ) { $payload.Add('dbsttl', $dbsttl) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('autodisablegraceful') ) { $payload.Add('autodisablegraceful', $autodisablegraceful) }
            if ( $PSBoundParameters.ContainsKey('autodisabledelay') ) { $payload.Add('autodisabledelay', $autodisabledelay) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('dup_weight') ) { $payload.Add('dup_weight', $dup_weight) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('autodelayedtrofs') ) { $payload.Add('autodelayedtrofs', $autodelayedtrofs) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Unset Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type servicegroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetServicegroup: Finished"
    }
}

function Invoke-NSDeleteServicegroup {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteServicegroup -Servicegroupname <string>
        An example how to delete servicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteServicegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteServicegroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type servicegroup -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteServicegroup: Finished"
    }
}

function Invoke-NSUpdateServicegroup {
    <#
    .SYNOPSIS
        Update Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
         
        Maximum value = 100 
    .PARAMETER Customserverid 
        The identifier for this IP:Port pair. Used when the persistency type is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER Dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
    .PARAMETER Order 
        Order number to be assigned to the servicegroup member. 
         
        Maximum value = 8192 
    .PARAMETER Monitor_name_svc 
        Name of the monitor bound to the service group. Used to assign a weight to the monitor. 
    .PARAMETER Dup_weight 
        weight of the monitor that is bound to servicegroup. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the service group. 
         
        Maximum value = 4294967294 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service group. 
        Note: Connection requests beyond this value are rejected. 
         
        Maximum value = 65535 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
         
        Possible values = YES, NO 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward the request to the cache server. 
        Note: Do not set this parameter if you set the Cache Type. 
         
        Possible values = YES, NO 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Usip 
        Use client's IP address as the source IP address when initiating connection to the server. With the NO setting, which is the default, a mapped IP (MIP) address or subnet IP (SNIP) address is used as the source IP address to initiate server side connections. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service group. 
         
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service group. 
         
        Possible values = ON, OFF 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
         
        Maximum value = 31536000 
    .PARAMETER Cka 
        Enable client keep-alive for the service group. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service group. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the specified service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the service group. 
         
        Maximum value = 4294967287 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
         
        Maximum value = 65535 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service group. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service group. 
    .PARAMETER Comment 
        Any information about the service group. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified service group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile for the service group. 
    .PARAMETER Autodisablegraceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service. 
         
        Possible values = YES, NO 
    .PARAMETER Autodisabledelay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER Autodelayedtrofs 
        Indicates graceful movement of IP-Port binding/s to TROFS when IP addresses are removed from DNS response. System will wait for monitor response timeout period before moving to TROFS . 
         
        Possible values = YES, NO 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
         
        Possible values = RESET, FIN 
    .PARAMETER Autoscale 
        Auto scale option for a servicegroup. 
         
        Possible values = DISABLED, DNS, POLICY, CLOUD, API 
    .PARAMETER PassThru 
        Return details about the created servicegroup item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateServicegroup -servicegroupname <string>
        An example how to update servicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateServicegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Customserverid,

        [double]$Serverid,

        [double]$Hashid,

        [string]$Nameserver,

        [double]$Dbsttl,

        [double]$Order,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Monitor_name_svc,

        [double]$Dup_weight,

        [double]$Maxclient,

        [double]$Maxreq,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('YES', 'NO')]
        [string]$Usip,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitor,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitorindv,

        [ValidateSet('YES', 'NO')]
        [string]$Useproxyport,

        [ValidateSet('ON', 'OFF')]
        [string]$Sp,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspsessionidremap,

        [double]$Clttimeout,

        [double]$Svrtimeout,

        [ValidateSet('YES', 'NO')]
        [string]$Cka,

        [ValidateSet('YES', 'NO')]
        [string]$Tcpb,

        [ValidateSet('YES', 'NO')]
        [string]$Cmp,

        [double]$Maxbandwidth,

        [double]$Monthreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('YES', 'NO')]
        [string]$Autodisablegraceful,

        [double]$Autodisabledelay,

        [ValidateSet('YES', 'NO')]
        [string]$Autodelayedtrofs,

        [ValidateSet('RESET', 'FIN')]
        [string]$Monconnectionclose,

        [ValidateSet('DISABLED', 'DNS', 'POLICY', 'CLOUD', 'API')]
        [string]$Autoscale,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('nameserver') ) { $payload.Add('nameserver', $nameserver) }
            if ( $PSBoundParameters.ContainsKey('dbsttl') ) { $payload.Add('dbsttl', $dbsttl) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('dup_weight') ) { $payload.Add('dup_weight', $dup_weight) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('autodisablegraceful') ) { $payload.Add('autodisablegraceful', $autodisablegraceful) }
            if ( $PSBoundParameters.ContainsKey('autodisabledelay') ) { $payload.Add('autodisabledelay', $autodisabledelay) }
            if ( $PSBoundParameters.ContainsKey('autodelayedtrofs') ) { $payload.Add('autodelayedtrofs', $autodelayedtrofs) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSBoundParameters.ContainsKey('autoscale') ) { $payload.Add('autoscale', $autoscale) }
            if ( $PSCmdlet.ShouldProcess("servicegroup", "Update Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type servicegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetServicegroup -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateServicegroup: Finished"
    }
}

function Invoke-NSAddServicegroup {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servicetype 
        Protocol used to exchange data with the service. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, RPCSVR, DNS, ADNS, SNMP, RTSP, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, ADNS_TCP, MYSQL, MSSQL, ORACLE, MONGO, MONGO_TLS, RADIUS, RADIUSListener, RDP, DIAMETER, SSL_DIAMETER, TFTP, SMPP, PPTP, GRE, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, LOGSTREAM_SSL, MQTT, MQTT_TLS, QUIC_BRIDGE 
    .PARAMETER Cachetype 
        Cache type supported by the cache server. 
        Possible values = TRANSPARENT, REVERSE, FORWARD 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
         
        Maximum value = 4094 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the service group. 
         
        Maximum value = 4294967294 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service group. 
        Note: Connection requests beyond this value are rejected. 
         
        Maximum value = 65535 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward the request to the cache server. 
        Note: Do not set this parameter if you set the Cache Type. 
         
        Possible values = YES, NO 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Usip 
        Use client's IP address as the source IP address when initiating connection to the server. With the NO setting, which is the default, a mapped IP (MIP) address or subnet IP (SNIP) address is used as the source IP address to initiate server side connections. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
         
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service group. 
         
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service group. 
         
        Possible values = ON, OFF 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
         
        Maximum value = 31536000 
    .PARAMETER Cka 
        Enable client keep-alive for the service group. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service group. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the specified service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the service group. 
         
        Maximum value = 4294967287 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
         
        Maximum value = 65535 
    .PARAMETER State 
        Initial state of the service group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service group. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service group. 
    .PARAMETER Comment 
        Any information about the service group. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified service group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile for the service group. 
    .PARAMETER Autoscale 
        Auto scale option for a servicegroup. 
         
        Possible values = DISABLED, DNS, POLICY, CLOUD, API 
    .PARAMETER Memberport 
        member port. 
    .PARAMETER Autodisablegraceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service. 
         
        Possible values = YES, NO 
    .PARAMETER Autodisabledelay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER Autodelayedtrofs 
        Indicates graceful movement of IP-Port binding/s to TROFS when IP addresses are removed from DNS response. System will wait for monitor response timeout period before moving to TROFS . 
         
        Possible values = YES, NO 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
         
        Possible values = RESET, FIN 
    .PARAMETER PassThru 
        Return details about the created servicegroup item.
    .EXAMPLE
        PS C:\>Invoke-NSAddServicegroup -servicegroupname <string> -servicetype <string>
        An example how to add servicegroup config Object(s).
    .NOTES
        File Name : Invoke-NSAddServicegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'RPCSVR', 'DNS', 'ADNS', 'SNMP', 'RTSP', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'ADNS_TCP', 'MYSQL', 'MSSQL', 'ORACLE', 'MONGO', 'MONGO_TLS', 'RADIUS', 'RADIUSListener', 'RDP', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'SMPP', 'PPTP', 'GRE', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'LOGSTREAM_SSL', 'MQTT', 'MQTT_TLS', 'QUIC_BRIDGE')]
        [string]$Servicetype,

        [ValidateSet('TRANSPARENT', 'REVERSE', 'FORWARD')]
        [string]$Cachetype,

        [double]$Td,

        [double]$Maxclient,

        [double]$Maxreq,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable = 'NO',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('YES', 'NO')]
        [string]$Usip,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitor,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitorindv,

        [ValidateSet('YES', 'NO')]
        [string]$Useproxyport,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor = 'YES',

        [ValidateSet('ON', 'OFF')]
        [string]$Sp = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspsessionidremap = 'OFF',

        [double]$Clttimeout,

        [double]$Svrtimeout,

        [ValidateSet('YES', 'NO')]
        [string]$Cka,

        [ValidateSet('YES', 'NO')]
        [string]$Tcpb,

        [ValidateSet('YES', 'NO')]
        [string]$Cmp,

        [double]$Maxbandwidth,

        [double]$Monthreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('DISABLED', 'DNS', 'POLICY', 'CLOUD', 'API')]
        [string]$Autoscale = 'DISABLED',

        [int]$Memberport,

        [ValidateSet('YES', 'NO')]
        [string]$Autodisablegraceful = 'NO',

        [double]$Autodisabledelay,

        [ValidateSet('YES', 'NO')]
        [string]$Autodelayedtrofs = 'NO',

        [ValidateSet('RESET', 'FIN')]
        [string]$Monconnectionclose = 'NONE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname
                servicetype                = $servicetype
            }
            if ( $PSBoundParameters.ContainsKey('cachetype') ) { $payload.Add('cachetype', $cachetype) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('autoscale') ) { $payload.Add('autoscale', $autoscale) }
            if ( $PSBoundParameters.ContainsKey('memberport') ) { $payload.Add('memberport', $memberport) }
            if ( $PSBoundParameters.ContainsKey('autodisablegraceful') ) { $payload.Add('autodisablegraceful', $autodisablegraceful) }
            if ( $PSBoundParameters.ContainsKey('autodisabledelay') ) { $payload.Add('autodisabledelay', $autodisabledelay) }
            if ( $PSBoundParameters.ContainsKey('autodelayedtrofs') ) { $payload.Add('autodelayedtrofs', $autodelayedtrofs) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSCmdlet.ShouldProcess("servicegroup", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type servicegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetServicegroup -Filter $payload)
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
        Write-Verbose "Invoke-NSAddServicegroup: Finished"
    }
}

function Invoke-NSGetServicegroup {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER GetAll 
        Retrieve all servicegroup object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroup -GetAll 
        Get all servicegroup data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroup -Count 
        Get the number of servicegroup objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroup -name <string>
        Get servicegroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroup -Filter @{ 'name'='<value>' }
        Get servicegroup data with a filter.
    .NOTES
        File Name : Invoke-NSGetServicegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup/
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
        Write-Verbose "Invoke-NSGetServicegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all servicegroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServicegroup: Ended"
    }
}

function Invoke-NSGetServicegroupBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER GetAll 
        Retrieve all servicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroupBinding -GetAll 
        Get all servicegroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupBinding -name <string>
        Get servicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupBinding -Filter @{ 'name'='<value>' }
        Get servicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServicegroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup_binding/
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
        Write-Verbose "Invoke-NSGetServicegroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all servicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_binding configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServicegroupBinding: Ended"
    }
}

function Invoke-NSAddServicegroupLbmonitorBinding {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER Port 
        Port number of the service. Each service must have a unique port number. 
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
    .PARAMETER Customserverid 
        Unique service identifier. Used when the persistency type for the virtual server is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER State 
        Initial state of the service after binding. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Hashid 
        Unique numerical identifier used by hash based load balancing methods to identify a service. 
    .PARAMETER Nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER Dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
    .PARAMETER Order 
        Order number to be assigned to the servicegroup member. 
         
        Maximum value = 8192 
    .PARAMETER PassThru 
        Return details about the created servicegroup_lbmonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddServicegroupLbmonitorBinding -servicegroupname <string>
        An example how to add servicegroup_lbmonitor_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddServicegroupLbmonitorBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup_lbmonitor_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Customserverid = '"None"',

        [double]$Serverid,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [double]$Hashid,

        [string]$Nameserver,

        [double]$Dbsttl = '0',

        [double]$Order,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddServicegroupLbmonitorBinding: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('monitor_name') ) { $payload.Add('monitor_name', $monitor_name) }
            if ( $PSBoundParameters.ContainsKey('monstate') ) { $payload.Add('monstate', $monstate) }
            if ( $PSBoundParameters.ContainsKey('passive') ) { $payload.Add('passive', $passive) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('nameserver') ) { $payload.Add('nameserver', $nameserver) }
            if ( $PSBoundParameters.ContainsKey('dbsttl') ) { $payload.Add('dbsttl', $dbsttl) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSCmdlet.ShouldProcess("servicegroup_lbmonitor_binding", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type servicegroup_lbmonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetServicegroupLbmonitorBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddServicegroupLbmonitorBinding: Finished"
    }
}

function Invoke-NSDeleteServicegroupLbmonitorBinding {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER Port 
        Port number of the service. Each service must have a unique port number. 
    .PARAMETER Monitor_name 
        Monitor name.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteServicegroupLbmonitorBinding -Servicegroupname <string>
        An example how to delete servicegroup_lbmonitor_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteServicegroupLbmonitorBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup_lbmonitor_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteServicegroupLbmonitorBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Port') ) { $arguments.Add('port', $Port) }
            if ( $PSBoundParameters.ContainsKey('Monitor_name') ) { $arguments.Add('monitor_name', $Monitor_name) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteServicegroupLbmonitorBinding: Finished"
    }
}

function Invoke-NSGetServicegroupLbmonitorBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER GetAll 
        Retrieve all servicegroup_lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup_lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupLbmonitorBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroupLbmonitorBinding -GetAll 
        Get all servicegroup_lbmonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroupLbmonitorBinding -Count 
        Get the number of servicegroup_lbmonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupLbmonitorBinding -name <string>
        Get servicegroup_lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupLbmonitorBinding -Filter @{ 'name'='<value>' }
        Get servicegroup_lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServicegroupLbmonitorBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup_lbmonitor_binding/
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
        Write-Verbose "Invoke-NSGetServicegroupLbmonitorBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all servicegroup_lbmonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_lbmonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_lbmonitor_binding configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_lbmonitor_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServicegroupLbmonitorBinding: Ended"
    }
}

function Invoke-NSGetServicegroupServicegroupentitymonbindingsBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object showing the servicegroupentitymonbindings that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER GetAll 
        Retrieve all servicegroup_servicegroupentitymonbindings_binding object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup_servicegroupentitymonbindings_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupServicegroupentitymonbindingsBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroupServicegroupentitymonbindingsBinding -GetAll 
        Get all servicegroup_servicegroupentitymonbindings_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroupServicegroupentitymonbindingsBinding -Count 
        Get the number of servicegroup_servicegroupentitymonbindings_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupServicegroupentitymonbindingsBinding -name <string>
        Get servicegroup_servicegroupentitymonbindings_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupServicegroupentitymonbindingsBinding -Filter @{ 'name'='<value>' }
        Get servicegroup_servicegroupentitymonbindings_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServicegroupServicegroupentitymonbindingsBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup_servicegroupentitymonbindings_binding/
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
        Write-Verbose "Invoke-NSGetServicegroupServicegroupentitymonbindingsBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all servicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupentitymonbindings_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupentitymonbindings_binding configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_servicegroupentitymonbindings_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServicegroupServicegroupentitymonbindingsBinding: Ended"
    }
}

function Invoke-NSAddServicegroupServicegroupmemberBinding {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Binding object showing the servicegroupmember that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER Ip 
        IP Address. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
         
        Maximum value = 100 
    .PARAMETER Customserverid 
        The identifier for this IP:Port pair. Used when the persistency type is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER State 
        Initial state of the service group. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER Dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
    .PARAMETER Order 
        Order number to be assigned to the servicegroup member. 
         
        Maximum value = 8192 
    .PARAMETER PassThru 
        Return details about the created servicegroup_servicegroupmember_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddServicegroupServicegroupmemberBinding -servicegroupname <string>
        An example how to add servicegroup_servicegroupmember_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddServicegroupServicegroupmemberBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup_servicegroupmember_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Customserverid = '"None"',

        [double]$Serverid,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [double]$Hashid,

        [string]$Nameserver,

        [double]$Dbsttl = '0',

        [double]$Order,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddServicegroupServicegroupmemberBinding: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('nameserver') ) { $payload.Add('nameserver', $nameserver) }
            if ( $PSBoundParameters.ContainsKey('dbsttl') ) { $payload.Add('dbsttl', $dbsttl) }
            if ( $PSBoundParameters.ContainsKey('order') ) { $payload.Add('order', $order) }
            if ( $PSCmdlet.ShouldProcess("servicegroup_servicegroupmember_binding", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type servicegroup_servicegroupmember_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetServicegroupServicegroupmemberBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddServicegroupServicegroupmemberBinding: Finished"
    }
}

function Invoke-NSDeleteServicegroupServicegroupmemberBinding {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Binding object showing the servicegroupmember that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER Ip 
        IP Address. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteServicegroupServicegroupmemberBinding -Servicegroupname <string>
        An example how to delete servicegroup_servicegroupmember_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteServicegroupServicegroupmemberBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup_servicegroupmember_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteServicegroupServicegroupmemberBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ip') ) { $arguments.Add('ip', $Ip) }
            if ( $PSBoundParameters.ContainsKey('Servername') ) { $arguments.Add('servername', $Servername) }
            if ( $PSBoundParameters.ContainsKey('Port') ) { $arguments.Add('port', $Port) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteServicegroupServicegroupmemberBinding: Finished"
    }
}

function Invoke-NSGetServicegroupServicegroupmemberBinding {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Binding object showing the servicegroupmember that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER GetAll 
        Retrieve all servicegroup_servicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup_servicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupServicegroupmemberBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroupServicegroupmemberBinding -GetAll 
        Get all servicegroup_servicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroupServicegroupmemberBinding -Count 
        Get the number of servicegroup_servicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupServicegroupmemberBinding -name <string>
        Get servicegroup_servicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupServicegroupmemberBinding -Filter @{ 'name'='<value>' }
        Get servicegroup_servicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetServicegroupServicegroupmemberBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup_servicegroupmember_binding/
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
        Write-Verbose "Invoke-NSGetServicegroupServicegroupmemberBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all servicegroup_servicegroupmember_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_servicegroupmember_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupmember_binding configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_servicegroupmember_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServicegroupServicegroupmemberBinding: Ended"
    }
}

function Invoke-NSAddServicegroupServicegroupmemberlistBinding {
    <#
    .SYNOPSIS
        Add Basic system configuration. config Object.
    .DESCRIPTION
        Binding object showing the servicegroupmemberlist that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER Members 
        Desired servicegroupmember binding set. Any existing servicegroupmember which is not part of the input will be deleted or disabled based on graceful setting on servicegroup.
    .EXAMPLE
        PS C:\>Invoke-NSAddServicegroupServicegroupmemberlistBinding -servicegroupname <string>
        An example how to add servicegroup_servicegroupmemberlist_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddServicegroupServicegroupmemberlistBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup_servicegroupmemberlist_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [object[]]$Members 
    )
    begin {
        Write-Verbose "Invoke-NSAddServicegroupServicegroupmemberlistBinding: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('members') ) { $payload.Add('members', $members) }
            if ( $PSCmdlet.ShouldProcess("servicegroup_servicegroupmemberlist_binding", "Add Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type servicegroup_servicegroupmemberlist_binding -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSAddServicegroupServicegroupmemberlistBinding: Finished"
    }
}

function Invoke-NSDeleteServicegroupServicegroupmemberlistBinding {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Binding object showing the servicegroupmemberlist that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteServicegroupServicegroupmemberlistBinding -Servicegroupname <string>
        An example how to delete servicegroup_servicegroupmemberlist_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteServicegroupServicegroupmemberlistBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroup_servicegroupmemberlist_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteServicegroupServicegroupmemberlistBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type servicegroup_servicegroupmemberlist_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteServicegroupServicegroupmemberlistBinding: Finished"
    }
}

function Invoke-NSGetServicegroupbindings {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for servicegroupbind resource.
    .PARAMETER Servicegroupname 
        The name of the service. 
    .PARAMETER GetAll 
        Retrieve all servicegroupbindings object(s).
    .PARAMETER Count
        If specified, the count of the servicegroupbindings object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupbindings
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroupbindings -GetAll 
        Get all servicegroupbindings data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetServicegroupbindings -Count 
        Get the number of servicegroupbindings objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupbindings -name <string>
        Get servicegroupbindings object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetServicegroupbindings -Filter @{ 'name'='<value>' }
        Get servicegroupbindings data with a filter.
    .NOTES
        File Name : Invoke-NSGetServicegroupbindings
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/servicegroupbindings/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetServicegroupbindings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all servicegroupbindings objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroupbindings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroupbindings objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroupbindings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroupbindings objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroupbindings -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroupbindings configuration for property 'servicegroupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroupbindings -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroupbindings configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type servicegroupbindings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetServicegroupbindings: Ended"
    }
}

function Invoke-NSGetSvcbindings {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for service bindings resource.
    .PARAMETER Servicename 
        The name of the service. 
    .PARAMETER GetAll 
        Retrieve all svcbindings object(s).
    .PARAMETER Count
        If specified, the count of the svcbindings object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSvcbindings
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSvcbindings -GetAll 
        Get all svcbindings data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSvcbindings -Count 
        Get the number of svcbindings objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSvcbindings -name <string>
        Get svcbindings object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSvcbindings -Filter @{ 'name'='<value>' }
        Get svcbindings data with a filter.
    .NOTES
        File Name : Invoke-NSGetSvcbindings
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/svcbindings/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetSvcbindings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all svcbindings objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type svcbindings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for svcbindings objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type svcbindings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving svcbindings objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type svcbindings -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving svcbindings configuration for property 'servicename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type svcbindings -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving svcbindings configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type svcbindings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSvcbindings: Ended"
    }
}

function Invoke-NSEnableSystemlevelreporting {
    <#
    .SYNOPSIS
        Enable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for Make entity count for reporting equal to system threshold count cumulatively resource.
    .EXAMPLE
        PS C:\>Invoke-NSEnableSystemlevelreporting 
        An example how to enable systemlevelreporting config Object(s).
    .NOTES
        File Name : Invoke-NSEnableSystemlevelreporting
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/systemlevelreporting/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSEnableSystemlevelreporting: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemlevelreporting -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableSystemlevelreporting: Finished"
    }
}

function Invoke-NSDisableSystemlevelreporting {
    <#
    .SYNOPSIS
        Disable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for Make entity count for reporting equal to system threshold count cumulatively resource.
    .EXAMPLE
        PS C:\>Invoke-NSDisableSystemlevelreporting 
        An example how to disable systemlevelreporting config Object(s).
    .NOTES
        File Name : Invoke-NSDisableSystemlevelreporting
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/systemlevelreporting/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSDisableSystemlevelreporting: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemlevelreporting -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableSystemlevelreporting: Finished"
    }
}

function Invoke-NSGetSystemlevelreporting {
    <#
    .SYNOPSIS
        Get Basic system configuration. config object(s).
    .DESCRIPTION
        Configuration for Make entity count for reporting equal to system threshold count cumulatively resource.
    .PARAMETER GetAll 
        Retrieve all systemlevelreporting object(s).
    .PARAMETER Count
        If specified, the count of the systemlevelreporting object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemlevelreporting
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemlevelreporting -GetAll 
        Get all systemlevelreporting data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemlevelreporting -name <string>
        Get systemlevelreporting object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemlevelreporting -Filter @{ 'name'='<value>' }
        Get systemlevelreporting data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemlevelreporting
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/systemlevelreporting/
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
        Write-Verbose "Invoke-NSGetSystemlevelreporting: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemlevelreporting objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemlevelreporting -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemlevelreporting objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemlevelreporting -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemlevelreporting objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemlevelreporting -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemlevelreporting configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemlevelreporting configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemlevelreporting -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemlevelreporting: Ended"
    }
}

function Invoke-NSDisableVserver {
    <#
    .SYNOPSIS
        Disable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for virtual server resource.
    .PARAMETER Name 
        The name of the virtual server to be removed.
    .EXAMPLE
        PS C:\>Invoke-NSDisableVserver -name <string>
        An example how to disable vserver config Object(s).
    .NOTES
        File Name : Invoke-NSDisableVserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/vserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDisableVserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type vserver -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableVserver: Finished"
    }
}

function Invoke-NSEnableVserver {
    <#
    .SYNOPSIS
        Enable Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for virtual server resource.
    .PARAMETER Name 
        The name of the virtual server to be removed.
    .EXAMPLE
        PS C:\>Invoke-NSEnableVserver -name <string>
        An example how to enable vserver config Object(s).
    .NOTES
        File Name : Invoke-NSEnableVserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/vserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSEnableVserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type vserver -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableVserver: Finished"
    }
}

function Invoke-NSDeleteVserver {
    <#
    .SYNOPSIS
        Delete Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for virtual server resource.
    .PARAMETER Name 
        The name of the virtual server to be removed.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVserver -Name <string>
        An example how to delete vserver config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/vserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteVserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Basic system configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type vserver -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVserver: Finished"
    }
}

function Invoke-NSUpdateVserver {
    <#
    .SYNOPSIS
        Update Basic system configuration. config Object.
    .DESCRIPTION
        Configuration for virtual server resource.
    .PARAMETER Name 
        The name of the virtual server to be removed. 
    .PARAMETER Backupvserver 
        The name of the backup virtual server for this virtual server. 
    .PARAMETER Redirecturl 
        The URL where traffic is redirected if the virtual server in the system becomes unavailable. 
    .PARAMETER Cacheable 
        Use this option to specify whether a virtual server (used for load balancing or content switching) routes requests to the cache redirection virtual server before sending it to the configured servers. 
        Possible values = YES, NO 
    .PARAMETER Clttimeout 
        The timeout value in seconds for idle client connection. 
         
        Maximum value = 31536000 
    .PARAMETER Somethod 
        The spillover factor. The system will use this value to determine if it should send traffic to the backupvserver when the main virtual server reaches the spillover threshold. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        The state of the spillover persistence. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        The spillover persistence entry timeout. 
         
         
        Maximum value = 1440 
    .PARAMETER Sothreshold 
        The spillver threshold value. 
         
        Maximum value = 4294967294 
    .PARAMETER Pushvserver 
        The lb vserver of type PUSH/SSL_PUSH to which server pushes the updates received on the client facing non-push lb vserver.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateVserver -name <string>
        An example how to update vserver config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateVserver
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/basic/vserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Pushvserver 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateVserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSCmdlet.ShouldProcess("vserver", "Update Basic system configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type vserver -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateVserver: Finished"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAtVFoNuVbd03O/
# gOQLKiRgTy0JO8CRg4+lNdxGWlHff6CCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQg/u+6padzjqlq7mZ6PoURR/R17CQdtJ/YGEADtrBCxx0wDQYJ
# KoZIhvcNAQEBBQAEggEAYb+yDCZ4laqOI2mJc83vYLfUw0VQS7gY3M4EIaBb/YD/
# N9LOHGqE+jK6Z8DjgW8M2+C/WKd7qhUq4D7R9Exnh2KClXn9vtNfmxB4oCdMhO3K
# saGEvk+By3xjo+fUxG2DTq84BbWBfW1q+TkFjoZUdvY26a+8u24/DJmbjX8gtjnt
# vASYKLel+07MSoOfnZgfyaFELJfoYeFvvKHZYho3pkCvxEhmvRbXyOJmsTLVnVU3
# LyfY46S3WBvLN1+DOxShwXQlmKZP1BfSuE/a9aRc1FxVXRmcQsp9NaWALEkqBDvc
# s4HJKUduXoauYlp/AuXDgAyc0hznf4gs/axYD+k3i6GCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQxNDNaMD8GCSqG
# SIb3DQEJBDEyBDDfyoVkK90hTShAGxAH8b34QWMCah/YhAxnk5iUhfNqcKbKSDeQ
# OsbAPYmmcsXuUMowDQYJKoZIhvcNAQEBBQAEggIAkwFglxBKDhb8LhzBB/6XTluV
# S57T7LlfxVdKgwCuKkxl7HPQMNLnIX2RAKci1Psz5PzeRqp4GP8Cn8titDGakYZG
# 9bhGwq8V2HpbaLZ6f6RD2ZETQgh8y+X5HyM/MHJ7YbtjgmE0OXryDG9hL06lhHqv
# WjRVOgELlUaWF0X5aghXW2D7wwpsNlnyaex5jYtn9IEw1emSgJyfPcA2rZlu8rKn
# cFL36+oCG4Ej36gx7sCT9tZuXhm9Y4sC9AnRxbJuhpahCa/5v+8TWmOrEma9tZVX
# hyccutZYTQemc2mHW2EI8uwHN8vpgy0K6GlryogPWKq5gNP64crK331EDjbIhO0W
# oxcsWOCU4Djbd5gPVy9oiAdjOo4fN0sab9tk8j50n7s1wYzg871Rag62ooZgkb0F
# HRacoC3Qw1YdiA/36d4Kf5P9AITCsI3BTVJgVAScxZk2rQhNv1kxDkhCaNYmhtwK
# K4C97FzQROBWTux6DbmBvmKsZp4fkPJbdGHS6IWvCWdQMYpaIqOK3HLKLFqSVu7I
# GHzAtVKFhT3EvaHjXGj+wpynKYWtNQbzcscKKxH9RdCF1ODtPO4Io1cbkrEQPt99
# WCirp19jDtaiW0rqJq4ZDxjk9k35jz+8X88Iqjr12XhgRHX5xoB1AWnhGix1uer7
# QyPze/ElcRxg8OSWLuI=
# SIG # End signature block
