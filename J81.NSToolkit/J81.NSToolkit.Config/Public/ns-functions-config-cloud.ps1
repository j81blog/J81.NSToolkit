function Invoke-NSAddCloudallowedngsticketprofile {
    <#
    .SYNOPSIS
        Add Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for Allowed ticket profile for NGS resource.
    .PARAMETER Name 
        Profile name for allowed tickets. 
    .PARAMETER Creator 
        Created name for allowed tickets. 
    .PARAMETER PassThru 
        Return details about the created cloudallowedngsticketprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCloudallowedngsticketprofile -name <string>
        An example how to add cloudallowedngsticketprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddCloudallowedngsticketprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudallowedngsticketprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Creator,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCloudallowedngsticketprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('creator') ) { $payload.Add('creator', $creator) }
            if ( $PSCmdlet.ShouldProcess("cloudallowedngsticketprofile", "Add Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cloudallowedngsticketprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCloudallowedngsticketprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCloudallowedngsticketprofile: Finished"
    }
}

function Invoke-NSDeleteCloudallowedngsticketprofile {
    <#
    .SYNOPSIS
        Delete Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for Allowed ticket profile for NGS resource.
    .PARAMETER Name 
        Profile name for allowed tickets.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCloudallowedngsticketprofile -Name <string>
        An example how to delete cloudallowedngsticketprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCloudallowedngsticketprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudallowedngsticketprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteCloudallowedngsticketprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cloudallowedngsticketprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCloudallowedngsticketprofile: Finished"
    }
}

function Invoke-NSUpdateCloudallowedngsticketprofile {
    <#
    .SYNOPSIS
        Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for Allowed ticket profile for NGS resource.
    .PARAMETER Name 
        Profile name for allowed tickets. 
    .PARAMETER Creator 
        Created name for allowed tickets. 
    .PARAMETER PassThru 
        Return details about the created cloudallowedngsticketprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCloudallowedngsticketprofile -name <string>
        An example how to update cloudallowedngsticketprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCloudallowedngsticketprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudallowedngsticketprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Creator,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCloudallowedngsticketprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('creator') ) { $payload.Add('creator', $creator) }
            if ( $PSCmdlet.ShouldProcess("cloudallowedngsticketprofile", "Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cloudallowedngsticketprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCloudallowedngsticketprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCloudallowedngsticketprofile: Finished"
    }
}

function Invoke-NSGetCloudallowedngsticketprofile {
    <#
    .SYNOPSIS
        Get Citrix ADC as SD proxy Configuration and cloud discovery commands. config object(s).
    .DESCRIPTION
        Configuration for Allowed ticket profile for NGS resource.
    .PARAMETER Name 
        Profile name for allowed tickets. 
    .PARAMETER GetAll 
        Retrieve all cloudallowedngsticketprofile object(s).
    .PARAMETER Count
        If specified, the count of the cloudallowedngsticketprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudallowedngsticketprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudallowedngsticketprofile -GetAll 
        Get all cloudallowedngsticketprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudallowedngsticketprofile -Count 
        Get the number of cloudallowedngsticketprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudallowedngsticketprofile -name <string>
        Get cloudallowedngsticketprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudallowedngsticketprofile -Filter @{ 'name'='<value>' }
        Get cloudallowedngsticketprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetCloudallowedngsticketprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudallowedngsticketprofile/
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
        Write-Verbose "Invoke-NSGetCloudallowedngsticketprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudallowedngsticketprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudallowedngsticketprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudallowedngsticketprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudallowedngsticketprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudallowedngsticketprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudallowedngsticketprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudallowedngsticketprofile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudallowedngsticketprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cloudallowedngsticketprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudallowedngsticketprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCloudallowedngsticketprofile: Ended"
    }
}

