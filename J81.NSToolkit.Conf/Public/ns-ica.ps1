function Invoke-NSAddIcaaccessprofile {
    <#
    .SYNOPSIS
        Add ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ica accessprofile resource.
    .PARAMETER Name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER Connectclientlptports 
        Allow Default access/Disable automatic connection of LPT ports from the client when the user logs on. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientaudioredirection 
        Allow Default access/Disable applications hosted on the server to play sounds through a sound device installed on the client computer, also allows or prevents users to record audio input. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Localremotedatasharing 
        Allow Default access/Disable file/data sharing via the Receiver for HTML5. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientclipboardredirection 
        Allow Default access/Disable the clipboard on the client device to be mapped to the clipboard on the server. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientcomportredirection 
        Allow Default access/Disable COM port redirection to and from the client. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientdriveredirection 
        Allow Default access/Disables drive redirection to and from the client. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientprinterredirection 
        Allow Default access/Disable client printers to be mapped to a server when a user logs on to a session. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Multistream 
        Allow Default access/Disable the multistream feature for the specified users. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientusbdriveredirection 
        Allow Default access/Disable the redirection of USB devices to and from the client. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clienttwaindeviceredirection 
        Allow default access or disable TWAIN devices, such as digital cameras or scanners, on the client device from published image processing applications. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Wiaredirection 
        Allow default access or disable WIA scanner redirection. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Draganddrop 
        Allow default access or disable drag and drop between client and remote applications and desktops. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Smartcardredirection 
        Allow default access or disable smart card redirection. Smart card virtual channel is always allowed in CVAD. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Fido2redirection 
        Allow default access or disable FIDO2 redirection. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER PassThru 
        Return details about the created icaaccessprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddIcaaccessprofile -name <string>
        An example how to add icaaccessprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddIcaaccessprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaccessprofile/
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

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Connectclientlptports = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientaudioredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Localremotedatasharing = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientclipboardredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientcomportredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientdriveredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientprinterredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Multistream = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientusbdriveredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clienttwaindeviceredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Wiaredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Draganddrop = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Smartcardredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Fido2redirection = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddIcaaccessprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('connectclientlptports') ) { $payload.Add('connectclientlptports', $connectclientlptports) }
            if ( $PSBoundParameters.ContainsKey('clientaudioredirection') ) { $payload.Add('clientaudioredirection', $clientaudioredirection) }
            if ( $PSBoundParameters.ContainsKey('localremotedatasharing') ) { $payload.Add('localremotedatasharing', $localremotedatasharing) }
            if ( $PSBoundParameters.ContainsKey('clientclipboardredirection') ) { $payload.Add('clientclipboardredirection', $clientclipboardredirection) }
            if ( $PSBoundParameters.ContainsKey('clientcomportredirection') ) { $payload.Add('clientcomportredirection', $clientcomportredirection) }
            if ( $PSBoundParameters.ContainsKey('clientdriveredirection') ) { $payload.Add('clientdriveredirection', $clientdriveredirection) }
            if ( $PSBoundParameters.ContainsKey('clientprinterredirection') ) { $payload.Add('clientprinterredirection', $clientprinterredirection) }
            if ( $PSBoundParameters.ContainsKey('multistream') ) { $payload.Add('multistream', $multistream) }
            if ( $PSBoundParameters.ContainsKey('clientusbdriveredirection') ) { $payload.Add('clientusbdriveredirection', $clientusbdriveredirection) }
            if ( $PSBoundParameters.ContainsKey('clienttwaindeviceredirection') ) { $payload.Add('clienttwaindeviceredirection', $clienttwaindeviceredirection) }
            if ( $PSBoundParameters.ContainsKey('wiaredirection') ) { $payload.Add('wiaredirection', $wiaredirection) }
            if ( $PSBoundParameters.ContainsKey('draganddrop') ) { $payload.Add('draganddrop', $draganddrop) }
            if ( $PSBoundParameters.ContainsKey('smartcardredirection') ) { $payload.Add('smartcardredirection', $smartcardredirection) }
            if ( $PSBoundParameters.ContainsKey('fido2redirection') ) { $payload.Add('fido2redirection', $fido2redirection) }
            if ( $PSCmdlet.ShouldProcess("icaaccessprofile", "Add ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type icaaccessprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcaaccessprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddIcaaccessprofile: Finished"
    }
}

function Invoke-NSDeleteIcaaccessprofile {
    <#
    .SYNOPSIS
        Delete ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ica accessprofile resource.
    .PARAMETER Name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteIcaaccessprofile -Name <string>
        An example how to delete icaaccessprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteIcaaccessprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaccessprofile/
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
        Write-Verbose "Invoke-NSDeleteIcaaccessprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete ICA configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type icaaccessprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteIcaaccessprofile: Finished"
    }
}

