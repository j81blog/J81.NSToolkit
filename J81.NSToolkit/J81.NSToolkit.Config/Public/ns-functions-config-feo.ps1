function Invoke-NSAddFeoaction {
    <#
    .SYNOPSIS
        Add Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Configuration for Front end optimization action resource.
    .PARAMETER Name 
        The name of the front end optimization action. 
    .PARAMETER Pageextendcache 
        Extend the time period during which the browser can use the cached resource. 
    .PARAMETER Cachemaxage 
        Maxage for cache extension. 
         
         
        Maximum value = 360 
    .PARAMETER Imgshrinktoattrib 
        Shrink image dimensions as per the height and width attributes specified in the &lt;img&gt; tag. 
    .PARAMETER Imggiftopng 
        Convert GIF image formats to PNG formats. 
    .PARAMETER Imgtowebp 
        Convert JPEG, GIF, PNG image formats to WEBP format. 
    .PARAMETER Imgtojpegxr 
        Convert JPEG, GIF, PNG image formats to JXR format. 
    .PARAMETER Imginline 
        Inline images whose size is less than 2KB. 
    .PARAMETER Cssimginline 
        Inline small images (less than 2KB) referred within CSS files as background-URLs. 
    .PARAMETER Jpgoptimize 
        Remove non-image data such as comments from JPEG images. 
    .PARAMETER Imglazyload 
        Download images, only when the user scrolls the page to view them. 
    .PARAMETER Cssminify 
        Remove comments and whitespaces from CSSs. 
    .PARAMETER Cssinline 
        Inline CSS files, whose size is less than 2KB, within the main page. 
    .PARAMETER Csscombine 
        Combine one or more CSS files into one file. 
    .PARAMETER Convertimporttolink 
        Convert CSS import statements to HTML link tags. 
    .PARAMETER Jsminify 
        Remove comments and whitespaces from JavaScript. 
    .PARAMETER Jsinline 
        Convert linked JavaScript files (less than 2KB) to inline JavaScript files. 
    .PARAMETER Htmlminify 
        Remove comments and whitespaces from an HTML page. 
    .PARAMETER Cssmovetohead 
        Move any CSS file present within the body tag of an HTML page to the head tag. 
    .PARAMETER Jsmovetoend 
        Move any JavaScript present in the body tag to the end of the body tag. 
    .PARAMETER Domainsharding 
        Domain name of the server. 
    .PARAMETER Dnsshards 
        Set of domain names that replaces the parent domain. 
    .PARAMETER Clientsidemeasurements 
        Send AppFlow records about the web pages optimized by this action. The records provide FEO statistics, such as the number of HTTP requests that have been reduced for this page. You must enable the Appflow feature before enabling this parameter. 
    .PARAMETER PassThru 
        Return details about the created feoaction item.
    .EXAMPLE
        PS C:\>Invoke-NSAddFeoaction -name <string>
        An example how to add feoaction config Object(s).
    .NOTES
        File Name : Invoke-NSAddFeoaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoaction/
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

        [boolean]$Pageextendcache,

        [double]$Cachemaxage = '30',

        [boolean]$Imgshrinktoattrib,

        [boolean]$Imggiftopng,

        [boolean]$Imgtowebp,

        [boolean]$Imgtojpegxr,

        [boolean]$Imginline,

        [boolean]$Cssimginline,

        [boolean]$Jpgoptimize,

        [boolean]$Imglazyload,

        [boolean]$Cssminify,

        [boolean]$Cssinline,

        [boolean]$Csscombine,

        [boolean]$Convertimporttolink,

        [boolean]$Jsminify,

        [boolean]$Jsinline,

        [boolean]$Htmlminify,

        [boolean]$Cssmovetohead,

        [boolean]$Jsmovetoend,

        [string]$Domainsharding,

        [string[]]$Dnsshards,

        [boolean]$Clientsidemeasurements,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddFeoaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('pageextendcache') ) { $payload.Add('pageextendcache', $pageextendcache) }
            if ( $PSBoundParameters.ContainsKey('cachemaxage') ) { $payload.Add('cachemaxage', $cachemaxage) }
            if ( $PSBoundParameters.ContainsKey('imgshrinktoattrib') ) { $payload.Add('imgshrinktoattrib', $imgshrinktoattrib) }
            if ( $PSBoundParameters.ContainsKey('imggiftopng') ) { $payload.Add('imggiftopng', $imggiftopng) }
            if ( $PSBoundParameters.ContainsKey('imgtowebp') ) { $payload.Add('imgtowebp', $imgtowebp) }
            if ( $PSBoundParameters.ContainsKey('imgtojpegxr') ) { $payload.Add('imgtojpegxr', $imgtojpegxr) }
            if ( $PSBoundParameters.ContainsKey('imginline') ) { $payload.Add('imginline', $imginline) }
            if ( $PSBoundParameters.ContainsKey('cssimginline') ) { $payload.Add('cssimginline', $cssimginline) }
            if ( $PSBoundParameters.ContainsKey('jpgoptimize') ) { $payload.Add('jpgoptimize', $jpgoptimize) }
            if ( $PSBoundParameters.ContainsKey('imglazyload') ) { $payload.Add('imglazyload', $imglazyload) }
            if ( $PSBoundParameters.ContainsKey('cssminify') ) { $payload.Add('cssminify', $cssminify) }
            if ( $PSBoundParameters.ContainsKey('cssinline') ) { $payload.Add('cssinline', $cssinline) }
            if ( $PSBoundParameters.ContainsKey('csscombine') ) { $payload.Add('csscombine', $csscombine) }
            if ( $PSBoundParameters.ContainsKey('convertimporttolink') ) { $payload.Add('convertimporttolink', $convertimporttolink) }
            if ( $PSBoundParameters.ContainsKey('jsminify') ) { $payload.Add('jsminify', $jsminify) }
            if ( $PSBoundParameters.ContainsKey('jsinline') ) { $payload.Add('jsinline', $jsinline) }
            if ( $PSBoundParameters.ContainsKey('htmlminify') ) { $payload.Add('htmlminify', $htmlminify) }
            if ( $PSBoundParameters.ContainsKey('cssmovetohead') ) { $payload.Add('cssmovetohead', $cssmovetohead) }
            if ( $PSBoundParameters.ContainsKey('jsmovetoend') ) { $payload.Add('jsmovetoend', $jsmovetoend) }
            if ( $PSBoundParameters.ContainsKey('domainsharding') ) { $payload.Add('domainsharding', $domainsharding) }
            if ( $PSBoundParameters.ContainsKey('dnsshards') ) { $payload.Add('dnsshards', $dnsshards) }
            if ( $PSBoundParameters.ContainsKey('clientsidemeasurements') ) { $payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ( $PSCmdlet.ShouldProcess("feoaction", "Add Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type feoaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetFeoaction -Filter $payload)
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
        Write-Verbose "Invoke-NSAddFeoaction: Finished"
    }
}

function Invoke-NSUpdateFeoaction {
    <#
    .SYNOPSIS
        Update Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Configuration for Front end optimization action resource.
    .PARAMETER Name 
        The name of the front end optimization action. 
    .PARAMETER Pageextendcache 
        Extend the time period during which the browser can use the cached resource. 
    .PARAMETER Cachemaxage 
        Maxage for cache extension. 
         
         
        Maximum value = 360 
    .PARAMETER Imgshrinktoattrib 
        Shrink image dimensions as per the height and width attributes specified in the &lt;img&gt; tag. 
    .PARAMETER Imggiftopng 
        Convert GIF image formats to PNG formats. 
    .PARAMETER Imgtowebp 
        Convert JPEG, GIF, PNG image formats to WEBP format. 
    .PARAMETER Imgtojpegxr 
        Convert JPEG, GIF, PNG image formats to JXR format. 
    .PARAMETER Imginline 
        Inline images whose size is less than 2KB. 
    .PARAMETER Cssimginline 
        Inline small images (less than 2KB) referred within CSS files as background-URLs. 
    .PARAMETER Jpgoptimize 
        Remove non-image data such as comments from JPEG images. 
    .PARAMETER Imglazyload 
        Download images, only when the user scrolls the page to view them. 
    .PARAMETER Cssminify 
        Remove comments and whitespaces from CSSs. 
    .PARAMETER Cssinline 
        Inline CSS files, whose size is less than 2KB, within the main page. 
    .PARAMETER Csscombine 
        Combine one or more CSS files into one file. 
    .PARAMETER Convertimporttolink 
        Convert CSS import statements to HTML link tags. 
    .PARAMETER Jsminify 
        Remove comments and whitespaces from JavaScript. 
    .PARAMETER Jsinline 
        Convert linked JavaScript files (less than 2KB) to inline JavaScript files. 
    .PARAMETER Htmlminify 
        Remove comments and whitespaces from an HTML page. 
    .PARAMETER Cssmovetohead 
        Move any CSS file present within the body tag of an HTML page to the head tag. 
    .PARAMETER Jsmovetoend 
        Move any JavaScript present in the body tag to the end of the body tag. 
    .PARAMETER Domainsharding 
        Domain name of the server. 
    .PARAMETER Dnsshards 
        Set of domain names that replaces the parent domain. 
    .PARAMETER Clientsidemeasurements 
        Send AppFlow records about the web pages optimized by this action. The records provide FEO statistics, such as the number of HTTP requests that have been reduced for this page. You must enable the Appflow feature before enabling this parameter. 
    .PARAMETER PassThru 
        Return details about the created feoaction item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateFeoaction -name <string>
        An example how to update feoaction config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateFeoaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoaction/
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

        [boolean]$Pageextendcache,

        [double]$Cachemaxage,

        [boolean]$Imgshrinktoattrib,

        [boolean]$Imggiftopng,

        [boolean]$Imgtowebp,

        [boolean]$Imgtojpegxr,

        [boolean]$Imginline,

        [boolean]$Cssimginline,

        [boolean]$Jpgoptimize,

        [boolean]$Imglazyload,

        [boolean]$Cssminify,

        [boolean]$Cssinline,

        [boolean]$Csscombine,

        [boolean]$Convertimporttolink,

        [boolean]$Jsminify,

        [boolean]$Jsinline,

        [boolean]$Htmlminify,

        [boolean]$Cssmovetohead,

        [boolean]$Jsmovetoend,

        [string]$Domainsharding,

        [string[]]$Dnsshards,

        [boolean]$Clientsidemeasurements,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateFeoaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('pageextendcache') ) { $payload.Add('pageextendcache', $pageextendcache) }
            if ( $PSBoundParameters.ContainsKey('cachemaxage') ) { $payload.Add('cachemaxage', $cachemaxage) }
            if ( $PSBoundParameters.ContainsKey('imgshrinktoattrib') ) { $payload.Add('imgshrinktoattrib', $imgshrinktoattrib) }
            if ( $PSBoundParameters.ContainsKey('imggiftopng') ) { $payload.Add('imggiftopng', $imggiftopng) }
            if ( $PSBoundParameters.ContainsKey('imgtowebp') ) { $payload.Add('imgtowebp', $imgtowebp) }
            if ( $PSBoundParameters.ContainsKey('imgtojpegxr') ) { $payload.Add('imgtojpegxr', $imgtojpegxr) }
            if ( $PSBoundParameters.ContainsKey('imginline') ) { $payload.Add('imginline', $imginline) }
            if ( $PSBoundParameters.ContainsKey('cssimginline') ) { $payload.Add('cssimginline', $cssimginline) }
            if ( $PSBoundParameters.ContainsKey('jpgoptimize') ) { $payload.Add('jpgoptimize', $jpgoptimize) }
            if ( $PSBoundParameters.ContainsKey('imglazyload') ) { $payload.Add('imglazyload', $imglazyload) }
            if ( $PSBoundParameters.ContainsKey('cssminify') ) { $payload.Add('cssminify', $cssminify) }
            if ( $PSBoundParameters.ContainsKey('cssinline') ) { $payload.Add('cssinline', $cssinline) }
            if ( $PSBoundParameters.ContainsKey('csscombine') ) { $payload.Add('csscombine', $csscombine) }
            if ( $PSBoundParameters.ContainsKey('convertimporttolink') ) { $payload.Add('convertimporttolink', $convertimporttolink) }
            if ( $PSBoundParameters.ContainsKey('jsminify') ) { $payload.Add('jsminify', $jsminify) }
            if ( $PSBoundParameters.ContainsKey('jsinline') ) { $payload.Add('jsinline', $jsinline) }
            if ( $PSBoundParameters.ContainsKey('htmlminify') ) { $payload.Add('htmlminify', $htmlminify) }
            if ( $PSBoundParameters.ContainsKey('cssmovetohead') ) { $payload.Add('cssmovetohead', $cssmovetohead) }
            if ( $PSBoundParameters.ContainsKey('jsmovetoend') ) { $payload.Add('jsmovetoend', $jsmovetoend) }
            if ( $PSBoundParameters.ContainsKey('domainsharding') ) { $payload.Add('domainsharding', $domainsharding) }
            if ( $PSBoundParameters.ContainsKey('dnsshards') ) { $payload.Add('dnsshards', $dnsshards) }
            if ( $PSBoundParameters.ContainsKey('clientsidemeasurements') ) { $payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ( $PSCmdlet.ShouldProcess("feoaction", "Update Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type feoaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetFeoaction -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateFeoaction: Finished"
    }
}

function Invoke-NSUnsetFeoaction {
    <#
    .SYNOPSIS
        Unset Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Configuration for Front end optimization action resource.
    .PARAMETER Name 
        The name of the front end optimization action. 
    .PARAMETER Pageextendcache 
        Extend the time period during which the browser can use the cached resource. 
    .PARAMETER Imgshrinktoattrib 
        Shrink image dimensions as per the height and width attributes specified in the &lt;img&gt; tag. 
    .PARAMETER Imggiftopng 
        Convert GIF image formats to PNG formats. 
    .PARAMETER Imgtowebp 
        Convert JPEG, GIF, PNG image formats to WEBP format. 
    .PARAMETER Imgtojpegxr 
        Convert JPEG, GIF, PNG image formats to JXR format. 
    .PARAMETER Imginline 
        Inline images whose size is less than 2KB. 
    .PARAMETER Cssimginline 
        Inline small images (less than 2KB) referred within CSS files as background-URLs. 
    .PARAMETER Jpgoptimize 
        Remove non-image data such as comments from JPEG images. 
    .PARAMETER Imglazyload 
        Download images, only when the user scrolls the page to view them. 
    .PARAMETER Cssminify 
        Remove comments and whitespaces from CSSs. 
    .PARAMETER Cssinline 
        Inline CSS files, whose size is less than 2KB, within the main page. 
    .PARAMETER Csscombine 
        Combine one or more CSS files into one file. 
    .PARAMETER Convertimporttolink 
        Convert CSS import statements to HTML link tags. 
    .PARAMETER Jsminify 
        Remove comments and whitespaces from JavaScript. 
    .PARAMETER Jsinline 
        Convert linked JavaScript files (less than 2KB) to inline JavaScript files. 
    .PARAMETER Htmlminify 
        Remove comments and whitespaces from an HTML page. 
    .PARAMETER Cssmovetohead 
        Move any CSS file present within the body tag of an HTML page to the head tag. 
    .PARAMETER Jsmovetoend 
        Move any JavaScript present in the body tag to the end of the body tag. 
    .PARAMETER Clientsidemeasurements 
        Send AppFlow records about the web pages optimized by this action. The records provide FEO statistics, such as the number of HTTP requests that have been reduced for this page. You must enable the Appflow feature before enabling this parameter. 
    .PARAMETER Domainsharding 
        Domain name of the server.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetFeoaction -name <string>
        An example how to unset feoaction config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetFeoaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoaction
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

        [Boolean]$pageextendcache,

        [Boolean]$imgshrinktoattrib,

        [Boolean]$imggiftopng,

        [Boolean]$imgtowebp,

        [Boolean]$imgtojpegxr,

        [Boolean]$imginline,

        [Boolean]$cssimginline,

        [Boolean]$jpgoptimize,

        [Boolean]$imglazyload,

        [Boolean]$cssminify,

        [Boolean]$cssinline,

        [Boolean]$csscombine,

        [Boolean]$convertimporttolink,

        [Boolean]$jsminify,

        [Boolean]$jsinline,

        [Boolean]$htmlminify,

        [Boolean]$cssmovetohead,

        [Boolean]$jsmovetoend,

        [Boolean]$clientsidemeasurements,

        [Boolean]$domainsharding 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetFeoaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('pageextendcache') ) { $payload.Add('pageextendcache', $pageextendcache) }
            if ( $PSBoundParameters.ContainsKey('imgshrinktoattrib') ) { $payload.Add('imgshrinktoattrib', $imgshrinktoattrib) }
            if ( $PSBoundParameters.ContainsKey('imggiftopng') ) { $payload.Add('imggiftopng', $imggiftopng) }
            if ( $PSBoundParameters.ContainsKey('imgtowebp') ) { $payload.Add('imgtowebp', $imgtowebp) }
            if ( $PSBoundParameters.ContainsKey('imgtojpegxr') ) { $payload.Add('imgtojpegxr', $imgtojpegxr) }
            if ( $PSBoundParameters.ContainsKey('imginline') ) { $payload.Add('imginline', $imginline) }
            if ( $PSBoundParameters.ContainsKey('cssimginline') ) { $payload.Add('cssimginline', $cssimginline) }
            if ( $PSBoundParameters.ContainsKey('jpgoptimize') ) { $payload.Add('jpgoptimize', $jpgoptimize) }
            if ( $PSBoundParameters.ContainsKey('imglazyload') ) { $payload.Add('imglazyload', $imglazyload) }
            if ( $PSBoundParameters.ContainsKey('cssminify') ) { $payload.Add('cssminify', $cssminify) }
            if ( $PSBoundParameters.ContainsKey('cssinline') ) { $payload.Add('cssinline', $cssinline) }
            if ( $PSBoundParameters.ContainsKey('csscombine') ) { $payload.Add('csscombine', $csscombine) }
            if ( $PSBoundParameters.ContainsKey('convertimporttolink') ) { $payload.Add('convertimporttolink', $convertimporttolink) }
            if ( $PSBoundParameters.ContainsKey('jsminify') ) { $payload.Add('jsminify', $jsminify) }
            if ( $PSBoundParameters.ContainsKey('jsinline') ) { $payload.Add('jsinline', $jsinline) }
            if ( $PSBoundParameters.ContainsKey('htmlminify') ) { $payload.Add('htmlminify', $htmlminify) }
            if ( $PSBoundParameters.ContainsKey('cssmovetohead') ) { $payload.Add('cssmovetohead', $cssmovetohead) }
            if ( $PSBoundParameters.ContainsKey('jsmovetoend') ) { $payload.Add('jsmovetoend', $jsmovetoend) }
            if ( $PSBoundParameters.ContainsKey('clientsidemeasurements') ) { $payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ( $PSBoundParameters.ContainsKey('domainsharding') ) { $payload.Add('domainsharding', $domainsharding) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type feoaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetFeoaction: Finished"
    }
}

function Invoke-NSDeleteFeoaction {
    <#
    .SYNOPSIS
        Delete Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Configuration for Front end optimization action resource.
    .PARAMETER Name 
        The name of the front end optimization action.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteFeoaction -Name <string>
        An example how to delete feoaction config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteFeoaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoaction/
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
        Write-Verbose "Invoke-NSDeleteFeoaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type feoaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteFeoaction: Finished"
    }
}

function Invoke-NSGetFeoaction {
    <#
    .SYNOPSIS
        Get Front end optimization configuration. The system's feature to optimize Web content for performance. config object(s).
    .DESCRIPTION
        Configuration for Front end optimization action resource.
    .PARAMETER Name 
        The name of the front end optimization action. 
    .PARAMETER GetAll 
        Retrieve all feoaction object(s).
    .PARAMETER Count
        If specified, the count of the feoaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeoaction -GetAll 
        Get all feoaction data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeoaction -Count 
        Get the number of feoaction objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoaction -name <string>
        Get feoaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoaction -Filter @{ 'name'='<value>' }
        Get feoaction data with a filter.
    .NOTES
        File Name : Invoke-NSGetFeoaction
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoaction/
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
        Write-Verbose "Invoke-NSGetFeoaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all feoaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feoaction objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feoaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feoaction configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feoaction configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetFeoaction: Ended"
    }
}