function Invoke-NSGetCloudautoscalegroup {
    <#
    .SYNOPSIS
        Get Citrix ADC as SD proxy Configuration and cloud discovery commands. config object(s).
    .DESCRIPTION
        Configuration for Cloud autoscalegroup resource.
    .PARAMETER Name 
        . 
    .PARAMETER GetAll 
        Retrieve all cloudautoscalegroup object(s).
    .PARAMETER Count
        If specified, the count of the cloudautoscalegroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudautoscalegroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudautoscalegroup -GetAll 
        Get all cloudautoscalegroup data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudautoscalegroup -Count 
        Get the number of cloudautoscalegroup objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudautoscalegroup -name <string>
        Get cloudautoscalegroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudautoscalegroup -Filter @{ 'name'='<value>' }
        Get cloudautoscalegroup data with a filter.
    .NOTES
        File Name : Invoke-NSGetCloudautoscalegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudautoscalegroup/
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
        Write-Verbose "Invoke-NSGetCloudautoscalegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudautoscalegroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudautoscalegroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudautoscalegroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudautoscalegroup configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cloudautoscalegroup configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCloudautoscalegroup: Ended"
    }
}

function Invoke-NSUpdateCloudawsparam {
    <#
    .SYNOPSIS
        Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud awsParam resource.
    .PARAMETER Rolearn 
        IAM Role ARN.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCloudawsparam 
        An example how to update cloudawsparam config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCloudawsparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudawsparam/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Rolearn 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCloudawsparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('rolearn') ) { $payload.Add('rolearn', $rolearn) }
            if ( $PSCmdlet.ShouldProcess("cloudawsparam", "Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cloudawsparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateCloudawsparam: Finished"
    }
}

function Invoke-NSUnsetCloudawsparam {
    <#
    .SYNOPSIS
        Unset Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud awsParam resource.
    .PARAMETER Rolearn 
        IAM Role ARN.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCloudawsparam 
        An example how to unset cloudawsparam config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCloudawsparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudawsparam
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$rolearn 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCloudawsparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('rolearn') ) { $payload.Add('rolearn', $rolearn) }
            if ( $PSCmdlet.ShouldProcess("cloudawsparam", "Unset Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type cloudawsparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCloudawsparam: Finished"
    }
}

function Invoke-NSGetCloudawsparam {
    <#
    .SYNOPSIS
        Get Citrix ADC as SD proxy Configuration and cloud discovery commands. config object(s).
    .DESCRIPTION
        Configuration for cloud awsParam resource.
    .PARAMETER GetAll 
        Retrieve all cloudawsparam object(s).
    .PARAMETER Count
        If specified, the count of the cloudawsparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudawsparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudawsparam -GetAll 
        Get all cloudawsparam data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudawsparam -name <string>
        Get cloudawsparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudawsparam -Filter @{ 'name'='<value>' }
        Get cloudawsparam data with a filter.
    .NOTES
        File Name : Invoke-NSGetCloudawsparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudawsparam/
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
        Write-Verbose "Invoke-NSGetCloudawsparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudawsparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudawsparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudawsparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudawsparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudawsparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudawsparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudawsparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudawsparam configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudawsparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCloudawsparam: Ended"
    }
}

