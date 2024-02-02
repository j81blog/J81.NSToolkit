function Invoke-NSUpdateSubscribergxinterface {
    <#
    .SYNOPSIS
        Update Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for Gx interface Parameters resource.
    .PARAMETER Vserver 
        Name of the load balancing, or content switching vserver to which the Gx connections are established. The service type of the virtual server must be DIAMETER/SSL_DIAMETER. Mutually exclusive with the service parameter. Therefore, you cannot set both service and the Virtual Server in the Gx Interface. 
    .PARAMETER Service 
        Name of DIAMETER/SSL_DIAMETER service corresponding to PCRF to which the Gx connection is established. The service type of the service must be DIAMETER/SSL_DIAMETER. Mutually exclusive with vserver parameter. Therefore, you cannot set both Service and the Virtual Server in the Gx Interface. 
    .PARAMETER Pcrfrealm 
        PCRF realm is of type DiameterIdentity and contains the realm of PCRF to which the message is to be routed. This is the realm used in Destination-Realm AVP by Citrix ADC Gx client (as a Diameter node). 
    .PARAMETER Holdonsubscriberabsence 
        Set this setting to yes if Citrix ADC needs to Hold pakcets till subscriber session is fetched from PCRF. Else set to NO. By default set to yes. If this setting is set to NO, then till Citrix ADC fetches subscriber from PCRF, default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes. . 
         
        Possible values = YES, NO 
    .PARAMETER Requesttimeout 
        q!Time, in seconds, within which the Gx CCR request must complete. If the request does not complete within this time, the request is retransmitted for requestRetryAttempts time. If still reuqest is not complete then default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes. 
        Zero disables the timeout. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Requestretryattempts 
        If the request does not complete within requestTimeout time, the request is retransmitted for requestRetryAttempts time. 
    .PARAMETER Idlettl 
        q!Idle Time, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer. 
        Zero value disables the idle timeout. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Revalidationtimeout 
        q!Revalidation Timeout, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer. 
        Zero value disables the idle timeout. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Healthcheck 
        q!Set this setting to yes if Citrix ADC should send DWR packets to PCRF server. When the session is idle, healthcheck timer expires and DWR packets are initiated in order to check that PCRF server is active. By default set to No. !. 
         
        Possible values = YES, NO 
    .PARAMETER Healthcheckttl 
        q!Healthcheck timeout, in seconds, after which the DWR will be sent in order to ensure the state of the PCRF server. Any CCR, CCA, RAR or RRA message resets the timer. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Cerrequesttimeout 
        q!Healthcheck request timeout, in seconds, after which the Citrix ADC considers that no CCA packet received to the initiated CCR. After this time Citrix ADC should send again CCR to PCRF server. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Negativettl 
        q!Negative TTL, in seconds, after which the Gx CCR-I request will be resent for sessions that have not been resolved by PCRF due to server being down or no response or failed response. Instead of polling the PCRF server constantly, negative-TTL makes Citrix ADC stick to un-resolved session. Meanwhile Citrix ADC installs a negative session to avoid going to PCRF. 
        For Negative Sessions, Netcaler inherits the attributes from default subscriber profile if default subscriber is configured. A default subscriber could be configured as 'add subscriber profile *'. Or these attributes can be inherited from Radius as well if Radius is configued. 
        Zero value disables the Negative Sessions. And Citrix ADC does not install Negative sessions even if subscriber session could not be fetched. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Negativettllimitedsuccess 
        Set this to YES if Citrix ADC should create negative session for Result-Code DIAMETER_LIMITED_SUCCESS (2002) received in CCA-I. If set to NO, regular session is created. 
         
        Possible values = YES, NO 
    .PARAMETER Purgesdbongxfailure 
        Set this setting to YES if needed to purge Subscriber Database in case of Gx failure. By default set to NO. . 
         
        Possible values = YES, NO 
    .PARAMETER Servicepathavp 
        The AVP code in which PCRF sends service path applicable for subscriber. 
    .PARAMETER Servicepathvendorid 
        The vendorid of the AVP in which PCRF sends service path for subscriber.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSubscribergxinterface 
        An example how to update subscribergxinterface config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSubscribergxinterface
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscribergxinterface/
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
        [string]$Vserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Service,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Pcrfrealm,

        [ValidateSet('YES', 'NO')]
        [string]$Holdonsubscriberabsence,

        [double]$Requesttimeout,

        [double]$Requestretryattempts,

        [double]$Idlettl,

        [double]$Revalidationtimeout,

        [ValidateSet('YES', 'NO')]
        [string]$Healthcheck,

        [double]$Healthcheckttl,

        [double]$Cerrequesttimeout,

        [double]$Negativettl,

        [ValidateSet('YES', 'NO')]
        [string]$Negativettllimitedsuccess,

        [ValidateSet('YES', 'NO')]
        [string]$Purgesdbongxfailure,

        [double[]]$Servicepathavp,

        [double]$Servicepathvendorid 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSubscribergxinterface: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('service') ) { $payload.Add('service', $service) }
            if ( $PSBoundParameters.ContainsKey('pcrfrealm') ) { $payload.Add('pcrfrealm', $pcrfrealm) }
            if ( $PSBoundParameters.ContainsKey('holdonsubscriberabsence') ) { $payload.Add('holdonsubscriberabsence', $holdonsubscriberabsence) }
            if ( $PSBoundParameters.ContainsKey('requesttimeout') ) { $payload.Add('requesttimeout', $requesttimeout) }
            if ( $PSBoundParameters.ContainsKey('requestretryattempts') ) { $payload.Add('requestretryattempts', $requestretryattempts) }
            if ( $PSBoundParameters.ContainsKey('idlettl') ) { $payload.Add('idlettl', $idlettl) }
            if ( $PSBoundParameters.ContainsKey('revalidationtimeout') ) { $payload.Add('revalidationtimeout', $revalidationtimeout) }
            if ( $PSBoundParameters.ContainsKey('healthcheck') ) { $payload.Add('healthcheck', $healthcheck) }
            if ( $PSBoundParameters.ContainsKey('healthcheckttl') ) { $payload.Add('healthcheckttl', $healthcheckttl) }
            if ( $PSBoundParameters.ContainsKey('cerrequesttimeout') ) { $payload.Add('cerrequesttimeout', $cerrequesttimeout) }
            if ( $PSBoundParameters.ContainsKey('negativettl') ) { $payload.Add('negativettl', $negativettl) }
            if ( $PSBoundParameters.ContainsKey('negativettllimitedsuccess') ) { $payload.Add('negativettllimitedsuccess', $negativettllimitedsuccess) }
            if ( $PSBoundParameters.ContainsKey('purgesdbongxfailure') ) { $payload.Add('purgesdbongxfailure', $purgesdbongxfailure) }
            if ( $PSBoundParameters.ContainsKey('servicepathavp') ) { $payload.Add('servicepathavp', $servicepathavp) }
            if ( $PSBoundParameters.ContainsKey('servicepathvendorid') ) { $payload.Add('servicepathvendorid', $servicepathvendorid) }
            if ( $PSCmdlet.ShouldProcess("subscribergxinterface", "Update Subscriber configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type subscribergxinterface -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateSubscribergxinterface: Finished"
    }
}

