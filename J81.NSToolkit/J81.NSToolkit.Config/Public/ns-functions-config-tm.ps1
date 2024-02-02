function Invoke-NSAddTmformssoaction {
    <#
    .SYNOPSIS
        Add TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for Form sso action resource.
    .PARAMETER Name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Actionurl 
        URL to which the completed form is submitted. 
    .PARAMETER Userfield 
        Name of the form field in which the user types in the user ID. 
    .PARAMETER Passwdfield 
        Name of the form field in which the user types in the password. 
    .PARAMETER Ssosuccessrule 
        Expression, that checks to see if single sign-on is successful. 
    .PARAMETER Namevaluepair 
        Name-value pair attributes to send to the server in addition to sending the username and password. Value names are separated by an ampersand (&amp;) (for example, name1=value1&amp;name2=value2). 
    .PARAMETER Responsesize 
        Number of bytes, in the response, to parse for extracting the forms. 
    .PARAMETER Nvtype 
        Type of processing of the name-value pair. If you specify STATIC, the values configured by the administrator are used. For DYNAMIC, the response is parsed, and the form is extracted and then submitted. 
         
        Possible values = STATIC, DYNAMIC 
    .PARAMETER Submitmethod 
        HTTP method used by the single sign-on form to send the logon credentials to the logon server. Applies only to STATIC name-value type. 
         
        Possible values = GET, POST 
    .PARAMETER PassThru 
        Return details about the created tmformssoaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddTmformssoaction -name <string> -actionurl <string> -userfield <string> -passwdfield <string> -ssosuccessrule <string>
        An example how to add tmformssoaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddTmformssoaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmformssoaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Actionurl,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Userfield,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Passwdfield,

        [Parameter(Mandatory)]
        [string]$Ssosuccessrule,

        [string]$Namevaluepair,

        [double]$Responsesize = '8096',

        [ValidateSet('STATIC', 'DYNAMIC')]
        [string]$Nvtype = 'DYNAMIC',

        [ValidateSet('GET', 'POST')]
        [string]$Submitmethod = 'GET',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddTmformssoaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                actionurl      = $actionurl
                userfield      = $userfield
                passwdfield    = $passwdfield
                ssosuccessrule = $ssosuccessrule
            }
            if ( $PSBoundParameters.ContainsKey('namevaluepair') ) { $payload.Add('namevaluepair', $namevaluepair) }
            if ( $PSBoundParameters.ContainsKey('responsesize') ) { $payload.Add('responsesize', $responsesize) }
            if ( $PSBoundParameters.ContainsKey('nvtype') ) { $payload.Add('nvtype', $nvtype) }
            if ( $PSBoundParameters.ContainsKey('submitmethod') ) { $payload.Add('submitmethod', $submitmethod) }
            if ( $PSCmdlet.ShouldProcess("tmformssoaction", "Add TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type tmformssoaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmformssoaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddTmformssoaction: Finished"
    }
}

function Invoke-NSDeleteTmformssoaction {
    <#
    .SYNOPSIS
        Delete TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for Form sso action resource.
    .PARAMETER Name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteTmformssoaction -Name <string>
        An example how to delete tmformssoaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteTmformssoaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmformssoaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteTmformssoaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type tmformssoaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteTmformssoaction: Finished"
    }
}

function Invoke-NSUpdateTmformssoaction {
    <#
    .SYNOPSIS
        Update TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for Form sso action resource.
    .PARAMETER Name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Actionurl 
        URL to which the completed form is submitted. 
    .PARAMETER Userfield 
        Name of the form field in which the user types in the user ID. 
    .PARAMETER Passwdfield 
        Name of the form field in which the user types in the password. 
    .PARAMETER Ssosuccessrule 
        Expression, that checks to see if single sign-on is successful. 
    .PARAMETER Responsesize 
        Number of bytes, in the response, to parse for extracting the forms. 
    .PARAMETER Namevaluepair 
        Name-value pair attributes to send to the server in addition to sending the username and password. Value names are separated by an ampersand (&amp;) (for example, name1=value1&amp;name2=value2). 
    .PARAMETER Nvtype 
        Type of processing of the name-value pair. If you specify STATIC, the values configured by the administrator are used. For DYNAMIC, the response is parsed, and the form is extracted and then submitted. 
         
        Possible values = STATIC, DYNAMIC 
    .PARAMETER Submitmethod 
        HTTP method used by the single sign-on form to send the logon credentials to the logon server. Applies only to STATIC name-value type. 
         
        Possible values = GET, POST 
    .PARAMETER PassThru 
        Return details about the created tmformssoaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateTmformssoaction -name <string>
        An example how to update tmformssoaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateTmformssoaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmformssoaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Actionurl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Userfield,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Passwdfield,

        [string]$Ssosuccessrule,

        [double]$Responsesize,

        [string]$Namevaluepair,

        [ValidateSet('STATIC', 'DYNAMIC')]
        [string]$Nvtype,

        [ValidateSet('GET', 'POST')]
        [string]$Submitmethod,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateTmformssoaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('actionurl') ) { $payload.Add('actionurl', $actionurl) }
            if ( $PSBoundParameters.ContainsKey('userfield') ) { $payload.Add('userfield', $userfield) }
            if ( $PSBoundParameters.ContainsKey('passwdfield') ) { $payload.Add('passwdfield', $passwdfield) }
            if ( $PSBoundParameters.ContainsKey('ssosuccessrule') ) { $payload.Add('ssosuccessrule', $ssosuccessrule) }
            if ( $PSBoundParameters.ContainsKey('responsesize') ) { $payload.Add('responsesize', $responsesize) }
            if ( $PSBoundParameters.ContainsKey('namevaluepair') ) { $payload.Add('namevaluepair', $namevaluepair) }
            if ( $PSBoundParameters.ContainsKey('nvtype') ) { $payload.Add('nvtype', $nvtype) }
            if ( $PSBoundParameters.ContainsKey('submitmethod') ) { $payload.Add('submitmethod', $submitmethod) }
            if ( $PSCmdlet.ShouldProcess("tmformssoaction", "Update TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmformssoaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmformssoaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateTmformssoaction: Finished"
    }
}

function Invoke-NSUnsetTmformssoaction {
    <#
    .SYNOPSIS
        Unset TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for Form sso action resource.
    .PARAMETER Name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Responsesize 
        Number of bytes, in the response, to parse for extracting the forms. 
    .PARAMETER Namevaluepair 
        Name-value pair attributes to send to the server in addition to sending the username and password. Value names are separated by an ampersand (&amp;) (for example, name1=value1&amp;name2=value2). 
    .PARAMETER Nvtype 
        Type of processing of the name-value pair. If you specify STATIC, the values configured by the administrator are used. For DYNAMIC, the response is parsed, and the form is extracted and then submitted. 
         
        Possible values = STATIC, DYNAMIC 
    .PARAMETER Submitmethod 
        HTTP method used by the single sign-on form to send the logon credentials to the logon server. Applies only to STATIC name-value type. 
         
        Possible values = GET, POST
    .EXAMPLE
        PS C:\>Invoke-NSUnsetTmformssoaction -name <string>
        An example how to unset tmformssoaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetTmformssoaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmformssoaction
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$responsesize,

        [Boolean]$namevaluepair,

        [Boolean]$nvtype,

        [Boolean]$submitmethod 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetTmformssoaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('responsesize') ) { $payload.Add('responsesize', $responsesize) }
            if ( $PSBoundParameters.ContainsKey('namevaluepair') ) { $payload.Add('namevaluepair', $namevaluepair) }
            if ( $PSBoundParameters.ContainsKey('nvtype') ) { $payload.Add('nvtype', $nvtype) }
            if ( $PSBoundParameters.ContainsKey('submitmethod') ) { $payload.Add('submitmethod', $submitmethod) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type tmformssoaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetTmformssoaction: Finished"
    }
}

function Invoke-NSGetTmformssoaction {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Configuration for Form sso action resource.
    .PARAMETER Name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER GetAll 
        Retrieve all tmformssoaction object(s).
    .PARAMETER Count
        If specified, the count of the tmformssoaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmformssoaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmformssoaction -GetAll 
        Get all tmformssoaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmformssoaction -Count 
        Get the number of tmformssoaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmformssoaction -name <string>
        Get tmformssoaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmformssoaction -Filter @{ 'name'='<value>' }
        Get tmformssoaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmformssoaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmformssoaction/
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
        Write-Verbose "Invoke-NSGetTmformssoaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmformssoaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmformssoaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmformssoaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmformssoaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmformssoaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmformssoaction: Ended"
    }
}

function Invoke-NSAddTmglobalAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Add TM session/policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance tmsession policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddTmglobalAuditnslogpolicyBinding 
        An example how to add tmglobal_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddTmglobalAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_auditnslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddTmglobalAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_auditnslogpolicy_binding", "Add TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmglobalAuditnslogpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddTmglobalAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteTmglobalAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete TM session/policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteTmglobalAuditnslogpolicyBinding 
        An example how to delete tmglobal_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteTmglobalAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_auditnslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteTmglobalAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_auditnslogpolicy_binding", "Delete TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteTmglobalAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetTmglobalAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to tmglobal.
    .PARAMETER GetAll 
        Retrieve all tmglobal_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmglobal_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalAuditnslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmglobalAuditnslogpolicyBinding -GetAll 
        Get all tmglobal_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmglobalAuditnslogpolicyBinding -Count 
        Get the number of tmglobal_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalAuditnslogpolicyBinding -name <string>
        Get tmglobal_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalAuditnslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get tmglobal_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmglobalAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_auditnslogpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetTmglobalAuditnslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmglobal_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmglobalAuditnslogpolicyBinding: Ended"
    }
}

function Invoke-NSAddTmglobalAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Add TM session/policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance tmsession policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddTmglobalAuditsyslogpolicyBinding 
        An example how to add tmglobal_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddTmglobalAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_auditsyslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddTmglobalAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_auditsyslogpolicy_binding", "Add TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmglobalAuditsyslogpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddTmglobalAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteTmglobalAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete TM session/policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteTmglobalAuditsyslogpolicyBinding 
        An example how to delete tmglobal_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteTmglobalAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_auditsyslogpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteTmglobalAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_auditsyslogpolicy_binding", "Delete TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteTmglobalAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetTmglobalAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to tmglobal.
    .PARAMETER GetAll 
        Retrieve all tmglobal_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmglobal_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalAuditsyslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmglobalAuditsyslogpolicyBinding -GetAll 
        Get all tmglobal_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmglobalAuditsyslogpolicyBinding -Count 
        Get the number of tmglobal_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalAuditsyslogpolicyBinding -name <string>
        Get tmglobal_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalAuditsyslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get tmglobal_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmglobalAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_auditsyslogpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetTmglobalAuditsyslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmglobalAuditsyslogpolicyBinding: Ended"
    }
}

function Invoke-NSGetTmglobalBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to tmglobal.
    .PARAMETER GetAll 
        Retrieve all tmglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmglobalBinding -GetAll 
        Get all tmglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalBinding -name <string>
        Get tmglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalBinding -Filter @{ 'name'='<value>' }
        Get tmglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_binding/
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
        Write-Verbose "Invoke-NSGetTmglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmglobalBinding: Ended"
    }
}

function Invoke-NSAddTmglobalTmsessionpolicyBinding {
    <#
    .SYNOPSIS
        Add TM session/policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_tmsessionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddTmglobalTmsessionpolicyBinding 
        An example how to add tmglobal_tmsessionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddTmglobalTmsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_tmsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddTmglobalTmsessionpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_tmsessionpolicy_binding", "Add TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_tmsessionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmglobalTmsessionpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddTmglobalTmsessionpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteTmglobalTmsessionpolicyBinding {
    <#
    .SYNOPSIS
        Delete TM session/policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteTmglobalTmsessionpolicyBinding 
        An example how to delete tmglobal_tmsessionpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteTmglobalTmsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_tmsessionpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteTmglobalTmsessionpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_tmsessionpolicy_binding", "Delete TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteTmglobalTmsessionpolicyBinding: Finished"
    }
}

function Invoke-NSGetTmglobalTmsessionpolicyBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to tmglobal.
    .PARAMETER GetAll 
        Retrieve all tmglobal_tmsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmglobal_tmsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalTmsessionpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmglobalTmsessionpolicyBinding -GetAll 
        Get all tmglobal_tmsessionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmglobalTmsessionpolicyBinding -Count 
        Get the number of tmglobal_tmsessionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalTmsessionpolicyBinding -name <string>
        Get tmglobal_tmsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalTmsessionpolicyBinding -Filter @{ 'name'='<value>' }
        Get tmglobal_tmsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmglobalTmsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_tmsessionpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetTmglobalTmsessionpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmglobal_tmsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_tmsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_tmsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_tmsessionpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_tmsessionpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmglobalTmsessionpolicyBinding: Ended"
    }
}

