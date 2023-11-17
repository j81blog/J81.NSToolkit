function Invoke-NSAddPolicydataset {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Configuration for TYPE set resource.
    .PARAMETER Name 
        Name of the dataset. Must not exceed 127 characters. 
    .PARAMETER Type 
        Type of value to bind to the dataset. 
        Possible values = ipv4, number, ipv6, ulong, double, mac 
    .PARAMETER Comment 
        Any comments to preserve information about this dataset or a data bound to this dataset. 
    .PARAMETER Patsetfile 
        File which contains list of patterns that needs to be bound to the dataset. A patsetfile cannot be associated with multiple datasets. 
    .PARAMETER Dynamic 
        This is used to populate internal dataset information so that the dataset can also be used dynamically in an expression. Here dynamically means the dataset name can also be derived using an expression. For example for a given dataset name "allow_test" it can be used dynamically as client.ip.src.equals_any("allow_" + http.req.url.path.get(1)). This cannot be used with default datasets. 
         
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created policydataset item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicydataset -name <string> -type <string>
        An example how to add policydataset config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicydataset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policydataset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateSet('ipv4', 'number', 'ipv6', 'ulong', 'double', 'mac')]
        [string]$Type,

        [string]$Comment,

        [string]$Patsetfile,

        [ValidateSet('YES', 'NO')]
        [string]$Dynamic = 'NO',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicydataset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('patsetfile') ) { $payload.Add('patsetfile', $patsetfile) }
            if ( $PSBoundParameters.ContainsKey('dynamic') ) { $payload.Add('dynamic', $dynamic) }
            if ( $PSCmdlet.ShouldProcess("policydataset", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policydataset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicydataset -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicydataset: Finished"
    }
}

function Invoke-NSDeletePolicydataset {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Configuration for TYPE set resource.
    .PARAMETER Name 
        Name of the dataset. Must not exceed 127 characters.
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicydataset -Name <string>
        An example how to delete policydataset config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicydataset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policydataset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeletePolicydataset: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policydataset -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicydataset: Finished"
    }
}

function Invoke-NSUpdatePolicydataset {
    <#
    .SYNOPSIS
        Update Policy configuration. config Object.
    .DESCRIPTION
        Configuration for TYPE set resource.
    .PARAMETER Name 
        Name of the dataset. Must not exceed 127 characters. 
    .PARAMETER Dynamic 
        This is used to populate internal dataset information so that the dataset can also be used dynamically in an expression. Here dynamically means the dataset name can also be derived using an expression. For example for a given dataset name "allow_test" it can be used dynamically as client.ip.src.equals_any("allow_" + http.req.url.path.get(1)). This cannot be used with default datasets. 
         
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created policydataset item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdatePolicydataset -name <string>
        An example how to update policydataset config Object(s).
    .NOTES
        File Name : Invoke-NSUpdatePolicydataset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policydataset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [ValidateSet('YES', 'NO')]
        [string]$Dynamic,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdatePolicydataset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('dynamic') ) { $payload.Add('dynamic', $dynamic) }
            if ( $PSCmdlet.ShouldProcess("policydataset", "Update Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type policydataset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicydataset -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdatePolicydataset: Finished"
    }
}

function Invoke-NSUnsetPolicydataset {
    <#
    .SYNOPSIS
        Unset Policy configuration. config Object.
    .DESCRIPTION
        Configuration for TYPE set resource.
    .PARAMETER Name 
        Name of the dataset. Must not exceed 127 characters. 
    .PARAMETER Dynamic 
        This is used to populate internal dataset information so that the dataset can also be used dynamically in an expression. Here dynamically means the dataset name can also be derived using an expression. For example for a given dataset name "allow_test" it can be used dynamically as client.ip.src.equals_any("allow_" + http.req.url.path.get(1)). This cannot be used with default datasets. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUnsetPolicydataset -name <string>
        An example how to unset policydataset config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetPolicydataset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policydataset
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$dynamic 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetPolicydataset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('dynamic') ) { $payload.Add('dynamic', $dynamic) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type policydataset -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetPolicydataset: Finished"
    }
}

function Invoke-NSGetPolicydataset {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Configuration for TYPE set resource.
    .PARAMETER Name 
        Name of the dataset. Must not exceed 127 characters. 
    .PARAMETER GetAll 
        Retrieve all policydataset object(s).
    .PARAMETER Count
        If specified, the count of the policydataset object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicydataset
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicydataset -GetAll 
        Get all policydataset data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicydataset -Count 
        Get the number of policydataset objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicydataset -name <string>
        Get policydataset object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicydataset -Filter @{ 'name'='<value>' }
        Get policydataset data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicydataset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policydataset/
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
        Write-Verbose "Invoke-NSGetPolicydataset: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policydataset objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policydataset objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policydataset objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policydataset configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policydataset configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicydataset: Ended"
    }
}

function Invoke-NSGetPolicydatasetBinding {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to policydataset.
    .PARAMETER Name 
        Name of the dataset. Must not exceed 127 characters. 
    .PARAMETER GetAll 
        Retrieve all policydataset_binding object(s).
    .PARAMETER Count
        If specified, the count of the policydataset_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicydatasetBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicydatasetBinding -GetAll 
        Get all policydataset_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicydatasetBinding -name <string>
        Get policydataset_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicydatasetBinding -Filter @{ 'name'='<value>' }
        Get policydataset_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicydatasetBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policydataset_binding/
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
        Write-Verbose "Invoke-NSGetPolicydatasetBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policydataset_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policydataset_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policydataset_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policydataset_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policydataset_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicydatasetBinding: Ended"
    }
}

function Invoke-NSAddPolicydatasetValueBinding {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the value that can be bound to policydataset.
    .PARAMETER Name 
        Name of the dataset to which to bind the value. 
    .PARAMETER Value 
        Value of the specified type that is associated with the dataset. For ipv4 and ipv6, value can be a subnet using the slash notation address/n, where address is the beginning of the subnet and n is the number of left-most bits set in the subnet mask, defining the end of the subnet. The start address will be masked by the subnet mask if necessary, for example for 192.128.128.0/10, the start address will be 192.128.0.0. 
    .PARAMETER Index 
        The index of the value (ipv4, ipv6, number) associated with the set. 
    .PARAMETER Endrange 
        The dataset entry is a range from &lt;value&gt; through &lt;end_range&gt;, inclusive. endRange cannot be used if value is an ipv4 or ipv6 subnet and endRange cannot itself be a subnet. 
    .PARAMETER Comment 
        Any comments to preserve information about this dataset or a data bound to this dataset. 
    .PARAMETER PassThru 
        Return details about the created policydataset_value_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicydatasetValueBinding -name <string> -value <string>
        An example how to add policydataset_value_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicydatasetValueBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policydataset_value_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Value,

        [double]$Index,

        [string]$Endrange,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicydatasetValueBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                value          = $value
            }
            if ( $PSBoundParameters.ContainsKey('index') ) { $payload.Add('index', $index) }
            if ( $PSBoundParameters.ContainsKey('endrange') ) { $payload.Add('endrange', $endrange) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policydataset_value_binding", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type policydataset_value_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicydatasetValueBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicydatasetValueBinding: Finished"
    }
}

function Invoke-NSDeletePolicydatasetValueBinding {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the value that can be bound to policydataset.
    .PARAMETER Name 
        Name of the dataset to which to bind the value. 
    .PARAMETER Value 
        Value of the specified type that is associated with the dataset. For ipv4 and ipv6, value can be a subnet using the slash notation address/n, where address is the beginning of the subnet and n is the number of left-most bits set in the subnet mask, defining the end of the subnet. The start address will be masked by the subnet mask if necessary, for example for 192.128.128.0/10, the start address will be 192.128.0.0. 
    .PARAMETER Endrange 
        The dataset entry is a range from &lt;value&gt; through &lt;end_range&gt;, inclusive. endRange cannot be used if value is an ipv4 or ipv6 subnet and endRange cannot itself be a subnet.
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicydatasetValueBinding -Name <string>
        An example how to delete policydataset_value_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicydatasetValueBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policydataset_value_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [string]$Value,

        [string]$Endrange 
    )
    begin {
        Write-Verbose "Invoke-NSDeletePolicydatasetValueBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Value') ) { $arguments.Add('value', $Value) }
            if ( $PSBoundParameters.ContainsKey('Endrange') ) { $arguments.Add('endrange', $Endrange) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policydataset_value_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicydatasetValueBinding: Finished"
    }
}

