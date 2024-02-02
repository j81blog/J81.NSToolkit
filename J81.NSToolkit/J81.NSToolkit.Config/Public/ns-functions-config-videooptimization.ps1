function Invoke-NSAddVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Type 
        Type of video optimization action. Available settings function as follows: 
        * clear_text_pd - Cleartext PD type is detected. 
        * clear_text_abr - Cleartext ABR is detected. 
        * encrypted_abr - Encrypted ABR is detected. 
        * trigger_enc_abr - Possible encrypted ABR is detected. 
        * trigger_body_detection - Possible cleartext ABR is detected. Triggers body content detection. 
        Possible values = clear_text_pd, clear_text_abr, encrypted_abr, trigger_enc_abr, trigger_body_detection 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddVideooptimizationdetectionaction -name <string> -type <string>
        An example how to add videooptimizationdetectionaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddVideooptimizationdetectionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [ValidateSet('clear_text_pd', 'clear_text_abr', 'encrypted_abr', 'trigger_enc_abr', 'trigger_body_detection')]
        [string]$Type,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddVideooptimizationdetectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionaction", "Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationdetectionaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddVideooptimizationdetectionaction: Finished"
    }
}

function Invoke-NSDeleteVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVideooptimizationdetectionaction -Name <string>
        An example how to delete videooptimizationdetectionaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVideooptimizationdetectionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationdetectionaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationdetectionaction: Finished"
    }
}

function Invoke-NSUpdateVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Update Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Type 
        Type of video optimization action. Available settings function as follows: 
        * clear_text_pd - Cleartext PD type is detected. 
        * clear_text_abr - Cleartext ABR is detected. 
        * encrypted_abr - Encrypted ABR is detected. 
        * trigger_enc_abr - Possible encrypted ABR is detected. 
        * trigger_body_detection - Possible cleartext ABR is detected. Triggers body content detection. 
        Possible values = clear_text_pd, clear_text_abr, encrypted_abr, trigger_enc_abr, trigger_body_detection 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateVideooptimizationdetectionaction -name <string>
        An example how to update videooptimizationdetectionaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateVideooptimizationdetectionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('clear_text_pd', 'clear_text_abr', 'encrypted_abr', 'trigger_enc_abr', 'trigger_body_detection')]
        [string]$Type,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateVideooptimizationdetectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionaction", "Update Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationdetectionaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationdetectionaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateVideooptimizationdetectionaction: Finished"
    }
}

function Invoke-NSUnsetVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Unset Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetVideooptimizationdetectionaction -name <string>
        An example how to unset videooptimizationdetectionaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetVideooptimizationdetectionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionaction
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetVideooptimizationdetectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetVideooptimizationdetectionaction: Finished"
    }
}

function Invoke-NSRenameVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Newname 
        New name for the videooptimization detection action. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionaction item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameVideooptimizationdetectionaction -name <string> -newname <string>
        An example how to rename videooptimizationdetectionaction config Object(s).
    .NOTES
        File Name : Invoke-NSRenameVideooptimizationdetectionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameVideooptimizationdetectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionaction", "Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationdetectionaction -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameVideooptimizationdetectionaction: Finished"
    }
}

function Invoke-NSGetVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionaction object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionaction -GetAll 
        Get all videooptimizationdetectionaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionaction -Count 
        Get the number of videooptimizationdetectionaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionaction -name <string>
        Get videooptimizationdetectionaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionaction -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationdetectionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionaction/
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
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationdetectionaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionaction: Ended"
    }
}

function Invoke-NSAddVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Rule 
        Expression that determines which request or response match the video optimization detection policy. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the videooptimization detection action to perform if the request matches this videooptimization detection policy. Built-in actions should be used. These are: 
        * DETECT_CLEARTEXT_PD - Cleartext PD is detected and increment related counters. 
        * DETECT_CLEARTEXT_ABR - Cleartext ABR is detected and increment related counters. 
        * DETECT_ENCRYPTED_ABR - Encrypted ABR is detected and increment related counters. 
        * TRIGGER_ENC_ABR_DETECTION - This is potentially encrypted ABR. Internal traffic heuristics algorithms will further process traffic to confirm detection. 
        * TRIGGER_CT_ABR_BODY_DETECTION - This is potentially cleartext ABR. Internal traffic heuristics algorithms will further process traffic to confirm detection. 
        * RESET - Reset the client connection by closing it. 
        * DROP - Drop the connection without sending a response. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization detection policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddVideooptimizationdetectionpolicy -name <string> -rule <string> -action <string>
        An example how to add videooptimizationdetectionpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddVideooptimizationdetectionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [Parameter(Mandatory)]
        [string]$Action,

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddVideooptimizationdetectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicy", "Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationdetectionpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddVideooptimizationdetectionpolicy: Finished"
    }
}

