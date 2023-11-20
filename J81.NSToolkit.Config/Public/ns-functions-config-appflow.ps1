function Invoke-NSRenameAppflowaction {
    <#
    .SYNOPSIS
        Rename AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Newname 
        New name for the AppFlow action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowaction item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameAppflowaction -name <string> -newname <string>
        An example how to rename appflowaction config Object(s).
    .NOTES
        File Name : Invoke-NSRenameAppflowaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameAppflowaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("appflowaction", "Rename AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appflowaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowaction -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameAppflowaction: Finished"
    }
}

function Invoke-NSUnsetAppflowaction {
    <#
    .SYNOPSIS
        Unset AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Clientsidemeasurements 
        On enabling this option, the Citrix ADC will collect the time required to load and render the mainpage on the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any comments about this action. In the CLI, if including spaces between words, enclose the comment in quotation marks. (The quotation marks are not required in the configuration utility.). 
    .PARAMETER Pagetracking 
        On enabling this option, the Citrix ADC will start tracking the page for waterfall chart by inserting a NS_ESNS cookie in the response. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Webinsight 
        On enabling this option, the Citrix ADC will send the webinsight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Securityinsight 
        On enabling this option, the Citrix ADC will send the security insight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Botinsight 
        On enabling this option, the Citrix ADC will send the bot insight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ciinsight 
        On enabling this option, the Citrix ADC will send the ContentInspection Insight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Videoanalytics 
        On enabling this option, the Citrix ADC will send the videoinsight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Distributionalgorithm 
        On enabling this option, the Citrix ADC will distribute records among the collectors. Else, all records will be sent to all the collectors. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAppflowaction -name <string>
        An example how to unset appflowaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAppflowaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowaction
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Name,

        [Boolean]$clientsidemeasurements,

        [Boolean]$comment,

        [Boolean]$pagetracking,

        [Boolean]$webinsight,

        [Boolean]$securityinsight,

        [Boolean]$botinsight,

        [Boolean]$ciinsight,

        [Boolean]$videoanalytics,

        [Boolean]$distributionalgorithm 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAppflowaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('clientsidemeasurements') ) { $payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('pagetracking') ) { $payload.Add('pagetracking', $pagetracking) }
            if ( $PSBoundParameters.ContainsKey('webinsight') ) { $payload.Add('webinsight', $webinsight) }
            if ( $PSBoundParameters.ContainsKey('securityinsight') ) { $payload.Add('securityinsight', $securityinsight) }
            if ( $PSBoundParameters.ContainsKey('botinsight') ) { $payload.Add('botinsight', $botinsight) }
            if ( $PSBoundParameters.ContainsKey('ciinsight') ) { $payload.Add('ciinsight', $ciinsight) }
            if ( $PSBoundParameters.ContainsKey('videoanalytics') ) { $payload.Add('videoanalytics', $videoanalytics) }
            if ( $PSBoundParameters.ContainsKey('distributionalgorithm') ) { $payload.Add('distributionalgorithm', $distributionalgorithm) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type appflowaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAppflowaction: Finished"
    }
}

function Invoke-NSDeleteAppflowaction {
    <#
    .SYNOPSIS
        Delete AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAppflowaction -Name <string>
        An example how to delete appflowaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAppflowaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteAppflowaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type appflowaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAppflowaction: Finished"
    }
}

function Invoke-NSUpdateAppflowaction {
    <#
    .SYNOPSIS
        Update AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Collectors 
        Name(s) of collector(s) to be associated with the AppFlow action. 
    .PARAMETER Clientsidemeasurements 
        On enabling this option, the Citrix ADC will collect the time required to load and render the mainpage on the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any comments about this action. In the CLI, if including spaces between words, enclose the comment in quotation marks. (The quotation marks are not required in the configuration utility.). 
    .PARAMETER Pagetracking 
        On enabling this option, the Citrix ADC will start tracking the page for waterfall chart by inserting a NS_ESNS cookie in the response. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Webinsight 
        On enabling this option, the Citrix ADC will send the webinsight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Securityinsight 
        On enabling this option, the Citrix ADC will send the security insight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Botinsight 
        On enabling this option, the Citrix ADC will send the bot insight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ciinsight 
        On enabling this option, the Citrix ADC will send the ContentInspection Insight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Videoanalytics 
        On enabling this option, the Citrix ADC will send the videoinsight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Distributionalgorithm 
        On enabling this option, the Citrix ADC will distribute records among the collectors. Else, all records will be sent to all the collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created appflowaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAppflowaction -name <string>
        An example how to update appflowaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAppflowaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Collectors,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Clientsidemeasurements,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Pagetracking,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Webinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Securityinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Botinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ciinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Videoanalytics,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Distributionalgorithm,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAppflowaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('collectors') ) { $payload.Add('collectors', $collectors) }
            if ( $PSBoundParameters.ContainsKey('clientsidemeasurements') ) { $payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('pagetracking') ) { $payload.Add('pagetracking', $pagetracking) }
            if ( $PSBoundParameters.ContainsKey('webinsight') ) { $payload.Add('webinsight', $webinsight) }
            if ( $PSBoundParameters.ContainsKey('securityinsight') ) { $payload.Add('securityinsight', $securityinsight) }
            if ( $PSBoundParameters.ContainsKey('botinsight') ) { $payload.Add('botinsight', $botinsight) }
            if ( $PSBoundParameters.ContainsKey('ciinsight') ) { $payload.Add('ciinsight', $ciinsight) }
            if ( $PSBoundParameters.ContainsKey('videoanalytics') ) { $payload.Add('videoanalytics', $videoanalytics) }
            if ( $PSBoundParameters.ContainsKey('distributionalgorithm') ) { $payload.Add('distributionalgorithm', $distributionalgorithm) }
            if ( $PSCmdlet.ShouldProcess("appflowaction", "Update AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type appflowaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAppflowaction: Finished"
    }
}

function Invoke-NSAddAppflowaction {
    <#
    .SYNOPSIS
        Add AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Collectors 
        Name(s) of collector(s) to be associated with the AppFlow action. 
    .PARAMETER Clientsidemeasurements 
        On enabling this option, the Citrix ADC will collect the time required to load and render the mainpage on the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pagetracking 
        On enabling this option, the Citrix ADC will start tracking the page for waterfall chart by inserting a NS_ESNS cookie in the response. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Webinsight 
        On enabling this option, the Citrix ADC will send the webinsight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Securityinsight 
        On enabling this option, the Citrix ADC will send the security insight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Botinsight 
        On enabling this option, the Citrix ADC will send the bot insight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ciinsight 
        On enabling this option, the Citrix ADC will send the ContentInspection Insight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Videoanalytics 
        On enabling this option, the Citrix ADC will send the videoinsight records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Distributionalgorithm 
        On enabling this option, the Citrix ADC will distribute records among the collectors. Else, all records will be sent to all the collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Metricslog 
        If only the stats records are to be exported, turn on this option. 
    .PARAMETER Transactionlog 
        Log ANOMALOUS or ALL transactions. 
         
        Possible values = ALL, ANOMALOUS 
    .PARAMETER Comment 
        Any comments about this action. In the CLI, if including spaces between words, enclose the comment in quotation marks. (The quotation marks are not required in the configuration utility.). 
    .PARAMETER PassThru 
        Return details about the created appflowaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAppflowaction -name <string> -collectors <string[]>
        An example how to add appflowaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddAppflowaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Collectors,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Clientsidemeasurements = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Pagetracking = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Webinsight = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Securityinsight = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Botinsight = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ciinsight = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Videoanalytics = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Distributionalgorithm = 'DISABLED',

        [boolean]$Metricslog,

        [ValidateSet('ALL', 'ANOMALOUS')]
        [string]$Transactionlog = 'ALL',

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAppflowaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                collectors     = $collectors
            }
            if ( $PSBoundParameters.ContainsKey('clientsidemeasurements') ) { $payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ( $PSBoundParameters.ContainsKey('pagetracking') ) { $payload.Add('pagetracking', $pagetracking) }
            if ( $PSBoundParameters.ContainsKey('webinsight') ) { $payload.Add('webinsight', $webinsight) }
            if ( $PSBoundParameters.ContainsKey('securityinsight') ) { $payload.Add('securityinsight', $securityinsight) }
            if ( $PSBoundParameters.ContainsKey('botinsight') ) { $payload.Add('botinsight', $botinsight) }
            if ( $PSBoundParameters.ContainsKey('ciinsight') ) { $payload.Add('ciinsight', $ciinsight) }
            if ( $PSBoundParameters.ContainsKey('videoanalytics') ) { $payload.Add('videoanalytics', $videoanalytics) }
            if ( $PSBoundParameters.ContainsKey('distributionalgorithm') ) { $payload.Add('distributionalgorithm', $distributionalgorithm) }
            if ( $PSBoundParameters.ContainsKey('metricslog') ) { $payload.Add('metricslog', $metricslog) }
            if ( $PSBoundParameters.ContainsKey('transactionlog') ) { $payload.Add('transactionlog', $transactionlog) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("appflowaction", "Add AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appflowaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAppflowaction: Finished"
    }
}

function Invoke-NSGetAppflowaction {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all appflowaction object(s).
    .PARAMETER Count
        If specified, the count of the appflowaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowaction -GetAll 
        Get all appflowaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowaction -Count 
        Get the number of appflowaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowaction -name <string>
        Get appflowaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowaction -Filter @{ 'name'='<value>' }
        Get appflowaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowaction/
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
        Write-Verbose "Invoke-NSGetAppflowaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appflowaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowaction: Ended"
    }
}