function Invoke-NSUpdateIcaaccessprofile {
    <#
    .SYNOPSIS
        Update ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ica accessprofile resource.
    .PARAMETER Name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER Connectclientlptports 
        Allow Default access/Disable automatic connection of LPT ports from the client when the user logs on. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientaudioredirection 
        Allow Default access/Disable applications hosted on the server to play sounds through a sound device installed on the client computer, also allows or prevents users to record audio input. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Localremotedatasharing 
        Allow Default access/Disable file/data sharing via the Receiver for HTML5. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientclipboardredirection 
        Allow Default access/Disable the clipboard on the client device to be mapped to the clipboard on the server. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientcomportredirection 
        Allow Default access/Disable COM port redirection to and from the client. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientdriveredirection 
        Allow Default access/Disables drive redirection to and from the client. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientprinterredirection 
        Allow Default access/Disable client printers to be mapped to a server when a user logs on to a session. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Multistream 
        Allow Default access/Disable the multistream feature for the specified users. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientusbdriveredirection 
        Allow Default access/Disable the redirection of USB devices to and from the client. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clienttwaindeviceredirection 
        Allow default access or disable TWAIN devices, such as digital cameras or scanners, on the client device from published image processing applications. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Wiaredirection 
        Allow default access or disable WIA scanner redirection. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Draganddrop 
        Allow default access or disable drag and drop between client and remote applications and desktops. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Smartcardredirection 
        Allow default access or disable smart card redirection. Smart card virtual channel is always allowed in CVAD. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Fido2redirection 
        Allow default access or disable FIDO2 redirection. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER PassThru 
        Return details about the created icaaccessprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateIcaaccessprofile -name <string>
        An example how to update icaaccessprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateIcaaccessprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaccessprofile/
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

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Connectclientlptports,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientaudioredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Localremotedatasharing,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientclipboardredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientcomportredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientdriveredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientprinterredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Multistream,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientusbdriveredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clienttwaindeviceredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Wiaredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Draganddrop,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Smartcardredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Fido2redirection,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateIcaaccessprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('connectclientlptports') ) { $payload.Add('connectclientlptports', $connectclientlptports) }
            if ( $PSBoundParameters.ContainsKey('clientaudioredirection') ) { $payload.Add('clientaudioredirection', $clientaudioredirection) }
            if ( $PSBoundParameters.ContainsKey('localremotedatasharing') ) { $payload.Add('localremotedatasharing', $localremotedatasharing) }
            if ( $PSBoundParameters.ContainsKey('clientclipboardredirection') ) { $payload.Add('clientclipboardredirection', $clientclipboardredirection) }
            if ( $PSBoundParameters.ContainsKey('clientcomportredirection') ) { $payload.Add('clientcomportredirection', $clientcomportredirection) }
            if ( $PSBoundParameters.ContainsKey('clientdriveredirection') ) { $payload.Add('clientdriveredirection', $clientdriveredirection) }
            if ( $PSBoundParameters.ContainsKey('clientprinterredirection') ) { $payload.Add('clientprinterredirection', $clientprinterredirection) }
            if ( $PSBoundParameters.ContainsKey('multistream') ) { $payload.Add('multistream', $multistream) }
            if ( $PSBoundParameters.ContainsKey('clientusbdriveredirection') ) { $payload.Add('clientusbdriveredirection', $clientusbdriveredirection) }
            if ( $PSBoundParameters.ContainsKey('clienttwaindeviceredirection') ) { $payload.Add('clienttwaindeviceredirection', $clienttwaindeviceredirection) }
            if ( $PSBoundParameters.ContainsKey('wiaredirection') ) { $payload.Add('wiaredirection', $wiaredirection) }
            if ( $PSBoundParameters.ContainsKey('draganddrop') ) { $payload.Add('draganddrop', $draganddrop) }
            if ( $PSBoundParameters.ContainsKey('smartcardredirection') ) { $payload.Add('smartcardredirection', $smartcardredirection) }
            if ( $PSBoundParameters.ContainsKey('fido2redirection') ) { $payload.Add('fido2redirection', $fido2redirection) }
            if ( $PSCmdlet.ShouldProcess("icaaccessprofile", "Update ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type icaaccessprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcaaccessprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateIcaaccessprofile: Finished"
    }
}

