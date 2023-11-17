function Invoke-NSUpdateQuicparam {
    <#
    .SYNOPSIS
        Update QUIC configuration. config Object.
    .DESCRIPTION
        Configuration for Citrix ADC QUIC parameters resource.
    .PARAMETER Quicsecrettimeout 
        Rotation frequency, in seconds, for the secret used to generate address validation tokens that will be issued in QUIC Retry packets and QUIC NEW_TOKEN frames sent by the Citrix ADC. A value of 0 can be configured if secret rotation is not desired. 
         
         
        Maximum value = 31536000
    .EXAMPLE
        PS C:\>Invoke-NSUpdateQuicparam 
        An example how to update quicparam config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateQuicparam
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/quic/quicparam/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [double]$Quicsecrettimeout 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateQuicparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('quicsecrettimeout') ) { $payload.Add('quicsecrettimeout', $quicsecrettimeout) }
            if ( $PSCmdlet.ShouldProcess("quicparam", "Update QUIC configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type quicparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateQuicparam: Finished"
    }
}

function Invoke-NSUnsetQuicparam {
    <#
    .SYNOPSIS
        Unset QUIC configuration. config Object.
    .DESCRIPTION
        Configuration for Citrix ADC QUIC parameters resource.
    .PARAMETER Quicsecrettimeout 
        Rotation frequency, in seconds, for the secret used to generate address validation tokens that will be issued in QUIC Retry packets and QUIC NEW_TOKEN frames sent by the Citrix ADC. A value of 0 can be configured if secret rotation is not desired. 
         
         
        Maximum value = 31536000
    .EXAMPLE
        PS C:\>Invoke-NSUnsetQuicparam 
        An example how to unset quicparam config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetQuicparam
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/quic/quicparam
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$NSSession = (Get-NSSession),

        [Boolean]$quicsecrettimeout 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetQuicparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('quicsecrettimeout') ) { $payload.Add('quicsecrettimeout', $quicsecrettimeout) }
            if ( $PSCmdlet.ShouldProcess("quicparam", "Unset QUIC configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type quicparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetQuicparam: Finished"
    }
}

function Invoke-NSGetQuicparam {
    <#
    .SYNOPSIS
        Get QUIC configuration. config object(s).
    .DESCRIPTION
        Configuration for Citrix ADC QUIC parameters resource.
    .PARAMETER GetAll 
        Retrieve all quicparam object(s).
    .PARAMETER Count
        If specified, the count of the quicparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetQuicparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetQuicparam -GetAll 
        Get all quicparam data.
    .EXAMPLE
        PS C:\>Invoke-NSGetQuicparam -name <string>
        Get quicparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetQuicparam -Filter @{ 'name'='<value>' }
        Get quicparam data with a filter.
    .NOTES
        File Name : Invoke-NSGetQuicparam
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/quic/quicparam/
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
        Write-Verbose "Invoke-NSGetQuicparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all quicparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type quicparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for quicparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type quicparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving quicparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type quicparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving quicparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving quicparam configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type quicparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetQuicparam: Ended"
    }
}