function Invoke-NSUpdateCloudcredential {
    <#
    .SYNOPSIS
        Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud credentials resource.
    .PARAMETER Tenantidentifier 
        Tenant ID of the Credentials. 
    .PARAMETER Applicationid 
        Application ID of the Credentials. 
    .PARAMETER Applicationsecret 
        Application Secret of the Credentials.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCloudcredential -tenantidentifier <string> -applicationid <string> -applicationsecret <string>
        An example how to update cloudcredential config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCloudcredential
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudcredential/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Tenantidentifier,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Applicationid,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Applicationsecret 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCloudcredential: Starting"
    }
    process {
        try {
            $payload = @{ tenantidentifier = $tenantidentifier
                applicationid              = $applicationid
                applicationsecret          = $applicationsecret
            }

            if ( $PSCmdlet.ShouldProcess("cloudcredential", "Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cloudcredential -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateCloudcredential: Finished"
    }
}

function Invoke-NSGetCloudcredential {
    <#
    .SYNOPSIS
        Get Citrix ADC as SD proxy Configuration and cloud discovery commands. config object(s).
    .DESCRIPTION
        Configuration for cloud credentials resource.
    .PARAMETER GetAll 
        Retrieve all cloudcredential object(s).
    .PARAMETER Count
        If specified, the count of the cloudcredential object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudcredential
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudcredential -GetAll 
        Get all cloudcredential data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudcredential -name <string>
        Get cloudcredential object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudcredential -Filter @{ 'name'='<value>' }
        Get cloudcredential data with a filter.
    .NOTES
        File Name : Invoke-NSGetCloudcredential
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudcredential/
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
        Write-Verbose "Invoke-NSGetCloudcredential: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudcredential objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudcredential objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudcredential objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudcredential configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudcredential configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCloudcredential: Ended"
    }
}

function Invoke-NSUpdateCloudngsparameter {
    <#
    .SYNOPSIS
        Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud ngsparameter resource.
    .PARAMETER Blockonallowedngstktprof 
        Enables blocking connections authenticated with a ticket createdby by an entity not whitelisted in allowedngstktprofile. 
         
        Possible values = YES, NO 
    .PARAMETER Allowedudtversion 
        Enables the required UDT version to EDT connections in the CGS deployment. 
         
        Possible values = V4, V5, V6, V7 
    .PARAMETER Csvserverticketingdecouple 
        Enables Decoupling CSVSERVER state from Ticketing Service state in the CGS deployment. 
         
        Possible values = YES, NO 
    .PARAMETER Allowdtls12 
        Enables DTLS1.2 for client connections on CGS. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCloudngsparameter 
        An example how to update cloudngsparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCloudngsparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudngsparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateSet('YES', 'NO')]
        [string]$Blockonallowedngstktprof,

        [ValidateSet('V4', 'V5', 'V6', 'V7')]
        [string]$Allowedudtversion,

        [ValidateSet('YES', 'NO')]
        [string]$Csvserverticketingdecouple,

        [ValidateSet('YES', 'NO')]
        [string]$Allowdtls12 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCloudngsparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('blockonallowedngstktprof') ) { $payload.Add('blockonallowedngstktprof', $blockonallowedngstktprof) }
            if ( $PSBoundParameters.ContainsKey('allowedudtversion') ) { $payload.Add('allowedudtversion', $allowedudtversion) }
            if ( $PSBoundParameters.ContainsKey('csvserverticketingdecouple') ) { $payload.Add('csvserverticketingdecouple', $csvserverticketingdecouple) }
            if ( $PSBoundParameters.ContainsKey('allowdtls12') ) { $payload.Add('allowdtls12', $allowdtls12) }
            if ( $PSCmdlet.ShouldProcess("cloudngsparameter", "Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cloudngsparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateCloudngsparameter: Finished"
    }
}

function Invoke-NSUnsetCloudngsparameter {
    <#
    .SYNOPSIS
        Unset Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud ngsparameter resource.
    .PARAMETER Blockonallowedngstktprof 
        Enables blocking connections authenticated with a ticket createdby by an entity not whitelisted in allowedngstktprofile. 
         
        Possible values = YES, NO 
    .PARAMETER Allowedudtversion 
        Enables the required UDT version to EDT connections in the CGS deployment. 
         
        Possible values = V4, V5, V6, V7 
    .PARAMETER Csvserverticketingdecouple 
        Enables Decoupling CSVSERVER state from Ticketing Service state in the CGS deployment. 
         
        Possible values = YES, NO 
    .PARAMETER Allowdtls12 
        Enables DTLS1.2 for client connections on CGS. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCloudngsparameter 
        An example how to unset cloudngsparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCloudngsparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudngsparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$blockonallowedngstktprof,

        [Boolean]$allowedudtversion,

        [Boolean]$csvserverticketingdecouple,

        [Boolean]$allowdtls12 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCloudngsparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('blockonallowedngstktprof') ) { $payload.Add('blockonallowedngstktprof', $blockonallowedngstktprof) }
            if ( $PSBoundParameters.ContainsKey('allowedudtversion') ) { $payload.Add('allowedudtversion', $allowedudtversion) }
            if ( $PSBoundParameters.ContainsKey('csvserverticketingdecouple') ) { $payload.Add('csvserverticketingdecouple', $csvserverticketingdecouple) }
            if ( $PSBoundParameters.ContainsKey('allowdtls12') ) { $payload.Add('allowdtls12', $allowdtls12) }
            if ( $PSCmdlet.ShouldProcess("cloudngsparameter", "Unset Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type cloudngsparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCloudngsparameter: Finished"
    }
}

