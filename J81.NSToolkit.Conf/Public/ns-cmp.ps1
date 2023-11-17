function Invoke-NSAddCmpaction {
    <#
    .SYNOPSIS
        Add Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression action resource.
    .PARAMETER Name 
        Name of the compression action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the action is added. 
    .PARAMETER Cmptype 
        Type of compression performed by this action. 
        Available settings function as follows: 
        * COMPRESS - Apply GZIP or DEFLATE compression to the response, depending on the request header. Prefer GZIP. 
        * GZIP - Apply GZIP compression. 
        * DEFLATE - Apply DEFLATE compression. 
        * NOCOMPRESS - Do not compress the response if the request matches a policy that uses this action. 
        Possible values = compress, gzip, deflate, nocompress 
    .PARAMETER Addvaryheader 
        Control insertion of the Vary header in HTTP responses compressed by Citrix ADC. Intermediate caches store different versions of the response for different values of the headers present in the Vary response header. 
         
        Possible values = GLOBAL, DISABLED, ENABLED 
    .PARAMETER Varyheadervalue 
        The value of the HTTP Vary header for compressed responses. 
    .PARAMETER Deltatype 
        The type of delta action (if delta type compression action is defined). 
         
        Possible values = PERURL, PERPOLICY 
    .PARAMETER PassThru 
        Return details about the created cmpaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCmpaction -name <string> -cmptype <string>
        An example how to add cmpaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddCmpaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [ValidateSet('compress', 'gzip', 'deflate', 'nocompress')]
        [string]$Cmptype,

        [ValidateSet('GLOBAL', 'DISABLED', 'ENABLED')]
        [string]$Addvaryheader = 'GLOBAL',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Varyheadervalue,

        [ValidateSet('PERURL', 'PERPOLICY')]
        [string]$Deltatype = 'PERURL',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCmpaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                cmptype        = $cmptype
            }
            if ( $PSBoundParameters.ContainsKey('addvaryheader') ) { $payload.Add('addvaryheader', $addvaryheader) }
            if ( $PSBoundParameters.ContainsKey('varyheadervalue') ) { $payload.Add('varyheadervalue', $varyheadervalue) }
            if ( $PSBoundParameters.ContainsKey('deltatype') ) { $payload.Add('deltatype', $deltatype) }
            if ( $PSCmdlet.ShouldProcess("cmpaction", "Add Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cmpaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCmpaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCmpaction: Finished"
    }
}

function Invoke-NSDeleteCmpaction {
    <#
    .SYNOPSIS
        Delete Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression action resource.
    .PARAMETER Name 
        Name of the compression action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the action is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCmpaction -Name <string>
        An example how to delete cmpaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCmpaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteCmpaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cmpaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCmpaction: Finished"
    }
}

function Invoke-NSUpdateCmpaction {
    <#
    .SYNOPSIS
        Update Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression action resource.
    .PARAMETER Name 
        Name of the compression action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the action is added. 
    .PARAMETER Cmptype 
        Type of compression performed by this action. 
        Available settings function as follows: 
        * COMPRESS - Apply GZIP or DEFLATE compression to the response, depending on the request header. Prefer GZIP. 
        * GZIP - Apply GZIP compression. 
        * DEFLATE - Apply DEFLATE compression. 
        * NOCOMPRESS - Do not compress the response if the request matches a policy that uses this action. 
        Possible values = compress, gzip, deflate, nocompress 
    .PARAMETER Addvaryheader 
        Control insertion of the Vary header in HTTP responses compressed by Citrix ADC. Intermediate caches store different versions of the response for different values of the headers present in the Vary response header. 
         
        Possible values = GLOBAL, DISABLED, ENABLED 
    .PARAMETER Varyheadervalue 
        The value of the HTTP Vary header for compressed responses. 
    .PARAMETER PassThru 
        Return details about the created cmpaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCmpaction -name <string>
        An example how to update cmpaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCmpaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('compress', 'gzip', 'deflate', 'nocompress')]
        [string]$Cmptype,

        [ValidateSet('GLOBAL', 'DISABLED', 'ENABLED')]
        [string]$Addvaryheader,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Varyheadervalue,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCmpaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('cmptype') ) { $payload.Add('cmptype', $cmptype) }
            if ( $PSBoundParameters.ContainsKey('addvaryheader') ) { $payload.Add('addvaryheader', $addvaryheader) }
            if ( $PSBoundParameters.ContainsKey('varyheadervalue') ) { $payload.Add('varyheadervalue', $varyheadervalue) }
            if ( $PSCmdlet.ShouldProcess("cmpaction", "Update Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cmpaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCmpaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCmpaction: Finished"
    }
}