function Invoke-NSAddQuicprofile {
    <#
    .SYNOPSIS
        Add QUIC configuration. config Object.
    .DESCRIPTION
        Configuration for QUIC profile resource.
    .PARAMETER Name 
        Name for the QUIC profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER Ackdelayexponent 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, indicating an exponent that the remote QUIC endpoint should use, to decode the ACK Delay field in QUIC ACK frames sent by the Citrix ADC. 
         
         
        Maximum value = 20 
    .PARAMETER Activeconnectionidlimit 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the maximum number of QUIC connection IDs from the remote QUIC endpoint, that the Citrix ADC is willing to store. 
         
         
        Maximum value = 8 
    .PARAMETER Activeconnectionmigration 
        Specify whether the Citrix ADC should allow the remote QUIC endpoint to perform active QUIC connection migration. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Congestionctrlalgorithm 
        Specify the congestion control algorithm to be used for QUIC connections. The default congestion control algorithm is CUBIC. 
         
        Possible values = Default, NewReno, CUBIC, BBR 
    .PARAMETER Initialmaxdata 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial value, in bytes, for the maximum amount of data that can be sent on a QUIC connection. 
         
         
        Maximum value = 67108864 
    .PARAMETER Initialmaxstreamdatabidilocal 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial flow control limit, in bytes, for bidirectional QUIC streams initiated by the Citrix ADC. 
         
         
        Maximum value = 8388608 
    .PARAMETER Initialmaxstreamdatabidiremote 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial flow control limit, in bytes, for bidirectional QUIC streams initiated by the remote QUIC endpoint. 
         
         
        Maximum value = 8388608 
    .PARAMETER Initialmaxstreamdatauni 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial flow control limit, in bytes, for unidirectional streams initiated by the remote QUIC endpoint. 
         
         
        Maximum value = 8388608 
    .PARAMETER Initialmaxstreamsbidi 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial maximum number of bidirectional streams the remote QUIC endpoint may initiate. 
         
         
        Maximum value = 500 
    .PARAMETER Initialmaxstreamsuni 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial maximum number of unidirectional streams the remote QUIC endpoint may initiate. 
         
         
        Maximum value = 500 
    .PARAMETER Maxackdelay 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the maximum amount of time, in milliseconds, by which the Citrix ADC will delay sending acknowledgments. 
         
         
        Maximum value = 2000 
    .PARAMETER Maxidletimeout 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the maximum idle timeout, in seconds, for a QUIC connection. A QUIC connection will be silently discarded by the Citrix ADC if it remains idle for longer than the minimum of the idle timeout values advertised by the Citrix ADC and the remote QUIC endpoint, and three times the current Probe Timeout (PTO). 
         
         
        Maximum value = 3600 
    .PARAMETER Maxudpdatagramsperburst 
        An integer value, specifying the maximum number of UDP datagrams that can be transmitted by the Citrix ADC in a single transmission burst on a QUIC connection. 
         
         
        Maximum value = 256 
    .PARAMETER Maxudppayloadsize 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the size of the largest UDP datagram payload, in bytes, that the Citrix ADC is willing to receive on a QUIC connection. 
         
         
        Maximum value = 9188 
    .PARAMETER Newtokenvalidityperiod 
        An integer value, specifying the validity period, in seconds, of address validation tokens issued through QUIC NEW_TOKEN frames sent by the Citrix ADC. 
         
         
        Maximum value = 3600 
    .PARAMETER Retrytokenvalidityperiod 
        An integer value, specifying the validity period, in seconds, of address validation tokens issued through QUIC Retry packets sent by the Citrix ADC. 
         
         
        Maximum value = 120 
    .PARAMETER Statelessaddressvalidation 
        Specify whether the Citrix ADC should perform stateless address validation for QUIC clients, by sending tokens in QUIC Retry packets during QUIC connection establishment, and by sending tokens in QUIC NEW_TOKEN frames after QUIC connection establishment. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created quicprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddQuicprofile -name <string>
        An example how to add quicprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddQuicprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/quic/quicprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 256)]
        [string]$Name,

        [double]$Ackdelayexponent = '3',

        [double]$Activeconnectionidlimit = '3',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Activeconnectionmigration = 'ENABLED',

        [ValidateSet('Default', 'NewReno', 'CUBIC', 'BBR')]
        [string]$Congestionctrlalgorithm = 'Default',

        [double]$Initialmaxdata = '1048576',

        [double]$Initialmaxstreamdatabidilocal = '262144',

        [double]$Initialmaxstreamdatabidiremote = '262144',

        [double]$Initialmaxstreamdatauni = '262144',

        [double]$Initialmaxstreamsbidi = '100',

        [double]$Initialmaxstreamsuni = '10',

        [double]$Maxackdelay = '20',

        [double]$Maxidletimeout = '180',

        [double]$Maxudpdatagramsperburst = '8',

        [double]$Maxudppayloadsize = '1472',

        [double]$Newtokenvalidityperiod = '300',

        [double]$Retrytokenvalidityperiod = '10',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Statelessaddressvalidation = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddQuicprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ackdelayexponent') ) { $payload.Add('ackdelayexponent', $ackdelayexponent) }
            if ( $PSBoundParameters.ContainsKey('activeconnectionidlimit') ) { $payload.Add('activeconnectionidlimit', $activeconnectionidlimit) }
            if ( $PSBoundParameters.ContainsKey('activeconnectionmigration') ) { $payload.Add('activeconnectionmigration', $activeconnectionmigration) }
            if ( $PSBoundParameters.ContainsKey('congestionctrlalgorithm') ) { $payload.Add('congestionctrlalgorithm', $congestionctrlalgorithm) }
            if ( $PSBoundParameters.ContainsKey('initialmaxdata') ) { $payload.Add('initialmaxdata', $initialmaxdata) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamdatabidilocal') ) { $payload.Add('initialmaxstreamdatabidilocal', $initialmaxstreamdatabidilocal) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamdatabidiremote') ) { $payload.Add('initialmaxstreamdatabidiremote', $initialmaxstreamdatabidiremote) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamdatauni') ) { $payload.Add('initialmaxstreamdatauni', $initialmaxstreamdatauni) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamsbidi') ) { $payload.Add('initialmaxstreamsbidi', $initialmaxstreamsbidi) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamsuni') ) { $payload.Add('initialmaxstreamsuni', $initialmaxstreamsuni) }
            if ( $PSBoundParameters.ContainsKey('maxackdelay') ) { $payload.Add('maxackdelay', $maxackdelay) }
            if ( $PSBoundParameters.ContainsKey('maxidletimeout') ) { $payload.Add('maxidletimeout', $maxidletimeout) }
            if ( $PSBoundParameters.ContainsKey('maxudpdatagramsperburst') ) { $payload.Add('maxudpdatagramsperburst', $maxudpdatagramsperburst) }
            if ( $PSBoundParameters.ContainsKey('maxudppayloadsize') ) { $payload.Add('maxudppayloadsize', $maxudppayloadsize) }
            if ( $PSBoundParameters.ContainsKey('newtokenvalidityperiod') ) { $payload.Add('newtokenvalidityperiod', $newtokenvalidityperiod) }
            if ( $PSBoundParameters.ContainsKey('retrytokenvalidityperiod') ) { $payload.Add('retrytokenvalidityperiod', $retrytokenvalidityperiod) }
            if ( $PSBoundParameters.ContainsKey('statelessaddressvalidation') ) { $payload.Add('statelessaddressvalidation', $statelessaddressvalidation) }
            if ( $PSCmdlet.ShouldProcess("quicprofile", "Add QUIC configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type quicprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetQuicprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddQuicprofile: Finished"
    }
}

function Invoke-NSDeleteQuicprofile {
    <#
    .SYNOPSIS
        Delete QUIC configuration. config Object.
    .DESCRIPTION
        Configuration for QUIC profile resource.
    .PARAMETER Name 
        Name for the QUIC profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals sign (=), and hyphen (-) characters. Cannot be changed after the profile is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteQuicprofile -Name <string>
        An example how to delete quicprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteQuicprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/quic/quicprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        Write-Verbose "Invoke-NSDeleteQuicprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete QUIC configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type quicprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteQuicprofile: Finished"
    }
}