function Invoke-NSGetFeoglobalBinding {
    <#
    .SYNOPSIS
        Get Front end optimization configuration. The system's feature to optimize Web content for performance. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to feoglobal.
    .PARAMETER GetAll 
        Retrieve all feoglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the feoglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeoglobalBinding -GetAll 
        Get all feoglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoglobalBinding -name <string>
        Get feoglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoglobalBinding -Filter @{ 'name'='<value>' }
        Get feoglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetFeoglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoglobal_binding/
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
        Write-Verbose "Invoke-NSGetFeoglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all feoglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feoglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feoglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feoglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving feoglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetFeoglobalBinding: Ended"
    }
}

function Invoke-NSAddFeoglobalFeopolicyBinding {
    <#
    .SYNOPSIS
        Add Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to feoglobal.
    .PARAMETER Policyname 
        The name of the globally bound front end optimization policy. 
    .PARAMETER Priority 
        The priority assigned to the policy binding. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, NONE 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created feoglobal_feopolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddFeoglobalFeopolicyBinding -policyname <string> -priority <double>
        An example how to add feoglobal_feopolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddFeoglobalFeopolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoglobal_feopolicy_binding/
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

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT', 'NONE')]
        [string]$Type,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddFeoglobalFeopolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("feoglobal_feopolicy_binding", "Add Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type feoglobal_feopolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetFeoglobalFeopolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddFeoglobalFeopolicyBinding: Finished"
    }
}