function Invoke-NSDeleteVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVideooptimizationdetectionpolicy -Name <string>
        An example how to delete videooptimizationdetectionpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVideooptimizationdetectionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationdetectionpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationdetectionpolicy: Finished"
    }
}

function Invoke-NSUpdateVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Update Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Rule 
        Expression that determines which request or response match the video optimization detection policy. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the videooptimization detection action to perform if the request matches this videooptimization detection policy. Built-in actions should be used. These are: 
        * DETECT_CLEARTEXT_PD - Cleartext PD is detected and increment related counters. 
        * DETECT_CLEARTEXT_ABR - Cleartext ABR is detected and increment related counters. 
        * DETECT_ENCRYPTED_ABR - Encrypted ABR is detected and increment related counters. 
        * TRIGGER_ENC_ABR_DETECTION - This is potentially encrypted ABR. Internal traffic heuristics algorithms will further process traffic to confirm detection. 
        * TRIGGER_CT_ABR_BODY_DETECTION - This is potentially cleartext ABR. Internal traffic heuristics algorithms will further process traffic to confirm detection. 
        * RESET - Reset the client connection by closing it. 
        * DROP - Drop the connection without sending a response. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization detection policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateVideooptimizationdetectionpolicy -name <string>
        An example how to update videooptimizationdetectionpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateVideooptimizationdetectionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateVideooptimizationdetectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicy", "Update Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationdetectionpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateVideooptimizationdetectionpolicy: Finished"
    }
}

function Invoke-NSUnsetVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Unset Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization detection policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetVideooptimizationdetectionpolicy -name <string>
        An example how to unset videooptimizationdetectionpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetVideooptimizationdetectionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicy
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$undefaction,

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetVideooptimizationdetectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetVideooptimizationdetectionpolicy: Finished"
    }
}

function Invoke-NSRenameVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Newname 
        New name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameVideooptimizationdetectionpolicy -name <string> -newname <string>
        An example how to rename videooptimizationdetectionpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSRenameVideooptimizationdetectionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameVideooptimizationdetectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicy", "Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationdetectionpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameVideooptimizationdetectionpolicy: Finished"
    }
}

function Invoke-NSGetVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicy object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicy -GetAll 
        Get all videooptimizationdetectionpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicy -Count 
        Get the number of videooptimizationdetectionpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicy -name <string>
        Get videooptimizationdetectionpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicy -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationdetectionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicy/
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
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicy: Ended"
    }
}

function Invoke-NSGetVideooptimizationdetectionpolicyBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationdetectionpolicy.
    .PARAMETER Name 
        Name of the videooptimization detection policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyBinding -GetAll 
        Get all videooptimizationdetectionpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyBinding -name <string>
        Get videooptimizationdetectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationdetectionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicy_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicyBinding: Ended"
    }
}

function Invoke-NSGetVideooptimizationdetectionpolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to videooptimizationdetectionpolicy.
    .PARAMETER Name 
        Name of the videooptimization detection policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyLbvserverBinding -GetAll 
        Get all videooptimizationdetectionpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyLbvserverBinding -Count 
        Get the number of videooptimizationdetectionpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyLbvserverBinding -name <string>
        Get videooptimizationdetectionpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationdetectionpolicyLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicyLbvserverBinding: Ended"
    }
}

function Invoke-NSGetVideooptimizationdetectionpolicyVideooptimizationglobaldetectionBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationglobaldetection that can be bound to videooptimizationdetectionpolicy.
    .PARAMETER Name 
        Name of the videooptimization detection policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyVideooptimizationglobaldetectionBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyVideooptimizationglobaldetectionBinding -GetAll 
        Get all videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyVideooptimizationglobaldetectionBinding -Count 
        Get the number of videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyVideooptimizationglobaldetectionBinding -name <string>
        Get videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicyVideooptimizationglobaldetectionBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationdetectionpolicyVideooptimizationglobaldetectionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicyVideooptimizationglobaldetectionBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicyVideooptimizationglobaldetectionBinding: Ended"
    }
}

