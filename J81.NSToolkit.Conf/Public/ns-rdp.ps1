function Invoke-NSAddRdpclientprofile {
    <#
    .SYNOPSIS
        Add RDP configuration. config Object.
    .DESCRIPTION
        Configuration for RDP clientprofile resource.
    .PARAMETER Name 
        The name of the rdp profile. 
    .PARAMETER Rdpurloverride 
        This setting determines whether the RDP parameters supplied in the vpn url override those specified in the RDP profile. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectclipboard 
        This setting corresponds to the Clipboard check box on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectdrives 
        This setting corresponds to the selections for Drives under More on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectprinters 
        This setting corresponds to the selection in the Printers check box on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectcomports 
        This setting corresponds to the selections for comports under More on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectpnpdevices 
        This setting corresponds to the selections for pnpdevices under More on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Keyboardhook 
        This setting corresponds to the selection in the Keyboard drop-down list on the Local Resources tab under Options in RDC. 
         
        Possible values = OnLocal, OnRemote, InFullScreenMode 
    .PARAMETER Audiocapturemode 
        This setting corresponds to the selections in the Remote audio area on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Videoplaybackmode 
        This setting determines if Remote Desktop Connection (RDC) will use RDP efficient multimedia streaming for video playback. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Multimonitorsupport 
        Enable/Disable Multiple Monitor Support for Remote Desktop Connection (RDC). 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Rdpcookievalidity 
        RDP cookie validity period. RDP cookie validity time is applicable for new connection and also for any re-connection that might happen, mostly due to network disruption or during fail-over. 
         
         
        Maximum value = 86400 
    .PARAMETER Addusernameinrdpfile 
        Add username in rdp file. 
         
        Possible values = YES, NO 
    .PARAMETER Rdpfilename 
        RDP file name to be sent to End User. 
    .PARAMETER Rdphost 
        Fully-qualified domain name (FQDN) of the RDP Listener. 
    .PARAMETER Rdplistener 
        IP address (or) Fully-qualified domain name(FQDN) of the RDP Listener with the port in the format IP:Port (or) FQDN:Port. 
    .PARAMETER Rdpcustomparams 
        Option for RDP custom parameters settings (if any). Custom params needs to be separated by '&amp;'. 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Randomizerdpfilename 
        Will generate unique filename everytime rdp file is downloaded by appending output of time() function in the format &lt;rdpfileName&gt;_&lt;time&gt;.rdp. This tries to avoid the pop-up for replacement of existing rdp file during each rdp connection launch, hence providing better end-user experience. 
         
        Possible values = YES, NO 
    .PARAMETER Rdplinkattribute 
        Citrix Gateway allows the configuration of rdpLinkAttribute parameter which can be used to fetch a list of RDP servers(IP/FQDN) that a user can access, from an Authentication server attribute(Example: LDAP, SAML). Based on the list received, the RDP links will be generated and displayed to the user. 
        Note: The Attribute mentioned in the rdpLinkAttribute should be fetched through corresponding authentication method. 
    .PARAMETER Rdpvalidateclientip 
        This setting determines whether RDC launch is initiated by the valid client IP. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created rdpclientprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddRdpclientprofile -name <string>
        An example how to add rdpclientprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddRdpclientprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpclientprofile/
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

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpurloverride = 'ENABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectclipboard = 'ENABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectdrives = 'DISABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectprinters = 'ENABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectcomports = 'DISABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectpnpdevices = 'DISABLE',

        [ValidateSet('OnLocal', 'OnRemote', 'InFullScreenMode')]
        [string]$Keyboardhook = 'InFullScreenMode',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Audiocapturemode = 'DISABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Videoplaybackmode = 'ENABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Multimonitorsupport = 'ENABLE',

        [double]$Rdpcookievalidity = '60',

        [ValidateSet('YES', 'NO')]
        [string]$Addusernameinrdpfile = 'NO',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpfilename,

        [string]$Rdphost,

        [string]$Rdplistener,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpcustomparams = '0',

        [string]$Psk = '0',

        [ValidateSet('YES', 'NO')]
        [string]$Randomizerdpfilename = 'NO',

        [string]$Rdplinkattribute,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpvalidateclientip = 'DISABLE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddRdpclientprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rdpurloverride') ) { $payload.Add('rdpurloverride', $rdpurloverride) }
            if ( $PSBoundParameters.ContainsKey('redirectclipboard') ) { $payload.Add('redirectclipboard', $redirectclipboard) }
            if ( $PSBoundParameters.ContainsKey('redirectdrives') ) { $payload.Add('redirectdrives', $redirectdrives) }
            if ( $PSBoundParameters.ContainsKey('redirectprinters') ) { $payload.Add('redirectprinters', $redirectprinters) }
            if ( $PSBoundParameters.ContainsKey('redirectcomports') ) { $payload.Add('redirectcomports', $redirectcomports) }
            if ( $PSBoundParameters.ContainsKey('redirectpnpdevices') ) { $payload.Add('redirectpnpdevices', $redirectpnpdevices) }
            if ( $PSBoundParameters.ContainsKey('keyboardhook') ) { $payload.Add('keyboardhook', $keyboardhook) }
            if ( $PSBoundParameters.ContainsKey('audiocapturemode') ) { $payload.Add('audiocapturemode', $audiocapturemode) }
            if ( $PSBoundParameters.ContainsKey('videoplaybackmode') ) { $payload.Add('videoplaybackmode', $videoplaybackmode) }
            if ( $PSBoundParameters.ContainsKey('multimonitorsupport') ) { $payload.Add('multimonitorsupport', $multimonitorsupport) }
            if ( $PSBoundParameters.ContainsKey('rdpcookievalidity') ) { $payload.Add('rdpcookievalidity', $rdpcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('addusernameinrdpfile') ) { $payload.Add('addusernameinrdpfile', $addusernameinrdpfile) }
            if ( $PSBoundParameters.ContainsKey('rdpfilename') ) { $payload.Add('rdpfilename', $rdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdphost') ) { $payload.Add('rdphost', $rdphost) }
            if ( $PSBoundParameters.ContainsKey('rdplistener') ) { $payload.Add('rdplistener', $rdplistener) }
            if ( $PSBoundParameters.ContainsKey('rdpcustomparams') ) { $payload.Add('rdpcustomparams', $rdpcustomparams) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('randomizerdpfilename') ) { $payload.Add('randomizerdpfilename', $randomizerdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdplinkattribute') ) { $payload.Add('rdplinkattribute', $rdplinkattribute) }
            if ( $PSBoundParameters.ContainsKey('rdpvalidateclientip') ) { $payload.Add('rdpvalidateclientip', $rdpvalidateclientip) }
            if ( $PSCmdlet.ShouldProcess("rdpclientprofile", "Add RDP configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type rdpclientprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetRdpclientprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddRdpclientprofile: Finished"
    }
}

function Invoke-NSUpdateRdpclientprofile {
    <#
    .SYNOPSIS
        Update RDP configuration. config Object.
    .DESCRIPTION
        Configuration for RDP clientprofile resource.
    .PARAMETER Name 
        The name of the rdp profile. 
    .PARAMETER Rdpurloverride 
        This setting determines whether the RDP parameters supplied in the vpn url override those specified in the RDP profile. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectclipboard 
        This setting corresponds to the Clipboard check box on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectdrives 
        This setting corresponds to the selections for Drives under More on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectprinters 
        This setting corresponds to the selection in the Printers check box on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectcomports 
        This setting corresponds to the selections for comports under More on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectpnpdevices 
        This setting corresponds to the selections for pnpdevices under More on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Keyboardhook 
        This setting corresponds to the selection in the Keyboard drop-down list on the Local Resources tab under Options in RDC. 
         
        Possible values = OnLocal, OnRemote, InFullScreenMode 
    .PARAMETER Audiocapturemode 
        This setting corresponds to the selections in the Remote audio area on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Videoplaybackmode 
        This setting determines if Remote Desktop Connection (RDC) will use RDP efficient multimedia streaming for video playback. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Multimonitorsupport 
        Enable/Disable Multiple Monitor Support for Remote Desktop Connection (RDC). 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Rdpcookievalidity 
        RDP cookie validity period. RDP cookie validity time is applicable for new connection and also for any re-connection that might happen, mostly due to network disruption or during fail-over. 
         
         
        Maximum value = 86400 
    .PARAMETER Addusernameinrdpfile 
        Add username in rdp file. 
         
        Possible values = YES, NO 
    .PARAMETER Rdpfilename 
        RDP file name to be sent to End User. 
    .PARAMETER Rdphost 
        Fully-qualified domain name (FQDN) of the RDP Listener. 
    .PARAMETER Rdplistener 
        IP address (or) Fully-qualified domain name(FQDN) of the RDP Listener with the port in the format IP:Port (or) FQDN:Port. 
    .PARAMETER Rdpcustomparams 
        Option for RDP custom parameters settings (if any). Custom params needs to be separated by '&amp;'. 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Randomizerdpfilename 
        Will generate unique filename everytime rdp file is downloaded by appending output of time() function in the format &lt;rdpfileName&gt;_&lt;time&gt;.rdp. This tries to avoid the pop-up for replacement of existing rdp file during each rdp connection launch, hence providing better end-user experience. 
         
        Possible values = YES, NO 
    .PARAMETER Rdplinkattribute 
        Citrix Gateway allows the configuration of rdpLinkAttribute parameter which can be used to fetch a list of RDP servers(IP/FQDN) that a user can access, from an Authentication server attribute(Example: LDAP, SAML). Based on the list received, the RDP links will be generated and displayed to the user. 
        Note: The Attribute mentioned in the rdpLinkAttribute should be fetched through corresponding authentication method. 
    .PARAMETER Rdpvalidateclientip 
        This setting determines whether RDC launch is initiated by the valid client IP. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created rdpclientprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateRdpclientprofile -name <string>
        An example how to update rdpclientprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateRdpclientprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpclientprofile/
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

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpurloverride,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectclipboard,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectdrives,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectprinters,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectcomports,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectpnpdevices,

        [ValidateSet('OnLocal', 'OnRemote', 'InFullScreenMode')]
        [string]$Keyboardhook,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Audiocapturemode,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Videoplaybackmode,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Multimonitorsupport,

        [double]$Rdpcookievalidity,

        [ValidateSet('YES', 'NO')]
        [string]$Addusernameinrdpfile,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpfilename,

        [string]$Rdphost,

        [string]$Rdplistener,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpcustomparams,

        [string]$Psk,

        [ValidateSet('YES', 'NO')]
        [string]$Randomizerdpfilename,

        [string]$Rdplinkattribute,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpvalidateclientip,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateRdpclientprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rdpurloverride') ) { $payload.Add('rdpurloverride', $rdpurloverride) }
            if ( $PSBoundParameters.ContainsKey('redirectclipboard') ) { $payload.Add('redirectclipboard', $redirectclipboard) }
            if ( $PSBoundParameters.ContainsKey('redirectdrives') ) { $payload.Add('redirectdrives', $redirectdrives) }
            if ( $PSBoundParameters.ContainsKey('redirectprinters') ) { $payload.Add('redirectprinters', $redirectprinters) }
            if ( $PSBoundParameters.ContainsKey('redirectcomports') ) { $payload.Add('redirectcomports', $redirectcomports) }
            if ( $PSBoundParameters.ContainsKey('redirectpnpdevices') ) { $payload.Add('redirectpnpdevices', $redirectpnpdevices) }
            if ( $PSBoundParameters.ContainsKey('keyboardhook') ) { $payload.Add('keyboardhook', $keyboardhook) }
            if ( $PSBoundParameters.ContainsKey('audiocapturemode') ) { $payload.Add('audiocapturemode', $audiocapturemode) }
            if ( $PSBoundParameters.ContainsKey('videoplaybackmode') ) { $payload.Add('videoplaybackmode', $videoplaybackmode) }
            if ( $PSBoundParameters.ContainsKey('multimonitorsupport') ) { $payload.Add('multimonitorsupport', $multimonitorsupport) }
            if ( $PSBoundParameters.ContainsKey('rdpcookievalidity') ) { $payload.Add('rdpcookievalidity', $rdpcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('addusernameinrdpfile') ) { $payload.Add('addusernameinrdpfile', $addusernameinrdpfile) }
            if ( $PSBoundParameters.ContainsKey('rdpfilename') ) { $payload.Add('rdpfilename', $rdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdphost') ) { $payload.Add('rdphost', $rdphost) }
            if ( $PSBoundParameters.ContainsKey('rdplistener') ) { $payload.Add('rdplistener', $rdplistener) }
            if ( $PSBoundParameters.ContainsKey('rdpcustomparams') ) { $payload.Add('rdpcustomparams', $rdpcustomparams) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('randomizerdpfilename') ) { $payload.Add('randomizerdpfilename', $randomizerdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdplinkattribute') ) { $payload.Add('rdplinkattribute', $rdplinkattribute) }
            if ( $PSBoundParameters.ContainsKey('rdpvalidateclientip') ) { $payload.Add('rdpvalidateclientip', $rdpvalidateclientip) }
            if ( $PSCmdlet.ShouldProcess("rdpclientprofile", "Update RDP configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type rdpclientprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetRdpclientprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateRdpclientprofile: Finished"
    }
}

function Invoke-NSUnsetRdpclientprofile {
    <#
    .SYNOPSIS
        Unset RDP configuration. config Object.
    .DESCRIPTION
        Configuration for RDP clientprofile resource.
    .PARAMETER Name 
        The name of the rdp profile. 
    .PARAMETER Rdpurloverride 
        This setting determines whether the RDP parameters supplied in the vpn url override those specified in the RDP profile. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectclipboard 
        This setting corresponds to the Clipboard check box on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectdrives 
        This setting corresponds to the selections for Drives under More on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectprinters 
        This setting corresponds to the selection in the Printers check box on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectcomports 
        This setting corresponds to the selections for comports under More on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectpnpdevices 
        This setting corresponds to the selections for pnpdevices under More on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Keyboardhook 
        This setting corresponds to the selection in the Keyboard drop-down list on the Local Resources tab under Options in RDC. 
         
        Possible values = OnLocal, OnRemote, InFullScreenMode 
    .PARAMETER Audiocapturemode 
        This setting corresponds to the selections in the Remote audio area on the Local Resources tab under Options in RDC. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Videoplaybackmode 
        This setting determines if Remote Desktop Connection (RDC) will use RDP efficient multimedia streaming for video playback. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Multimonitorsupport 
        Enable/Disable Multiple Monitor Support for Remote Desktop Connection (RDC). 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER Rdpcookievalidity 
        RDP cookie validity period. RDP cookie validity time is applicable for new connection and also for any re-connection that might happen, mostly due to network disruption or during fail-over. 
         
         
        Maximum value = 86400 
    .PARAMETER Addusernameinrdpfile 
        Add username in rdp file. 
         
        Possible values = YES, NO 
    .PARAMETER Rdpfilename 
        RDP file name to be sent to End User. 
    .PARAMETER Rdphost 
        Fully-qualified domain name (FQDN) of the RDP Listener. 
    .PARAMETER Rdplistener 
        IP address (or) Fully-qualified domain name(FQDN) of the RDP Listener with the port in the format IP:Port (or) FQDN:Port. 
    .PARAMETER Rdpcustomparams 
        Option for RDP custom parameters settings (if any). Custom params needs to be separated by '&amp;'. 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Randomizerdpfilename 
        Will generate unique filename everytime rdp file is downloaded by appending output of time() function in the format &lt;rdpfileName&gt;_&lt;time&gt;.rdp. This tries to avoid the pop-up for replacement of existing rdp file during each rdp connection launch, hence providing better end-user experience. 
         
        Possible values = YES, NO 
    .PARAMETER Rdplinkattribute 
        Citrix Gateway allows the configuration of rdpLinkAttribute parameter which can be used to fetch a list of RDP servers(IP/FQDN) that a user can access, from an Authentication server attribute(Example: LDAP, SAML). Based on the list received, the RDP links will be generated and displayed to the user. 
        Note: The Attribute mentioned in the rdpLinkAttribute should be fetched through corresponding authentication method. 
    .PARAMETER Rdpvalidateclientip 
        This setting determines whether RDC launch is initiated by the valid client IP. 
         
        Possible values = ENABLE, DISABLE
    .EXAMPLE
        PS C:\>Invoke-NSUnsetRdpclientprofile -name <string>
        An example how to unset rdpclientprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetRdpclientprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpclientprofile
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

        [Boolean]$rdpurloverride,

        [Boolean]$redirectclipboard,

        [Boolean]$redirectdrives,

        [Boolean]$redirectprinters,

        [Boolean]$redirectcomports,

        [Boolean]$redirectpnpdevices,

        [Boolean]$keyboardhook,

        [Boolean]$audiocapturemode,

        [Boolean]$videoplaybackmode,

        [Boolean]$multimonitorsupport,

        [Boolean]$rdpcookievalidity,

        [Boolean]$addusernameinrdpfile,

        [Boolean]$rdpfilename,

        [Boolean]$rdphost,

        [Boolean]$rdplistener,

        [Boolean]$rdpcustomparams,

        [Boolean]$psk,

        [Boolean]$randomizerdpfilename,

        [Boolean]$rdplinkattribute,

        [Boolean]$rdpvalidateclientip 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetRdpclientprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rdpurloverride') ) { $payload.Add('rdpurloverride', $rdpurloverride) }
            if ( $PSBoundParameters.ContainsKey('redirectclipboard') ) { $payload.Add('redirectclipboard', $redirectclipboard) }
            if ( $PSBoundParameters.ContainsKey('redirectdrives') ) { $payload.Add('redirectdrives', $redirectdrives) }
            if ( $PSBoundParameters.ContainsKey('redirectprinters') ) { $payload.Add('redirectprinters', $redirectprinters) }
            if ( $PSBoundParameters.ContainsKey('redirectcomports') ) { $payload.Add('redirectcomports', $redirectcomports) }
            if ( $PSBoundParameters.ContainsKey('redirectpnpdevices') ) { $payload.Add('redirectpnpdevices', $redirectpnpdevices) }
            if ( $PSBoundParameters.ContainsKey('keyboardhook') ) { $payload.Add('keyboardhook', $keyboardhook) }
            if ( $PSBoundParameters.ContainsKey('audiocapturemode') ) { $payload.Add('audiocapturemode', $audiocapturemode) }
            if ( $PSBoundParameters.ContainsKey('videoplaybackmode') ) { $payload.Add('videoplaybackmode', $videoplaybackmode) }
            if ( $PSBoundParameters.ContainsKey('multimonitorsupport') ) { $payload.Add('multimonitorsupport', $multimonitorsupport) }
            if ( $PSBoundParameters.ContainsKey('rdpcookievalidity') ) { $payload.Add('rdpcookievalidity', $rdpcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('addusernameinrdpfile') ) { $payload.Add('addusernameinrdpfile', $addusernameinrdpfile) }
            if ( $PSBoundParameters.ContainsKey('rdpfilename') ) { $payload.Add('rdpfilename', $rdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdphost') ) { $payload.Add('rdphost', $rdphost) }
            if ( $PSBoundParameters.ContainsKey('rdplistener') ) { $payload.Add('rdplistener', $rdplistener) }
            if ( $PSBoundParameters.ContainsKey('rdpcustomparams') ) { $payload.Add('rdpcustomparams', $rdpcustomparams) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('randomizerdpfilename') ) { $payload.Add('randomizerdpfilename', $randomizerdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdplinkattribute') ) { $payload.Add('rdplinkattribute', $rdplinkattribute) }
            if ( $PSBoundParameters.ContainsKey('rdpvalidateclientip') ) { $payload.Add('rdpvalidateclientip', $rdpvalidateclientip) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset RDP configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type rdpclientprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetRdpclientprofile: Finished"
    }
}

function Invoke-NSDeleteRdpclientprofile {
    <#
    .SYNOPSIS
        Delete RDP configuration. config Object.
    .DESCRIPTION
        Configuration for RDP clientprofile resource.
    .PARAMETER Name 
        The name of the rdp profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteRdpclientprofile -Name <string>
        An example how to delete rdpclientprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteRdpclientprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpclientprofile/
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
        Write-Verbose "Invoke-NSDeleteRdpclientprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete RDP configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type rdpclientprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteRdpclientprofile: Finished"
    }
}

function Invoke-NSGetRdpclientprofile {
    <#
    .SYNOPSIS
        Get RDP configuration. config object(s).
    .DESCRIPTION
        Configuration for RDP clientprofile resource.
    .PARAMETER Name 
        The name of the rdp profile. 
    .PARAMETER GetAll 
        Retrieve all rdpclientprofile object(s).
    .PARAMETER Count
        If specified, the count of the rdpclientprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetRdpclientprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetRdpclientprofile -GetAll 
        Get all rdpclientprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetRdpclientprofile -Count 
        Get the number of rdpclientprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetRdpclientprofile -name <string>
        Get rdpclientprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetRdpclientprofile -Filter @{ 'name'='<value>' }
        Get rdpclientprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetRdpclientprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpclientprofile/
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
        Write-Verbose "Invoke-NSGetRdpclientprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rdpclientprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rdpclientprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rdpclientprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rdpclientprofile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rdpclientprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetRdpclientprofile: Ended"
    }
}

function Invoke-NSKillRdpconnections {
    <#
    .SYNOPSIS
        Kill RDP configuration. config Object.
    .DESCRIPTION
        Configuration for active rdp connections resource.
    .PARAMETER Username 
        User name for which to display connections. 
    .PARAMETER All 
        Terminate all active rdpconnections.
    .EXAMPLE
        PS C:\>Invoke-NSKillRdpconnections 
        An example how to kill rdpconnections config Object(s).
    .NOTES
        File Name : Invoke-NSKillRdpconnections
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpconnections/
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
        [string]$Username,

        [boolean]$All 

    )
    begin {
        Write-Verbose "Invoke-NSKillRdpconnections: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('all') ) { $payload.Add('all', $all) }
            if ( $PSCmdlet.ShouldProcess($Name, "Kill RDP configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type rdpconnections -Action kill -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSKillRdpconnections: Finished"
    }
}

function Invoke-NSGetRdpconnections {
    <#
    .SYNOPSIS
        Get RDP configuration. config object(s).
    .DESCRIPTION
        Configuration for active rdp connections resource.
    .PARAMETER Username 
        User name for which to display connections. 
    .PARAMETER GetAll 
        Retrieve all rdpconnections object(s).
    .PARAMETER Count
        If specified, the count of the rdpconnections object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetRdpconnections
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetRdpconnections -GetAll 
        Get all rdpconnections data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetRdpconnections -Count 
        Get the number of rdpconnections objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetRdpconnections -name <string>
        Get rdpconnections object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetRdpconnections -Filter @{ 'name'='<value>' }
        Get rdpconnections data with a filter.
    .NOTES
        File Name : Invoke-NSGetRdpconnections
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpconnections/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetRdpconnections: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rdpconnections objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rdpconnections objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rdpconnections objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('username') ) { $arguments.Add('username', $username) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rdpconnections configuration for property ''"

            } else {
                Write-Verbose "Retrieving rdpconnections configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetRdpconnections: Ended"
    }
}

function Invoke-NSAddRdpserverprofile {
    <#
    .SYNOPSIS
        Add RDP configuration. config Object.
    .DESCRIPTION
        Configuration for RDP serverprofile resource.
    .PARAMETER Name 
        The name of the rdp server profile. 
    .PARAMETER Rdpip 
        IPv4 or IPv6 address of RDP listener. This terminates client RDP connections. 
    .PARAMETER Rdpport 
        TCP port on which the RDP connection is established. 
         
         
        Maximum value = 65535 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Rdpredirection 
        Enable/Disable RDP redirection support. This needs to be enabled in presence of connection broker or session directory with IP cookie(msts cookie) based redirection support. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created rdpserverprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddRdpserverprofile -name <string> -psk <string>
        An example how to add rdpserverprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddRdpserverprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpserverprofile/
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
        [ValidateLength(1, 32)]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpip,

        [double]$Rdpport = '3389',

        [Parameter(Mandatory)]
        [string]$Psk,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpredirection = 'DISABLE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddRdpserverprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                psk            = $psk
            }
            if ( $PSBoundParameters.ContainsKey('rdpip') ) { $payload.Add('rdpip', $rdpip) }
            if ( $PSBoundParameters.ContainsKey('rdpport') ) { $payload.Add('rdpport', $rdpport) }
            if ( $PSBoundParameters.ContainsKey('rdpredirection') ) { $payload.Add('rdpredirection', $rdpredirection) }
            if ( $PSCmdlet.ShouldProcess("rdpserverprofile", "Add RDP configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type rdpserverprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetRdpserverprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddRdpserverprofile: Finished"
    }
}

function Invoke-NSUpdateRdpserverprofile {
    <#
    .SYNOPSIS
        Update RDP configuration. config Object.
    .DESCRIPTION
        Configuration for RDP serverprofile resource.
    .PARAMETER Name 
        The name of the rdp server profile. 
    .PARAMETER Rdpip 
        IPv4 or IPv6 address of RDP listener. This terminates client RDP connections. 
    .PARAMETER Rdpport 
        TCP port on which the RDP connection is established. 
         
         
        Maximum value = 65535 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Rdpredirection 
        Enable/Disable RDP redirection support. This needs to be enabled in presence of connection broker or session directory with IP cookie(msts cookie) based redirection support. 
         
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created rdpserverprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateRdpserverprofile -name <string>
        An example how to update rdpserverprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateRdpserverprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpserverprofile/
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
        [ValidateLength(1, 32)]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpip,

        [double]$Rdpport,

        [string]$Psk,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpredirection,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateRdpserverprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rdpip') ) { $payload.Add('rdpip', $rdpip) }
            if ( $PSBoundParameters.ContainsKey('rdpport') ) { $payload.Add('rdpport', $rdpport) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('rdpredirection') ) { $payload.Add('rdpredirection', $rdpredirection) }
            if ( $PSCmdlet.ShouldProcess("rdpserverprofile", "Update RDP configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type rdpserverprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetRdpserverprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateRdpserverprofile: Finished"
    }
}

function Invoke-NSUnsetRdpserverprofile {
    <#
    .SYNOPSIS
        Unset RDP configuration. config Object.
    .DESCRIPTION
        Configuration for RDP serverprofile resource.
    .PARAMETER Name 
        The name of the rdp server profile. 
    .PARAMETER Rdpip 
        IPv4 or IPv6 address of RDP listener. This terminates client RDP connections. 
    .PARAMETER Rdpport 
        TCP port on which the RDP connection is established. 
         
         
        Maximum value = 65535 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Rdpredirection 
        Enable/Disable RDP redirection support. This needs to be enabled in presence of connection broker or session directory with IP cookie(msts cookie) based redirection support. 
         
        Possible values = ENABLE, DISABLE
    .EXAMPLE
        PS C:\>Invoke-NSUnsetRdpserverprofile -name <string>
        An example how to unset rdpserverprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetRdpserverprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpserverprofile
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

        [ValidateLength(1, 32)]
        [string]$Name,

        [Boolean]$rdpip,

        [Boolean]$rdpport,

        [Boolean]$psk,

        [Boolean]$rdpredirection 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetRdpserverprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rdpip') ) { $payload.Add('rdpip', $rdpip) }
            if ( $PSBoundParameters.ContainsKey('rdpport') ) { $payload.Add('rdpport', $rdpport) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('rdpredirection') ) { $payload.Add('rdpredirection', $rdpredirection) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset RDP configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type rdpserverprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetRdpserverprofile: Finished"
    }
}

function Invoke-NSDeleteRdpserverprofile {
    <#
    .SYNOPSIS
        Delete RDP configuration. config Object.
    .DESCRIPTION
        Configuration for RDP serverprofile resource.
    .PARAMETER Name 
        The name of the rdp server profile.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteRdpserverprofile -Name <string>
        An example how to delete rdpserverprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteRdpserverprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpserverprofile/
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
        Write-Verbose "Invoke-NSDeleteRdpserverprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete RDP configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type rdpserverprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteRdpserverprofile: Finished"
    }
}

function Invoke-NSGetRdpserverprofile {
    <#
    .SYNOPSIS
        Get RDP configuration. config object(s).
    .DESCRIPTION
        Configuration for RDP serverprofile resource.
    .PARAMETER Name 
        The name of the rdp server profile. 
    .PARAMETER GetAll 
        Retrieve all rdpserverprofile object(s).
    .PARAMETER Count
        If specified, the count of the rdpserverprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetRdpserverprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetRdpserverprofile -GetAll 
        Get all rdpserverprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetRdpserverprofile -Count 
        Get the number of rdpserverprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetRdpserverprofile -name <string>
        Get rdpserverprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetRdpserverprofile -Filter @{ 'name'='<value>' }
        Get rdpserverprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetRdpserverprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/rdp/rdpserverprofile/
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
        [ValidateLength(1, 32)]
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
        Write-Verbose "Invoke-NSGetRdpserverprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rdpserverprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rdpserverprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rdpserverprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rdpserverprofile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rdpserverprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetRdpserverprofile: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAOjH0z6mR1+ZM9
# FCFak4FeOqiXOxqhr+YQ5ueUMo6jW6CCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgO2HeAPHiMq0ImAZm0JqRlC76R1583STU87w+Apz73dYwDQYJKoZIhvcNAQEB
# BQAEggEAgAxxVF+izUn0DvMbWbu0FqX1NRuLscieiHP0sjaDYecCQsOJtaqsLj0f
# RjMlyYTcQ9ucnPvw4zIQ+HYUb9oZnKiUZRfkFMhyZ9nZZ017hLQrbak54FEppMGP
# nFLorgWcv/6leG+dUZG3UPTPT93H4GQf2dkRmAHfRach8Z2G5qpa3J9Biu351DOx
# 8qhmGY8nxZEaKzq/In/vxMxKuNUruVfz4pUrHLO/UB/Trw68FdEnrlvtTFF9c9mc
# eedN9/9raXi3Kkm/rQumWP0hJNTqwkajdoULIVsil9k6lSP/E5dG8rzpZyLTJhg4
# 3EkcsWo9RX3NKP0xZXfEeNnEGQJtWw==
# SIG # End signature block