function Invoke-NSDeleteFeoglobalFeopolicyBinding {
    <#
    .SYNOPSIS
        Delete Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to feoglobal.
    .PARAMETER Policyname 
        The name of the globally bound front end optimization policy. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, NONE 
    .PARAMETER Priority 
        The priority assigned to the policy binding.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteFeoglobalFeopolicyBinding 
        An example how to delete feoglobal_feopolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteFeoglobalFeopolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoglobal_feopolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteFeoglobalFeopolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("feoglobal_feopolicy_binding", "Delete Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type feoglobal_feopolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteFeoglobalFeopolicyBinding: Finished"
    }
}

function Invoke-NSGetFeoglobalFeopolicyBinding {
    <#
    .SYNOPSIS
        Get Front end optimization configuration. The system's feature to optimize Web content for performance. config object(s).
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to feoglobal.
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, NONE 
    .PARAMETER GetAll 
        Retrieve all feoglobal_feopolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the feoglobal_feopolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoglobalFeopolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeoglobalFeopolicyBinding -GetAll 
        Get all feoglobal_feopolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeoglobalFeopolicyBinding -Count 
        Get the number of feoglobal_feopolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoglobalFeopolicyBinding -name <string>
        Get feoglobal_feopolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoglobalFeopolicyBinding -Filter @{ 'name'='<value>' }
        Get feoglobal_feopolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetFeoglobalFeopolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoglobal_feopolicy_binding/
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
        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT', 'NONE')]
        [string]$Type,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetFeoglobalFeopolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all feoglobal_feopolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoglobal_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feoglobal_feopolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoglobal_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feoglobal_feopolicy_binding objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoglobal_feopolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feoglobal_feopolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving feoglobal_feopolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoglobal_feopolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetFeoglobalFeopolicyBinding: Ended"
    }
}