function Invoke-NSUnsetIcaaccessprofile {
    <#
    .SYNOPSIS
        Unset ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ica accessprofile resource.
    .PARAMETER Name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER Connectclientlptports 
        Allow Default access/Disable automatic connection of LPT ports from the client when the user logs on. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientaudioredirection 
        Allow Default access/Disable applications hosted on the server to play sounds through a sound device installed on the client computer, also allows or prevents users to record audio input. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Localremotedatasharing 
        Allow Default access/Disable file/data sharing via the Receiver for HTML5. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientclipboardredirection 
        Allow Default access/Disable the clipboard on the client device to be mapped to the clipboard on the server. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientcomportredirection 
        Allow Default access/Disable COM port redirection to and from the client. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientdriveredirection 
        Allow Default access/Disables drive redirection to and from the client. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientprinterredirection 
        Allow Default access/Disable client printers to be mapped to a server when a user logs on to a session. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Multistream 
        Allow Default access/Disable the multistream feature for the specified users. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientusbdriveredirection 
        Allow Default access/Disable the redirection of USB devices to and from the client. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clienttwaindeviceredirection 
        Allow default access or disable TWAIN devices, such as digital cameras or scanners, on the client device from published image processing applications. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Wiaredirection 
        Allow default access or disable WIA scanner redirection. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Draganddrop 
        Allow default access or disable drag and drop between client and remote applications and desktops. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Smartcardredirection 
        Allow default access or disable smart card redirection. Smart card virtual channel is always allowed in CVAD. 
         
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Fido2redirection 
        Allow default access or disable FIDO2 redirection. 
         
        Possible values = DEFAULT, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetIcaaccessprofile -name <string>
        An example how to unset icaaccessprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetIcaaccessprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaccessprofile
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

        [Boolean]$connectclientlptports,

        [Boolean]$clientaudioredirection,

        [Boolean]$localremotedatasharing,

        [Boolean]$clientclipboardredirection,

        [Boolean]$clientcomportredirection,

        [Boolean]$clientdriveredirection,

        [Boolean]$clientprinterredirection,

        [Boolean]$multistream,

        [Boolean]$clientusbdriveredirection,

        [Boolean]$clienttwaindeviceredirection,

        [Boolean]$wiaredirection,

        [Boolean]$draganddrop,

        [Boolean]$smartcardredirection,

        [Boolean]$fido2redirection 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetIcaaccessprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('connectclientlptports') ) { $payload.Add('connectclientlptports', $connectclientlptports) }
            if ( $PSBoundParameters.ContainsKey('clientaudioredirection') ) { $payload.Add('clientaudioredirection', $clientaudioredirection) }
            if ( $PSBoundParameters.ContainsKey('localremotedatasharing') ) { $payload.Add('localremotedatasharing', $localremotedatasharing) }
            if ( $PSBoundParameters.ContainsKey('clientclipboardredirection') ) { $payload.Add('clientclipboardredirection', $clientclipboardredirection) }
            if ( $PSBoundParameters.ContainsKey('clientcomportredirection') ) { $payload.Add('clientcomportredirection', $clientcomportredirection) }
            if ( $PSBoundParameters.ContainsKey('clientdriveredirection') ) { $payload.Add('clientdriveredirection', $clientdriveredirection) }
            if ( $PSBoundParameters.ContainsKey('clientprinterredirection') ) { $payload.Add('clientprinterredirection', $clientprinterredirection) }
            if ( $PSBoundParameters.ContainsKey('multistream') ) { $payload.Add('multistream', $multistream) }
            if ( $PSBoundParameters.ContainsKey('clientusbdriveredirection') ) { $payload.Add('clientusbdriveredirection', $clientusbdriveredirection) }
            if ( $PSBoundParameters.ContainsKey('clienttwaindeviceredirection') ) { $payload.Add('clienttwaindeviceredirection', $clienttwaindeviceredirection) }
            if ( $PSBoundParameters.ContainsKey('wiaredirection') ) { $payload.Add('wiaredirection', $wiaredirection) }
            if ( $PSBoundParameters.ContainsKey('draganddrop') ) { $payload.Add('draganddrop', $draganddrop) }
            if ( $PSBoundParameters.ContainsKey('smartcardredirection') ) { $payload.Add('smartcardredirection', $smartcardredirection) }
            if ( $PSBoundParameters.ContainsKey('fido2redirection') ) { $payload.Add('fido2redirection', $fido2redirection) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset ICA configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type icaaccessprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetIcaaccessprofile: Finished"
    }
}

function Invoke-NSGetIcaaccessprofile {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Configuration for ica accessprofile resource.
    .PARAMETER Name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER GetAll 
        Retrieve all icaaccessprofile object(s).
    .PARAMETER Count
        If specified, the count of the icaaccessprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaaccessprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcaaccessprofile -GetAll 
        Get all icaaccessprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcaaccessprofile -Count 
        Get the number of icaaccessprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaaccessprofile -name <string>
        Get icaaccessprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaaccessprofile -Filter @{ 'name'='<value>' }
        Get icaaccessprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcaaccessprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaccessprofile/
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
        Write-Verbose "Invoke-NSGetIcaaccessprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all icaaccessprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaaccessprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaaccessprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaaccessprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaaccessprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaaccessprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaaccessprofile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaaccessprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icaaccessprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaaccessprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcaaccessprofile: Ended"
    }
}

function Invoke-NSAddIcaaction {
    <#
    .SYNOPSIS
        Add ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER Accessprofilename 
        Name of the ica accessprofile to be associated with this action. 
    .PARAMETER Latencyprofilename 
        Name of the ica latencyprofile to be associated with this action. 
    .PARAMETER PassThru 
        Return details about the created icaaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddIcaaction -name <string>
        An example how to add icaaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddIcaaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaction/
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

        [string]$Accessprofilename,

        [string]$Latencyprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddIcaaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('accessprofilename') ) { $payload.Add('accessprofilename', $accessprofilename) }
            if ( $PSBoundParameters.ContainsKey('latencyprofilename') ) { $payload.Add('latencyprofilename', $latencyprofilename) }
            if ( $PSCmdlet.ShouldProcess("icaaction", "Add ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type icaaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcaaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddIcaaction: Finished"
    }
}

function Invoke-NSDeleteIcaaction {
    <#
    .SYNOPSIS
        Delete ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteIcaaction -Name <string>
        An example how to delete icaaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteIcaaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaction/
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
        Write-Verbose "Invoke-NSDeleteIcaaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete ICA configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type icaaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteIcaaction: Finished"
    }
}