function Invoke-NSAddAppflowactionAnalyticsprofileBinding {
    <#
    .SYNOPSIS
        Add AppFlow configuration. config Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to appflowaction.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Analyticsprofile 
        Analytics profile to be bound to the appflow action. 
    .PARAMETER PassThru 
        Return details about the created appflowaction_analyticsprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAppflowactionAnalyticsprofileBinding -name <string>
        An example how to add appflowaction_analyticsprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAppflowactionAnalyticsprofileBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowaction_analyticsprofile_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Name,

        [string]$Analyticsprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAppflowactionAnalyticsprofileBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("appflowaction_analyticsprofile_binding", "Add AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type appflowaction_analyticsprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowactionAnalyticsprofileBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAppflowactionAnalyticsprofileBinding: Finished"
    }
}

function Invoke-NSDeleteAppflowactionAnalyticsprofileBinding {
    <#
    .SYNOPSIS
        Delete AppFlow configuration. config Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to appflowaction.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Analyticsprofile 
        Analytics profile to be bound to the appflow action.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAppflowactionAnalyticsprofileBinding -Name <string>
        An example how to delete appflowaction_analyticsprofile_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAppflowactionAnalyticsprofileBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowaction_analyticsprofile_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [string]$Analyticsprofile 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteAppflowactionAnalyticsprofileBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Analyticsprofile') ) { $arguments.Add('analyticsprofile', $Analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAppflowactionAnalyticsprofileBinding: Finished"
    }
}

function Invoke-NSGetAppflowactionAnalyticsprofileBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to appflowaction.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all appflowaction_analyticsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowaction_analyticsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowactionAnalyticsprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowactionAnalyticsprofileBinding -GetAll 
        Get all appflowaction_analyticsprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowactionAnalyticsprofileBinding -Count 
        Get the number of appflowaction_analyticsprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowactionAnalyticsprofileBinding -name <string>
        Get appflowaction_analyticsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowactionAnalyticsprofileBinding -Filter @{ 'name'='<value>' }
        Get appflowaction_analyticsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowactionAnalyticsprofileBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowaction_analyticsprofile_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAppflowactionAnalyticsprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowaction_analyticsprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowaction_analyticsprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowaction_analyticsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowaction_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowaction_analyticsprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowactionAnalyticsprofileBinding: Ended"
    }
}

function Invoke-NSGetAppflowactionBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appflowaction.
    .PARAMETER Name 
        Name of the action about which to display information. 
    .PARAMETER GetAll 
        Retrieve all appflowaction_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowaction_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowactionBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowactionBinding -GetAll 
        Get all appflowaction_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowactionBinding -name <string>
        Get appflowaction_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowactionBinding -Filter @{ 'name'='<value>' }
        Get appflowaction_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowactionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowaction_binding/
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
        Write-Verbose "Invoke-NSGetAppflowactionBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowaction_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowaction_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowaction_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowaction_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowaction_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowaction_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowactionBinding: Ended"
    }
}

function Invoke-NSUnsetAppflowcollector {
    <#
    .SYNOPSIS
        Unset AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured. 
    .PARAMETER Ipaddress 
        IPv4 address of the collector. 
    .PARAMETER Port 
        Port on which the collector listens. 
    .PARAMETER Netprofile 
        Netprofile to associate with the collector. The IP address defined in the profile is used as the source IP address for AppFlow traffic for this collector. If you do not set this parameter, the Citrix ADC IP (NSIP) address is used as the source IP address.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAppflowcollector -name <string>
        An example how to unset appflowcollector config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAppflowcollector
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowcollector
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Name,

        [Boolean]$ipaddress,

        [Boolean]$port,

        [Boolean]$netprofile 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAppflowcollector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type appflowcollector -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAppflowcollector: Finished"
    }
}

function Invoke-NSDeleteAppflowcollector {
    <#
    .SYNOPSIS
        Delete AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAppflowcollector -Name <string>
        An example how to delete appflowcollector config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAppflowcollector
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowcollector/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteAppflowcollector: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type appflowcollector -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAppflowcollector: Finished"
    }
}

function Invoke-NSRenameAppflowcollector {
    <#
    .SYNOPSIS
        Rename AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured. 
    .PARAMETER Newname 
        New name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must 
        contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at(@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowcollector item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameAppflowcollector -name <string> -newname <string>
        An example how to rename appflowcollector config Object(s).
    .NOTES
        File Name : Invoke-NSRenameAppflowcollector
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowcollector/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameAppflowcollector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("appflowcollector", "Rename AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appflowcollector -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowcollector -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameAppflowcollector: Finished"
    }
}

function Invoke-NSUpdateAppflowcollector {
    <#
    .SYNOPSIS
        Update AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured. 
    .PARAMETER Ipaddress 
        IPv4 address of the collector. 
    .PARAMETER Port 
        Port on which the collector listens. 
    .PARAMETER Netprofile 
        Netprofile to associate with the collector. The IP address defined in the profile is used as the source IP address for AppFlow traffic for this collector. If you do not set this parameter, the Citrix ADC IP (NSIP) address is used as the source IP address. 
    .PARAMETER PassThru 
        Return details about the created appflowcollector item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAppflowcollector -name <string>
        An example how to update appflowcollector config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAppflowcollector
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowcollector/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Name,

        [string]$Ipaddress,

        [int]$Port,

        [string]$Netprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAppflowcollector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSCmdlet.ShouldProcess("appflowcollector", "Update AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type appflowcollector -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowcollector -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAppflowcollector: Finished"
    }
}

function Invoke-NSAddAppflowcollector {
    <#
    .SYNOPSIS
        Add AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured. 
    .PARAMETER Ipaddress 
        IPv4 address of the collector. 
    .PARAMETER Port 
        Port on which the collector listens. 
    .PARAMETER Netprofile 
        Netprofile to associate with the collector. The IP address defined in the profile is used as the source IP address for AppFlow traffic for this collector. If you do not set this parameter, the Citrix ADC IP (NSIP) address is used as the source IP address. 
    .PARAMETER Transport 
        Type of collector: either logstream or ipfix or rest. 
         
        Possible values = ipfix, logstream, rest 
    .PARAMETER PassThru 
        Return details about the created appflowcollector item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAppflowcollector -name <string> -ipaddress <string>
        An example how to add appflowcollector config Object(s).
    .NOTES
        File Name : Invoke-NSAddAppflowcollector
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowcollector/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Ipaddress,

        [int]$Port,

        [string]$Netprofile,

        [ValidateSet('ipfix', 'logstream', 'rest')]
        [string]$Transport = 'ipfix',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAppflowcollector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                ipaddress      = $ipaddress
            }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('transport') ) { $payload.Add('transport', $transport) }
            if ( $PSCmdlet.ShouldProcess("appflowcollector", "Add AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appflowcollector -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowcollector -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAppflowcollector: Finished"
    }
}