function Invoke-NSUpdateFeoparameter {
    <#
    .SYNOPSIS
        Update Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Configuration for FEO parameter resource.
    .PARAMETER Jpegqualitypercent 
        The percentage value of a JPEG image quality to be reduced. Range: 0 - 100. 
         
         
        Maximum value = 100 
    .PARAMETER Cssinlinethressize 
        Threshold value of the file size (in bytes) for converting external CSS files to inline CSS files. 
         
         
        Maximum value = 2048 
    .PARAMETER Jsinlinethressize 
        Threshold value of the file size (in bytes), for converting external JavaScript files to inline JavaScript files. 
         
         
        Maximum value = 2048 
    .PARAMETER Imginlinethressize 
        Maximum file size of an image (in bytes), for coverting linked images to inline images. 
         
         
        Maximum value = 2048
    .EXAMPLE
        PS C:\>Invoke-NSUpdateFeoparameter 
        An example how to update feoparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateFeoparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoparameter/
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

        [double]$Jpegqualitypercent,

        [double]$Cssinlinethressize,

        [double]$Jsinlinethressize,

        [double]$Imginlinethressize 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateFeoparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('jpegqualitypercent') ) { $payload.Add('jpegqualitypercent', $jpegqualitypercent) }
            if ( $PSBoundParameters.ContainsKey('cssinlinethressize') ) { $payload.Add('cssinlinethressize', $cssinlinethressize) }
            if ( $PSBoundParameters.ContainsKey('jsinlinethressize') ) { $payload.Add('jsinlinethressize', $jsinlinethressize) }
            if ( $PSBoundParameters.ContainsKey('imginlinethressize') ) { $payload.Add('imginlinethressize', $imginlinethressize) }
            if ( $PSCmdlet.ShouldProcess("feoparameter", "Update Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type feoparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateFeoparameter: Finished"
    }
}