function Invoke-NSUnsetCmpaction {
    <#
    .SYNOPSIS
        Unset Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression action resource.
    .PARAMETER Name 
        Name of the compression action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the action is added. 
    .PARAMETER Addvaryheader 
        Control insertion of the Vary header in HTTP responses compressed by Citrix ADC. Intermediate caches store different versions of the response for different values of the headers present in the Vary response header. 
         
        Possible values = GLOBAL, DISABLED, ENABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCmpaction -name <string>
        An example how to unset cmpaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCmpaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpaction
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$addvaryheader 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCmpaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('addvaryheader') ) { $payload.Add('addvaryheader', $addvaryheader) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type cmpaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCmpaction: Finished"
    }
}

function Invoke-NSRenameCmpaction {
    <#
    .SYNOPSIS
        Rename Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression action resource.
    .PARAMETER Name 
        Name of the compression action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the action is added. 
    .PARAMETER Newname 
        New name for the compression action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Choose a name that can be correlated with the function that the action performs. 
    .PARAMETER PassThru 
        Return details about the created cmpaction item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCmpaction -name <string> -newname <string>
        An example how to rename cmpaction config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCmpaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSRenameCmpaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("cmpaction", "Rename Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cmpaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCmpaction -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCmpaction: Finished"
    }
}

function Invoke-NSGetCmpaction {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Configuration for compression action resource.
    .PARAMETER Name 
        Name of the compression action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the action is added. 
    .PARAMETER GetAll 
        Retrieve all cmpaction object(s).
    .PARAMETER Count
        If specified, the count of the cmpaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmpaction -GetAll 
        Get all cmpaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmpaction -Count 
        Get the number of cmpaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpaction -name <string>
        Get cmpaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpaction -Filter @{ 'name'='<value>' }
        Get cmpaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmpaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpaction/
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
        Write-Verbose "Invoke-NSGetCmpaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cmpaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmpaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmpaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmpaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmpaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmpaction: Ended"
    }
}

function Invoke-NSGetCmpglobalBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to cmpglobal.
    .PARAMETER GetAll 
        Retrieve all cmpglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmpglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmpglobalBinding -GetAll 
        Get all cmpglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpglobalBinding -name <string>
        Get cmpglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpglobalBinding -Filter @{ 'name'='<value>' }
        Get cmpglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmpglobalBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpglobal_binding/
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
        Write-Verbose "Invoke-NSGetCmpglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmpglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmpglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmpglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmpglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving cmpglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmpglobalBinding: Ended"
    }
}

function Invoke-NSAddCmpglobalCmppolicyBinding {
    <#
    .SYNOPSIS
        Add Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to cmpglobal.
    .PARAMETER Policyname 
        The name of the globally bound HTTP compression policy. 
    .PARAMETER Priority 
        Positive integer specifying the priority of the policy. The lower the number, the higher the priority. By default, polices within a label are evaluated in the order of their priority numbers. In the configuration utility, you can click the Priority field and edit the priority level or drag the entry to a new position in the list. If you drag the entry to a new position, the priority level is updated automatically. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the priority of the next policy, within the policy label, to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher numbered priority. * END - Stop evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, it's evaluation result determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, that policy is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher priority number is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest priority number, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Type 
        Bind point to which the policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, HTTPQUIC_RES_OVERRIDE, HTTPQUIC_RES_DEFAULT, NONE 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or a policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. 
    .PARAMETER Labeltype 
        Type of policy label invocation. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created cmpglobal_cmppolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCmpglobalCmppolicyBinding -policyname <string>
        An example how to add cmpglobal_cmppolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCmpglobalCmppolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpglobal_cmppolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT', 'HTTPQUIC_RES_OVERRIDE', 'HTTPQUIC_RES_DEFAULT', 'NONE')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCmpglobalCmppolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("cmpglobal_cmppolicy_binding", "Add Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cmpglobal_cmppolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCmpglobalCmppolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCmpglobalCmppolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCmpglobalCmppolicyBinding {
    <#
    .SYNOPSIS
        Delete Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to cmpglobal.
    .PARAMETER Policyname 
        The name of the globally bound HTTP compression policy. 
    .PARAMETER Type 
        Bind point to which the policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, HTTPQUIC_RES_OVERRIDE, HTTPQUIC_RES_DEFAULT, NONE 
    .PARAMETER Priority 
        Positive integer specifying the priority of the policy. The lower the number, the higher the priority. By default, polices within a label are evaluated in the order of their priority numbers. In the configuration utility, you can click the Priority field and edit the priority level or drag the entry to a new position in the list. If you drag the entry to a new position, the priority level is updated automatically.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCmpglobalCmppolicyBinding 
        An example how to delete cmpglobal_cmppolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCmpglobalCmppolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpglobal_cmppolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [string]$Type,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCmpglobalCmppolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("cmpglobal_cmppolicy_binding", "Delete Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cmpglobal_cmppolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCmpglobalCmppolicyBinding: Finished"
    }
}

