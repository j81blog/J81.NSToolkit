function Invoke-NSGetUrlfilteringcategories {
    <#
    .SYNOPSIS
        Get URL Filtering feature is used control access to webpages based on category. config object(s).
    .DESCRIPTION
        Configuration for Categories resource.
    .PARAMETER Group 
        URL Filtering SDK Category per Group. 
    .PARAMETER GetAll 
        Retrieve all urlfilteringcategories object(s).
    .PARAMETER Count
        If specified, the count of the urlfilteringcategories object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringcategories
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetUrlfilteringcategories -GetAll 
        Get all urlfilteringcategories data.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringcategories -name <string>
        Get urlfilteringcategories object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringcategories -Filter @{ 'name'='<value>' }
        Get urlfilteringcategories data with a filter.
    .NOTES
        File Name : Invoke-NSGetUrlfilteringcategories
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/urlfiltering/urlfilteringcategories/
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
        [string]$Group,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetUrlfilteringcategories: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all urlfilteringcategories objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringcategories objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringcategories objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('group') ) { $arguments.Add('group', $group) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringcategories configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringcategories configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetUrlfilteringcategories: Ended"
    }
}

function Invoke-NSAddUrlfilteringcategorization {
    <#
    .SYNOPSIS
        Add URL Filtering feature is used control access to webpages based on category. config Object.
    .DESCRIPTION
        Configuration for Categorization resource.
    .PARAMETER Url 
        Url given for categorization.
    .EXAMPLE
        PS C:\>Invoke-NSAddUrlfilteringcategorization -url <string>
        An example how to add urlfilteringcategorization config Object(s).
    .NOTES
        File Name : Invoke-NSAddUrlfilteringcategorization
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/urlfiltering/urlfilteringcategorization/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Url 
    )
    begin {
        Write-Verbose "Invoke-NSAddUrlfilteringcategorization: Starting"
    }
    process {
        try {
            $payload = @{ url = $url }

            if ( $PSCmdlet.ShouldProcess("urlfilteringcategorization", "Add URL Filtering feature is used control access to webpages based on category. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type urlfilteringcategorization -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSAddUrlfilteringcategorization: Finished"
    }
}

function Invoke-NSClearUrlfilteringcategorization {
    <#
    .SYNOPSIS
        Clear URL Filtering feature is used control access to webpages based on category. config Object.
    .DESCRIPTION
        Configuration for Categorization resource.
    .EXAMPLE
        PS C:\>Invoke-NSClearUrlfilteringcategorization 
        An example how to clear urlfilteringcategorization config Object(s).
    .NOTES
        File Name : Invoke-NSClearUrlfilteringcategorization
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/urlfiltering/urlfilteringcategorization/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSClearUrlfilteringcategorization: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear URL Filtering feature is used control access to webpages based on category. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type urlfilteringcategorization -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSClearUrlfilteringcategorization: Finished"
    }
}

function Invoke-NSGetUrlfilteringcategorization {
    <#
    .SYNOPSIS
        Get URL Filtering feature is used control access to webpages based on category. config object(s).
    .DESCRIPTION
        Configuration for Categorization resource.
    .PARAMETER GetAll 
        Retrieve all urlfilteringcategorization object(s).
    .PARAMETER Count
        If specified, the count of the urlfilteringcategorization object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringcategorization
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetUrlfilteringcategorization -GetAll 
        Get all urlfilteringcategorization data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetUrlfilteringcategorization -Count 
        Get the number of urlfilteringcategorization objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringcategorization -name <string>
        Get urlfilteringcategorization object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringcategorization -Filter @{ 'name'='<value>' }
        Get urlfilteringcategorization data with a filter.
    .NOTES
        File Name : Invoke-NSGetUrlfilteringcategorization
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/urlfiltering/urlfilteringcategorization/
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
        Write-Verbose "Invoke-NSGetUrlfilteringcategorization: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all urlfilteringcategorization objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringcategorization objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringcategorization objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringcategorization configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringcategorization configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetUrlfilteringcategorization: Ended"
    }
}

function Invoke-NSGetUrlfilteringcategorygroups {
    <#
    .SYNOPSIS
        Get URL Filtering feature is used control access to webpages based on category. config object(s).
    .DESCRIPTION
        Configuration for Category Groups resource.
    .PARAMETER GetAll 
        Retrieve all urlfilteringcategorygroups object(s).
    .PARAMETER Count
        If specified, the count of the urlfilteringcategorygroups object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringcategorygroups
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetUrlfilteringcategorygroups -GetAll 
        Get all urlfilteringcategorygroups data.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringcategorygroups -name <string>
        Get urlfilteringcategorygroups object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringcategorygroups -Filter @{ 'name'='<value>' }
        Get urlfilteringcategorygroups data with a filter.
    .NOTES
        File Name : Invoke-NSGetUrlfilteringcategorygroups
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/urlfiltering/urlfilteringcategorygroups/
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
        Write-Verbose "Invoke-NSGetUrlfilteringcategorygroups: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all urlfilteringcategorygroups objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringcategorygroups objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringcategorygroups objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringcategorygroups configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringcategorygroups configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetUrlfilteringcategorygroups: Ended"
    }
}