function Invoke-NSUpdateIcaaction {
    <#
    .SYNOPSIS
        Update ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER Accessprofilename 
        Name of the ica accessprofile to be associated with this action. 
    .PARAMETER Latencyprofilename 
        Name of the ica latencyprofile to be associated with this action. 
    .PARAMETER PassThru 
        Return details about the created icaaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateIcaaction -name <string>
        An example how to update icaaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateIcaaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaction/
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

        [string]$Accessprofilename,

        [string]$Latencyprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateIcaaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('accessprofilename') ) { $payload.Add('accessprofilename', $accessprofilename) }
            if ( $PSBoundParameters.ContainsKey('latencyprofilename') ) { $payload.Add('latencyprofilename', $latencyprofilename) }
            if ( $PSCmdlet.ShouldProcess("icaaction", "Update ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type icaaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcaaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateIcaaction: Finished"
    }
}

function Invoke-NSUnsetIcaaction {
    <#
    .SYNOPSIS
        Unset ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER Accessprofilename 
        Name of the ica accessprofile to be associated with this action. 
    .PARAMETER Latencyprofilename 
        Name of the ica latencyprofile to be associated with this action.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetIcaaction -name <string>
        An example how to unset icaaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetIcaaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaction
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

        [Boolean]$accessprofilename,

        [Boolean]$latencyprofilename 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetIcaaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('accessprofilename') ) { $payload.Add('accessprofilename', $accessprofilename) }
            if ( $PSBoundParameters.ContainsKey('latencyprofilename') ) { $payload.Add('latencyprofilename', $latencyprofilename) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset ICA configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type icaaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetIcaaction: Finished"
    }
}

function Invoke-NSRenameIcaaction {
    <#
    .SYNOPSIS
        Rename ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER Newname 
        New name for the ICA action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#),period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created icaaction item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameIcaaction -name <string> -newname <string>
        An example how to rename icaaction config Object(s).
    .NOTES
        File Name : Invoke-NSRenameIcaaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaction/
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
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameIcaaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("icaaction", "Rename ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type icaaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcaaction -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameIcaaction: Finished"
    }
}

function Invoke-NSGetIcaaction {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER GetAll 
        Retrieve all icaaction object(s).
    .PARAMETER Count
        If specified, the count of the icaaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcaaction -GetAll 
        Get all icaaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcaaction -Count 
        Get the number of icaaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaaction -name <string>
        Get icaaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaaction -Filter @{ 'name'='<value>' }
        Get icaaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcaaction
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaaction/
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
        Write-Verbose "Invoke-NSGetIcaaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all icaaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icaaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcaaction: Ended"
    }
}

function Invoke-NSGetIcaglobalBinding {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to icaglobal.
    .PARAMETER GetAll 
        Retrieve all icaglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the icaglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcaglobalBinding -GetAll 
        Get all icaglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaglobalBinding -name <string>
        Get icaglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaglobalBinding -Filter @{ 'name'='<value>' }
        Get icaglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcaglobalBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaglobal_binding/
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
        Write-Verbose "Invoke-NSGetIcaglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icaglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving icaglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcaglobalBinding: Ended"
    }
}

function Invoke-NSAddIcaglobalIcapolicyBinding {
    <#
    .SYNOPSIS
        Add ICA configuration. config Object.
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to icaglobal.
    .PARAMETER Policyname 
        Name of the ICA policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Global bind point for which to show detailed information about the policies bound to the bind point. 
        Possible values = ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT 
    .PARAMETER PassThru 
        Return details about the created icaglobal_icapolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddIcaglobalIcapolicyBinding -policyname <string> -priority <double>
        An example how to add icaglobal_icapolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddIcaglobalIcapolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaglobal_icapolicy_binding/
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

        [ValidateSet('ICA_REQ_OVERRIDE', 'ICA_REQ_DEFAULT')]
        [string]$Type,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddIcaglobalIcapolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess("icaglobal_icapolicy_binding", "Add ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type icaglobal_icapolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcaglobalIcapolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddIcaglobalIcapolicyBinding: Finished"
    }
}

function Invoke-NSDeleteIcaglobalIcapolicyBinding {
    <#
    .SYNOPSIS
        Delete ICA configuration. config Object.
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to icaglobal.
    .PARAMETER Policyname 
        Name of the ICA policy. 
    .PARAMETER Type 
        Global bind point for which to show detailed information about the policies bound to the bind point. 
        Possible values = ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteIcaglobalIcapolicyBinding 
        An example how to delete icaglobal_icapolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteIcaglobalIcapolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaglobal_icapolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteIcaglobalIcapolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("icaglobal_icapolicy_binding", "Delete ICA configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type icaglobal_icapolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteIcaglobalIcapolicyBinding: Finished"
    }
}

function Invoke-NSGetIcaglobalIcapolicyBinding {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to icaglobal.
    .PARAMETER Type 
        Global bind point for which to show detailed information about the policies bound to the bind point. 
        Possible values = ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT 
    .PARAMETER GetAll 
        Retrieve all icaglobal_icapolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the icaglobal_icapolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaglobalIcapolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcaglobalIcapolicyBinding -GetAll 
        Get all icaglobal_icapolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcaglobalIcapolicyBinding -Count 
        Get the number of icaglobal_icapolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaglobalIcapolicyBinding -name <string>
        Get icaglobal_icapolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaglobalIcapolicyBinding -Filter @{ 'name'='<value>' }
        Get icaglobal_icapolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcaglobalIcapolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaglobal_icapolicy_binding/
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
        [ValidateSet('ICA_REQ_OVERRIDE', 'ICA_REQ_DEFAULT')]
        [string]$Type,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetIcaglobalIcapolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icaglobal_icapolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaglobal_icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaglobal_icapolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaglobal_icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaglobal_icapolicy_binding objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaglobal_icapolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaglobal_icapolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving icaglobal_icapolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaglobal_icapolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcaglobalIcapolicyBinding: Ended"
    }
}