function Invoke-NSGetPolicydatasetValueBinding {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the value that can be bound to policydataset.
    .PARAMETER Name 
        Name of the dataset to which to bind the value. 
    .PARAMETER GetAll 
        Retrieve all policydataset_value_binding object(s).
    .PARAMETER Count
        If specified, the count of the policydataset_value_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicydatasetValueBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicydatasetValueBinding -GetAll 
        Get all policydataset_value_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicydatasetValueBinding -Count 
        Get the number of policydataset_value_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicydatasetValueBinding -name <string>
        Get policydataset_value_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicydatasetValueBinding -Filter @{ 'name'='<value>' }
        Get policydataset_value_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicydatasetValueBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policydataset_value_binding/
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
        Write-Verbose "Invoke-NSGetPolicydatasetValueBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policydataset_value_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policydataset_value_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policydataset_value_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policydataset_value_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policydataset_value_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicydatasetValueBinding: Ended"
    }
}

function Invoke-NSGetPolicyevaluation {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Configuration for expr evaluation resource.
    .PARAMETER Expression 
        Expression string. For example: http.req.body(100).contains("this"). 
    .PARAMETER Action 
        Rewrite action name. Supported rewrite action types are: 
        -delete 
        -delete_all 
        -delete_http_header 
        -insert_after 
        -insert_after_all 
        -insert_before 
        -insert_before_all 
        -insert_http_header 
        -replace 
        -replace_all 
        . 
    .PARAMETER Type 
        Indicates request or response input packet. 
        Possible values = HTTP_REQ, HTTP_RES, TEXT 
    .PARAMETER Input 
        Text representation of input packet. 
    .PARAMETER GetAll 
        Retrieve all policyevaluation object(s).
    .PARAMETER Count
        If specified, the count of the policyevaluation object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyevaluation
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicyevaluation -GetAll 
        Get all policyevaluation data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicyevaluation -Count 
        Get the number of policyevaluation objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyevaluation -name <string>
        Get policyevaluation object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyevaluation -Filter @{ 'name'='<value>' }
        Get policyevaluation data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicyevaluation
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyevaluation/
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
        [string]$Expression,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HTTP_REQ', 'HTTP_RES', 'TEXT')]
        [string]$Type,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Input,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetPolicyevaluation: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policyevaluation objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyevaluation objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyevaluation objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('expression') ) { $arguments.Add('expression', $expression) } 
                if ( $PSBoundParameters.ContainsKey('action') ) { $arguments.Add('action', $action) } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('input') ) { $arguments.Add('input', $input) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyevaluation configuration for property ''"

            } else {
                Write-Verbose "Retrieving policyevaluation configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicyevaluation: Ended"
    }
}

function Invoke-NSAddPolicyexpression {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Configuration for expression resource.
    .PARAMETER Name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Value 
        Expression string. For example: http.req.body(100).contains("this"). 
    .PARAMETER Comment 
        Any comments associated with the expression. Displayed upon viewing the policy expression. 
    .PARAMETER Clientsecuritymessage 
        Message to display if the expression fails. Allowed for classic end-point check expressions only. 
    .PARAMETER PassThru 
        Return details about the created policyexpression item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicyexpression -name <string> -value <string>
        An example how to add policyexpression config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicyexpression
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyexpression/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Value,

        [string]$Comment,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Clientsecuritymessage,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicyexpression: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                value          = $value
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('clientsecuritymessage') ) { $payload.Add('clientsecuritymessage', $clientsecuritymessage) }
            if ( $PSCmdlet.ShouldProcess("policyexpression", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policyexpression -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicyexpression -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicyexpression: Finished"
    }
}

function Invoke-NSDeletePolicyexpression {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Configuration for expression resource.
    .PARAMETER Name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicyexpression -Name <string>
        An example how to delete policyexpression config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicyexpression
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyexpression/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeletePolicyexpression: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policyexpression -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicyexpression: Finished"
    }
}

function Invoke-NSUpdatePolicyexpression {
    <#
    .SYNOPSIS
        Update Policy configuration. config Object.
    .DESCRIPTION
        Configuration for expression resource.
    .PARAMETER Name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Value 
        Expression string. For example: http.req.body(100).contains("this"). 
    .PARAMETER Comment 
        Any comments associated with the expression. Displayed upon viewing the policy expression. 
    .PARAMETER Clientsecuritymessage 
        Message to display if the expression fails. Allowed for classic end-point check expressions only. 
    .PARAMETER PassThru 
        Return details about the created policyexpression item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdatePolicyexpression -name <string>
        An example how to update policyexpression config Object(s).
    .NOTES
        File Name : Invoke-NSUpdatePolicyexpression
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyexpression/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Value,

        [string]$Comment,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Clientsecuritymessage,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdatePolicyexpression: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('value') ) { $payload.Add('value', $value) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('clientsecuritymessage') ) { $payload.Add('clientsecuritymessage', $clientsecuritymessage) }
            if ( $PSCmdlet.ShouldProcess("policyexpression", "Update Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type policyexpression -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicyexpression -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdatePolicyexpression: Finished"
    }
}

function Invoke-NSUnsetPolicyexpression {
    <#
    .SYNOPSIS
        Unset Policy configuration. config Object.
    .DESCRIPTION
        Configuration for expression resource.
    .PARAMETER Name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Comment 
        Any comments associated with the expression. Displayed upon viewing the policy expression. 
    .PARAMETER Clientsecuritymessage 
        Message to display if the expression fails. Allowed for classic end-point check expressions only.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetPolicyexpression -name <string>
        An example how to unset policyexpression config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetPolicyexpression
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyexpression
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$comment,

        [Boolean]$clientsecuritymessage 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetPolicyexpression: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('clientsecuritymessage') ) { $payload.Add('clientsecuritymessage', $clientsecuritymessage) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type policyexpression -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetPolicyexpression: Finished"
    }
}

function Invoke-NSGetPolicyexpression {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Configuration for expression resource.
    .PARAMETER Name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER GetAll 
        Retrieve all policyexpression object(s).
    .PARAMETER Count
        If specified, the count of the policyexpression object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyexpression
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicyexpression -GetAll 
        Get all policyexpression data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicyexpression -Count 
        Get the number of policyexpression objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyexpression -name <string>
        Get policyexpression object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyexpression -Filter @{ 'name'='<value>' }
        Get policyexpression data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicyexpression
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyexpression/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-NSGetPolicyexpression: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policyexpression objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyexpression objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyexpression objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyexpression configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policyexpression configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicyexpression: Ended"
    }
}

