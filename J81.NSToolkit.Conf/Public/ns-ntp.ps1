function Invoke-NSUpdateNtpparam {
    <#
    .SYNOPSIS
        Update NTP configuration. config Object.
    .DESCRIPTION
        Configuration for NTP parameter resource.
    .PARAMETER Authentication 
        Apply NTP authentication, which enables the NTP client (Citrix ADC) to verify that the server is in fact known and trusted. 
         
        Possible values = YES, NO 
    .PARAMETER Trustedkey 
        Key identifiers that are trusted for server authentication with symmetric key cryptography in the keys file. 
         
        Maximum value = 65534 
    .PARAMETER Autokeylogsec 
        Autokey protocol requires the keys to be refreshed periodically. This parameter specifies the interval between regenerations of new session keys. In seconds, expressed as a power of 2. 
         
         
        Maximum value = 32 
    .PARAMETER Revokelogsec 
        Interval between re-randomizations of the autokey seeds to prevent brute-force attacks on the autokey algorithms. 
         
         
        Maximum value = 32
    .EXAMPLE
        PS C:\>Invoke-NSUpdateNtpparam 
        An example how to update ntpparam config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateNtpparam
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpparam/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Authentication,

        [double[]]$Trustedkey,

        [double]$Autokeylogsec,

        [double]$Revokelogsec 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateNtpparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('trustedkey') ) { $payload.Add('trustedkey', $trustedkey) }
            if ( $PSBoundParameters.ContainsKey('autokeylogsec') ) { $payload.Add('autokeylogsec', $autokeylogsec) }
            if ( $PSBoundParameters.ContainsKey('revokelogsec') ) { $payload.Add('revokelogsec', $revokelogsec) }
            if ( $PSCmdlet.ShouldProcess("ntpparam", "Update NTP configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type ntpparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateNtpparam: Finished"
    }
}

function Invoke-NSUnsetNtpparam {
    <#
    .SYNOPSIS
        Unset NTP configuration. config Object.
    .DESCRIPTION
        Configuration for NTP parameter resource.
    .PARAMETER Authentication 
        Apply NTP authentication, which enables the NTP client (Citrix ADC) to verify that the server is in fact known and trusted. 
         
        Possible values = YES, NO 
    .PARAMETER Trustedkey 
        Key identifiers that are trusted for server authentication with symmetric key cryptography in the keys file. 
         
        Maximum value = 65534 
    .PARAMETER Autokeylogsec 
        Autokey protocol requires the keys to be refreshed periodically. This parameter specifies the interval between regenerations of new session keys. In seconds, expressed as a power of 2. 
         
         
        Maximum value = 32 
    .PARAMETER Revokelogsec 
        Interval between re-randomizations of the autokey seeds to prevent brute-force attacks on the autokey algorithms. 
         
         
        Maximum value = 32
    .EXAMPLE
        PS C:\>Invoke-NSUnsetNtpparam 
        An example how to unset ntpparam config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetNtpparam
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpparam
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$authentication,

        [Boolean]$trustedkey,

        [Boolean]$autokeylogsec,

        [Boolean]$revokelogsec 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetNtpparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('trustedkey') ) { $payload.Add('trustedkey', $trustedkey) }
            if ( $PSBoundParameters.ContainsKey('autokeylogsec') ) { $payload.Add('autokeylogsec', $autokeylogsec) }
            if ( $PSBoundParameters.ContainsKey('revokelogsec') ) { $payload.Add('revokelogsec', $revokelogsec) }
            if ( $PSCmdlet.ShouldProcess("ntpparam", "Unset NTP configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type ntpparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetNtpparam: Finished"
    }
}

function Invoke-NSGetNtpparam {
    <#
    .SYNOPSIS
        Get NTP configuration. config object(s).
    .DESCRIPTION
        Configuration for NTP parameter resource.
    .PARAMETER GetAll 
        Retrieve all ntpparam object(s).
    .PARAMETER Count
        If specified, the count of the ntpparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetNtpparam -GetAll 
        Get all ntpparam data.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpparam -name <string>
        Get ntpparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpparam -Filter @{ 'name'='<value>' }
        Get ntpparam data with a filter.
    .NOTES
        File Name : Invoke-NSGetNtpparam
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpparam/
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
        Write-Verbose "Invoke-NSGetNtpparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ntpparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpparam configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetNtpparam: Ended"
    }
}