function Invoke-NSGetCloudngsparameter {
    <#
    .SYNOPSIS
        Get Citrix ADC as SD proxy Configuration and cloud discovery commands. config object(s).
    .DESCRIPTION
        Configuration for cloud ngsparameter resource.
    .PARAMETER GetAll 
        Retrieve all cloudngsparameter object(s).
    .PARAMETER Count
        If specified, the count of the cloudngsparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudngsparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudngsparameter -GetAll 
        Get all cloudngsparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudngsparameter -name <string>
        Get cloudngsparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudngsparameter -Filter @{ 'name'='<value>' }
        Get cloudngsparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetCloudngsparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudngsparameter/
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
        Write-Verbose "Invoke-NSGetCloudngsparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudngsparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudngsparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudngsparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudngsparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudngsparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudngsparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudngsparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudngsparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudngsparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCloudngsparameter: Ended"
    }
}

function Invoke-NSUpdateCloudparameter {
    <#
    .SYNOPSIS
        Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud parameter resource.
    .PARAMETER Controllerfqdn 
        FQDN of the controller to which the Citrix ADC SDProxy Connects. 
    .PARAMETER Controllerport 
        Port number of the controller to which the Citrix ADC SDProxy connects. 
    .PARAMETER Instanceid 
        Instance ID of the customer provided by Trust. 
    .PARAMETER Customerid 
        Customer ID of the citrix cloud customer. 
    .PARAMETER Resourcelocation 
        Resource Location of the customer provided by Trust. 
    .PARAMETER Activationcode 
        Activation code for the NGS Connector instance. 
    .PARAMETER Deployment 
        Describes if the customer is a Staging/Production or Dev Citrix Cloud customer. 
        Possible values = Production, Staging, Dev 
    .PARAMETER Connectorresidence 
        Identifies whether the connector is located Onprem, Aws or Azure. 
        Possible values = None, Onprem, Aws, Azure, Cpx
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCloudparameter 
        An example how to update cloudparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCloudparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Controllerfqdn,

        [ValidateRange(1, 65535)]
        [int]$Controllerport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Instanceid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Customerid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resourcelocation,

        [string]$Activationcode,

        [ValidateSet('Production', 'Staging', 'Dev')]
        [string]$Deployment,

        [ValidateSet('None', 'Onprem', 'Aws', 'Azure', 'Cpx')]
        [string]$Connectorresidence 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCloudparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('controllerfqdn') ) { $payload.Add('controllerfqdn', $controllerfqdn) }
            if ( $PSBoundParameters.ContainsKey('controllerport') ) { $payload.Add('controllerport', $controllerport) }
            if ( $PSBoundParameters.ContainsKey('instanceid') ) { $payload.Add('instanceid', $instanceid) }
            if ( $PSBoundParameters.ContainsKey('customerid') ) { $payload.Add('customerid', $customerid) }
            if ( $PSBoundParameters.ContainsKey('resourcelocation') ) { $payload.Add('resourcelocation', $resourcelocation) }
            if ( $PSBoundParameters.ContainsKey('activationcode') ) { $payload.Add('activationcode', $activationcode) }
            if ( $PSBoundParameters.ContainsKey('deployment') ) { $payload.Add('deployment', $deployment) }
            if ( $PSBoundParameters.ContainsKey('connectorresidence') ) { $payload.Add('connectorresidence', $connectorresidence) }
            if ( $PSCmdlet.ShouldProcess("cloudparameter", "Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cloudparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateCloudparameter: Finished"
    }
}

function Invoke-NSUnsetCloudparameter {
    <#
    .SYNOPSIS
        Unset Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud parameter resource.
    .PARAMETER Instanceid 
        Instance ID of the customer provided by Trust. 
    .PARAMETER Customerid 
        Customer ID of the citrix cloud customer. 
    .PARAMETER Resourcelocation 
        Resource Location of the customer provided by Trust.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCloudparameter 
        An example how to unset cloudparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCloudparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$instanceid,

        [Boolean]$customerid,

        [Boolean]$resourcelocation 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCloudparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('instanceid') ) { $payload.Add('instanceid', $instanceid) }
            if ( $PSBoundParameters.ContainsKey('customerid') ) { $payload.Add('customerid', $customerid) }
            if ( $PSBoundParameters.ContainsKey('resourcelocation') ) { $payload.Add('resourcelocation', $resourcelocation) }
            if ( $PSCmdlet.ShouldProcess("cloudparameter", "Unset Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type cloudparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCloudparameter: Finished"
    }
}