function Invoke-NSUnsetFeoparameter {
    <#
    .SYNOPSIS
        Unset Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Configuration for FEO parameter resource.
    .PARAMETER Jpegqualitypercent 
        The percentage value of a JPEG image quality to be reduced. Range: 0 - 100. 
         
         
        Maximum value = 100 
    .PARAMETER Cssinlinethressize 
        Threshold value of the file size (in bytes) for converting external CSS files to inline CSS files. 
         
         
        Maximum value = 2048 
    .PARAMETER Jsinlinethressize 
        Threshold value of the file size (in bytes), for converting external JavaScript files to inline JavaScript files. 
         
         
        Maximum value = 2048 
    .PARAMETER Imginlinethressize 
        Maximum file size of an image (in bytes), for coverting linked images to inline images. 
         
         
        Maximum value = 2048
    .EXAMPLE
        PS C:\>Invoke-NSUnsetFeoparameter 
        An example how to unset feoparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetFeoparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoparameter
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

        [Boolean]$jpegqualitypercent,

        [Boolean]$cssinlinethressize,

        [Boolean]$jsinlinethressize,

        [Boolean]$imginlinethressize 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetFeoparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('jpegqualitypercent') ) { $payload.Add('jpegqualitypercent', $jpegqualitypercent) }
            if ( $PSBoundParameters.ContainsKey('cssinlinethressize') ) { $payload.Add('cssinlinethressize', $cssinlinethressize) }
            if ( $PSBoundParameters.ContainsKey('jsinlinethressize') ) { $payload.Add('jsinlinethressize', $jsinlinethressize) }
            if ( $PSBoundParameters.ContainsKey('imginlinethressize') ) { $payload.Add('imginlinethressize', $imginlinethressize) }
            if ( $PSCmdlet.ShouldProcess("feoparameter", "Unset Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type feoparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetFeoparameter: Finished"
    }
}