function Invoke-NSUpdateQuicprofile {
    <#
    .SYNOPSIS
        Update QUIC configuration. config Object.
    .DESCRIPTION
        Configuration for QUIC profile resource.
    .PARAMETER Name 
        Name for the QUIC profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER Ackdelayexponent 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, indicating an exponent that the remote QUIC endpoint should use, to decode the ACK Delay field in QUIC ACK frames sent by the Citrix ADC. 
         
         
        Maximum value = 20 
    .PARAMETER Activeconnectionidlimit 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the maximum number of QUIC connection IDs from the remote QUIC endpoint, that the Citrix ADC is willing to store. 
         
         
        Maximum value = 8 
    .PARAMETER Activeconnectionmigration 
        Specify whether the Citrix ADC should allow the remote QUIC endpoint to perform active QUIC connection migration. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Congestionctrlalgorithm 
        Specify the congestion control algorithm to be used for QUIC connections. The default congestion control algorithm is CUBIC. 
         
        Possible values = Default, NewReno, CUBIC, BBR 
    .PARAMETER Initialmaxdata 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial value, in bytes, for the maximum amount of data that can be sent on a QUIC connection. 
         
         
        Maximum value = 67108864 
    .PARAMETER Initialmaxstreamdatabidilocal 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial flow control limit, in bytes, for bidirectional QUIC streams initiated by the Citrix ADC. 
         
         
        Maximum value = 8388608 
    .PARAMETER Initialmaxstreamdatabidiremote 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial flow control limit, in bytes, for bidirectional QUIC streams initiated by the remote QUIC endpoint. 
         
         
        Maximum value = 8388608 
    .PARAMETER Initialmaxstreamdatauni 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial flow control limit, in bytes, for unidirectional streams initiated by the remote QUIC endpoint. 
         
         
        Maximum value = 8388608 
    .PARAMETER Initialmaxstreamsbidi 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial maximum number of bidirectional streams the remote QUIC endpoint may initiate. 
         
         
        Maximum value = 500 
    .PARAMETER Initialmaxstreamsuni 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial maximum number of unidirectional streams the remote QUIC endpoint may initiate. 
         
         
        Maximum value = 500 
    .PARAMETER Maxackdelay 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the maximum amount of time, in milliseconds, by which the Citrix ADC will delay sending acknowledgments. 
         
         
        Maximum value = 2000 
    .PARAMETER Maxidletimeout 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the maximum idle timeout, in seconds, for a QUIC connection. A QUIC connection will be silently discarded by the Citrix ADC if it remains idle for longer than the minimum of the idle timeout values advertised by the Citrix ADC and the remote QUIC endpoint, and three times the current Probe Timeout (PTO). 
         
         
        Maximum value = 3600 
    .PARAMETER Maxudpdatagramsperburst 
        An integer value, specifying the maximum number of UDP datagrams that can be transmitted by the Citrix ADC in a single transmission burst on a QUIC connection. 
         
         
        Maximum value = 256 
    .PARAMETER Maxudppayloadsize 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the size of the largest UDP datagram payload, in bytes, that the Citrix ADC is willing to receive on a QUIC connection. 
         
         
        Maximum value = 9188 
    .PARAMETER Newtokenvalidityperiod 
        An integer value, specifying the validity period, in seconds, of address validation tokens issued through QUIC NEW_TOKEN frames sent by the Citrix ADC. 
         
         
        Maximum value = 3600 
    .PARAMETER Retrytokenvalidityperiod 
        An integer value, specifying the validity period, in seconds, of address validation tokens issued through QUIC Retry packets sent by the Citrix ADC. 
         
         
        Maximum value = 120 
    .PARAMETER Statelessaddressvalidation 
        Specify whether the Citrix ADC should perform stateless address validation for QUIC clients, by sending tokens in QUIC Retry packets during QUIC connection establishment, and by sending tokens in QUIC NEW_TOKEN frames after QUIC connection establishment. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created quicprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateQuicprofile -name <string>
        An example how to update quicprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateQuicprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/quic/quicprofile/
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 256)]
        [string]$Name,

        [double]$Ackdelayexponent,

        [double]$Activeconnectionidlimit,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Activeconnectionmigration,

        [ValidateSet('Default', 'NewReno', 'CUBIC', 'BBR')]
        [string]$Congestionctrlalgorithm,

        [double]$Initialmaxdata,

        [double]$Initialmaxstreamdatabidilocal,

        [double]$Initialmaxstreamdatabidiremote,

        [double]$Initialmaxstreamdatauni,

        [double]$Initialmaxstreamsbidi,

        [double]$Initialmaxstreamsuni,

        [double]$Maxackdelay,

        [double]$Maxidletimeout,

        [double]$Maxudpdatagramsperburst,

        [double]$Maxudppayloadsize,

        [double]$Newtokenvalidityperiod,

        [double]$Retrytokenvalidityperiod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Statelessaddressvalidation,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateQuicprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ackdelayexponent') ) { $payload.Add('ackdelayexponent', $ackdelayexponent) }
            if ( $PSBoundParameters.ContainsKey('activeconnectionidlimit') ) { $payload.Add('activeconnectionidlimit', $activeconnectionidlimit) }
            if ( $PSBoundParameters.ContainsKey('activeconnectionmigration') ) { $payload.Add('activeconnectionmigration', $activeconnectionmigration) }
            if ( $PSBoundParameters.ContainsKey('congestionctrlalgorithm') ) { $payload.Add('congestionctrlalgorithm', $congestionctrlalgorithm) }
            if ( $PSBoundParameters.ContainsKey('initialmaxdata') ) { $payload.Add('initialmaxdata', $initialmaxdata) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamdatabidilocal') ) { $payload.Add('initialmaxstreamdatabidilocal', $initialmaxstreamdatabidilocal) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamdatabidiremote') ) { $payload.Add('initialmaxstreamdatabidiremote', $initialmaxstreamdatabidiremote) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamdatauni') ) { $payload.Add('initialmaxstreamdatauni', $initialmaxstreamdatauni) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamsbidi') ) { $payload.Add('initialmaxstreamsbidi', $initialmaxstreamsbidi) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamsuni') ) { $payload.Add('initialmaxstreamsuni', $initialmaxstreamsuni) }
            if ( $PSBoundParameters.ContainsKey('maxackdelay') ) { $payload.Add('maxackdelay', $maxackdelay) }
            if ( $PSBoundParameters.ContainsKey('maxidletimeout') ) { $payload.Add('maxidletimeout', $maxidletimeout) }
            if ( $PSBoundParameters.ContainsKey('maxudpdatagramsperburst') ) { $payload.Add('maxudpdatagramsperburst', $maxudpdatagramsperburst) }
            if ( $PSBoundParameters.ContainsKey('maxudppayloadsize') ) { $payload.Add('maxudppayloadsize', $maxudppayloadsize) }
            if ( $PSBoundParameters.ContainsKey('newtokenvalidityperiod') ) { $payload.Add('newtokenvalidityperiod', $newtokenvalidityperiod) }
            if ( $PSBoundParameters.ContainsKey('retrytokenvalidityperiod') ) { $payload.Add('retrytokenvalidityperiod', $retrytokenvalidityperiod) }
            if ( $PSBoundParameters.ContainsKey('statelessaddressvalidation') ) { $payload.Add('statelessaddressvalidation', $statelessaddressvalidation) }
            if ( $PSCmdlet.ShouldProcess("quicprofile", "Update QUIC configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type quicprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetQuicprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateQuicprofile: Finished"
    }
}

function Invoke-NSUnsetQuicprofile {
    <#
    .SYNOPSIS
        Unset QUIC configuration. config Object.
    .DESCRIPTION
        Configuration for QUIC profile resource.
    .PARAMETER Name 
        Name for the QUIC profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER Ackdelayexponent 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, indicating an exponent that the remote QUIC endpoint should use, to decode the ACK Delay field in QUIC ACK frames sent by the Citrix ADC. 
         
         
        Maximum value = 20 
    .PARAMETER Activeconnectionidlimit 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the maximum number of QUIC connection IDs from the remote QUIC endpoint, that the Citrix ADC is willing to store. 
         
         
        Maximum value = 8 
    .PARAMETER Activeconnectionmigration 
        Specify whether the Citrix ADC should allow the remote QUIC endpoint to perform active QUIC connection migration. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Congestionctrlalgorithm 
        Specify the congestion control algorithm to be used for QUIC connections. The default congestion control algorithm is CUBIC. 
         
        Possible values = Default, NewReno, CUBIC, BBR 
    .PARAMETER Initialmaxdata 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial value, in bytes, for the maximum amount of data that can be sent on a QUIC connection. 
         
         
        Maximum value = 67108864 
    .PARAMETER Initialmaxstreamdatabidilocal 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial flow control limit, in bytes, for bidirectional QUIC streams initiated by the Citrix ADC. 
         
         
        Maximum value = 8388608 
    .PARAMETER Initialmaxstreamdatabidiremote 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial flow control limit, in bytes, for bidirectional QUIC streams initiated by the remote QUIC endpoint. 
         
         
        Maximum value = 8388608 
    .PARAMETER Initialmaxstreamdatauni 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial flow control limit, in bytes, for unidirectional streams initiated by the remote QUIC endpoint. 
         
         
        Maximum value = 8388608 
    .PARAMETER Initialmaxstreamsbidi 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial maximum number of bidirectional streams the remote QUIC endpoint may initiate. 
         
         
        Maximum value = 500 
    .PARAMETER Initialmaxstreamsuni 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the initial maximum number of unidirectional streams the remote QUIC endpoint may initiate. 
         
         
        Maximum value = 500 
    .PARAMETER Maxackdelay 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the maximum amount of time, in milliseconds, by which the Citrix ADC will delay sending acknowledgments. 
         
         
        Maximum value = 2000 
    .PARAMETER Maxidletimeout 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the maximum idle timeout, in seconds, for a QUIC connection. A QUIC connection will be silently discarded by the Citrix ADC if it remains idle for longer than the minimum of the idle timeout values advertised by the Citrix ADC and the remote QUIC endpoint, and three times the current Probe Timeout (PTO). 
         
         
        Maximum value = 3600 
    .PARAMETER Maxudpdatagramsperburst 
        An integer value, specifying the maximum number of UDP datagrams that can be transmitted by the Citrix ADC in a single transmission burst on a QUIC connection. 
         
         
        Maximum value = 256 
    .PARAMETER Maxudppayloadsize 
        An integer value advertised by the Citrix ADC to the remote QUIC endpoint, specifying the size of the largest UDP datagram payload, in bytes, that the Citrix ADC is willing to receive on a QUIC connection. 
         
         
        Maximum value = 9188 
    .PARAMETER Newtokenvalidityperiod 
        An integer value, specifying the validity period, in seconds, of address validation tokens issued through QUIC NEW_TOKEN frames sent by the Citrix ADC. 
         
         
        Maximum value = 3600 
    .PARAMETER Retrytokenvalidityperiod 
        An integer value, specifying the validity period, in seconds, of address validation tokens issued through QUIC Retry packets sent by the Citrix ADC. 
         
         
        Maximum value = 120 
    .PARAMETER Statelessaddressvalidation 
        Specify whether the Citrix ADC should perform stateless address validation for QUIC clients, by sending tokens in QUIC Retry packets during QUIC connection establishment, and by sending tokens in QUIC NEW_TOKEN frames after QUIC connection establishment. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetQuicprofile -name <string>
        An example how to unset quicprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetQuicprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/quic/quicprofile
        Requires  : PowerShell v5.1 and up
                    NS 13.x and up.
                    NS 12 and lower may work, not guaranteed (best effort).
    .LINK
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
        [ValidateLength(1, 256)]
        [string]$Name,

        [Boolean]$ackdelayexponent,

        [Boolean]$activeconnectionidlimit,

        [Boolean]$activeconnectionmigration,

        [Boolean]$congestionctrlalgorithm,

        [Boolean]$initialmaxdata,

        [Boolean]$initialmaxstreamdatabidilocal,

        [Boolean]$initialmaxstreamdatabidiremote,

        [Boolean]$initialmaxstreamdatauni,

        [Boolean]$initialmaxstreamsbidi,

        [Boolean]$initialmaxstreamsuni,

        [Boolean]$maxackdelay,

        [Boolean]$maxidletimeout,

        [Boolean]$maxudpdatagramsperburst,

        [Boolean]$maxudppayloadsize,

        [Boolean]$newtokenvalidityperiod,

        [Boolean]$retrytokenvalidityperiod,

        [Boolean]$statelessaddressvalidation 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetQuicprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ackdelayexponent') ) { $payload.Add('ackdelayexponent', $ackdelayexponent) }
            if ( $PSBoundParameters.ContainsKey('activeconnectionidlimit') ) { $payload.Add('activeconnectionidlimit', $activeconnectionidlimit) }
            if ( $PSBoundParameters.ContainsKey('activeconnectionmigration') ) { $payload.Add('activeconnectionmigration', $activeconnectionmigration) }
            if ( $PSBoundParameters.ContainsKey('congestionctrlalgorithm') ) { $payload.Add('congestionctrlalgorithm', $congestionctrlalgorithm) }
            if ( $PSBoundParameters.ContainsKey('initialmaxdata') ) { $payload.Add('initialmaxdata', $initialmaxdata) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamdatabidilocal') ) { $payload.Add('initialmaxstreamdatabidilocal', $initialmaxstreamdatabidilocal) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamdatabidiremote') ) { $payload.Add('initialmaxstreamdatabidiremote', $initialmaxstreamdatabidiremote) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamdatauni') ) { $payload.Add('initialmaxstreamdatauni', $initialmaxstreamdatauni) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamsbidi') ) { $payload.Add('initialmaxstreamsbidi', $initialmaxstreamsbidi) }
            if ( $PSBoundParameters.ContainsKey('initialmaxstreamsuni') ) { $payload.Add('initialmaxstreamsuni', $initialmaxstreamsuni) }
            if ( $PSBoundParameters.ContainsKey('maxackdelay') ) { $payload.Add('maxackdelay', $maxackdelay) }
            if ( $PSBoundParameters.ContainsKey('maxidletimeout') ) { $payload.Add('maxidletimeout', $maxidletimeout) }
            if ( $PSBoundParameters.ContainsKey('maxudpdatagramsperburst') ) { $payload.Add('maxudpdatagramsperburst', $maxudpdatagramsperburst) }
            if ( $PSBoundParameters.ContainsKey('maxudppayloadsize') ) { $payload.Add('maxudppayloadsize', $maxudppayloadsize) }
            if ( $PSBoundParameters.ContainsKey('newtokenvalidityperiod') ) { $payload.Add('newtokenvalidityperiod', $newtokenvalidityperiod) }
            if ( $PSBoundParameters.ContainsKey('retrytokenvalidityperiod') ) { $payload.Add('retrytokenvalidityperiod', $retrytokenvalidityperiod) }
            if ( $PSBoundParameters.ContainsKey('statelessaddressvalidation') ) { $payload.Add('statelessaddressvalidation', $statelessaddressvalidation) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset QUIC configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type quicprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetQuicprofile: Finished"
    }
}