function Invoke-NSGetAppflowcollector {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured. 
    .PARAMETER GetAll 
        Retrieve all appflowcollector object(s).
    .PARAMETER Count
        If specified, the count of the appflowcollector object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowcollector
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowcollector -GetAll 
        Get all appflowcollector data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowcollector -Count 
        Get the number of appflowcollector objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowcollector -name <string>
        Get appflowcollector object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowcollector -Filter @{ 'name'='<value>' }
        Get appflowcollector data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowcollector
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowcollector/
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
        Write-Verbose "Invoke-NSGetAppflowcollector: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appflowcollector objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowcollector -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowcollector objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowcollector -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowcollector objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowcollector -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowcollector configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowcollector -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowcollector configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowcollector -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowcollector: Ended"
    }
}

function Invoke-NSAddAppflowglobalAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Add AppFlow configuration. config Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowglobal.
    .PARAMETER Policyname 
        Name of the AppFlow policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Global bind point for which to show detailed information about the policies bound to the bind point. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, OVERRIDE, DEFAULT, OTHERTCP_REQ_OVERRIDE, OTHERTCP_REQ_DEFAULT, MSSQL_REQ_OVERRIDE, MSSQL_REQ_DEFAULT, MYSQL_REQ_OVERRIDE, MYSQL_REQ_DEFAULT, ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT, ORACLE_REQ_OVERRIDE, ORACLE_REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Specify vserver for a policy label associated with a virtual server, or policylabel for a user-defined policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to invoke if the current policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created appflowglobal_appflowpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAppflowglobalAppflowpolicyBinding -policyname <string> -priority <double>
        An example how to add appflowglobal_appflowpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAppflowglobalAppflowpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowglobal_appflowpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'OVERRIDE', 'DEFAULT', 'OTHERTCP_REQ_OVERRIDE', 'OTHERTCP_REQ_DEFAULT', 'MSSQL_REQ_OVERRIDE', 'MSSQL_REQ_DEFAULT', 'MYSQL_REQ_OVERRIDE', 'MYSQL_REQ_DEFAULT', 'ICA_REQ_OVERRIDE', 'ICA_REQ_DEFAULT', 'ORACLE_REQ_OVERRIDE', 'ORACLE_REQ_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAppflowglobalAppflowpolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("appflowglobal_appflowpolicy_binding", "Add AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type appflowglobal_appflowpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowglobalAppflowpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAppflowglobalAppflowpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAppflowglobalAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Delete AppFlow configuration. config Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowglobal.
    .PARAMETER Policyname 
        Name of the AppFlow policy. 
    .PARAMETER Type 
        Global bind point for which to show detailed information about the policies bound to the bind point. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, OVERRIDE, DEFAULT, OTHERTCP_REQ_OVERRIDE, OTHERTCP_REQ_DEFAULT, MSSQL_REQ_OVERRIDE, MSSQL_REQ_DEFAULT, MYSQL_REQ_OVERRIDE, MYSQL_REQ_DEFAULT, ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT, ORACLE_REQ_OVERRIDE, ORACLE_REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAppflowglobalAppflowpolicyBinding 
        An example how to delete appflowglobal_appflowpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAppflowglobalAppflowpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowglobal_appflowpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteAppflowglobalAppflowpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("appflowglobal_appflowpolicy_binding", "Delete AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type appflowglobal_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAppflowglobalAppflowpolicyBinding: Finished"
    }
}

function Invoke-NSGetAppflowglobalAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowglobal.
    .PARAMETER Type 
        Global bind point for which to show detailed information about the policies bound to the bind point. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, OVERRIDE, DEFAULT, OTHERTCP_REQ_OVERRIDE, OTHERTCP_REQ_DEFAULT, MSSQL_REQ_OVERRIDE, MSSQL_REQ_DEFAULT, MYSQL_REQ_OVERRIDE, MYSQL_REQ_DEFAULT, ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT, ORACLE_REQ_OVERRIDE, ORACLE_REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT 
    .PARAMETER GetAll 
        Retrieve all appflowglobal_appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowglobal_appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowglobalAppflowpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowglobalAppflowpolicyBinding -GetAll 
        Get all appflowglobal_appflowpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowglobalAppflowpolicyBinding -Count 
        Get the number of appflowglobal_appflowpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowglobalAppflowpolicyBinding -name <string>
        Get appflowglobal_appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowglobalAppflowpolicyBinding -Filter @{ 'name'='<value>' }
        Get appflowglobal_appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowglobalAppflowpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowglobal_appflowpolicy_binding/
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
        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'OVERRIDE', 'DEFAULT', 'OTHERTCP_REQ_OVERRIDE', 'OTHERTCP_REQ_DEFAULT', 'MSSQL_REQ_OVERRIDE', 'MSSQL_REQ_DEFAULT', 'MYSQL_REQ_OVERRIDE', 'MYSQL_REQ_DEFAULT', 'ICA_REQ_OVERRIDE', 'ICA_REQ_DEFAULT', 'ORACLE_REQ_OVERRIDE', 'ORACLE_REQ_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT')]
        [string]$Type,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetAppflowglobalAppflowpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowglobal_appflowpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowglobal_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowglobal_appflowpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowglobal_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowglobal_appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowglobal_appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowglobal_appflowpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appflowglobal_appflowpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowglobal_appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowglobalAppflowpolicyBinding: Ended"
    }
}

function Invoke-NSGetAppflowglobalBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appflowglobal.
    .PARAMETER GetAll 
        Retrieve all appflowglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowglobalBinding -GetAll 
        Get all appflowglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowglobalBinding -name <string>
        Get appflowglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowglobalBinding -Filter @{ 'name'='<value>' }
        Get appflowglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowglobal_binding/
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
        Write-Verbose "Invoke-NSGetAppflowglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appflowglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowglobalBinding: Ended"
    }
}