function Invoke-NSGetFeoparameter {
    <#
    .SYNOPSIS
        Get Front end optimization configuration. The system's feature to optimize Web content for performance. config object(s).
    .DESCRIPTION
        Configuration for FEO parameter resource.
    .PARAMETER GetAll 
        Retrieve all feoparameter object(s).
    .PARAMETER Count
        If specified, the count of the feoparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeoparameter -GetAll 
        Get all feoparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoparameter -name <string>
        Get feoparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeoparameter -Filter @{ 'name'='<value>' }
        Get feoparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetFeoparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feoparameter/
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
        Write-Verbose "Invoke-NSGetFeoparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all feoparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feoparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feoparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feoparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving feoparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feoparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetFeoparameter: Ended"
    }
}

function Invoke-NSAddFeopolicy {
    <#
    .SYNOPSIS
        Add Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Configuration for Front end optimization policy resource.
    .PARAMETER Name 
        The name of the front end optimization policy. 
    .PARAMETER Rule 
        The rule associated with the front end optimization policy. 
    .PARAMETER Action 
        The front end optimization action that has to be performed when the rule matches. 
    .PARAMETER PassThru 
        Return details about the created feopolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddFeopolicy -name <string> -rule <string> -action <string>
        An example how to add feopolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddFeopolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feopolicy/
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
        [string]$Rule,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddFeopolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("feopolicy", "Add Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type feopolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetFeopolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddFeopolicy: Finished"
    }
}

