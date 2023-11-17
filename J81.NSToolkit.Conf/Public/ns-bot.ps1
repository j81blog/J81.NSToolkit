function Invoke-NSGetBotglobalBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to botglobal.
    .PARAMETER GetAll 
        Retrieve all botglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the botglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotglobalBinding -GetAll 
        Get all botglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotglobalBinding -name <string>
        Get botglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotglobalBinding -Filter @{ 'name'='<value>' }
        Get botglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotglobalBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botglobal_binding/
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
        Write-Verbose "Invoke-NSGetBotglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving botglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotglobalBinding: Ended"
    }
}

function Invoke-NSAddBotglobalBotpolicyBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botglobal.
    .PARAMETER Policyname 
        Name of the bot policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. Available settings function as follows: * REQ_OVERRIDE - Request override. Binds the policy to the priority request queue. * REQ_DEFAULT - Binds the policy to the default request queue. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server. 
    .PARAMETER Labeltype 
        Type of invocation, Available settings function as follows: * vserver - Forward the request to the specified virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Labelname 
        Name of the policy label to invoke. If the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is policylabel. 
    .PARAMETER PassThru 
        Return details about the created botglobal_botpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotglobalBotpolicyBinding -policyname <string> -priority <double>
        An example how to add botglobal_botpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotglobalBotpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botglobal_botpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotglobalBotpolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("botglobal_botpolicy_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botglobal_botpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotglobalBotpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotglobalBotpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteBotglobalBotpolicyBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botglobal.
    .PARAMETER Policyname 
        Name of the bot policy. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. Available settings function as follows: * REQ_OVERRIDE - Request override. Binds the policy to the priority request queue. * REQ_DEFAULT - Binds the policy to the default request queue. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotglobalBotpolicyBinding 
        An example how to delete botglobal_botpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotglobalBotpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botglobal_botpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteBotglobalBotpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("botglobal_botpolicy_binding", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotglobalBotpolicyBinding: Finished"
    }
}

function Invoke-NSGetBotglobalBotpolicyBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botglobal.
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. Available settings function as follows: * REQ_OVERRIDE - Request override. Binds the policy to the priority request queue. * REQ_DEFAULT - Binds the policy to the default request queue. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT 
    .PARAMETER GetAll 
        Retrieve all botglobal_botpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the botglobal_botpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotglobalBotpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotglobalBotpolicyBinding -GetAll 
        Get all botglobal_botpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotglobalBotpolicyBinding -Count 
        Get the number of botglobal_botpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotglobalBotpolicyBinding -name <string>
        Get botglobal_botpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotglobalBotpolicyBinding -Filter @{ 'name'='<value>' }
        Get botglobal_botpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotglobalBotpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botglobal_botpolicy_binding/
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
        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT')]
        [string]$Type,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotglobalBotpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botglobal_botpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botglobal_botpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botglobal_botpolicy_binding objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botglobal_botpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving botglobal_botpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotglobalBotpolicyBinding: Ended"
    }
}

function Invoke-NSAddBotpolicy {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER Rule 
        Expression that the policy uses to determine whether to apply bot profile on the specified request. 
    .PARAMETER Profilename 
        Name of the bot profile to apply if the request matches this bot policy. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. 
    .PARAMETER Comment 
        Any type of information about this bot policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created botpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotpolicy -name <string> -rule <string> -profilename <string>
        An example how to add botpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Profilename,

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                profilename    = $profilename
            }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("botpolicy", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type botpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotpolicy: Finished"
    }
}

function Invoke-NSDeleteBotpolicy {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotpolicy -Name <string>
        An example how to delete botpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteBotpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotpolicy: Finished"
    }
}

function Invoke-NSUpdateBotpolicy {
    <#
    .SYNOPSIS
        Update Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER Rule 
        Expression that the policy uses to determine whether to apply bot profile on the specified request. 
    .PARAMETER Profilename 
        Name of the bot profile to apply if the request matches this bot policy. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. 
    .PARAMETER Comment 
        Any type of information about this bot policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created botpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateBotpolicy -name <string>
        An example how to update botpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateBotpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [string]$Profilename,

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateBotpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('profilename') ) { $payload.Add('profilename', $profilename) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("botpolicy", "Update Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateBotpolicy: Finished"
    }
}

function Invoke-NSUnsetBotpolicy {
    <#
    .SYNOPSIS
        Unset Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. 
    .PARAMETER Comment 
        Any type of information about this bot policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetBotpolicy -name <string>
        An example how to unset botpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetBotpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSUnsetBotpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type botpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetBotpolicy: Finished"
    }
}

function Invoke-NSRenameBotpolicy {
    <#
    .SYNOPSIS
        Rename Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER Newname 
        New name for the bot policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created botpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameBotpolicy -name <string> -newname <string>
        An example how to rename botpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSRenameBotpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSRenameBotpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("botpolicy", "Rename Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type botpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameBotpolicy: Finished"
    }
}

function Invoke-NSGetBotpolicy {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER GetAll 
        Retrieve all botpolicy object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicy -GetAll 
        Get all botpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicy -Count 
        Get the number of botpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicy -name <string>
        Get botpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicy -Filter @{ 'name'='<value>' }
        Get botpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotpolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy/
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
        Write-Verbose "Invoke-NSGetBotpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all botpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotpolicy: Ended"
    }
}

function Invoke-NSGetBotpolicyBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to botpolicy.
    .PARAMETER Name 
        Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all botpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicyBinding -GetAll 
        Get all botpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyBinding -name <string>
        Get botpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyBinding -Filter @{ 'name'='<value>' }
        Get botpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy_binding/
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
        Write-Verbose "Invoke-NSGetBotpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotpolicyBinding: Ended"
    }
}

function Invoke-NSGetBotpolicyBotglobalBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the botglobal that can be bound to botpolicy.
    .PARAMETER Name 
        Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all botpolicy_botglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy_botglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyBotglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicyBotglobalBinding -GetAll 
        Get all botpolicy_botglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicyBotglobalBinding -Count 
        Get the number of botpolicy_botglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyBotglobalBinding -name <string>
        Get botpolicy_botglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyBotglobalBinding -Filter @{ 'name'='<value>' }
        Get botpolicy_botglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotpolicyBotglobalBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy_botglobal_binding/
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
        Write-Verbose "Invoke-NSGetBotpolicyBotglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicy_botglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_botglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_botglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_botglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_botglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotpolicyBotglobalBinding: Ended"
    }
}

function Invoke-NSGetBotpolicyBotpolicylabelBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the botpolicylabel that can be bound to botpolicy.
    .PARAMETER Name 
        Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all botpolicy_botpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy_botpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyBotpolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicyBotpolicylabelBinding -GetAll 
        Get all botpolicy_botpolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicyBotpolicylabelBinding -Count 
        Get the number of botpolicy_botpolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyBotpolicylabelBinding -name <string>
        Get botpolicy_botpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyBotpolicylabelBinding -Filter @{ 'name'='<value>' }
        Get botpolicy_botpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotpolicyBotpolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy_botpolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetBotpolicyBotpolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicy_botpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_botpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_botpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_botpolicylabel_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_botpolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotpolicyBotpolicylabelBinding: Ended"
    }
}

function Invoke-NSGetBotpolicyCsvserverBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to botpolicy.
    .PARAMETER Name 
        Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all botpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicyCsvserverBinding -GetAll 
        Get all botpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicyCsvserverBinding -Count 
        Get the number of botpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyCsvserverBinding -name <string>
        Get botpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyCsvserverBinding -Filter @{ 'name'='<value>' }
        Get botpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotpolicyCsvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-NSGetBotpolicyCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotpolicyCsvserverBinding: Ended"
    }
}

function Invoke-NSGetBotpolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to botpolicy.
    .PARAMETER Name 
        Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all botpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicyLbvserverBinding -GetAll 
        Get all botpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicyLbvserverBinding -Count 
        Get the number of botpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyLbvserverBinding -name <string>
        Get botpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get botpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotpolicyLbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetBotpolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotpolicyLbvserverBinding: Ended"
    }
}

function Invoke-NSAddBotpolicylabel {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot policy label resource.
    .PARAMETER Labelname 
        Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added. 
    .PARAMETER Comment 
        Any comments to preserve information about this bot policy label. 
    .PARAMETER PassThru 
        Return details about the created botpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotpolicylabel -labelname <string>
        An example how to add botpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotpolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("botpolicylabel", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type botpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotpolicylabel: Finished"
    }
}

function Invoke-NSDeleteBotpolicylabel {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot policy label resource.
    .PARAMETER Labelname 
        Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotpolicylabel -Labelname <string>
        An example how to delete botpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotpolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteBotpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotpolicylabel: Finished"
    }
}

function Invoke-NSRenameBotpolicylabel {
    <#
    .SYNOPSIS
        Rename Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot policy label resource.
    .PARAMETER Labelname 
        Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added. 
    .PARAMETER Newname 
        New name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created botpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameBotpolicylabel -labelname <string> -newname <string>
        An example how to rename botpolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSRenameBotpolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicylabel/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSRenameBotpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("botpolicylabel", "Rename Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type botpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameBotpolicylabel: Finished"
    }
}

function Invoke-NSGetBotpolicylabel {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Configuration for Bot policy label resource.
    .PARAMETER Labelname 
        Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added. 
    .PARAMETER GetAll 
        Retrieve all botpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the botpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicylabel -GetAll 
        Get all botpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicylabel -Count 
        Get the number of botpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabel -name <string>
        Get botpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabel -Filter @{ 'name'='<value>' }
        Get botpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotpolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicylabel/
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
        Write-Verbose "Invoke-NSGetBotpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all botpolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotpolicylabel: Ended"
    }
}

function Invoke-NSGetBotpolicylabelBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to botpolicylabel.
    .PARAMETER Labelname 
        Name of the bot policy label. 
    .PARAMETER GetAll 
        Retrieve all botpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicylabelBinding -GetAll 
        Get all botpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabelBinding -name <string>
        Get botpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabelBinding -Filter @{ 'name'='<value>' }
        Get botpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotpolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetBotpolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotpolicylabelBinding: Ended"
    }
}

function Invoke-NSAddBotpolicylabelBotpolicyBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botpolicylabel.
    .PARAMETER Labelname 
        Name of the bot policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the bot policy. 
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
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is vserver, name of the virtual server. 
    .PARAMETER PassThru 
        Return details about the created botpolicylabel_botpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotpolicylabelBotpolicyBinding -labelname <string> -policyname <string> -priority <double>
        An example how to add botpolicylabel_botpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotpolicylabelBotpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicylabel_botpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSAddBotpolicylabelBotpolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("botpolicylabel_botpolicy_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botpolicylabel_botpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotpolicylabelBotpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotpolicylabelBotpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteBotpolicylabelBotpolicyBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botpolicylabel.
    .PARAMETER Labelname 
        Name of the bot policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the bot policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotpolicylabelBotpolicyBinding -Labelname <string>
        An example how to delete botpolicylabel_botpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotpolicylabelBotpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicylabel_botpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteBotpolicylabelBotpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotpolicylabelBotpolicyBinding: Finished"
    }
}

function Invoke-NSGetBotpolicylabelBotpolicyBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botpolicylabel.
    .PARAMETER Labelname 
        Name of the bot policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all botpolicylabel_botpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicylabel_botpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabelBotpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicylabelBotpolicyBinding -GetAll 
        Get all botpolicylabel_botpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicylabelBotpolicyBinding -Count 
        Get the number of botpolicylabel_botpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabelBotpolicyBinding -name <string>
        Get botpolicylabel_botpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabelBotpolicyBinding -Filter @{ 'name'='<value>' }
        Get botpolicylabel_botpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotpolicylabelBotpolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicylabel_botpolicy_binding/
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
        Write-Verbose "Invoke-NSGetBotpolicylabelBotpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicylabel_botpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel_botpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel_botpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel_botpolicy_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel_botpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotpolicylabelBotpolicyBinding: Ended"
    }
}