function Invoke-NSUnsetAppflowparam {
    <#
    .SYNOPSIS
        Unset AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow parameter resource.
    .PARAMETER Templaterefresh 
        Refresh interval, in seconds, at which to export the template data. Because data transmission is in UDP, the templates must be resent at regular intervals. 
         
         
        Maximum value = 3600 
    .PARAMETER Appnamerefresh 
        Interval, in seconds, at which to send Appnames to the configured collectors. Appname refers to the name of an entity (virtual server, service, or service group) in the Citrix ADC. 
         
         
        Maximum value = 3600 
    .PARAMETER Flowrecordinterval 
        Interval, in seconds, at which to send flow records to the configured collectors. 
         
         
        Maximum value = 3600 
    .PARAMETER Securityinsightrecordinterval 
        Interval, in seconds, at which to send security insight flow records to the configured collectors. 
         
         
        Maximum value = 3600 
    .PARAMETER Udppmtu 
        MTU, in bytes, for IPFIX UDP packets. 
         
         
        Maximum value = 1472 
    .PARAMETER Httpurl 
        Include the http URL that the Citrix ADC received from the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Aaausername 
        Enable AppFlow AAA Username logging. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpcookie 
        Include the cookie that was in the HTTP request the appliance received from the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpreferer 
        Include the web page that was last visited by the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpmethod 
        Include the method that was specified in the HTTP request that the appliance received from the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httphost 
        Include the host identified in the HTTP request that the appliance received from the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpuseragent 
        Include the client application through which the HTTP request was received by the Citrix ADC. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Clienttrafficonly 
        Generate AppFlow records for only the traffic from the client. 
         
        Possible values = YES, NO 
    .PARAMETER Httpcontenttype 
        Include the HTTP Content-Type header sent from the server to the client to determine the type of the content sent. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpauthorization 
        Include the HTTP Authorization header information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpvia 
        Include the httpVia header which contains the IP address of proxy server through which the client accessed the server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpxforwardedfor 
        Include the httpXForwardedFor header, which contains the original IP Address of the client using a proxy server to access the server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httplocation 
        Include the HTTP location headers returned from the HTTP responses. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie 
        Include the Set-cookie header sent from the server to the client in response to a HTTP request. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie2 
        Include the Set-cookie header sent from the server to the client in response to a HTTP request. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Connectionchaining 
        Enable connection chaining so that the client server flows of a connection are linked. Also the connection chain ID is propagated across Citrix ADCs, so that in a multi-hop environment the flows belonging to the same logical connection are linked. This id is also logged as part of appflow record. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpdomain 
        Include the http domain request to be exported. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Skipcacheredirectionhttptransaction 
        Skip Cache http transaction. This HTTP transaction is specific to Cache Redirection module. In Case of Cache Miss there will be another HTTP transaction initiated by the cache server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Identifiername 
        Include the stream identifier name to be exported. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Identifiersessionname 
        Include the stream identifier session name to be exported. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Observationdomainid 
        An observation domain groups a set of Citrix ADCs based on deployment: cluster, HA etc. A unique Observation Domain ID is required to be assigned to each such group. 
    .PARAMETER Observationdomainname 
        Name of the Observation Domain defined by the observation domain ID. 
    .PARAMETER Subscriberawareness 
        Enable this option for logging end user MSISDN in L4/L7 appflow records. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberidobfuscation 
        Enable this option for obfuscating MSISDN in L4/L7 appflow records. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberidobfuscationalgo 
        Algorithm(MD5 or SHA256) to be used for obfuscating MSISDN. 
         
        Possible values = MD5, SHA256 
    .PARAMETER Gxsessionreporting 
        Enable this option for Gx session reporting. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Securityinsighttraffic 
        Enable/disable the feature individually on appflow action. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacheinsight 
        Flag to determine whether cache records need to be exported or not. If this flag is true and IC is enabled, cache records are exported instead of L7 HTTP records. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Videoinsight 
        Enable/disable the feature individually on appflow action. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpquerywithurl 
        Include the HTTP query segment along with the URL that the Citrix ADC received from the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlcategory 
        Include the URL category record. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsnlogging 
        On enabling this option, the Citrix ADC will send the Large Scale Nat(LSN) records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cqareporting 
        TCP CQA reporting enable/disable knob. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Emailaddress 
        Enable AppFlow user email-id logging. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Usagerecordinterval 
        On enabling this option, the NGS will send bandwidth usage record to configured collectors. 
         
         
        Maximum value = 7200 
    .PARAMETER Websaasappusagereporting 
        On enabling this option, NGS will send data used by Web/saas app at the end of every HTTP transaction to configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Metrics 
        Enable Citrix ADC Stats to be sent to the Telemetry Agent. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Events 
        Enable Events to be sent to the Telemetry Agent. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Auditlogs 
        Enable Auditlogs to be sent to the Telemetry Agent. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Observationpointid 
        An observation point ID is identifier for the NetScaler from which appflow records are being exported. By default, the NetScaler IP is the observation point ID. 
    .PARAMETER Distributedtracing 
        Enable generation of the distributed tracing templates in the Appflow records. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disttracingsamplingrate 
        Sampling rate for Distributed Tracing. 
         
         
        Maximum value = 100 
    .PARAMETER Tcpattackcounterinterval 
        Interval, in seconds, at which to send tcp attack counters to the configured collectors. If 0 is configured, the record is not sent. 
         
         
        Maximum value = 3600 
    .PARAMETER Logstreamovernsip 
        To use the Citrix ADC IP to send Logstream records instead of the SNIP. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Analyticsauthtoken 
        Authentication token to be set by the agent. 
    .PARAMETER Timeseriesovernsip 
        To use the Citrix ADC IP to send Time series data such as metrics and events, instead of the SNIP. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAppflowparam 
        An example how to unset appflowparam config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAppflowparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowparam
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$templaterefresh,

        [Boolean]$appnamerefresh,

        [Boolean]$flowrecordinterval,

        [Boolean]$securityinsightrecordinterval,

        [Boolean]$udppmtu,

        [Boolean]$httpurl,

        [Boolean]$aaausername,

        [Boolean]$httpcookie,

        [Boolean]$httpreferer,

        [Boolean]$httpmethod,

        [Boolean]$httphost,

        [Boolean]$httpuseragent,

        [Boolean]$clienttrafficonly,

        [Boolean]$httpcontenttype,

        [Boolean]$httpauthorization,

        [Boolean]$httpvia,

        [Boolean]$httpxforwardedfor,

        [Boolean]$httplocation,

        [Boolean]$httpsetcookie,

        [Boolean]$httpsetcookie2,

        [Boolean]$connectionchaining,

        [Boolean]$httpdomain,

        [Boolean]$skipcacheredirectionhttptransaction,

        [Boolean]$identifiername,

        [Boolean]$identifiersessionname,

        [Boolean]$observationdomainid,

        [Boolean]$observationdomainname,

        [Boolean]$subscriberawareness,

        [Boolean]$subscriberidobfuscation,

        [Boolean]$subscriberidobfuscationalgo,

        [Boolean]$gxsessionreporting,

        [Boolean]$securityinsighttraffic,

        [Boolean]$cacheinsight,

        [Boolean]$videoinsight,

        [Boolean]$httpquerywithurl,

        [Boolean]$urlcategory,

        [Boolean]$lsnlogging,

        [Boolean]$cqareporting,

        [Boolean]$emailaddress,

        [Boolean]$usagerecordinterval,

        [Boolean]$websaasappusagereporting,

        [Boolean]$metrics,

        [Boolean]$events,

        [Boolean]$auditlogs,

        [Boolean]$observationpointid,

        [Boolean]$distributedtracing,

        [Boolean]$disttracingsamplingrate,

        [Boolean]$tcpattackcounterinterval,

        [Boolean]$logstreamovernsip,

        [Boolean]$analyticsauthtoken,

        [Boolean]$timeseriesovernsip 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAppflowparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('templaterefresh') ) { $payload.Add('templaterefresh', $templaterefresh) }
            if ( $PSBoundParameters.ContainsKey('appnamerefresh') ) { $payload.Add('appnamerefresh', $appnamerefresh) }
            if ( $PSBoundParameters.ContainsKey('flowrecordinterval') ) { $payload.Add('flowrecordinterval', $flowrecordinterval) }
            if ( $PSBoundParameters.ContainsKey('securityinsightrecordinterval') ) { $payload.Add('securityinsightrecordinterval', $securityinsightrecordinterval) }
            if ( $PSBoundParameters.ContainsKey('udppmtu') ) { $payload.Add('udppmtu', $udppmtu) }
            if ( $PSBoundParameters.ContainsKey('httpurl') ) { $payload.Add('httpurl', $httpurl) }
            if ( $PSBoundParameters.ContainsKey('aaausername') ) { $payload.Add('aaausername', $aaausername) }
            if ( $PSBoundParameters.ContainsKey('httpcookie') ) { $payload.Add('httpcookie', $httpcookie) }
            if ( $PSBoundParameters.ContainsKey('httpreferer') ) { $payload.Add('httpreferer', $httpreferer) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('httphost') ) { $payload.Add('httphost', $httphost) }
            if ( $PSBoundParameters.ContainsKey('httpuseragent') ) { $payload.Add('httpuseragent', $httpuseragent) }
            if ( $PSBoundParameters.ContainsKey('clienttrafficonly') ) { $payload.Add('clienttrafficonly', $clienttrafficonly) }
            if ( $PSBoundParameters.ContainsKey('httpcontenttype') ) { $payload.Add('httpcontenttype', $httpcontenttype) }
            if ( $PSBoundParameters.ContainsKey('httpauthorization') ) { $payload.Add('httpauthorization', $httpauthorization) }
            if ( $PSBoundParameters.ContainsKey('httpvia') ) { $payload.Add('httpvia', $httpvia) }
            if ( $PSBoundParameters.ContainsKey('httpxforwardedfor') ) { $payload.Add('httpxforwardedfor', $httpxforwardedfor) }
            if ( $PSBoundParameters.ContainsKey('httplocation') ) { $payload.Add('httplocation', $httplocation) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie') ) { $payload.Add('httpsetcookie', $httpsetcookie) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie2') ) { $payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ( $PSBoundParameters.ContainsKey('connectionchaining') ) { $payload.Add('connectionchaining', $connectionchaining) }
            if ( $PSBoundParameters.ContainsKey('httpdomain') ) { $payload.Add('httpdomain', $httpdomain) }
            if ( $PSBoundParameters.ContainsKey('skipcacheredirectionhttptransaction') ) { $payload.Add('skipcacheredirectionhttptransaction', $skipcacheredirectionhttptransaction) }
            if ( $PSBoundParameters.ContainsKey('identifiername') ) { $payload.Add('identifiername', $identifiername) }
            if ( $PSBoundParameters.ContainsKey('identifiersessionname') ) { $payload.Add('identifiersessionname', $identifiersessionname) }
            if ( $PSBoundParameters.ContainsKey('observationdomainid') ) { $payload.Add('observationdomainid', $observationdomainid) }
            if ( $PSBoundParameters.ContainsKey('observationdomainname') ) { $payload.Add('observationdomainname', $observationdomainname) }
            if ( $PSBoundParameters.ContainsKey('subscriberawareness') ) { $payload.Add('subscriberawareness', $subscriberawareness) }
            if ( $PSBoundParameters.ContainsKey('subscriberidobfuscation') ) { $payload.Add('subscriberidobfuscation', $subscriberidobfuscation) }
            if ( $PSBoundParameters.ContainsKey('subscriberidobfuscationalgo') ) { $payload.Add('subscriberidobfuscationalgo', $subscriberidobfuscationalgo) }
            if ( $PSBoundParameters.ContainsKey('gxsessionreporting') ) { $payload.Add('gxsessionreporting', $gxsessionreporting) }
            if ( $PSBoundParameters.ContainsKey('securityinsighttraffic') ) { $payload.Add('securityinsighttraffic', $securityinsighttraffic) }
            if ( $PSBoundParameters.ContainsKey('cacheinsight') ) { $payload.Add('cacheinsight', $cacheinsight) }
            if ( $PSBoundParameters.ContainsKey('videoinsight') ) { $payload.Add('videoinsight', $videoinsight) }
            if ( $PSBoundParameters.ContainsKey('httpquerywithurl') ) { $payload.Add('httpquerywithurl', $httpquerywithurl) }
            if ( $PSBoundParameters.ContainsKey('urlcategory') ) { $payload.Add('urlcategory', $urlcategory) }
            if ( $PSBoundParameters.ContainsKey('lsnlogging') ) { $payload.Add('lsnlogging', $lsnlogging) }
            if ( $PSBoundParameters.ContainsKey('cqareporting') ) { $payload.Add('cqareporting', $cqareporting) }
            if ( $PSBoundParameters.ContainsKey('emailaddress') ) { $payload.Add('emailaddress', $emailaddress) }
            if ( $PSBoundParameters.ContainsKey('usagerecordinterval') ) { $payload.Add('usagerecordinterval', $usagerecordinterval) }
            if ( $PSBoundParameters.ContainsKey('websaasappusagereporting') ) { $payload.Add('websaasappusagereporting', $websaasappusagereporting) }
            if ( $PSBoundParameters.ContainsKey('metrics') ) { $payload.Add('metrics', $metrics) }
            if ( $PSBoundParameters.ContainsKey('events') ) { $payload.Add('events', $events) }
            if ( $PSBoundParameters.ContainsKey('auditlogs') ) { $payload.Add('auditlogs', $auditlogs) }
            if ( $PSBoundParameters.ContainsKey('observationpointid') ) { $payload.Add('observationpointid', $observationpointid) }
            if ( $PSBoundParameters.ContainsKey('distributedtracing') ) { $payload.Add('distributedtracing', $distributedtracing) }
            if ( $PSBoundParameters.ContainsKey('disttracingsamplingrate') ) { $payload.Add('disttracingsamplingrate', $disttracingsamplingrate) }
            if ( $PSBoundParameters.ContainsKey('tcpattackcounterinterval') ) { $payload.Add('tcpattackcounterinterval', $tcpattackcounterinterval) }
            if ( $PSBoundParameters.ContainsKey('logstreamovernsip') ) { $payload.Add('logstreamovernsip', $logstreamovernsip) }
            if ( $PSBoundParameters.ContainsKey('analyticsauthtoken') ) { $payload.Add('analyticsauthtoken', $analyticsauthtoken) }
            if ( $PSBoundParameters.ContainsKey('timeseriesovernsip') ) { $payload.Add('timeseriesovernsip', $timeseriesovernsip) }
            if ( $PSCmdlet.ShouldProcess("appflowparam", "Unset AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type appflowparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAppflowparam: Finished"
    }
}

function Invoke-NSUpdateAppflowparam {
    <#
    .SYNOPSIS
        Update AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow parameter resource.
    .PARAMETER Templaterefresh 
        Refresh interval, in seconds, at which to export the template data. Because data transmission is in UDP, the templates must be resent at regular intervals. 
         
         
        Maximum value = 3600 
    .PARAMETER Appnamerefresh 
        Interval, in seconds, at which to send Appnames to the configured collectors. Appname refers to the name of an entity (virtual server, service, or service group) in the Citrix ADC. 
         
         
        Maximum value = 3600 
    .PARAMETER Flowrecordinterval 
        Interval, in seconds, at which to send flow records to the configured collectors. 
         
         
        Maximum value = 3600 
    .PARAMETER Securityinsightrecordinterval 
        Interval, in seconds, at which to send security insight flow records to the configured collectors. 
         
         
        Maximum value = 3600 
    .PARAMETER Udppmtu 
        MTU, in bytes, for IPFIX UDP packets. 
         
         
        Maximum value = 1472 
    .PARAMETER Httpurl 
        Include the http URL that the Citrix ADC received from the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Aaausername 
        Enable AppFlow AAA Username logging. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpcookie 
        Include the cookie that was in the HTTP request the appliance received from the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpreferer 
        Include the web page that was last visited by the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpmethod 
        Include the method that was specified in the HTTP request that the appliance received from the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httphost 
        Include the host identified in the HTTP request that the appliance received from the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpuseragent 
        Include the client application through which the HTTP request was received by the Citrix ADC. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Clienttrafficonly 
        Generate AppFlow records for only the traffic from the client. 
         
        Possible values = YES, NO 
    .PARAMETER Httpcontenttype 
        Include the HTTP Content-Type header sent from the server to the client to determine the type of the content sent. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpauthorization 
        Include the HTTP Authorization header information. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpvia 
        Include the httpVia header which contains the IP address of proxy server through which the client accessed the server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpxforwardedfor 
        Include the httpXForwardedFor header, which contains the original IP Address of the client using a proxy server to access the server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httplocation 
        Include the HTTP location headers returned from the HTTP responses. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie 
        Include the Set-cookie header sent from the server to the client in response to a HTTP request. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie2 
        Include the Set-cookie header sent from the server to the client in response to a HTTP request. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Connectionchaining 
        Enable connection chaining so that the client server flows of a connection are linked. Also the connection chain ID is propagated across Citrix ADCs, so that in a multi-hop environment the flows belonging to the same logical connection are linked. This id is also logged as part of appflow record. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpdomain 
        Include the http domain request to be exported. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Skipcacheredirectionhttptransaction 
        Skip Cache http transaction. This HTTP transaction is specific to Cache Redirection module. In Case of Cache Miss there will be another HTTP transaction initiated by the cache server. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Identifiername 
        Include the stream identifier name to be exported. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Identifiersessionname 
        Include the stream identifier session name to be exported. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Observationdomainid 
        An observation domain groups a set of Citrix ADCs based on deployment: cluster, HA etc. A unique Observation Domain ID is required to be assigned to each such group. 
    .PARAMETER Observationdomainname 
        Name of the Observation Domain defined by the observation domain ID. 
    .PARAMETER Subscriberawareness 
        Enable this option for logging end user MSISDN in L4/L7 appflow records. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberidobfuscation 
        Enable this option for obfuscating MSISDN in L4/L7 appflow records. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberidobfuscationalgo 
        Algorithm(MD5 or SHA256) to be used for obfuscating MSISDN. 
         
        Possible values = MD5, SHA256 
    .PARAMETER Gxsessionreporting 
        Enable this option for Gx session reporting. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Securityinsighttraffic 
        Enable/disable the feature individually on appflow action. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacheinsight 
        Flag to determine whether cache records need to be exported or not. If this flag is true and IC is enabled, cache records are exported instead of L7 HTTP records. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Videoinsight 
        Enable/disable the feature individually on appflow action. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpquerywithurl 
        Include the HTTP query segment along with the URL that the Citrix ADC received from the client. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlcategory 
        Include the URL category record. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsnlogging 
        On enabling this option, the Citrix ADC will send the Large Scale Nat(LSN) records to the configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cqareporting 
        TCP CQA reporting enable/disable knob. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Emailaddress 
        Enable AppFlow user email-id logging. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Usagerecordinterval 
        On enabling this option, the NGS will send bandwidth usage record to configured collectors. 
         
         
        Maximum value = 7200 
    .PARAMETER Websaasappusagereporting 
        On enabling this option, NGS will send data used by Web/saas app at the end of every HTTP transaction to configured collectors. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Metrics 
        Enable Citrix ADC Stats to be sent to the Telemetry Agent. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Events 
        Enable Events to be sent to the Telemetry Agent. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Auditlogs 
        Enable Auditlogs to be sent to the Telemetry Agent. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Observationpointid 
        An observation point ID is identifier for the NetScaler from which appflow records are being exported. By default, the NetScaler IP is the observation point ID. 
    .PARAMETER Distributedtracing 
        Enable generation of the distributed tracing templates in the Appflow records. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disttracingsamplingrate 
        Sampling rate for Distributed Tracing. 
         
         
        Maximum value = 100 
    .PARAMETER Tcpattackcounterinterval 
        Interval, in seconds, at which to send tcp attack counters to the configured collectors. If 0 is configured, the record is not sent. 
         
         
        Maximum value = 3600 
    .PARAMETER Logstreamovernsip 
        To use the Citrix ADC IP to send Logstream records instead of the SNIP. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Analyticsauthtoken 
        Authentication token to be set by the agent. 
    .PARAMETER Timeseriesovernsip 
        To use the Citrix ADC IP to send Time series data such as metrics and events, instead of the SNIP. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAppflowparam 
        An example how to update appflowparam config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAppflowparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowparam/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [double]$Templaterefresh,

        [double]$Appnamerefresh,

        [double]$Flowrecordinterval,

        [double]$Securityinsightrecordinterval,

        [double]$Udppmtu,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpurl,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Aaausername,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpcookie,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpreferer,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpmethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httphost,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpuseragent,

        [ValidateSet('YES', 'NO')]
        [string]$Clienttrafficonly,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpcontenttype,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpauthorization,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpvia,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpxforwardedfor,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httplocation,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpsetcookie,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpsetcookie2,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Connectionchaining,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpdomain,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Skipcacheredirectionhttptransaction,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Identifiername,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Identifiersessionname,

        [double]$Observationdomainid,

        [string]$Observationdomainname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberawareness,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberidobfuscation,

        [ValidateSet('MD5', 'SHA256')]
        [string]$Subscriberidobfuscationalgo,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Gxsessionreporting,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Securityinsighttraffic,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacheinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Videoinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpquerywithurl,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlcategory,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsnlogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cqareporting,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Emailaddress,

        [double]$Usagerecordinterval,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Websaasappusagereporting,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Metrics,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Events,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Auditlogs,

        [double]$Observationpointid,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Distributedtracing,

        [double]$Disttracingsamplingrate,

        [double]$Tcpattackcounterinterval,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logstreamovernsip,

        [string]$Analyticsauthtoken,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Timeseriesovernsip 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAppflowparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('templaterefresh') ) { $payload.Add('templaterefresh', $templaterefresh) }
            if ( $PSBoundParameters.ContainsKey('appnamerefresh') ) { $payload.Add('appnamerefresh', $appnamerefresh) }
            if ( $PSBoundParameters.ContainsKey('flowrecordinterval') ) { $payload.Add('flowrecordinterval', $flowrecordinterval) }
            if ( $PSBoundParameters.ContainsKey('securityinsightrecordinterval') ) { $payload.Add('securityinsightrecordinterval', $securityinsightrecordinterval) }
            if ( $PSBoundParameters.ContainsKey('udppmtu') ) { $payload.Add('udppmtu', $udppmtu) }
            if ( $PSBoundParameters.ContainsKey('httpurl') ) { $payload.Add('httpurl', $httpurl) }
            if ( $PSBoundParameters.ContainsKey('aaausername') ) { $payload.Add('aaausername', $aaausername) }
            if ( $PSBoundParameters.ContainsKey('httpcookie') ) { $payload.Add('httpcookie', $httpcookie) }
            if ( $PSBoundParameters.ContainsKey('httpreferer') ) { $payload.Add('httpreferer', $httpreferer) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('httphost') ) { $payload.Add('httphost', $httphost) }
            if ( $PSBoundParameters.ContainsKey('httpuseragent') ) { $payload.Add('httpuseragent', $httpuseragent) }
            if ( $PSBoundParameters.ContainsKey('clienttrafficonly') ) { $payload.Add('clienttrafficonly', $clienttrafficonly) }
            if ( $PSBoundParameters.ContainsKey('httpcontenttype') ) { $payload.Add('httpcontenttype', $httpcontenttype) }
            if ( $PSBoundParameters.ContainsKey('httpauthorization') ) { $payload.Add('httpauthorization', $httpauthorization) }
            if ( $PSBoundParameters.ContainsKey('httpvia') ) { $payload.Add('httpvia', $httpvia) }
            if ( $PSBoundParameters.ContainsKey('httpxforwardedfor') ) { $payload.Add('httpxforwardedfor', $httpxforwardedfor) }
            if ( $PSBoundParameters.ContainsKey('httplocation') ) { $payload.Add('httplocation', $httplocation) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie') ) { $payload.Add('httpsetcookie', $httpsetcookie) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie2') ) { $payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ( $PSBoundParameters.ContainsKey('connectionchaining') ) { $payload.Add('connectionchaining', $connectionchaining) }
            if ( $PSBoundParameters.ContainsKey('httpdomain') ) { $payload.Add('httpdomain', $httpdomain) }
            if ( $PSBoundParameters.ContainsKey('skipcacheredirectionhttptransaction') ) { $payload.Add('skipcacheredirectionhttptransaction', $skipcacheredirectionhttptransaction) }
            if ( $PSBoundParameters.ContainsKey('identifiername') ) { $payload.Add('identifiername', $identifiername) }
            if ( $PSBoundParameters.ContainsKey('identifiersessionname') ) { $payload.Add('identifiersessionname', $identifiersessionname) }
            if ( $PSBoundParameters.ContainsKey('observationdomainid') ) { $payload.Add('observationdomainid', $observationdomainid) }
            if ( $PSBoundParameters.ContainsKey('observationdomainname') ) { $payload.Add('observationdomainname', $observationdomainname) }
            if ( $PSBoundParameters.ContainsKey('subscriberawareness') ) { $payload.Add('subscriberawareness', $subscriberawareness) }
            if ( $PSBoundParameters.ContainsKey('subscriberidobfuscation') ) { $payload.Add('subscriberidobfuscation', $subscriberidobfuscation) }
            if ( $PSBoundParameters.ContainsKey('subscriberidobfuscationalgo') ) { $payload.Add('subscriberidobfuscationalgo', $subscriberidobfuscationalgo) }
            if ( $PSBoundParameters.ContainsKey('gxsessionreporting') ) { $payload.Add('gxsessionreporting', $gxsessionreporting) }
            if ( $PSBoundParameters.ContainsKey('securityinsighttraffic') ) { $payload.Add('securityinsighttraffic', $securityinsighttraffic) }
            if ( $PSBoundParameters.ContainsKey('cacheinsight') ) { $payload.Add('cacheinsight', $cacheinsight) }
            if ( $PSBoundParameters.ContainsKey('videoinsight') ) { $payload.Add('videoinsight', $videoinsight) }
            if ( $PSBoundParameters.ContainsKey('httpquerywithurl') ) { $payload.Add('httpquerywithurl', $httpquerywithurl) }
            if ( $PSBoundParameters.ContainsKey('urlcategory') ) { $payload.Add('urlcategory', $urlcategory) }
            if ( $PSBoundParameters.ContainsKey('lsnlogging') ) { $payload.Add('lsnlogging', $lsnlogging) }
            if ( $PSBoundParameters.ContainsKey('cqareporting') ) { $payload.Add('cqareporting', $cqareporting) }
            if ( $PSBoundParameters.ContainsKey('emailaddress') ) { $payload.Add('emailaddress', $emailaddress) }
            if ( $PSBoundParameters.ContainsKey('usagerecordinterval') ) { $payload.Add('usagerecordinterval', $usagerecordinterval) }
            if ( $PSBoundParameters.ContainsKey('websaasappusagereporting') ) { $payload.Add('websaasappusagereporting', $websaasappusagereporting) }
            if ( $PSBoundParameters.ContainsKey('metrics') ) { $payload.Add('metrics', $metrics) }
            if ( $PSBoundParameters.ContainsKey('events') ) { $payload.Add('events', $events) }
            if ( $PSBoundParameters.ContainsKey('auditlogs') ) { $payload.Add('auditlogs', $auditlogs) }
            if ( $PSBoundParameters.ContainsKey('observationpointid') ) { $payload.Add('observationpointid', $observationpointid) }
            if ( $PSBoundParameters.ContainsKey('distributedtracing') ) { $payload.Add('distributedtracing', $distributedtracing) }
            if ( $PSBoundParameters.ContainsKey('disttracingsamplingrate') ) { $payload.Add('disttracingsamplingrate', $disttracingsamplingrate) }
            if ( $PSBoundParameters.ContainsKey('tcpattackcounterinterval') ) { $payload.Add('tcpattackcounterinterval', $tcpattackcounterinterval) }
            if ( $PSBoundParameters.ContainsKey('logstreamovernsip') ) { $payload.Add('logstreamovernsip', $logstreamovernsip) }
            if ( $PSBoundParameters.ContainsKey('analyticsauthtoken') ) { $payload.Add('analyticsauthtoken', $analyticsauthtoken) }
            if ( $PSBoundParameters.ContainsKey('timeseriesovernsip') ) { $payload.Add('timeseriesovernsip', $timeseriesovernsip) }
            if ( $PSCmdlet.ShouldProcess("appflowparam", "Update AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type appflowparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateAppflowparam: Finished"
    }
}

function Invoke-NSGetAppflowparam {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Configuration for AppFlow parameter resource.
    .PARAMETER GetAll 
        Retrieve all appflowparam object(s).
    .PARAMETER Count
        If specified, the count of the appflowparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowparam -GetAll 
        Get all appflowparam data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowparam -name <string>
        Get appflowparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowparam -Filter @{ 'name'='<value>' }
        Get appflowparam data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowparam/
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
        Write-Verbose "Invoke-NSGetAppflowparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appflowparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving appflowparam configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowparam: Ended"
    }
}