function Invoke-NSAddPolicyhttpcallout {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Configuration for HTTP callout resource.
    .PARAMETER Name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Ipaddress 
        IP Address of the server (callout agent) to which the callout is sent. Can be an IPv4 or IPv6 address. 
        Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the &lt;IP Address, Port&gt; and the Virtual Server in the same HTTP callout. 
    .PARAMETER Port 
        Server port to which the HTTP callout agent is mapped. Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the &lt;IP Address, Port&gt; and the Virtual Server in the same HTTP callout. 
    .PARAMETER Vserver 
        Name of the load balancing, content switching, or cache redirection virtual server (the callout agent) to which the HTTP callout is sent. The service type of the virtual server must be HTTP. Mutually exclusive with the IP address and port parameters. Therefore, you cannot set the &lt;IP Address, Port&gt; and the Virtual Server in the same HTTP callout. 
    .PARAMETER Returntype 
        Type of data that the target callout agent returns in response to the callout. 
        Available settings function as follows: 
        * TEXT - Treat the returned value as a text string. 
        * NUM - Treat the returned value as a number. 
        * BOOL - Treat the returned value as a Boolean value. 
        Note: You cannot change the return type after it is set. 
        Possible values = BOOL, NUM, TEXT 
    .PARAMETER Httpmethod 
        Method used in the HTTP request that this callout sends. Mutually exclusive with the full HTTP request expression. 
        Possible values = GET, POST 
    .PARAMETER Hostexpr 
        String expression to configure the Host header. Can contain a literal value (for example, 10.101.10.11) or a derived value (for example, http.req.header("Host")). The literal value can be an IP address or a fully qualified domain name. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Urlstemexpr 
        String expression for generating the URL stem. Can contain a literal string (for example, "/mysite/index.html") or an expression that derives the value (for example, http.req.url). Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Headers 
        One or more headers to insert into the HTTP request. Each header is specified as "name(expr)", where expr is an expression that is evaluated at runtime to provide the value for the named header. You can configure a maximum of eight headers for an HTTP callout. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Parameters 
        One or more query parameters to insert into the HTTP request URL (for a GET request) or into the request body (for a POST request). Each parameter is specified as "name(expr)", where expr is an expression that is evaluated at run time to provide the value for the named parameter (name=value). The parameter values are URL encoded. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Bodyexpr 
        An advanced string expression for generating the body of the request. The expression can contain a literal string or an expression that derives the value (for example, client.ip.src). Mutually exclusive with -fullReqExpr. 
    .PARAMETER Fullreqexpr 
        Exact HTTP request, in the form of an expression, which the Citrix ADC sends to the callout agent. If you set this parameter, you must not include HTTP method, host expression, URL stem expression, headers, or parameters. 
        The request expression is constrained by the feature for which the callout is used. For example, an HTTP.RES expression cannot be used in a request-time policy bank or in a TCP content switching policy bank. 
        The Citrix ADC does not check the validity of this request. You must manually validate the request. 
    .PARAMETER Scheme 
        Type of scheme for the callout server. 
        Possible values = http, https 
    .PARAMETER Resultexpr 
        Expression that extracts the callout results from the response sent by the HTTP callout agent. Must be a response based expression, that is, it must begin with HTTP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression. If the return type is NUM, the result expression (resultExpr) must return a numeric value, as in the following example: http.res.body(10000).length. 
    .PARAMETER Cacheforsecs 
        Duration, in seconds, for which the callout response is cached. The cached responses are stored in an integrated caching content group named "calloutContentGroup". If no duration is configured, the callout responses will not be cached unless normal caching configuration is used to cache them. This parameter takes precedence over any normal caching configuration that would otherwise apply to these responses. 
        Note that the calloutContentGroup definition may not be modified or removed nor may it be used with other cache policies. 
         
        Maximum value = 31536000 
    .PARAMETER Comment 
        Any comments to preserve information about this HTTP callout. 
    .PARAMETER PassThru 
        Return details about the created policyhttpcallout item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicyhttpcallout -name <string>
        An example how to add policyhttpcallout config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicyhttpcallout
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyhttpcallout/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Ipaddress,

        [int]$Port,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vserver,

        [ValidateSet('BOOL', 'NUM', 'TEXT')]
        [string]$Returntype,

        [ValidateSet('GET', 'POST')]
        [string]$Httpmethod,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostexpr,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Urlstemexpr,

        [string[]]$Headers,

        [string[]]$Parameters,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bodyexpr,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Fullreqexpr,

        [ValidateSet('http', 'https')]
        [string]$Scheme,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resultexpr,

        [double]$Cacheforsecs,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicyhttpcallout: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('returntype') ) { $payload.Add('returntype', $returntype) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('hostexpr') ) { $payload.Add('hostexpr', $hostexpr) }
            if ( $PSBoundParameters.ContainsKey('urlstemexpr') ) { $payload.Add('urlstemexpr', $urlstemexpr) }
            if ( $PSBoundParameters.ContainsKey('headers') ) { $payload.Add('headers', $headers) }
            if ( $PSBoundParameters.ContainsKey('parameters') ) { $payload.Add('parameters', $parameters) }
            if ( $PSBoundParameters.ContainsKey('bodyexpr') ) { $payload.Add('bodyexpr', $bodyexpr) }
            if ( $PSBoundParameters.ContainsKey('fullreqexpr') ) { $payload.Add('fullreqexpr', $fullreqexpr) }
            if ( $PSBoundParameters.ContainsKey('scheme') ) { $payload.Add('scheme', $scheme) }
            if ( $PSBoundParameters.ContainsKey('resultexpr') ) { $payload.Add('resultexpr', $resultexpr) }
            if ( $PSBoundParameters.ContainsKey('cacheforsecs') ) { $payload.Add('cacheforsecs', $cacheforsecs) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policyhttpcallout", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policyhttpcallout -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicyhttpcallout -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicyhttpcallout: Finished"
    }
}

function Invoke-NSDeletePolicyhttpcallout {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Configuration for HTTP callout resource.
    .PARAMETER Name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicyhttpcallout -Name <string>
        An example how to delete policyhttpcallout config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicyhttpcallout
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyhttpcallout/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeletePolicyhttpcallout: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policyhttpcallout -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicyhttpcallout: Finished"
    }
}

function Invoke-NSUpdatePolicyhttpcallout {
    <#
    .SYNOPSIS
        Update Policy configuration. config Object.
    .DESCRIPTION
        Configuration for HTTP callout resource.
    .PARAMETER Name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Ipaddress 
        IP Address of the server (callout agent) to which the callout is sent. Can be an IPv4 or IPv6 address. 
        Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the &lt;IP Address, Port&gt; and the Virtual Server in the same HTTP callout. 
    .PARAMETER Port 
        Server port to which the HTTP callout agent is mapped. Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the &lt;IP Address, Port&gt; and the Virtual Server in the same HTTP callout. 
    .PARAMETER Vserver 
        Name of the load balancing, content switching, or cache redirection virtual server (the callout agent) to which the HTTP callout is sent. The service type of the virtual server must be HTTP. Mutually exclusive with the IP address and port parameters. Therefore, you cannot set the &lt;IP Address, Port&gt; and the Virtual Server in the same HTTP callout. 
    .PARAMETER Returntype 
        Type of data that the target callout agent returns in response to the callout. 
        Available settings function as follows: 
        * TEXT - Treat the returned value as a text string. 
        * NUM - Treat the returned value as a number. 
        * BOOL - Treat the returned value as a Boolean value. 
        Note: You cannot change the return type after it is set. 
        Possible values = BOOL, NUM, TEXT 
    .PARAMETER Httpmethod 
        Method used in the HTTP request that this callout sends. Mutually exclusive with the full HTTP request expression. 
        Possible values = GET, POST 
    .PARAMETER Hostexpr 
        String expression to configure the Host header. Can contain a literal value (for example, 10.101.10.11) or a derived value (for example, http.req.header("Host")). The literal value can be an IP address or a fully qualified domain name. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Urlstemexpr 
        String expression for generating the URL stem. Can contain a literal string (for example, "/mysite/index.html") or an expression that derives the value (for example, http.req.url). Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Headers 
        One or more headers to insert into the HTTP request. Each header is specified as "name(expr)", where expr is an expression that is evaluated at runtime to provide the value for the named header. You can configure a maximum of eight headers for an HTTP callout. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Parameters 
        One or more query parameters to insert into the HTTP request URL (for a GET request) or into the request body (for a POST request). Each parameter is specified as "name(expr)", where expr is an expression that is evaluated at run time to provide the value for the named parameter (name=value). The parameter values are URL encoded. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Bodyexpr 
        An advanced string expression for generating the body of the request. The expression can contain a literal string or an expression that derives the value (for example, client.ip.src). Mutually exclusive with -fullReqExpr. 
    .PARAMETER Fullreqexpr 
        Exact HTTP request, in the form of an expression, which the Citrix ADC sends to the callout agent. If you set this parameter, you must not include HTTP method, host expression, URL stem expression, headers, or parameters. 
        The request expression is constrained by the feature for which the callout is used. For example, an HTTP.RES expression cannot be used in a request-time policy bank or in a TCP content switching policy bank. 
        The Citrix ADC does not check the validity of this request. You must manually validate the request. 
    .PARAMETER Scheme 
        Type of scheme for the callout server. 
        Possible values = http, https 
    .PARAMETER Resultexpr 
        Expression that extracts the callout results from the response sent by the HTTP callout agent. Must be a response based expression, that is, it must begin with HTTP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression. If the return type is NUM, the result expression (resultExpr) must return a numeric value, as in the following example: http.res.body(10000).length. 
    .PARAMETER Cacheforsecs 
        Duration, in seconds, for which the callout response is cached. The cached responses are stored in an integrated caching content group named "calloutContentGroup". If no duration is configured, the callout responses will not be cached unless normal caching configuration is used to cache them. This parameter takes precedence over any normal caching configuration that would otherwise apply to these responses. 
        Note that the calloutContentGroup definition may not be modified or removed nor may it be used with other cache policies. 
         
        Maximum value = 31536000 
    .PARAMETER Comment 
        Any comments to preserve information about this HTTP callout. 
    .PARAMETER PassThru 
        Return details about the created policyhttpcallout item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdatePolicyhttpcallout -name <string>
        An example how to update policyhttpcallout config Object(s).
    .NOTES
        File Name : Invoke-NSUpdatePolicyhttpcallout
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyhttpcallout/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Ipaddress,

        [int]$Port,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vserver,

        [ValidateSet('BOOL', 'NUM', 'TEXT')]
        [string]$Returntype,

        [ValidateSet('GET', 'POST')]
        [string]$Httpmethod,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostexpr,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Urlstemexpr,

        [string[]]$Headers,

        [string[]]$Parameters,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bodyexpr,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Fullreqexpr,

        [ValidateSet('http', 'https')]
        [string]$Scheme,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resultexpr,

        [double]$Cacheforsecs,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdatePolicyhttpcallout: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('returntype') ) { $payload.Add('returntype', $returntype) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('hostexpr') ) { $payload.Add('hostexpr', $hostexpr) }
            if ( $PSBoundParameters.ContainsKey('urlstemexpr') ) { $payload.Add('urlstemexpr', $urlstemexpr) }
            if ( $PSBoundParameters.ContainsKey('headers') ) { $payload.Add('headers', $headers) }
            if ( $PSBoundParameters.ContainsKey('parameters') ) { $payload.Add('parameters', $parameters) }
            if ( $PSBoundParameters.ContainsKey('bodyexpr') ) { $payload.Add('bodyexpr', $bodyexpr) }
            if ( $PSBoundParameters.ContainsKey('fullreqexpr') ) { $payload.Add('fullreqexpr', $fullreqexpr) }
            if ( $PSBoundParameters.ContainsKey('scheme') ) { $payload.Add('scheme', $scheme) }
            if ( $PSBoundParameters.ContainsKey('resultexpr') ) { $payload.Add('resultexpr', $resultexpr) }
            if ( $PSBoundParameters.ContainsKey('cacheforsecs') ) { $payload.Add('cacheforsecs', $cacheforsecs) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policyhttpcallout", "Update Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type policyhttpcallout -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicyhttpcallout -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdatePolicyhttpcallout: Finished"
    }
}