function Invoke-NSAddVideooptimizationdetectionpolicylabel {
    <#
    .SYNOPSIS
        Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detection policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization detection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization detection policy label is added. 
    .PARAMETER Policylabeltype 
        Type of responses sent by the policies bound to this policy label. Types are: 
        * HTTP - HTTP responses. 
        * OTHERTCP - NON-HTTP TCP responses. 
         
        Possible values = videoopt_req, videoopt_res 
    .PARAMETER Comment 
        Any comments to preserve information about this videooptimization detection policy label. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSAddVideooptimizationdetectionpolicylabel -labelname <string>
        An example how to add videooptimizationdetectionpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSAddVideooptimizationdetectionpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('videoopt_req', 'videoopt_res')]
        [string]$Policylabeltype = 'NS_PLTMAP_RSP_REQ',

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddVideooptimizationdetectionpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname }
            if ( $PSBoundParameters.ContainsKey('policylabeltype') ) { $payload.Add('policylabeltype', $policylabeltype) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicylabel", "Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationdetectionpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSAddVideooptimizationdetectionpolicylabel: Finished"
    }
}

function Invoke-NSDeleteVideooptimizationdetectionpolicylabel {
    <#
    .SYNOPSIS
        Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detection policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization detection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization detection policy label is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVideooptimizationdetectionpolicylabel -Labelname <string>
        An example how to delete videooptimizationdetectionpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVideooptimizationdetectionpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationdetectionpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationdetectionpolicylabel: Finished"
    }
}

function Invoke-NSRenameVideooptimizationdetectionpolicylabel {
    <#
    .SYNOPSIS
        Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization detection policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization detection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization detection policy label is added. 
    .PARAMETER Newname 
        New name for the videooptimization detection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen ( 
        -), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameVideooptimizationdetectionpolicylabel -labelname <string> -newname <string>
        An example how to rename videooptimizationdetectionpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSRenameVideooptimizationdetectionpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSRenameVideooptimizationdetectionpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicylabel", "Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationdetectionpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameVideooptimizationdetectionpolicylabel: Finished"
    }
}

function Invoke-NSGetVideooptimizationdetectionpolicylabel {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Configuration for videooptimization detection policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization detection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization detection policy label is added. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabel -GetAll 
        Get all videooptimizationdetectionpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabel -Count 
        Get the number of videooptimizationdetectionpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabel -name <string>
        Get videooptimizationdetectionpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabel -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationdetectionpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicylabel/
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
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicylabel: Ended"
    }
}

function Invoke-NSGetVideooptimizationdetectionpolicylabelBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationdetectionpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization detection policy label. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelBinding -GetAll 
        Get all videooptimizationdetectionpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelBinding -name <string>
        Get videooptimizationdetectionpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationdetectionpolicylabelBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicylabelBinding: Ended"
    }
}

function Invoke-NSGetVideooptimizationdetectionpolicylabelPolicybindingBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to videooptimizationdetectionpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization detection policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelPolicybindingBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelPolicybindingBinding -GetAll 
        Get all videooptimizationdetectionpolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelPolicybindingBinding -Count 
        Get the number of videooptimizationdetectionpolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelPolicybindingBinding -name <string>
        Get videooptimizationdetectionpolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelPolicybindingBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationdetectionpolicylabelPolicybindingBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicylabelPolicybindingBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicylabelPolicybindingBinding: Ended"
    }
}

function Invoke-NSAddVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding {
    <#
    .SYNOPSIS
        Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationdetectionpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization detection policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the videooptimization policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label and evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Available settings function as follows: * vserver - Invoke an unnamed policy label associated with a virtual server. * policylabel - Invoke a user-defined policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Invoke_labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is reqvserver or resvserver, name of the virtual server. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding -labelname <string> -policyname <string> -priority <double>
        An example how to add videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding", "Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding {
    <#
    .SYNOPSIS
        Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationdetectionpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization detection policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the videooptimization policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding -Labelname <string>
        An example how to delete videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding: Finished"
    }
}

function Invoke-NSGetVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationdetectionpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization detection policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding -GetAll 
        Get all videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding -Count 
        Get the number of videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding -name <string>
        Get videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationdetectionpolicylabelVideooptimizationdetectionpolicyBinding: Ended"
    }
}