function Invoke-NSAddNtpserver {
    <#
    .SYNOPSIS
        Add NTP configuration. config Object.
    .DESCRIPTION
        Configuration for NTP server resource.
    .PARAMETER Serverip 
        IP address of the NTP server. 
    .PARAMETER Servername 
        Fully qualified domain name of the NTP server. 
    .PARAMETER Minpoll 
        Minimum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
         
        Maximum value = 17 
    .PARAMETER Maxpoll 
        Maximum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
         
        Maximum value = 17 
    .PARAMETER Autokey 
        Use the Autokey protocol for key management for this server, with the cryptographic values (for example, symmetric key, host and public certificate files, and sign key) generated by the ntp-keygen utility. To require authentication for communication with the server, you must set either the value of this parameter or the key parameter. 
    .PARAMETER Key 
        Key to use for encrypting authentication fields. All packets sent to and received from the server must include authentication fields encrypted by using this key. To require authentication for communication with the server, you must set either the value of this parameter or the autokey parameter. 
         
        Maximum value = 65534
    .EXAMPLE
        PS C:\>Invoke-NSAddNtpserver 
        An example how to add ntpserver config Object(s).
    .NOTES
        File Name : Invoke-NSAddNtpserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Serverip,

        [string]$Servername,

        [double]$Minpoll,

        [double]$Maxpoll,

        [boolean]$Autokey,

        [double]$Key 
    )
    begin {
        Write-Verbose "Invoke-NSAddNtpserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('minpoll') ) { $payload.Add('minpoll', $minpoll) }
            if ( $PSBoundParameters.ContainsKey('maxpoll') ) { $payload.Add('maxpoll', $maxpoll) }
            if ( $PSBoundParameters.ContainsKey('autokey') ) { $payload.Add('autokey', $autokey) }
            if ( $PSBoundParameters.ContainsKey('key') ) { $payload.Add('key', $key) }
            if ( $PSCmdlet.ShouldProcess("ntpserver", "Add NTP configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type ntpserver -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSAddNtpserver: Finished"
    }
}

function Invoke-NSDeleteNtpserver {
    <#
    .SYNOPSIS
        Delete NTP configuration. config Object.
    .DESCRIPTION
        Configuration for NTP server resource.
    .PARAMETER Serverip 
        IP address of the NTP server. 
    .PARAMETER Servername 
        Fully qualified domain name of the NTP server.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteNtpserver -Serverip <string>
        An example how to delete ntpserver config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteNtpserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Serverip,

        [string]$Servername 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteNtpserver: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Servername') ) { $arguments.Add('servername', $Servername) }
            if ( $PSCmdlet.ShouldProcess("$serverip", "Delete NTP configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type ntpserver -NitroPath nitro/v1/config -Resource $serverip -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteNtpserver: Finished"
    }
}

function Invoke-NSUpdateNtpserver {
    <#
    .SYNOPSIS
        Update NTP configuration. config Object.
    .DESCRIPTION
        Configuration for NTP server resource.
    .PARAMETER Serverip 
        IP address of the NTP server. 
    .PARAMETER Servername 
        Fully qualified domain name of the NTP server. 
    .PARAMETER Minpoll 
        Minimum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
         
        Maximum value = 17 
    .PARAMETER Maxpoll 
        Maximum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
         
        Maximum value = 17 
    .PARAMETER Preferredntpserver 
        Preferred NTP server. The Citrix ADC chooses this NTP server for time synchronization among a set of correctly operating hosts. 
         
        Possible values = YES, NO 
    .PARAMETER Autokey 
        Use the Autokey protocol for key management for this server, with the cryptographic values (for example, symmetric key, host and public certificate files, and sign key) generated by the ntp-keygen utility. To require authentication for communication with the server, you must set either the value of this parameter or the key parameter. 
    .PARAMETER Key 
        Key to use for encrypting authentication fields. All packets sent to and received from the server must include authentication fields encrypted by using this key. To require authentication for communication with the server, you must set either the value of this parameter or the autokey parameter. 
         
        Maximum value = 65534
    .EXAMPLE
        PS C:\>Invoke-NSUpdateNtpserver 
        An example how to update ntpserver config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateNtpserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpserver/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [string]$Serverip,

        [string]$Servername,

        [double]$Minpoll,

        [double]$Maxpoll,

        [ValidateSet('YES', 'NO')]
        [string]$Preferredntpserver,

        [boolean]$Autokey,

        [double]$Key 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateNtpserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('minpoll') ) { $payload.Add('minpoll', $minpoll) }
            if ( $PSBoundParameters.ContainsKey('maxpoll') ) { $payload.Add('maxpoll', $maxpoll) }
            if ( $PSBoundParameters.ContainsKey('preferredntpserver') ) { $payload.Add('preferredntpserver', $preferredntpserver) }
            if ( $PSBoundParameters.ContainsKey('autokey') ) { $payload.Add('autokey', $autokey) }
            if ( $PSBoundParameters.ContainsKey('key') ) { $payload.Add('key', $key) }
            if ( $PSCmdlet.ShouldProcess("ntpserver", "Update NTP configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type ntpserver -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateNtpserver: Finished"
    }
}

function Invoke-NSUnsetNtpserver {
    <#
    .SYNOPSIS
        Unset NTP configuration. config Object.
    .DESCRIPTION
        Configuration for NTP server resource.
    .PARAMETER Serverip 
        IP address of the NTP server. 
    .PARAMETER Servername 
        Fully qualified domain name of the NTP server. 
    .PARAMETER Autokey 
        Use the Autokey protocol for key management for this server, with the cryptographic values (for example, symmetric key, host and public certificate files, and sign key) generated by the ntp-keygen utility. To require authentication for communication with the server, you must set either the value of this parameter or the key parameter. 
    .PARAMETER Minpoll 
        Minimum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
         
        Maximum value = 17 
    .PARAMETER Maxpoll 
        Maximum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
         
        Maximum value = 17 
    .PARAMETER Preferredntpserver 
        Preferred NTP server. The Citrix ADC chooses this NTP server for time synchronization among a set of correctly operating hosts. 
         
        Possible values = YES, NO 
    .PARAMETER Key 
        Key to use for encrypting authentication fields. All packets sent to and received from the server must include authentication fields encrypted by using this key. To require authentication for communication with the server, you must set either the value of this parameter or the autokey parameter. 
         
        Maximum value = 65534
    .EXAMPLE
        PS C:\>Invoke-NSUnsetNtpserver 
        An example how to unset ntpserver config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetNtpserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpserver
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$serverip,

        [Boolean]$servername,

        [Boolean]$autokey,

        [Boolean]$minpoll,

        [Boolean]$maxpoll,

        [Boolean]$preferredntpserver,

        [Boolean]$key 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetNtpserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('autokey') ) { $payload.Add('autokey', $autokey) }
            if ( $PSBoundParameters.ContainsKey('minpoll') ) { $payload.Add('minpoll', $minpoll) }
            if ( $PSBoundParameters.ContainsKey('maxpoll') ) { $payload.Add('maxpoll', $maxpoll) }
            if ( $PSBoundParameters.ContainsKey('preferredntpserver') ) { $payload.Add('preferredntpserver', $preferredntpserver) }
            if ( $PSBoundParameters.ContainsKey('key') ) { $payload.Add('key', $key) }
            if ( $PSCmdlet.ShouldProcess("ntpserver", "Unset NTP configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type ntpserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetNtpserver: Finished"
    }
}

function Invoke-NSGetNtpserver {
    <#
    .SYNOPSIS
        Get NTP configuration. config object(s).
    .DESCRIPTION
        Configuration for NTP server resource.
    .PARAMETER GetAll 
        Retrieve all ntpserver object(s).
    .PARAMETER Count
        If specified, the count of the ntpserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetNtpserver -GetAll 
        Get all ntpserver data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetNtpserver -Count 
        Get the number of ntpserver objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpserver -name <string>
        Get ntpserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpserver -Filter @{ 'name'='<value>' }
        Get ntpserver data with a filter.
    .NOTES
        File Name : Invoke-NSGetNtpserver
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpserver/
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
        Write-Verbose "Invoke-NSGetNtpserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ntpserver objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpserver objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpserver configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpserver configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetNtpserver: Ended"
    }
}

function Invoke-NSGetNtpstatus {
    <#
    .SYNOPSIS
        Get NTP configuration. config object(s).
    .DESCRIPTION
        Configuration for ntp status resource.
    .PARAMETER GetAll 
        Retrieve all ntpstatus object(s).
    .PARAMETER Count
        If specified, the count of the ntpstatus object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpstatus
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetNtpstatus -GetAll 
        Get all ntpstatus data.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpstatus -name <string>
        Get ntpstatus object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpstatus -Filter @{ 'name'='<value>' }
        Get ntpstatus data with a filter.
    .NOTES
        File Name : Invoke-NSGetNtpstatus
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpstatus/
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
        Write-Verbose "Invoke-NSGetNtpstatus: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ntpstatus objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpstatus objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpstatus objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpstatus configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpstatus configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetNtpstatus: Ended"
    }
}