function Invoke-NSGetQuicprofile {
    <#
    .SYNOPSIS
        Get QUIC configuration. config object(s).
    .DESCRIPTION
        Configuration for QUIC profile resource.
    .PARAMETER Name 
        Name for the QUIC profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER GetAll 
        Retrieve all quicprofile object(s).
    .PARAMETER Count
        If specified, the count of the quicprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetQuicprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetQuicprofile -GetAll 
        Get all quicprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetQuicprofile -Count 
        Get the number of quicprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetQuicprofile -name <string>
        Get quicprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetQuicprofile -Filter @{ 'name'='<value>' }
        Get quicprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetQuicprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/quic/quicprofile/
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
        [ValidateLength(1, 256)]
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
        Write-Verbose "Invoke-NSGetQuicprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all quicprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type quicprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for quicprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type quicprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving quicprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type quicprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving quicprofile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type quicprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving quicprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type quicprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetQuicprofile: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDaNsu6z2tIIbl7
# pG97u5bOZoBW7+8cjkXMCRx95xie2KCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgQWUqLmpVsyCgvEfiFijzxzcNuL4+JjjSyhesvaYSFo0wDQYJKoZIhvcNAQEB
# BQAEggEAKo5xBfgnaUcLBJVMAwcVieA4DZjAexnxfUO5ljlNJky0JViVvPX9PsvG
# CkNnNjQ+yW53q1zxw6EhtgR5Cfqba3xF4GKgZ/4g/JNTV2mdfGRLznxNS1AV5jm2
# 1i9gcOo1w9wKM2JR4/AGyujryqKh/f7lrY2CPZKvPKWhtJcDupI+t/OQR8UMIUJw
# GNdGhSA53wMAP0V1tcCTC7pi9Co34gK20UgTcOFJ5h55KY0QW43GK/cr7ttFtdqk
# A1UyZlAnaKovCUAvmlkhXslIWYvzR0QimeNjrIQuQVUW3q+eX+r7hBWQlITHhwsr
# qEtgX7XkwCLKV4BN/RmN9gYVhO9vsw==
# SIG # End signature block