function Invoke-NSUpdateUrlfilteringparameter {
    <#
    .SYNOPSIS
        Update URL Filtering feature is used control access to webpages based on category. config Object.
    .DESCRIPTION
        Configuration for URLFILTERING paramter resource.
    .PARAMETER Hoursbetweendbupdates 
        URL Filtering hours between DB updates. 
         
        Maximum value = 720 
    .PARAMETER Timeofdaytoupdatedb 
        URL Filtering time of day to update DB. 
    .PARAMETER Localdatabasethreads 
        URL Filtering Local DB number of threads. 
         
        Maximum value = 4 
    .PARAMETER Cloudhost 
        URL Filtering Cloud host. 
    .PARAMETER Seeddbpath 
        URL Filtering Seed DB path.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateUrlfilteringparameter 
        An example how to update urlfilteringparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateUrlfilteringparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/urlfiltering/urlfilteringparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [double]$Hoursbetweendbupdates,

        [string]$Timeofdaytoupdatedb,

        [double]$Localdatabasethreads,

        [string]$Cloudhost,

        [string]$Seeddbpath 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateUrlfilteringparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('hoursbetweendbupdates') ) { $payload.Add('hoursbetweendbupdates', $hoursbetweendbupdates) }
            if ( $PSBoundParameters.ContainsKey('timeofdaytoupdatedb') ) { $payload.Add('timeofdaytoupdatedb', $timeofdaytoupdatedb) }
            if ( $PSBoundParameters.ContainsKey('localdatabasethreads') ) { $payload.Add('localdatabasethreads', $localdatabasethreads) }
            if ( $PSBoundParameters.ContainsKey('cloudhost') ) { $payload.Add('cloudhost', $cloudhost) }
            if ( $PSBoundParameters.ContainsKey('seeddbpath') ) { $payload.Add('seeddbpath', $seeddbpath) }
            if ( $PSCmdlet.ShouldProcess("urlfilteringparameter", "Update URL Filtering feature is used control access to webpages based on category. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type urlfilteringparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateUrlfilteringparameter: Finished"
    }
}

function Invoke-NSUnsetUrlfilteringparameter {
    <#
    .SYNOPSIS
        Unset URL Filtering feature is used control access to webpages based on category. config Object.
    .DESCRIPTION
        Configuration for URLFILTERING paramter resource.
    .PARAMETER Hoursbetweendbupdates 
        URL Filtering hours between DB updates. 
         
        Maximum value = 720 
    .PARAMETER Timeofdaytoupdatedb 
        URL Filtering time of day to update DB. 
    .PARAMETER Localdatabasethreads 
        URL Filtering Local DB number of threads. 
         
        Maximum value = 4 
    .PARAMETER Cloudhost 
        URL Filtering Cloud host. 
    .PARAMETER Seeddbpath 
        URL Filtering Seed DB path.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetUrlfilteringparameter 
        An example how to unset urlfilteringparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetUrlfilteringparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/urlfiltering/urlfilteringparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$hoursbetweendbupdates,

        [Boolean]$timeofdaytoupdatedb,

        [Boolean]$localdatabasethreads,

        [Boolean]$cloudhost,

        [Boolean]$seeddbpath 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetUrlfilteringparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('hoursbetweendbupdates') ) { $payload.Add('hoursbetweendbupdates', $hoursbetweendbupdates) }
            if ( $PSBoundParameters.ContainsKey('timeofdaytoupdatedb') ) { $payload.Add('timeofdaytoupdatedb', $timeofdaytoupdatedb) }
            if ( $PSBoundParameters.ContainsKey('localdatabasethreads') ) { $payload.Add('localdatabasethreads', $localdatabasethreads) }
            if ( $PSBoundParameters.ContainsKey('cloudhost') ) { $payload.Add('cloudhost', $cloudhost) }
            if ( $PSBoundParameters.ContainsKey('seeddbpath') ) { $payload.Add('seeddbpath', $seeddbpath) }
            if ( $PSCmdlet.ShouldProcess("urlfilteringparameter", "Unset URL Filtering feature is used control access to webpages based on category. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type urlfilteringparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetUrlfilteringparameter: Finished"
    }
}

function Invoke-NSGetUrlfilteringparameter {
    <#
    .SYNOPSIS
        Get URL Filtering feature is used control access to webpages based on category. config object(s).
    .DESCRIPTION
        Configuration for URLFILTERING paramter resource.
    .PARAMETER GetAll 
        Retrieve all urlfilteringparameter object(s).
    .PARAMETER Count
        If specified, the count of the urlfilteringparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetUrlfilteringparameter -GetAll 
        Get all urlfilteringparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringparameter -name <string>
        Get urlfilteringparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetUrlfilteringparameter -Filter @{ 'name'='<value>' }
        Get urlfilteringparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetUrlfilteringparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/urlfiltering/urlfilteringparameter/
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
        Write-Verbose "Invoke-NSGetUrlfilteringparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all urlfilteringparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetUrlfilteringparameter: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAsjtKJFZlIGReq
# xR7cTKYQIy0A5E/Z5u3xSdoywETVQaCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgDfvskF+SCA7N9V3MD/wVKfe2ndu7niDiW53S/at7v7MwDQYJKoZIhvcNAQEB
# BQAEggEAEPIkhlzDY22D0iw+Wh7tdIi+yJbk/ZXM9jauRoP8nezbiaWOzz2Y7n6O
# 7zFxYRfiOA73sVR8atZTHZ5w4h6PbQaUz+WeUkkhGZOTCsR70g0z33xuAHSxSH9y
# XN5Do3/OGzlhfkMZ+bVz8yrOf/AaqlTcfzWCB6btwGUhbUzyHHjZznhnJpU5YXD3
# j49LClavzjtuV+kkNiHJ146L0ByMDj35RIByKlLV7/Fd4+1JL5IyCUYXL5VolZnt
# UApSsaZXtvuB2LVIs5SLOMjLpcB5Llded3qbQ4CQ2DKaUBF106TS6n8D/SRjQFqa
# lPyw/AYaLreeKVywkUbeR0xgwCuOeg==
# SIG # End signature block