function Invoke-NSAddTmglobalTmtrafficpolicyBinding {
    <#
    .SYNOPSIS
        Add TM session/policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance tmsession policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_tmtrafficpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddTmglobalTmtrafficpolicyBinding 
        An example how to add tmglobal_tmtrafficpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddTmglobalTmtrafficpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_tmtrafficpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddTmglobalTmtrafficpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_tmtrafficpolicy_binding", "Add TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_tmtrafficpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmglobalTmtrafficpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddTmglobalTmtrafficpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteTmglobalTmtrafficpolicyBinding {
    <#
    .SYNOPSIS
        Delete TM session/policy configuration. config Object.
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteTmglobalTmtrafficpolicyBinding 
        An example how to delete tmglobal_tmtrafficpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteTmglobalTmtrafficpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_tmtrafficpolicy_binding/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteTmglobalTmtrafficpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_tmtrafficpolicy_binding", "Delete TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteTmglobalTmtrafficpolicyBinding: Finished"
    }
}

function Invoke-NSGetTmglobalTmtrafficpolicyBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to tmglobal.
    .PARAMETER GetAll 
        Retrieve all tmglobal_tmtrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmglobal_tmtrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalTmtrafficpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmglobalTmtrafficpolicyBinding -GetAll 
        Get all tmglobal_tmtrafficpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmglobalTmtrafficpolicyBinding -Count 
        Get the number of tmglobal_tmtrafficpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalTmtrafficpolicyBinding -name <string>
        Get tmglobal_tmtrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmglobalTmtrafficpolicyBinding -Filter @{ 'name'='<value>' }
        Get tmglobal_tmtrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmglobalTmtrafficpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmglobal_tmtrafficpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetTmglobalTmtrafficpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmglobal_tmtrafficpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_tmtrafficpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_tmtrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_tmtrafficpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_tmtrafficpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmglobalTmtrafficpolicyBinding: Ended"
    }
}