function Invoke-NSAddIcalatencyprofile {
    <#
    .SYNOPSIS
        Add ICA configuration. config Object.
    .DESCRIPTION
        Configuration for Profile for Latency monitoring resource.
    .PARAMETER Name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER L7latencymonitoring 
        Enable/Disable L7 Latency monitoring for L7 latency notifications. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER L7latencythresholdfactor 
        L7 Latency threshold factor. This is the factor by which the active latency should be greater than the minimum observed value to determine that the latency is high and may need to be reported. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencywaittime 
        L7 Latency Wait time. This is the time for which the Citrix ADC waits after the threshold is exceeded before it sends out a Notification to the Insight Center. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencynotifyinterval 
        L7 Latency Notify Interval. This is the interval at which the Citrix ADC sends out notifications to the Insight Center after the wait time has passed. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencymaxnotifycount 
        L7 Latency Max notify Count. This is the upper limit on the number of notifications sent to the Insight Center within an interval where the Latency is above the threshold. 
         
         
        Maximum value = 65535 
    .PARAMETER PassThru 
        Return details about the created icalatencyprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSAddIcalatencyprofile -name <string>
        An example how to add icalatencyprofile config Object(s).
    .NOTES
        File Name : Invoke-NSAddIcalatencyprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icalatencyprofile/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$L7latencymonitoring = 'DISABLED',

        [double]$L7latencythresholdfactor = '4',

        [double]$L7latencywaittime = '20',

        [double]$L7latencynotifyinterval = '20',

        [double]$L7latencymaxnotifycount = '5',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddIcalatencyprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('l7latencymonitoring') ) { $payload.Add('l7latencymonitoring', $l7latencymonitoring) }
            if ( $PSBoundParameters.ContainsKey('l7latencythresholdfactor') ) { $payload.Add('l7latencythresholdfactor', $l7latencythresholdfactor) }
            if ( $PSBoundParameters.ContainsKey('l7latencywaittime') ) { $payload.Add('l7latencywaittime', $l7latencywaittime) }
            if ( $PSBoundParameters.ContainsKey('l7latencynotifyinterval') ) { $payload.Add('l7latencynotifyinterval', $l7latencynotifyinterval) }
            if ( $PSBoundParameters.ContainsKey('l7latencymaxnotifycount') ) { $payload.Add('l7latencymaxnotifycount', $l7latencymaxnotifycount) }
            if ( $PSCmdlet.ShouldProcess("icalatencyprofile", "Add ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type icalatencyprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcalatencyprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSAddIcalatencyprofile: Finished"
    }
}

function Invoke-NSDeleteIcalatencyprofile {
    <#
    .SYNOPSIS
        Delete ICA configuration. config Object.
    .DESCRIPTION
        Configuration for Profile for Latency monitoring resource.
    .PARAMETER Name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteIcalatencyprofile -Name <string>
        An example how to delete icalatencyprofile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteIcalatencyprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icalatencyprofile/
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
        Write-Verbose "Invoke-NSDeleteIcalatencyprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete ICA configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type icalatencyprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteIcalatencyprofile: Finished"
    }
}

function Invoke-NSUpdateIcalatencyprofile {
    <#
    .SYNOPSIS
        Update ICA configuration. config Object.
    .DESCRIPTION
        Configuration for Profile for Latency monitoring resource.
    .PARAMETER Name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER L7latencymonitoring 
        Enable/Disable L7 Latency monitoring for L7 latency notifications. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER L7latencythresholdfactor 
        L7 Latency threshold factor. This is the factor by which the active latency should be greater than the minimum observed value to determine that the latency is high and may need to be reported. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencywaittime 
        L7 Latency Wait time. This is the time for which the Citrix ADC waits after the threshold is exceeded before it sends out a Notification to the Insight Center. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencynotifyinterval 
        L7 Latency Notify Interval. This is the interval at which the Citrix ADC sends out notifications to the Insight Center after the wait time has passed. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencymaxnotifycount 
        L7 Latency Max notify Count. This is the upper limit on the number of notifications sent to the Insight Center within an interval where the Latency is above the threshold. 
         
         
        Maximum value = 65535 
    .PARAMETER PassThru 
        Return details about the created icalatencyprofile item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateIcalatencyprofile -name <string>
        An example how to update icalatencyprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateIcalatencyprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icalatencyprofile/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$L7latencymonitoring,

        [double]$L7latencythresholdfactor,

        [double]$L7latencywaittime,

        [double]$L7latencynotifyinterval,

        [double]$L7latencymaxnotifycount,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateIcalatencyprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('l7latencymonitoring') ) { $payload.Add('l7latencymonitoring', $l7latencymonitoring) }
            if ( $PSBoundParameters.ContainsKey('l7latencythresholdfactor') ) { $payload.Add('l7latencythresholdfactor', $l7latencythresholdfactor) }
            if ( $PSBoundParameters.ContainsKey('l7latencywaittime') ) { $payload.Add('l7latencywaittime', $l7latencywaittime) }
            if ( $PSBoundParameters.ContainsKey('l7latencynotifyinterval') ) { $payload.Add('l7latencynotifyinterval', $l7latencynotifyinterval) }
            if ( $PSBoundParameters.ContainsKey('l7latencymaxnotifycount') ) { $payload.Add('l7latencymaxnotifycount', $l7latencymaxnotifycount) }
            if ( $PSCmdlet.ShouldProcess("icalatencyprofile", "Update ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type icalatencyprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcalatencyprofile -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateIcalatencyprofile: Finished"
    }
}