function Invoke-NSGetCmpglobalCmppolicyBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to cmpglobal.
    .PARAMETER Type 
        Bind point to which the policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, HTTPQUIC_RES_OVERRIDE, HTTPQUIC_RES_DEFAULT, NONE 
    .PARAMETER GetAll 
        Retrieve all cmpglobal_cmppolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmpglobal_cmppolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpglobalCmppolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmpglobalCmppolicyBinding -GetAll 
        Get all cmpglobal_cmppolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmpglobalCmppolicyBinding -Count 
        Get the number of cmpglobal_cmppolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpglobalCmppolicyBinding -name <string>
        Get cmpglobal_cmppolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpglobalCmppolicyBinding -Filter @{ 'name'='<value>' }
        Get cmpglobal_cmppolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmpglobalCmppolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpglobal_cmppolicy_binding/
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
        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT', 'HTTPQUIC_RES_OVERRIDE', 'HTTPQUIC_RES_DEFAULT', 'NONE')]
        [string]$Type,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCmpglobalCmppolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmpglobal_cmppolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpglobal_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmpglobal_cmppolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpglobal_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmpglobal_cmppolicy_binding objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpglobal_cmppolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmpglobal_cmppolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving cmpglobal_cmppolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpglobal_cmppolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmpglobalCmppolicyBinding: Ended"
    }
}

function Invoke-NSUpdateCmpparameter {
    <#
    .SYNOPSIS
        Update Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for CMP parameter resource.
    .PARAMETER Cmplevel 
        Specify a compression level. Available settings function as follows: 
        * Optimal - Corresponds to a gzip GZIP level of 5-7. 
        * Best speed - Corresponds to a gzip level of 1. 
        * Best compression - Corresponds to a gzip level of 9. 
         
        Possible values = optimal, bestspeed, bestcompression 
    .PARAMETER Quantumsize 
        Minimum quantum of data to be filled before compression begins. 
         
         
        Maximum value = 63488 
    .PARAMETER Servercmp 
        Allow the server to send compressed data to the Citrix ADC. With the default setting, the Citrix ADC appliance handles all compression. 
         
        Possible values = ON, OFF 
    .PARAMETER Heurexpiry 
        Heuristic basefile expiry. 
         
        Possible values = ON, OFF 
    .PARAMETER Heurexpirythres 
        Threshold compression ratio for heuristic basefile expiry, multiplied by 100. For example, to set the threshold ratio to 1.25, specify 125. 
         
         
        Maximum value = 1000 
    .PARAMETER Heurexpiryhistwt 
        For heuristic basefile expiry, weightage to be given to historical delta compression ratio, specified as percentage. For example, to give 25% weightage to historical ratio (and therefore 75% weightage to the ratio for current delta compression transaction), specify 25. 
         
         
        Maximum value = 100 
    .PARAMETER Minressize 
        Smallest response size, in bytes, to be compressed. 
    .PARAMETER Cmpbypasspct 
        Citrix ADC CPU threshold after which compression is not performed. Range: 0 - 100. 
         
         
        Maximum value = 100 
    .PARAMETER Cmponpush 
        Citrix ADC does not wait for the quantum to be filled before starting to compress data. Upon receipt of a packet with a PUSH flag, the appliance immediately begins compression of the accumulated packets. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Policytype 
        Type of the policy. The only possible value is ADVANCED. 
         
        Possible values = ADVANCED 
    .PARAMETER Addvaryheader 
        Control insertion of the Vary header in HTTP responses compressed by Citrix ADC. Intermediate caches store different versions of the response for different values of the headers present in the Vary response header. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Varyheadervalue 
        The value of the HTTP Vary header for compressed responses. If this argument is not specified, a default value of "Accept-Encoding" will be used. 
    .PARAMETER Externalcache 
        Enable insertion of Cache-Control: private response directive to indicate response message is intended for a single user and must not be cached by a shared or proxy cache. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCmpparameter 
        An example how to update cmpparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCmpparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateSet('optimal', 'bestspeed', 'bestcompression')]
        [string]$Cmplevel,

        [double]$Quantumsize,

        [ValidateSet('ON', 'OFF')]
        [string]$Servercmp,

        [ValidateSet('ON', 'OFF')]
        [string]$Heurexpiry,

        [double]$Heurexpirythres,

        [double]$Heurexpiryhistwt,

        [double]$Minressize,

        [double]$Cmpbypasspct,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cmponpush,

        [ValidateSet('ADVANCED')]
        [string]$Policytype,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Addvaryheader,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Varyheadervalue,

        [ValidateSet('YES', 'NO')]
        [string]$Externalcache 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCmpparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('cmplevel') ) { $payload.Add('cmplevel', $cmplevel) }
            if ( $PSBoundParameters.ContainsKey('quantumsize') ) { $payload.Add('quantumsize', $quantumsize) }
            if ( $PSBoundParameters.ContainsKey('servercmp') ) { $payload.Add('servercmp', $servercmp) }
            if ( $PSBoundParameters.ContainsKey('heurexpiry') ) { $payload.Add('heurexpiry', $heurexpiry) }
            if ( $PSBoundParameters.ContainsKey('heurexpirythres') ) { $payload.Add('heurexpirythres', $heurexpirythres) }
            if ( $PSBoundParameters.ContainsKey('heurexpiryhistwt') ) { $payload.Add('heurexpiryhistwt', $heurexpiryhistwt) }
            if ( $PSBoundParameters.ContainsKey('minressize') ) { $payload.Add('minressize', $minressize) }
            if ( $PSBoundParameters.ContainsKey('cmpbypasspct') ) { $payload.Add('cmpbypasspct', $cmpbypasspct) }
            if ( $PSBoundParameters.ContainsKey('cmponpush') ) { $payload.Add('cmponpush', $cmponpush) }
            if ( $PSBoundParameters.ContainsKey('policytype') ) { $payload.Add('policytype', $policytype) }
            if ( $PSBoundParameters.ContainsKey('addvaryheader') ) { $payload.Add('addvaryheader', $addvaryheader) }
            if ( $PSBoundParameters.ContainsKey('varyheadervalue') ) { $payload.Add('varyheadervalue', $varyheadervalue) }
            if ( $PSBoundParameters.ContainsKey('externalcache') ) { $payload.Add('externalcache', $externalcache) }
            if ( $PSCmdlet.ShouldProcess("cmpparameter", "Update Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cmpparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateCmpparameter: Finished"
    }
}