function Invoke-NSUnsetPolicyhttpcallout {
    <#
    .SYNOPSIS
        Unset Policy configuration. config Object.
    .DESCRIPTION
        Configuration for HTTP callout resource.
    .PARAMETER Name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Ipaddress 
        IP Address of the server (callout agent) to which the callout is sent. Can be an IPv4 or IPv6 address. 
        Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the &lt;IP Address, Port&gt; and the Virtual Server in the same HTTP callout. 
    .PARAMETER Port 
        Server port to which the HTTP callout agent is mapped. Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the &lt;IP Address, Port&gt; and the Virtual Server in the same HTTP callout. 
    .PARAMETER Vserver 
        Name of the load balancing, content switching, or cache redirection virtual server (the callout agent) to which the HTTP callout is sent. The service type of the virtual server must be HTTP. Mutually exclusive with the IP address and port parameters. Therefore, you cannot set the &lt;IP Address, Port&gt; and the Virtual Server in the same HTTP callout. 
    .PARAMETER Httpmethod 
        Method used in the HTTP request that this callout sends. Mutually exclusive with the full HTTP request expression. 
        Possible values = GET, POST 
    .PARAMETER Hostexpr 
        String expression to configure the Host header. Can contain a literal value (for example, 10.101.10.11) or a derived value (for example, http.req.header("Host")). The literal value can be an IP address or a fully qualified domain name. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Urlstemexpr 
        String expression for generating the URL stem. Can contain a literal string (for example, "/mysite/index.html") or an expression that derives the value (for example, http.req.url). Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Headers 
        One or more headers to insert into the HTTP request. Each header is specified as "name(expr)", where expr is an expression that is evaluated at runtime to provide the value for the named header. You can configure a maximum of eight headers for an HTTP callout. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Parameters 
        One or more query parameters to insert into the HTTP request URL (for a GET request) or into the request body (for a POST request). Each parameter is specified as "name(expr)", where expr is an expression that is evaluated at run time to provide the value for the named parameter (name=value). The parameter values are URL encoded. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Bodyexpr 
        An advanced string expression for generating the body of the request. The expression can contain a literal string or an expression that derives the value (for example, client.ip.src). Mutually exclusive with -fullReqExpr. 
    .PARAMETER Fullreqexpr 
        Exact HTTP request, in the form of an expression, which the Citrix ADC sends to the callout agent. If you set this parameter, you must not include HTTP method, host expression, URL stem expression, headers, or parameters. 
        The request expression is constrained by the feature for which the callout is used. For example, an HTTP.RES expression cannot be used in a request-time policy bank or in a TCP content switching policy bank. 
        The Citrix ADC does not check the validity of this request. You must manually validate the request. 
    .PARAMETER Resultexpr 
        Expression that extracts the callout results from the response sent by the HTTP callout agent. Must be a response based expression, that is, it must begin with HTTP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression. If the return type is NUM, the result expression (resultExpr) must return a numeric value, as in the following example: http.res.body(10000).length. 
    .PARAMETER Cacheforsecs 
        Duration, in seconds, for which the callout response is cached. The cached responses are stored in an integrated caching content group named "calloutContentGroup". If no duration is configured, the callout responses will not be cached unless normal caching configuration is used to cache them. This parameter takes precedence over any normal caching configuration that would otherwise apply to these responses. 
        Note that the calloutContentGroup definition may not be modified or removed nor may it be used with other cache policies. 
         
        Maximum value = 31536000 
    .PARAMETER Comment 
        Any comments to preserve information about this HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetPolicyhttpcallout -name <string>
        An example how to unset policyhttpcallout config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetPolicyhttpcallout
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyhttpcallout
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$ipaddress,

        [Boolean]$port,

        [Boolean]$vserver,

        [Boolean]$httpmethod,

        [Boolean]$hostexpr,

        [Boolean]$urlstemexpr,

        [Boolean]$headers,

        [Boolean]$parameters,

        [Boolean]$bodyexpr,

        [Boolean]$fullreqexpr,

        [Boolean]$resultexpr,

        [Boolean]$cacheforsecs,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetPolicyhttpcallout: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('hostexpr') ) { $payload.Add('hostexpr', $hostexpr) }
            if ( $PSBoundParameters.ContainsKey('urlstemexpr') ) { $payload.Add('urlstemexpr', $urlstemexpr) }
            if ( $PSBoundParameters.ContainsKey('headers') ) { $payload.Add('headers', $headers) }
            if ( $PSBoundParameters.ContainsKey('parameters') ) { $payload.Add('parameters', $parameters) }
            if ( $PSBoundParameters.ContainsKey('bodyexpr') ) { $payload.Add('bodyexpr', $bodyexpr) }
            if ( $PSBoundParameters.ContainsKey('fullreqexpr') ) { $payload.Add('fullreqexpr', $fullreqexpr) }
            if ( $PSBoundParameters.ContainsKey('resultexpr') ) { $payload.Add('resultexpr', $resultexpr) }
            if ( $PSBoundParameters.ContainsKey('cacheforsecs') ) { $payload.Add('cacheforsecs', $cacheforsecs) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type policyhttpcallout -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetPolicyhttpcallout: Finished"
    }
}