function Invoke-NSGetVideooptimizationglobaldetectionBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationglobaldetection.
    .PARAMETER GetAll 
        Retrieve all videooptimizationglobaldetection_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationglobaldetection_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobaldetectionBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationglobaldetectionBinding -GetAll 
        Get all videooptimizationglobaldetection_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobaldetectionBinding -name <string>
        Get videooptimizationglobaldetection_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobaldetectionBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationglobaldetection_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationglobaldetectionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationglobaldetection_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationglobaldetectionBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationglobaldetection_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationglobaldetection_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationglobaldetection_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationglobaldetection_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving videooptimizationglobaldetection_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationglobaldetectionBinding: Ended"
    }
}

function Invoke-NSAddVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding {
    <#
    .SYNOPSIS
        Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationglobaldetection.
    .PARAMETER Policyname 
        Name of the videooptimization detection policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation, Available settings function as follows: * vserver - Forward the request to the specified virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Labelname 
        Name of the policy label to invoke. If the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is policylabel. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding -policyname <string> -priority <double>
        An example how to add videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding", "Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding {
    <#
    .SYNOPSIS
        Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationglobaldetection.
    .PARAMETER Policyname 
        Name of the videooptimization detection policy. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding 
        An example how to delete videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding", "Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding: Finished"
    }
}

function Invoke-NSGetVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationglobaldetection.
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER GetAll 
        Retrieve all videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding -GetAll 
        Get all videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding -Count 
        Get the number of videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding -name <string>
        Get videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationglobaldetectionVideooptimizationdetectionpolicyBinding: Ended"
    }
}

function Invoke-NSGetVideooptimizationglobalpacingBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationglobalpacing.
    .PARAMETER GetAll 
        Retrieve all videooptimizationglobalpacing_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationglobalpacing_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobalpacingBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationglobalpacingBinding -GetAll 
        Get all videooptimizationglobalpacing_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobalpacingBinding -name <string>
        Get videooptimizationglobalpacing_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobalpacingBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationglobalpacing_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationglobalpacingBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationglobalpacing_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationglobalpacingBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationglobalpacing_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationglobalpacing_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationglobalpacing_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationglobalpacing_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving videooptimizationglobalpacing_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationglobalpacingBinding: Ended"
    }
}

function Invoke-NSAddVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding {
    <#
    .SYNOPSIS
        Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationglobalpacing.
    .PARAMETER Policyname 
        Name of the videooptimization pacing policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation, Available settings function as follows: * vserver - Forward the request to the specified virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Labelname 
        Name of the policy label to invoke. If the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is policylabel. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationglobalpacing_videooptimizationpacingpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding -policyname <string> -priority <double>
        An example how to add videooptimizationglobalpacing_videooptimizationpacingpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationglobalpacing_videooptimizationpacingpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("videooptimizationglobalpacing_videooptimizationpacingpolicy_binding", "Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding {
    <#
    .SYNOPSIS
        Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationglobalpacing.
    .PARAMETER Policyname 
        Name of the videooptimization pacing policy. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding 
        An example how to delete videooptimizationglobalpacing_videooptimizationpacingpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationglobalpacing_videooptimizationpacingpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationglobalpacing_videooptimizationpacingpolicy_binding", "Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding: Finished"
    }
}

function Invoke-NSGetVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationglobalpacing.
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER GetAll 
        Retrieve all videooptimizationglobalpacing_videooptimizationpacingpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationglobalpacing_videooptimizationpacingpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding -GetAll 
        Get all videooptimizationglobalpacing_videooptimizationpacingpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding -Count 
        Get the number of videooptimizationglobalpacing_videooptimizationpacingpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding -name <string>
        Get videooptimizationglobalpacing_videooptimizationpacingpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationglobalpacing_videooptimizationpacingpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationglobalpacing_videooptimizationpacingpolicy_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationglobalpacing_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationglobalpacing_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationglobalpacing_videooptimizationpacingpolicy_binding objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationglobalpacing_videooptimizationpacingpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving videooptimizationglobalpacing_videooptimizationpacingpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationglobalpacingVideooptimizationpacingpolicyBinding: Ended"
    }
}