function Invoke-NSUnsetSubscribergxinterface {
    <#
    .SYNOPSIS
        Unset Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for Gx interface Parameters resource.
    .PARAMETER Vserver 
        Name of the load balancing, or content switching vserver to which the Gx connections are established. The service type of the virtual server must be DIAMETER/SSL_DIAMETER. Mutually exclusive with the service parameter. Therefore, you cannot set both service and the Virtual Server in the Gx Interface. 
    .PARAMETER Service 
        Name of DIAMETER/SSL_DIAMETER service corresponding to PCRF to which the Gx connection is established. The service type of the service must be DIAMETER/SSL_DIAMETER. Mutually exclusive with vserver parameter. Therefore, you cannot set both Service and the Virtual Server in the Gx Interface. 
    .PARAMETER Holdonsubscriberabsence 
        Set this setting to yes if Citrix ADC needs to Hold pakcets till subscriber session is fetched from PCRF. Else set to NO. By default set to yes. If this setting is set to NO, then till Citrix ADC fetches subscriber from PCRF, default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes. . 
         
        Possible values = YES, NO 
    .PARAMETER Requesttimeout 
        q!Time, in seconds, within which the Gx CCR request must complete. If the request does not complete within this time, the request is retransmitted for requestRetryAttempts time. If still reuqest is not complete then default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes. 
        Zero disables the timeout. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Requestretryattempts 
        If the request does not complete within requestTimeout time, the request is retransmitted for requestRetryAttempts time. 
    .PARAMETER Idlettl 
        q!Idle Time, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer. 
        Zero value disables the idle timeout. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Revalidationtimeout 
        q!Revalidation Timeout, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer. 
        Zero value disables the idle timeout. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Healthcheck 
        q!Set this setting to yes if Citrix ADC should send DWR packets to PCRF server. When the session is idle, healthcheck timer expires and DWR packets are initiated in order to check that PCRF server is active. By default set to No. !. 
         
        Possible values = YES, NO 
    .PARAMETER Healthcheckttl 
        q!Healthcheck timeout, in seconds, after which the DWR will be sent in order to ensure the state of the PCRF server. Any CCR, CCA, RAR or RRA message resets the timer. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Cerrequesttimeout 
        q!Healthcheck request timeout, in seconds, after which the Citrix ADC considers that no CCA packet received to the initiated CCR. After this time Citrix ADC should send again CCR to PCRF server. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Negativettl 
        q!Negative TTL, in seconds, after which the Gx CCR-I request will be resent for sessions that have not been resolved by PCRF due to server being down or no response or failed response. Instead of polling the PCRF server constantly, negative-TTL makes Citrix ADC stick to un-resolved session. Meanwhile Citrix ADC installs a negative session to avoid going to PCRF. 
        For Negative Sessions, Netcaler inherits the attributes from default subscriber profile if default subscriber is configured. A default subscriber could be configured as 'add subscriber profile *'. Or these attributes can be inherited from Radius as well if Radius is configued. 
        Zero value disables the Negative Sessions. And Citrix ADC does not install Negative sessions even if subscriber session could not be fetched. !. 
         
         
        Maximum value = 86400 
    .PARAMETER Negativettllimitedsuccess 
        Set this to YES if Citrix ADC should create negative session for Result-Code DIAMETER_LIMITED_SUCCESS (2002) received in CCA-I. If set to NO, regular session is created. 
         
        Possible values = YES, NO 
    .PARAMETER Purgesdbongxfailure 
        Set this setting to YES if needed to purge Subscriber Database in case of Gx failure. By default set to NO. . 
         
        Possible values = YES, NO 
    .PARAMETER Servicepathavp 
        The AVP code in which PCRF sends service path applicable for subscriber. 
    .PARAMETER Servicepathvendorid 
        The vendorid of the AVP in which PCRF sends service path for subscriber.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetSubscribergxinterface 
        An example how to unset subscribergxinterface config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetSubscribergxinterface
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscribergxinterface
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

        [Boolean]$vserver,

        [Boolean]$service,

        [Boolean]$holdonsubscriberabsence,

        [Boolean]$requesttimeout,

        [Boolean]$requestretryattempts,

        [Boolean]$idlettl,

        [Boolean]$revalidationtimeout,

        [Boolean]$healthcheck,

        [Boolean]$healthcheckttl,

        [Boolean]$cerrequesttimeout,

        [Boolean]$negativettl,

        [Boolean]$negativettllimitedsuccess,

        [Boolean]$purgesdbongxfailure,

        [Boolean]$servicepathavp,

        [Boolean]$servicepathvendorid 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetSubscribergxinterface: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('service') ) { $payload.Add('service', $service) }
            if ( $PSBoundParameters.ContainsKey('holdonsubscriberabsence') ) { $payload.Add('holdonsubscriberabsence', $holdonsubscriberabsence) }
            if ( $PSBoundParameters.ContainsKey('requesttimeout') ) { $payload.Add('requesttimeout', $requesttimeout) }
            if ( $PSBoundParameters.ContainsKey('requestretryattempts') ) { $payload.Add('requestretryattempts', $requestretryattempts) }
            if ( $PSBoundParameters.ContainsKey('idlettl') ) { $payload.Add('idlettl', $idlettl) }
            if ( $PSBoundParameters.ContainsKey('revalidationtimeout') ) { $payload.Add('revalidationtimeout', $revalidationtimeout) }
            if ( $PSBoundParameters.ContainsKey('healthcheck') ) { $payload.Add('healthcheck', $healthcheck) }
            if ( $PSBoundParameters.ContainsKey('healthcheckttl') ) { $payload.Add('healthcheckttl', $healthcheckttl) }
            if ( $PSBoundParameters.ContainsKey('cerrequesttimeout') ) { $payload.Add('cerrequesttimeout', $cerrequesttimeout) }
            if ( $PSBoundParameters.ContainsKey('negativettl') ) { $payload.Add('negativettl', $negativettl) }
            if ( $PSBoundParameters.ContainsKey('negativettllimitedsuccess') ) { $payload.Add('negativettllimitedsuccess', $negativettllimitedsuccess) }
            if ( $PSBoundParameters.ContainsKey('purgesdbongxfailure') ) { $payload.Add('purgesdbongxfailure', $purgesdbongxfailure) }
            if ( $PSBoundParameters.ContainsKey('servicepathavp') ) { $payload.Add('servicepathavp', $servicepathavp) }
            if ( $PSBoundParameters.ContainsKey('servicepathvendorid') ) { $payload.Add('servicepathvendorid', $servicepathvendorid) }
            if ( $PSCmdlet.ShouldProcess("subscribergxinterface", "Unset Subscriber configuration config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type subscribergxinterface -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetSubscribergxinterface: Finished"
    }
}