function Invoke-NSRenameAppflowpolicy {
    <#
    .SYNOPSIS
        Rename AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Newname 
        New name for the policy. Must begin with an ASCII alphabetic or underscore (_)character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameAppflowpolicy -name <string> -newname <string>
        An example how to rename appflowpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSRenameAppflowpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameAppflowpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("appflowpolicy", "Rename AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appflowpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameAppflowpolicy: Finished"
    }
}

function Invoke-NSUpdateAppflowpolicy {
    <#
    .SYNOPSIS
        Update AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the action to be associated with this policy. 
    .PARAMETER Undefaction 
        Name of the appflow action to be associated with this policy when an undef event occurs. 
    .PARAMETER Comment 
        Any comments about this policy. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateAppflowpolicy -name <string>
        An example how to update appflowpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateAppflowpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateAppflowpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("appflowpolicy", "Update AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type appflowpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateAppflowpolicy: Finished"
    }
}

function Invoke-NSUnsetAppflowpolicy {
    <#
    .SYNOPSIS
        Unset AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Undefaction 
        Name of the appflow action to be associated with this policy when an undef event occurs. 
    .PARAMETER Comment 
        Any comments about this policy.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetAppflowpolicy -name <string>
        An example how to unset appflowpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetAppflowpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetAppflowpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type appflowpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetAppflowpolicy: Finished"
    }
}