function Invoke-NSUnsetIcalatencyprofile {
    <#
    .SYNOPSIS
        Unset ICA configuration. config Object.
    .DESCRIPTION
        Configuration for Profile for Latency monitoring resource.
    .PARAMETER Name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER L7latencymonitoring 
        Enable/Disable L7 Latency monitoring for L7 latency notifications. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER L7latencythresholdfactor 
        L7 Latency threshold factor. This is the factor by which the active latency should be greater than the minimum observed value to determine that the latency is high and may need to be reported. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencywaittime 
        L7 Latency Wait time. This is the time for which the Citrix ADC waits after the threshold is exceeded before it sends out a Notification to the Insight Center. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencynotifyinterval 
        L7 Latency Notify Interval. This is the interval at which the Citrix ADC sends out notifications to the Insight Center after the wait time has passed. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencymaxnotifycount 
        L7 Latency Max notify Count. This is the upper limit on the number of notifications sent to the Insight Center within an interval where the Latency is above the threshold. 
         
         
        Maximum value = 65535
    .EXAMPLE
        PS C:\>Invoke-NSUnsetIcalatencyprofile -name <string>
        An example how to unset icalatencyprofile config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetIcalatencyprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icalatencyprofile
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

        [Boolean]$l7latencymonitoring,

        [Boolean]$l7latencythresholdfactor,

        [Boolean]$l7latencywaittime,

        [Boolean]$l7latencynotifyinterval,

        [Boolean]$l7latencymaxnotifycount 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetIcalatencyprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('l7latencymonitoring') ) { $payload.Add('l7latencymonitoring', $l7latencymonitoring) }
            if ( $PSBoundParameters.ContainsKey('l7latencythresholdfactor') ) { $payload.Add('l7latencythresholdfactor', $l7latencythresholdfactor) }
            if ( $PSBoundParameters.ContainsKey('l7latencywaittime') ) { $payload.Add('l7latencywaittime', $l7latencywaittime) }
            if ( $PSBoundParameters.ContainsKey('l7latencynotifyinterval') ) { $payload.Add('l7latencynotifyinterval', $l7latencynotifyinterval) }
            if ( $PSBoundParameters.ContainsKey('l7latencymaxnotifycount') ) { $payload.Add('l7latencymaxnotifycount', $l7latencymaxnotifycount) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset ICA configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type icalatencyprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetIcalatencyprofile: Finished"
    }
}

function Invoke-NSGetIcalatencyprofile {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Configuration for Profile for Latency monitoring resource.
    .PARAMETER Name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER GetAll 
        Retrieve all icalatencyprofile object(s).
    .PARAMETER Count
        If specified, the count of the icalatencyprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcalatencyprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcalatencyprofile -GetAll 
        Get all icalatencyprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcalatencyprofile -Count 
        Get the number of icalatencyprofile objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcalatencyprofile -name <string>
        Get icalatencyprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcalatencyprofile -Filter @{ 'name'='<value>' }
        Get icalatencyprofile data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcalatencyprofile
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icalatencyprofile/
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
        Write-Verbose "Invoke-NSGetIcalatencyprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all icalatencyprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icalatencyprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icalatencyprofile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icalatencyprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icalatencyprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icalatencyprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icalatencyprofile configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icalatencyprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icalatencyprofile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icalatencyprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcalatencyprofile: Ended"
    }
}

function Invoke-NSUpdateIcaparameter {
    <#
    .SYNOPSIS
        Update ICA configuration. config Object.
    .DESCRIPTION
        Configuration for Config Parameters for NS ICA resource.
    .PARAMETER Enablesronhafailover 
        Enable/Disable Session Reliability on HA failover. The default value is No. 
         
        Possible values = YES, NO 
    .PARAMETER Hdxinsightnonnsap 
        Enable/Disable HDXInsight for Non NSAP ICA Sessions. The default value is Yes. 
         
        Possible values = YES, NO 
    .PARAMETER Edtpmtuddf 
        Enable/Disable DF enforcement for EDT PMTUD Control Blocks. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Edtpmtuddftimeout 
        DF enforcement timeout for EDTPMTUDDF. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencyfrequency 
        Specify the time interval/period for which L7 Client Latency value is to be calculated. By default, L7 Client Latency is calculated for every packet. The default value is 0. 
         
         
        Maximum value = 60
    .EXAMPLE
        PS C:\>Invoke-NSUpdateIcaparameter 
        An example how to update icaparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateIcaparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaparameter/
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
        [string]$Enablesronhafailover,

        [ValidateSet('YES', 'NO')]
        [string]$Hdxinsightnonnsap,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Edtpmtuddf,

        [double]$Edtpmtuddftimeout,

        [double]$L7latencyfrequency 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateIcaparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('enablesronhafailover') ) { $payload.Add('enablesronhafailover', $enablesronhafailover) }
            if ( $PSBoundParameters.ContainsKey('hdxinsightnonnsap') ) { $payload.Add('hdxinsightnonnsap', $hdxinsightnonnsap) }
            if ( $PSBoundParameters.ContainsKey('edtpmtuddf') ) { $payload.Add('edtpmtuddf', $edtpmtuddf) }
            if ( $PSBoundParameters.ContainsKey('edtpmtuddftimeout') ) { $payload.Add('edtpmtuddftimeout', $edtpmtuddftimeout) }
            if ( $PSBoundParameters.ContainsKey('l7latencyfrequency') ) { $payload.Add('l7latencyfrequency', $l7latencyfrequency) }
            if ( $PSCmdlet.ShouldProcess("icaparameter", "Update ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type icaparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateIcaparameter: Finished"
    }
}