function Invoke-NSGetPolicyhttpcallout {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Configuration for HTTP callout resource.
    .PARAMETER Name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER GetAll 
        Retrieve all policyhttpcallout object(s).
    .PARAMETER Count
        If specified, the count of the policyhttpcallout object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyhttpcallout
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicyhttpcallout -GetAll 
        Get all policyhttpcallout data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicyhttpcallout -Count 
        Get the number of policyhttpcallout objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyhttpcallout -name <string>
        Get policyhttpcallout object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyhttpcallout -Filter @{ 'name'='<value>' }
        Get policyhttpcallout data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicyhttpcallout
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyhttpcallout/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-NSGetPolicyhttpcallout: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policyhttpcallout objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyhttpcallout objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyhttpcallout objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyhttpcallout configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policyhttpcallout configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicyhttpcallout: Ended"
    }
}

function Invoke-NSAddPolicymap {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Configuration for map policy resource.
    .PARAMETER Mappolicyname 
        Name for the map policy. Must begin with a letter, number, or the underscore (_) character and must consist only of letters, numbers, and the hash (#), period (.), colon (:), space ( ), at (@), equals (=), hyphen (-), and underscore (_) characters. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my map" or 'my map'). 
    .PARAMETER Sd 
        Publicly known source domain name. This is the domain name with which a client request arrives at a reverse proxy virtual server for cache redirection. If you specify a source domain, you must specify a target domain. 
    .PARAMETER Su 
        Source URL. Specify all or part of the source URL, in the following format: /[[prefix] [*]] [.suffix]. 
    .PARAMETER Td 
        Target domain name sent to the server. The source domain name is replaced with this domain name. 
    .PARAMETER Tu 
        Target URL. Specify the target URL in the following format: /[[prefix] [*]][.suffix]. 
    .PARAMETER PassThru 
        Return details about the created policymap item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicymap -mappolicyname <string> -sd <string>
        An example how to add policymap config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicymap
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policymap/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Mappolicyname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sd,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Su,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Td,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Tu,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicymap: Starting"
    }
    process {
        try {
            $payload = @{ mappolicyname = $mappolicyname
                sd                      = $sd
            }
            if ( $PSBoundParameters.ContainsKey('su') ) { $payload.Add('su', $su) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('tu') ) { $payload.Add('tu', $tu) }
            if ( $PSCmdlet.ShouldProcess("policymap", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policymap -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicymap -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicymap: Finished"
    }
}

function Invoke-NSDeletePolicymap {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Configuration for map policy resource.
    .PARAMETER Mappolicyname 
        Name for the map policy. Must begin with a letter, number, or the underscore (_) character and must consist only of letters, numbers, and the hash (#), period (.), colon (:), space ( ), at (@), equals (=), hyphen (-), and underscore (_) characters. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my map" or 'my map').
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicymap -Mappolicyname <string>
        An example how to delete policymap config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicymap
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policymap/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Mappolicyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeletePolicymap: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$mappolicyname", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policymap -NitroPath nitro/v1/config -Resource $mappolicyname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicymap: Finished"
    }
}

function Invoke-NSGetPolicymap {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Configuration for map policy resource.
    .PARAMETER Mappolicyname 
        Name for the map policy. Must begin with a letter, number, or the underscore (_) character and must consist only of letters, numbers, and the hash (#), period (.), colon (:), space ( ), at (@), equals (=), hyphen (-), and underscore (_) characters. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my map" or 'my map'). 
    .PARAMETER GetAll 
        Retrieve all policymap object(s).
    .PARAMETER Count
        If specified, the count of the policymap object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicymap
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicymap -GetAll 
        Get all policymap data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicymap -Count 
        Get the number of policymap objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicymap -name <string>
        Get policymap object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicymap -Filter @{ 'name'='<value>' }
        Get policymap data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicymap
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policymap/
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
        [string]$Mappolicyname,

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
        Write-Verbose "Invoke-NSGetPolicymap: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policymap objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policymap -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policymap objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policymap -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policymap objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policymap -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policymap configuration for property 'mappolicyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policymap -NitroPath nitro/v1/config -Resource $mappolicyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policymap configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policymap -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicymap: Ended"
    }
}

function Invoke-NSUpdatePolicyparam {
    <#
    .SYNOPSIS
        Update Policy configuration. config Object.
    .DESCRIPTION
        Configuration for policy parameter resource.
    .PARAMETER Timeout 
        Maximum time in milliseconds to allow for processing expressions and policies without interruption. If the timeout is reached then the evaluation causes an UNDEF to be raised and no further processing is performed. 
         
         
        Maximum value = 5000
    .EXAMPLE
        PS C:\>Invoke-NSUpdatePolicyparam 
        An example how to update policyparam config Object(s).
    .NOTES
        File Name : Invoke-NSUpdatePolicyparam
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyparam/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [double]$Timeout 
    )
    begin {
        Write-Verbose "Invoke-NSUpdatePolicyparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSCmdlet.ShouldProcess("policyparam", "Update Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type policyparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdatePolicyparam: Finished"
    }
}

function Invoke-NSUnsetPolicyparam {
    <#
    .SYNOPSIS
        Unset Policy configuration. config Object.
    .DESCRIPTION
        Configuration for policy parameter resource.
    .PARAMETER Timeout 
        Maximum time in milliseconds to allow for processing expressions and policies without interruption. If the timeout is reached then the evaluation causes an UNDEF to be raised and no further processing is performed. 
         
         
        Maximum value = 5000
    .EXAMPLE
        PS C:\>Invoke-NSUnsetPolicyparam 
        An example how to unset policyparam config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetPolicyparam
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyparam
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$timeout 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetPolicyparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSCmdlet.ShouldProcess("policyparam", "Unset Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type policyparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetPolicyparam: Finished"
    }
}

function Invoke-NSGetPolicyparam {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Configuration for policy parameter resource.
    .PARAMETER GetAll 
        Retrieve all policyparam object(s).
    .PARAMETER Count
        If specified, the count of the policyparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicyparam -GetAll 
        Get all policyparam data.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyparam -name <string>
        Get policyparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyparam -Filter @{ 'name'='<value>' }
        Get policyparam data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicyparam
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyparam/
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
        Write-Verbose "Invoke-NSGetPolicyparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policyparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving policyparam configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicyparam: Ended"
    }
}

function Invoke-NSAddPolicypatset {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Configuration for PAT set resource.
    .PARAMETER Name 
        Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Comment 
        Any comments to preserve information about this patset or a pattern bound to this patset. 
    .PARAMETER Patsetfile 
        File which contains list of patterns that needs to be bound to the patset. A patsetfile cannot be associated with multiple patsets. 
    .PARAMETER Dynamic 
        This is used to populate internal patset information so that the patset can also be used dynamically in an expression. Here dynamically means the patset name can also be derived using an expression. For example for a given patset name "allow_test" it can be used dynamically as http.req.url.contains_any("allow_" + http.req.url.path.get(1)). This cannot be used with default patsets. 
         
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created policypatset item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicypatset -name <string>
        An example how to add policypatset config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicypatset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Comment,

        [string]$Patsetfile,

        [ValidateSet('YES', 'NO')]
        [string]$Dynamic = 'NO',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicypatset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('patsetfile') ) { $payload.Add('patsetfile', $patsetfile) }
            if ( $PSBoundParameters.ContainsKey('dynamic') ) { $payload.Add('dynamic', $dynamic) }
            if ( $PSCmdlet.ShouldProcess("policypatset", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policypatset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicypatset -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicypatset: Finished"
    }
}

function Invoke-NSDeletePolicypatset {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Configuration for PAT set resource.
    .PARAMETER Name 
        Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicypatset -Name <string>
        An example how to delete policypatset config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicypatset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeletePolicypatset: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policypatset -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicypatset: Finished"
    }
}

function Invoke-NSUpdatePolicypatset {
    <#
    .SYNOPSIS
        Update Policy configuration. config Object.
    .DESCRIPTION
        Configuration for PAT set resource.
    .PARAMETER Name 
        Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Dynamic 
        This is used to populate internal patset information so that the patset can also be used dynamically in an expression. Here dynamically means the patset name can also be derived using an expression. For example for a given patset name "allow_test" it can be used dynamically as http.req.url.contains_any("allow_" + http.req.url.path.get(1)). This cannot be used with default patsets. 
         
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created policypatset item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdatePolicypatset -name <string>
        An example how to update policypatset config Object(s).
    .NOTES
        File Name : Invoke-NSUpdatePolicypatset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [ValidateSet('YES', 'NO')]
        [string]$Dynamic,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdatePolicypatset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('dynamic') ) { $payload.Add('dynamic', $dynamic) }
            if ( $PSCmdlet.ShouldProcess("policypatset", "Update Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type policypatset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicypatset -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdatePolicypatset: Finished"
    }
}