function Invoke-NSGetBotpolicylabelPolicybindingBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to botpolicylabel.
    .PARAMETER Labelname 
        Name of the bot policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all botpolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabelPolicybindingBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicylabelPolicybindingBinding -GetAll 
        Get all botpolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotpolicylabelPolicybindingBinding -Count 
        Get the number of botpolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabelPolicybindingBinding -name <string>
        Get botpolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotpolicylabelPolicybindingBinding -Filter @{ 'name'='<value>' }
        Get botpolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotpolicylabelPolicybindingBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botpolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-NSGetBotpolicylabelPolicybindingBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotpolicylabelPolicybindingBinding: Ended"
    }
}

function Invoke-NSAddBotprofile {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Signature 
        Name of object containing bot static signature details. 
    .PARAMETER Errorurl 
        URL that Bot protection uses as the Error URL. 
    .PARAMETER Trapurl 
        URL that Bot protection uses as the Trap URL. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER Bot_enable_white_list 
        Enable white-list bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_black_list 
        Enable black-list bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_rate_limit 
        Enable rate-limit bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprint 
        Enable device-fingerprint bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintaction 
        Action to be taken for device-fingerprint based bot detection. 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER Bot_enable_ip_reputation 
        Enable IP-reputation bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Trap 
        Enable trap bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Trapaction 
        Action to be taken for bot trap based bot detection. 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Signaturenouseragentheaderaction 
        Actions to be taken if no User-Agent header in the request (Applicable if Signature check is enabled). 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Signaturemultipleuseragentheaderaction 
        Actions to be taken if multiple User-Agent headers are seen in a request (Applicable if Signature check is enabled). Log action should be combined with other actions. 
         
        Possible values = CHECKLAST, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Bot_enable_tps 
        Enable TPS. 
         
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintmobile 
        Enabling bot device fingerprint protection for mobile clients. 
         
        Possible values = NONE, Android, iOS 
    .PARAMETER Headlessbrowserdetection 
        Enable Headless Browser detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Clientipexpression 
        Expression to get the client IP. 
    .PARAMETER Kmjavascriptname 
        Name of the JavaScript file that the Bot Management feature will insert in the response for keyboard-mouse based detection. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Kmdetection 
        Enable keyboard-mouse based bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Kmeventspostbodylimit 
        Size of the KM data send by the browser, needs to be processed on ADC. 
         
        Maximum value = 204800 
    .PARAMETER Verboseloglevel 
        Bot verbose Logging. Based on the log level, ADC will log additional information whenever client is detected as a bot. 
         
        Possible values = NONE, HTTP_FULL_HEADER 
    .PARAMETER Spoofedreqaction 
        Actions to be taken on a spoofed request (A request spoofing good bot user agent string). 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Dfprequestlimit 
        Number of requests to allow without bot session cookie if device fingerprint is enabled. 
    .PARAMETER Sessioncookiename 
        Name of the SessionCookie that the Bot Management feature uses for tracking. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, after which a user session is terminated. 
         
        Maximum value = 65535 
    .PARAMETER PassThru 
        Return details about the created botprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotprofile -name <string>
        An example how to add botprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Signature,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Errorurl,

        [ValidateLength(1, 127)]
        [string]$Trapurl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Comment,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_white_list = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_black_list = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_rate_limit = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Devicefingerprint = 'OFF',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$Devicefingerprintaction = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_ip_reputation = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Trap = 'OFF',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Trapaction = 'NONE',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Signaturenouseragentheaderaction = 'DROP',

        [ValidateSet('CHECKLAST', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Signaturemultipleuseragentheaderaction = 'CHECKLAST',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_tps = 'OFF',

        [ValidateSet('NONE', 'Android', 'iOS')]
        [string[]]$Devicefingerprintmobile = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Headlessbrowserdetection = 'OFF',

        [string]$Clientipexpression,

        [string]$Kmjavascriptname,

        [ValidateSet('ON', 'OFF')]
        [string]$Kmdetection = 'OFF',

        [double]$Kmeventspostbodylimit,

        [ValidateSet('NONE', 'HTTP_FULL_HEADER')]
        [string]$Verboseloglevel = 'NONE',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Spoofedreqaction = 'BOT_ACTION_LOG_DROP',

        [double]$Dfprequestlimit,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sessioncookiename,

        [double]$Sessiontimeout,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('signature') ) { $payload.Add('signature', $signature) }
            if ( $PSBoundParameters.ContainsKey('errorurl') ) { $payload.Add('errorurl', $errorurl) }
            if ( $PSBoundParameters.ContainsKey('trapurl') ) { $payload.Add('trapurl', $trapurl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_white_list') ) { $payload.Add('bot_enable_white_list', $bot_enable_white_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_black_list') ) { $payload.Add('bot_enable_black_list', $bot_enable_black_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_rate_limit') ) { $payload.Add('bot_enable_rate_limit', $bot_enable_rate_limit) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprint') ) { $payload.Add('devicefingerprint', $devicefingerprint) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintaction') ) { $payload.Add('devicefingerprintaction', $devicefingerprintaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_ip_reputation') ) { $payload.Add('bot_enable_ip_reputation', $bot_enable_ip_reputation) }
            if ( $PSBoundParameters.ContainsKey('trap') ) { $payload.Add('trap', $trap) }
            if ( $PSBoundParameters.ContainsKey('trapaction') ) { $payload.Add('trapaction', $trapaction) }
            if ( $PSBoundParameters.ContainsKey('signaturenouseragentheaderaction') ) { $payload.Add('signaturenouseragentheaderaction', $signaturenouseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('signaturemultipleuseragentheaderaction') ) { $payload.Add('signaturemultipleuseragentheaderaction', $signaturemultipleuseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_tps') ) { $payload.Add('bot_enable_tps', $bot_enable_tps) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintmobile') ) { $payload.Add('devicefingerprintmobile', $devicefingerprintmobile) }
            if ( $PSBoundParameters.ContainsKey('headlessbrowserdetection') ) { $payload.Add('headlessbrowserdetection', $headlessbrowserdetection) }
            if ( $PSBoundParameters.ContainsKey('clientipexpression') ) { $payload.Add('clientipexpression', $clientipexpression) }
            if ( $PSBoundParameters.ContainsKey('kmjavascriptname') ) { $payload.Add('kmjavascriptname', $kmjavascriptname) }
            if ( $PSBoundParameters.ContainsKey('kmdetection') ) { $payload.Add('kmdetection', $kmdetection) }
            if ( $PSBoundParameters.ContainsKey('kmeventspostbodylimit') ) { $payload.Add('kmeventspostbodylimit', $kmeventspostbodylimit) }
            if ( $PSBoundParameters.ContainsKey('verboseloglevel') ) { $payload.Add('verboseloglevel', $verboseloglevel) }
            if ( $PSBoundParameters.ContainsKey('spoofedreqaction') ) { $payload.Add('spoofedreqaction', $spoofedreqaction) }
            if ( $PSBoundParameters.ContainsKey('dfprequestlimit') ) { $payload.Add('dfprequestlimit', $dfprequestlimit) }
            if ( $PSBoundParameters.ContainsKey('sessioncookiename') ) { $payload.Add('sessioncookiename', $sessioncookiename) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSCmdlet.ShouldProcess("botprofile", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type botprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotprofile: Finished"
    }
}

function Invoke-NSUpdateBotprofile {
    <#
    .SYNOPSIS
        Update Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Signature 
        Name of object containing bot static signature details. 
    .PARAMETER Errorurl 
        URL that Bot protection uses as the Error URL. 
    .PARAMETER Trapurl 
        URL that Bot protection uses as the Trap URL. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER Bot_enable_white_list 
        Enable white-list bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_black_list 
        Enable black-list bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_rate_limit 
        Enable rate-limit bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprint 
        Enable device-fingerprint bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintaction 
        Action to be taken for device-fingerprint based bot detection. 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER Bot_enable_ip_reputation 
        Enable IP-reputation bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Trap 
        Enable trap bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Signaturenouseragentheaderaction 
        Actions to be taken if no User-Agent header in the request (Applicable if Signature check is enabled). 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Signaturemultipleuseragentheaderaction 
        Actions to be taken if multiple User-Agent headers are seen in a request (Applicable if Signature check is enabled). Log action should be combined with other actions. 
         
        Possible values = CHECKLAST, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Trapaction 
        Action to be taken for bot trap based bot detection. 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Bot_enable_tps 
        Enable TPS. 
         
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintmobile 
        Enabling bot device fingerprint protection for mobile clients. 
         
        Possible values = NONE, Android, iOS 
    .PARAMETER Headlessbrowserdetection 
        Enable Headless Browser detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Clientipexpression 
        Expression to get the client IP. 
    .PARAMETER Kmjavascriptname 
        Name of the JavaScript file that the Bot Management feature will insert in the response for keyboard-mouse based detection. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Kmdetection 
        Enable keyboard-mouse based bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Kmeventspostbodylimit 
        Size of the KM data send by the browser, needs to be processed on ADC. 
         
        Maximum value = 204800 
    .PARAMETER Verboseloglevel 
        Bot verbose Logging. Based on the log level, ADC will log additional information whenever client is detected as a bot. 
         
        Possible values = NONE, HTTP_FULL_HEADER 
    .PARAMETER Spoofedreqaction 
        Actions to be taken on a spoofed request (A request spoofing good bot user agent string). 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Dfprequestlimit 
        Number of requests to allow without bot session cookie if device fingerprint is enabled. 
    .PARAMETER Sessioncookiename 
        Name of the SessionCookie that the Bot Management feature uses for tracking. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, after which a user session is terminated. 
         
        Maximum value = 65535 
    .PARAMETER PassThru 
        Return details about the created botprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateBotprofile -name <string>
        An example how to update botprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateBotprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Signature,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Errorurl,

        [ValidateLength(1, 127)]
        [string]$Trapurl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Comment,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_white_list,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_black_list,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_rate_limit,

        [ValidateSet('ON', 'OFF')]
        [string]$Devicefingerprint,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$Devicefingerprintaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_ip_reputation,

        [ValidateSet('ON', 'OFF')]
        [string]$Trap,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Signaturenouseragentheaderaction,

        [ValidateSet('CHECKLAST', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Signaturemultipleuseragentheaderaction,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Trapaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_tps,

        [ValidateSet('NONE', 'Android', 'iOS')]
        [string[]]$Devicefingerprintmobile,

        [ValidateSet('ON', 'OFF')]
        [string]$Headlessbrowserdetection,

        [string]$Clientipexpression,

        [string]$Kmjavascriptname,

        [ValidateSet('ON', 'OFF')]
        [string]$Kmdetection,

        [double]$Kmeventspostbodylimit,

        [ValidateSet('NONE', 'HTTP_FULL_HEADER')]
        [string]$Verboseloglevel,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Spoofedreqaction,

        [double]$Dfprequestlimit,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sessioncookiename,

        [double]$Sessiontimeout,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateBotprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('signature') ) { $payload.Add('signature', $signature) }
            if ( $PSBoundParameters.ContainsKey('errorurl') ) { $payload.Add('errorurl', $errorurl) }
            if ( $PSBoundParameters.ContainsKey('trapurl') ) { $payload.Add('trapurl', $trapurl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_white_list') ) { $payload.Add('bot_enable_white_list', $bot_enable_white_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_black_list') ) { $payload.Add('bot_enable_black_list', $bot_enable_black_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_rate_limit') ) { $payload.Add('bot_enable_rate_limit', $bot_enable_rate_limit) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprint') ) { $payload.Add('devicefingerprint', $devicefingerprint) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintaction') ) { $payload.Add('devicefingerprintaction', $devicefingerprintaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_ip_reputation') ) { $payload.Add('bot_enable_ip_reputation', $bot_enable_ip_reputation) }
            if ( $PSBoundParameters.ContainsKey('trap') ) { $payload.Add('trap', $trap) }
            if ( $PSBoundParameters.ContainsKey('signaturenouseragentheaderaction') ) { $payload.Add('signaturenouseragentheaderaction', $signaturenouseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('signaturemultipleuseragentheaderaction') ) { $payload.Add('signaturemultipleuseragentheaderaction', $signaturemultipleuseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('trapaction') ) { $payload.Add('trapaction', $trapaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_tps') ) { $payload.Add('bot_enable_tps', $bot_enable_tps) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintmobile') ) { $payload.Add('devicefingerprintmobile', $devicefingerprintmobile) }
            if ( $PSBoundParameters.ContainsKey('headlessbrowserdetection') ) { $payload.Add('headlessbrowserdetection', $headlessbrowserdetection) }
            if ( $PSBoundParameters.ContainsKey('clientipexpression') ) { $payload.Add('clientipexpression', $clientipexpression) }
            if ( $PSBoundParameters.ContainsKey('kmjavascriptname') ) { $payload.Add('kmjavascriptname', $kmjavascriptname) }
            if ( $PSBoundParameters.ContainsKey('kmdetection') ) { $payload.Add('kmdetection', $kmdetection) }
            if ( $PSBoundParameters.ContainsKey('kmeventspostbodylimit') ) { $payload.Add('kmeventspostbodylimit', $kmeventspostbodylimit) }
            if ( $PSBoundParameters.ContainsKey('verboseloglevel') ) { $payload.Add('verboseloglevel', $verboseloglevel) }
            if ( $PSBoundParameters.ContainsKey('spoofedreqaction') ) { $payload.Add('spoofedreqaction', $spoofedreqaction) }
            if ( $PSBoundParameters.ContainsKey('dfprequestlimit') ) { $payload.Add('dfprequestlimit', $dfprequestlimit) }
            if ( $PSBoundParameters.ContainsKey('sessioncookiename') ) { $payload.Add('sessioncookiename', $sessioncookiename) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSCmdlet.ShouldProcess("botprofile", "Update Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateBotprofile: Finished"
    }
}

function Invoke-NSUnsetBotprofile {
    <#
    .SYNOPSIS
        Unset Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Signature 
        Name of object containing bot static signature details. 
    .PARAMETER Errorurl 
        URL that Bot protection uses as the Error URL. 
    .PARAMETER Trapurl 
        URL that Bot protection uses as the Trap URL. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER Bot_enable_white_list 
        Enable white-list bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_black_list 
        Enable black-list bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_rate_limit 
        Enable rate-limit bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprint 
        Enable device-fingerprint bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintaction 
        Action to be taken for device-fingerprint based bot detection. 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER Bot_enable_ip_reputation 
        Enable IP-reputation bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Trap 
        Enable trap bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Signaturenouseragentheaderaction 
        Actions to be taken if no User-Agent header in the request (Applicable if Signature check is enabled). 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Signaturemultipleuseragentheaderaction 
        Actions to be taken if multiple User-Agent headers are seen in a request (Applicable if Signature check is enabled). Log action should be combined with other actions. 
         
        Possible values = CHECKLAST, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Trapaction 
        Action to be taken for bot trap based bot detection. 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Bot_enable_tps 
        Enable TPS. 
         
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintmobile 
        Enabling bot device fingerprint protection for mobile clients. 
         
        Possible values = NONE, Android, iOS 
    .PARAMETER Headlessbrowserdetection 
        Enable Headless Browser detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Clientipexpression 
        Expression to get the client IP. 
    .PARAMETER Kmjavascriptname 
        Name of the JavaScript file that the Bot Management feature will insert in the response for keyboard-mouse based detection. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Kmdetection 
        Enable keyboard-mouse based bot detection. 
         
        Possible values = ON, OFF 
    .PARAMETER Kmeventspostbodylimit 
        Size of the KM data send by the browser, needs to be processed on ADC. 
         
        Maximum value = 204800 
    .PARAMETER Verboseloglevel 
        Bot verbose Logging. Based on the log level, ADC will log additional information whenever client is detected as a bot. 
         
        Possible values = NONE, HTTP_FULL_HEADER 
    .PARAMETER Spoofedreqaction 
        Actions to be taken on a spoofed request (A request spoofing good bot user agent string). 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Dfprequestlimit 
        Number of requests to allow without bot session cookie if device fingerprint is enabled. 
    .PARAMETER Sessioncookiename 
        Name of the SessionCookie that the Bot Management feature uses for tracking. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, after which a user session is terminated. 
         
        Maximum value = 65535
    .EXAMPLE
        PS C:\>Invoke-NSUnsetBotprofile -name <string>
        An example how to unset botprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetBotprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateLength(1, 31)]
        [string]$Name,

        [Boolean]$signature,

        [Boolean]$errorurl,

        [Boolean]$trapurl,

        [Boolean]$comment,

        [Boolean]$bot_enable_white_list,

        [Boolean]$bot_enable_black_list,

        [Boolean]$bot_enable_rate_limit,

        [Boolean]$devicefingerprint,

        [Boolean]$devicefingerprintaction,

        [Boolean]$bot_enable_ip_reputation,

        [Boolean]$trap,

        [Boolean]$signaturenouseragentheaderaction,

        [Boolean]$signaturemultipleuseragentheaderaction,

        [Boolean]$trapaction,

        [Boolean]$bot_enable_tps,

        [Boolean]$devicefingerprintmobile,

        [Boolean]$headlessbrowserdetection,

        [Boolean]$clientipexpression,

        [Boolean]$kmjavascriptname,

        [Boolean]$kmdetection,

        [Boolean]$kmeventspostbodylimit,

        [Boolean]$verboseloglevel,

        [Boolean]$spoofedreqaction,

        [Boolean]$dfprequestlimit,

        [Boolean]$sessioncookiename,

        [Boolean]$sessiontimeout 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetBotprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('signature') ) { $payload.Add('signature', $signature) }
            if ( $PSBoundParameters.ContainsKey('errorurl') ) { $payload.Add('errorurl', $errorurl) }
            if ( $PSBoundParameters.ContainsKey('trapurl') ) { $payload.Add('trapurl', $trapurl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_white_list') ) { $payload.Add('bot_enable_white_list', $bot_enable_white_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_black_list') ) { $payload.Add('bot_enable_black_list', $bot_enable_black_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_rate_limit') ) { $payload.Add('bot_enable_rate_limit', $bot_enable_rate_limit) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprint') ) { $payload.Add('devicefingerprint', $devicefingerprint) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintaction') ) { $payload.Add('devicefingerprintaction', $devicefingerprintaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_ip_reputation') ) { $payload.Add('bot_enable_ip_reputation', $bot_enable_ip_reputation) }
            if ( $PSBoundParameters.ContainsKey('trap') ) { $payload.Add('trap', $trap) }
            if ( $PSBoundParameters.ContainsKey('signaturenouseragentheaderaction') ) { $payload.Add('signaturenouseragentheaderaction', $signaturenouseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('signaturemultipleuseragentheaderaction') ) { $payload.Add('signaturemultipleuseragentheaderaction', $signaturemultipleuseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('trapaction') ) { $payload.Add('trapaction', $trapaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_tps') ) { $payload.Add('bot_enable_tps', $bot_enable_tps) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintmobile') ) { $payload.Add('devicefingerprintmobile', $devicefingerprintmobile) }
            if ( $PSBoundParameters.ContainsKey('headlessbrowserdetection') ) { $payload.Add('headlessbrowserdetection', $headlessbrowserdetection) }
            if ( $PSBoundParameters.ContainsKey('clientipexpression') ) { $payload.Add('clientipexpression', $clientipexpression) }
            if ( $PSBoundParameters.ContainsKey('kmjavascriptname') ) { $payload.Add('kmjavascriptname', $kmjavascriptname) }
            if ( $PSBoundParameters.ContainsKey('kmdetection') ) { $payload.Add('kmdetection', $kmdetection) }
            if ( $PSBoundParameters.ContainsKey('kmeventspostbodylimit') ) { $payload.Add('kmeventspostbodylimit', $kmeventspostbodylimit) }
            if ( $PSBoundParameters.ContainsKey('verboseloglevel') ) { $payload.Add('verboseloglevel', $verboseloglevel) }
            if ( $PSBoundParameters.ContainsKey('spoofedreqaction') ) { $payload.Add('spoofedreqaction', $spoofedreqaction) }
            if ( $PSBoundParameters.ContainsKey('dfprequestlimit') ) { $payload.Add('dfprequestlimit', $dfprequestlimit) }
            if ( $PSBoundParameters.ContainsKey('sessioncookiename') ) { $payload.Add('sessioncookiename', $sessioncookiename) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type botprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetBotprofile: Finished"
    }
}

function Invoke-NSDeleteBotprofile {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotprofile -Name <string>
        An example how to delete botprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteBotprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotprofile: Finished"
    }
}

function Invoke-NSGetBotprofile {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Configuration for Bot profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile object(s).
    .PARAMETER Count
        If specified, the count of the botprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofile -GetAll 
        Get all botprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofile -Count 
        Get the number of botprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofile -name <string>
        Get botprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofile -Filter @{ 'name'='<value>' }
        Get botprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile/
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
        Write-Verbose "Invoke-NSGetBotprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all botprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofile: Ended"
    }
}

function Invoke-NSGetBotprofileBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to botprofile.
    .PARAMETER Name 
        Name of the bot management profile. 
    .PARAMETER GetAll 
        Retrieve all botprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileBinding -GetAll 
        Get all botprofile_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileBinding -name <string>
        Get botprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileBinding -Filter @{ 'name'='<value>' }
        Get botprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofileBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotprofileBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofileBinding: Ended"
    }
}

function Invoke-NSAddBotprofileBlacklistBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the blacklist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_blacklist 
        Blacklist binding. Maximum 32 bindings can be configured per profile for Blacklist detection. 
    .PARAMETER Bot_blacklist_type 
        Type of the black-list entry. 
        Possible values = IPv4, SUBNET, IPv6, IPv6_SUBNET, EXPRESSION 
    .PARAMETER Bot_blacklist_value 
        Value of the bot black-list entry. 
    .PARAMETER Bot_blacklist_action 
        One or more actions to be taken if bot is detected based on this Blacklist binding. Only LOG action can be combined with DROP or RESET action. 
         
        Possible values = NONE, LOG, DROP, RESET, REDIRECT 
    .PARAMETER Bot_blacklist_enabled 
        Enabled or disbaled black-list binding. 
         
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_blacklist_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotprofileBlacklistBinding -name <string>
        An example how to add botprofile_blacklist_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotprofileBlacklistBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_blacklist_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Bot_blacklist,

        [ValidateSet('IPv4', 'SUBNET', 'IPv6', 'IPv6_SUBNET', 'EXPRESSION')]
        [string]$Bot_blacklist_type,

        [string]$Bot_blacklist_value,

        [ValidateSet('NONE', 'LOG', 'DROP', 'RESET', 'REDIRECT')]
        [string[]]$Bot_blacklist_action = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_blacklist_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotprofileBlacklistBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('bot_blacklist') ) { $payload.Add('bot_blacklist', $bot_blacklist) }
            if ( $PSBoundParameters.ContainsKey('bot_blacklist_type') ) { $payload.Add('bot_blacklist_type', $bot_blacklist_type) }
            if ( $PSBoundParameters.ContainsKey('bot_blacklist_value') ) { $payload.Add('bot_blacklist_value', $bot_blacklist_value) }
            if ( $PSBoundParameters.ContainsKey('bot_blacklist_action') ) { $payload.Add('bot_blacklist_action', $bot_blacklist_action) }
            if ( $PSBoundParameters.ContainsKey('bot_blacklist_enabled') ) { $payload.Add('bot_blacklist_enabled', $bot_blacklist_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_blacklist_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_blacklist_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofileBlacklistBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotprofileBlacklistBinding: Finished"
    }
}