function Invoke-NSGetSubscribergxinterface {
    <#
    .SYNOPSIS
        Get Subscriber configuration config object(s).
    .DESCRIPTION
        Configuration for Gx interface Parameters resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all subscribergxinterface object(s).
    .PARAMETER Count
        If specified, the count of the subscribergxinterface object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscribergxinterface
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSubscribergxinterface -GetAll 
        Get all subscribergxinterface data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscribergxinterface -name <string>
        Get subscribergxinterface object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscribergxinterface -Filter @{ 'name'='<value>' }
        Get subscribergxinterface data with a filter.
    .NOTES
        File Name : Invoke-NSGetSubscribergxinterface
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscribergxinterface/
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
        [double]$Nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSubscribergxinterface: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all subscribergxinterface objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscribergxinterface objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscribergxinterface objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscribergxinterface configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscribergxinterface configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSubscribergxinterface: Ended"
    }
}

function Invoke-NSUpdateSubscriberparam {
    <#
    .SYNOPSIS
        Update Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for Subscriber Params resource.
    .PARAMETER Keytype 
        Type of subscriber key type IP or IPANDVLAN. IPANDVLAN option can be used only when the interfaceType is set to gxOnly. 
        Changing the lookup method should result to the subscriber session database being flushed. 
         
         
        Possible values = IP, IPANDVLAN 
    .PARAMETER Interfacetype 
        Subscriber Interface refers to Citrix ADC interaction with control plane protocols, RADIUS and GX. 
        Types of subscriber interface: NONE, RadiusOnly, RadiusAndGx, GxOnly. 
        NONE: Only static subscribers can be configured. 
        RadiusOnly: GX interface is absent. Subscriber information is obtained through RADIUS Accounting messages. 
        RadiusAndGx: Subscriber ID obtained through RADIUS Accounting is used to query PCRF. Subscriber information is obtained from both RADIUS and PCRF. 
        GxOnly: RADIUS interface is absent. Subscriber information is queried using Subscriber IP or IP+VLAN. 
         
         
        Possible values = None, RadiusOnly, RadiusAndGx, GxOnly 
    .PARAMETER Idlettl 
        q!Idle Timeout, in seconds, after which Citrix ADC will take an idleAction on a subscriber session (refer to 'idleAction' arguement in 'set subscriber param' for more details on idleAction). Any data-plane or control plane activity updates the idleTimeout on subscriber session. idleAction could be to 'just delete the session' or 'delete and CCR-T' (if PCRF is configured) or 'do not delete but send a CCR-U'. 
        Zero value disables the idle timeout. !. 
         
         
        Maximum value = 172800 
    .PARAMETER Idleaction 
        q!Once idleTTL exprires on a subscriber session, Citrix ADC will take an idle action on that session. idleAction could be chosen from one of these ==&gt; 
        1. ccrTerminate: (default) send CCR-T to inform PCRF about session termination and delete the session. 
        2. delete: Just delete the subscriber session without informing PCRF. 
        3. ccrUpdate: Do not delete the session and instead send a CCR-U to PCRF requesting for an updated session. !. 
         
        Possible values = ccrTerminate, delete, ccrUpdate 
    .PARAMETER Ipv6prefixlookuplist 
        The ipv6PrefixLookupList should consist of all the ipv6 prefix lengths assigned to the UE's'. 
         
        Maximum value = 128
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSubscriberparam 
        An example how to update subscriberparam config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSubscriberparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberparam/
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

        [ValidateSet('IP', 'IPANDVLAN')]
        [string]$Keytype,

        [ValidateSet('None', 'RadiusOnly', 'RadiusAndGx', 'GxOnly')]
        [string]$Interfacetype,

        [double]$Idlettl,

        [ValidateSet('ccrTerminate', 'delete', 'ccrUpdate')]
        [string]$Idleaction,

        [double[]]$Ipv6prefixlookuplist 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSubscriberparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('keytype') ) { $payload.Add('keytype', $keytype) }
            if ( $PSBoundParameters.ContainsKey('interfacetype') ) { $payload.Add('interfacetype', $interfacetype) }
            if ( $PSBoundParameters.ContainsKey('idlettl') ) { $payload.Add('idlettl', $idlettl) }
            if ( $PSBoundParameters.ContainsKey('idleaction') ) { $payload.Add('idleaction', $idleaction) }
            if ( $PSBoundParameters.ContainsKey('ipv6prefixlookuplist') ) { $payload.Add('ipv6prefixlookuplist', $ipv6prefixlookuplist) }
            if ( $PSCmdlet.ShouldProcess("subscriberparam", "Update Subscriber configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type subscriberparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateSubscriberparam: Finished"
    }
}