function Invoke-NSUnsetCmpparameter {
    <#
    .SYNOPSIS
        Unset Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for CMP parameter resource.
    .PARAMETER Policytype 
        Type of the policy. The only possible value is ADVANCED. 
         
        Possible values = ADVANCED 
    .PARAMETER Cmplevel 
        Specify a compression level. Available settings function as follows: 
        * Optimal - Corresponds to a gzip GZIP level of 5-7. 
        * Best speed - Corresponds to a gzip level of 1. 
        * Best compression - Corresponds to a gzip level of 9. 
         
        Possible values = optimal, bestspeed, bestcompression 
    .PARAMETER Quantumsize 
        Minimum quantum of data to be filled before compression begins. 
         
         
        Maximum value = 63488 
    .PARAMETER Servercmp 
        Allow the server to send compressed data to the Citrix ADC. With the default setting, the Citrix ADC appliance handles all compression. 
         
        Possible values = ON, OFF 
    .PARAMETER Heurexpiry 
        Heuristic basefile expiry. 
         
        Possible values = ON, OFF 
    .PARAMETER Heurexpirythres 
        Threshold compression ratio for heuristic basefile expiry, multiplied by 100. For example, to set the threshold ratio to 1.25, specify 125. 
         
         
        Maximum value = 1000 
    .PARAMETER Heurexpiryhistwt 
        For heuristic basefile expiry, weightage to be given to historical delta compression ratio, specified as percentage. For example, to give 25% weightage to historical ratio (and therefore 75% weightage to the ratio for current delta compression transaction), specify 25. 
         
         
        Maximum value = 100 
    .PARAMETER Minressize 
        Smallest response size, in bytes, to be compressed. 
    .PARAMETER Cmpbypasspct 
        Citrix ADC CPU threshold after which compression is not performed. Range: 0 - 100. 
         
         
        Maximum value = 100 
    .PARAMETER Cmponpush 
        Citrix ADC does not wait for the quantum to be filled before starting to compress data. Upon receipt of a packet with a PUSH flag, the appliance immediately begins compression of the accumulated packets. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Addvaryheader 
        Control insertion of the Vary header in HTTP responses compressed by Citrix ADC. Intermediate caches store different versions of the response for different values of the headers present in the Vary response header. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Varyheadervalue 
        The value of the HTTP Vary header for compressed responses. If this argument is not specified, a default value of "Accept-Encoding" will be used. 
    .PARAMETER Externalcache 
        Enable insertion of Cache-Control: private response directive to indicate response message is intended for a single user and must not be cached by a shared or proxy cache. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCmpparameter 
        An example how to unset cmpparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCmpparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$policytype,

        [Boolean]$cmplevel,

        [Boolean]$quantumsize,

        [Boolean]$servercmp,

        [Boolean]$heurexpiry,

        [Boolean]$heurexpirythres,

        [Boolean]$heurexpiryhistwt,

        [Boolean]$minressize,

        [Boolean]$cmpbypasspct,

        [Boolean]$cmponpush,

        [Boolean]$addvaryheader,

        [Boolean]$varyheadervalue,

        [Boolean]$externalcache 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCmpparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policytype') ) { $payload.Add('policytype', $policytype) }
            if ( $PSBoundParameters.ContainsKey('cmplevel') ) { $payload.Add('cmplevel', $cmplevel) }
            if ( $PSBoundParameters.ContainsKey('quantumsize') ) { $payload.Add('quantumsize', $quantumsize) }
            if ( $PSBoundParameters.ContainsKey('servercmp') ) { $payload.Add('servercmp', $servercmp) }
            if ( $PSBoundParameters.ContainsKey('heurexpiry') ) { $payload.Add('heurexpiry', $heurexpiry) }
            if ( $PSBoundParameters.ContainsKey('heurexpirythres') ) { $payload.Add('heurexpirythres', $heurexpirythres) }
            if ( $PSBoundParameters.ContainsKey('heurexpiryhistwt') ) { $payload.Add('heurexpiryhistwt', $heurexpiryhistwt) }
            if ( $PSBoundParameters.ContainsKey('minressize') ) { $payload.Add('minressize', $minressize) }
            if ( $PSBoundParameters.ContainsKey('cmpbypasspct') ) { $payload.Add('cmpbypasspct', $cmpbypasspct) }
            if ( $PSBoundParameters.ContainsKey('cmponpush') ) { $payload.Add('cmponpush', $cmponpush) }
            if ( $PSBoundParameters.ContainsKey('addvaryheader') ) { $payload.Add('addvaryheader', $addvaryheader) }
            if ( $PSBoundParameters.ContainsKey('varyheadervalue') ) { $payload.Add('varyheadervalue', $varyheadervalue) }
            if ( $PSBoundParameters.ContainsKey('externalcache') ) { $payload.Add('externalcache', $externalcache) }
            if ( $PSCmdlet.ShouldProcess("cmpparameter", "Unset Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type cmpparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCmpparameter: Finished"
    }
}

function Invoke-NSGetCmpparameter {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Configuration for CMP parameter resource.
    .PARAMETER GetAll 
        Retrieve all cmpparameter object(s).
    .PARAMETER Count
        If specified, the count of the cmpparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmpparameter -GetAll 
        Get all cmpparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpparameter -name <string>
        Get cmpparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmpparameter -Filter @{ 'name'='<value>' }
        Get cmpparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmpparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmpparameter/
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
        Write-Verbose "Invoke-NSGetCmpparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cmpparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmpparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmpparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmpparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving cmpparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmpparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmpparameter: Ended"
    }
}