function Invoke-NSDeleteBotprofileBlacklistBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the blacklist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_blacklist 
        Blacklist binding. Maximum 32 bindings can be configured per profile for Blacklist detection. 
    .PARAMETER Bot_blacklist_value 
        Value of the bot black-list entry.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotprofileBlacklistBinding -Name <string>
        An example how to delete botprofile_blacklist_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotprofileBlacklistBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_blacklist_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [boolean]$Bot_blacklist,

        [string]$Bot_blacklist_value 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteBotprofileBlacklistBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Bot_blacklist') ) { $arguments.Add('bot_blacklist', $Bot_blacklist) }
            if ( $PSBoundParameters.ContainsKey('Bot_blacklist_value') ) { $arguments.Add('bot_blacklist_value', $Bot_blacklist_value) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotprofileBlacklistBinding: Finished"
    }
}

function Invoke-NSGetBotprofileBlacklistBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the blacklist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_blacklist_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_blacklist_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileBlacklistBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileBlacklistBinding -GetAll 
        Get all botprofile_blacklist_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileBlacklistBinding -Count 
        Get the number of botprofile_blacklist_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileBlacklistBinding -name <string>
        Get botprofile_blacklist_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileBlacklistBinding -Filter @{ 'name'='<value>' }
        Get botprofile_blacklist_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofileBlacklistBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_blacklist_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotprofileBlacklistBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_blacklist_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_blacklist_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_blacklist_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_blacklist_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_blacklist_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofileBlacklistBinding: Ended"
    }
}

function Invoke-NSAddBotprofileCaptchaBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the captcha that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Captcharesource 
        Captcha action binding. For each URL, only one binding is allowed. To update the values of an existing URL binding, user has to first unbind that binding, and then needs to bind the URL again with new values. Maximum 30 bindings can be configured per profile. 
    .PARAMETER Bot_captcha_url 
        URL for which the Captcha action, if configured under IP reputation, TPS or device fingerprint, need to be applied. 
    .PARAMETER Waittime 
        Wait time in seconds for which ADC needs to wait for the Captcha response. This is to avoid DOS attacks. 
         
         
        Maximum value = 60 
    .PARAMETER Graceperiod 
        Time (in seconds) duration for which no new captcha challenge is sent after current captcha challenge has been answered successfully. 
         
         
        Maximum value = 900 
    .PARAMETER Muteperiod 
        Time (in seconds) duration for which client which failed captcha need to wait until allowed to try again. The requests from this client are silently dropped during the mute period. 
         
         
        Maximum value = 900 
    .PARAMETER Requestsizelimit 
        Length of body request (in Bytes) up to (equal or less than) which captcha challenge will be provided to client. Above this length threshold the request will be dropped. This is to avoid DOS and DDOS attacks. 
         
         
        Maximum value = 30000 
    .PARAMETER Retryattempts 
        Number of times client can retry solving the captcha. 
         
         
        Maximum value = 10 
    .PARAMETER Bot_captcha_action 
        One or more actions to be taken when client fails captcha challenge. Only, log action can be configured with DROP, REDIRECT or RESET action. 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Bot_captcha_enabled 
        Enable or disable the captcha binding. 
         
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_captcha_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotprofileCaptchaBinding -name <string>
        An example how to add botprofile_captcha_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotprofileCaptchaBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_captcha_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Captcharesource,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_captcha_url,

        [double]$Waittime = '15',

        [double]$Graceperiod = '900',

        [double]$Muteperiod = '300',

        [double]$Requestsizelimit = '8000',

        [double]$Retryattempts = '3',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Bot_captcha_action = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_captcha_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotprofileCaptchaBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('captcharesource') ) { $payload.Add('captcharesource', $captcharesource) }
            if ( $PSBoundParameters.ContainsKey('bot_captcha_url') ) { $payload.Add('bot_captcha_url', $bot_captcha_url) }
            if ( $PSBoundParameters.ContainsKey('waittime') ) { $payload.Add('waittime', $waittime) }
            if ( $PSBoundParameters.ContainsKey('graceperiod') ) { $payload.Add('graceperiod', $graceperiod) }
            if ( $PSBoundParameters.ContainsKey('muteperiod') ) { $payload.Add('muteperiod', $muteperiod) }
            if ( $PSBoundParameters.ContainsKey('requestsizelimit') ) { $payload.Add('requestsizelimit', $requestsizelimit) }
            if ( $PSBoundParameters.ContainsKey('retryattempts') ) { $payload.Add('retryattempts', $retryattempts) }
            if ( $PSBoundParameters.ContainsKey('bot_captcha_action') ) { $payload.Add('bot_captcha_action', $bot_captcha_action) }
            if ( $PSBoundParameters.ContainsKey('bot_captcha_enabled') ) { $payload.Add('bot_captcha_enabled', $bot_captcha_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_captcha_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_captcha_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofileCaptchaBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotprofileCaptchaBinding: Finished"
    }
}

function Invoke-NSDeleteBotprofileCaptchaBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the captcha that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Captcharesource 
        Captcha action binding. For each URL, only one binding is allowed. To update the values of an existing URL binding, user has to first unbind that binding, and then needs to bind the URL again with new values. Maximum 30 bindings can be configured per profile. 
    .PARAMETER Bot_captcha_url 
        URL for which the Captcha action, if configured under IP reputation, TPS or device fingerprint, need to be applied.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotprofileCaptchaBinding -Name <string>
        An example how to delete botprofile_captcha_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotprofileCaptchaBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_captcha_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [boolean]$Captcharesource,

        [string]$Bot_captcha_url 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteBotprofileCaptchaBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Captcharesource') ) { $arguments.Add('captcharesource', $Captcharesource) }
            if ( $PSBoundParameters.ContainsKey('Bot_captcha_url') ) { $arguments.Add('bot_captcha_url', $Bot_captcha_url) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotprofileCaptchaBinding: Finished"
    }
}

function Invoke-NSGetBotprofileCaptchaBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the captcha that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_captcha_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_captcha_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileCaptchaBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileCaptchaBinding -GetAll 
        Get all botprofile_captcha_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileCaptchaBinding -Count 
        Get the number of botprofile_captcha_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileCaptchaBinding -name <string>
        Get botprofile_captcha_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileCaptchaBinding -Filter @{ 'name'='<value>' }
        Get botprofile_captcha_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofileCaptchaBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_captcha_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotprofileCaptchaBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_captcha_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_captcha_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_captcha_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_captcha_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_captcha_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofileCaptchaBinding: Ended"
    }
}

function Invoke-NSAddBotprofileIpreputationBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the ipreputation that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_ipreputation 
        IP reputation binding. For each category, only one binding is allowed. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with the new values. 
    .PARAMETER Category 
        IP Repuation category. Following IP Reuputation categories are allowed: *IP_BASED - This category checks whether client IP is malicious or not. *BOTNET - This category includes Botnet C&amp;C channels, and infected zombie machines controlled by Bot master. *SPAM_SOURCES - This category includes tunneling spam messages through a proxy, anomalous SMTP activities, and forum spam activities. *SCANNERS - This category includes all reconnaissance such as probes, host scan, domain scan, and password brute force attack. *DOS - This category includes DOS, DDOS, anomalous sync flood, and anomalous traffic detection. *REPUTATION - This category denies access from IP addresses currently known to be infected with malware. This category also includes IPs with average low Webroot Reputation Index score. Enabling this category will prevent access from sources identified to contact malware distribution points. *PHISHING - This category includes IP addresses hosting phishing sites and other kinds of fraud activities such as ad click fraud or gaming fraud. *PROXY - This category includes IP addresses providing proxy services. *NETWORK - IPs providing proxy and anonymization services including The Onion Router aka TOR or darknet. *MOBILE_THREATS - This category checks client IP with the list of IPs harmful for mobile devices. *WINDOWS_EXPLOITS - This category includes active IP address offering or distributig malware, shell code, rootkits, worms or viruses. *WEB_ATTACKS - This category includes cross site scripting, iFrame injection, SQL injection, cross domain injection or domain password brute force attack. *TOR_PROXY - This category includes IP address acting as exit nodes for the Tor Network. *CLOUD - This category checks client IP with list of public cloud IPs. *CLOUD_AWS - This category checks client IP with list of public cloud IPs from Amazon Web Services. *CLOUD_GCP - This category checks client IP with list of public cloud IPs from Google Cloud Platform. *CLOUD_AZURE - This category checks client IP with list of public cloud IPs from Azure. *CLOUD_ORACLE - This category checks client IP with list of public cloud IPs from Oracle. *CLOUD_IBM - This category checks client IP with list of public cloud IPs from IBM. *CLOUD_SALESFORCE - This category checks client IP with list of public cloud IPs from Salesforce. 
        Possible values = IP, BOTNETS, SPAM_SOURCES, SCANNERS, DOS, REPUTATION, PHISHING, PROXY, NETWORK, MOBILE_THREATS, WINDOWS_EXPLOITS, WEB_ATTACKS, TOR_PROXY, CLOUD, CLOUD_AWS, CLOUD_GCP, CLOUD_AZURE, CLOUD_ORACLE, CLOUD_IBM, CLOUD_SALESFORCE 
    .PARAMETER Bot_iprep_enabled 
        Enabled or disabled IP-repuation binding. 
         
        Possible values = ON, OFF 
    .PARAMETER Bot_iprep_action 
        One or more actions to be taken if bot is detected based on this IP Reputation binding. Only LOG action can be combinded with DROP, RESET, REDIRECT or MITIGATION action. 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_ipreputation_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotprofileIpreputationBinding -name <string>
        An example how to add botprofile_ipreputation_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotprofileIpreputationBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_ipreputation_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Bot_ipreputation,

        [ValidateSet('IP', 'BOTNETS', 'SPAM_SOURCES', 'SCANNERS', 'DOS', 'REPUTATION', 'PHISHING', 'PROXY', 'NETWORK', 'MOBILE_THREATS', 'WINDOWS_EXPLOITS', 'WEB_ATTACKS', 'TOR_PROXY', 'CLOUD', 'CLOUD_AWS', 'CLOUD_GCP', 'CLOUD_AZURE', 'CLOUD_ORACLE', 'CLOUD_IBM', 'CLOUD_SALESFORCE')]
        [string]$Category,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_iprep_enabled = 'OFF',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$Bot_iprep_action = 'NONE',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotprofileIpreputationBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('bot_ipreputation') ) { $payload.Add('bot_ipreputation', $bot_ipreputation) }
            if ( $PSBoundParameters.ContainsKey('category') ) { $payload.Add('category', $category) }
            if ( $PSBoundParameters.ContainsKey('bot_iprep_enabled') ) { $payload.Add('bot_iprep_enabled', $bot_iprep_enabled) }
            if ( $PSBoundParameters.ContainsKey('bot_iprep_action') ) { $payload.Add('bot_iprep_action', $bot_iprep_action) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_ipreputation_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_ipreputation_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofileIpreputationBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotprofileIpreputationBinding: Finished"
    }
}