function Invoke-NSUnsetPolicypatset {
    <#
    .SYNOPSIS
        Unset Policy configuration. config Object.
    .DESCRIPTION
        Configuration for PAT set resource.
    .PARAMETER Name 
        Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Dynamic 
        This is used to populate internal patset information so that the patset can also be used dynamically in an expression. Here dynamically means the patset name can also be derived using an expression. For example for a given patset name "allow_test" it can be used dynamically as http.req.url.contains_any("allow_" + http.req.url.path.get(1)). This cannot be used with default patsets. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUnsetPolicypatset -name <string>
        An example how to unset policypatset config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetPolicypatset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatset
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$dynamic 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetPolicypatset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('dynamic') ) { $payload.Add('dynamic', $dynamic) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type policypatset -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetPolicypatset: Finished"
    }
}

function Invoke-NSGetPolicypatset {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Configuration for PAT set resource.
    .PARAMETER Name 
        Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER GetAll 
        Retrieve all policypatset object(s).
    .PARAMETER Count
        If specified, the count of the policypatset object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatset
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicypatset -GetAll 
        Get all policypatset data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicypatset -Count 
        Get the number of policypatset objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatset -name <string>
        Get policypatset object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatset -Filter @{ 'name'='<value>' }
        Get policypatset data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicypatset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatset/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-NSGetPolicypatset: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policypatset objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policypatset objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policypatset objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policypatset configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policypatset configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicypatset: Ended"
    }
}

function Invoke-NSGetPolicypatsetBinding {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to policypatset.
    .PARAMETER Name 
        Name of the pattern set for which to display the detailed information. If a name is not provided, a list of all pattern sets configured on the appliance is shown. 
    .PARAMETER GetAll 
        Retrieve all policypatset_binding object(s).
    .PARAMETER Count
        If specified, the count of the policypatset_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatsetBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicypatsetBinding -GetAll 
        Get all policypatset_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatsetBinding -name <string>
        Get policypatset_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatsetBinding -Filter @{ 'name'='<value>' }
        Get policypatset_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicypatsetBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatset_binding/
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
        Write-Verbose "Invoke-NSGetPolicypatsetBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policypatset_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policypatset_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policypatset_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policypatset_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policypatset_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicypatsetBinding: Ended"
    }
}

function Invoke-NSAddPolicypatsetPatternBinding {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policypatset.
    .PARAMETER Name 
        Name of the pattern set to which to bind the string. 
    .PARAMETER String 
        String of characters that constitutes a pattern. For more information about the characters that can be used, refer to the character set parameter. Note: Minimum length for pattern sets used in rewrite actions of type REPLACE_ALL, DELETE_ALL, INSERT_AFTER_ALL, and INSERT_BEFORE_ALL, is three characters. 
    .PARAMETER Index 
        The index of the string associated with the patset. 
    .PARAMETER Charset 
        Character set associated with the characters in the string. Note: UTF-8 characters can be entered directly (if the UI supports it) or can be encoded as a sequence of hexadecimal bytes '\xNN'. For example, the UTF-8 character '�' can be encoded as '\xC3\xBC'. 
        Possible values = ASCII, UTF_8 
    .PARAMETER Comment 
        Any comments to preserve information about this patset or a pattern bound to this patset. 
    .PARAMETER PassThru 
        Return details about the created policypatset_pattern_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicypatsetPatternBinding -name <string> -String <string>
        An example how to add policypatset_pattern_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicypatsetPatternBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatset_pattern_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$String,

        [double]$Index,

        [ValidateSet('ASCII', 'UTF_8')]
        [string]$Charset,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicypatsetPatternBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                String         = $String
            }
            if ( $PSBoundParameters.ContainsKey('index') ) { $payload.Add('index', $index) }
            if ( $PSBoundParameters.ContainsKey('charset') ) { $payload.Add('charset', $charset) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policypatset_pattern_binding", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type policypatset_pattern_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicypatsetPatternBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicypatsetPatternBinding: Finished"
    }
}

function Invoke-NSDeletePolicypatsetPatternBinding {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policypatset.
    .PARAMETER Name 
        Name of the pattern set to which to bind the string. 
    .PARAMETER String 
        String of characters that constitutes a pattern. For more information about the characters that can be used, refer to the character set parameter. Note: Minimum length for pattern sets used in rewrite actions of type REPLACE_ALL, DELETE_ALL, INSERT_AFTER_ALL, and INSERT_BEFORE_ALL, is three characters.
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicypatsetPatternBinding -Name <string>
        An example how to delete policypatset_pattern_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicypatsetPatternBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatset_pattern_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [string]$String 
    )
    begin {
        Write-Verbose "Invoke-NSDeletePolicypatsetPatternBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('String') ) { $arguments.Add('String', $String) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicypatsetPatternBinding: Finished"
    }
}

function Invoke-NSGetPolicypatsetPatternBinding {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policypatset.
    .PARAMETER Name 
        Name of the pattern set to which to bind the string. 
    .PARAMETER GetAll 
        Retrieve all policypatset_pattern_binding object(s).
    .PARAMETER Count
        If specified, the count of the policypatset_pattern_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatsetPatternBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicypatsetPatternBinding -GetAll 
        Get all policypatset_pattern_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicypatsetPatternBinding -Count 
        Get the number of policypatset_pattern_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatsetPatternBinding -name <string>
        Get policypatset_pattern_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatsetPatternBinding -Filter @{ 'name'='<value>' }
        Get policypatset_pattern_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicypatsetPatternBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatset_pattern_binding/
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
        Write-Verbose "Invoke-NSGetPolicypatsetPatternBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policypatset_pattern_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policypatset_pattern_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policypatset_pattern_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policypatset_pattern_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policypatset_pattern_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicypatsetPatternBinding: Ended"
    }
}

function Invoke-NSImportPolicypatsetfile {
    <#
    .SYNOPSIS
        Import Policy configuration. config Object.
    .DESCRIPTION
        Configuration for patset file resource.
    .PARAMETER Src 
        URL in protocol, host, path, and file name format from where the patset file will be imported. If file is already present, then it can be imported using local keyword (import patsetfile local:filename patsetfile1) 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Name 
        Name to assign to the imported patset file. Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. 
    .PARAMETER Overwrite 
        Overwrites the existing file. 
    .PARAMETER Delimiter 
        patset file patterns delimiter. 
    .PARAMETER Charset 
        Character set associated with the characters in the string. 
        Possible values = ASCII, UTF_8
    .EXAMPLE
        PS C:\>Invoke-NSImportPolicypatsetfile -src <string> -name <string>
        An example how to import policypatsetfile config Object(s).
    .NOTES
        File Name : Invoke-NSImportPolicypatsetfile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatsetfile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Overwrite,

        [string]$Delimiter,

        [ValidateSet('ASCII', 'UTF_8')]
        [string]$Charset 

    )
    begin {
        Write-Verbose "Invoke-NSImportPolicypatsetfile: Starting"
    }
    process {
        try {
            $payload = @{ src = $src
                name          = $name
            }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSBoundParameters.ContainsKey('delimiter') ) { $payload.Add('delimiter', $delimiter) }
            if ( $PSBoundParameters.ContainsKey('charset') ) { $payload.Add('charset', $charset) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policypatsetfile -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSImportPolicypatsetfile: Finished"
    }
}

function Invoke-NSAddPolicypatsetfile {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Configuration for patset file resource.
    .PARAMETER Name 
        Name to assign to the imported patset file. Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. 
    .PARAMETER Comment 
        Any comments to preserve information about this patsetfile. 
    .PARAMETER PassThru 
        Return details about the created policypatsetfile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicypatsetfile -name <string>
        An example how to add policypatsetfile config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicypatsetfile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatsetfile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
        [string]$Name,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicypatsetfile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policypatsetfile", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policypatsetfile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicypatsetfile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicypatsetfile: Finished"
    }
}