function Invoke-NSAddCmppolicy {
    <#
    .SYNOPSIS
        Add Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression policy resource.
    .PARAMETER Name 
        Name of the HTTP compression policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the policy is created. 
    .PARAMETER Rule 
        Expression that determines which HTTP requests or responses match the compression policy. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Resaction 
        The built-in or user-defined compression action to apply to the response when the policy matches a request or response. 
    .PARAMETER PassThru 
        Return details about the created cmppolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCmppolicy -name <string> -rule <string> -resaction <string>
        An example how to add cmppolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddCmppolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Rule,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCmppolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                resaction      = $resaction
            }

            if ( $PSCmdlet.ShouldProcess("cmppolicy", "Add Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cmppolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCmppolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCmppolicy: Finished"
    }
}

function Invoke-NSDeleteCmppolicy {
    <#
    .SYNOPSIS
        Delete Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression policy resource.
    .PARAMETER Name 
        Name of the HTTP compression policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the policy is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCmppolicy -Name <string>
        An example how to delete cmppolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCmppolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteCmppolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cmppolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCmppolicy: Finished"
    }
}

function Invoke-NSUpdateCmppolicy {
    <#
    .SYNOPSIS
        Update Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression policy resource.
    .PARAMETER Name 
        Name of the HTTP compression policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the policy is created. 
    .PARAMETER Rule 
        Expression that determines which HTTP requests or responses match the compression policy. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Resaction 
        The built-in or user-defined compression action to apply to the response when the policy matches a request or response. 
    .PARAMETER PassThru 
        Return details about the created cmppolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCmppolicy -name <string>
        An example how to update cmppolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCmppolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCmppolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('resaction') ) { $payload.Add('resaction', $resaction) }
            if ( $PSCmdlet.ShouldProcess("cmppolicy", "Update Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cmppolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCmppolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCmppolicy: Finished"
    }
}