function Invoke-NSDeleteBotprofileIpreputationBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the ipreputation that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_ipreputation 
        IP reputation binding. For each category, only one binding is allowed. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with the new values. 
    .PARAMETER Category 
        IP Repuation category. Following IP Reuputation categories are allowed: *IP_BASED - This category checks whether client IP is malicious or not. *BOTNET - This category includes Botnet C&amp;C channels, and infected zombie machines controlled by Bot master. *SPAM_SOURCES - This category includes tunneling spam messages through a proxy, anomalous SMTP activities, and forum spam activities. *SCANNERS - This category includes all reconnaissance such as probes, host scan, domain scan, and password brute force attack. *DOS - This category includes DOS, DDOS, anomalous sync flood, and anomalous traffic detection. *REPUTATION - This category denies access from IP addresses currently known to be infected with malware. This category also includes IPs with average low Webroot Reputation Index score. Enabling this category will prevent access from sources identified to contact malware distribution points. *PHISHING - This category includes IP addresses hosting phishing sites and other kinds of fraud activities such as ad click fraud or gaming fraud. *PROXY - This category includes IP addresses providing proxy services. *NETWORK - IPs providing proxy and anonymization services including The Onion Router aka TOR or darknet. *MOBILE_THREATS - This category checks client IP with the list of IPs harmful for mobile devices. *WINDOWS_EXPLOITS - This category includes active IP address offering or distributig malware, shell code, rootkits, worms or viruses. *WEB_ATTACKS - This category includes cross site scripting, iFrame injection, SQL injection, cross domain injection or domain password brute force attack. *TOR_PROXY - This category includes IP address acting as exit nodes for the Tor Network. *CLOUD - This category checks client IP with list of public cloud IPs. *CLOUD_AWS - This category checks client IP with list of public cloud IPs from Amazon Web Services. *CLOUD_GCP - This category checks client IP with list of public cloud IPs from Google Cloud Platform. *CLOUD_AZURE - This category checks client IP with list of public cloud IPs from Azure. *CLOUD_ORACLE - This category checks client IP with list of public cloud IPs from Oracle. *CLOUD_IBM - This category checks client IP with list of public cloud IPs from IBM. *CLOUD_SALESFORCE - This category checks client IP with list of public cloud IPs from Salesforce. 
        Possible values = IP, BOTNETS, SPAM_SOURCES, SCANNERS, DOS, REPUTATION, PHISHING, PROXY, NETWORK, MOBILE_THREATS, WINDOWS_EXPLOITS, WEB_ATTACKS, TOR_PROXY, CLOUD, CLOUD_AWS, CLOUD_GCP, CLOUD_AZURE, CLOUD_ORACLE, CLOUD_IBM, CLOUD_SALESFORCE
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotprofileIpreputationBinding -Name <string>
        An example how to delete botprofile_ipreputation_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotprofileIpreputationBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_ipreputation_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [boolean]$Bot_ipreputation,

        [string]$Category 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteBotprofileIpreputationBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Bot_ipreputation') ) { $arguments.Add('bot_ipreputation', $Bot_ipreputation) }
            if ( $PSBoundParameters.ContainsKey('Category') ) { $arguments.Add('category', $Category) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotprofileIpreputationBinding: Finished"
    }
}

function Invoke-NSGetBotprofileIpreputationBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the ipreputation that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_ipreputation_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_ipreputation_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileIpreputationBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileIpreputationBinding -GetAll 
        Get all botprofile_ipreputation_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileIpreputationBinding -Count 
        Get the number of botprofile_ipreputation_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileIpreputationBinding -name <string>
        Get botprofile_ipreputation_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileIpreputationBinding -Filter @{ 'name'='<value>' }
        Get botprofile_ipreputation_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofileIpreputationBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_ipreputation_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotprofileIpreputationBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_ipreputation_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_ipreputation_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_ipreputation_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_ipreputation_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_ipreputation_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofileIpreputationBinding: Ended"
    }
}

function Invoke-NSAddBotprofileKmdetectionexprBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the kmdetectionexpr that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Kmdetectionexpr 
        Keyboard-mouse based detection binding. For each name, only one binding is allowed. To update the values of an existing binding, user has to first unbind that binding, then needs to bind again with new vlaues. Maximum 30 bindings can be configured per profile. 
    .PARAMETER Bot_km_expression_name 
        Name of the keyboard-mouse expression object. 
    .PARAMETER Bot_km_expression_value 
        JavaScript file for keyboard-mouse detection, would be inserted if the result of the expression is true. 
    .PARAMETER Bot_km_detection_enabled 
        Enable or disable the keyboard-mouse based binding. 
         
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_kmdetectionexpr_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotprofileKmdetectionexprBinding -name <string>
        An example how to add botprofile_kmdetectionexpr_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotprofileKmdetectionexprBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_kmdetectionexpr_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Kmdetectionexpr,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_km_expression_name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_km_expression_value,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_km_detection_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotprofileKmdetectionexprBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('kmdetectionexpr') ) { $payload.Add('kmdetectionexpr', $kmdetectionexpr) }
            if ( $PSBoundParameters.ContainsKey('bot_km_expression_name') ) { $payload.Add('bot_km_expression_name', $bot_km_expression_name) }
            if ( $PSBoundParameters.ContainsKey('bot_km_expression_value') ) { $payload.Add('bot_km_expression_value', $bot_km_expression_value) }
            if ( $PSBoundParameters.ContainsKey('bot_km_detection_enabled') ) { $payload.Add('bot_km_detection_enabled', $bot_km_detection_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_kmdetectionexpr_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_kmdetectionexpr_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofileKmdetectionexprBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotprofileKmdetectionexprBinding: Finished"
    }
}

function Invoke-NSDeleteBotprofileKmdetectionexprBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the kmdetectionexpr that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Kmdetectionexpr 
        Keyboard-mouse based detection binding. For each name, only one binding is allowed. To update the values of an existing binding, user has to first unbind that binding, then needs to bind again with new vlaues. Maximum 30 bindings can be configured per profile. 
    .PARAMETER Bot_km_expression_name 
        Name of the keyboard-mouse expression object.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotprofileKmdetectionexprBinding -Name <string>
        An example how to delete botprofile_kmdetectionexpr_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotprofileKmdetectionexprBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_kmdetectionexpr_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [boolean]$Kmdetectionexpr,

        [string]$Bot_km_expression_name 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteBotprofileKmdetectionexprBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Kmdetectionexpr') ) { $arguments.Add('kmdetectionexpr', $Kmdetectionexpr) }
            if ( $PSBoundParameters.ContainsKey('Bot_km_expression_name') ) { $arguments.Add('bot_km_expression_name', $Bot_km_expression_name) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botprofile_kmdetectionexpr_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotprofileKmdetectionexprBinding: Finished"
    }
}

function Invoke-NSGetBotprofileKmdetectionexprBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the kmdetectionexpr that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_kmdetectionexpr_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_kmdetectionexpr_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileKmdetectionexprBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileKmdetectionexprBinding -GetAll 
        Get all botprofile_kmdetectionexpr_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileKmdetectionexprBinding -Count 
        Get the number of botprofile_kmdetectionexpr_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileKmdetectionexprBinding -name <string>
        Get botprofile_kmdetectionexpr_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileKmdetectionexprBinding -Filter @{ 'name'='<value>' }
        Get botprofile_kmdetectionexpr_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofileKmdetectionexprBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_kmdetectionexpr_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotprofileKmdetectionexprBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_kmdetectionexpr_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_kmdetectionexpr_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_kmdetectionexpr_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_kmdetectionexpr_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_kmdetectionexpr_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_kmdetectionexpr_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_kmdetectionexpr_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_kmdetectionexpr_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_kmdetectionexpr_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_kmdetectionexpr_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofileKmdetectionexprBinding: Ended"
    }
}

function Invoke-NSAddBotprofileLogexpressionBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the logexpression that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Logexpression 
        Log expression binding. 
    .PARAMETER Bot_log_expression_name 
        Name of the log expression object. 
    .PARAMETER Bot_log_expression_value 
        Expression whose result to be logged when violation happened on the bot profile. 
    .PARAMETER Bot_log_expression_enabled 
        Enable or disable the log expression binding. 
         
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_logexpression_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotprofileLogexpressionBinding -name <string>
        An example how to add botprofile_logexpression_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotprofileLogexpressionBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_logexpression_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Logexpression,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_log_expression_name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_log_expression_value,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_log_expression_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotprofileLogexpressionBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('logexpression') ) { $payload.Add('logexpression', $logexpression) }
            if ( $PSBoundParameters.ContainsKey('bot_log_expression_name') ) { $payload.Add('bot_log_expression_name', $bot_log_expression_name) }
            if ( $PSBoundParameters.ContainsKey('bot_log_expression_value') ) { $payload.Add('bot_log_expression_value', $bot_log_expression_value) }
            if ( $PSBoundParameters.ContainsKey('bot_log_expression_enabled') ) { $payload.Add('bot_log_expression_enabled', $bot_log_expression_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_logexpression_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_logexpression_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofileLogexpressionBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotprofileLogexpressionBinding: Finished"
    }
}

function Invoke-NSDeleteBotprofileLogexpressionBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the logexpression that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Logexpression 
        Log expression binding. 
    .PARAMETER Bot_log_expression_name 
        Name of the log expression object.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotprofileLogexpressionBinding -Name <string>
        An example how to delete botprofile_logexpression_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotprofileLogexpressionBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_logexpression_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [boolean]$Logexpression,

        [string]$Bot_log_expression_name 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteBotprofileLogexpressionBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Logexpression') ) { $arguments.Add('logexpression', $Logexpression) }
            if ( $PSBoundParameters.ContainsKey('Bot_log_expression_name') ) { $arguments.Add('bot_log_expression_name', $Bot_log_expression_name) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botprofile_logexpression_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotprofileLogexpressionBinding: Finished"
    }
}

function Invoke-NSGetBotprofileLogexpressionBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the logexpression that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_logexpression_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_logexpression_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileLogexpressionBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileLogexpressionBinding -GetAll 
        Get all botprofile_logexpression_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileLogexpressionBinding -Count 
        Get the number of botprofile_logexpression_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileLogexpressionBinding -name <string>
        Get botprofile_logexpression_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileLogexpressionBinding -Filter @{ 'name'='<value>' }
        Get botprofile_logexpression_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofileLogexpressionBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_logexpression_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotprofileLogexpressionBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_logexpression_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_logexpression_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_logexpression_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_logexpression_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_logexpression_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_logexpression_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_logexpression_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_logexpression_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_logexpression_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_logexpression_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofileLogexpressionBinding: Ended"
    }
}

function Invoke-NSAddBotprofileRatelimitBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the ratelimit that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_ratelimit 
        Rate-limit binding. Maximum 30 bindings can be configured per profile for rate-limit detection. For SOURCE_IP type, only one binding can be configured, and for URL type, only one binding is allowed per URL, and for SESSION type, only one binding is allowed for a cookie name. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with new values. 
    .PARAMETER Bot_rate_limit_type 
        Rate-limiting type Following rate-limiting types are allowed: *SOURCE_IP - Rate-limiting based on the client IP. *SESSION - Rate-limiting based on the configured cookie name. *URL - Rate-limiting based on the configured URL. *GEOLOCATION - Rate-limiting based on the configured country name. 
        Possible values = SESSION, SOURCE_IP, URL, GEOLOCATION, JA3_FINGERPRINT 
    .PARAMETER Bot_rate_limit_url 
        URL for the resource based rate-limiting. 
    .PARAMETER Cookiename 
        Cookie name which is used to identify the session for session rate-limiting. 
    .PARAMETER Countrycode 
        Country name which is used for geolocation rate-limiting. 
        Possible values = AF, AX, AL, DZ, AS, AD, AO, AI, AQ, AG, AR, AM, AW, AU, AT, AZ, BS, BH, BD, BB, BY, BE, BZ, BJ, BM, BT, BO, BQ, BA, BW, BR, IO, BN, BG, BF, BI, KH, CM, CA, CV, KY, CF, TD, CL, CN, CX, CC, CO, KM, CG, CD, CK, CR, CI, HR, CU, CW, CY, CZ, DK, DJ, DM, DO, EC, EG, SV, GQ, ER, EE, ET, FK, FO, FJ, FI, FR, GF, PF, TF, GA, GM, GE, DE, GH, GI, GR, GL, GD, GP, GU, GT, GG, GN, GW, GY, HT, HM, VA, HN, HK, HU, IS, IN, ID, IR, IQ, IE, IM, IL, IT, JM, JP, JE, JO, KZ, KE, KI, XK, KW, KG, LA, LV, LB, LS, LR, LY, LI, LT, LU, MO, MK, MG, MW, MY, MV, ML, MT, MH, MQ, MR, MU, YT, MX, FM, MD, MC, MN, ME, MS, MA, MZ, MM, NA, NR, NP, NL, NC, NZ, NI, NE, NG, NU, NF, KP, MP, NO, OM, PK, PW, PS, PA, PG, PY, PE, PH, PN, PL, PT, PR, QA, RE, RO, RU, RW, BL, SH, KN, LC, MF, PM, VC, WS, SM, ST, SA, SN, RS, SC, SL, SG, SX, SK, SI, SB, SO, SZA, GS, KR, SS, ES, LK, SD, SR, SJ, SZ, SE, CH, SY, TW, TJ, TZ, TH, TL, TG, TK, TO, TT, TN, TR, TM, TC, TV, UG, UA, AE, GB, US, UM, UY, UZ, VU, VE, VN, VG, VI, WF, EH, YE, ZM, ZW 
    .PARAMETER Rate 
        Maximum number of requests that are allowed in this session in the given period time. 
    .PARAMETER Timeslice 
        Time interval during which requests are tracked to check if they cross the given rate. 
    .PARAMETER Limittype 
        Rate-Limiting traffic Type. 
         
        Possible values = BURSTY, SMOOTH 
    .PARAMETER Condition 
        Expression to be used in a rate-limiting condition. This expression result must be a boolean value. 
    .PARAMETER Bot_rate_limit_action 
        One or more actions to be taken when the current rate becomes more than the configured rate. Only LOG action can be combined with DROP, REDIRECT or RESET action. 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Bot_rate_limit_enabled 
        Enable or disable rate-limit binding. 
         
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_ratelimit_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotprofileRatelimitBinding -name <string>
        An example how to add botprofile_ratelimit_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotprofileRatelimitBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_ratelimit_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Bot_ratelimit,

        [ValidateSet('SESSION', 'SOURCE_IP', 'URL', 'GEOLOCATION', 'JA3_FINGERPRINT')]
        [string]$Bot_rate_limit_type,

        [string]$Bot_rate_limit_url,

        [string]$Cookiename,

        [ValidateSet('AF', 'AX', 'AL', 'DZ', 'AS', 'AD', 'AO', 'AI', 'AQ', 'AG', 'AR', 'AM', 'AW', 'AU', 'AT', 'AZ', 'BS', 'BH', 'BD', 'BB', 'BY', 'BE', 'BZ', 'BJ', 'BM', 'BT', 'BO', 'BQ', 'BA', 'BW', 'BR', 'IO', 'BN', 'BG', 'BF', 'BI', 'KH', 'CM', 'CA', 'CV', 'KY', 'CF', 'TD', 'CL', 'CN', 'CX', 'CC', 'CO', 'KM', 'CG', 'CD', 'CK', 'CR', 'CI', 'HR', 'CU', 'CW', 'CY', 'CZ', 'DK', 'DJ', 'DM', 'DO', 'EC', 'EG', 'SV', 'GQ', 'ER', 'EE', 'ET', 'FK', 'FO', 'FJ', 'FI', 'FR', 'GF', 'PF', 'TF', 'GA', 'GM', 'GE', 'DE', 'GH', 'GI', 'GR', 'GL', 'GD', 'GP', 'GU', 'GT', 'GG', 'GN', 'GW', 'GY', 'HT', 'HM', 'VA', 'HN', 'HK', 'HU', 'IS', 'IN', 'ID', 'IR', 'IQ', 'IE', 'IM', 'IL', 'IT', 'JM', 'JP', 'JE', 'JO', 'KZ', 'KE', 'KI', 'XK', 'KW', 'KG', 'LA', 'LV', 'LB', 'LS', 'LR', 'LY', 'LI', 'LT', 'LU', 'MO', 'MK', 'MG', 'MW', 'MY', 'MV', 'ML', 'MT', 'MH', 'MQ', 'MR', 'MU', 'YT', 'MX', 'FM', 'MD', 'MC', 'MN', 'ME', 'MS', 'MA', 'MZ', 'MM', 'NA', 'NR', 'NP', 'NL', 'NC', 'NZ', 'NI', 'NE', 'NG', 'NU', 'NF', 'KP', 'MP', 'NO', 'OM', 'PK', 'PW', 'PS', 'PA', 'PG', 'PY', 'PE', 'PH', 'PN', 'PL', 'PT', 'PR', 'QA', 'RE', 'RO', 'RU', 'RW', 'BL', 'SH', 'KN', 'LC', 'MF', 'PM', 'VC', 'WS', 'SM', 'ST', 'SA', 'SN', 'RS', 'SC', 'SL', 'SG', 'SX', 'SK', 'SI', 'SB', 'SO', 'SZA', 'GS', 'KR', 'SS', 'ES', 'LK', 'SD', 'SR', 'SJ', 'SZ', 'SE', 'CH', 'SY', 'TW', 'TJ', 'TZ', 'TH', 'TL', 'TG', 'TK', 'TO', 'TT', 'TN', 'TR', 'TM', 'TC', 'TV', 'UG', 'UA', 'AE', 'GB', 'US', 'UM', 'UY', 'UZ', 'VU', 'VE', 'VN', 'VG', 'VI', 'WF', 'EH', 'YE', 'ZM', 'ZW')]
        [string]$Countrycode,

        [double]$Rate = '1',

        [double]$Timeslice = '1000',

        [ValidateSet('BURSTY', 'SMOOTH')]
        [string]$Limittype = 'BURSTY',

        [string]$Condition,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Bot_rate_limit_action = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_rate_limit_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotprofileRatelimitBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('bot_ratelimit') ) { $payload.Add('bot_ratelimit', $bot_ratelimit) }
            if ( $PSBoundParameters.ContainsKey('bot_rate_limit_type') ) { $payload.Add('bot_rate_limit_type', $bot_rate_limit_type) }
            if ( $PSBoundParameters.ContainsKey('bot_rate_limit_url') ) { $payload.Add('bot_rate_limit_url', $bot_rate_limit_url) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('countrycode') ) { $payload.Add('countrycode', $countrycode) }
            if ( $PSBoundParameters.ContainsKey('rate') ) { $payload.Add('rate', $rate) }
            if ( $PSBoundParameters.ContainsKey('timeslice') ) { $payload.Add('timeslice', $timeslice) }
            if ( $PSBoundParameters.ContainsKey('limittype') ) { $payload.Add('limittype', $limittype) }
            if ( $PSBoundParameters.ContainsKey('condition') ) { $payload.Add('condition', $condition) }
            if ( $PSBoundParameters.ContainsKey('bot_rate_limit_action') ) { $payload.Add('bot_rate_limit_action', $bot_rate_limit_action) }
            if ( $PSBoundParameters.ContainsKey('bot_rate_limit_enabled') ) { $payload.Add('bot_rate_limit_enabled', $bot_rate_limit_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_ratelimit_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_ratelimit_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofileRatelimitBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotprofileRatelimitBinding: Finished"
    }
}

function Invoke-NSDeleteBotprofileRatelimitBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the ratelimit that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_ratelimit 
        Rate-limit binding. Maximum 30 bindings can be configured per profile for rate-limit detection. For SOURCE_IP type, only one binding can be configured, and for URL type, only one binding is allowed per URL, and for SESSION type, only one binding is allowed for a cookie name. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with new values. 
    .PARAMETER Bot_rate_limit_type 
        Rate-limiting type Following rate-limiting types are allowed: *SOURCE_IP - Rate-limiting based on the client IP. *SESSION - Rate-limiting based on the configured cookie name. *URL - Rate-limiting based on the configured URL. *GEOLOCATION - Rate-limiting based on the configured country name. 
        Possible values = SESSION, SOURCE_IP, URL, GEOLOCATION, JA3_FINGERPRINT 
    .PARAMETER Bot_rate_limit_url 
        URL for the resource based rate-limiting. 
    .PARAMETER Cookiename 
        Cookie name which is used to identify the session for session rate-limiting. 
    .PARAMETER Countrycode 
        Country name which is used for geolocation rate-limiting. 
        Possible values = AF, AX, AL, DZ, AS, AD, AO, AI, AQ, AG, AR, AM, AW, AU, AT, AZ, BS, BH, BD, BB, BY, BE, BZ, BJ, BM, BT, BO, BQ, BA, BW, BR, IO, BN, BG, BF, BI, KH, CM, CA, CV, KY, CF, TD, CL, CN, CX, CC, CO, KM, CG, CD, CK, CR, CI, HR, CU, CW, CY, CZ, DK, DJ, DM, DO, EC, EG, SV, GQ, ER, EE, ET, FK, FO, FJ, FI, FR, GF, PF, TF, GA, GM, GE, DE, GH, GI, GR, GL, GD, GP, GU, GT, GG, GN, GW, GY, HT, HM, VA, HN, HK, HU, IS, IN, ID, IR, IQ, IE, IM, IL, IT, JM, JP, JE, JO, KZ, KE, KI, XK, KW, KG, LA, LV, LB, LS, LR, LY, LI, LT, LU, MO, MK, MG, MW, MY, MV, ML, MT, MH, MQ, MR, MU, YT, MX, FM, MD, MC, MN, ME, MS, MA, MZ, MM, NA, NR, NP, NL, NC, NZ, NI, NE, NG, NU, NF, KP, MP, NO, OM, PK, PW, PS, PA, PG, PY, PE, PH, PN, PL, PT, PR, QA, RE, RO, RU, RW, BL, SH, KN, LC, MF, PM, VC, WS, SM, ST, SA, SN, RS, SC, SL, SG, SX, SK, SI, SB, SO, SZA, GS, KR, SS, ES, LK, SD, SR, SJ, SZ, SE, CH, SY, TW, TJ, TZ, TH, TL, TG, TK, TO, TT, TN, TR, TM, TC, TV, UG, UA, AE, GB, US, UM, UY, UZ, VU, VE, VN, VG, VI, WF, EH, YE, ZM, ZW 
    .PARAMETER Condition 
        Expression to be used in a rate-limiting condition. This expression result must be a boolean value.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotprofileRatelimitBinding -Name <string>
        An example how to delete botprofile_ratelimit_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotprofileRatelimitBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_ratelimit_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [boolean]$Bot_ratelimit,

        [string]$Bot_rate_limit_type,

        [string]$Bot_rate_limit_url,

        [string]$Cookiename,

        [string]$Countrycode,

        [string]$Condition 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteBotprofileRatelimitBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Bot_ratelimit') ) { $arguments.Add('bot_ratelimit', $Bot_ratelimit) }
            if ( $PSBoundParameters.ContainsKey('Bot_rate_limit_type') ) { $arguments.Add('bot_rate_limit_type', $Bot_rate_limit_type) }
            if ( $PSBoundParameters.ContainsKey('Bot_rate_limit_url') ) { $arguments.Add('bot_rate_limit_url', $Bot_rate_limit_url) }
            if ( $PSBoundParameters.ContainsKey('Cookiename') ) { $arguments.Add('cookiename', $Cookiename) }
            if ( $PSBoundParameters.ContainsKey('Countrycode') ) { $arguments.Add('countrycode', $Countrycode) }
            if ( $PSBoundParameters.ContainsKey('Condition') ) { $arguments.Add('condition', $Condition) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotprofileRatelimitBinding: Finished"
    }
}

function Invoke-NSGetBotprofileRatelimitBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the ratelimit that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_ratelimit_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_ratelimit_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileRatelimitBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileRatelimitBinding -GetAll 
        Get all botprofile_ratelimit_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileRatelimitBinding -Count 
        Get the number of botprofile_ratelimit_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileRatelimitBinding -name <string>
        Get botprofile_ratelimit_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileRatelimitBinding -Filter @{ 'name'='<value>' }
        Get botprofile_ratelimit_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofileRatelimitBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_ratelimit_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotprofileRatelimitBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_ratelimit_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_ratelimit_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_ratelimit_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_ratelimit_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_ratelimit_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofileRatelimitBinding: Ended"
    }
}

function Invoke-NSAddBotprofileTpsBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the tps that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_tps 
        TPS binding. For each type only binding can be configured. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with new values. 
    .PARAMETER Bot_tps_type 
        Type of TPS binding. 
        Possible values = SOURCE_IP, GEOLOCATION, REQUEST_URL, Host 
    .PARAMETER Threshold 
        Maximum number of requests that are allowed from (or to) a IP, Geolocation, URL or Host in 1 second time interval. 
    .PARAMETER Percentage 
        Maximum percentage increase in the requests from (or to) a IP, Geolocation, URL or Host in 30 minutes interval. 
    .PARAMETER Bot_tps_action 
        One to more actions to be taken if bot is detected based on this TPS binding. Only LOG action can be combined with DROP, RESET, REDIRECT, or MITIGIATION action. 
         
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER Bot_tps_enabled 
        Enabled or disabled TPS binding. 
         
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_tps_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotprofileTpsBinding -name <string>
        An example how to add botprofile_tps_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotprofileTpsBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_tps_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Bot_tps,

        [ValidateSet('SOURCE_IP', 'GEOLOCATION', 'REQUEST_URL', 'Host')]
        [string]$Bot_tps_type,

        [double]$Threshold,

        [double]$Percentage,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$Bot_tps_action = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_tps_enabled = 'ON',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotprofileTpsBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('bot_tps') ) { $payload.Add('bot_tps', $bot_tps) }
            if ( $PSBoundParameters.ContainsKey('bot_tps_type') ) { $payload.Add('bot_tps_type', $bot_tps_type) }
            if ( $PSBoundParameters.ContainsKey('threshold') ) { $payload.Add('threshold', $threshold) }
            if ( $PSBoundParameters.ContainsKey('percentage') ) { $payload.Add('percentage', $percentage) }
            if ( $PSBoundParameters.ContainsKey('bot_tps_action') ) { $payload.Add('bot_tps_action', $bot_tps_action) }
            if ( $PSBoundParameters.ContainsKey('bot_tps_enabled') ) { $payload.Add('bot_tps_enabled', $bot_tps_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_tps_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_tps_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofileTpsBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotprofileTpsBinding: Finished"
    }
}

function Invoke-NSDeleteBotprofileTpsBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the tps that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_tps 
        TPS binding. For each type only binding can be configured. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with new values. 
    .PARAMETER Bot_tps_type 
        Type of TPS binding. 
        Possible values = SOURCE_IP, GEOLOCATION, REQUEST_URL, Host
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotprofileTpsBinding -Name <string>
        An example how to delete botprofile_tps_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotprofileTpsBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_tps_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [boolean]$Bot_tps,

        [string]$Bot_tps_type 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteBotprofileTpsBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Bot_tps') ) { $arguments.Add('bot_tps', $Bot_tps) }
            if ( $PSBoundParameters.ContainsKey('Bot_tps_type') ) { $arguments.Add('bot_tps_type', $Bot_tps_type) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botprofile_tps_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotprofileTpsBinding: Finished"
    }
}

function Invoke-NSGetBotprofileTpsBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the tps that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_tps_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_tps_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileTpsBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileTpsBinding -GetAll 
        Get all botprofile_tps_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileTpsBinding -Count 
        Get the number of botprofile_tps_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileTpsBinding -name <string>
        Get botprofile_tps_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileTpsBinding -Filter @{ 'name'='<value>' }
        Get botprofile_tps_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofileTpsBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_tps_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotprofileTpsBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_tps_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_tps_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_tps_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_tps_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_tps_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofileTpsBinding: Ended"
    }
}

function Invoke-NSAddBotprofileTrapinsertionurlBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the trapinsertionurl that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Trapinsertionurl 
        Bind the trap URL for the configured request URLs. Maximum 30 bindings can be configured per profile. 
    .PARAMETER Bot_trap_url 
        Request URL regex pattern for which Trap URL is inserted. 
    .PARAMETER Bot_trap_url_insertion_enabled 
        Enable or disable the request URL pattern. 
         
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_trapinsertionurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotprofileTrapinsertionurlBinding -name <string>
        An example how to add botprofile_trapinsertionurl_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotprofileTrapinsertionurlBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_trapinsertionurl_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Trapinsertionurl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_trap_url,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_trap_url_insertion_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotprofileTrapinsertionurlBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('trapinsertionurl') ) { $payload.Add('trapinsertionurl', $trapinsertionurl) }
            if ( $PSBoundParameters.ContainsKey('bot_trap_url') ) { $payload.Add('bot_trap_url', $bot_trap_url) }
            if ( $PSBoundParameters.ContainsKey('bot_trap_url_insertion_enabled') ) { $payload.Add('bot_trap_url_insertion_enabled', $bot_trap_url_insertion_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_trapinsertionurl_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_trapinsertionurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofileTrapinsertionurlBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotprofileTrapinsertionurlBinding: Finished"
    }
}

function Invoke-NSDeleteBotprofileTrapinsertionurlBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the trapinsertionurl that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Trapinsertionurl 
        Bind the trap URL for the configured request URLs. Maximum 30 bindings can be configured per profile. 
    .PARAMETER Bot_trap_url 
        Request URL regex pattern for which Trap URL is inserted.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotprofileTrapinsertionurlBinding -Name <string>
        An example how to delete botprofile_trapinsertionurl_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotprofileTrapinsertionurlBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_trapinsertionurl_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [boolean]$Trapinsertionurl,

        [string]$Bot_trap_url 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteBotprofileTrapinsertionurlBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Trapinsertionurl') ) { $arguments.Add('trapinsertionurl', $Trapinsertionurl) }
            if ( $PSBoundParameters.ContainsKey('Bot_trap_url') ) { $arguments.Add('bot_trap_url', $Bot_trap_url) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botprofile_trapinsertionurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotprofileTrapinsertionurlBinding: Finished"
    }
}

function Invoke-NSGetBotprofileTrapinsertionurlBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the trapinsertionurl that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_trapinsertionurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_trapinsertionurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileTrapinsertionurlBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileTrapinsertionurlBinding -GetAll 
        Get all botprofile_trapinsertionurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileTrapinsertionurlBinding -Count 
        Get the number of botprofile_trapinsertionurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileTrapinsertionurlBinding -name <string>
        Get botprofile_trapinsertionurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileTrapinsertionurlBinding -Filter @{ 'name'='<value>' }
        Get botprofile_trapinsertionurl_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofileTrapinsertionurlBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_trapinsertionurl_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotprofileTrapinsertionurlBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_trapinsertionurl_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_trapinsertionurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_trapinsertionurl_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_trapinsertionurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_trapinsertionurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_trapinsertionurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_trapinsertionurl_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_trapinsertionurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_trapinsertionurl_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_trapinsertionurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofileTrapinsertionurlBinding: Ended"
    }
}

function Invoke-NSAddBotprofileWhitelistBinding {
    <#
    .SYNOPSIS
        Add Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the whitelist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_whitelist 
        Whitelist binding. Maximum 32 bindings can be configured per profile for Whitelist detection. 
    .PARAMETER Bot_whitelist_type 
        Type of the white-list entry. 
        Possible values = IPv4, SUBNET, IPv6, IPv6_SUBNET, EXPRESSION 
    .PARAMETER Bot_whitelist_value 
        Value of bot white-list entry. 
    .PARAMETER Log 
        Enable logging for Whitelist binding. 
         
        Possible values = ON, OFF 
    .PARAMETER Bot_whitelist_enabled 
        Enabled or disabled white-list binding. 
         
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_whitelist_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddBotprofileWhitelistBinding -name <string>
        An example how to add botprofile_whitelist_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddBotprofileWhitelistBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_whitelist_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Bot_whitelist,

        [ValidateSet('IPv4', 'SUBNET', 'IPv6', 'IPv6_SUBNET', 'EXPRESSION')]
        [string]$Bot_whitelist_type,

        [string]$Bot_whitelist_value,

        [ValidateSet('ON', 'OFF')]
        [string]$Log = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_whitelist_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddBotprofileWhitelistBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('bot_whitelist') ) { $payload.Add('bot_whitelist', $bot_whitelist) }
            if ( $PSBoundParameters.ContainsKey('bot_whitelist_type') ) { $payload.Add('bot_whitelist_type', $bot_whitelist_type) }
            if ( $PSBoundParameters.ContainsKey('bot_whitelist_value') ) { $payload.Add('bot_whitelist_value', $bot_whitelist_value) }
            if ( $PSBoundParameters.ContainsKey('log') ) { $payload.Add('log', $log) }
            if ( $PSBoundParameters.ContainsKey('bot_whitelist_enabled') ) { $payload.Add('bot_whitelist_enabled', $bot_whitelist_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_whitelist_binding", "Add Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_whitelist_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotprofileWhitelistBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddBotprofileWhitelistBinding: Finished"
    }
}

function Invoke-NSDeleteBotprofileWhitelistBinding {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Binding object showing the whitelist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_whitelist 
        Whitelist binding. Maximum 32 bindings can be configured per profile for Whitelist detection. 
    .PARAMETER Bot_whitelist_value 
        Value of bot white-list entry.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotprofileWhitelistBinding -Name <string>
        An example how to delete botprofile_whitelist_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotprofileWhitelistBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_whitelist_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [boolean]$Bot_whitelist,

        [string]$Bot_whitelist_value 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteBotprofileWhitelistBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Bot_whitelist') ) { $arguments.Add('bot_whitelist', $Bot_whitelist) }
            if ( $PSBoundParameters.ContainsKey('Bot_whitelist_value') ) { $arguments.Add('bot_whitelist_value', $Bot_whitelist_value) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotprofileWhitelistBinding: Finished"
    }
}

function Invoke-NSGetBotprofileWhitelistBinding {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Binding object showing the whitelist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_whitelist_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_whitelist_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileWhitelistBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileWhitelistBinding -GetAll 
        Get all botprofile_whitelist_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotprofileWhitelistBinding -Count 
        Get the number of botprofile_whitelist_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileWhitelistBinding -name <string>
        Get botprofile_whitelist_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotprofileWhitelistBinding -Filter @{ 'name'='<value>' }
        Get botprofile_whitelist_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotprofileWhitelistBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botprofile_whitelist_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetBotprofileWhitelistBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_whitelist_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_whitelist_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_whitelist_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_whitelist_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_whitelist_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotprofileWhitelistBinding: Ended"
    }
}

function Invoke-NSUpdateBotsettings {
    <#
    .SYNOPSIS
        Update Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot engine settings resource.
    .PARAMETER Defaultprofile 
        Profile to use when a connection does not match any policy. Default setting is " ", which sends unmatched connections back to the Citrix ADC without attempting to filter them further. 
    .PARAMETER Defaultnonintrusiveprofile 
        Profile to use when the feature is not enabled but feature is licensed. NonIntrusive checks will be disabled and IPRep cronjob(24 Hours) will be removed if this is set to BOT_BYPASS. 
         
         
        Possible values = BOT_BYPASS, BOT_STATS, BOT_LOG 
    .PARAMETER Javascriptname 
        Name of the JavaScript that the Bot Management feature uses in response. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, after which a user session is terminated. 
         
        Maximum value = 65535 
    .PARAMETER Sessioncookiename 
        Name of the SessionCookie that the Bot Management feature uses for tracking. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Dfprequestlimit 
        Number of requests to allow without bot session cookie if device fingerprint is enabled. 
    .PARAMETER Signatureautoupdate 
        Flag used to enable/disable bot auto update signatures. 
         
        Possible values = ON, OFF 
    .PARAMETER Signatureurl 
        URL to download the bot signature mapping file from server. 
    .PARAMETER Proxyserver 
        Proxy Server IP to get updated signatures from AWS. 
    .PARAMETER Proxyport 
        Proxy Server Port to get updated signatures from AWS. 
    .PARAMETER Trapurlautogenerate 
        Enable/disable trap URL auto generation. When enabled, trap URL is updated within the configured interval. 
         
        Possible values = ON, OFF 
    .PARAMETER Trapurlinterval 
        Time in seconds after which trap URL is updated. 
         
         
        Maximum value = 86400 
    .PARAMETER Trapurllength 
        Length of the auto-generated trap URL. 
         
         
        Maximum value = 255 
    .PARAMETER Proxyusername 
        Proxy Username. 
    .PARAMETER Proxypassword 
        Password with which user logs on.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateBotsettings 
        An example how to update botsettings config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateBotsettings
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botsettings/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Defaultprofile,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidateSet('BOT_BYPASS', 'BOT_STATS', 'BOT_LOG')]
        [string]$Defaultnonintrusiveprofile,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Javascriptname,

        [double]$Sessiontimeout,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sessioncookiename,

        [double]$Dfprequestlimit,

        [ValidateSet('ON', 'OFF')]
        [string]$Signatureautoupdate,

        [string]$Signatureurl,

        [string]$Proxyserver,

        [ValidateRange(1, 65535)]
        [int]$Proxyport,

        [ValidateSet('ON', 'OFF')]
        [string]$Trapurlautogenerate,

        [double]$Trapurlinterval,

        [double]$Trapurllength,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Proxyusername,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Proxypassword 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateBotsettings: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('defaultprofile') ) { $payload.Add('defaultprofile', $defaultprofile) }
            if ( $PSBoundParameters.ContainsKey('defaultnonintrusiveprofile') ) { $payload.Add('defaultnonintrusiveprofile', $defaultnonintrusiveprofile) }
            if ( $PSBoundParameters.ContainsKey('javascriptname') ) { $payload.Add('javascriptname', $javascriptname) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('sessioncookiename') ) { $payload.Add('sessioncookiename', $sessioncookiename) }
            if ( $PSBoundParameters.ContainsKey('dfprequestlimit') ) { $payload.Add('dfprequestlimit', $dfprequestlimit) }
            if ( $PSBoundParameters.ContainsKey('signatureautoupdate') ) { $payload.Add('signatureautoupdate', $signatureautoupdate) }
            if ( $PSBoundParameters.ContainsKey('signatureurl') ) { $payload.Add('signatureurl', $signatureurl) }
            if ( $PSBoundParameters.ContainsKey('proxyserver') ) { $payload.Add('proxyserver', $proxyserver) }
            if ( $PSBoundParameters.ContainsKey('proxyport') ) { $payload.Add('proxyport', $proxyport) }
            if ( $PSBoundParameters.ContainsKey('trapurlautogenerate') ) { $payload.Add('trapurlautogenerate', $trapurlautogenerate) }
            if ( $PSBoundParameters.ContainsKey('trapurlinterval') ) { $payload.Add('trapurlinterval', $trapurlinterval) }
            if ( $PSBoundParameters.ContainsKey('trapurllength') ) { $payload.Add('trapurllength', $trapurllength) }
            if ( $PSBoundParameters.ContainsKey('proxyusername') ) { $payload.Add('proxyusername', $proxyusername) }
            if ( $PSBoundParameters.ContainsKey('proxypassword') ) { $payload.Add('proxypassword', $proxypassword) }
            if ( $PSCmdlet.ShouldProcess("botsettings", "Update Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type botsettings -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateBotsettings: Finished"
    }
}