function Invoke-NSAddVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Rate 
        ABR Video Optimization Pacing Rate (in Kbps). 
         
         
        Maximum value = 2147483647 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddVideooptimizationpacingaction -name <string> -rate <int>
        An example how to add videooptimizationpacingaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddVideooptimizationpacingaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [int]$Rate = '1000',

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddVideooptimizationpacingaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rate           = $rate
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingaction", "Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationpacingaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddVideooptimizationpacingaction: Finished"
    }
}

function Invoke-NSDeleteVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVideooptimizationpacingaction -Name <string>
        An example how to delete videooptimizationpacingaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVideooptimizationpacingaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationpacingaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationpacingaction: Finished"
    }
}

function Invoke-NSUpdateVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Update Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Rate 
        ABR Video Optimization Pacing Rate (in Kbps). 
         
         
        Maximum value = 2147483647 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateVideooptimizationpacingaction -name <string>
        An example how to update videooptimizationpacingaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateVideooptimizationpacingaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [int]$Rate,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateVideooptimizationpacingaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rate') ) { $payload.Add('rate', $rate) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingaction", "Update Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationpacingaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationpacingaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateVideooptimizationpacingaction: Finished"
    }
}

function Invoke-NSUnsetVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Unset Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Rate 
        ABR Video Optimization Pacing Rate (in Kbps). 
         
         
        Maximum value = 2147483647 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetVideooptimizationpacingaction -name <string>
        An example how to unset videooptimizationpacingaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetVideooptimizationpacingaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingaction
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$rate,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetVideooptimizationpacingaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rate') ) { $payload.Add('rate', $rate) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetVideooptimizationpacingaction: Finished"
    }
}

function Invoke-NSRenameVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Newname 
        New name for the videooptimization pacing action. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingaction item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameVideooptimizationpacingaction -name <string> -newname <string>
        An example how to rename videooptimizationpacingaction config Object(s).
    .NOTES
        File Name : Invoke-NSRenameVideooptimizationpacingaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameVideooptimizationpacingaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingaction", "Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationpacingaction -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameVideooptimizationpacingaction: Finished"
    }
}

function Invoke-NSGetVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingaction object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingaction -GetAll 
        Get all videooptimizationpacingaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingaction -Count 
        Get the number of videooptimizationpacingaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingaction -name <string>
        Get videooptimizationpacingaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingaction -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationpacingaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingaction/
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
        Write-Verbose "Invoke-NSGetVideooptimizationpacingaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationpacingaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationpacingaction: Ended"
    }
}

function Invoke-NSAddVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Rule 
        Expression that determines which request or response match the video optimization pacing policy. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the videooptimization pacing action to perform if the request matches this videooptimization pacing policy. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization pacing policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddVideooptimizationpacingpolicy -name <string> -rule <string> -action <string>
        An example how to add videooptimizationpacingpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddVideooptimizationpacingpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [Parameter(Mandatory)]
        [string]$Action,

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddVideooptimizationpacingpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicy", "Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationpacingpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddVideooptimizationpacingpolicy: Finished"
    }
}

function Invoke-NSDeleteVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVideooptimizationpacingpolicy -Name <string>
        An example how to delete videooptimizationpacingpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVideooptimizationpacingpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationpacingpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationpacingpolicy: Finished"
    }
}

function Invoke-NSUpdateVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Update Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Rule 
        Expression that determines which request or response match the video optimization pacing policy. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the videooptimization pacing action to perform if the request matches this videooptimization pacing policy. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization pacing policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateVideooptimizationpacingpolicy -name <string>
        An example how to update videooptimizationpacingpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateVideooptimizationpacingpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateVideooptimizationpacingpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicy", "Update Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationpacingpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationpacingpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateVideooptimizationpacingpolicy: Finished"
    }
}

function Invoke-NSUnsetVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Unset Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization pacing policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetVideooptimizationpacingpolicy -name <string>
        An example how to unset videooptimizationpacingpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetVideooptimizationpacingpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicy
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$undefaction,

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetVideooptimizationpacingpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetVideooptimizationpacingpolicy: Finished"
    }
}

function Invoke-NSRenameVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Newname 
        New name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameVideooptimizationpacingpolicy -name <string> -newname <string>
        An example how to rename videooptimizationpacingpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSRenameVideooptimizationpacingpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameVideooptimizationpacingpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicy", "Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationpacingpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameVideooptimizationpacingpolicy: Finished"
    }
}