function Invoke-NSRenameCmppolicy {
    <#
    .SYNOPSIS
        Rename Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression policy resource.
    .PARAMETER Name 
        Name of the HTTP compression policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the policy is created. 
    .PARAMETER Newname 
        New name for the compression policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Choose a name that reflects the function that the policy performs. 
    .PARAMETER PassThru 
        Return details about the created cmppolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCmppolicy -name <string> -newname <string>
        An example how to rename cmppolicy config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCmppolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSRenameCmppolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("cmppolicy", "Rename Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cmppolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCmppolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCmppolicy: Finished"
    }
}

function Invoke-NSGetCmppolicy {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Configuration for compression policy resource.
    .PARAMETER Name 
        Name of the HTTP compression policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the policy is created. 
    .PARAMETER GetAll 
        Retrieve all cmppolicy object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicy -GetAll 
        Get all cmppolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicy -Count 
        Get the number of cmppolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicy -name <string>
        Get cmppolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicy -Filter @{ 'name'='<value>' }
        Get cmppolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy/
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
        Write-Verbose "Invoke-NSGetCmppolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cmppolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicy: Ended"
    }
}

function Invoke-NSGetCmppolicyBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to cmppolicy.
    .PARAMETER Name 
        Name of the HTTP compression policy for which to display details. 
    .PARAMETER GetAll 
        Retrieve all cmppolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyBinding -GetAll 
        Get all cmppolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyBinding -name <string>
        Get cmppolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyBinding -Filter @{ 'name'='<value>' }
        Get cmppolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy_binding/
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
        Write-Verbose "Invoke-NSGetCmppolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmppolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicyBinding: Ended"
    }
}

function Invoke-NSGetCmppolicyCmpglobalBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object showing the cmpglobal that can be bound to cmppolicy.
    .PARAMETER Name 
        Name of the HTTP compression policy for which to display details. 
    .PARAMETER GetAll 
        Retrieve all cmppolicy_cmpglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicy_cmpglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCmpglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyCmpglobalBinding -GetAll 
        Get all cmppolicy_cmpglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyCmpglobalBinding -Count 
        Get the number of cmppolicy_cmpglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCmpglobalBinding -name <string>
        Get cmppolicy_cmpglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCmpglobalBinding -Filter @{ 'name'='<value>' }
        Get cmppolicy_cmpglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicyCmpglobalBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy_cmpglobal_binding/
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
        Write-Verbose "Invoke-NSGetCmppolicyCmpglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmppolicy_cmpglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_cmpglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicy_cmpglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_cmpglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicy_cmpglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_cmpglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicy_cmpglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_cmpglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicy_cmpglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_cmpglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicyCmpglobalBinding: Ended"
    }
}

function Invoke-NSGetCmppolicyCmppolicylabelBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object showing the cmppolicylabel that can be bound to cmppolicy.
    .PARAMETER Name 
        Name of the HTTP compression policy for which to display details. 
    .PARAMETER GetAll 
        Retrieve all cmppolicy_cmppolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicy_cmppolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCmppolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyCmppolicylabelBinding -GetAll 
        Get all cmppolicy_cmppolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyCmppolicylabelBinding -Count 
        Get the number of cmppolicy_cmppolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCmppolicylabelBinding -name <string>
        Get cmppolicy_cmppolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCmppolicylabelBinding -Filter @{ 'name'='<value>' }
        Get cmppolicy_cmppolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicyCmppolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy_cmppolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetCmppolicyCmppolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmppolicy_cmppolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_cmppolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicy_cmppolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_cmppolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicy_cmppolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_cmppolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicy_cmppolicylabel_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_cmppolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicy_cmppolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_cmppolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicyCmppolicylabelBinding: Ended"
    }
}

function Invoke-NSGetCmppolicyCrvserverBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to cmppolicy.
    .PARAMETER Name 
        Name of the HTTP compression policy for which to display details. 
    .PARAMETER GetAll 
        Retrieve all cmppolicy_crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicy_crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCrvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyCrvserverBinding -GetAll 
        Get all cmppolicy_crvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyCrvserverBinding -Count 
        Get the number of cmppolicy_crvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCrvserverBinding -name <string>
        Get cmppolicy_crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCrvserverBinding -Filter @{ 'name'='<value>' }
        Get cmppolicy_crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicyCrvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy_crvserver_binding/
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
        Write-Verbose "Invoke-NSGetCmppolicyCrvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmppolicy_crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicy_crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicy_crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicy_crvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_crvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicy_crvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicyCrvserverBinding: Ended"
    }
}