function Invoke-NSUnsetSubscriberparam {
    <#
    .SYNOPSIS
        Unset Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for Subscriber Params resource.
    .PARAMETER Keytype 
        Type of subscriber key type IP or IPANDVLAN. IPANDVLAN option can be used only when the interfaceType is set to gxOnly. 
        Changing the lookup method should result to the subscriber session database being flushed. 
         
         
        Possible values = IP, IPANDVLAN 
    .PARAMETER Interfacetype 
        Subscriber Interface refers to Citrix ADC interaction with control plane protocols, RADIUS and GX. 
        Types of subscriber interface: NONE, RadiusOnly, RadiusAndGx, GxOnly. 
        NONE: Only static subscribers can be configured. 
        RadiusOnly: GX interface is absent. Subscriber information is obtained through RADIUS Accounting messages. 
        RadiusAndGx: Subscriber ID obtained through RADIUS Accounting is used to query PCRF. Subscriber information is obtained from both RADIUS and PCRF. 
        GxOnly: RADIUS interface is absent. Subscriber information is queried using Subscriber IP or IP+VLAN. 
         
         
        Possible values = None, RadiusOnly, RadiusAndGx, GxOnly 
    .PARAMETER Idlettl 
        q!Idle Timeout, in seconds, after which Citrix ADC will take an idleAction on a subscriber session (refer to 'idleAction' arguement in 'set subscriber param' for more details on idleAction). Any data-plane or control plane activity updates the idleTimeout on subscriber session. idleAction could be to 'just delete the session' or 'delete and CCR-T' (if PCRF is configured) or 'do not delete but send a CCR-U'. 
        Zero value disables the idle timeout. !. 
         
         
        Maximum value = 172800 
    .PARAMETER Idleaction 
        q!Once idleTTL exprires on a subscriber session, Citrix ADC will take an idle action on that session. idleAction could be chosen from one of these ==&gt; 
        1. ccrTerminate: (default) send CCR-T to inform PCRF about session termination and delete the session. 
        2. delete: Just delete the subscriber session without informing PCRF. 
        3. ccrUpdate: Do not delete the session and instead send a CCR-U to PCRF requesting for an updated session. !. 
         
        Possible values = ccrTerminate, delete, ccrUpdate
    .EXAMPLE
        PS C:\>Invoke-NSUnsetSubscriberparam 
        An example how to unset subscriberparam config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetSubscriberparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberparam
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

        [Boolean]$keytype,

        [Boolean]$interfacetype,

        [Boolean]$idlettl,

        [Boolean]$idleaction 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetSubscriberparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('keytype') ) { $payload.Add('keytype', $keytype) }
            if ( $PSBoundParameters.ContainsKey('interfacetype') ) { $payload.Add('interfacetype', $interfacetype) }
            if ( $PSBoundParameters.ContainsKey('idlettl') ) { $payload.Add('idlettl', $idlettl) }
            if ( $PSBoundParameters.ContainsKey('idleaction') ) { $payload.Add('idleaction', $idleaction) }
            if ( $PSCmdlet.ShouldProcess("subscriberparam", "Unset Subscriber configuration config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type subscriberparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetSubscriberparam: Finished"
    }
}