function Invoke-NSAddTmsamlssoprofile {
    <#
    .SYNOPSIS
        Add TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for SAML sso action resource.
    .PARAMETER Name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Samlsigningcertname 
        Name of the SSL certificate that is used to Sign Assertion. 
    .PARAMETER Assertionconsumerserviceurl 
        URL to which the assertion is to be sent. 
    .PARAMETER Relaystaterule 
        Expression to extract relaystate to be sent along with assertion. Evaluation of this expression should return TEXT content. This is typically a targ 
        et url to which user is redirected after the recipient validates SAML token. 
    .PARAMETER Sendpassword 
        Option to send password in assertion. 
         
        Possible values = ON, OFF 
    .PARAMETER Samlissuername 
        The name to be used in requests sent from Citrix ADC to IdP to uniquely identify Citrix ADC. 
    .PARAMETER Signaturealg 
        Algorithm to be used to sign/verify SAML transactions. 
         
        Possible values = RSA-SHA1, RSA-SHA256 
    .PARAMETER Digestmethod 
        Algorithm to be used to compute/verify digest for SAML transactions. 
         
        Possible values = SHA1, SHA256 
    .PARAMETER Audience 
        Audience for which assertion sent by IdP is applicable. This is typically entity name or url that represents ServiceProvider. 
    .PARAMETER Nameidformat 
        Format of Name Identifier sent in Assertion. 
         
        Possible values = Unspecified, emailAddress, X509SubjectName, WindowsDomainQualifiedName, kerberos, entity, persistent, transient 
    .PARAMETER Nameidexpr 
        Expression that will be evaluated to obtain NameIdentifier to be sent in assertion. 
    .PARAMETER Attribute1 
        Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1expr 
        Expression that will be evaluated to obtain attribute1's value to be sent in Assertion. 
    .PARAMETER Attribute1friendlyname 
        User-Friendly Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1format 
        Format of Attribute1 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute2 
        Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2expr 
        Expression that will be evaluated to obtain attribute2's value to be sent in Assertion. 
    .PARAMETER Attribute2friendlyname 
        User-Friendly Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2format 
        Format of Attribute2 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute3 
        Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3expr 
        Expression that will be evaluated to obtain attribute3's value to be sent in Assertion. 
    .PARAMETER Attribute3friendlyname 
        User-Friendly Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3format 
        Format of Attribute3 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute4 
        Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4expr 
        Expression that will be evaluated to obtain attribute4's value to be sent in Assertion. 
    .PARAMETER Attribute4friendlyname 
        User-Friendly Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4format 
        Format of Attribute4 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute5 
        Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5expr 
        Expression that will be evaluated to obtain attribute5's value to be sent in Assertion. 
    .PARAMETER Attribute5friendlyname 
        User-Friendly Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5format 
        Format of Attribute5 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute6 
        Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6expr 
        Expression that will be evaluated to obtain attribute6's value to be sent in Assertion. 
    .PARAMETER Attribute6friendlyname 
        User-Friendly Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6format 
        Format of Attribute6 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute7 
        Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7expr 
        Expression that will be evaluated to obtain attribute7's value to be sent in Assertion. 
    .PARAMETER Attribute7friendlyname 
        User-Friendly Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7format 
        Format of Attribute7 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute8 
        Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8expr 
        Expression that will be evaluated to obtain attribute8's value to be sent in Assertion. 
    .PARAMETER Attribute8friendlyname 
        User-Friendly Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8format 
        Format of Attribute8 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute9 
        Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9expr 
        Expression that will be evaluated to obtain attribute9's value to be sent in Assertion. 
    .PARAMETER Attribute9friendlyname 
        User-Friendly Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9format 
        Format of Attribute9 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute10 
        Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10expr 
        Expression that will be evaluated to obtain attribute10's value to be sent in Assertion. 
    .PARAMETER Attribute10friendlyname 
        User-Friendly Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10format 
        Format of Attribute10 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute11 
        Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11expr 
        Expression that will be evaluated to obtain attribute11's value to be sent in Assertion. 
    .PARAMETER Attribute11friendlyname 
        User-Friendly Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11format 
        Format of Attribute11 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute12 
        Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12expr 
        Expression that will be evaluated to obtain attribute12's value to be sent in Assertion. 
    .PARAMETER Attribute12friendlyname 
        User-Friendly Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12format 
        Format of Attribute12 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute13 
        Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13expr 
        Expression that will be evaluated to obtain attribute13's value to be sent in Assertion. 
    .PARAMETER Attribute13friendlyname 
        User-Friendly Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13format 
        Format of Attribute13 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute14 
        Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14expr 
        Expression that will be evaluated to obtain attribute14's value to be sent in Assertion. 
    .PARAMETER Attribute14friendlyname 
        User-Friendly Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14format 
        Format of Attribute14 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute15 
        Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15expr 
        Expression that will be evaluated to obtain attribute15's value to be sent in Assertion. 
    .PARAMETER Attribute15friendlyname 
        User-Friendly Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15format 
        Format of Attribute15 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute16 
        Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16expr 
        Expression that will be evaluated to obtain attribute16's value to be sent in Assertion. 
    .PARAMETER Attribute16friendlyname 
        User-Friendly Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16format 
        Format of Attribute16 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Encryptassertion 
        Option to encrypt assertion when Citrix ADC sends one. 
         
        Possible values = ON, OFF 
    .PARAMETER Samlspcertname 
        Name of the SSL certificate of peer/receving party using which Assertion is encrypted. 
    .PARAMETER Encryptionalgorithm 
        Algorithm to be used to encrypt SAML assertion. 
         
        Possible values = DES3, AES128, AES192, AES256 
    .PARAMETER Skewtime 
        This option specifies the number of minutes on either side of current time that the assertion would be valid. For example, if skewTime is 10, then assertion would be valid from (current time - 10) min to (current time + 10) min, ie 20min in all. 
    .PARAMETER Signassertion 
        Option to sign portions of assertion when Citrix ADC IDP sends one. Based on the user selection, either Assertion or Response or Both or none can be signed. 
         
        Possible values = NONE, ASSERTION, RESPONSE, BOTH 
    .PARAMETER PassThru 
        Return details about the created tmsamlssoprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddTmsamlssoprofile -name <string> -assertionconsumerserviceurl <string>
        An example how to add tmsamlssoprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddTmsamlssoprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsamlssoprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Samlsigningcertname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Assertionconsumerserviceurl,

        [string]$Relaystaterule,

        [ValidateSet('ON', 'OFF')]
        [string]$Sendpassword = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlissuername,

        [ValidateSet('RSA-SHA1', 'RSA-SHA256')]
        [string]$Signaturealg = 'RSA-SHA256',

        [ValidateSet('SHA1', 'SHA256')]
        [string]$Digestmethod = 'SHA256',

        [string]$Audience,

        [ValidateSet('Unspecified', 'emailAddress', 'X509SubjectName', 'WindowsDomainQualifiedName', 'kerberos', 'entity', 'persistent', 'transient')]
        [string]$Nameidformat = 'transient',

        [string]$Nameidexpr,

        [string]$Attribute1,

        [string]$Attribute1expr,

        [string]$Attribute1friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute1format,

        [string]$Attribute2,

        [string]$Attribute2expr,

        [string]$Attribute2friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute2format,

        [string]$Attribute3,

        [string]$Attribute3expr,

        [string]$Attribute3friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute3format,

        [string]$Attribute4,

        [string]$Attribute4expr,

        [string]$Attribute4friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute4format,

        [string]$Attribute5,

        [string]$Attribute5expr,

        [string]$Attribute5friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute5format,

        [string]$Attribute6,

        [string]$Attribute6expr,

        [string]$Attribute6friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute6format,

        [string]$Attribute7,

        [string]$Attribute7expr,

        [string]$Attribute7friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute7format,

        [string]$Attribute8,

        [string]$Attribute8expr,

        [string]$Attribute8friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute8format,

        [string]$Attribute9,

        [string]$Attribute9expr,

        [string]$Attribute9friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute9format,

        [string]$Attribute10,

        [string]$Attribute10expr,

        [string]$Attribute10friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute10format,

        [string]$Attribute11,

        [string]$Attribute11expr,

        [string]$Attribute11friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute11format,

        [string]$Attribute12,

        [string]$Attribute12expr,

        [string]$Attribute12friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute12format,

        [string]$Attribute13,

        [string]$Attribute13expr,

        [string]$Attribute13friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute13format,

        [string]$Attribute14,

        [string]$Attribute14expr,

        [string]$Attribute14friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute14format,

        [string]$Attribute15,

        [string]$Attribute15expr,

        [string]$Attribute15friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute15format,

        [string]$Attribute16,

        [string]$Attribute16expr,

        [string]$Attribute16friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute16format,

        [ValidateSet('ON', 'OFF')]
        [string]$Encryptassertion = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlspcertname,

        [ValidateSet('DES3', 'AES128', 'AES192', 'AES256')]
        [string]$Encryptionalgorithm = 'AES256',

        [double]$Skewtime = '5',

        [ValidateSet('NONE', 'ASSERTION', 'RESPONSE', 'BOTH')]
        [string]$Signassertion = 'ASSERTION',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddTmsamlssoprofile: Starting"
    }
    process {
        try {
            $payload = @{ name              = $name
                assertionconsumerserviceurl = $assertionconsumerserviceurl
            }
            if ( $PSBoundParameters.ContainsKey('samlsigningcertname') ) { $payload.Add('samlsigningcertname', $samlsigningcertname) }
            if ( $PSBoundParameters.ContainsKey('relaystaterule') ) { $payload.Add('relaystaterule', $relaystaterule) }
            if ( $PSBoundParameters.ContainsKey('sendpassword') ) { $payload.Add('sendpassword', $sendpassword) }
            if ( $PSBoundParameters.ContainsKey('samlissuername') ) { $payload.Add('samlissuername', $samlissuername) }
            if ( $PSBoundParameters.ContainsKey('signaturealg') ) { $payload.Add('signaturealg', $signaturealg) }
            if ( $PSBoundParameters.ContainsKey('digestmethod') ) { $payload.Add('digestmethod', $digestmethod) }
            if ( $PSBoundParameters.ContainsKey('audience') ) { $payload.Add('audience', $audience) }
            if ( $PSBoundParameters.ContainsKey('nameidformat') ) { $payload.Add('nameidformat', $nameidformat) }
            if ( $PSBoundParameters.ContainsKey('nameidexpr') ) { $payload.Add('nameidexpr', $nameidexpr) }
            if ( $PSBoundParameters.ContainsKey('attribute1') ) { $payload.Add('attribute1', $attribute1) }
            if ( $PSBoundParameters.ContainsKey('attribute1expr') ) { $payload.Add('attribute1expr', $attribute1expr) }
            if ( $PSBoundParameters.ContainsKey('attribute1friendlyname') ) { $payload.Add('attribute1friendlyname', $attribute1friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute1format') ) { $payload.Add('attribute1format', $attribute1format) }
            if ( $PSBoundParameters.ContainsKey('attribute2') ) { $payload.Add('attribute2', $attribute2) }
            if ( $PSBoundParameters.ContainsKey('attribute2expr') ) { $payload.Add('attribute2expr', $attribute2expr) }
            if ( $PSBoundParameters.ContainsKey('attribute2friendlyname') ) { $payload.Add('attribute2friendlyname', $attribute2friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute2format') ) { $payload.Add('attribute2format', $attribute2format) }
            if ( $PSBoundParameters.ContainsKey('attribute3') ) { $payload.Add('attribute3', $attribute3) }
            if ( $PSBoundParameters.ContainsKey('attribute3expr') ) { $payload.Add('attribute3expr', $attribute3expr) }
            if ( $PSBoundParameters.ContainsKey('attribute3friendlyname') ) { $payload.Add('attribute3friendlyname', $attribute3friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute3format') ) { $payload.Add('attribute3format', $attribute3format) }
            if ( $PSBoundParameters.ContainsKey('attribute4') ) { $payload.Add('attribute4', $attribute4) }
            if ( $PSBoundParameters.ContainsKey('attribute4expr') ) { $payload.Add('attribute4expr', $attribute4expr) }
            if ( $PSBoundParameters.ContainsKey('attribute4friendlyname') ) { $payload.Add('attribute4friendlyname', $attribute4friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute4format') ) { $payload.Add('attribute4format', $attribute4format) }
            if ( $PSBoundParameters.ContainsKey('attribute5') ) { $payload.Add('attribute5', $attribute5) }
            if ( $PSBoundParameters.ContainsKey('attribute5expr') ) { $payload.Add('attribute5expr', $attribute5expr) }
            if ( $PSBoundParameters.ContainsKey('attribute5friendlyname') ) { $payload.Add('attribute5friendlyname', $attribute5friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute5format') ) { $payload.Add('attribute5format', $attribute5format) }
            if ( $PSBoundParameters.ContainsKey('attribute6') ) { $payload.Add('attribute6', $attribute6) }
            if ( $PSBoundParameters.ContainsKey('attribute6expr') ) { $payload.Add('attribute6expr', $attribute6expr) }
            if ( $PSBoundParameters.ContainsKey('attribute6friendlyname') ) { $payload.Add('attribute6friendlyname', $attribute6friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute6format') ) { $payload.Add('attribute6format', $attribute6format) }
            if ( $PSBoundParameters.ContainsKey('attribute7') ) { $payload.Add('attribute7', $attribute7) }
            if ( $PSBoundParameters.ContainsKey('attribute7expr') ) { $payload.Add('attribute7expr', $attribute7expr) }
            if ( $PSBoundParameters.ContainsKey('attribute7friendlyname') ) { $payload.Add('attribute7friendlyname', $attribute7friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute7format') ) { $payload.Add('attribute7format', $attribute7format) }
            if ( $PSBoundParameters.ContainsKey('attribute8') ) { $payload.Add('attribute8', $attribute8) }
            if ( $PSBoundParameters.ContainsKey('attribute8expr') ) { $payload.Add('attribute8expr', $attribute8expr) }
            if ( $PSBoundParameters.ContainsKey('attribute8friendlyname') ) { $payload.Add('attribute8friendlyname', $attribute8friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute8format') ) { $payload.Add('attribute8format', $attribute8format) }
            if ( $PSBoundParameters.ContainsKey('attribute9') ) { $payload.Add('attribute9', $attribute9) }
            if ( $PSBoundParameters.ContainsKey('attribute9expr') ) { $payload.Add('attribute9expr', $attribute9expr) }
            if ( $PSBoundParameters.ContainsKey('attribute9friendlyname') ) { $payload.Add('attribute9friendlyname', $attribute9friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute9format') ) { $payload.Add('attribute9format', $attribute9format) }
            if ( $PSBoundParameters.ContainsKey('attribute10') ) { $payload.Add('attribute10', $attribute10) }
            if ( $PSBoundParameters.ContainsKey('attribute10expr') ) { $payload.Add('attribute10expr', $attribute10expr) }
            if ( $PSBoundParameters.ContainsKey('attribute10friendlyname') ) { $payload.Add('attribute10friendlyname', $attribute10friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute10format') ) { $payload.Add('attribute10format', $attribute10format) }
            if ( $PSBoundParameters.ContainsKey('attribute11') ) { $payload.Add('attribute11', $attribute11) }
            if ( $PSBoundParameters.ContainsKey('attribute11expr') ) { $payload.Add('attribute11expr', $attribute11expr) }
            if ( $PSBoundParameters.ContainsKey('attribute11friendlyname') ) { $payload.Add('attribute11friendlyname', $attribute11friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute11format') ) { $payload.Add('attribute11format', $attribute11format) }
            if ( $PSBoundParameters.ContainsKey('attribute12') ) { $payload.Add('attribute12', $attribute12) }
            if ( $PSBoundParameters.ContainsKey('attribute12expr') ) { $payload.Add('attribute12expr', $attribute12expr) }
            if ( $PSBoundParameters.ContainsKey('attribute12friendlyname') ) { $payload.Add('attribute12friendlyname', $attribute12friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute12format') ) { $payload.Add('attribute12format', $attribute12format) }
            if ( $PSBoundParameters.ContainsKey('attribute13') ) { $payload.Add('attribute13', $attribute13) }
            if ( $PSBoundParameters.ContainsKey('attribute13expr') ) { $payload.Add('attribute13expr', $attribute13expr) }
            if ( $PSBoundParameters.ContainsKey('attribute13friendlyname') ) { $payload.Add('attribute13friendlyname', $attribute13friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute13format') ) { $payload.Add('attribute13format', $attribute13format) }
            if ( $PSBoundParameters.ContainsKey('attribute14') ) { $payload.Add('attribute14', $attribute14) }
            if ( $PSBoundParameters.ContainsKey('attribute14expr') ) { $payload.Add('attribute14expr', $attribute14expr) }
            if ( $PSBoundParameters.ContainsKey('attribute14friendlyname') ) { $payload.Add('attribute14friendlyname', $attribute14friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute14format') ) { $payload.Add('attribute14format', $attribute14format) }
            if ( $PSBoundParameters.ContainsKey('attribute15') ) { $payload.Add('attribute15', $attribute15) }
            if ( $PSBoundParameters.ContainsKey('attribute15expr') ) { $payload.Add('attribute15expr', $attribute15expr) }
            if ( $PSBoundParameters.ContainsKey('attribute15friendlyname') ) { $payload.Add('attribute15friendlyname', $attribute15friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute15format') ) { $payload.Add('attribute15format', $attribute15format) }
            if ( $PSBoundParameters.ContainsKey('attribute16') ) { $payload.Add('attribute16', $attribute16) }
            if ( $PSBoundParameters.ContainsKey('attribute16expr') ) { $payload.Add('attribute16expr', $attribute16expr) }
            if ( $PSBoundParameters.ContainsKey('attribute16friendlyname') ) { $payload.Add('attribute16friendlyname', $attribute16friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute16format') ) { $payload.Add('attribute16format', $attribute16format) }
            if ( $PSBoundParameters.ContainsKey('encryptassertion') ) { $payload.Add('encryptassertion', $encryptassertion) }
            if ( $PSBoundParameters.ContainsKey('samlspcertname') ) { $payload.Add('samlspcertname', $samlspcertname) }
            if ( $PSBoundParameters.ContainsKey('encryptionalgorithm') ) { $payload.Add('encryptionalgorithm', $encryptionalgorithm) }
            if ( $PSBoundParameters.ContainsKey('skewtime') ) { $payload.Add('skewtime', $skewtime) }
            if ( $PSBoundParameters.ContainsKey('signassertion') ) { $payload.Add('signassertion', $signassertion) }
            if ( $PSCmdlet.ShouldProcess("tmsamlssoprofile", "Add TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type tmsamlssoprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmsamlssoprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddTmsamlssoprofile: Finished"
    }
}

function Invoke-NSDeleteTmsamlssoprofile {
    <#
    .SYNOPSIS
        Delete TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for SAML sso action resource.
    .PARAMETER Name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteTmsamlssoprofile -Name <string>
        An example how to delete tmsamlssoprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteTmsamlssoprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsamlssoprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteTmsamlssoprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type tmsamlssoprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteTmsamlssoprofile: Finished"
    }
}

function Invoke-NSUpdateTmsamlssoprofile {
    <#
    .SYNOPSIS
        Update TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for SAML sso action resource.
    .PARAMETER Name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Samlsigningcertname 
        Name of the SSL certificate that is used to Sign Assertion. 
    .PARAMETER Assertionconsumerserviceurl 
        URL to which the assertion is to be sent. 
    .PARAMETER Sendpassword 
        Option to send password in assertion. 
         
        Possible values = ON, OFF 
    .PARAMETER Samlissuername 
        The name to be used in requests sent from Citrix ADC to IdP to uniquely identify Citrix ADC. 
    .PARAMETER Relaystaterule 
        Expression to extract relaystate to be sent along with assertion. Evaluation of this expression should return TEXT content. This is typically a targ 
        et url to which user is redirected after the recipient validates SAML token. 
    .PARAMETER Signaturealg 
        Algorithm to be used to sign/verify SAML transactions. 
         
        Possible values = RSA-SHA1, RSA-SHA256 
    .PARAMETER Digestmethod 
        Algorithm to be used to compute/verify digest for SAML transactions. 
         
        Possible values = SHA1, SHA256 
    .PARAMETER Audience 
        Audience for which assertion sent by IdP is applicable. This is typically entity name or url that represents ServiceProvider. 
    .PARAMETER Nameidformat 
        Format of Name Identifier sent in Assertion. 
         
        Possible values = Unspecified, emailAddress, X509SubjectName, WindowsDomainQualifiedName, kerberos, entity, persistent, transient 
    .PARAMETER Nameidexpr 
        Expression that will be evaluated to obtain NameIdentifier to be sent in assertion. 
    .PARAMETER Attribute1 
        Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1expr 
        Expression that will be evaluated to obtain attribute1's value to be sent in Assertion. 
    .PARAMETER Attribute1friendlyname 
        User-Friendly Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1format 
        Format of Attribute1 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute2 
        Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2expr 
        Expression that will be evaluated to obtain attribute2's value to be sent in Assertion. 
    .PARAMETER Attribute2friendlyname 
        User-Friendly Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2format 
        Format of Attribute2 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute3 
        Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3expr 
        Expression that will be evaluated to obtain attribute3's value to be sent in Assertion. 
    .PARAMETER Attribute3friendlyname 
        User-Friendly Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3format 
        Format of Attribute3 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute4 
        Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4expr 
        Expression that will be evaluated to obtain attribute4's value to be sent in Assertion. 
    .PARAMETER Attribute4friendlyname 
        User-Friendly Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4format 
        Format of Attribute4 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute5 
        Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5expr 
        Expression that will be evaluated to obtain attribute5's value to be sent in Assertion. 
    .PARAMETER Attribute5friendlyname 
        User-Friendly Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5format 
        Format of Attribute5 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute6 
        Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6expr 
        Expression that will be evaluated to obtain attribute6's value to be sent in Assertion. 
    .PARAMETER Attribute6friendlyname 
        User-Friendly Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6format 
        Format of Attribute6 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute7 
        Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7expr 
        Expression that will be evaluated to obtain attribute7's value to be sent in Assertion. 
    .PARAMETER Attribute7friendlyname 
        User-Friendly Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7format 
        Format of Attribute7 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute8 
        Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8expr 
        Expression that will be evaluated to obtain attribute8's value to be sent in Assertion. 
    .PARAMETER Attribute8friendlyname 
        User-Friendly Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8format 
        Format of Attribute8 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute9 
        Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9expr 
        Expression that will be evaluated to obtain attribute9's value to be sent in Assertion. 
    .PARAMETER Attribute9friendlyname 
        User-Friendly Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9format 
        Format of Attribute9 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute10 
        Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10expr 
        Expression that will be evaluated to obtain attribute10's value to be sent in Assertion. 
    .PARAMETER Attribute10friendlyname 
        User-Friendly Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10format 
        Format of Attribute10 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute11 
        Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11expr 
        Expression that will be evaluated to obtain attribute11's value to be sent in Assertion. 
    .PARAMETER Attribute11friendlyname 
        User-Friendly Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11format 
        Format of Attribute11 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute12 
        Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12expr 
        Expression that will be evaluated to obtain attribute12's value to be sent in Assertion. 
    .PARAMETER Attribute12friendlyname 
        User-Friendly Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12format 
        Format of Attribute12 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute13 
        Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13expr 
        Expression that will be evaluated to obtain attribute13's value to be sent in Assertion. 
    .PARAMETER Attribute13friendlyname 
        User-Friendly Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13format 
        Format of Attribute13 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute14 
        Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14expr 
        Expression that will be evaluated to obtain attribute14's value to be sent in Assertion. 
    .PARAMETER Attribute14friendlyname 
        User-Friendly Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14format 
        Format of Attribute14 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute15 
        Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15expr 
        Expression that will be evaluated to obtain attribute15's value to be sent in Assertion. 
    .PARAMETER Attribute15friendlyname 
        User-Friendly Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15format 
        Format of Attribute15 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute16 
        Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16expr 
        Expression that will be evaluated to obtain attribute16's value to be sent in Assertion. 
    .PARAMETER Attribute16friendlyname 
        User-Friendly Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16format 
        Format of Attribute16 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Encryptassertion 
        Option to encrypt assertion when Citrix ADC sends one. 
         
        Possible values = ON, OFF 
    .PARAMETER Samlspcertname 
        Name of the SSL certificate of peer/receving party using which Assertion is encrypted. 
    .PARAMETER Encryptionalgorithm 
        Algorithm to be used to encrypt SAML assertion. 
         
        Possible values = DES3, AES128, AES192, AES256 
    .PARAMETER Skewtime 
        This option specifies the number of minutes on either side of current time that the assertion would be valid. For example, if skewTime is 10, then assertion would be valid from (current time - 10) min to (current time + 10) min, ie 20min in all. 
    .PARAMETER Signassertion 
        Option to sign portions of assertion when Citrix ADC IDP sends one. Based on the user selection, either Assertion or Response or Both or none can be signed. 
         
        Possible values = NONE, ASSERTION, RESPONSE, BOTH 
    .PARAMETER PassThru 
        Return details about the created tmsamlssoprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateTmsamlssoprofile -name <string>
        An example how to update tmsamlssoprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateTmsamlssoprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsamlssoprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Samlsigningcertname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Assertionconsumerserviceurl,

        [ValidateSet('ON', 'OFF')]
        [string]$Sendpassword,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlissuername,

        [string]$Relaystaterule,

        [ValidateSet('RSA-SHA1', 'RSA-SHA256')]
        [string]$Signaturealg,

        [ValidateSet('SHA1', 'SHA256')]
        [string]$Digestmethod,

        [string]$Audience,

        [ValidateSet('Unspecified', 'emailAddress', 'X509SubjectName', 'WindowsDomainQualifiedName', 'kerberos', 'entity', 'persistent', 'transient')]
        [string]$Nameidformat,

        [string]$Nameidexpr,

        [string]$Attribute1,

        [string]$Attribute1expr,

        [string]$Attribute1friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute1format,

        [string]$Attribute2,

        [string]$Attribute2expr,

        [string]$Attribute2friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute2format,

        [string]$Attribute3,

        [string]$Attribute3expr,

        [string]$Attribute3friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute3format,

        [string]$Attribute4,

        [string]$Attribute4expr,

        [string]$Attribute4friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute4format,

        [string]$Attribute5,

        [string]$Attribute5expr,

        [string]$Attribute5friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute5format,

        [string]$Attribute6,

        [string]$Attribute6expr,

        [string]$Attribute6friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute6format,

        [string]$Attribute7,

        [string]$Attribute7expr,

        [string]$Attribute7friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute7format,

        [string]$Attribute8,

        [string]$Attribute8expr,

        [string]$Attribute8friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute8format,

        [string]$Attribute9,

        [string]$Attribute9expr,

        [string]$Attribute9friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute9format,

        [string]$Attribute10,

        [string]$Attribute10expr,

        [string]$Attribute10friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute10format,

        [string]$Attribute11,

        [string]$Attribute11expr,

        [string]$Attribute11friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute11format,

        [string]$Attribute12,

        [string]$Attribute12expr,

        [string]$Attribute12friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute12format,

        [string]$Attribute13,

        [string]$Attribute13expr,

        [string]$Attribute13friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute13format,

        [string]$Attribute14,

        [string]$Attribute14expr,

        [string]$Attribute14friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute14format,

        [string]$Attribute15,

        [string]$Attribute15expr,

        [string]$Attribute15friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute15format,

        [string]$Attribute16,

        [string]$Attribute16expr,

        [string]$Attribute16friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute16format,

        [ValidateSet('ON', 'OFF')]
        [string]$Encryptassertion,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlspcertname,

        [ValidateSet('DES3', 'AES128', 'AES192', 'AES256')]
        [string]$Encryptionalgorithm,

        [double]$Skewtime,

        [ValidateSet('NONE', 'ASSERTION', 'RESPONSE', 'BOTH')]
        [string]$Signassertion,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateTmsamlssoprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('samlsigningcertname') ) { $payload.Add('samlsigningcertname', $samlsigningcertname) }
            if ( $PSBoundParameters.ContainsKey('assertionconsumerserviceurl') ) { $payload.Add('assertionconsumerserviceurl', $assertionconsumerserviceurl) }
            if ( $PSBoundParameters.ContainsKey('sendpassword') ) { $payload.Add('sendpassword', $sendpassword) }
            if ( $PSBoundParameters.ContainsKey('samlissuername') ) { $payload.Add('samlissuername', $samlissuername) }
            if ( $PSBoundParameters.ContainsKey('relaystaterule') ) { $payload.Add('relaystaterule', $relaystaterule) }
            if ( $PSBoundParameters.ContainsKey('signaturealg') ) { $payload.Add('signaturealg', $signaturealg) }
            if ( $PSBoundParameters.ContainsKey('digestmethod') ) { $payload.Add('digestmethod', $digestmethod) }
            if ( $PSBoundParameters.ContainsKey('audience') ) { $payload.Add('audience', $audience) }
            if ( $PSBoundParameters.ContainsKey('nameidformat') ) { $payload.Add('nameidformat', $nameidformat) }
            if ( $PSBoundParameters.ContainsKey('nameidexpr') ) { $payload.Add('nameidexpr', $nameidexpr) }
            if ( $PSBoundParameters.ContainsKey('attribute1') ) { $payload.Add('attribute1', $attribute1) }
            if ( $PSBoundParameters.ContainsKey('attribute1expr') ) { $payload.Add('attribute1expr', $attribute1expr) }
            if ( $PSBoundParameters.ContainsKey('attribute1friendlyname') ) { $payload.Add('attribute1friendlyname', $attribute1friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute1format') ) { $payload.Add('attribute1format', $attribute1format) }
            if ( $PSBoundParameters.ContainsKey('attribute2') ) { $payload.Add('attribute2', $attribute2) }
            if ( $PSBoundParameters.ContainsKey('attribute2expr') ) { $payload.Add('attribute2expr', $attribute2expr) }
            if ( $PSBoundParameters.ContainsKey('attribute2friendlyname') ) { $payload.Add('attribute2friendlyname', $attribute2friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute2format') ) { $payload.Add('attribute2format', $attribute2format) }
            if ( $PSBoundParameters.ContainsKey('attribute3') ) { $payload.Add('attribute3', $attribute3) }
            if ( $PSBoundParameters.ContainsKey('attribute3expr') ) { $payload.Add('attribute3expr', $attribute3expr) }
            if ( $PSBoundParameters.ContainsKey('attribute3friendlyname') ) { $payload.Add('attribute3friendlyname', $attribute3friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute3format') ) { $payload.Add('attribute3format', $attribute3format) }
            if ( $PSBoundParameters.ContainsKey('attribute4') ) { $payload.Add('attribute4', $attribute4) }
            if ( $PSBoundParameters.ContainsKey('attribute4expr') ) { $payload.Add('attribute4expr', $attribute4expr) }
            if ( $PSBoundParameters.ContainsKey('attribute4friendlyname') ) { $payload.Add('attribute4friendlyname', $attribute4friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute4format') ) { $payload.Add('attribute4format', $attribute4format) }
            if ( $PSBoundParameters.ContainsKey('attribute5') ) { $payload.Add('attribute5', $attribute5) }
            if ( $PSBoundParameters.ContainsKey('attribute5expr') ) { $payload.Add('attribute5expr', $attribute5expr) }
            if ( $PSBoundParameters.ContainsKey('attribute5friendlyname') ) { $payload.Add('attribute5friendlyname', $attribute5friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute5format') ) { $payload.Add('attribute5format', $attribute5format) }
            if ( $PSBoundParameters.ContainsKey('attribute6') ) { $payload.Add('attribute6', $attribute6) }
            if ( $PSBoundParameters.ContainsKey('attribute6expr') ) { $payload.Add('attribute6expr', $attribute6expr) }
            if ( $PSBoundParameters.ContainsKey('attribute6friendlyname') ) { $payload.Add('attribute6friendlyname', $attribute6friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute6format') ) { $payload.Add('attribute6format', $attribute6format) }
            if ( $PSBoundParameters.ContainsKey('attribute7') ) { $payload.Add('attribute7', $attribute7) }
            if ( $PSBoundParameters.ContainsKey('attribute7expr') ) { $payload.Add('attribute7expr', $attribute7expr) }
            if ( $PSBoundParameters.ContainsKey('attribute7friendlyname') ) { $payload.Add('attribute7friendlyname', $attribute7friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute7format') ) { $payload.Add('attribute7format', $attribute7format) }
            if ( $PSBoundParameters.ContainsKey('attribute8') ) { $payload.Add('attribute8', $attribute8) }
            if ( $PSBoundParameters.ContainsKey('attribute8expr') ) { $payload.Add('attribute8expr', $attribute8expr) }
            if ( $PSBoundParameters.ContainsKey('attribute8friendlyname') ) { $payload.Add('attribute8friendlyname', $attribute8friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute8format') ) { $payload.Add('attribute8format', $attribute8format) }
            if ( $PSBoundParameters.ContainsKey('attribute9') ) { $payload.Add('attribute9', $attribute9) }
            if ( $PSBoundParameters.ContainsKey('attribute9expr') ) { $payload.Add('attribute9expr', $attribute9expr) }
            if ( $PSBoundParameters.ContainsKey('attribute9friendlyname') ) { $payload.Add('attribute9friendlyname', $attribute9friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute9format') ) { $payload.Add('attribute9format', $attribute9format) }
            if ( $PSBoundParameters.ContainsKey('attribute10') ) { $payload.Add('attribute10', $attribute10) }
            if ( $PSBoundParameters.ContainsKey('attribute10expr') ) { $payload.Add('attribute10expr', $attribute10expr) }
            if ( $PSBoundParameters.ContainsKey('attribute10friendlyname') ) { $payload.Add('attribute10friendlyname', $attribute10friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute10format') ) { $payload.Add('attribute10format', $attribute10format) }
            if ( $PSBoundParameters.ContainsKey('attribute11') ) { $payload.Add('attribute11', $attribute11) }
            if ( $PSBoundParameters.ContainsKey('attribute11expr') ) { $payload.Add('attribute11expr', $attribute11expr) }
            if ( $PSBoundParameters.ContainsKey('attribute11friendlyname') ) { $payload.Add('attribute11friendlyname', $attribute11friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute11format') ) { $payload.Add('attribute11format', $attribute11format) }
            if ( $PSBoundParameters.ContainsKey('attribute12') ) { $payload.Add('attribute12', $attribute12) }
            if ( $PSBoundParameters.ContainsKey('attribute12expr') ) { $payload.Add('attribute12expr', $attribute12expr) }
            if ( $PSBoundParameters.ContainsKey('attribute12friendlyname') ) { $payload.Add('attribute12friendlyname', $attribute12friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute12format') ) { $payload.Add('attribute12format', $attribute12format) }
            if ( $PSBoundParameters.ContainsKey('attribute13') ) { $payload.Add('attribute13', $attribute13) }
            if ( $PSBoundParameters.ContainsKey('attribute13expr') ) { $payload.Add('attribute13expr', $attribute13expr) }
            if ( $PSBoundParameters.ContainsKey('attribute13friendlyname') ) { $payload.Add('attribute13friendlyname', $attribute13friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute13format') ) { $payload.Add('attribute13format', $attribute13format) }
            if ( $PSBoundParameters.ContainsKey('attribute14') ) { $payload.Add('attribute14', $attribute14) }
            if ( $PSBoundParameters.ContainsKey('attribute14expr') ) { $payload.Add('attribute14expr', $attribute14expr) }
            if ( $PSBoundParameters.ContainsKey('attribute14friendlyname') ) { $payload.Add('attribute14friendlyname', $attribute14friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute14format') ) { $payload.Add('attribute14format', $attribute14format) }
            if ( $PSBoundParameters.ContainsKey('attribute15') ) { $payload.Add('attribute15', $attribute15) }
            if ( $PSBoundParameters.ContainsKey('attribute15expr') ) { $payload.Add('attribute15expr', $attribute15expr) }
            if ( $PSBoundParameters.ContainsKey('attribute15friendlyname') ) { $payload.Add('attribute15friendlyname', $attribute15friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute15format') ) { $payload.Add('attribute15format', $attribute15format) }
            if ( $PSBoundParameters.ContainsKey('attribute16') ) { $payload.Add('attribute16', $attribute16) }
            if ( $PSBoundParameters.ContainsKey('attribute16expr') ) { $payload.Add('attribute16expr', $attribute16expr) }
            if ( $PSBoundParameters.ContainsKey('attribute16friendlyname') ) { $payload.Add('attribute16friendlyname', $attribute16friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute16format') ) { $payload.Add('attribute16format', $attribute16format) }
            if ( $PSBoundParameters.ContainsKey('encryptassertion') ) { $payload.Add('encryptassertion', $encryptassertion) }
            if ( $PSBoundParameters.ContainsKey('samlspcertname') ) { $payload.Add('samlspcertname', $samlspcertname) }
            if ( $PSBoundParameters.ContainsKey('encryptionalgorithm') ) { $payload.Add('encryptionalgorithm', $encryptionalgorithm) }
            if ( $PSBoundParameters.ContainsKey('skewtime') ) { $payload.Add('skewtime', $skewtime) }
            if ( $PSBoundParameters.ContainsKey('signassertion') ) { $payload.Add('signassertion', $signassertion) }
            if ( $PSCmdlet.ShouldProcess("tmsamlssoprofile", "Update TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmsamlssoprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmsamlssoprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateTmsamlssoprofile: Finished"
    }
}

function Invoke-NSUnsetTmsamlssoprofile {
    <#
    .SYNOPSIS
        Unset TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for SAML sso action resource.
    .PARAMETER Name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Samlsigningcertname 
        Name of the SSL certificate that is used to Sign Assertion. 
    .PARAMETER Sendpassword 
        Option to send password in assertion. 
         
        Possible values = ON, OFF 
    .PARAMETER Samlissuername 
        The name to be used in requests sent from Citrix ADC to IdP to uniquely identify Citrix ADC. 
    .PARAMETER Relaystaterule 
        Expression to extract relaystate to be sent along with assertion. Evaluation of this expression should return TEXT content. This is typically a targ 
        et url to which user is redirected after the recipient validates SAML token. 
    .PARAMETER Signaturealg 
        Algorithm to be used to sign/verify SAML transactions. 
         
        Possible values = RSA-SHA1, RSA-SHA256 
    .PARAMETER Digestmethod 
        Algorithm to be used to compute/verify digest for SAML transactions. 
         
        Possible values = SHA1, SHA256 
    .PARAMETER Audience 
        Audience for which assertion sent by IdP is applicable. This is typically entity name or url that represents ServiceProvider. 
    .PARAMETER Nameidformat 
        Format of Name Identifier sent in Assertion. 
         
        Possible values = Unspecified, emailAddress, X509SubjectName, WindowsDomainQualifiedName, kerberos, entity, persistent, transient 
    .PARAMETER Nameidexpr 
        Expression that will be evaluated to obtain NameIdentifier to be sent in assertion. 
    .PARAMETER Attribute1 
        Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1friendlyname 
        User-Friendly Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1format 
        Format of Attribute1 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute2 
        Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2friendlyname 
        User-Friendly Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2format 
        Format of Attribute2 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute3 
        Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3friendlyname 
        User-Friendly Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3format 
        Format of Attribute3 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute4 
        Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4friendlyname 
        User-Friendly Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4format 
        Format of Attribute4 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute5 
        Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5friendlyname 
        User-Friendly Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5format 
        Format of Attribute5 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute6 
        Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6friendlyname 
        User-Friendly Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6format 
        Format of Attribute6 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute7 
        Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7friendlyname 
        User-Friendly Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7format 
        Format of Attribute7 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute8 
        Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8friendlyname 
        User-Friendly Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8format 
        Format of Attribute8 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute9 
        Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9friendlyname 
        User-Friendly Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9format 
        Format of Attribute9 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute10 
        Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10friendlyname 
        User-Friendly Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10format 
        Format of Attribute10 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute11 
        Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11friendlyname 
        User-Friendly Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11format 
        Format of Attribute11 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute12 
        Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12friendlyname 
        User-Friendly Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12format 
        Format of Attribute12 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute13 
        Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13friendlyname 
        User-Friendly Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13format 
        Format of Attribute13 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute14 
        Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14friendlyname 
        User-Friendly Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14format 
        Format of Attribute14 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute15 
        Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15friendlyname 
        User-Friendly Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15format 
        Format of Attribute15 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute16 
        Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16friendlyname 
        User-Friendly Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16format 
        Format of Attribute16 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Encryptassertion 
        Option to encrypt assertion when Citrix ADC sends one. 
         
        Possible values = ON, OFF 
    .PARAMETER Samlspcertname 
        Name of the SSL certificate of peer/receving party using which Assertion is encrypted. 
    .PARAMETER Encryptionalgorithm 
        Algorithm to be used to encrypt SAML assertion. 
         
        Possible values = DES3, AES128, AES192, AES256 
    .PARAMETER Skewtime 
        This option specifies the number of minutes on either side of current time that the assertion would be valid. For example, if skewTime is 10, then assertion would be valid from (current time - 10) min to (current time + 10) min, ie 20min in all. 
    .PARAMETER Signassertion 
        Option to sign portions of assertion when Citrix ADC IDP sends one. Based on the user selection, either Assertion or Response or Both or none can be signed. 
         
        Possible values = NONE, ASSERTION, RESPONSE, BOTH
    .EXAMPLE
        PS C:\>Invoke-NSUnsetTmsamlssoprofile -name <string>
        An example how to unset tmsamlssoprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetTmsamlssoprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsamlssoprofile
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$samlsigningcertname,

        [Boolean]$sendpassword,

        [Boolean]$samlissuername,

        [Boolean]$relaystaterule,

        [Boolean]$signaturealg,

        [Boolean]$digestmethod,

        [Boolean]$audience,

        [Boolean]$nameidformat,

        [Boolean]$nameidexpr,

        [Boolean]$attribute1,

        [Boolean]$attribute1friendlyname,

        [Boolean]$attribute1format,

        [Boolean]$attribute2,

        [Boolean]$attribute2friendlyname,

        [Boolean]$attribute2format,

        [Boolean]$attribute3,

        [Boolean]$attribute3friendlyname,

        [Boolean]$attribute3format,

        [Boolean]$attribute4,

        [Boolean]$attribute4friendlyname,

        [Boolean]$attribute4format,

        [Boolean]$attribute5,

        [Boolean]$attribute5friendlyname,

        [Boolean]$attribute5format,

        [Boolean]$attribute6,

        [Boolean]$attribute6friendlyname,

        [Boolean]$attribute6format,

        [Boolean]$attribute7,

        [Boolean]$attribute7friendlyname,

        [Boolean]$attribute7format,

        [Boolean]$attribute8,

        [Boolean]$attribute8friendlyname,

        [Boolean]$attribute8format,

        [Boolean]$attribute9,

        [Boolean]$attribute9friendlyname,

        [Boolean]$attribute9format,

        [Boolean]$attribute10,

        [Boolean]$attribute10friendlyname,

        [Boolean]$attribute10format,

        [Boolean]$attribute11,

        [Boolean]$attribute11friendlyname,

        [Boolean]$attribute11format,

        [Boolean]$attribute12,

        [Boolean]$attribute12friendlyname,

        [Boolean]$attribute12format,

        [Boolean]$attribute13,

        [Boolean]$attribute13friendlyname,

        [Boolean]$attribute13format,

        [Boolean]$attribute14,

        [Boolean]$attribute14friendlyname,

        [Boolean]$attribute14format,

        [Boolean]$attribute15,

        [Boolean]$attribute15friendlyname,

        [Boolean]$attribute15format,

        [Boolean]$attribute16,

        [Boolean]$attribute16friendlyname,

        [Boolean]$attribute16format,

        [Boolean]$encryptassertion,

        [Boolean]$samlspcertname,

        [Boolean]$encryptionalgorithm,

        [Boolean]$skewtime,

        [Boolean]$signassertion 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetTmsamlssoprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('samlsigningcertname') ) { $payload.Add('samlsigningcertname', $samlsigningcertname) }
            if ( $PSBoundParameters.ContainsKey('sendpassword') ) { $payload.Add('sendpassword', $sendpassword) }
            if ( $PSBoundParameters.ContainsKey('samlissuername') ) { $payload.Add('samlissuername', $samlissuername) }
            if ( $PSBoundParameters.ContainsKey('relaystaterule') ) { $payload.Add('relaystaterule', $relaystaterule) }
            if ( $PSBoundParameters.ContainsKey('signaturealg') ) { $payload.Add('signaturealg', $signaturealg) }
            if ( $PSBoundParameters.ContainsKey('digestmethod') ) { $payload.Add('digestmethod', $digestmethod) }
            if ( $PSBoundParameters.ContainsKey('audience') ) { $payload.Add('audience', $audience) }
            if ( $PSBoundParameters.ContainsKey('nameidformat') ) { $payload.Add('nameidformat', $nameidformat) }
            if ( $PSBoundParameters.ContainsKey('nameidexpr') ) { $payload.Add('nameidexpr', $nameidexpr) }
            if ( $PSBoundParameters.ContainsKey('attribute1') ) { $payload.Add('attribute1', $attribute1) }
            if ( $PSBoundParameters.ContainsKey('attribute1friendlyname') ) { $payload.Add('attribute1friendlyname', $attribute1friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute1format') ) { $payload.Add('attribute1format', $attribute1format) }
            if ( $PSBoundParameters.ContainsKey('attribute2') ) { $payload.Add('attribute2', $attribute2) }
            if ( $PSBoundParameters.ContainsKey('attribute2friendlyname') ) { $payload.Add('attribute2friendlyname', $attribute2friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute2format') ) { $payload.Add('attribute2format', $attribute2format) }
            if ( $PSBoundParameters.ContainsKey('attribute3') ) { $payload.Add('attribute3', $attribute3) }
            if ( $PSBoundParameters.ContainsKey('attribute3friendlyname') ) { $payload.Add('attribute3friendlyname', $attribute3friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute3format') ) { $payload.Add('attribute3format', $attribute3format) }
            if ( $PSBoundParameters.ContainsKey('attribute4') ) { $payload.Add('attribute4', $attribute4) }
            if ( $PSBoundParameters.ContainsKey('attribute4friendlyname') ) { $payload.Add('attribute4friendlyname', $attribute4friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute4format') ) { $payload.Add('attribute4format', $attribute4format) }
            if ( $PSBoundParameters.ContainsKey('attribute5') ) { $payload.Add('attribute5', $attribute5) }
            if ( $PSBoundParameters.ContainsKey('attribute5friendlyname') ) { $payload.Add('attribute5friendlyname', $attribute5friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute5format') ) { $payload.Add('attribute5format', $attribute5format) }
            if ( $PSBoundParameters.ContainsKey('attribute6') ) { $payload.Add('attribute6', $attribute6) }
            if ( $PSBoundParameters.ContainsKey('attribute6friendlyname') ) { $payload.Add('attribute6friendlyname', $attribute6friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute6format') ) { $payload.Add('attribute6format', $attribute6format) }
            if ( $PSBoundParameters.ContainsKey('attribute7') ) { $payload.Add('attribute7', $attribute7) }
            if ( $PSBoundParameters.ContainsKey('attribute7friendlyname') ) { $payload.Add('attribute7friendlyname', $attribute7friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute7format') ) { $payload.Add('attribute7format', $attribute7format) }
            if ( $PSBoundParameters.ContainsKey('attribute8') ) { $payload.Add('attribute8', $attribute8) }
            if ( $PSBoundParameters.ContainsKey('attribute8friendlyname') ) { $payload.Add('attribute8friendlyname', $attribute8friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute8format') ) { $payload.Add('attribute8format', $attribute8format) }
            if ( $PSBoundParameters.ContainsKey('attribute9') ) { $payload.Add('attribute9', $attribute9) }
            if ( $PSBoundParameters.ContainsKey('attribute9friendlyname') ) { $payload.Add('attribute9friendlyname', $attribute9friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute9format') ) { $payload.Add('attribute9format', $attribute9format) }
            if ( $PSBoundParameters.ContainsKey('attribute10') ) { $payload.Add('attribute10', $attribute10) }
            if ( $PSBoundParameters.ContainsKey('attribute10friendlyname') ) { $payload.Add('attribute10friendlyname', $attribute10friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute10format') ) { $payload.Add('attribute10format', $attribute10format) }
            if ( $PSBoundParameters.ContainsKey('attribute11') ) { $payload.Add('attribute11', $attribute11) }
            if ( $PSBoundParameters.ContainsKey('attribute11friendlyname') ) { $payload.Add('attribute11friendlyname', $attribute11friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute11format') ) { $payload.Add('attribute11format', $attribute11format) }
            if ( $PSBoundParameters.ContainsKey('attribute12') ) { $payload.Add('attribute12', $attribute12) }
            if ( $PSBoundParameters.ContainsKey('attribute12friendlyname') ) { $payload.Add('attribute12friendlyname', $attribute12friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute12format') ) { $payload.Add('attribute12format', $attribute12format) }
            if ( $PSBoundParameters.ContainsKey('attribute13') ) { $payload.Add('attribute13', $attribute13) }
            if ( $PSBoundParameters.ContainsKey('attribute13friendlyname') ) { $payload.Add('attribute13friendlyname', $attribute13friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute13format') ) { $payload.Add('attribute13format', $attribute13format) }
            if ( $PSBoundParameters.ContainsKey('attribute14') ) { $payload.Add('attribute14', $attribute14) }
            if ( $PSBoundParameters.ContainsKey('attribute14friendlyname') ) { $payload.Add('attribute14friendlyname', $attribute14friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute14format') ) { $payload.Add('attribute14format', $attribute14format) }
            if ( $PSBoundParameters.ContainsKey('attribute15') ) { $payload.Add('attribute15', $attribute15) }
            if ( $PSBoundParameters.ContainsKey('attribute15friendlyname') ) { $payload.Add('attribute15friendlyname', $attribute15friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute15format') ) { $payload.Add('attribute15format', $attribute15format) }
            if ( $PSBoundParameters.ContainsKey('attribute16') ) { $payload.Add('attribute16', $attribute16) }
            if ( $PSBoundParameters.ContainsKey('attribute16friendlyname') ) { $payload.Add('attribute16friendlyname', $attribute16friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute16format') ) { $payload.Add('attribute16format', $attribute16format) }
            if ( $PSBoundParameters.ContainsKey('encryptassertion') ) { $payload.Add('encryptassertion', $encryptassertion) }
            if ( $PSBoundParameters.ContainsKey('samlspcertname') ) { $payload.Add('samlspcertname', $samlspcertname) }
            if ( $PSBoundParameters.ContainsKey('encryptionalgorithm') ) { $payload.Add('encryptionalgorithm', $encryptionalgorithm) }
            if ( $PSBoundParameters.ContainsKey('skewtime') ) { $payload.Add('skewtime', $skewtime) }
            if ( $PSBoundParameters.ContainsKey('signassertion') ) { $payload.Add('signassertion', $signassertion) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type tmsamlssoprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetTmsamlssoprofile: Finished"
    }
}

function Invoke-NSGetTmsamlssoprofile {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Configuration for SAML sso action resource.
    .PARAMETER Name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER GetAll 
        Retrieve all tmsamlssoprofile object(s).
    .PARAMETER Count
        If specified, the count of the tmsamlssoprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsamlssoprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsamlssoprofile -GetAll 
        Get all tmsamlssoprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsamlssoprofile -Count 
        Get the number of tmsamlssoprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsamlssoprofile -name <string>
        Get tmsamlssoprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsamlssoprofile -Filter @{ 'name'='<value>' }
        Get tmsamlssoprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmsamlssoprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsamlssoprofile/
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
        Write-Verbose "Invoke-NSGetTmsamlssoprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmsamlssoprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsamlssoprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsamlssoprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsamlssoprofile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsamlssoprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmsamlssoprofile: Ended"
    }
}

function Invoke-NSAddTmsessionaction {
    <#
    .SYNOPSIS
        Add TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM session action resource.
    .PARAMETER Name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER Sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access intranet resources. 
    .PARAMETER Defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Sso 
        Use single sign-on (SSO) to log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate to each application individually. Note that this configuration does not honor the following authentication types for security reason. BASIC, DIGEST, and NTLM (without Negotiate NTLM2 Key or Negotiate Sign Flag). Use TM TrafficAction to configure SSO for these authentication types. 
         
        Possible values = ON, OFF 
    .PARAMETER Ssocredential 
        Use the primary or secondary authentication credentials for single sign-on (SSO). 
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER Ssodomain 
        Domain to use for single sign-on (SSO). 
    .PARAMETER Httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts. 
         
        Possible values = YES, NO 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Persistentcookie 
        Enable or disable persistent SSO cookies for the traffic management (TM) session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. This setting is overwritten if a traffic action sets persistent cookie to OFF. 
        Note: If persistent cookie is enabled, make sure you set the persistent cookie validity. 
        Possible values = ON, OFF 
    .PARAMETER Persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistent cookie setting is enabled. 
    .PARAMETER Homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login. 
    .PARAMETER PassThru 
        Return details about the created tmsessionaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddTmsessionaction -name <string>
        An example how to add tmsessionaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddTmsessionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [double]$Sesstimeout,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Defaultauthorizationaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Sso = 'OFF',

        [ValidateSet('PRIMARY', 'SECONDARY')]
        [string]$Ssocredential,

        [ValidateLength(1, 32)]
        [string]$Ssodomain,

        [ValidateSet('YES', 'NO')]
        [string]$Httponlycookie = 'YES',

        [ValidateLength(1, 32)]
        [string]$Kcdaccount,

        [ValidateSet('ON', 'OFF')]
        [string]$Persistentcookie,

        [double]$Persistentcookievalidity,

        [string]$Homepage,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddTmsessionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sesstimeout') ) { $payload.Add('sesstimeout', $sesstimeout) }
            if ( $PSBoundParameters.ContainsKey('defaultauthorizationaction') ) { $payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('ssocredential') ) { $payload.Add('ssocredential', $ssocredential) }
            if ( $PSBoundParameters.ContainsKey('ssodomain') ) { $payload.Add('ssodomain', $ssodomain) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookievalidity') ) { $payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('homepage') ) { $payload.Add('homepage', $homepage) }
            if ( $PSCmdlet.ShouldProcess("tmsessionaction", "Add TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type tmsessionaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmsessionaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddTmsessionaction: Finished"
    }
}

function Invoke-NSDeleteTmsessionaction {
    <#
    .SYNOPSIS
        Delete TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM session action resource.
    .PARAMETER Name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteTmsessionaction -Name <string>
        An example how to delete tmsessionaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteTmsessionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteTmsessionaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type tmsessionaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteTmsessionaction: Finished"
    }
}

function Invoke-NSUpdateTmsessionaction {
    <#
    .SYNOPSIS
        Update TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM session action resource.
    .PARAMETER Name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER Sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access intranet resources. 
    .PARAMETER Defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Sso 
        Use single sign-on (SSO) to log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate to each application individually. Note that this configuration does not honor the following authentication types for security reason. BASIC, DIGEST, and NTLM (without Negotiate NTLM2 Key or Negotiate Sign Flag). Use TM TrafficAction to configure SSO for these authentication types. 
         
        Possible values = ON, OFF 
    .PARAMETER Ssocredential 
        Use the primary or secondary authentication credentials for single sign-on (SSO). 
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER Ssodomain 
        Domain to use for single sign-on (SSO). 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts. 
         
        Possible values = YES, NO 
    .PARAMETER Persistentcookie 
        Enable or disable persistent SSO cookies for the traffic management (TM) session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. This setting is overwritten if a traffic action sets persistent cookie to OFF. 
        Note: If persistent cookie is enabled, make sure you set the persistent cookie validity. 
        Possible values = ON, OFF 
    .PARAMETER Persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistent cookie setting is enabled. 
    .PARAMETER Homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login. 
    .PARAMETER PassThru 
        Return details about the created tmsessionaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateTmsessionaction -name <string>
        An example how to update tmsessionaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateTmsessionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [double]$Sesstimeout,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Defaultauthorizationaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Sso,

        [ValidateSet('PRIMARY', 'SECONDARY')]
        [string]$Ssocredential,

        [ValidateLength(1, 32)]
        [string]$Ssodomain,

        [ValidateLength(1, 32)]
        [string]$Kcdaccount,

        [ValidateSet('YES', 'NO')]
        [string]$Httponlycookie,

        [ValidateSet('ON', 'OFF')]
        [string]$Persistentcookie,

        [double]$Persistentcookievalidity,

        [string]$Homepage,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateTmsessionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sesstimeout') ) { $payload.Add('sesstimeout', $sesstimeout) }
            if ( $PSBoundParameters.ContainsKey('defaultauthorizationaction') ) { $payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('ssocredential') ) { $payload.Add('ssocredential', $ssocredential) }
            if ( $PSBoundParameters.ContainsKey('ssodomain') ) { $payload.Add('ssodomain', $ssodomain) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookievalidity') ) { $payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('homepage') ) { $payload.Add('homepage', $homepage) }
            if ( $PSCmdlet.ShouldProcess("tmsessionaction", "Update TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmsessionaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmsessionaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateTmsessionaction: Finished"
    }
}

function Invoke-NSUnsetTmsessionaction {
    <#
    .SYNOPSIS
        Unset TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM session action resource.
    .PARAMETER Name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER Sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access intranet resources. 
    .PARAMETER Defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Sso 
        Use single sign-on (SSO) to log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate to each application individually. Note that this configuration does not honor the following authentication types for security reason. BASIC, DIGEST, and NTLM (without Negotiate NTLM2 Key or Negotiate Sign Flag). Use TM TrafficAction to configure SSO for these authentication types. 
         
        Possible values = ON, OFF 
    .PARAMETER Ssocredential 
        Use the primary or secondary authentication credentials for single sign-on (SSO). 
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER Ssodomain 
        Domain to use for single sign-on (SSO). 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts. 
         
        Possible values = YES, NO 
    .PARAMETER Persistentcookie 
        Enable or disable persistent SSO cookies for the traffic management (TM) session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. This setting is overwritten if a traffic action sets persistent cookie to OFF. 
        Note: If persistent cookie is enabled, make sure you set the persistent cookie validity. 
        Possible values = ON, OFF 
    .PARAMETER Persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistent cookie setting is enabled. 
    .PARAMETER Homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetTmsessionaction -name <string>
        An example how to unset tmsessionaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetTmsessionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionaction
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$sesstimeout,

        [Boolean]$defaultauthorizationaction,

        [Boolean]$sso,

        [Boolean]$ssocredential,

        [Boolean]$ssodomain,

        [Boolean]$kcdaccount,

        [Boolean]$httponlycookie,

        [Boolean]$persistentcookie,

        [Boolean]$persistentcookievalidity,

        [Boolean]$homepage 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetTmsessionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sesstimeout') ) { $payload.Add('sesstimeout', $sesstimeout) }
            if ( $PSBoundParameters.ContainsKey('defaultauthorizationaction') ) { $payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('ssocredential') ) { $payload.Add('ssocredential', $ssocredential) }
            if ( $PSBoundParameters.ContainsKey('ssodomain') ) { $payload.Add('ssodomain', $ssodomain) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookievalidity') ) { $payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('homepage') ) { $payload.Add('homepage', $homepage) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type tmsessionaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetTmsessionaction: Finished"
    }
}

function Invoke-NSGetTmsessionaction {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Configuration for TM session action resource.
    .PARAMETER Name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER GetAll 
        Retrieve all tmsessionaction object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionaction -GetAll 
        Get all tmsessionaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionaction -Count 
        Get the number of tmsessionaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionaction -name <string>
        Get tmsessionaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionaction -Filter @{ 'name'='<value>' }
        Get tmsessionaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmsessionaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionaction/
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
        Write-Verbose "Invoke-NSGetTmsessionaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmsessionaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmsessionaction: Ended"
    }
}

function Invoke-NSUpdateTmsessionparameter {
    <#
    .SYNOPSIS
        Update TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for session parameter resource.
    .PARAMETER Sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access the intranet resources. 
    .PARAMETER Defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy. 
         
        Possible values = ALLOW, DENY 
    .PARAMETER Sso 
        Log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate for each application. Note that this configuration does not honor the following authentication types for security reason. BASIC, DIGEST, and NTLM (without Negotiate NTLM2 Key or Negotiate Sign Flag). Use TM TrafficAction to configure SSO for these authentication types. 
         
        Possible values = ON, OFF 
    .PARAMETER Ssocredential 
        Use primary or secondary authentication credentials for single sign-on. 
         
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER Ssodomain 
        Domain to use for single sign-on. 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts. 
         
        Possible values = YES, NO 
    .PARAMETER Persistentcookie 
        Use persistent SSO cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. 
         
        Possible values = ON, OFF 
    .PARAMETER Persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistence cookie setting is enabled. 
    .PARAMETER Homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateTmsessionparameter 
        An example how to update tmsessionparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateTmsessionparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionparameter/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [double]$Sesstimeout,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Defaultauthorizationaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Sso,

        [ValidateSet('PRIMARY', 'SECONDARY')]
        [string]$Ssocredential,

        [ValidateLength(1, 32)]
        [string]$Ssodomain,

        [ValidateLength(1, 32)]
        [string]$Kcdaccount,

        [ValidateSet('YES', 'NO')]
        [string]$Httponlycookie,

        [ValidateSet('ON', 'OFF')]
        [string]$Persistentcookie,

        [double]$Persistentcookievalidity,

        [string]$Homepage 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateTmsessionparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sesstimeout') ) { $payload.Add('sesstimeout', $sesstimeout) }
            if ( $PSBoundParameters.ContainsKey('defaultauthorizationaction') ) { $payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('ssocredential') ) { $payload.Add('ssocredential', $ssocredential) }
            if ( $PSBoundParameters.ContainsKey('ssodomain') ) { $payload.Add('ssodomain', $ssodomain) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookievalidity') ) { $payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('homepage') ) { $payload.Add('homepage', $homepage) }
            if ( $PSCmdlet.ShouldProcess("tmsessionparameter", "Update TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmsessionparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateTmsessionparameter: Finished"
    }
}

function Invoke-NSUnsetTmsessionparameter {
    <#
    .SYNOPSIS
        Unset TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for session parameter resource.
    .PARAMETER Sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access the intranet resources. 
    .PARAMETER Sso 
        Log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate for each application. Note that this configuration does not honor the following authentication types for security reason. BASIC, DIGEST, and NTLM (without Negotiate NTLM2 Key or Negotiate Sign Flag). Use TM TrafficAction to configure SSO for these authentication types. 
         
        Possible values = ON, OFF 
    .PARAMETER Ssodomain 
        Domain to use for single sign-on. 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Persistentcookie 
        Use persistent SSO cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. 
         
        Possible values = ON, OFF 
    .PARAMETER Homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login. 
    .PARAMETER Defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy. 
         
        Possible values = ALLOW, DENY 
    .PARAMETER Ssocredential 
        Use primary or secondary authentication credentials for single sign-on. 
         
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER Httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts. 
         
        Possible values = YES, NO 
    .PARAMETER Persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistence cookie setting is enabled.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetTmsessionparameter 
        An example how to unset tmsessionparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetTmsessionparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionparameter
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$sesstimeout,

        [Boolean]$sso,

        [Boolean]$ssodomain,

        [Boolean]$kcdaccount,

        [Boolean]$persistentcookie,

        [Boolean]$homepage,

        [Boolean]$defaultauthorizationaction,

        [Boolean]$ssocredential,

        [Boolean]$httponlycookie,

        [Boolean]$persistentcookievalidity 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetTmsessionparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sesstimeout') ) { $payload.Add('sesstimeout', $sesstimeout) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('ssodomain') ) { $payload.Add('ssodomain', $ssodomain) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('homepage') ) { $payload.Add('homepage', $homepage) }
            if ( $PSBoundParameters.ContainsKey('defaultauthorizationaction') ) { $payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ( $PSBoundParameters.ContainsKey('ssocredential') ) { $payload.Add('ssocredential', $ssocredential) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookievalidity') ) { $payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ( $PSCmdlet.ShouldProcess("tmsessionparameter", "Unset TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type tmsessionparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetTmsessionparameter: Finished"
    }
}

function Invoke-NSGetTmsessionparameter {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Configuration for session parameter resource.
    .PARAMETER GetAll 
        Retrieve all tmsessionparameter object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionparameter -GetAll 
        Get all tmsessionparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionparameter -name <string>
        Get tmsessionparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionparameter -Filter @{ 'name'='<value>' }
        Get tmsessionparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmsessionparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionparameter/
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
        Write-Verbose "Invoke-NSGetTmsessionparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmsessionparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmsessionparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmsessionparameter: Ended"
    }
}

function Invoke-NSAddTmsessionpolicy {
    <#
    .SYNOPSIS
        Add TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM session policy resource.
    .PARAMETER Name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER Rule 
        Expression, against which traffic is evaluated. Both classic and advance expressions are supported in default partition but only advance expressions in non-default partition. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Action to be applied to connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created tmsessionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddTmsessionpolicy -name <string> -rule <string> -action <string>
        An example how to add tmsessionpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddTmsessionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddTmsessionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("tmsessionpolicy", "Add TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type tmsessionpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmsessionpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddTmsessionpolicy: Finished"
    }
}

function Invoke-NSDeleteTmsessionpolicy {
    <#
    .SYNOPSIS
        Delete TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM session policy resource.
    .PARAMETER Name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteTmsessionpolicy -Name <string>
        An example how to delete tmsessionpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteTmsessionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteTmsessionpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type tmsessionpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteTmsessionpolicy: Finished"
    }
}

function Invoke-NSUpdateTmsessionpolicy {
    <#
    .SYNOPSIS
        Update TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM session policy resource.
    .PARAMETER Name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER Rule 
        Expression, against which traffic is evaluated. Both classic and advance expressions are supported in default partition but only advance expressions in non-default partition. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Action to be applied to connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created tmsessionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateTmsessionpolicy -name <string>
        An example how to update tmsessionpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateTmsessionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateTmsessionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("tmsessionpolicy", "Update TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmsessionpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmsessionpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateTmsessionpolicy: Finished"
    }
}

function Invoke-NSUnsetTmsessionpolicy {
    <#
    .SYNOPSIS
        Unset TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM session policy resource.
    .PARAMETER Name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER Rule 
        Expression, against which traffic is evaluated. Both classic and advance expressions are supported in default partition but only advance expressions in non-default partition. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Action to be applied to connections that match this policy.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetTmsessionpolicy -name <string>
        An example how to unset tmsessionpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetTmsessionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionpolicy
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$rule,

        [Boolean]$action 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetTmsessionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type tmsessionpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetTmsessionpolicy: Finished"
    }
}

function Invoke-NSGetTmsessionpolicy {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Configuration for TM session policy resource.
    .PARAMETER Name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicy -GetAll 
        Get all tmsessionpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicy -Count 
        Get the number of tmsessionpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicy -name <string>
        Get tmsessionpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicy -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmsessionpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionpolicy/
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
        Write-Verbose "Invoke-NSGetTmsessionpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmsessionpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmsessionpolicy: Ended"
    }
}

function Invoke-NSGetTmsessionpolicyAaagroupBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the aaagroup that can be bound to tmsessionpolicy.
    .PARAMETER Name 
        Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy_aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyAaagroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicyAaagroupBinding -GetAll 
        Get all tmsessionpolicy_aaagroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicyAaagroupBinding -Count 
        Get the number of tmsessionpolicy_aaagroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyAaagroupBinding -name <string>
        Get tmsessionpolicy_aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyAaagroupBinding -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy_aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmsessionpolicyAaagroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionpolicy_aaagroup_binding/
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
        Write-Verbose "Invoke-NSGetTmsessionpolicyAaagroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmsessionpolicy_aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_aaagroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaagroup_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_aaagroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmsessionpolicyAaagroupBinding: Ended"
    }
}

function Invoke-NSGetTmsessionpolicyAaauserBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to tmsessionpolicy.
    .PARAMETER Name 
        Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy_aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyAaauserBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicyAaauserBinding -GetAll 
        Get all tmsessionpolicy_aaauser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicyAaauserBinding -Count 
        Get the number of tmsessionpolicy_aaauser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyAaauserBinding -name <string>
        Get tmsessionpolicy_aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyAaauserBinding -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy_aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmsessionpolicyAaauserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionpolicy_aaauser_binding/
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
        Write-Verbose "Invoke-NSGetTmsessionpolicyAaauserBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmsessionpolicy_aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_aaauser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaauser_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_aaauser_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmsessionpolicyAaauserBinding: Ended"
    }
}

function Invoke-NSGetTmsessionpolicyAuthenticationvserverBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to tmsessionpolicy.
    .PARAMETER Name 
        Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy_authenticationvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_authenticationvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyAuthenticationvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicyAuthenticationvserverBinding -GetAll 
        Get all tmsessionpolicy_authenticationvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicyAuthenticationvserverBinding -Count 
        Get the number of tmsessionpolicy_authenticationvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyAuthenticationvserverBinding -name <string>
        Get tmsessionpolicy_authenticationvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyAuthenticationvserverBinding -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy_authenticationvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmsessionpolicyAuthenticationvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionpolicy_authenticationvserver_binding/
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
        Write-Verbose "Invoke-NSGetTmsessionpolicyAuthenticationvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmsessionpolicy_authenticationvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_authenticationvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_authenticationvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_authenticationvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_authenticationvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmsessionpolicyAuthenticationvserverBinding: Ended"
    }
}

function Invoke-NSGetTmsessionpolicyBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to tmsessionpolicy.
    .PARAMETER Name 
        Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicyBinding -GetAll 
        Get all tmsessionpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyBinding -name <string>
        Get tmsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyBinding -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmsessionpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionpolicy_binding/
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
        Write-Verbose "Invoke-NSGetTmsessionpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmsessionpolicyBinding: Ended"
    }
}

function Invoke-NSGetTmsessionpolicyTmglobalBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the tmglobal that can be bound to tmsessionpolicy.
    .PARAMETER Name 
        Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy_tmglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_tmglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyTmglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicyTmglobalBinding -GetAll 
        Get all tmsessionpolicy_tmglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmsessionpolicyTmglobalBinding -Count 
        Get the number of tmsessionpolicy_tmglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyTmglobalBinding -name <string>
        Get tmsessionpolicy_tmglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmsessionpolicyTmglobalBinding -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy_tmglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmsessionpolicyTmglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmsessionpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-NSGetTmsessionpolicyTmglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmsessionpolicy_tmglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_tmglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_tmglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_tmglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmsessionpolicyTmglobalBinding: Ended"
    }
}

function Invoke-NSAddTmtrafficaction {
    <#
    .SYNOPSIS
        Add TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM traffic action resource.
    .PARAMETER Name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER Apptimeout 
        Time interval, in minutes, of user inactivity after which the connection is closed. 
         
        Maximum value = 715827 
    .PARAMETER Sso 
        Use single sign-on for the resource that the user is accessing now. 
        Possible values = ON, OFF 
    .PARAMETER Formssoaction 
        Name of the configured form-based single sign-on profile. 
    .PARAMETER Persistentcookie 
        Use persistent cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. 
        Possible values = ON, OFF 
    .PARAMETER Initiatelogout 
        Initiate logout for the traffic management (TM) session if the policy evaluates to true. The session is then terminated after two minutes. 
        Possible values = ON, OFF 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Samlssoprofile 
        Profile to be used for doing SAML SSO to remote relying party. 
    .PARAMETER Forcedtimeout 
        Setting to start, stop or reset TM session force timer. 
        Possible values = START, STOP, RESET 
    .PARAMETER Forcedtimeoutval 
        Time interval, in minutes, for which force timer should be set. 
    .PARAMETER Userexpression 
        expression that will be evaluated to obtain username for SingleSignOn. 
    .PARAMETER Passwdexpression 
        expression that will be evaluated to obtain password for SingleSignOn. 
    .PARAMETER PassThru 
        Return details about the created tmtrafficaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddTmtrafficaction -name <string>
        An example how to add tmtrafficaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddTmtrafficaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [double]$Apptimeout,

        [ValidateSet('ON', 'OFF')]
        [string]$Sso,

        [string]$Formssoaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Persistentcookie,

        [ValidateSet('ON', 'OFF')]
        [string]$Initiatelogout,

        [ValidateLength(1, 32)]
        [string]$Kcdaccount = '"None"',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlssoprofile,

        [ValidateSet('START', 'STOP', 'RESET')]
        [string]$Forcedtimeout,

        [double]$Forcedtimeoutval,

        [string]$Userexpression,

        [string]$Passwdexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddTmtrafficaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('apptimeout') ) { $payload.Add('apptimeout', $apptimeout) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('formssoaction') ) { $payload.Add('formssoaction', $formssoaction) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('initiatelogout') ) { $payload.Add('initiatelogout', $initiatelogout) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('samlssoprofile') ) { $payload.Add('samlssoprofile', $samlssoprofile) }
            if ( $PSBoundParameters.ContainsKey('forcedtimeout') ) { $payload.Add('forcedtimeout', $forcedtimeout) }
            if ( $PSBoundParameters.ContainsKey('forcedtimeoutval') ) { $payload.Add('forcedtimeoutval', $forcedtimeoutval) }
            if ( $PSBoundParameters.ContainsKey('userexpression') ) { $payload.Add('userexpression', $userexpression) }
            if ( $PSBoundParameters.ContainsKey('passwdexpression') ) { $payload.Add('passwdexpression', $passwdexpression) }
            if ( $PSCmdlet.ShouldProcess("tmtrafficaction", "Add TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type tmtrafficaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmtrafficaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddTmtrafficaction: Finished"
    }
}

function Invoke-NSDeleteTmtrafficaction {
    <#
    .SYNOPSIS
        Delete TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM traffic action resource.
    .PARAMETER Name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteTmtrafficaction -Name <string>
        An example how to delete tmtrafficaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteTmtrafficaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteTmtrafficaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type tmtrafficaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteTmtrafficaction: Finished"
    }
}

function Invoke-NSUpdateTmtrafficaction {
    <#
    .SYNOPSIS
        Update TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM traffic action resource.
    .PARAMETER Name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER Apptimeout 
        Time interval, in minutes, of user inactivity after which the connection is closed. 
         
        Maximum value = 715827 
    .PARAMETER Sso 
        Use single sign-on for the resource that the user is accessing now. 
        Possible values = ON, OFF 
    .PARAMETER Formssoaction 
        Name of the configured form-based single sign-on profile. 
    .PARAMETER Persistentcookie 
        Use persistent cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. 
        Possible values = ON, OFF 
    .PARAMETER Initiatelogout 
        Initiate logout for the traffic management (TM) session if the policy evaluates to true. The session is then terminated after two minutes. 
        Possible values = ON, OFF 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Samlssoprofile 
        Profile to be used for doing SAML SSO to remote relying party. 
    .PARAMETER Forcedtimeout 
        Setting to start, stop or reset TM session force timer. 
        Possible values = START, STOP, RESET 
    .PARAMETER Forcedtimeoutval 
        Time interval, in minutes, for which force timer should be set. 
    .PARAMETER Userexpression 
        expression that will be evaluated to obtain username for SingleSignOn. 
    .PARAMETER Passwdexpression 
        expression that will be evaluated to obtain password for SingleSignOn. 
    .PARAMETER PassThru 
        Return details about the created tmtrafficaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateTmtrafficaction -name <string>
        An example how to update tmtrafficaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateTmtrafficaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficaction/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [double]$Apptimeout,

        [ValidateSet('ON', 'OFF')]
        [string]$Sso,

        [string]$Formssoaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Persistentcookie,

        [ValidateSet('ON', 'OFF')]
        [string]$Initiatelogout,

        [ValidateLength(1, 32)]
        [string]$Kcdaccount,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlssoprofile,

        [ValidateSet('START', 'STOP', 'RESET')]
        [string]$Forcedtimeout,

        [double]$Forcedtimeoutval,

        [string]$Userexpression,

        [string]$Passwdexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateTmtrafficaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('apptimeout') ) { $payload.Add('apptimeout', $apptimeout) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('formssoaction') ) { $payload.Add('formssoaction', $formssoaction) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('initiatelogout') ) { $payload.Add('initiatelogout', $initiatelogout) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('samlssoprofile') ) { $payload.Add('samlssoprofile', $samlssoprofile) }
            if ( $PSBoundParameters.ContainsKey('forcedtimeout') ) { $payload.Add('forcedtimeout', $forcedtimeout) }
            if ( $PSBoundParameters.ContainsKey('forcedtimeoutval') ) { $payload.Add('forcedtimeoutval', $forcedtimeoutval) }
            if ( $PSBoundParameters.ContainsKey('userexpression') ) { $payload.Add('userexpression', $userexpression) }
            if ( $PSBoundParameters.ContainsKey('passwdexpression') ) { $payload.Add('passwdexpression', $passwdexpression) }
            if ( $PSCmdlet.ShouldProcess("tmtrafficaction", "Update TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmtrafficaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmtrafficaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateTmtrafficaction: Finished"
    }
}

function Invoke-NSUnsetTmtrafficaction {
    <#
    .SYNOPSIS
        Unset TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM traffic action resource.
    .PARAMETER Name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER Persistentcookie 
        Use persistent cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. 
        Possible values = ON, OFF 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Forcedtimeout 
        Setting to start, stop or reset TM session force timer. 
        Possible values = START, STOP, RESET 
    .PARAMETER Userexpression 
        expression that will be evaluated to obtain username for SingleSignOn. 
    .PARAMETER Passwdexpression 
        expression that will be evaluated to obtain password for SingleSignOn.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetTmtrafficaction -name <string>
        An example how to unset tmtrafficaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetTmtrafficaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficaction
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$persistentcookie,

        [Boolean]$kcdaccount,

        [Boolean]$forcedtimeout,

        [Boolean]$userexpression,

        [Boolean]$passwdexpression 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetTmtrafficaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('forcedtimeout') ) { $payload.Add('forcedtimeout', $forcedtimeout) }
            if ( $PSBoundParameters.ContainsKey('userexpression') ) { $payload.Add('userexpression', $userexpression) }
            if ( $PSBoundParameters.ContainsKey('passwdexpression') ) { $payload.Add('passwdexpression', $passwdexpression) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type tmtrafficaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetTmtrafficaction: Finished"
    }
}

function Invoke-NSGetTmtrafficaction {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Configuration for TM traffic action resource.
    .PARAMETER Name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficaction object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficaction -GetAll 
        Get all tmtrafficaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficaction -Count 
        Get the number of tmtrafficaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficaction -name <string>
        Get tmtrafficaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficaction -Filter @{ 'name'='<value>' }
        Get tmtrafficaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmtrafficaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficaction/
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
        Write-Verbose "Invoke-NSGetTmtrafficaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmtrafficaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmtrafficaction: Ended"
    }
}

function Invoke-NSAddTmtrafficpolicy {
    <#
    .SYNOPSIS
        Add TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM traffic policy resource.
    .PARAMETER Name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named expression, or an expression, that the policy uses to determine whether to apply certain action on the current traffic. 
    .PARAMETER Action 
        Name of the action to apply to requests or connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created tmtrafficpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddTmtrafficpolicy -name <string> -rule <string> -action <string>
        An example how to add tmtrafficpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddTmtrafficpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddTmtrafficpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("tmtrafficpolicy", "Add TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type tmtrafficpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmtrafficpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddTmtrafficpolicy: Finished"
    }
}

function Invoke-NSDeleteTmtrafficpolicy {
    <#
    .SYNOPSIS
        Delete TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM traffic policy resource.
    .PARAMETER Name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteTmtrafficpolicy -Name <string>
        An example how to delete tmtrafficpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteTmtrafficpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteTmtrafficpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type tmtrafficpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteTmtrafficpolicy: Finished"
    }
}

function Invoke-NSUpdateTmtrafficpolicy {
    <#
    .SYNOPSIS
        Update TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM traffic policy resource.
    .PARAMETER Name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named expression, or an expression, that the policy uses to determine whether to apply certain action on the current traffic. 
    .PARAMETER Action 
        Name of the action to apply to requests or connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created tmtrafficpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateTmtrafficpolicy -name <string>
        An example how to update tmtrafficpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateTmtrafficpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficpolicy/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateTmtrafficpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("tmtrafficpolicy", "Update TM session/policy configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type tmtrafficpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetTmtrafficpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateTmtrafficpolicy: Finished"
    }
}

function Invoke-NSUnsetTmtrafficpolicy {
    <#
    .SYNOPSIS
        Unset TM session/policy configuration. config Object.
    .DESCRIPTION
        Configuration for TM traffic policy resource.
    .PARAMETER Name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named expression, or an expression, that the policy uses to determine whether to apply certain action on the current traffic. 
    .PARAMETER Action 
        Name of the action to apply to requests or connections that match this policy.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetTmtrafficpolicy -name <string>
        An example how to unset tmtrafficpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetTmtrafficpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficpolicy
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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

        [Boolean]$rule,

        [Boolean]$action 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetTmtrafficpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset TM session/policy configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type tmtrafficpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetTmtrafficpolicy: Finished"
    }
}

function Invoke-NSGetTmtrafficpolicy {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Configuration for TM traffic policy resource.
    .PARAMETER Name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficpolicy object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficpolicy -GetAll 
        Get all tmtrafficpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficpolicy -Count 
        Get the number of tmtrafficpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicy -name <string>
        Get tmtrafficpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicy -Filter @{ 'name'='<value>' }
        Get tmtrafficpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmtrafficpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficpolicy/
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
        Write-Verbose "Invoke-NSGetTmtrafficpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmtrafficpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmtrafficpolicy: Ended"
    }
}

function Invoke-NSGetTmtrafficpolicyBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to tmtrafficpolicy.
    .PARAMETER Name 
        Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficpolicyBinding -GetAll 
        Get all tmtrafficpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyBinding -name <string>
        Get tmtrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyBinding -Filter @{ 'name'='<value>' }
        Get tmtrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmtrafficpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficpolicy_binding/
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
        Write-Verbose "Invoke-NSGetTmtrafficpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmtrafficpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmtrafficpolicyBinding: Ended"
    }
}

function Invoke-NSGetTmtrafficpolicyCsvserverBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to tmtrafficpolicy.
    .PARAMETER Name 
        Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficpolicyCsvserverBinding -GetAll 
        Get all tmtrafficpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficpolicyCsvserverBinding -Count 
        Get the number of tmtrafficpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyCsvserverBinding -name <string>
        Get tmtrafficpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyCsvserverBinding -Filter @{ 'name'='<value>' }
        Get tmtrafficpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmtrafficpolicyCsvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-NSGetTmtrafficpolicyCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmtrafficpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmtrafficpolicyCsvserverBinding: Ended"
    }
}

function Invoke-NSGetTmtrafficpolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to tmtrafficpolicy.
    .PARAMETER Name 
        Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficpolicyLbvserverBinding -GetAll 
        Get all tmtrafficpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficpolicyLbvserverBinding -Count 
        Get the number of tmtrafficpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyLbvserverBinding -name <string>
        Get tmtrafficpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get tmtrafficpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmtrafficpolicyLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetTmtrafficpolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmtrafficpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmtrafficpolicyLbvserverBinding: Ended"
    }
}

function Invoke-NSGetTmtrafficpolicyTmglobalBinding {
    <#
    .SYNOPSIS
        Get TM session/policy configuration. config object(s).
    .DESCRIPTION
        Binding object showing the tmglobal that can be bound to tmtrafficpolicy.
    .PARAMETER Name 
        Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficpolicy_tmglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_tmglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyTmglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficpolicyTmglobalBinding -GetAll 
        Get all tmtrafficpolicy_tmglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetTmtrafficpolicyTmglobalBinding -Count 
        Get the number of tmtrafficpolicy_tmglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyTmglobalBinding -name <string>
        Get tmtrafficpolicy_tmglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetTmtrafficpolicyTmglobalBinding -Filter @{ 'name'='<value>' }
        Get tmtrafficpolicy_tmglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetTmtrafficpolicyTmglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/tm/tmtrafficpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-NSGetTmtrafficpolicyTmglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmtrafficpolicy_tmglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_tmglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_tmglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_tmglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetTmtrafficpolicyTmglobalBinding: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAfL8toUPGXGXZc
# 992p4Wr7J8lyPyRPuLRPrlXCHiWBL6CCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQgYZ1aSjlcuq6fxAREmzvLdx7pRgZ3dr0xsRe3t2gYa38wDQYJ
# KoZIhvcNAQEBBQAEggEADLnv1T3r+8vFvRyp5toFYE4k269DtH0g2AoKrNQCQdaL
# Mh+jHqcifVI3kvaqOc8YsX2eGgwuBtQnxglGW3B3SCV8ELoAMo1Lj1BHQaHGcAYl
# tBp0brkSJPfcXkvXNhvlpA7Yi27uPFcCnjrOCMHnES0NTBesDpCB5PHk+eRIC9Ni
# lTMfSL9wNXx/SKMTfGsUWJp/nB7BkObng2GzSEkPvOOP42G3aDaroSFfMuMAW9Mc
# Kob0EXHkh9v82EzP4DTqcr2wPiCi2ugSUWKMSL9expVrxOQDTLF2L+VEi+MpwszS
# l0pi2m3cGm+ULq2GjOuYEiEA1zlY+qFvyZAApnqBnqGCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQzNTJaMD8GCSqG
# SIb3DQEJBDEyBDC1Vd07OGOqm6iDlVvpMixUsZiyrWC68FaDO8c1kPrFq5bbZeMc
# XddGQv2699Z60z4wDQYJKoZIhvcNAQEBBQAEggIAJQ2+EllzhO+ty7DczNkPNP+y
# 6aoK0Vqd3DgQQVM6ITazFK2EhB88S+5ss66oTK+1aZqTKeZwHdq7BI3A/Mfwk6bm
# rdSP7Is8p4v34Q3ZjWfNLvwcXqB4vb4PE82bSmDhx1SB4PyRwjeNE5Kb4sRG+lmM
# 3WKT/8ViDs4ffkCfrOatC/MxgL08/5CaHdtlYhKhDBvzC/GA9LT5Educddrbq6uS
# 4l0CRlAQ4tNVyx4Km+xd8aoE58gfVxULdoz5/MMjvMgzo2nfdGTqRLPVIhhb6zJM
# Q/d2NHFGkuQFKrJjX9UVuNKo9tO5/S9puRr4YAUVU2fsUbHX86uc0BRciIEOaUBo
# EHEdDZM1JefJEUh0nztclKDJQJCbNAuBqp/VKJD2MbEXX9vrc5O+zjDRWWDJhzJF
# R7BMgSrMJIFuHISHyDq6zrNc1i5fvAwxCeOCHscdixkIV6uJf1a8/sHaC1H5DN1j
# z7Y8hf8iTG//DIfH7YGI7afkeUNP0xiviFK/ZZ8yfxM8I1+et1und6oFVy6qcZEx
# fjUFxdxJTXuUz8KQ6X/YLyVAu5GnFgiKhtoEyjUGvC5Jakr0jt6P/shItbF6+mIH
# oESTc0VlJvTpI7i2sXRzNhE2jkl1o3Ev2/GTrcsDT1IHKVt7bpGHw1au1Zj+b6AY
# 0S00UD/FVeRmRbNNfU0=
# SIG # End signature block