function Invoke-NSUnsetIcaparameter {
    <#
    .SYNOPSIS
        Unset ICA configuration. config Object.
    .DESCRIPTION
        Configuration for Config Parameters for NS ICA resource.
    .PARAMETER Enablesronhafailover 
        Enable/Disable Session Reliability on HA failover. The default value is No. 
         
        Possible values = YES, NO 
    .PARAMETER Hdxinsightnonnsap 
        Enable/Disable HDXInsight for Non NSAP ICA Sessions. The default value is Yes. 
         
        Possible values = YES, NO 
    .PARAMETER Edtpmtuddf 
        Enable/Disable DF enforcement for EDT PMTUD Control Blocks. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Edtpmtuddftimeout 
        DF enforcement timeout for EDTPMTUDDF. 
         
         
        Maximum value = 65535 
    .PARAMETER L7latencyfrequency 
        Specify the time interval/period for which L7 Client Latency value is to be calculated. By default, L7 Client Latency is calculated for every packet. The default value is 0. 
         
         
        Maximum value = 60
    .EXAMPLE
        PS C:\>Invoke-NSUnsetIcaparameter 
        An example how to unset icaparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetIcaparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaparameter
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

        [Boolean]$enablesronhafailover,

        [Boolean]$hdxinsightnonnsap,

        [Boolean]$edtpmtuddf,

        [Boolean]$edtpmtuddftimeout,

        [Boolean]$l7latencyfrequency 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetIcaparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('enablesronhafailover') ) { $payload.Add('enablesronhafailover', $enablesronhafailover) }
            if ( $PSBoundParameters.ContainsKey('hdxinsightnonnsap') ) { $payload.Add('hdxinsightnonnsap', $hdxinsightnonnsap) }
            if ( $PSBoundParameters.ContainsKey('edtpmtuddf') ) { $payload.Add('edtpmtuddf', $edtpmtuddf) }
            if ( $PSBoundParameters.ContainsKey('edtpmtuddftimeout') ) { $payload.Add('edtpmtuddftimeout', $edtpmtuddftimeout) }
            if ( $PSBoundParameters.ContainsKey('l7latencyfrequency') ) { $payload.Add('l7latencyfrequency', $l7latencyfrequency) }
            if ( $PSCmdlet.ShouldProcess("icaparameter", "Unset ICA configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type icaparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetIcaparameter: Finished"
    }
}

function Invoke-NSGetIcaparameter {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Configuration for Config Parameters for NS ICA resource.
    .PARAMETER GetAll 
        Retrieve all icaparameter object(s).
    .PARAMETER Count
        If specified, the count of the icaparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcaparameter -GetAll 
        Get all icaparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaparameter -name <string>
        Get icaparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcaparameter -Filter @{ 'name'='<value>' }
        Get icaparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcaparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icaparameter/
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
        Write-Verbose "Invoke-NSGetIcaparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all icaparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving icaparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icaparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcaparameter: Ended"
    }
}

function Invoke-NSAddIcapolicy {
    <#
    .SYNOPSIS
        Add ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the ica action to be associated with this policy. 
    .PARAMETER Comment 
        Any type of information about this ICA policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created icapolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddIcapolicy -name <string> -rule <string> -action <string>
        An example how to add icapolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddIcapolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icapolicy/
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
        [string]$Rule,

        [Parameter(Mandatory)]
        [string]$Action,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddIcapolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("icapolicy", "Add ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type icapolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcapolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddIcapolicy: Finished"
    }
}

function Invoke-NSDeleteIcapolicy {
    <#
    .SYNOPSIS
        Delete ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteIcapolicy -Name <string>
        An example how to delete icapolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteIcapolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icapolicy/
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
        Write-Verbose "Invoke-NSDeleteIcapolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete ICA configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type icapolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteIcapolicy: Finished"
    }
}

function Invoke-NSUpdateIcapolicy {
    <#
    .SYNOPSIS
        Update ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression. 
         
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the ica action to be associated with this policy. 
    .PARAMETER Comment 
        Any type of information about this ICA policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created icapolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateIcapolicy -name <string>
        An example how to update icapolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateIcapolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icapolicy/
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

        [string]$Rule,

        [string]$Action,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateIcapolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("icapolicy", "Update ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type icapolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcapolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateIcapolicy: Finished"
    }
}