function Invoke-NSDeleteAppflowpolicy {
    <#
    .SYNOPSIS
        Delete AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAppflowpolicy -Name <string>
        An example how to delete appflowpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAppflowpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteAppflowpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type appflowpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAppflowpolicy: Finished"
    }
}

function Invoke-NSAddAppflowpolicy {
    <#
    .SYNOPSIS
        Add AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the action to be associated with this policy. 
    .PARAMETER Undefaction 
        Name of the appflow action to be associated with this policy when an undef event occurs. 
    .PARAMETER Comment 
        Any comments about this policy. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAppflowpolicy -name <string> -rule <string> -action <string>
        An example how to add appflowpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddAppflowpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAppflowpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("appflowpolicy", "Add AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appflowpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAppflowpolicy: Finished"
    }
}

function Invoke-NSGetAppflowpolicy {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicy -GetAll 
        Get all appflowpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicy -Count 
        Get the number of appflowpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicy -name <string>
        Get appflowpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicy -Filter @{ 'name'='<value>' }
        Get appflowpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy/
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
        Write-Verbose "Invoke-NSGetAppflowpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appflowpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowpolicy: Ended"
    }
}

function Invoke-NSGetAppflowpolicyAppflowglobalBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object showing the appflowglobal that can be bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_appflowglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_appflowglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyAppflowglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyAppflowglobalBinding -GetAll 
        Get all appflowpolicy_appflowglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyAppflowglobalBinding -Count 
        Get the number of appflowpolicy_appflowglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyAppflowglobalBinding -name <string>
        Get appflowpolicy_appflowglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyAppflowglobalBinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_appflowglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowpolicyAppflowglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy_appflowglobal_binding/
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
        Write-Verbose "Invoke-NSGetAppflowpolicyAppflowglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_appflowglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_appflowglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_appflowglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_appflowglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_appflowglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_appflowglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_appflowglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_appflowglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowpolicyAppflowglobalBinding: Ended"
    }
}