function Invoke-NSDeletePolicypatsetfile {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Configuration for patset file resource.
    .PARAMETER Name 
        Name to assign to the imported patset file. Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters.
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicypatsetfile -Name <string>
        An example how to delete policypatsetfile config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicypatsetfile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatsetfile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeletePolicypatsetfile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policypatsetfile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicypatsetfile: Finished"
    }
}

function Invoke-NSChangePolicypatsetfile {
    <#
    .SYNOPSIS
        Change Policy configuration. config Object.
    .DESCRIPTION
        Configuration for patset file resource.
    .PARAMETER Name 
        Name to assign to the imported patset file. Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created policypatsetfile item.
    .EXAMPLE
        PS C:\>Invoke-NSChangePolicypatsetfile -name <string>
        An example how to change policypatsetfile config Object(s).
    .NOTES
        File Name : Invoke-NSChangePolicypatsetfile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatsetfile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
        [string]$Name,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSChangePolicypatsetfile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess("policypatsetfile", "Change Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policypatsetfile -Action update -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicypatsetfile -Filter $payload)
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
        Write-Verbose "Invoke-NSChangePolicypatsetfile: Finished"
    }
}

function Invoke-NSGetPolicypatsetfile {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Configuration for patset file resource.
    .PARAMETER Name 
        Name to assign to the imported patset file. Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. 
    .PARAMETER GetAll 
        Retrieve all policypatsetfile object(s).
    .PARAMETER Count
        If specified, the count of the policypatsetfile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatsetfile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicypatsetfile -GetAll 
        Get all policypatsetfile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicypatsetfile -Count 
        Get the number of policypatsetfile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatsetfile -name <string>
        Get policypatsetfile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicypatsetfile -Filter @{ 'name'='<value>' }
        Get policypatsetfile data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicypatsetfile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policypatsetfile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
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
        Write-Verbose "Invoke-NSGetPolicypatsetfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policypatsetfile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatsetfile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policypatsetfile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatsetfile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policypatsetfile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatsetfile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policypatsetfile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatsetfile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policypatsetfile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policypatsetfile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicypatsetfile: Ended"
    }
}

function Invoke-NSAddPolicystringmap {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Configuration for string map resource.
    .PARAMETER Name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Comment 
        Comments associated with the string map or key-value pair bound to this string map. 
    .PARAMETER PassThru 
        Return details about the created policystringmap item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicystringmap -name <string>
        An example how to add policystringmap config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicystringmap
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policystringmap/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicystringmap: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policystringmap", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policystringmap -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicystringmap -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicystringmap: Finished"
    }
}

function Invoke-NSDeletePolicystringmap {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Configuration for string map resource.
    .PARAMETER Name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicystringmap -Name <string>
        An example how to delete policystringmap config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicystringmap
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policystringmap/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeletePolicystringmap: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policystringmap -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicystringmap: Finished"
    }
}

function Invoke-NSUpdatePolicystringmap {
    <#
    .SYNOPSIS
        Update Policy configuration. config Object.
    .DESCRIPTION
        Configuration for string map resource.
    .PARAMETER Name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Comment 
        Comments associated with the string map or key-value pair bound to this string map. 
    .PARAMETER PassThru 
        Return details about the created policystringmap item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdatePolicystringmap -name <string>
        An example how to update policystringmap config Object(s).
    .NOTES
        File Name : Invoke-NSUpdatePolicystringmap
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policystringmap/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdatePolicystringmap: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policystringmap", "Update Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type policystringmap -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicystringmap -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdatePolicystringmap: Finished"
    }
}

function Invoke-NSUnsetPolicystringmap {
    <#
    .SYNOPSIS
        Unset Policy configuration. config Object.
    .DESCRIPTION
        Configuration for string map resource.
    .PARAMETER Name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Comment 
        Comments associated with the string map or key-value pair bound to this string map.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetPolicystringmap -name <string>
        An example how to unset policystringmap config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetPolicystringmap
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policystringmap
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetPolicystringmap: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type policystringmap -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetPolicystringmap: Finished"
    }
}

function Invoke-NSGetPolicystringmap {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Configuration for string map resource.
    .PARAMETER Name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER GetAll 
        Retrieve all policystringmap object(s).
    .PARAMETER Count
        If specified, the count of the policystringmap object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicystringmap
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicystringmap -GetAll 
        Get all policystringmap data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicystringmap -Count 
        Get the number of policystringmap objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicystringmap -name <string>
        Get policystringmap object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicystringmap -Filter @{ 'name'='<value>' }
        Get policystringmap data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicystringmap
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policystringmap/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-NSGetPolicystringmap: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policystringmap objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policystringmap objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policystringmap objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policystringmap configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policystringmap configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicystringmap: Ended"
    }
}

function Invoke-NSGetPolicystringmapBinding {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to policystringmap.
    .PARAMETER Name 
        Name of the string map to display. If a name is not provided, a list of all the configured string maps is shown. 
    .PARAMETER GetAll 
        Retrieve all policystringmap_binding object(s).
    .PARAMETER Count
        If specified, the count of the policystringmap_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicystringmapBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicystringmapBinding -GetAll 
        Get all policystringmap_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicystringmapBinding -name <string>
        Get policystringmap_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicystringmapBinding -Filter @{ 'name'='<value>' }
        Get policystringmap_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicystringmapBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policystringmap_binding/
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
        Write-Verbose "Invoke-NSGetPolicystringmapBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policystringmap_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policystringmap_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policystringmap_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policystringmap_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policystringmap_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicystringmapBinding: Ended"
    }
}

function Invoke-NSAddPolicystringmapPatternBinding {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policystringmap.
    .PARAMETER Name 
        Name of the string map to which to bind the key-value pair. 
    .PARAMETER Key 
        Character string constituting the key to be bound to the string map. The key is matched against the data processed by the operation that uses the string map. The default character set is ASCII. UTF-8 characters can be included if the character set is UTF-8. UTF-8 characters can be entered directly (if the UI supports it) or can be encoded as a sequence of hexadecimal bytes '\xNN'. For example, the UTF-8 character '�' can be encoded as '\xC3\xBC'. 
    .PARAMETER Value 
        Character string constituting the value associated with the key. This value is returned when processed data matches the associated key. Refer to the key parameter for details of the value character set. 
    .PARAMETER Comment 
        Comments associated with the string map or key-value pair bound to this string map. 
    .PARAMETER PassThru 
        Return details about the created policystringmap_pattern_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicystringmapPatternBinding -name <string> -key <string> -value <string>
        An example how to add policystringmap_pattern_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicystringmapPatternBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policystringmap_pattern_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Key,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Value,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicystringmapPatternBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                key            = $key
                value          = $value
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policystringmap_pattern_binding", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type policystringmap_pattern_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicystringmapPatternBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicystringmapPatternBinding: Finished"
    }
}

function Invoke-NSDeletePolicystringmapPatternBinding {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policystringmap.
    .PARAMETER Name 
        Name of the string map to which to bind the key-value pair. 
    .PARAMETER Key 
        Character string constituting the key to be bound to the string map. The key is matched against the data processed by the operation that uses the string map. The default character set is ASCII. UTF-8 characters can be included if the character set is UTF-8. UTF-8 characters can be entered directly (if the UI supports it) or can be encoded as a sequence of hexadecimal bytes '\xNN'. For example, the UTF-8 character '�' can be encoded as '\xC3\xBC'.
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicystringmapPatternBinding -Name <string>
        An example how to delete policystringmap_pattern_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicystringmapPatternBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policystringmap_pattern_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [string]$Key 
    )
    begin {
        Write-Verbose "Invoke-NSDeletePolicystringmapPatternBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Key') ) { $arguments.Add('key', $Key) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicystringmapPatternBinding: Finished"
    }
}