function Invoke-NSUnsetBotsettings {
    <#
    .SYNOPSIS
        Unset Bot Management. config Object.
    .DESCRIPTION
        Configuration for Bot engine settings resource.
    .PARAMETER Defaultprofile 
        Profile to use when a connection does not match any policy. Default setting is " ", which sends unmatched connections back to the Citrix ADC without attempting to filter them further. 
    .PARAMETER Defaultnonintrusiveprofile 
        Profile to use when the feature is not enabled but feature is licensed. NonIntrusive checks will be disabled and IPRep cronjob(24 Hours) will be removed if this is set to BOT_BYPASS. 
         
         
        Possible values = BOT_BYPASS, BOT_STATS, BOT_LOG 
    .PARAMETER Javascriptname 
        Name of the JavaScript that the Bot Management feature uses in response. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, after which a user session is terminated. 
         
        Maximum value = 65535 
    .PARAMETER Sessioncookiename 
        Name of the SessionCookie that the Bot Management feature uses for tracking. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Dfprequestlimit 
        Number of requests to allow without bot session cookie if device fingerprint is enabled. 
    .PARAMETER Signatureautoupdate 
        Flag used to enable/disable bot auto update signatures. 
         
        Possible values = ON, OFF 
    .PARAMETER Signatureurl 
        URL to download the bot signature mapping file from server. 
    .PARAMETER Proxyserver 
        Proxy Server IP to get updated signatures from AWS. 
    .PARAMETER Proxyport 
        Proxy Server Port to get updated signatures from AWS. 
    .PARAMETER Trapurlautogenerate 
        Enable/disable trap URL auto generation. When enabled, trap URL is updated within the configured interval. 
         
        Possible values = ON, OFF 
    .PARAMETER Trapurlinterval 
        Time in seconds after which trap URL is updated. 
         
         
        Maximum value = 86400 
    .PARAMETER Trapurllength 
        Length of the auto-generated trap URL. 
         
         
        Maximum value = 255 
    .PARAMETER Proxyusername 
        Proxy Username. 
    .PARAMETER Proxypassword 
        Password with which user logs on.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetBotsettings 
        An example how to unset botsettings config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetBotsettings
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botsettings
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$defaultprofile,

        [Boolean]$defaultnonintrusiveprofile,

        [Boolean]$javascriptname,

        [Boolean]$sessiontimeout,

        [Boolean]$sessioncookiename,

        [Boolean]$dfprequestlimit,

        [Boolean]$signatureautoupdate,

        [Boolean]$signatureurl,

        [Boolean]$proxyserver,

        [Boolean]$proxyport,

        [Boolean]$trapurlautogenerate,

        [Boolean]$trapurlinterval,

        [Boolean]$trapurllength,

        [Boolean]$proxyusername,

        [Boolean]$proxypassword 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetBotsettings: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('defaultprofile') ) { $payload.Add('defaultprofile', $defaultprofile) }
            if ( $PSBoundParameters.ContainsKey('defaultnonintrusiveprofile') ) { $payload.Add('defaultnonintrusiveprofile', $defaultnonintrusiveprofile) }
            if ( $PSBoundParameters.ContainsKey('javascriptname') ) { $payload.Add('javascriptname', $javascriptname) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('sessioncookiename') ) { $payload.Add('sessioncookiename', $sessioncookiename) }
            if ( $PSBoundParameters.ContainsKey('dfprequestlimit') ) { $payload.Add('dfprequestlimit', $dfprequestlimit) }
            if ( $PSBoundParameters.ContainsKey('signatureautoupdate') ) { $payload.Add('signatureautoupdate', $signatureautoupdate) }
            if ( $PSBoundParameters.ContainsKey('signatureurl') ) { $payload.Add('signatureurl', $signatureurl) }
            if ( $PSBoundParameters.ContainsKey('proxyserver') ) { $payload.Add('proxyserver', $proxyserver) }
            if ( $PSBoundParameters.ContainsKey('proxyport') ) { $payload.Add('proxyport', $proxyport) }
            if ( $PSBoundParameters.ContainsKey('trapurlautogenerate') ) { $payload.Add('trapurlautogenerate', $trapurlautogenerate) }
            if ( $PSBoundParameters.ContainsKey('trapurlinterval') ) { $payload.Add('trapurlinterval', $trapurlinterval) }
            if ( $PSBoundParameters.ContainsKey('trapurllength') ) { $payload.Add('trapurllength', $trapurllength) }
            if ( $PSBoundParameters.ContainsKey('proxyusername') ) { $payload.Add('proxyusername', $proxyusername) }
            if ( $PSBoundParameters.ContainsKey('proxypassword') ) { $payload.Add('proxypassword', $proxypassword) }
            if ( $PSCmdlet.ShouldProcess("botsettings", "Unset Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type botsettings -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetBotsettings: Finished"
    }
}

function Invoke-NSGetBotsettings {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Configuration for Bot engine settings resource.
    .PARAMETER GetAll 
        Retrieve all botsettings object(s).
    .PARAMETER Count
        If specified, the count of the botsettings object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotsettings
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotsettings -GetAll 
        Get all botsettings data.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotsettings -name <string>
        Get botsettings object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotsettings -Filter @{ 'name'='<value>' }
        Get botsettings data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotsettings
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botsettings/
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
        Write-Verbose "Invoke-NSGetBotsettings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all botsettings objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botsettings objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botsettings objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botsettings configuration for property ''"

            } else {
                Write-Verbose "Retrieving botsettings configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotsettings: Ended"
    }
}

function Invoke-NSImportBotsignature {
    <#
    .SYNOPSIS
        Import Bot Management. config Object.
    .DESCRIPTION
        Configuration for bot signatures resource.
    .PARAMETER Src 
        Local path to and name of, or URL (protocol, host, path, and file name) for, the file in which to store the imported signature file. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Name 
        Name to assign to the bot signature file object on the Citrix ADC. 
    .PARAMETER Comment 
        Any comments to preserve information about the signature file object. 
    .PARAMETER Overwrite 
        Overwrites the existing file.
    .EXAMPLE
        PS C:\>Invoke-NSImportBotsignature -name <string>
        An example how to import botsignature config Object(s).
    .NOTES
        File Name : Invoke-NSImportBotsignature
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botsignature/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateLength(1, 31)]
        [string]$Name,

        [string]$Comment,

        [boolean]$Overwrite 

    )
    begin {
        Write-Verbose "Invoke-NSImportBotsignature: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('src') ) { $payload.Add('src', $src) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type botsignature -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSImportBotsignature: Finished"
    }
}

function Invoke-NSDeleteBotsignature {
    <#
    .SYNOPSIS
        Delete Bot Management. config Object.
    .DESCRIPTION
        Configuration for bot signatures resource.
    .PARAMETER Name 
        Name to assign to the bot signature file object on the Citrix ADC.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteBotsignature -Name <string>
        An example how to delete botsignature config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteBotsignature
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botsignature/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteBotsignature: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot Management. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type botsignature -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteBotsignature: Finished"
    }
}

function Invoke-NSChangeBotsignature {
    <#
    .SYNOPSIS
        Change Bot Management. config Object.
    .DESCRIPTION
        Configuration for bot signatures resource.
    .PARAMETER Name 
        Name to assign to the bot signature file object on the Citrix ADC. 
    .PARAMETER PassThru 
        Return details about the created botsignature item.
    .EXAMPLE
        PS C:\>Invoke-NSChangeBotsignature -name <string>
        An example how to change botsignature config Object(s).
    .NOTES
        File Name : Invoke-NSChangeBotsignature
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botsignature/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSChangeBotsignature: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess("botsignature", "Change Bot Management. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type botsignature -Action update -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetBotsignature -Filter $payload)
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
        Write-Verbose "Invoke-NSChangeBotsignature: Finished"
    }
}

function Invoke-NSGetBotsignature {
    <#
    .SYNOPSIS
        Get Bot Management. config object(s).
    .DESCRIPTION
        Configuration for bot signatures resource.
    .PARAMETER Name 
        Name to assign to the bot signature file object on the Citrix ADC. 
    .PARAMETER GetAll 
        Retrieve all botsignature object(s).
    .PARAMETER Count
        If specified, the count of the botsignature object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotsignature
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetBotsignature -GetAll 
        Get all botsignature data.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotsignature -name <string>
        Get botsignature object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetBotsignature -Filter @{ 'name'='<value>' }
        Get botsignature data with a filter.
    .NOTES
        File Name : Invoke-NSGetBotsignature
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/bot/botsignature/
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
        [ValidateLength(1, 31)]
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetBotsignature: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all botsignature objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botsignature objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botsignature objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botsignature configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botsignature configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetBotsignature: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCD9CYS59Rp/Vndq
# 7hznkLOJ9JthBRdEv5sXFlbzcQd9JqCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQg/AU9HWKCQexGePzbuAwnA0csOwc0UthvJvXLsVgIL0YwDQYJKoZIhvcNAQEB
# BQAEggEAFCNSKaZIeqxrvbIkcLUepLh2kNHuJ6FcpTBkGImmau7OUVPMmr+uc4tr
# wMyM2hjqQv8a+PAMZQz4byLygvh4zCXpDVeYZT7Mba0eaeeZMmjdHkkUQ237oeXG
# O1hQzdhaZHDcp9kiPPfwp4PX055g3cgOjtXEGsDWDQeo5g40bDQ7WrFH2TuVTxRU
# bhBAc4kw1frMgc/4sBTbePWfUNLQ0JI741qHCSzdb+wbIQPNdDrNdmg5MIbUiKyF
# nlrU6QrKp7n/Wg5f0Zfa00d1z26rYHJ/00ssVn6UsibSZ+ys76YBsZBGAJ3gD4Ud
# UBJ2dnY1feYkHMv7Z0Q7L+jiM0pv7w==
# SIG # End signature block