function Invoke-NSGetCloudparameter {
    <#
    .SYNOPSIS
        Get Citrix ADC as SD proxy Configuration and cloud discovery commands. config object(s).
    .DESCRIPTION
        Configuration for cloud parameter resource.
    .PARAMETER GetAll 
        Retrieve all cloudparameter object(s).
    .PARAMETER Count
        If specified, the count of the cloudparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudparameter -GetAll 
        Get all cloudparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudparameter -name <string>
        Get cloudparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudparameter -Filter @{ 'name'='<value>' }
        Get cloudparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetCloudparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudparameter/
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
        Write-Verbose "Invoke-NSGetCloudparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCloudparameter: Ended"
    }
}

function Invoke-NSUpdateCloudparaminternal {
    <#
    .SYNOPSIS
        Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud paramInternal resource.
    .PARAMETER Nonftumode 
        Indicates if GUI in in FTU mode or not. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCloudparaminternal 
        An example how to update cloudparaminternal config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCloudparaminternal
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudparaminternal/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateSet('YES', 'NO')]
        [string]$Nonftumode 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCloudparaminternal: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('nonftumode') ) { $payload.Add('nonftumode', $nonftumode) }
            if ( $PSCmdlet.ShouldProcess("cloudparaminternal", "Update Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cloudparaminternal -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateCloudparaminternal: Finished"
    }
}

function Invoke-NSGetCloudparaminternal {
    <#
    .SYNOPSIS
        Get Citrix ADC as SD proxy Configuration and cloud discovery commands. config object(s).
    .DESCRIPTION
        Configuration for cloud paramInternal resource.
    .PARAMETER GetAll 
        Retrieve all cloudparaminternal object(s).
    .PARAMETER Count
        If specified, the count of the cloudparaminternal object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudparaminternal
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudparaminternal -GetAll 
        Get all cloudparaminternal data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudparaminternal -Count 
        Get the number of cloudparaminternal objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudparaminternal -name <string>
        Get cloudparaminternal object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudparaminternal -Filter @{ 'name'='<value>' }
        Get cloudparaminternal data with a filter.
    .NOTES
        File Name : Invoke-NSGetCloudparaminternal
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudparaminternal/
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
        Write-Verbose "Invoke-NSGetCloudparaminternal: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudparaminternal objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudparaminternal objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudparaminternal objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudparaminternal configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudparaminternal configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCloudparaminternal: Ended"
    }
}