function Invoke-NSUnsetIcapolicy {
    <#
    .SYNOPSIS
        Unset ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Comment 
        Any type of information about this ICA policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetIcapolicy -name <string>
        An example how to unset icapolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetIcapolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icapolicy
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

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetIcapolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset ICA configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type icapolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetIcapolicy: Finished"
    }
}

function Invoke-NSRenameIcapolicy {
    <#
    .SYNOPSIS
        Rename ICA configuration. config Object.
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Newname 
        New name for the policy. Must begin with an ASCII alphabetic or underscore (_)character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), s 
        pace, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created icapolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameIcapolicy -name <string> -newname <string>
        An example how to rename icapolicy config Object(s).
    .NOTES
        File Name : Invoke-NSRenameIcapolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icapolicy/
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
        Write-Verbose "Invoke-NSRenameIcapolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("icapolicy", "Rename ICA configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type icapolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetIcapolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameIcapolicy: Finished"
    }
}

function Invoke-NSGetIcapolicy {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all icapolicy object(s).
    .PARAMETER Count
        If specified, the count of the icapolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcapolicy -GetAll 
        Get all icapolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcapolicy -Count 
        Get the number of icapolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicy -name <string>
        Get icapolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicy -Filter @{ 'name'='<value>' }
        Get icapolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcapolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icapolicy/
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
        Write-Verbose "Invoke-NSGetIcapolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all icapolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcapolicy: Ended"
    }
}

function Invoke-NSGetIcapolicyBinding {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to icapolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all icapolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the icapolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcapolicyBinding -GetAll 
        Get all icapolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyBinding -name <string>
        Get icapolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyBinding -Filter @{ 'name'='<value>' }
        Get icapolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcapolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icapolicy_binding/
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
        Write-Verbose "Invoke-NSGetIcapolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icapolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcapolicyBinding: Ended"
    }
}

function Invoke-NSGetIcapolicyCrvserverBinding {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to icapolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all icapolicy_crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the icapolicy_crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyCrvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcapolicyCrvserverBinding -GetAll 
        Get all icapolicy_crvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcapolicyCrvserverBinding -Count 
        Get the number of icapolicy_crvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyCrvserverBinding -name <string>
        Get icapolicy_crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyCrvserverBinding -Filter @{ 'name'='<value>' }
        Get icapolicy_crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcapolicyCrvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icapolicy_crvserver_binding/
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
        Write-Verbose "Invoke-NSGetIcapolicyCrvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icapolicy_crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_crvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_crvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_crvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcapolicyCrvserverBinding: Ended"
    }
}

function Invoke-NSGetIcapolicyIcaglobalBinding {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Binding object showing the icaglobal that can be bound to icapolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all icapolicy_icaglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the icapolicy_icaglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyIcaglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcapolicyIcaglobalBinding -GetAll 
        Get all icapolicy_icaglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcapolicyIcaglobalBinding -Count 
        Get the number of icapolicy_icaglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyIcaglobalBinding -name <string>
        Get icapolicy_icaglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyIcaglobalBinding -Filter @{ 'name'='<value>' }
        Get icapolicy_icaglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcapolicyIcaglobalBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icapolicy_icaglobal_binding/
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
        Write-Verbose "Invoke-NSGetIcapolicyIcaglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icapolicy_icaglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_icaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_icaglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_icaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_icaglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_icaglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_icaglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_icaglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_icaglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_icaglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcapolicyIcaglobalBinding: Ended"
    }
}

function Invoke-NSGetIcapolicyVpnvserverBinding {
    <#
    .SYNOPSIS
        Get ICA configuration. config object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to icapolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all icapolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the icapolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyVpnvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcapolicyVpnvserverBinding -GetAll 
        Get all icapolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetIcapolicyVpnvserverBinding -Count 
        Get the number of icapolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyVpnvserverBinding -name <string>
        Get icapolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetIcapolicyVpnvserverBinding -Filter @{ 'name'='<value>' }
        Get icapolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetIcapolicyVpnvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/ica/icapolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-NSGetIcapolicyVpnvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icapolicy_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_vpnvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type icapolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetIcapolicyVpnvserverBinding: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCB3Y0HGCfqdrGtb
# lB1JeEreqC9qC3bOhDpR5Xt34K8LvKCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgLrrDsuN2134c8g8LdC2nYoYsLsQJtNVTnMpXrbeSYqcwDQYJKoZIhvcNAQEB
# BQAEggEAgArny56ZblG3h17rdYufjC2LwojW8BhkgfBRD6F5pEtKLf1MBIsP9OmK
# GD/UBC2BXUNTQ2peU/tUUsNehHm83FqmICEFyT/MKFgWriGULH5Vyi1J1mo9oIzk
# FU6XLGEzEH2xWVkrTa/OSErbBzjRa9WNAZ5vQi7iwX0btMtvD6dttYTSSo6kIxZA
# rHwxEDgUmTQlcNmgWHIjkz7W333NDcmk6ocwTV7c32R+9JYmBzDnQyWYz3CkXfDE
# Am3wBFA7BiH5F9Uv+4FrM359c24BM1aHAldQ28y8/M1rrCqZNR7Is/83wwB+WfK3
# XRozQ6ybfgh1YOJfvv1pDg/U2EZnrg==
# SIG # End signature block