function Invoke-NSDeleteFeopolicy {
    <#
    .SYNOPSIS
        Delete Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Configuration for Front end optimization policy resource.
    .PARAMETER Name 
        The name of the front end optimization policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteFeopolicy -Name <string>
        An example how to delete feopolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteFeopolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feopolicy/
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
        Write-Verbose "Invoke-NSDeleteFeopolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type feopolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteFeopolicy: Finished"
    }
}

function Invoke-NSUpdateFeopolicy {
    <#
    .SYNOPSIS
        Update Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Configuration for Front end optimization policy resource.
    .PARAMETER Name 
        The name of the front end optimization policy. 
    .PARAMETER Rule 
        The rule associated with the front end optimization policy. 
    .PARAMETER Action 
        The front end optimization action that has to be performed when the rule matches. 
    .PARAMETER PassThru 
        Return details about the created feopolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateFeopolicy -name <string>
        An example how to update feopolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateFeopolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feopolicy/
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

        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateFeopolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("feopolicy", "Update Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type feopolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetFeopolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateFeopolicy: Finished"
    }
}

function Invoke-NSUnsetFeopolicy {
    <#
    .SYNOPSIS
        Unset Front end optimization configuration. The system's feature to optimize Web content for performance. config Object.
    .DESCRIPTION
        Configuration for Front end optimization policy resource.
    .PARAMETER Name 
        The name of the front end optimization policy. 
    .PARAMETER Rule 
        The rule associated with the front end optimization policy. 
    .PARAMETER Action 
        The front end optimization action that has to be performed when the rule matches.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetFeopolicy -name <string>
        An example how to unset feopolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetFeopolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feopolicy
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

        [Boolean]$rule,

        [Boolean]$action 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetFeopolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Front end optimization configuration. The system's feature to optimize Web content for performance. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type feopolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetFeopolicy: Finished"
    }
}

function Invoke-NSGetFeopolicy {
    <#
    .SYNOPSIS
        Get Front end optimization configuration. The system's feature to optimize Web content for performance. config object(s).
    .DESCRIPTION
        Configuration for Front end optimization policy resource.
    .PARAMETER Name 
        The name of the front end optimization policy. 
    .PARAMETER GetAll 
        Retrieve all feopolicy object(s).
    .PARAMETER Count
        If specified, the count of the feopolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeopolicy -GetAll 
        Get all feopolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeopolicy -Count 
        Get the number of feopolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicy -name <string>
        Get feopolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicy -Filter @{ 'name'='<value>' }
        Get feopolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetFeopolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feopolicy/
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
        Write-Verbose "Invoke-NSGetFeopolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all feopolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feopolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feopolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feopolicy configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feopolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetFeopolicy: Ended"
    }
}

function Invoke-NSGetFeopolicyBinding {
    <#
    .SYNOPSIS
        Get Front end optimization configuration. The system's feature to optimize Web content for performance. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to feopolicy.
    .PARAMETER Name 
        The name of the front end optimization policy. 
    .PARAMETER GetAll 
        Retrieve all feopolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the feopolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeopolicyBinding -GetAll 
        Get all feopolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyBinding -name <string>
        Get feopolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyBinding -Filter @{ 'name'='<value>' }
        Get feopolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetFeopolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feopolicy_binding/
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
        Write-Verbose "Invoke-NSGetFeopolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all feopolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feopolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feopolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feopolicy_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feopolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetFeopolicyBinding: Ended"
    }
}

function Invoke-NSGetFeopolicyCsvserverBinding {
    <#
    .SYNOPSIS
        Get Front end optimization configuration. The system's feature to optimize Web content for performance. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to feopolicy.
    .PARAMETER Name 
        The name of the front end optimization policy. 
    .PARAMETER GetAll 
        Retrieve all feopolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the feopolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeopolicyCsvserverBinding -GetAll 
        Get all feopolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeopolicyCsvserverBinding -Count 
        Get the number of feopolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyCsvserverBinding -name <string>
        Get feopolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyCsvserverBinding -Filter @{ 'name'='<value>' }
        Get feopolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetFeopolicyCsvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feopolicy_csvserver_binding/
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
        Write-Verbose "Invoke-NSGetFeopolicyCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all feopolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feopolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feopolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feopolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feopolicy_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetFeopolicyCsvserverBinding: Ended"
    }
}