function Invoke-NSGetVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicy object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicy -GetAll 
        Get all videooptimizationpacingpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicy -Count 
        Get the number of videooptimizationpacingpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicy -name <string>
        Get videooptimizationpacingpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicy -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationpacingpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicy/
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
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationpacingpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicy: Ended"
    }
}

function Invoke-NSGetVideooptimizationpacingpolicyBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationpacingpolicy.
    .PARAMETER Name 
        Name of the videooptimization pacing policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyBinding -GetAll 
        Get all videooptimizationpacingpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyBinding -name <string>
        Get videooptimizationpacingpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationpacingpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicy_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicyBinding: Ended"
    }
}

function Invoke-NSGetVideooptimizationpacingpolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to videooptimizationpacingpolicy.
    .PARAMETER Name 
        Name of the videooptimization pacing policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyLbvserverBinding -GetAll 
        Get all videooptimizationpacingpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyLbvserverBinding -Count 
        Get the number of videooptimizationpacingpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyLbvserverBinding -name <string>
        Get videooptimizationpacingpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationpacingpolicyLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicyLbvserverBinding: Ended"
    }
}

function Invoke-NSGetVideooptimizationpacingpolicyVideooptimizationglobalpacingBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationglobalpacing that can be bound to videooptimizationpacingpolicy.
    .PARAMETER Name 
        Name of the videooptimization pacing policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicy_videooptimizationglobalpacing_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicy_videooptimizationglobalpacing_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyVideooptimizationglobalpacingBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyVideooptimizationglobalpacingBinding -GetAll 
        Get all videooptimizationpacingpolicy_videooptimizationglobalpacing_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyVideooptimizationglobalpacingBinding -Count 
        Get the number of videooptimizationpacingpolicy_videooptimizationglobalpacing_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyVideooptimizationglobalpacingBinding -name <string>
        Get videooptimizationpacingpolicy_videooptimizationglobalpacing_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicyVideooptimizationglobalpacingBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicy_videooptimizationglobalpacing_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationpacingpolicyVideooptimizationglobalpacingBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicy_videooptimizationglobalpacing_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicyVideooptimizationglobalpacingBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicy_videooptimizationglobalpacing_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicy_videooptimizationglobalpacing_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_videooptimizationglobalpacing_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_videooptimizationglobalpacing_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_videooptimizationglobalpacing_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicy_videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicyVideooptimizationglobalpacingBinding: Ended"
    }
}

function Invoke-NSAddVideooptimizationpacingpolicylabel {
    <#
    .SYNOPSIS
        Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacing policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization pacing policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization pacing policy label is added. 
    .PARAMETER Policylabeltype 
        Type of responses sent by the policies bound to this policy label. Types are: 
        * HTTP - HTTP responses. 
        * OTHERTCP - NON-HTTP TCP responses. 
         
        Possible values = videoopt_req, videoopt_res 
    .PARAMETER Comment 
        Any comments to preserve information about this videooptimization pacing policy label. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSAddVideooptimizationpacingpolicylabel -labelname <string>
        An example how to add videooptimizationpacingpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSAddVideooptimizationpacingpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('videoopt_req', 'videoopt_res')]
        [string]$Policylabeltype = 'NS_PLTMAP_RSP_REQ',

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddVideooptimizationpacingpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname }
            if ( $PSBoundParameters.ContainsKey('policylabeltype') ) { $payload.Add('policylabeltype', $policylabeltype) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicylabel", "Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationpacingpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSAddVideooptimizationpacingpolicylabel: Finished"
    }
}

function Invoke-NSDeleteVideooptimizationpacingpolicylabel {
    <#
    .SYNOPSIS
        Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacing policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization pacing policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization pacing policy label is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVideooptimizationpacingpolicylabel -Labelname <string>
        An example how to delete videooptimizationpacingpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVideooptimizationpacingpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationpacingpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationpacingpolicylabel: Finished"
    }
}