function Invoke-NSGetSubscriberparam {
    <#
    .SYNOPSIS
        Get Subscriber configuration config object(s).
    .DESCRIPTION
        Configuration for Subscriber Params resource.
    .PARAMETER GetAll 
        Retrieve all subscriberparam object(s).
    .PARAMETER Count
        If specified, the count of the subscriberparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscriberparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSubscriberparam -GetAll 
        Get all subscriberparam data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscriberparam -name <string>
        Get subscriberparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscriberparam -Filter @{ 'name'='<value>' }
        Get subscriberparam data with a filter.
    .NOTES
        File Name : Invoke-NSGetSubscriberparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberparam/
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
        Write-Verbose "Invoke-NSGetSubscriberparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all subscriberparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscriberparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscriberparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscriberparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscriberparam configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSubscriberparam: Ended"
    }
}

function Invoke-NSAddSubscriberprofile {
    <#
    .SYNOPSIS
        Add Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for Subscriber Profile resource.
    .PARAMETER Ip 
        Subscriber ip address. 
    .PARAMETER Vlan 
        The vlan number on which the subscriber is located. 
         
         
        Maximum value = 4096 
    .PARAMETER Subscriberrules 
        Rules configured for this subscriber. This is similar to rules received from PCRF for dynamic subscriber sessions. 
    .PARAMETER Subscriptionidtype 
        Subscription-Id type. 
        Possible values = E164, IMSI, SIP_URI, NAI, PRIVATE 
    .PARAMETER Subscriptionidvalue 
        Subscription-Id value. 
    .PARAMETER Servicepath 
        Name of the servicepath to be taken for this subscriber.
    .EXAMPLE
        PS C:\>Invoke-NSAddSubscriberprofile -ip <string>
        An example how to add subscriberprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddSubscriberprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberprofile/
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
        [string]$Ip,

        [double]$Vlan = '0',

        [string[]]$Subscriberrules,

        [ValidateSet('E164', 'IMSI', 'SIP_URI', 'NAI', 'PRIVATE')]
        [string]$Subscriptionidtype,

        [string]$Subscriptionidvalue,

        [string]$Servicepath 
    )
    begin {
        Write-Verbose "Invoke-NSAddSubscriberprofile: Starting"
    }
    process {
        try {
            $payload = @{ ip = $ip }
            if ( $PSBoundParameters.ContainsKey('vlan') ) { $payload.Add('vlan', $vlan) }
            if ( $PSBoundParameters.ContainsKey('subscriberrules') ) { $payload.Add('subscriberrules', $subscriberrules) }
            if ( $PSBoundParameters.ContainsKey('subscriptionidtype') ) { $payload.Add('subscriptionidtype', $subscriptionidtype) }
            if ( $PSBoundParameters.ContainsKey('subscriptionidvalue') ) { $payload.Add('subscriptionidvalue', $subscriptionidvalue) }
            if ( $PSBoundParameters.ContainsKey('servicepath') ) { $payload.Add('servicepath', $servicepath) }
            if ( $PSCmdlet.ShouldProcess("subscriberprofile", "Add Subscriber configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type subscriberprofile -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSAddSubscriberprofile: Finished"
    }
}

function Invoke-NSUpdateSubscriberprofile {
    <#
    .SYNOPSIS
        Update Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for Subscriber Profile resource.
    .PARAMETER Ip 
        Subscriber ip address. 
    .PARAMETER Vlan 
        The vlan number on which the subscriber is located. 
         
         
        Maximum value = 4096 
    .PARAMETER Subscriberrules 
        Rules configured for this subscriber. This is similar to rules received from PCRF for dynamic subscriber sessions. 
    .PARAMETER Subscriptionidtype 
        Subscription-Id type. 
        Possible values = E164, IMSI, SIP_URI, NAI, PRIVATE 
    .PARAMETER Subscriptionidvalue 
        Subscription-Id value. 
    .PARAMETER Servicepath 
        Name of the servicepath to be taken for this subscriber.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSubscriberprofile -ip <string>
        An example how to update subscriberprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSubscriberprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberprofile/
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
        [string]$Ip,

        [double]$Vlan,

        [string[]]$Subscriberrules,

        [ValidateSet('E164', 'IMSI', 'SIP_URI', 'NAI', 'PRIVATE')]
        [string]$Subscriptionidtype,

        [string]$Subscriptionidvalue,

        [string]$Servicepath 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSubscriberprofile: Starting"
    }
    process {
        try {
            $payload = @{ ip = $ip }
            if ( $PSBoundParameters.ContainsKey('vlan') ) { $payload.Add('vlan', $vlan) }
            if ( $PSBoundParameters.ContainsKey('subscriberrules') ) { $payload.Add('subscriberrules', $subscriberrules) }
            if ( $PSBoundParameters.ContainsKey('subscriptionidtype') ) { $payload.Add('subscriptionidtype', $subscriptionidtype) }
            if ( $PSBoundParameters.ContainsKey('subscriptionidvalue') ) { $payload.Add('subscriptionidvalue', $subscriptionidvalue) }
            if ( $PSBoundParameters.ContainsKey('servicepath') ) { $payload.Add('servicepath', $servicepath) }
            if ( $PSCmdlet.ShouldProcess("subscriberprofile", "Update Subscriber configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type subscriberprofile -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateSubscriberprofile: Finished"
    }
}

function Invoke-NSUnsetSubscriberprofile {
    <#
    .SYNOPSIS
        Unset Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for Subscriber Profile resource.
    .PARAMETER Ip 
        Subscriber ip address. 
    .PARAMETER Servicepath 
        Name of the servicepath to be taken for this subscriber.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetSubscriberprofile -ip <string>
        An example how to unset subscriberprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetSubscriberprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberprofile
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

        [string]$Ip,

        [Boolean]$servicepath 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetSubscriberprofile: Starting"
    }
    process {
        try {
            $payload = @{ ip = $ip }
            if ( $PSBoundParameters.ContainsKey('servicepath') ) { $payload.Add('servicepath', $servicepath) }
            if ( $PSCmdlet.ShouldProcess("$ip", "Unset Subscriber configuration config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type subscriberprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetSubscriberprofile: Finished"
    }
}

function Invoke-NSDeleteSubscriberprofile {
    <#
    .SYNOPSIS
        Delete Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for Subscriber Profile resource.
    .PARAMETER Ip 
        Subscriber ip address. 
    .PARAMETER Vlan 
        The vlan number on which the subscriber is located. 
         
         
        Maximum value = 4096
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSubscriberprofile -Ip <string>
        An example how to delete subscriberprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSubscriberprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberprofile/
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
        [string]$Ip,

        [double]$Vlan 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSubscriberprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Vlan') ) { $arguments.Add('vlan', $Vlan) }
            if ( $PSCmdlet.ShouldProcess("$ip", "Delete Subscriber configuration config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type subscriberprofile -NitroPath nitro/v1/config -Resource $ip -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSubscriberprofile: Finished"
    }
}

function Invoke-NSGetSubscriberprofile {
    <#
    .SYNOPSIS
        Get Subscriber configuration config object(s).
    .DESCRIPTION
        Configuration for Subscriber Profile resource.
    .PARAMETER GetAll 
        Retrieve all subscriberprofile object(s).
    .PARAMETER Count
        If specified, the count of the subscriberprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscriberprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSubscriberprofile -GetAll 
        Get all subscriberprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSubscriberprofile -Count 
        Get the number of subscriberprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscriberprofile -name <string>
        Get subscriberprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscriberprofile -Filter @{ 'name'='<value>' }
        Get subscriberprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetSubscriberprofile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberprofile/
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
        Write-Verbose "Invoke-NSGetSubscriberprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all subscriberprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscriberprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscriberprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscriberprofile configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscriberprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSubscriberprofile: Ended"
    }
}

function Invoke-NSUpdateSubscriberradiusinterface {
    <#
    .SYNOPSIS
        Update Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for RADIUS interface Parameters resource.
    .PARAMETER Listeningservice 
        Name of RADIUS LISTENING service that will process RADIUS accounting requests. 
    .PARAMETER Radiusinterimasstart 
        Treat radius interim message as start radius messages. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSubscriberradiusinterface 
        An example how to update subscriberradiusinterface config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSubscriberradiusinterface
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberradiusinterface/
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
        [string]$Listeningservice,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Radiusinterimasstart 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSubscriberradiusinterface: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('listeningservice') ) { $payload.Add('listeningservice', $listeningservice) }
            if ( $PSBoundParameters.ContainsKey('radiusinterimasstart') ) { $payload.Add('radiusinterimasstart', $radiusinterimasstart) }
            if ( $PSCmdlet.ShouldProcess("subscriberradiusinterface", "Update Subscriber configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type subscriberradiusinterface -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateSubscriberradiusinterface: Finished"
    }
}

function Invoke-NSUnsetSubscriberradiusinterface {
    <#
    .SYNOPSIS
        Unset Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for RADIUS interface Parameters resource.
    .PARAMETER Radiusinterimasstart 
        Treat radius interim message as start radius messages. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetSubscriberradiusinterface 
        An example how to unset subscriberradiusinterface config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetSubscriberradiusinterface
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberradiusinterface
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

        [Boolean]$radiusinterimasstart 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetSubscriberradiusinterface: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('radiusinterimasstart') ) { $payload.Add('radiusinterimasstart', $radiusinterimasstart) }
            if ( $PSCmdlet.ShouldProcess("subscriberradiusinterface", "Unset Subscriber configuration config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type subscriberradiusinterface -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetSubscriberradiusinterface: Finished"
    }
}

function Invoke-NSGetSubscriberradiusinterface {
    <#
    .SYNOPSIS
        Get Subscriber configuration config object(s).
    .DESCRIPTION
        Configuration for RADIUS interface Parameters resource.
    .PARAMETER GetAll 
        Retrieve all subscriberradiusinterface object(s).
    .PARAMETER Count
        If specified, the count of the subscriberradiusinterface object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscriberradiusinterface
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSubscriberradiusinterface -GetAll 
        Get all subscriberradiusinterface data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscriberradiusinterface -name <string>
        Get subscriberradiusinterface object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscriberradiusinterface -Filter @{ 'name'='<value>' }
        Get subscriberradiusinterface data with a filter.
    .NOTES
        File Name : Invoke-NSGetSubscriberradiusinterface
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscriberradiusinterface/
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
        Write-Verbose "Invoke-NSGetSubscriberradiusinterface: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all subscriberradiusinterface objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscriberradiusinterface objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscriberradiusinterface objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscriberradiusinterface configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscriberradiusinterface configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSubscriberradiusinterface: Ended"
    }
}

function Invoke-NSClearSubscribersessions {
    <#
    .SYNOPSIS
        Clear Subscriber configuration config Object.
    .DESCRIPTION
        Configuration for subscriber sesions resource.
    .PARAMETER Ip 
        Subscriber IP Address. 
    .PARAMETER Vlan 
        The vlan number on which the subscriber is located. 
         
         
        Maximum value = 4096
    .EXAMPLE
        PS C:\>Invoke-NSClearSubscribersessions 
        An example how to clear subscribersessions config Object(s).
    .NOTES
        File Name : Invoke-NSClearSubscribersessions
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscribersessions/
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

        [string]$Ip,

        [double]$Vlan 

    )
    begin {
        Write-Verbose "Invoke-NSClearSubscribersessions: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('vlan') ) { $payload.Add('vlan', $vlan) }
            if ( $PSCmdlet.ShouldProcess($Name, "Clear Subscriber configuration config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type subscribersessions -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSClearSubscribersessions: Finished"
    }
}

function Invoke-NSGetSubscribersessions {
    <#
    .SYNOPSIS
        Get Subscriber configuration config object(s).
    .DESCRIPTION
        Configuration for subscriber sesions resource.
    .PARAMETER Ip 
        Subscriber IP Address. 
    .PARAMETER Vlan 
        The vlan number on which the subscriber is located. 
         
         
        Maximum value = 4096 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all subscribersessions object(s).
    .PARAMETER Count
        If specified, the count of the subscribersessions object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscribersessions
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSubscribersessions -GetAll 
        Get all subscribersessions data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSubscribersessions -Count 
        Get the number of subscribersessions objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscribersessions -name <string>
        Get subscribersessions object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSubscribersessions -Filter @{ 'name'='<value>' }
        Get subscribersessions data with a filter.
    .NOTES
        File Name : Invoke-NSGetSubscribersessions
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/subscriber/subscribersessions/
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
        [string]$Ip,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double]$Vlan,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double]$Nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetSubscribersessions: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all subscribersessions objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscribersessions objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscribersessions objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('ip') ) { $arguments.Add('ip', $ip) } 
                if ( $PSBoundParameters.ContainsKey('vlan') ) { $arguments.Add('vlan', $vlan) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscribersessions configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscribersessions configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSubscribersessions: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCB6vLpbWM+ScbuD
# e7QenG27ThwGJahHsoLAHAWbPZkquaCCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQg/W7WOY8YWDe24OUWQDOqPjHpUD0Y/kPMyjaUYfm6/vMwDQYJ
# KoZIhvcNAQEBBQAEggEADVf/hQyQ4J/lpwvoedP1zzrpNChRwu3Q0DbMlm66gIEf
# uthdWdAafF/L9Ar4Cy8V2nrwOxc5V9VX2MiLiqGfpJ8kNIMe5W7/oKlxyQFg3YPz
# M1fc9SFhFhg/wtFCmbBGpiIn5KdVR6U8nGwQhIBuUjtUAI94KRDidUosmT3LHvl/
# b1V5jN/CQ94fndINN6Lnng38pGu4DD5GpKetTeZ+SBGYMRHxnxy22ohvp9IOj+Z9
# Fx5UZZpDhAa+8lFHss8BR+f75BmLiz1giKj1d15uNK8sJXj5rHb/7JJUcUPVL303
# 4f9FJY51JixNssxwsgXJ+S0vR6Bk4th5+LQpYHA4p6GCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQzNDZaMD8GCSqG
# SIb3DQEJBDEyBDC9hMugN2Kih+Gj6eBoNixG5Ju+vO6SBIwgj5uxz85V/jWzix30
# WP5YuRPcuWCa4O4wDQYJKoZIhvcNAQEBBQAEggIAGM/SjpxK4A5NcT8C6CPvYjeT
# A1LcB4Eyb0CxXmXePWaHx0ihPnvXBPHs+kRig95X3wzdvHtwLGU84qDGXNi2CtIg
# giCbB7dzhM95Au+6ld52aXIptdn3JgNTGx84hHaLiT2P8h6UsQIH0xdk1NSC743W
# QiR56M8yFhc0tybfR1ZP5gMadVF8OjZz+aMYCCWTFSlDUWu10Lb2cAun6QLCgRGu
# 2SapMdI2ctmHi4ttqRleJYpb0ZDLQuVUUk8z7+fTCouulatX+1Su2TLMcniNTrIR
# sITc7JBgC7lif6VnJUo+ZC+HVgrJjoyUuWQPUO607We8wzXkoG+lL0mXNeCjqiId
# oJZiOzqScWf/WtMuDQmxqwCFogmmtQrG+wLdw8EILgfDaqROGkpwgHA9tVzpH8qA
# DdNHtPdcSQJOpXC3BEMNHxMiWGzDrop4x+/xHKcLpEMU94HrIrg86tsigG+wxKQB
# YeTtThBcsgXvBxYt76Occ1wLZIPWxOH4wEL4E3hlCLhDl9jtGuEWaXbDrfh4G4ix
# izAGx37yxL1/pmvy93oEBLxcou2yYjtCEzQ9YpliWqrbNjOSjyRaG9ztWWuntU3r
# bpiq/G0tw9yDdTfRWezES2njOycCqGBnrew9AdCjmiO4p8K9GkTLALxG2IOIrAy4
# Z4IS3uwB6bCSdmigNe4=
# SIG # End signature block