function Invoke-NSAddCloudprofile {
    <#
    .SYNOPSIS
        Add Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud profile resource.
    .PARAMETER Name 
        Name for the Cloud profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER Type 
        Type of cloud profile that you want to create, Vserver or based on Azure Tags. 
        Possible values = autoscale, azuretags 
    .PARAMETER Vservername 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Servicetype 
        Protocol used by the service (also called the service type). 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, DNS, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, RTSP, PUSH, SSL_PUSH, RADIUS, RDP, MYSQL, MSSQL, DIAMETER, SSL_DIAMETER, TFTP, ORACLE, SMPP, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, PROXY, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, MONGO, MONGO_TLS, MQTT, MQTT_TLS, QUIC_BRIDGE, HTTP_QUIC 
    .PARAMETER Ipaddress 
        IPv4 or IPv6 address to assign to the virtual server. 
    .PARAMETER Port 
        Port number for the virtual server. 
    .PARAMETER Servicegroupname 
        servicegroups bind to this server. 
    .PARAMETER Boundservicegroupsvctype 
        The type of bound service. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, RPCSVR, DNS, ADNS, SNMP, RTSP, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, ADNS_TCP, MYSQL, MSSQL, ORACLE, MONGO, MONGO_TLS, RADIUS, RADIUSListener, RDP, DIAMETER, SSL_DIAMETER, TFTP, SMPP, PPTP, GRE, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, LOGSTREAM_SSL, MQTT, MQTT_TLS, QUIC_BRIDGE 
    .PARAMETER Vsvrbindsvcport 
        The port number to be used for the bound service. 
    .PARAMETER Graceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service. 
         
        Possible values = YES, NO 
    .PARAMETER Delay 
        Time, in seconds, after which all the services configured on the server are disabled. 
    .PARAMETER Azuretagname 
        Azure tag name. 
    .PARAMETER Azuretagvalue 
        Azure tag value. 
    .PARAMETER Azurepollperiod 
        Azure polling period (in seconds). 
         
         
        Maximum value = 3600 
    .PARAMETER PassThru 
        Return details about the created cloudprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCloudprofile -name <string> -type <string> -vservername <string> -servicetype <string> -ipaddress <string> -port <int> -servicegroupname <string> -boundservicegroupsvctype <string> -vsvrbindsvcport <int>
        An example how to add cloudprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddCloudprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [ValidateSet('autoscale', 'azuretags')]
        [string]$Type,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Vservername,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'DNS', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'RTSP', 'PUSH', 'SSL_PUSH', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'ORACLE', 'SMPP', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'PROXY', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'MONGO', 'MONGO_TLS', 'MQTT', 'MQTT_TLS', 'QUIC_BRIDGE', 'HTTP_QUIC')]
        [string]$Servicetype,

        [Parameter(Mandatory)]
        [string]$Ipaddress,

        [Parameter(Mandatory)]
        [ValidateRange(1, 65535)]
        [int]$Port,

        [Parameter(Mandatory)]
        [string]$Servicegroupname,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'RPCSVR', 'DNS', 'ADNS', 'SNMP', 'RTSP', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'ADNS_TCP', 'MYSQL', 'MSSQL', 'ORACLE', 'MONGO', 'MONGO_TLS', 'RADIUS', 'RADIUSListener', 'RDP', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'SMPP', 'PPTP', 'GRE', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'LOGSTREAM_SSL', 'MQTT', 'MQTT_TLS', 'QUIC_BRIDGE')]
        [string]$Boundservicegroupsvctype,

        [Parameter(Mandatory)]
        [ValidateRange(1, 65535)]
        [int]$Vsvrbindsvcport,

        [ValidateSet('YES', 'NO')]
        [string]$Graceful = 'NO',

        [double]$Delay,

        [string]$Azuretagname,

        [string]$Azuretagvalue,

        [double]$Azurepollperiod = '60',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCloudprofile: Starting"
    }
    process {
        try {
            $payload = @{ name           = $name
                type                     = $type
                vservername              = $vservername
                servicetype              = $servicetype
                ipaddress                = $ipaddress
                port                     = $port
                servicegroupname         = $servicegroupname
                boundservicegroupsvctype = $boundservicegroupsvctype
                vsvrbindsvcport          = $vsvrbindsvcport
            }
            if ( $PSBoundParameters.ContainsKey('graceful') ) { $payload.Add('graceful', $graceful) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('azuretagname') ) { $payload.Add('azuretagname', $azuretagname) }
            if ( $PSBoundParameters.ContainsKey('azuretagvalue') ) { $payload.Add('azuretagvalue', $azuretagvalue) }
            if ( $PSBoundParameters.ContainsKey('azurepollperiod') ) { $payload.Add('azurepollperiod', $azurepollperiod) }
            if ( $PSCmdlet.ShouldProcess("cloudprofile", "Add Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cloudprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCloudprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCloudprofile: Finished"
    }
}

function Invoke-NSDeleteCloudprofile {
    <#
    .SYNOPSIS
        Delete Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud profile resource.
    .PARAMETER Name 
        Name for the Cloud profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCloudprofile -Name <string>
        An example how to delete cloudprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCloudprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteCloudprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cloudprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCloudprofile: Finished"
    }
}

function Invoke-NSGetCloudprofile {
    <#
    .SYNOPSIS
        Get Citrix ADC as SD proxy Configuration and cloud discovery commands. config object(s).
    .DESCRIPTION
        Configuration for cloud profile resource.
    .PARAMETER Name 
        Name for the Cloud profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER GetAll 
        Retrieve all cloudprofile object(s).
    .PARAMETER Count
        If specified, the count of the cloudprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudprofile -GetAll 
        Get all cloudprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudprofile -Count 
        Get the number of cloudprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudprofile -name <string>
        Get cloudprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudprofile -Filter @{ 'name'='<value>' }
        Get cloudprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetCloudprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudprofile/
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
        Write-Verbose "Invoke-NSGetCloudprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudprofile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cloudprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCloudprofile: Ended"
    }
}

function Invoke-NSCheckCloudservice {
    <#
    .SYNOPSIS
        Check Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object.
    .DESCRIPTION
        Configuration for cloud service resource.
    .EXAMPLE
        PS C:\>Invoke-NSCheckCloudservice 
        An example how to check cloudservice config Object(s).
    .NOTES
        File Name : Invoke-NSCheckCloudservice
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudservice/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSCheckCloudservice: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Check Citrix ADC as SD proxy Configuration and cloud discovery commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cloudservice -Action check -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSCheckCloudservice: Finished"
    }
}