function Invoke-NSRenameVideooptimizationpacingpolicylabel {
    <#
    .SYNOPSIS
        Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for videooptimization pacing policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization pacing policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization pacing policy label is added. 
    .PARAMETER Newname 
        New name for the videooptimization pacing policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen ( 
        -), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameVideooptimizationpacingpolicylabel -labelname <string> -newname <string>
        An example how to rename videooptimizationpacingpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSRenameVideooptimizationpacingpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSRenameVideooptimizationpacingpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicylabel", "Rename Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationpacingpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameVideooptimizationpacingpolicylabel: Finished"
    }
}

function Invoke-NSGetVideooptimizationpacingpolicylabel {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Configuration for videooptimization pacing policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization pacing policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization pacing policy label is added. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabel -GetAll 
        Get all videooptimizationpacingpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabel -Count 
        Get the number of videooptimizationpacingpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabel -name <string>
        Get videooptimizationpacingpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabel -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationpacingpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicylabel/
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
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationpacingpolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicylabel: Ended"
    }
}

function Invoke-NSGetVideooptimizationpacingpolicylabelBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationpacingpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization pacing policy label. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelBinding -GetAll 
        Get all videooptimizationpacingpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelBinding -name <string>
        Get videooptimizationpacingpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationpacingpolicylabelBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicylabelBinding: Ended"
    }
}

function Invoke-NSGetVideooptimizationpacingpolicylabelPolicybindingBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to videooptimizationpacingpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization pacing policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelPolicybindingBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelPolicybindingBinding -GetAll 
        Get all videooptimizationpacingpolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelPolicybindingBinding -Count 
        Get the number of videooptimizationpacingpolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelPolicybindingBinding -name <string>
        Get videooptimizationpacingpolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelPolicybindingBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationpacingpolicylabelPolicybindingBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicylabelPolicybindingBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicylabelPolicybindingBinding: Ended"
    }
}

function Invoke-NSAddVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding {
    <#
    .SYNOPSIS
        Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationpacingpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization pacing policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the videooptimization policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label and evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Available settings function as follows: * vserver - Invoke an unnamed policy label associated with a virtual server. * policylabel - Invoke a user-defined policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Invoke_labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is reqvserver or resvserver, name of the virtual server. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding -labelname <string> -policyname <string> -priority <double>
        An example how to add videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding", "Add Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding {
    <#
    .SYNOPSIS
        Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationpacingpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization pacing policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the videooptimization policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding -Labelname <string>
        An example how to delete videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding: Finished"
    }
}

function Invoke-NSGetVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationpacingpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization pacing policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding -GetAll 
        Get all videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding -Count 
        Get the number of videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding -name <string>
        Get videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding/
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
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationpacingpolicylabelVideooptimizationpacingpolicyBinding: Ended"
    }
}

function Invoke-NSUpdateVideooptimizationparameter {
    <#
    .SYNOPSIS
        Update Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for VideoOptimization parameter resource.
    .PARAMETER Randomsamplingpercentage 
        Random Sampling Percentage. 
         
         
        Maximum value = 100 
    .PARAMETER Quicpacingrate 
        QUIC Video Pacing Rate (Kbps). 
         
        Maximum value = 2147483647
    .EXAMPLE
        PS C:\>Invoke-NSUpdateVideooptimizationparameter 
        An example how to update videooptimizationparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateVideooptimizationparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [double]$Randomsamplingpercentage,

        [double]$Quicpacingrate 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateVideooptimizationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('randomsamplingpercentage') ) { $payload.Add('randomsamplingpercentage', $randomsamplingpercentage) }
            if ( $PSBoundParameters.ContainsKey('quicpacingrate') ) { $payload.Add('quicpacingrate', $quicpacingrate) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationparameter", "Update Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateVideooptimizationparameter: Finished"
    }
}

function Invoke-NSUnsetVideooptimizationparameter {
    <#
    .SYNOPSIS
        Unset Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object.
    .DESCRIPTION
        Configuration for VideoOptimization parameter resource.
    .PARAMETER Randomsamplingpercentage 
        Random Sampling Percentage. 
         
         
        Maximum value = 100 
    .PARAMETER Quicpacingrate 
        QUIC Video Pacing Rate (Kbps). 
         
        Maximum value = 2147483647
    .EXAMPLE
        PS C:\>Invoke-NSUnsetVideooptimizationparameter 
        An example how to unset videooptimizationparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetVideooptimizationparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$randomsamplingpercentage,

        [Boolean]$quicpacingrate 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetVideooptimizationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('randomsamplingpercentage') ) { $payload.Add('randomsamplingpercentage', $randomsamplingpercentage) }
            if ( $PSBoundParameters.ContainsKey('quicpacingrate') ) { $payload.Add('quicpacingrate', $quicpacingrate) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationparameter", "Unset Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type videooptimizationparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetVideooptimizationparameter: Finished"
    }
}