function Invoke-NSGetAppflowpolicyAppflowpolicylabelBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicylabel that can be bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_appflowpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_appflowpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyAppflowpolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyAppflowpolicylabelBinding -GetAll 
        Get all appflowpolicy_appflowpolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyAppflowpolicylabelBinding -Count 
        Get the number of appflowpolicy_appflowpolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyAppflowpolicylabelBinding -name <string>
        Get appflowpolicy_appflowpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyAppflowpolicylabelBinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_appflowpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowpolicyAppflowpolicylabelBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy_appflowpolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetAppflowpolicyAppflowpolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_appflowpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_appflowpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowpolicylabel_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_appflowpolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowpolicyAppflowpolicylabelBinding: Ended"
    }
}

function Invoke-NSGetAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyBinding -GetAll 
        Get all appflowpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyBinding -name <string>
        Get appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyBinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy_binding/
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
        Write-Verbose "Invoke-NSGetAppflowpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowpolicyBinding: Ended"
    }
}

function Invoke-NSGetAppflowpolicyCsvserverBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyCsvserverBinding -GetAll 
        Get all appflowpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyCsvserverBinding -Count 
        Get the number of appflowpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyCsvserverBinding -name <string>
        Get appflowpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyCsvserverBinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowpolicyCsvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-NSGetAppflowpolicyCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowpolicyCsvserverBinding: Ended"
    }
}

function Invoke-NSGetAppflowpolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyLbvserverBinding -GetAll 
        Get all appflowpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyLbvserverBinding -Count 
        Get the number of appflowpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyLbvserverBinding -name <string>
        Get appflowpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowpolicyLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetAppflowpolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowpolicyLbvserverBinding: Ended"
    }
}

function Invoke-NSGetAppflowpolicyVpnvserverBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyVpnvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyVpnvserverBinding -GetAll 
        Get all appflowpolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicyVpnvserverBinding -Count 
        Get the number of appflowpolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyVpnvserverBinding -name <string>
        Get appflowpolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicyVpnvserverBinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowpolicyVpnvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-NSGetAppflowpolicyVpnvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowpolicyVpnvserverBinding: Ended"
    }
}