function Invoke-NSEnableNtpsync {
    <#
    .SYNOPSIS
        Enable NTP configuration. config Object.
    .DESCRIPTION
        Configuration for NTP sync resource.
    .EXAMPLE
        PS C:\>Invoke-NSEnableNtpsync 
        An example how to enable ntpsync config Object(s).
    .NOTES
        File Name : Invoke-NSEnableNtpsync
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpsync/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSEnableNtpsync: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable NTP configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type ntpsync -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableNtpsync: Finished"
    }
}

function Invoke-NSDisableNtpsync {
    <#
    .SYNOPSIS
        Disable NTP configuration. config Object.
    .DESCRIPTION
        Configuration for NTP sync resource.
    .EXAMPLE
        PS C:\>Invoke-NSDisableNtpsync 
        An example how to disable ntpsync config Object(s).
    .NOTES
        File Name : Invoke-NSDisableNtpsync
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpsync/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
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
        Write-Verbose "Invoke-NSDisableNtpsync: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable NTP configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type ntpsync -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableNtpsync: Finished"
    }
}

function Invoke-NSGetNtpsync {
    <#
    .SYNOPSIS
        Get NTP configuration. config object(s).
    .DESCRIPTION
        Configuration for NTP sync resource.
    .PARAMETER GetAll 
        Retrieve all ntpsync object(s).
    .PARAMETER Count
        If specified, the count of the ntpsync object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpsync
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetNtpsync -GetAll 
        Get all ntpsync data.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpsync -name <string>
        Get ntpsync object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetNtpsync -Filter @{ 'name'='<value>' }
        Get ntpsync data with a filter.
    .NOTES
        File Name : Invoke-NSGetNtpsync
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ntp/ntpsync/
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
        Write-Verbose "Invoke-NSGetNtpsync: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ntpsync objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpsync objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpsync objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpsync configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpsync configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetNtpsync: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBDGvLBnnNwrBwX
# +9fnL0KmIDTrH13E7M4gdSbsT1A9QaCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgarK91mhIZUhRPmEp3pUmvRndK0z5egZWOxnGEo2CkQkwDQYJKoZIhvcNAQEB
# BQAEggEABbGDO17ZmYVQ90nVkV+W/Dxo7I7WFW+ec3v+JPtMYcknFNj4uN+nXter
# N0SpQfO8vvsZ9PS1+A4hNeXkxrM7IU5tE4lcTo8Dv9/dUIjf3ux0MvH9RejpbFTP
# bBOmVSVpxIs5pNEhMNlR2ev1+JWJ7C1wAry67y6Dt9HBkjM175L/GK458QeFNObP
# /9dkwA7EBbvGyFgoZ7Xasa8LI8EcbqyAG2x+1kxL+QXDiqecfveVMRQOtmRCNOHn
# qczpuAvp97kx2Tcihz9dvF2TS0wsakioUWZ7GkLHkCEJvt9xjSYOecAZHvreLf7D
# xk5QEzL5DxfCysEtLmwdsst5lsm1tg==
# SIG # End signature block