function Invoke-NSGetFeopolicyFeoglobalBinding {
    <#
    .SYNOPSIS
        Get Front end optimization configuration. The system's feature to optimize Web content for performance. config object(s).
    .DESCRIPTION
        Binding object showing the feoglobal that can be bound to feopolicy.
    .PARAMETER Name 
        The name of the front end optimization policy. 
    .PARAMETER GetAll 
        Retrieve all feopolicy_feoglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the feopolicy_feoglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyFeoglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeopolicyFeoglobalBinding -GetAll 
        Get all feopolicy_feoglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeopolicyFeoglobalBinding -Count 
        Get the number of feopolicy_feoglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyFeoglobalBinding -name <string>
        Get feopolicy_feoglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyFeoglobalBinding -Filter @{ 'name'='<value>' }
        Get feopolicy_feoglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetFeopolicyFeoglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feopolicy_feoglobal_binding/
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
        Write-Verbose "Invoke-NSGetFeopolicyFeoglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all feopolicy_feoglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_feoglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feopolicy_feoglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_feoglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feopolicy_feoglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_feoglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feopolicy_feoglobal_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_feoglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feopolicy_feoglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_feoglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetFeopolicyFeoglobalBinding: Ended"
    }
}

function Invoke-NSGetFeopolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get Front end optimization configuration. The system's feature to optimize Web content for performance. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to feopolicy.
    .PARAMETER Name 
        The name of the front end optimization policy. 
    .PARAMETER GetAll 
        Retrieve all feopolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the feopolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeopolicyLbvserverBinding -GetAll 
        Get all feopolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetFeopolicyLbvserverBinding -Count 
        Get the number of feopolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyLbvserverBinding -name <string>
        Get feopolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetFeopolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get feopolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetFeopolicyLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/feo/feopolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetFeopolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all feopolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feopolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feopolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feopolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feopolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type feopolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetFeopolicyLbvserverBinding: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBTcnHITG87lTF5
# 6TWMMmyAyvUUUjyLYfZ4Dt1s3Htl/KCCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQgWNeYHsPdTTe84degcfdCyC4w7tswMMupPJN2Nugac9owDQYJ
# KoZIhvcNAQEBBQAEggEAYxWNiYYH1ui7+Cu2hmlWGo0IhQe8jf8ANh0pXPk7MuDw
# SL/3KvUcCsIGtbL869OFkWDNuEd6a9fBDXFunQfih6CW9occUrCltyy2aO3cKmlA
# uSKqe2FUFmfOEMjQCTleLpnqUhv1NQD3Ls3yp8U0Jz0Yx321CQxrWhGVfnXWHU1g
# qra366m3ei29dXxHLerPuMTvtXRgVGGBJlP2raWSB0bISB9A9kp5ev5pPGsbVkJJ
# jDmilXeqrlwUDbqbIA1c6yBnDQiXWyUuKzdG+CT7r99+0QkVHBkxzfHUPzgl/Xjp
# 9osfMOc9hQrO95OzEI3dltj1p3/6yh/xNA54eSd4FKGCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQyMjVaMD8GCSqG
# SIb3DQEJBDEyBDD2rQE/LDxYzEVjIcItRJURv6JwZzHc1s+5xCXOip92+anAoOzt
# 3PFdUC+/9rBqmNswDQYJKoZIhvcNAQEBBQAEggIADQ9pMyHgSGuovYF0odnIpu+G
# EwY8jwFzWHPO4Q5AADUAj3a0DYYnktKoHgtHtfsW9QIdopgt/dSHaM9eB/uzIpt9
# OCoApAnaAjylSabEjDDed4mDjpt96ywKdHm6Gnw45ijiowmF9J79s0OY66hhIuaN
# UUoGgWqivaRcvwEjBChlpP/SoeUTGSKKb4T7lEjGZ+MK9VrRjhfF3Yuar5ilG8wC
# F9bGLsguWVgwdOWnTXRoy3qZFdxQ2OHwWjC+OzkQvHuE4qF8nTnZ8s+o9xsL8Vqr
# dE7L/tmlXPQUWwtrhCK8ZtQ1OzHA6rIi5ZRiryyxmgGU4ortOkPuUH8LkRsA8MIJ
# 6840wv8nJTBY7fB8AeBSM12qavvEhyqRj+ce4irwGf+DI4qO7Cxj4NyCpRAN1i6q
# abJ4J6uwdW2/LhPZ6t6pTyd8C3cb6qDNrjOCoF8mucaRYfK7RlWa+D3g3H1kMSKD
# YA7JUOQFdAGkYfYwfzmM64crT26xFknoxZX6+PaUF78hTuzBqF4WKlfl8gsOG2Gj
# d5PkEMWlcnbLZSv6oqWxxri/bE7uwaD0rZGZWhH0vp5LeTQSPGUeWYhXS9TQQTe2
# 5nG7K8eafrPPE9SI8edvKYuu9yc6Wy3VZWX1WwRmEfLAXdyYCEYm0XgJTdvW5G3t
# yHw09VxPwxJtbnAu9fc=
# SIG # End signature block