function Invoke-NSGetPolicystringmapPatternBinding {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policystringmap.
    .PARAMETER Name 
        Name of the string map to which to bind the key-value pair. 
    .PARAMETER GetAll 
        Retrieve all policystringmap_pattern_binding object(s).
    .PARAMETER Count
        If specified, the count of the policystringmap_pattern_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicystringmapPatternBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicystringmapPatternBinding -GetAll 
        Get all policystringmap_pattern_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicystringmapPatternBinding -Count 
        Get the number of policystringmap_pattern_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicystringmapPatternBinding -name <string>
        Get policystringmap_pattern_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicystringmapPatternBinding -Filter @{ 'name'='<value>' }
        Get policystringmap_pattern_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicystringmapPatternBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policystringmap_pattern_binding/
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
        Write-Verbose "Invoke-NSGetPolicystringmapPatternBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policystringmap_pattern_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policystringmap_pattern_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policystringmap_pattern_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policystringmap_pattern_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policystringmap_pattern_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicystringmapPatternBinding: Ended"
    }
}

function Invoke-NSAddPolicyurlset {
    <#
    .SYNOPSIS
        Add Policy configuration. config Object.
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Comment 
        Any comments to preserve information about this url set. 
    .PARAMETER PassThru 
        Return details about the created policyurlset item.
    .EXAMPLE
        PS C:\>Invoke-NSAddPolicyurlset -name <string>
        An example how to add policyurlset config Object(s).
    .NOTES
        File Name : Invoke-NSAddPolicyurlset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyurlset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddPolicyurlset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policyurlset", "Add Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicyurlset -Filter $payload)
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
        Write-Verbose "Invoke-NSAddPolicyurlset: Finished"
    }
}

function Invoke-NSDeletePolicyurlset {
    <#
    .SYNOPSIS
        Delete Policy configuration. config Object.
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-NSDeletePolicyurlset -Name <string>
        An example how to delete policyurlset config Object(s).
    .NOTES
        File Name : Invoke-NSDeletePolicyurlset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyurlset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeletePolicyurlset: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type policyurlset -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeletePolicyurlset: Finished"
    }
}

function Invoke-NSImportPolicyurlset {
    <#
    .SYNOPSIS
        Import Policy configuration. config Object.
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Overwrite 
        Overwrites the existing file. 
    .PARAMETER Delimiter 
        CSV file record delimiter. 
    .PARAMETER Rowseparator 
        CSV file row separator. 
    .PARAMETER Url 
        URL (protocol, host, path and file name) from where the CSV (comma separated file) file will be imported or exported. Each record/line will one entry within the urlset. The first field contains the URL pattern, subsequent fields contains the metadata, if available. HTTP, HTTPS and FTP protocols are supported. NOTE: The operation fails if the destination HTTPS server requires client certificate authentication for access. 
    .PARAMETER Interval 
        The interval, in seconds, rounded down to the nearest 15 minutes, at which the update of urlset occurs. 
         
         
        Maximum value = 2592000 
    .PARAMETER Privateset 
        Prevent this urlset from being exported. 
    .PARAMETER Subdomainexactmatch 
        Force exact subdomain matching, ex. given an entry 'google.com' in the urlset, a request to 'news.google.com' won't match, if subdomainExactMatch is set. 
    .PARAMETER Matchedid 
        An ID that would be sent to AppFlow to indicate which URLSet was the last one that matched the requested URL. 
         
         
        Maximum value = 31 
    .PARAMETER Canaryurl 
        Add this URL to this urlset. Used for testing when contents of urlset is kept confidential.
    .EXAMPLE
        PS C:\>Invoke-NSImportPolicyurlset -name <string> -url <string>
        An example how to import policyurlset config Object(s).
    .NOTES
        File Name : Invoke-NSImportPolicyurlset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyurlset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [boolean]$Overwrite,

        [string]$Delimiter,

        [string]$Rowseparator,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Url,

        [double]$Interval,

        [boolean]$Privateset,

        [boolean]$Subdomainexactmatch,

        [double]$Matchedid,

        [ValidateLength(1, 2047)]
        [string]$Canaryurl 

    )
    begin {
        Write-Verbose "Invoke-NSImportPolicyurlset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                url            = $url
            }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSBoundParameters.ContainsKey('delimiter') ) { $payload.Add('delimiter', $delimiter) }
            if ( $PSBoundParameters.ContainsKey('rowseparator') ) { $payload.Add('rowseparator', $rowseparator) }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('privateset') ) { $payload.Add('privateset', $privateset) }
            if ( $PSBoundParameters.ContainsKey('subdomainexactmatch') ) { $payload.Add('subdomainexactmatch', $subdomainexactmatch) }
            if ( $PSBoundParameters.ContainsKey('matchedid') ) { $payload.Add('matchedid', $matchedid) }
            if ( $PSBoundParameters.ContainsKey('canaryurl') ) { $payload.Add('canaryurl', $canaryurl) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSImportPolicyurlset: Finished"
    }
}

function Invoke-NSChangePolicyurlset {
    <#
    .SYNOPSIS
        Change Policy configuration. config Object.
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER PassThru 
        Return details about the created policyurlset item.
    .EXAMPLE
        PS C:\>Invoke-NSChangePolicyurlset -name <string>
        An example how to change policyurlset config Object(s).
    .NOTES
        File Name : Invoke-NSChangePolicyurlset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyurlset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSChangePolicyurlset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess("policyurlset", "Change Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Action update -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetPolicyurlset -Filter $payload)
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
        Write-Verbose "Invoke-NSChangePolicyurlset: Finished"
    }
}

function Invoke-NSExportPolicyurlset {
    <#
    .SYNOPSIS
        Export Policy configuration. config Object.
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Url 
        URL (protocol, host, path and file name) from where the CSV (comma separated file) file will be imported or exported. Each record/line will one entry within the urlset. The first field contains the URL pattern, subsequent fields contains the metadata, if available. HTTP, HTTPS and FTP protocols are supported. NOTE: The operation fails if the destination HTTPS server requires client certificate authentication for access.
    .EXAMPLE
        PS C:\>Invoke-NSExportPolicyurlset -name <string> -url <string>
        An example how to export policyurlset config Object(s).
    .NOTES
        File Name : Invoke-NSExportPolicyurlset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyurlset/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Url 

    )
    begin {
        Write-Verbose "Invoke-NSExportPolicyurlset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                url            = $url
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Export Policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Action export -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSExportPolicyurlset: Finished"
    }
}

function Invoke-NSGetPolicyurlset {
    <#
    .SYNOPSIS
        Get Policy configuration. config object(s).
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER GetAll 
        Retrieve all policyurlset object(s).
    .PARAMETER Count
        If specified, the count of the policyurlset object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyurlset
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicyurlset -GetAll 
        Get all policyurlset data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetPolicyurlset -Count 
        Get the number of policyurlset objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyurlset -name <string>
        Get policyurlset object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetPolicyurlset -Filter @{ 'name'='<value>' }
        Get policyurlset data with a filter.
    .NOTES
        File Name : Invoke-NSGetPolicyurlset
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/policy/policyurlset/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-NSGetPolicyurlset: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policyurlset objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyurlset objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyurlset objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyurlset configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policyurlset configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetPolicyurlset: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCK8Tt88tOW4+Wa
# YPLDeZj3LwikktzeVsYi+ElzUivsnaCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgzFvcivhf4gr+0HURYaC99k4s8vLd3njn0NasxeGLbUEwDQYJKoZIhvcNAQEB
# BQAEggEAWu+FO8wLwZNpOZlO8yjoWfR212cXYGxnDvuZv5mzudxrZ+JB2Uz3DRPV
# zFV/qVXUHqRpRS4JlC0wJh4wVgAbrNAcfw/mjq7of5REnjNFRb9zLqJzutkAJmbP
# PlbvtClIWI0c7st8mKc000S5zV0jNiGGN1omed3qH8zQuVsWmPr9H2vm47kYxw+n
# yJX0YBqXZkEUGArblLz95tuVDh24xTthHI3W9XN4Nr/VwM4szCVWQO8UFdGFoBEk
# f9SJ4chHh5SH931V5KPvR1EbnUcfOkekAwbFjcY8diwGassxcC0FOISvXLLPvXeL
# RJ67Jagi+WrUlRLIVYfIyBmMrlkfRQ==
# SIG # End signature block