function Invoke-NSGetCloudvserverip {
    <#
    .SYNOPSIS
        Get Citrix ADC as SD proxy Configuration and cloud discovery commands. config object(s).
    .DESCRIPTION
        Configuration for Cloud virtual server IPs resource.
    .PARAMETER GetAll 
        Retrieve all cloudvserverip object(s).
    .PARAMETER Count
        If specified, the count of the cloudvserverip object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudvserverip
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudvserverip -GetAll 
        Get all cloudvserverip data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCloudvserverip -Count 
        Get the number of cloudvserverip objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudvserverip -name <string>
        Get cloudvserverip object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCloudvserverip -Filter @{ 'name'='<value>' }
        Get cloudvserverip data with a filter.
    .NOTES
        File Name : Invoke-NSGetCloudvserverip
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cloud/cloudvserverip/
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
        Write-Verbose "Invoke-NSGetCloudvserverip: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudvserverip objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudvserverip objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudvserverip objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudvserverip configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudvserverip configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCloudvserverip: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCRPMdDgUmLFjb4
# xC+s+P0PMbYDPzffDRGr7ocaXJerI6CCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQgX2H26SApS29AeWP+fLjkk9UtT5zgkocX5P1eNi4uxhEwDQYJ
# KoZIhvcNAQEBBQAEggEApDPRHJzEnv11VulBzJCjnqJAgDOlCu6hqUmasUsotjeK
# ooZtBOw+s9tmo5sUM6c5hO0uExQFi+WUPMCx2HGJckKicC/69WdVmFqnoz+8ePNE
# 157hb3uFFDIcA4SNdSHiSW+3S0yXJhp1QnXOtVYaTNal8JyIVpiNkty+MwmM9Nzk
# TZh5f2aUNkcCBtVPHcNkaRXw8o0FY0RYPB8Hx8KGF7Wo0EhdTdoySch2B5G+zoW5
# PXa/yG3uqS8dtBNHH/xR5Ypq33o1P1T5PLLK9I2D7zydc9Cc/a0wSX73mBLxoXYu
# fQbnaVHZ4MQ2v/Hv4Gz789GSvv1jpgWWOgbfNlw2IaGCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQxNTVaMD8GCSqG
# SIb3DQEJBDEyBDA4zxWdIfItvB4Xp5DtFFRz0d+RUuNsw4+hFzrnsBVGPBOBfmaR
# AYu8hxuFp5+8BpcwDQYJKoZIhvcNAQEBBQAEggIAaWOnk1ew8nPqLcN6AwnpzfKj
# he+q3lyHE1VstV1Rgjxq0xoE7mO8iT/pHJeRuxL8gh0nkgdE6YQijKcMhvJjoMMs
# iAKf3IC2eMnSSsFszYNxpejCqVzYyuOoV15+5rqZgFz0RiNPnQL4+qyTpwVB/6ap
# P7pTadeGhacsij+uhlW/q0p+/tSm5wQyAtem8qVOK30AEWcPSWCiNvRmn0aQrcv+
# 3DXXEkFSdyouKBRvAap7+7hCl9fJJJ45g++y4kIP+gUqMXFgU6sV1VpGUF0jDFiv
# UrQYyn8Aq4fMdTuoE7syx9Z9CGVsGZruIw5ni+bhzhNvgVoMGoiTxjG7An2QSt6o
# QmeMd3HWYg24gOIMxq4NW6PqTq7BA4/1Aw457liM1aJkFOtFQEuIWFaQlesCBiCF
# qVPZHB8z6bxcEn4kNPIVGZqVV8EIK1vBNHV9mPvgb8u5nj3HmJDKqyYjvRD+/wPm
# 3DUPYKdNVrHtP2odkNWB195N4jXH8Vutbvd8LoX9ekZV9fyTUR7hoWCyfSNf1acL
# wdZ+g4tvOJDBZkNBHGl6G0jZ2ehTpv3jWgQ3Md4UGV3n/lq95bFrZ1P0idaWDlDD
# qeyLZmgMsg6Bftbw06UrQ8SUaPbnAFRYCML1A2h21ofjWakrlqeHu7PotR7+bERJ
# bJm4kYT7puown1TV7Kc=
# SIG # End signature block