function Invoke-NSRenameAppflowpolicylabel {
    <#
    .SYNOPSIS
        Rename AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow policy label resource.
    .PARAMETER Labelname 
        Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Newname 
        New name for the policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameAppflowpolicylabel -labelname <string> -newname <string>
        An example how to rename appflowpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSRenameAppflowpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSRenameAppflowpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("appflowpolicylabel", "Rename AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appflowpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameAppflowpolicylabel: Finished"
    }
}

function Invoke-NSDeleteAppflowpolicylabel {
    <#
    .SYNOPSIS
        Delete AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow policy label resource.
    .PARAMETER Labelname 
        Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAppflowpolicylabel -Labelname <string>
        An example how to delete appflowpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAppflowpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteAppflowpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type appflowpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAppflowpolicylabel: Finished"
    }
}

function Invoke-NSAddAppflowpolicylabel {
    <#
    .SYNOPSIS
        Add AppFlow configuration. config Object.
    .DESCRIPTION
        Configuration for AppFlow policy label resource.
    .PARAMETER Labelname 
        Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Policylabeltype 
        Type of traffic evaluated by the policies bound to the policy label. 
         
        Possible values = HTTP, OTHERTCP, HTTP_QUIC 
    .PARAMETER PassThru 
        Return details about the created appflowpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAppflowpolicylabel -labelname <string>
        An example how to add appflowpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSAddAppflowpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('HTTP', 'OTHERTCP', 'HTTP_QUIC')]
        [string]$Policylabeltype = 'HTTP',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAppflowpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname }
            if ( $PSBoundParameters.ContainsKey('policylabeltype') ) { $payload.Add('policylabeltype', $policylabeltype) }
            if ( $PSCmdlet.ShouldProcess("appflowpolicylabel", "Add AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type appflowpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAppflowpolicylabel: Finished"
    }
}

function Invoke-NSGetAppflowpolicylabel {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Configuration for AppFlow policy label resource.
    .PARAMETER Labelname 
        Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicylabel -GetAll 
        Get all appflowpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicylabel -Count 
        Get the number of appflowpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicylabel -name <string>
        Get appflowpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicylabel -Filter @{ 'name'='<value>' }
        Get appflowpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowpolicylabel
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicylabel/
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
        Write-Verbose "Invoke-NSGetAppflowpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appflowpolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicylabel configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicylabel configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowpolicylabel: Ended"
    }
}

function Invoke-NSAddAppflowpolicylabelAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Add AppFlow configuration. config Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowpolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the AppFlow policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. 
    .PARAMETER Labeltype 
        Type of policy label to be invoked. 
        Possible values = vserver, policylabel 
    .PARAMETER Invoke_labelname 
        Name of the label to invoke if the current policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicylabel_appflowpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddAppflowpolicylabelAppflowpolicyBinding -labelname <string> -policyname <string> -priority <double>
        An example how to add appflowpolicylabel_appflowpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddAppflowpolicylabelAppflowpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicylabel_appflowpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddAppflowpolicylabelAppflowpolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("appflowpolicylabel_appflowpolicy_binding", "Add AppFlow configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type appflowpolicylabel_appflowpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetAppflowpolicylabelAppflowpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddAppflowpolicylabelAppflowpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteAppflowpolicylabelAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Delete AppFlow configuration. config Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowpolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the AppFlow policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteAppflowpolicylabelAppflowpolicyBinding -Labelname <string>
        An example how to delete appflowpolicylabel_appflowpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteAppflowpolicylabelAppflowpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicylabel_appflowpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
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
        Write-Verbose "Invoke-NSDeleteAppflowpolicylabelAppflowpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete AppFlow configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteAppflowpolicylabelAppflowpolicyBinding: Finished"
    }
}

function Invoke-NSGetAppflowpolicylabelAppflowpolicyBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowpolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicylabel_appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicylabel_appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicylabelAppflowpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicylabelAppflowpolicyBinding -GetAll 
        Get all appflowpolicylabel_appflowpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicylabelAppflowpolicyBinding -Count 
        Get the number of appflowpolicylabel_appflowpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicylabelAppflowpolicyBinding -name <string>
        Get appflowpolicylabel_appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicylabelAppflowpolicyBinding -Filter @{ 'name'='<value>' }
        Get appflowpolicylabel_appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowpolicylabelAppflowpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicylabel_appflowpolicy_binding/
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
        Write-Verbose "Invoke-NSGetAppflowpolicylabelAppflowpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicylabel_appflowpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicylabel_appflowpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicylabel_appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicylabel_appflowpolicy_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicylabel_appflowpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowpolicylabelAppflowpolicyBinding: Ended"
    }
}

function Invoke-NSGetAppflowpolicylabelBinding {
    <#
    .SYNOPSIS
        Get AppFlow configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appflowpolicylabel.
    .PARAMETER Labelname 
        Name of the policy label about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetAppflowpolicylabelBinding -GetAll 
        Get all appflowpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicylabelBinding -name <string>
        Get appflowpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetAppflowpolicylabelBinding -Filter @{ 'name'='<value>' }
        Get appflowpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetAppflowpolicylabelBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/appflow/appflowpolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetAppflowpolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type appflowpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetAppflowpolicylabelBinding: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBB9CZThVrZ8fqY
# qf3erdzXBKlH30eW0odMxvgtHOXCJqCCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQgfxV4fyd15rl0pR4dWb9N1X/HQOVlJF5Azt8TCv0Wm+UwDQYJ
# KoZIhvcNAQEBBQAEggEAVYIwfmYvmVaMMByv6FzREUp5fueY1XCG4DZjxNtO6FAb
# NPlsNTLOhjff5rlqGfVx23hX5bS4/E7cqnplPTcxcIGfjq9DdL26VTRP8U4gctic
# jZ9hjr0lfujYFZ2wnE9t2IrjFrNhIDlrll4+Q/1B98J7L/CxQLfON5yM5unSz9ac
# gGt63iPBG1ZapI60Ji4n8u6czjC4F+P8dZciJpQucjcl2o0QgRQERCkcpw1e9s04
# JPa84ixOmzfXv8nxTM48lg7ICCuZncbf53sW67y91DyQ5Kd2erosiqJbcS5ENk8X
# Pglb73FiHkt18m8k/8cz0uIbk6eoZMRN6jpXPbFO5qGCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQxMTlaMD8GCSqG
# SIb3DQEJBDEyBDBWjn05p4rNo1bexPw5moGWwJDbddcGKjMbv2Lfeb/DMSDlwLLy
# tX25QyWxOvJQqL4wDQYJKoZIhvcNAQEBBQAEggIAQbdZN9CTdmWTcu+CWa999WxV
# PMCuHqTHD06ofkHdCRJ6bwizDqNHyjMkuXbjt9dBY8Z0ieW8df5ny8i60//kByUn
# B8nvUleVL71PlJ5YgMIZI+NRjyIOgIJkrt3+sNxRh2V7wt8R2Tfo2XH8Q6irX3vx
# FgztyyLEtHqClT8HwTYKsFZdFID6lCzpG+hYeXKERS/a+k4TcWb+j1eTJOk4ly4N
# 6sqY8yqD5XQYXyposJzg/RrFQ2dQ+UyERZNBf/AL+j1fA9JziHGXjKidLn9NOl8C
# jwQjNBtrRjGLdhpu/MArCJauiX2OJ4imy4KbZYpNp+y/yb82grHX9w93/gqKqCCr
# X0ifWVqpcMT2MUIYgUQmsVkuSZDtQijr2b2ycOmC799rwH1M9RwXIcm57+L0GEOp
# 0rw2U49JMDuNY+NMZBGmY0zNh41UQcLO8YcV583MEFvimPsK7mV2QsMuGUzoTDdS
# qSc7tNe5g1pvJJZzQHu3kS17Xbp4P046AzLkKG3j2UJNXePG7Bvf5jPs5ZKihAum
# EC43ak1/XFB4PnoMdmJN7LCeNZjuC9LCfDk1Zfhkr5za8nhy6JY862vSQMABPFvj
# g83jblRxeyU1c6Y/9Eo0dLFgiJ3+ZvvrjOeKRugz0wunfoNx2Ji28XgmFpfRAmeL
# zAzStZZnofSeXNsg2Wc=
# SIG # End signature block