function Invoke-NSGetCmppolicyCsvserverBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to cmppolicy.
    .PARAMETER Name 
        Name of the HTTP compression policy for which to display details. 
    .PARAMETER GetAll 
        Retrieve all cmppolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyCsvserverBinding -GetAll 
        Get all cmppolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyCsvserverBinding -Count 
        Get the number of cmppolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCsvserverBinding -name <string>
        Get cmppolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyCsvserverBinding -Filter @{ 'name'='<value>' }
        Get cmppolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicyCsvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy_csvserver_binding/
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
        Write-Verbose "Invoke-NSGetCmppolicyCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmppolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicy_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicyCsvserverBinding: Ended"
    }
}

function Invoke-NSGetCmppolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to cmppolicy.
    .PARAMETER Name 
        Name of the HTTP compression policy for which to display details. 
    .PARAMETER GetAll 
        Retrieve all cmppolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyLbvserverBinding -GetAll 
        Get all cmppolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicyLbvserverBinding -Count 
        Get the number of cmppolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyLbvserverBinding -name <string>
        Get cmppolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get cmppolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicyLbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetCmppolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmppolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicyLbvserverBinding: Ended"
    }
}

function Invoke-NSAddCmppolicylabel {
    <#
    .SYNOPSIS
        Add Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression policy label resource.
    .PARAMETER Labelname 
        Name of the HTTP compression policy label. Must begin with a letter, number, or the underscore character (_). Additional characters allowed, after the first character, are the hyphen (-), period (.) pound sign (#), space ( ), at sign (@), equals (=), and colon (:). The name must be unique within the list of policy labels for compression policies. Can be renamed after the policy label is created. 
    .PARAMETER Type 
        Type of packets (request packets or response) against which to match the policies bound to this policy label. 
        Possible values = REQ, RES, HTTPQUIC_REQ, HTTPQUIC_RES 
    .PARAMETER PassThru 
        Return details about the created cmppolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCmppolicylabel -labelname <string> -type <string>
        An example how to add cmppolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSAddCmppolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateSet('REQ', 'RES', 'HTTPQUIC_REQ', 'HTTPQUIC_RES')]
        [string]$Type,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCmppolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                type                = $type
            }

            if ( $PSCmdlet.ShouldProcess("cmppolicylabel", "Add Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cmppolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCmppolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCmppolicylabel: Finished"
    }
}

function Invoke-NSDeleteCmppolicylabel {
    <#
    .SYNOPSIS
        Delete Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression policy label resource.
    .PARAMETER Labelname 
        Name of the HTTP compression policy label. Must begin with a letter, number, or the underscore character (_). Additional characters allowed, after the first character, are the hyphen (-), period (.) pound sign (#), space ( ), at sign (@), equals (=), and colon (:). The name must be unique within the list of policy labels for compression policies. Can be renamed after the policy label is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCmppolicylabel -Labelname <string>
        An example how to delete cmppolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCmppolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteCmppolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cmppolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCmppolicylabel: Finished"
    }
}

function Invoke-NSRenameCmppolicylabel {
    <#
    .SYNOPSIS
        Rename Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Configuration for compression policy label resource.
    .PARAMETER Labelname 
        Name of the HTTP compression policy label. Must begin with a letter, number, or the underscore character (_). Additional characters allowed, after the first character, are the hyphen (-), period (.) pound sign (#), space ( ), at sign (@), equals (=), and colon (:). The name must be unique within the list of policy labels for compression policies. Can be renamed after the policy label is created. 
    .PARAMETER Newname 
        New name for the compression policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created cmppolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCmppolicylabel -labelname <string> -newname <string>
        An example how to rename cmppolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCmppolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameCmppolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("cmppolicylabel", "Rename Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cmppolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCmppolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCmppolicylabel: Finished"
    }
}

function Invoke-NSGetCmppolicylabel {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Configuration for compression policy label resource.
    .PARAMETER Labelname 
        Name of the HTTP compression policy label. Must begin with a letter, number, or the underscore character (_). Additional characters allowed, after the first character, are the hyphen (-), period (.) pound sign (#), space ( ), at sign (@), equals (=), and colon (:). The name must be unique within the list of policy labels for compression policies. Can be renamed after the policy label is created. 
    .PARAMETER GetAll 
        Retrieve all cmppolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicylabel -GetAll 
        Get all cmppolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicylabel -Count 
        Get the number of cmppolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabel -name <string>
        Get cmppolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabel -Filter @{ 'name'='<value>' }
        Get cmppolicylabel data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicylabel/
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
        Write-Verbose "Invoke-NSGetCmppolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cmppolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicylabel configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicylabel configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicylabel: Ended"
    }
}

function Invoke-NSGetCmppolicylabelBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to cmppolicylabel.
    .PARAMETER Labelname 
        Name of the HTTP compression policy label for which to display details. 
    .PARAMETER GetAll 
        Retrieve all cmppolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicylabelBinding -GetAll 
        Get all cmppolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabelBinding -name <string>
        Get cmppolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabelBinding -Filter @{ 'name'='<value>' }
        Get cmppolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicylabel_binding/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCmppolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmppolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicylabelBinding: Ended"
    }
}