function Invoke-NSGetVideooptimizationparameter {
    <#
    .SYNOPSIS
        Get Video optimization feature is used to show (i) the stats of different media types that are being served by the Citrix ADC and (ii) the details of optimization applied on ABR videos config object(s).
    .DESCRIPTION
        Configuration for VideoOptimization parameter resource.
    .PARAMETER GetAll 
        Retrieve all videooptimizationparameter object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetVideooptimizationparameter -GetAll 
        Get all videooptimizationparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationparameter -name <string>
        Get videooptimizationparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetVideooptimizationparameter -Filter @{ 'name'='<value>' }
        Get videooptimizationparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetVideooptimizationparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/videooptimization/videooptimizationparameter/
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
        Write-Verbose "Invoke-NSGetVideooptimizationparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving videooptimizationparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type videooptimizationparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetVideooptimizationparameter: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAd5T5qfYgkq3sa
# WntByJomARkTDkXs8Vh9SUbWZ0CHpqCCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQgDT1Gqw5QN761cnZG/oWPr7Kjrtn0dHRSqQRWS6dIXBgwDQYJ
# KoZIhvcNAQEBBQAEggEAbWo+hAa780GtMuVIZF9zGK6YqQ8BsTfqfB+6EtdiUpZs
# orh3s2XTDQI/Sh4QvPDeSSisL+a5j2q6yFAqEoMY36YNNFBZ2GG3YCoMpqK7PEag
# Qcrcw+OYArni/x8gjP4FUQvOXBHaviyCiIYXj0s3HpFUPE1sGtYF6BwXN0YgfmFW
# a8kRI1Ze8Q8Y96hLt80rGv16ZtxBxwlaTyPTduuruWiZIBT8Ezbtyzw6FTRAUh0i
# VqWrPgZyJrDpON/OL79MsoWj0XKtZzL3q0VEYbzduaR1E4z+UBguaY5V8Omhhoxl
# yhLMHB+KF5jynp/kFh28N9Exs9hY4kTa7A+ZOtS5M6GCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQ0MTNaMD8GCSqG
# SIb3DQEJBDEyBDDV+k+Yb1YGGdMB49cHXLpvW/GOOIj4wuPdSoczMNHFWASy7zME
# 0J4lk4LHJUWtBnowDQYJKoZIhvcNAQEBBQAEggIAT/F4Q76owDtD1dPqHWx0k/Ve
# tGtaAqcnn64eB4YcvuvocWwPPtqCZg/VipIDK1HquNZl/dka6KdCW/oESqTQjST4
# haP7BrEYb3BGSZM49s/qAdaXWQKxfOAo/s1+u9tLWYJi8F5ouhrsJDzIXvYzUM8M
# dIxJCxyLzM2kRaZnk8RZRe7kH6shArroYHu4UEI/W2LQTz2msI/P9yBzuAOqYIOs
# cKIMQ54rYnPNEddubAH+4i+sqoZLHZdhRz0WfV8J848ck6olRRZXc1YZ9fEPevv7
# qYHrOsKeC52DNhAaebyRh3G4sKJl3HtB/0/6u6mDnCW8JpBX/VLQy54llJnxC5UC
# 7g7J+/14E7mrrhdVagLGQphDP6sjp9qvLI6JQKGtG6X3lcmxwODo/5o0zKSUfy7L
# rhyCK+aSIUD7GO30RiQDvaP3ORITFjrNasLKT+TjGZkYGnU7AzZ7MYsNUy3X+UhP
# QYcae8rukwAoTEBCkNcjsr7qI4T9LQYau8Cz/MfRe2kzUqjh2HhEIGEGgDTURE48
# bxyqORtyzGCDTAaU3fU/S9MmI272qizmQbFeBJOr8XhRhhQFlYHd/5KgOeMpxGZB
# oJZdntnctk+v6bFj0l2QuVFhcLOtbvB8rmBSfJAayjlukOmmyGs3qD8bGCZ/NpDr
# 69Tn5Nsn3vqa1w4Rt4E=
# SIG # End signature block