function Invoke-NSAddCmppolicylabelCmppolicyBinding {
    <#
    .SYNOPSIS
        Add Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to cmppolicylabel.
    .PARAMETER Labelname 
        Name of the HTTP compression policy label to which to bind the policy. 
    .PARAMETER Policyname 
        The compression policy name. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next higher priority number in the original label. 
    .PARAMETER Labeltype 
        Type of policy label invocation. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Invoke_labelname 
        Name of the label to invoke if the current policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created cmppolicylabel_cmppolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCmppolicylabelCmppolicyBinding -labelname <string> -policyname <string> -priority <double>
        An example how to add cmppolicylabel_cmppolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCmppolicylabelCmppolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicylabel_cmppolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCmppolicylabelCmppolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("cmppolicylabel_cmppolicy_binding", "Add Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cmppolicylabel_cmppolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCmppolicylabelCmppolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCmppolicylabelCmppolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCmppolicylabelCmppolicyBinding {
    <#
    .SYNOPSIS
        Delete Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to cmppolicylabel.
    .PARAMETER Labelname 
        Name of the HTTP compression policy label to which to bind the policy. 
    .PARAMETER Policyname 
        The compression policy name. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCmppolicylabelCmppolicyBinding -Labelname <string>
        An example how to delete cmppolicylabel_cmppolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCmppolicylabelCmppolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicylabel_cmppolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteCmppolicylabelCmppolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cmppolicylabel_cmppolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCmppolicylabelCmppolicyBinding: Finished"
    }
}

function Invoke-NSGetCmppolicylabelCmppolicyBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to cmppolicylabel.
    .PARAMETER Labelname 
        Name of the HTTP compression policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all cmppolicylabel_cmppolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicylabel_cmppolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabelCmppolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicylabelCmppolicyBinding -GetAll 
        Get all cmppolicylabel_cmppolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicylabelCmppolicyBinding -Count 
        Get the number of cmppolicylabel_cmppolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabelCmppolicyBinding -name <string>
        Get cmppolicylabel_cmppolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabelCmppolicyBinding -Filter @{ 'name'='<value>' }
        Get cmppolicylabel_cmppolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicylabelCmppolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicylabel_cmppolicy_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCmppolicylabelCmppolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmppolicylabel_cmppolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicylabel_cmppolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicylabel_cmppolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_cmppolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicylabel_cmppolicy_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_cmppolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicylabel_cmppolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_cmppolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicylabelCmppolicyBinding: Ended"
    }
}

function Invoke-NSGetCmppolicylabelPolicybindingBinding {
    <#
    .SYNOPSIS
        Get Compression configuration. The system's feature for compressing HTTP responses to compression-aware browsers. config object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to cmppolicylabel.
    .PARAMETER Labelname 
        Name of the HTTP compression policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all cmppolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabelPolicybindingBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicylabelPolicybindingBinding -GetAll 
        Get all cmppolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCmppolicylabelPolicybindingBinding -Count 
        Get the number of cmppolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabelPolicybindingBinding -name <string>
        Get cmppolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCmppolicylabelPolicybindingBinding -Filter @{ 'name'='<value>' }
        Get cmppolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCmppolicylabelPolicybindingBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cmp/cmppolicylabel_policybinding_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCmppolicylabelPolicybindingBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cmppolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicylabel_policybinding_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cmppolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCmppolicylabelPolicybindingBinding: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA3P+OemzB76qys
# y/pHpEAfEb4otlx1DY2sm6SqQ+9jKaCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQg3dgdIu99HLpglGLja8Wtgkcjqhbk45isjB6soRdv09YwDQYJKoZIhvcNAQEB
# BQAEggEAd9JLTv5bv/LokNDUJzSuDRrNW/QRW8v0z3zY0tsGb+3CaSjxaWkEIr82
# 34fwokdELxXGwwkMwhH3Q2LdZ2ihbBft6R/i9EOuyFDsWte12Y3c534Y2mod5/Qd
# nERkyuT+Gxltby6pzuYO7BKZYE5vZWdjJ6lNMtCyf4FdN4nGuKgZSdrDAiKGd8In
# lbLKQU77Zr0zxAsfV/Xu+1Yd62xceQRY/EtzXwSc8zuSvJFkpRj/ySlZ4OJptwpC
# Gxw4DfgnnPTk9Zlr93qF05TVrPUG/hsVX1WlQzkTIqzLLRTRJjFnCCAEoAWnrpM5
# KxPZbAXo1zBgVc061+BcEEQ8ihIJaw==
# SIG # End signature block
