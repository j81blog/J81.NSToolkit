function Invoke-NSAddCachecontentgroup {
    <#
    .SYNOPSIS
        Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache content group resource.
    .PARAMETER Name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created. 
    .PARAMETER Weakposrelexpiry 
        Relative expiry time, in seconds, for expiring positive responses with response codes between 200 and 399. Cannot be used in combination with other Expiry attributes. Similar to -relExpiry but has lower precedence. 
         
        Maximum value = 31536000 
    .PARAMETER Heurexpiryparam 
        Heuristic expiry time, in percent of the duration, since the object was last modified. 
         
        Maximum value = 100 
    .PARAMETER Relexpiry 
        Relative expiry time, in seconds, after which to expire an object cached in this content group. 
         
        Maximum value = 31536000 
    .PARAMETER Relexpirymillisec 
        Relative expiry time, in milliseconds, after which to expire an object cached in this content group. 
         
        Maximum value = 86400000 
    .PARAMETER Absexpiry 
        Local time, up to 4 times a day, at which all objects in the content group must expire. 
         
        CLI Users: 
        For example, to specify that the objects in the content group should expire by 11:00 PM, type the following command: add cache contentgroup &lt;contentgroup name&gt; -absexpiry 23:00 
        To specify that the objects in the content group should expire at 10:00 AM, 3 PM, 6 PM, and 11:00 PM, type: add cache contentgroup &lt;contentgroup name&gt; -absexpiry 10:00 15:00 18:00 23:00. 
    .PARAMETER Absexpirygmt 
        Coordinated Universal Time (GMT), up to 4 times a day, when all objects in the content group must expire. 
    .PARAMETER Weaknegrelexpiry 
        Relative expiry time, in seconds, for expiring negative responses. This value is used only if the expiry time cannot be determined from any other source. It is applicable only to the following status codes: 307, 403, 404, and 410. 
         
        Maximum value = 31536000 
    .PARAMETER Hitparams 
        Parameters to use for parameterized hit evaluation of an object. Up to 128 parameters can be specified. Mutually exclusive with the Hit Selector parameter. 
    .PARAMETER Invalparams 
        Parameters for parameterized invalidation of an object. You can specify up to 8 parameters. Mutually exclusive with invalSelector. 
    .PARAMETER Ignoreparamvaluecase 
        Ignore case when comparing parameter values during parameterized hit evaluation. (Parameter value case is ignored by default during parameterized invalidation.). 
        Possible values = YES, NO 
    .PARAMETER Matchcookies 
        Evaluate for parameters in the cookie header also. 
        Possible values = YES, NO 
    .PARAMETER Invalrestrictedtohost 
        Take the host header into account during parameterized invalidation. 
        Possible values = YES, NO 
    .PARAMETER Polleverytime 
        Always poll for the objects in this content group. That is, retrieve the objects from the origin server whenever they are requested. 
         
        Possible values = YES, NO 
    .PARAMETER Ignorereloadreq 
        Ignore any request to reload a cached object from the origin server. 
        To guard against Denial of Service attacks, set this parameter to YES. For RFC-compliant behavior, set it to NO. 
         
        Possible values = YES, NO 
    .PARAMETER Removecookies 
        Remove cookies from responses. 
         
        Possible values = YES, NO 
    .PARAMETER Prefetch 
        Attempt to refresh objects that are about to go stale. 
         
        Possible values = YES, NO 
    .PARAMETER Prefetchperiod 
        Time period, in seconds before an object's calculated expiry time, during which to attempt prefetch. 
         
        Maximum value = 4294967294 
    .PARAMETER Prefetchperiodmillisec 
        Time period, in milliseconds before an object's calculated expiry time, during which to attempt prefetch. 
         
        Maximum value = 4294967290 
    .PARAMETER Prefetchmaxpending 
        Maximum number of outstanding prefetches that can be queued for the content group. 
         
        Maximum value = 4294967294 
    .PARAMETER Flashcache 
        Perform flash cache. Mutually exclusive with Poll Every Time (PET) on the same content group. 
         
        Possible values = YES, NO 
    .PARAMETER Expireatlastbyte 
        Force expiration of the content immediately after the response is downloaded (upon receipt of the last byte of the response body). Applicable only to positive responses. 
         
        Possible values = YES, NO 
    .PARAMETER Insertvia 
        Insert a Via header into the response. 
         
        Possible values = YES, NO 
    .PARAMETER Insertage 
        Insert an Age header into the response. An Age header contains information about the age of the object, in seconds, as calculated by the integrated cache. 
         
        Possible values = YES, NO 
    .PARAMETER Insertetag 
        Insert an ETag header in the response. With ETag header insertion, the integrated cache does not serve full responses on repeat requests. 
         
        Possible values = YES, NO 
    .PARAMETER Cachecontrol 
        Insert a Cache-Control header into the response. 
    .PARAMETER Quickabortsize 
        If the size of an object that is being downloaded is less than or equal to the quick abort value, and a client aborts during the download, the cache stops downloading the response. If the object is larger than the quick abort size, the cache continues to download the response. 
         
         
        Maximum value = 4194303 
    .PARAMETER Minressize 
        Minimum size of a response that can be cached in this content group. 
        Default minimum response size is 0. 
         
        Maximum value = 2097151 
    .PARAMETER Maxressize 
        Maximum size of a response that can be cached in this content group. 
         
         
        Maximum value = 2097151 
    .PARAMETER Memlimit 
        Maximum amount of memory that the cache can use. The effective limit is based on the available memory of the Citrix ADC. 
    .PARAMETER Ignorereqcachinghdrs 
        Ignore Cache-Control and Pragma headers in the incoming request. 
         
        Possible values = YES, NO 
    .PARAMETER Minhits 
        Number of hits that qualifies a response for storage in this content group. 
    .PARAMETER Alwaysevalpolicies 
        Force policy evaluation for each response arriving from the origin server. Cannot be set to YES if the Prefetch parameter is also set to YES. 
         
        Possible values = YES, NO 
    .PARAMETER Persistha 
        Setting persistHA to YES causes IC to save objects in contentgroup to Secondary node in HA deployment. 
         
        Possible values = YES, NO 
    .PARAMETER Pinned 
        Do not flush objects from this content group under memory pressure. 
         
        Possible values = YES, NO 
    .PARAMETER Lazydnsresolve 
        Perform DNS resolution for responses only if the destination IP address in the request does not match the destination IP address of the cached response. 
         
        Possible values = YES, NO 
    .PARAMETER Hitselector 
        Selector for evaluating whether an object gets stored in a particular content group. A selector is an abstraction for a collection of PIXL expressions. 
    .PARAMETER Invalselector 
        Selector for invalidating objects in the content group. A selector is an abstraction for a collection of PIXL expressions. 
    .PARAMETER Type 
        The type of the content group. 
         
        Possible values = HTTP, MYSQL, MSSQL 
    .PARAMETER PassThru 
        Return details about the created cachecontentgroup item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCachecontentgroup -name <string>
        An example how to add cachecontentgroup config Object(s).
    .NOTES
        File Name : Invoke-NSAddCachecontentgroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachecontentgroup/
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

        [double]$Weakposrelexpiry,

        [double]$Heurexpiryparam,

        [double]$Relexpiry,

        [double]$Relexpirymillisec,

        [string[]]$Absexpiry,

        [string[]]$Absexpirygmt,

        [double]$Weaknegrelexpiry,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Hitparams,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Invalparams,

        [ValidateSet('YES', 'NO')]
        [string]$Ignoreparamvaluecase,

        [ValidateSet('YES', 'NO')]
        [string]$Matchcookies,

        [ValidateSet('YES', 'NO')]
        [string]$Invalrestrictedtohost,

        [ValidateSet('YES', 'NO')]
        [string]$Polleverytime = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Ignorereloadreq = 'YES',

        [ValidateSet('YES', 'NO')]
        [string]$Removecookies = 'YES',

        [ValidateSet('YES', 'NO')]
        [string]$Prefetch = 'YES',

        [double]$Prefetchperiod,

        [double]$Prefetchperiodmillisec,

        [double]$Prefetchmaxpending,

        [ValidateSet('YES', 'NO')]
        [string]$Flashcache = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Expireatlastbyte = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Insertvia = 'YES',

        [ValidateSet('YES', 'NO')]
        [string]$Insertage = 'YES',

        [ValidateSet('YES', 'NO')]
        [string]$Insertetag = 'YES',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cachecontrol,

        [double]$Quickabortsize = '4194303',

        [double]$Minressize,

        [double]$Maxressize = '80',

        [double]$Memlimit = '65536',

        [ValidateSet('YES', 'NO')]
        [string]$Ignorereqcachinghdrs = 'YES',

        [int]$Minhits = '0',

        [ValidateSet('YES', 'NO')]
        [string]$Alwaysevalpolicies = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Persistha = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Pinned = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Lazydnsresolve = 'YES',

        [string]$Hitselector,

        [string]$Invalselector,

        [ValidateSet('HTTP', 'MYSQL', 'MSSQL')]
        [string]$Type = 'HTTP',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCachecontentgroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('weakposrelexpiry') ) { $payload.Add('weakposrelexpiry', $weakposrelexpiry) }
            if ( $PSBoundParameters.ContainsKey('heurexpiryparam') ) { $payload.Add('heurexpiryparam', $heurexpiryparam) }
            if ( $PSBoundParameters.ContainsKey('relexpiry') ) { $payload.Add('relexpiry', $relexpiry) }
            if ( $PSBoundParameters.ContainsKey('relexpirymillisec') ) { $payload.Add('relexpirymillisec', $relexpirymillisec) }
            if ( $PSBoundParameters.ContainsKey('absexpiry') ) { $payload.Add('absexpiry', $absexpiry) }
            if ( $PSBoundParameters.ContainsKey('absexpirygmt') ) { $payload.Add('absexpirygmt', $absexpirygmt) }
            if ( $PSBoundParameters.ContainsKey('weaknegrelexpiry') ) { $payload.Add('weaknegrelexpiry', $weaknegrelexpiry) }
            if ( $PSBoundParameters.ContainsKey('hitparams') ) { $payload.Add('hitparams', $hitparams) }
            if ( $PSBoundParameters.ContainsKey('invalparams') ) { $payload.Add('invalparams', $invalparams) }
            if ( $PSBoundParameters.ContainsKey('ignoreparamvaluecase') ) { $payload.Add('ignoreparamvaluecase', $ignoreparamvaluecase) }
            if ( $PSBoundParameters.ContainsKey('matchcookies') ) { $payload.Add('matchcookies', $matchcookies) }
            if ( $PSBoundParameters.ContainsKey('invalrestrictedtohost') ) { $payload.Add('invalrestrictedtohost', $invalrestrictedtohost) }
            if ( $PSBoundParameters.ContainsKey('polleverytime') ) { $payload.Add('polleverytime', $polleverytime) }
            if ( $PSBoundParameters.ContainsKey('ignorereloadreq') ) { $payload.Add('ignorereloadreq', $ignorereloadreq) }
            if ( $PSBoundParameters.ContainsKey('removecookies') ) { $payload.Add('removecookies', $removecookies) }
            if ( $PSBoundParameters.ContainsKey('prefetch') ) { $payload.Add('prefetch', $prefetch) }
            if ( $PSBoundParameters.ContainsKey('prefetchperiod') ) { $payload.Add('prefetchperiod', $prefetchperiod) }
            if ( $PSBoundParameters.ContainsKey('prefetchperiodmillisec') ) { $payload.Add('prefetchperiodmillisec', $prefetchperiodmillisec) }
            if ( $PSBoundParameters.ContainsKey('prefetchmaxpending') ) { $payload.Add('prefetchmaxpending', $prefetchmaxpending) }
            if ( $PSBoundParameters.ContainsKey('flashcache') ) { $payload.Add('flashcache', $flashcache) }
            if ( $PSBoundParameters.ContainsKey('expireatlastbyte') ) { $payload.Add('expireatlastbyte', $expireatlastbyte) }
            if ( $PSBoundParameters.ContainsKey('insertvia') ) { $payload.Add('insertvia', $insertvia) }
            if ( $PSBoundParameters.ContainsKey('insertage') ) { $payload.Add('insertage', $insertage) }
            if ( $PSBoundParameters.ContainsKey('insertetag') ) { $payload.Add('insertetag', $insertetag) }
            if ( $PSBoundParameters.ContainsKey('cachecontrol') ) { $payload.Add('cachecontrol', $cachecontrol) }
            if ( $PSBoundParameters.ContainsKey('quickabortsize') ) { $payload.Add('quickabortsize', $quickabortsize) }
            if ( $PSBoundParameters.ContainsKey('minressize') ) { $payload.Add('minressize', $minressize) }
            if ( $PSBoundParameters.ContainsKey('maxressize') ) { $payload.Add('maxressize', $maxressize) }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSBoundParameters.ContainsKey('ignorereqcachinghdrs') ) { $payload.Add('ignorereqcachinghdrs', $ignorereqcachinghdrs) }
            if ( $PSBoundParameters.ContainsKey('minhits') ) { $payload.Add('minhits', $minhits) }
            if ( $PSBoundParameters.ContainsKey('alwaysevalpolicies') ) { $payload.Add('alwaysevalpolicies', $alwaysevalpolicies) }
            if ( $PSBoundParameters.ContainsKey('persistha') ) { $payload.Add('persistha', $persistha) }
            if ( $PSBoundParameters.ContainsKey('pinned') ) { $payload.Add('pinned', $pinned) }
            if ( $PSBoundParameters.ContainsKey('lazydnsresolve') ) { $payload.Add('lazydnsresolve', $lazydnsresolve) }
            if ( $PSBoundParameters.ContainsKey('hitselector') ) { $payload.Add('hitselector', $hitselector) }
            if ( $PSBoundParameters.ContainsKey('invalselector') ) { $payload.Add('invalselector', $invalselector) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess("cachecontentgroup", "Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cachecontentgroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCachecontentgroup -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCachecontentgroup: Finished"
    }
}

function Invoke-NSDeleteCachecontentgroup {
    <#
    .SYNOPSIS
        Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache content group resource.
    .PARAMETER Name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCachecontentgroup -Name <string>
        An example how to delete cachecontentgroup config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCachecontentgroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachecontentgroup/
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
        Write-Verbose "Invoke-NSDeleteCachecontentgroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cachecontentgroup -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCachecontentgroup: Finished"
    }
}

function Invoke-NSUpdateCachecontentgroup {
    <#
    .SYNOPSIS
        Update Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache content group resource.
    .PARAMETER Name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created. 
    .PARAMETER Weakposrelexpiry 
        Relative expiry time, in seconds, for expiring positive responses with response codes between 200 and 399. Cannot be used in combination with other Expiry attributes. Similar to -relExpiry but has lower precedence. 
         
        Maximum value = 31536000 
    .PARAMETER Heurexpiryparam 
        Heuristic expiry time, in percent of the duration, since the object was last modified. 
         
        Maximum value = 100 
    .PARAMETER Relexpiry 
        Relative expiry time, in seconds, after which to expire an object cached in this content group. 
         
        Maximum value = 31536000 
    .PARAMETER Relexpirymillisec 
        Relative expiry time, in milliseconds, after which to expire an object cached in this content group. 
         
        Maximum value = 86400000 
    .PARAMETER Absexpiry 
        Local time, up to 4 times a day, at which all objects in the content group must expire. 
         
        CLI Users: 
        For example, to specify that the objects in the content group should expire by 11:00 PM, type the following command: add cache contentgroup &lt;contentgroup name&gt; -absexpiry 23:00 
        To specify that the objects in the content group should expire at 10:00 AM, 3 PM, 6 PM, and 11:00 PM, type: add cache contentgroup &lt;contentgroup name&gt; -absexpiry 10:00 15:00 18:00 23:00. 
    .PARAMETER Absexpirygmt 
        Coordinated Universal Time (GMT), up to 4 times a day, when all objects in the content group must expire. 
    .PARAMETER Weaknegrelexpiry 
        Relative expiry time, in seconds, for expiring negative responses. This value is used only if the expiry time cannot be determined from any other source. It is applicable only to the following status codes: 307, 403, 404, and 410. 
         
        Maximum value = 31536000 
    .PARAMETER Hitparams 
        Parameters to use for parameterized hit evaluation of an object. Up to 128 parameters can be specified. Mutually exclusive with the Hit Selector parameter. 
    .PARAMETER Invalparams 
        Parameters for parameterized invalidation of an object. You can specify up to 8 parameters. Mutually exclusive with invalSelector. 
    .PARAMETER Ignoreparamvaluecase 
        Ignore case when comparing parameter values during parameterized hit evaluation. (Parameter value case is ignored by default during parameterized invalidation.). 
        Possible values = YES, NO 
    .PARAMETER Matchcookies 
        Evaluate for parameters in the cookie header also. 
        Possible values = YES, NO 
    .PARAMETER Invalrestrictedtohost 
        Take the host header into account during parameterized invalidation. 
        Possible values = YES, NO 
    .PARAMETER Polleverytime 
        Always poll for the objects in this content group. That is, retrieve the objects from the origin server whenever they are requested. 
         
        Possible values = YES, NO 
    .PARAMETER Ignorereloadreq 
        Ignore any request to reload a cached object from the origin server. 
        To guard against Denial of Service attacks, set this parameter to YES. For RFC-compliant behavior, set it to NO. 
         
        Possible values = YES, NO 
    .PARAMETER Removecookies 
        Remove cookies from responses. 
         
        Possible values = YES, NO 
    .PARAMETER Prefetch 
        Attempt to refresh objects that are about to go stale. 
         
        Possible values = YES, NO 
    .PARAMETER Prefetchperiod 
        Time period, in seconds before an object's calculated expiry time, during which to attempt prefetch. 
         
        Maximum value = 4294967294 
    .PARAMETER Prefetchperiodmillisec 
        Time period, in milliseconds before an object's calculated expiry time, during which to attempt prefetch. 
         
        Maximum value = 4294967290 
    .PARAMETER Prefetchmaxpending 
        Maximum number of outstanding prefetches that can be queued for the content group. 
         
        Maximum value = 4294967294 
    .PARAMETER Flashcache 
        Perform flash cache. Mutually exclusive with Poll Every Time (PET) on the same content group. 
         
        Possible values = YES, NO 
    .PARAMETER Expireatlastbyte 
        Force expiration of the content immediately after the response is downloaded (upon receipt of the last byte of the response body). Applicable only to positive responses. 
         
        Possible values = YES, NO 
    .PARAMETER Insertvia 
        Insert a Via header into the response. 
         
        Possible values = YES, NO 
    .PARAMETER Insertage 
        Insert an Age header into the response. An Age header contains information about the age of the object, in seconds, as calculated by the integrated cache. 
         
        Possible values = YES, NO 
    .PARAMETER Insertetag 
        Insert an ETag header in the response. With ETag header insertion, the integrated cache does not serve full responses on repeat requests. 
         
        Possible values = YES, NO 
    .PARAMETER Cachecontrol 
        Insert a Cache-Control header into the response. 
    .PARAMETER Quickabortsize 
        If the size of an object that is being downloaded is less than or equal to the quick abort value, and a client aborts during the download, the cache stops downloading the response. If the object is larger than the quick abort size, the cache continues to download the response. 
         
         
        Maximum value = 4194303 
    .PARAMETER Minressize 
        Minimum size of a response that can be cached in this content group. 
        Default minimum response size is 0. 
         
        Maximum value = 2097151 
    .PARAMETER Maxressize 
        Maximum size of a response that can be cached in this content group. 
         
         
        Maximum value = 2097151 
    .PARAMETER Memlimit 
        Maximum amount of memory that the cache can use. The effective limit is based on the available memory of the Citrix ADC. 
    .PARAMETER Ignorereqcachinghdrs 
        Ignore Cache-Control and Pragma headers in the incoming request. 
         
        Possible values = YES, NO 
    .PARAMETER Minhits 
        Number of hits that qualifies a response for storage in this content group. 
    .PARAMETER Alwaysevalpolicies 
        Force policy evaluation for each response arriving from the origin server. Cannot be set to YES if the Prefetch parameter is also set to YES. 
         
        Possible values = YES, NO 
    .PARAMETER Persistha 
        Setting persistHA to YES causes IC to save objects in contentgroup to Secondary node in HA deployment. 
         
        Possible values = YES, NO 
    .PARAMETER Pinned 
        Do not flush objects from this content group under memory pressure. 
         
        Possible values = YES, NO 
    .PARAMETER Lazydnsresolve 
        Perform DNS resolution for responses only if the destination IP address in the request does not match the destination IP address of the cached response. 
         
        Possible values = YES, NO 
    .PARAMETER Hitselector 
        Selector for evaluating whether an object gets stored in a particular content group. A selector is an abstraction for a collection of PIXL expressions. 
    .PARAMETER Invalselector 
        Selector for invalidating objects in the content group. A selector is an abstraction for a collection of PIXL expressions. 
    .PARAMETER PassThru 
        Return details about the created cachecontentgroup item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCachecontentgroup -name <string>
        An example how to update cachecontentgroup config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCachecontentgroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachecontentgroup/
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

        [double]$Weakposrelexpiry,

        [double]$Heurexpiryparam,

        [double]$Relexpiry,

        [double]$Relexpirymillisec,

        [string[]]$Absexpiry,

        [string[]]$Absexpirygmt,

        [double]$Weaknegrelexpiry,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Hitparams,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Invalparams,

        [ValidateSet('YES', 'NO')]
        [string]$Ignoreparamvaluecase,

        [ValidateSet('YES', 'NO')]
        [string]$Matchcookies,

        [ValidateSet('YES', 'NO')]
        [string]$Invalrestrictedtohost,

        [ValidateSet('YES', 'NO')]
        [string]$Polleverytime,

        [ValidateSet('YES', 'NO')]
        [string]$Ignorereloadreq,

        [ValidateSet('YES', 'NO')]
        [string]$Removecookies,

        [ValidateSet('YES', 'NO')]
        [string]$Prefetch,

        [double]$Prefetchperiod,

        [double]$Prefetchperiodmillisec,

        [double]$Prefetchmaxpending,

        [ValidateSet('YES', 'NO')]
        [string]$Flashcache,

        [ValidateSet('YES', 'NO')]
        [string]$Expireatlastbyte,

        [ValidateSet('YES', 'NO')]
        [string]$Insertvia,

        [ValidateSet('YES', 'NO')]
        [string]$Insertage,

        [ValidateSet('YES', 'NO')]
        [string]$Insertetag,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cachecontrol,

        [double]$Quickabortsize,

        [double]$Minressize,

        [double]$Maxressize,

        [double]$Memlimit,

        [ValidateSet('YES', 'NO')]
        [string]$Ignorereqcachinghdrs,

        [int]$Minhits,

        [ValidateSet('YES', 'NO')]
        [string]$Alwaysevalpolicies,

        [ValidateSet('YES', 'NO')]
        [string]$Persistha,

        [ValidateSet('YES', 'NO')]
        [string]$Pinned,

        [ValidateSet('YES', 'NO')]
        [string]$Lazydnsresolve,

        [string]$Hitselector,

        [string]$Invalselector,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCachecontentgroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('weakposrelexpiry') ) { $payload.Add('weakposrelexpiry', $weakposrelexpiry) }
            if ( $PSBoundParameters.ContainsKey('heurexpiryparam') ) { $payload.Add('heurexpiryparam', $heurexpiryparam) }
            if ( $PSBoundParameters.ContainsKey('relexpiry') ) { $payload.Add('relexpiry', $relexpiry) }
            if ( $PSBoundParameters.ContainsKey('relexpirymillisec') ) { $payload.Add('relexpirymillisec', $relexpirymillisec) }
            if ( $PSBoundParameters.ContainsKey('absexpiry') ) { $payload.Add('absexpiry', $absexpiry) }
            if ( $PSBoundParameters.ContainsKey('absexpirygmt') ) { $payload.Add('absexpirygmt', $absexpirygmt) }
            if ( $PSBoundParameters.ContainsKey('weaknegrelexpiry') ) { $payload.Add('weaknegrelexpiry', $weaknegrelexpiry) }
            if ( $PSBoundParameters.ContainsKey('hitparams') ) { $payload.Add('hitparams', $hitparams) }
            if ( $PSBoundParameters.ContainsKey('invalparams') ) { $payload.Add('invalparams', $invalparams) }
            if ( $PSBoundParameters.ContainsKey('ignoreparamvaluecase') ) { $payload.Add('ignoreparamvaluecase', $ignoreparamvaluecase) }
            if ( $PSBoundParameters.ContainsKey('matchcookies') ) { $payload.Add('matchcookies', $matchcookies) }
            if ( $PSBoundParameters.ContainsKey('invalrestrictedtohost') ) { $payload.Add('invalrestrictedtohost', $invalrestrictedtohost) }
            if ( $PSBoundParameters.ContainsKey('polleverytime') ) { $payload.Add('polleverytime', $polleverytime) }
            if ( $PSBoundParameters.ContainsKey('ignorereloadreq') ) { $payload.Add('ignorereloadreq', $ignorereloadreq) }
            if ( $PSBoundParameters.ContainsKey('removecookies') ) { $payload.Add('removecookies', $removecookies) }
            if ( $PSBoundParameters.ContainsKey('prefetch') ) { $payload.Add('prefetch', $prefetch) }
            if ( $PSBoundParameters.ContainsKey('prefetchperiod') ) { $payload.Add('prefetchperiod', $prefetchperiod) }
            if ( $PSBoundParameters.ContainsKey('prefetchperiodmillisec') ) { $payload.Add('prefetchperiodmillisec', $prefetchperiodmillisec) }
            if ( $PSBoundParameters.ContainsKey('prefetchmaxpending') ) { $payload.Add('prefetchmaxpending', $prefetchmaxpending) }
            if ( $PSBoundParameters.ContainsKey('flashcache') ) { $payload.Add('flashcache', $flashcache) }
            if ( $PSBoundParameters.ContainsKey('expireatlastbyte') ) { $payload.Add('expireatlastbyte', $expireatlastbyte) }
            if ( $PSBoundParameters.ContainsKey('insertvia') ) { $payload.Add('insertvia', $insertvia) }
            if ( $PSBoundParameters.ContainsKey('insertage') ) { $payload.Add('insertage', $insertage) }
            if ( $PSBoundParameters.ContainsKey('insertetag') ) { $payload.Add('insertetag', $insertetag) }
            if ( $PSBoundParameters.ContainsKey('cachecontrol') ) { $payload.Add('cachecontrol', $cachecontrol) }
            if ( $PSBoundParameters.ContainsKey('quickabortsize') ) { $payload.Add('quickabortsize', $quickabortsize) }
            if ( $PSBoundParameters.ContainsKey('minressize') ) { $payload.Add('minressize', $minressize) }
            if ( $PSBoundParameters.ContainsKey('maxressize') ) { $payload.Add('maxressize', $maxressize) }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSBoundParameters.ContainsKey('ignorereqcachinghdrs') ) { $payload.Add('ignorereqcachinghdrs', $ignorereqcachinghdrs) }
            if ( $PSBoundParameters.ContainsKey('minhits') ) { $payload.Add('minhits', $minhits) }
            if ( $PSBoundParameters.ContainsKey('alwaysevalpolicies') ) { $payload.Add('alwaysevalpolicies', $alwaysevalpolicies) }
            if ( $PSBoundParameters.ContainsKey('persistha') ) { $payload.Add('persistha', $persistha) }
            if ( $PSBoundParameters.ContainsKey('pinned') ) { $payload.Add('pinned', $pinned) }
            if ( $PSBoundParameters.ContainsKey('lazydnsresolve') ) { $payload.Add('lazydnsresolve', $lazydnsresolve) }
            if ( $PSBoundParameters.ContainsKey('hitselector') ) { $payload.Add('hitselector', $hitselector) }
            if ( $PSBoundParameters.ContainsKey('invalselector') ) { $payload.Add('invalselector', $invalselector) }
            if ( $PSCmdlet.ShouldProcess("cachecontentgroup", "Update Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cachecontentgroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCachecontentgroup -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCachecontentgroup: Finished"
    }
}

function Invoke-NSUnsetCachecontentgroup {
    <#
    .SYNOPSIS
        Unset Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache content group resource.
    .PARAMETER Name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created. 
    .PARAMETER Weakposrelexpiry 
        Relative expiry time, in seconds, for expiring positive responses with response codes between 200 and 399. Cannot be used in combination with other Expiry attributes. Similar to -relExpiry but has lower precedence. 
         
        Maximum value = 31536000 
    .PARAMETER Heurexpiryparam 
        Heuristic expiry time, in percent of the duration, since the object was last modified. 
         
        Maximum value = 100 
    .PARAMETER Relexpiry 
        Relative expiry time, in seconds, after which to expire an object cached in this content group. 
         
        Maximum value = 31536000 
    .PARAMETER Relexpirymillisec 
        Relative expiry time, in milliseconds, after which to expire an object cached in this content group. 
         
        Maximum value = 86400000 
    .PARAMETER Absexpiry 
        Local time, up to 4 times a day, at which all objects in the content group must expire. 
         
        CLI Users: 
        For example, to specify that the objects in the content group should expire by 11:00 PM, type the following command: add cache contentgroup &lt;contentgroup name&gt; -absexpiry 23:00 
        To specify that the objects in the content group should expire at 10:00 AM, 3 PM, 6 PM, and 11:00 PM, type: add cache contentgroup &lt;contentgroup name&gt; -absexpiry 10:00 15:00 18:00 23:00. 
    .PARAMETER Absexpirygmt 
        Coordinated Universal Time (GMT), up to 4 times a day, when all objects in the content group must expire. 
    .PARAMETER Weaknegrelexpiry 
        Relative expiry time, in seconds, for expiring negative responses. This value is used only if the expiry time cannot be determined from any other source. It is applicable only to the following status codes: 307, 403, 404, and 410. 
         
        Maximum value = 31536000 
    .PARAMETER Hitparams 
        Parameters to use for parameterized hit evaluation of an object. Up to 128 parameters can be specified. Mutually exclusive with the Hit Selector parameter. 
    .PARAMETER Invalparams 
        Parameters for parameterized invalidation of an object. You can specify up to 8 parameters. Mutually exclusive with invalSelector. 
    .PARAMETER Ignoreparamvaluecase 
        Ignore case when comparing parameter values during parameterized hit evaluation. (Parameter value case is ignored by default during parameterized invalidation.). 
        Possible values = YES, NO 
    .PARAMETER Matchcookies 
        Evaluate for parameters in the cookie header also. 
        Possible values = YES, NO 
    .PARAMETER Invalrestrictedtohost 
        Take the host header into account during parameterized invalidation. 
        Possible values = YES, NO 
    .PARAMETER Polleverytime 
        Always poll for the objects in this content group. That is, retrieve the objects from the origin server whenever they are requested. 
         
        Possible values = YES, NO 
    .PARAMETER Ignorereloadreq 
        Ignore any request to reload a cached object from the origin server. 
        To guard against Denial of Service attacks, set this parameter to YES. For RFC-compliant behavior, set it to NO. 
         
        Possible values = YES, NO 
    .PARAMETER Removecookies 
        Remove cookies from responses. 
         
        Possible values = YES, NO 
    .PARAMETER Prefetch 
        Attempt to refresh objects that are about to go stale. 
         
        Possible values = YES, NO 
    .PARAMETER Prefetchperiod 
        Time period, in seconds before an object's calculated expiry time, during which to attempt prefetch. 
         
        Maximum value = 4294967294 
    .PARAMETER Prefetchperiodmillisec 
        Time period, in milliseconds before an object's calculated expiry time, during which to attempt prefetch. 
         
        Maximum value = 4294967290 
    .PARAMETER Prefetchmaxpending 
        Maximum number of outstanding prefetches that can be queued for the content group. 
         
        Maximum value = 4294967294 
    .PARAMETER Flashcache 
        Perform flash cache. Mutually exclusive with Poll Every Time (PET) on the same content group. 
         
        Possible values = YES, NO 
    .PARAMETER Expireatlastbyte 
        Force expiration of the content immediately after the response is downloaded (upon receipt of the last byte of the response body). Applicable only to positive responses. 
         
        Possible values = YES, NO 
    .PARAMETER Insertvia 
        Insert a Via header into the response. 
         
        Possible values = YES, NO 
    .PARAMETER Insertage 
        Insert an Age header into the response. An Age header contains information about the age of the object, in seconds, as calculated by the integrated cache. 
         
        Possible values = YES, NO 
    .PARAMETER Insertetag 
        Insert an ETag header in the response. With ETag header insertion, the integrated cache does not serve full responses on repeat requests. 
         
        Possible values = YES, NO 
    .PARAMETER Cachecontrol 
        Insert a Cache-Control header into the response. 
    .PARAMETER Quickabortsize 
        If the size of an object that is being downloaded is less than or equal to the quick abort value, and a client aborts during the download, the cache stops downloading the response. If the object is larger than the quick abort size, the cache continues to download the response. 
         
         
        Maximum value = 4194303 
    .PARAMETER Minressize 
        Minimum size of a response that can be cached in this content group. 
        Default minimum response size is 0. 
         
        Maximum value = 2097151 
    .PARAMETER Maxressize 
        Maximum size of a response that can be cached in this content group. 
         
         
        Maximum value = 2097151 
    .PARAMETER Memlimit 
        Maximum amount of memory that the cache can use. The effective limit is based on the available memory of the Citrix ADC. 
    .PARAMETER Ignorereqcachinghdrs 
        Ignore Cache-Control and Pragma headers in the incoming request. 
         
        Possible values = YES, NO 
    .PARAMETER Minhits 
        Number of hits that qualifies a response for storage in this content group. 
    .PARAMETER Alwaysevalpolicies 
        Force policy evaluation for each response arriving from the origin server. Cannot be set to YES if the Prefetch parameter is also set to YES. 
         
        Possible values = YES, NO 
    .PARAMETER Persistha 
        Setting persistHA to YES causes IC to save objects in contentgroup to Secondary node in HA deployment. 
         
        Possible values = YES, NO 
    .PARAMETER Pinned 
        Do not flush objects from this content group under memory pressure. 
         
        Possible values = YES, NO 
    .PARAMETER Lazydnsresolve 
        Perform DNS resolution for responses only if the destination IP address in the request does not match the destination IP address of the cached response. 
         
        Possible values = YES, NO 
    .PARAMETER Hitselector 
        Selector for evaluating whether an object gets stored in a particular content group. A selector is an abstraction for a collection of PIXL expressions. 
    .PARAMETER Invalselector 
        Selector for invalidating objects in the content group. A selector is an abstraction for a collection of PIXL expressions.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCachecontentgroup -name <string>
        An example how to unset cachecontentgroup config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCachecontentgroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachecontentgroup
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

        [Boolean]$weakposrelexpiry,

        [Boolean]$heurexpiryparam,

        [Boolean]$relexpiry,

        [Boolean]$relexpirymillisec,

        [Boolean]$absexpiry,

        [Boolean]$absexpirygmt,

        [Boolean]$weaknegrelexpiry,

        [Boolean]$hitparams,

        [Boolean]$invalparams,

        [Boolean]$ignoreparamvaluecase,

        [Boolean]$matchcookies,

        [Boolean]$invalrestrictedtohost,

        [Boolean]$polleverytime,

        [Boolean]$ignorereloadreq,

        [Boolean]$removecookies,

        [Boolean]$prefetch,

        [Boolean]$prefetchperiod,

        [Boolean]$prefetchperiodmillisec,

        [Boolean]$prefetchmaxpending,

        [Boolean]$flashcache,

        [Boolean]$expireatlastbyte,

        [Boolean]$insertvia,

        [Boolean]$insertage,

        [Boolean]$insertetag,

        [Boolean]$cachecontrol,

        [Boolean]$quickabortsize,

        [Boolean]$minressize,

        [Boolean]$maxressize,

        [Boolean]$memlimit,

        [Boolean]$ignorereqcachinghdrs,

        [Boolean]$minhits,

        [Boolean]$alwaysevalpolicies,

        [Boolean]$persistha,

        [Boolean]$pinned,

        [Boolean]$lazydnsresolve,

        [Boolean]$hitselector,

        [Boolean]$invalselector 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCachecontentgroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('weakposrelexpiry') ) { $payload.Add('weakposrelexpiry', $weakposrelexpiry) }
            if ( $PSBoundParameters.ContainsKey('heurexpiryparam') ) { $payload.Add('heurexpiryparam', $heurexpiryparam) }
            if ( $PSBoundParameters.ContainsKey('relexpiry') ) { $payload.Add('relexpiry', $relexpiry) }
            if ( $PSBoundParameters.ContainsKey('relexpirymillisec') ) { $payload.Add('relexpirymillisec', $relexpirymillisec) }
            if ( $PSBoundParameters.ContainsKey('absexpiry') ) { $payload.Add('absexpiry', $absexpiry) }
            if ( $PSBoundParameters.ContainsKey('absexpirygmt') ) { $payload.Add('absexpirygmt', $absexpirygmt) }
            if ( $PSBoundParameters.ContainsKey('weaknegrelexpiry') ) { $payload.Add('weaknegrelexpiry', $weaknegrelexpiry) }
            if ( $PSBoundParameters.ContainsKey('hitparams') ) { $payload.Add('hitparams', $hitparams) }
            if ( $PSBoundParameters.ContainsKey('invalparams') ) { $payload.Add('invalparams', $invalparams) }
            if ( $PSBoundParameters.ContainsKey('ignoreparamvaluecase') ) { $payload.Add('ignoreparamvaluecase', $ignoreparamvaluecase) }
            if ( $PSBoundParameters.ContainsKey('matchcookies') ) { $payload.Add('matchcookies', $matchcookies) }
            if ( $PSBoundParameters.ContainsKey('invalrestrictedtohost') ) { $payload.Add('invalrestrictedtohost', $invalrestrictedtohost) }
            if ( $PSBoundParameters.ContainsKey('polleverytime') ) { $payload.Add('polleverytime', $polleverytime) }
            if ( $PSBoundParameters.ContainsKey('ignorereloadreq') ) { $payload.Add('ignorereloadreq', $ignorereloadreq) }
            if ( $PSBoundParameters.ContainsKey('removecookies') ) { $payload.Add('removecookies', $removecookies) }
            if ( $PSBoundParameters.ContainsKey('prefetch') ) { $payload.Add('prefetch', $prefetch) }
            if ( $PSBoundParameters.ContainsKey('prefetchperiod') ) { $payload.Add('prefetchperiod', $prefetchperiod) }
            if ( $PSBoundParameters.ContainsKey('prefetchperiodmillisec') ) { $payload.Add('prefetchperiodmillisec', $prefetchperiodmillisec) }
            if ( $PSBoundParameters.ContainsKey('prefetchmaxpending') ) { $payload.Add('prefetchmaxpending', $prefetchmaxpending) }
            if ( $PSBoundParameters.ContainsKey('flashcache') ) { $payload.Add('flashcache', $flashcache) }
            if ( $PSBoundParameters.ContainsKey('expireatlastbyte') ) { $payload.Add('expireatlastbyte', $expireatlastbyte) }
            if ( $PSBoundParameters.ContainsKey('insertvia') ) { $payload.Add('insertvia', $insertvia) }
            if ( $PSBoundParameters.ContainsKey('insertage') ) { $payload.Add('insertage', $insertage) }
            if ( $PSBoundParameters.ContainsKey('insertetag') ) { $payload.Add('insertetag', $insertetag) }
            if ( $PSBoundParameters.ContainsKey('cachecontrol') ) { $payload.Add('cachecontrol', $cachecontrol) }
            if ( $PSBoundParameters.ContainsKey('quickabortsize') ) { $payload.Add('quickabortsize', $quickabortsize) }
            if ( $PSBoundParameters.ContainsKey('minressize') ) { $payload.Add('minressize', $minressize) }
            if ( $PSBoundParameters.ContainsKey('maxressize') ) { $payload.Add('maxressize', $maxressize) }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSBoundParameters.ContainsKey('ignorereqcachinghdrs') ) { $payload.Add('ignorereqcachinghdrs', $ignorereqcachinghdrs) }
            if ( $PSBoundParameters.ContainsKey('minhits') ) { $payload.Add('minhits', $minhits) }
            if ( $PSBoundParameters.ContainsKey('alwaysevalpolicies') ) { $payload.Add('alwaysevalpolicies', $alwaysevalpolicies) }
            if ( $PSBoundParameters.ContainsKey('persistha') ) { $payload.Add('persistha', $persistha) }
            if ( $PSBoundParameters.ContainsKey('pinned') ) { $payload.Add('pinned', $pinned) }
            if ( $PSBoundParameters.ContainsKey('lazydnsresolve') ) { $payload.Add('lazydnsresolve', $lazydnsresolve) }
            if ( $PSBoundParameters.ContainsKey('hitselector') ) { $payload.Add('hitselector', $hitselector) }
            if ( $PSBoundParameters.ContainsKey('invalselector') ) { $payload.Add('invalselector', $invalselector) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type cachecontentgroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCachecontentgroup: Finished"
    }
}

function Invoke-NSExpireCachecontentgroup {
    <#
    .SYNOPSIS
        Expire Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache content group resource.
    .PARAMETER Name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created.
    .EXAMPLE
        PS C:\>Invoke-NSExpireCachecontentgroup -name <string>
        An example how to expire cachecontentgroup config Object(s).
    .NOTES
        File Name : Invoke-NSExpireCachecontentgroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachecontentgroup/
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
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-NSExpireCachecontentgroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Expire Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cachecontentgroup -Action expire -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSExpireCachecontentgroup: Finished"
    }
}

function Invoke-NSFlushCachecontentgroup {
    <#
    .SYNOPSIS
        Flush Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache content group resource.
    .PARAMETER Name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created. 
    .PARAMETER Query 
        Query string specifying individual objects to flush from this group by using parameterized invalidation. If this parameter is not set, all objects are flushed from the group. 
    .PARAMETER Hostname 
        Flush only objects that belong to the specified host. Do not use except with parameterized invalidation. Also, the Invalidation Restricted to Host parameter for the group must be set to YES. 
    .PARAMETER Selectorvalue 
        Value of the selector to be used for flushing objects from the content group. Requires that an invalidation selector be configured for the content group.
    .EXAMPLE
        PS C:\>Invoke-NSFlushCachecontentgroup -name <string>
        An example how to flush cachecontentgroup config Object(s).
    .NOTES
        File Name : Invoke-NSFlushCachecontentgroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachecontentgroup/
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
        [string]$Query,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Selectorvalue 

    )
    begin {
        Write-Verbose "Invoke-NSFlushCachecontentgroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('query') ) { $payload.Add('query', $query) }
            if ( $PSBoundParameters.ContainsKey('Hostname') ) { $payload.Add('host', $Hostname) }
            if ( $PSBoundParameters.ContainsKey('selectorvalue') ) { $payload.Add('selectorvalue', $selectorvalue) }
            if ( $PSCmdlet.ShouldProcess($Name, "Flush Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cachecontentgroup -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSFlushCachecontentgroup: Finished"
    }
}

function Invoke-NSSaveCachecontentgroup {
    <#
    .SYNOPSIS
        Save Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache content group resource.
    .PARAMETER Name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created. 
    .PARAMETER Tosecondary 
        content group whose objects are to be sent to secondary. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSSaveCachecontentgroup -name <string>
        An example how to save cachecontentgroup config Object(s).
    .NOTES
        File Name : Invoke-NSSaveCachecontentgroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachecontentgroup/
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

        [ValidateSet('YES', 'NO')]
        [string]$Tosecondary 

    )
    begin {
        Write-Verbose "Invoke-NSSaveCachecontentgroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('tosecondary') ) { $payload.Add('tosecondary', $tosecondary) }
            if ( $PSCmdlet.ShouldProcess($Name, "Save Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cachecontentgroup -Action save -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSSaveCachecontentgroup: Finished"
    }
}

function Invoke-NSGetCachecontentgroup {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Configuration for Integrated Cache content group resource.
    .PARAMETER Name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created. 
    .PARAMETER GetAll 
        Retrieve all cachecontentgroup object(s).
    .PARAMETER Count
        If specified, the count of the cachecontentgroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachecontentgroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachecontentgroup -GetAll 
        Get all cachecontentgroup data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachecontentgroup -Count 
        Get the number of cachecontentgroup objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachecontentgroup -name <string>
        Get cachecontentgroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachecontentgroup -Filter @{ 'name'='<value>' }
        Get cachecontentgroup data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachecontentgroup
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachecontentgroup/
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
        Write-Verbose "Invoke-NSGetCachecontentgroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cachecontentgroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachecontentgroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachecontentgroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachecontentgroup configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachecontentgroup configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachecontentgroup: Ended"
    }
}

function Invoke-NSAddCacheforwardproxy {
    <#
    .SYNOPSIS
        Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for forward proxy resource.
    .PARAMETER Ipaddress 
        IP address of the Citrix ADC or a cache server for which the cache acts as a proxy. Requests coming to the Citrix ADC with the configured IP address are forwarded to the particular address, without involving the Integrated Cache in any way. 
    .PARAMETER Port 
        Port on the Citrix ADC or a server for which the cache acts as a proxy.
    .EXAMPLE
        PS C:\>Invoke-NSAddCacheforwardproxy -ipaddress <string> -port <int>
        An example how to add cacheforwardproxy config Object(s).
    .NOTES
        File Name : Invoke-NSAddCacheforwardproxy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheforwardproxy/
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
        [string]$Ipaddress,

        [Parameter(Mandatory)]
        [ValidateRange(1, 65535)]
        [int]$Port 
    )
    begin {
        Write-Verbose "Invoke-NSAddCacheforwardproxy: Starting"
    }
    process {
        try {
            $payload = @{ ipaddress = $ipaddress
                port                = $port
            }

            if ( $PSCmdlet.ShouldProcess("cacheforwardproxy", "Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cacheforwardproxy -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSAddCacheforwardproxy: Finished"
    }
}

function Invoke-NSDeleteCacheforwardproxy {
    <#
    .SYNOPSIS
        Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for forward proxy resource.
    .PARAMETER Ipaddress 
        IP address of the Citrix ADC or a cache server for which the cache acts as a proxy. Requests coming to the Citrix ADC with the configured IP address are forwarded to the particular address, without involving the Integrated Cache in any way. 
    .PARAMETER Port 
        Port on the Citrix ADC or a server for which the cache acts as a proxy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCacheforwardproxy -Ipaddress <string>
        An example how to delete cacheforwardproxy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCacheforwardproxy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheforwardproxy/
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
        [string]$Ipaddress,

        [int]$Port 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCacheforwardproxy: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Port') ) { $arguments.Add('port', $Port) }
            if ( $PSCmdlet.ShouldProcess("$ipaddress", "Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cacheforwardproxy -NitroPath nitro/v1/config -Resource $ipaddress -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCacheforwardproxy: Finished"
    }
}

function Invoke-NSGetCacheforwardproxy {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Configuration for forward proxy resource.
    .PARAMETER GetAll 
        Retrieve all cacheforwardproxy object(s).
    .PARAMETER Count
        If specified, the count of the cacheforwardproxy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheforwardproxy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCacheforwardproxy -GetAll 
        Get all cacheforwardproxy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCacheforwardproxy -Count 
        Get the number of cacheforwardproxy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheforwardproxy -name <string>
        Get cacheforwardproxy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheforwardproxy -Filter @{ 'name'='<value>' }
        Get cacheforwardproxy data with a filter.
    .NOTES
        File Name : Invoke-NSGetCacheforwardproxy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheforwardproxy/
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
        Write-Verbose "Invoke-NSGetCacheforwardproxy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cacheforwardproxy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheforwardproxy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheforwardproxy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheforwardproxy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheforwardproxy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheforwardproxy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheforwardproxy configuration for property ''"

            } else {
                Write-Verbose "Retrieving cacheforwardproxy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheforwardproxy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCacheforwardproxy: Ended"
    }
}

function Invoke-NSGetCacheglobalBinding {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to cacheglobal.
    .PARAMETER GetAll 
        Retrieve all cacheglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the cacheglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCacheglobalBinding -GetAll 
        Get all cacheglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheglobalBinding -name <string>
        Get cacheglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheglobalBinding -Filter @{ 'name'='<value>' }
        Get cacheglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCacheglobalBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheglobal_binding/
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
        Write-Verbose "Invoke-NSGetCacheglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cacheglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving cacheglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCacheglobalBinding: Ended"
    }
}

function Invoke-NSAddCacheglobalCachepolicyBinding {
    <#
    .SYNOPSIS
        Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to cacheglobal.
    .PARAMETER Policy 
        Name of the cache policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Precededefrules 
        Specify whether this policy should be evaluated. 
         
        Possible values = YES, NO 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        The bind point to which policy is bound. When you specify the type, detailed information about that bind point appears. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, HTTPQUIC_RES_OVERRIDE, HTTPQUIC_RES_DEFAULT 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. Applicable only to default-syntax policies. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. (To invoke a label associated with a virtual server, specify the name of the virtual server.). 
    .PARAMETER PassThru 
        Return details about the created cacheglobal_cachepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCacheglobalCachepolicyBinding -policy <string> -priority <double>
        An example how to add cacheglobal_cachepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCacheglobalCachepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheglobal_cachepolicy_binding/
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
        [string]$Policy,

        [Parameter(Mandatory)]
        [double]$Priority,

        [ValidateSet('YES', 'NO')]
        [string]$Precededefrules = 'NO',

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT', 'HTTPQUIC_RES_OVERRIDE', 'HTTPQUIC_RES_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCacheglobalCachepolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ policy = $policy
                priority         = $priority
            }
            if ( $PSBoundParameters.ContainsKey('precededefrules') ) { $payload.Add('precededefrules', $precededefrules) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("cacheglobal_cachepolicy_binding", "Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cacheglobal_cachepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCacheglobalCachepolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCacheglobalCachepolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCacheglobalCachepolicyBinding {
    <#
    .SYNOPSIS
        Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to cacheglobal.
    .PARAMETER Policy 
        Name of the cache policy. 
    .PARAMETER Type 
        The bind point to which policy is bound. When you specify the type, detailed information about that bind point appears. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, HTTPQUIC_RES_OVERRIDE, HTTPQUIC_RES_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCacheglobalCachepolicyBinding 
        An example how to delete cacheglobal_cachepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCacheglobalCachepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheglobal_cachepolicy_binding/
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

        [string]$Policy,

        [string]$Type,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCacheglobalCachepolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("cacheglobal_cachepolicy_binding", "Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cacheglobal_cachepolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCacheglobalCachepolicyBinding: Finished"
    }
}

function Invoke-NSGetCacheglobalCachepolicyBinding {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to cacheglobal.
    .PARAMETER Type 
        The bind point to which policy is bound. When you specify the type, detailed information about that bind point appears. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, HTTPQUIC_RES_OVERRIDE, HTTPQUIC_RES_DEFAULT 
    .PARAMETER GetAll 
        Retrieve all cacheglobal_cachepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the cacheglobal_cachepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheglobalCachepolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCacheglobalCachepolicyBinding -GetAll 
        Get all cacheglobal_cachepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCacheglobalCachepolicyBinding -Count 
        Get the number of cacheglobal_cachepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheglobalCachepolicyBinding -name <string>
        Get cacheglobal_cachepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheglobalCachepolicyBinding -Filter @{ 'name'='<value>' }
        Get cacheglobal_cachepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCacheglobalCachepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheglobal_cachepolicy_binding/
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
        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT', 'HTTPQUIC_RES_OVERRIDE', 'HTTPQUIC_RES_DEFAULT')]
        [string]$Type,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCacheglobalCachepolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cacheglobal_cachepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheglobal_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheglobal_cachepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheglobal_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheglobal_cachepolicy_binding objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheglobal_cachepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheglobal_cachepolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving cacheglobal_cachepolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheglobal_cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCacheglobalCachepolicyBinding: Ended"
    }
}

function Invoke-NSExpireCacheobject {
    <#
    .SYNOPSIS
        Expire Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache object resource.
    .PARAMETER Locator 
        ID of the cached object. 
    .PARAMETER Url 
        URL of the particular object whose details is required. Parameter "host" must be specified along with the URL. 
    .PARAMETER Hostname 
        Host name of the object. Parameter "url" must be specified. 
    .PARAMETER Port 
        Host port of the object. You must also set the Host parameter. 
    .PARAMETER Groupname 
        Name of the content group to which the object belongs. It will display only the objects belonging to the specified content group. You must also set the Host parameter. 
    .PARAMETER Httpmethod 
        HTTP request method that caused the object to be stored. 
         
        Possible values = GET, POST
    .EXAMPLE
        PS C:\>Invoke-NSExpireCacheobject 
        An example how to expire cacheobject config Object(s).
    .NOTES
        File Name : Invoke-NSExpireCacheobject
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheobject/
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

        [double]$Locator,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Url,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostname,

        [int]$Port,

        [string]$Groupname,

        [ValidateSet('GET', 'POST')]
        [string]$Httpmethod 

    )
    begin {
        Write-Verbose "Invoke-NSExpireCacheobject: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('locator') ) { $payload.Add('locator', $locator) }
            if ( $PSBoundParameters.ContainsKey('url') ) { $payload.Add('url', $url) }
            if ( $PSBoundParameters.ContainsKey('Hostname') ) { $payload.Add('host', $Hostname) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('groupname') ) { $payload.Add('groupname', $groupname) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSCmdlet.ShouldProcess($Name, "Expire Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cacheobject -Action expire -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSExpireCacheobject: Finished"
    }
}

function Invoke-NSFlushCacheobject {
    <#
    .SYNOPSIS
        Flush Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache object resource.
    .PARAMETER Locator 
        ID of the cached object. 
    .PARAMETER Url 
        URL of the particular object whose details is required. Parameter "host" must be specified along with the URL. 
    .PARAMETER Hostname 
        Host name of the object. Parameter "url" must be specified. 
    .PARAMETER Port 
        Host port of the object. You must also set the Host parameter. 
    .PARAMETER Groupname 
        Name of the content group to which the object belongs. It will display only the objects belonging to the specified content group. You must also set the Host parameter. 
    .PARAMETER Httpmethod 
        HTTP request method that caused the object to be stored. 
         
        Possible values = GET, POST
    .EXAMPLE
        PS C:\>Invoke-NSFlushCacheobject 
        An example how to flush cacheobject config Object(s).
    .NOTES
        File Name : Invoke-NSFlushCacheobject
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheobject/
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

        [double]$Locator,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Url,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostname,

        [int]$Port,

        [string]$Groupname,

        [ValidateSet('GET', 'POST')]
        [string]$Httpmethod 

    )
    begin {
        Write-Verbose "Invoke-NSFlushCacheobject: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('locator') ) { $payload.Add('locator', $locator) }
            if ( $PSBoundParameters.ContainsKey('url') ) { $payload.Add('url', $url) }
            if ( $PSBoundParameters.ContainsKey('Hostname') ) { $payload.Add('host', $Hostname) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('groupname') ) { $payload.Add('groupname', $groupname) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSCmdlet.ShouldProcess($Name, "Flush Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cacheobject -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSFlushCacheobject: Finished"
    }
}

function Invoke-NSSaveCacheobject {
    <#
    .SYNOPSIS
        Save Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache object resource.
    .PARAMETER Locator 
        ID of the cached object. 
    .PARAMETER Tosecondary 
        Object will be saved onto Secondary. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSSaveCacheobject 
        An example how to save cacheobject config Object(s).
    .NOTES
        File Name : Invoke-NSSaveCacheobject
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheobject/
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

        [double]$Locator,

        [ValidateSet('YES', 'NO')]
        [string]$Tosecondary 

    )
    begin {
        Write-Verbose "Invoke-NSSaveCacheobject: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('locator') ) { $payload.Add('locator', $locator) }
            if ( $PSBoundParameters.ContainsKey('tosecondary') ) { $payload.Add('tosecondary', $tosecondary) }
            if ( $PSCmdlet.ShouldProcess($Name, "Save Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cacheobject -Action save -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSSaveCacheobject: Finished"
    }
}

function Invoke-NSGetCacheobject {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Configuration for cache object resource.
    .PARAMETER Url 
        URL of the particular object whose details is required. Parameter "host" must be specified along with the URL. 
    .PARAMETER Locator 
        ID of the cached object. 
    .PARAMETER Httpstatus 
        HTTP status of the object. 
    .PARAMETER Hostname 
        Host name of the object. Parameter "url" must be specified. 
    .PARAMETER Port 
        Host port of the object. You must also set the Host parameter. 
    .PARAMETER Groupname 
        Name of the content group to which the object belongs. It will display only the objects belonging to the specified content group. You must also set the Host parameter. 
    .PARAMETER Httpmethod 
        HTTP request method that caused the object to be stored. 
         
        Possible values = GET, POST 
    .PARAMETER Group 
        Name of the content group whose objects should be listed. 
    .PARAMETER Ignoremarkerobjects 
        Ignore marker objects. Marker objects are created when a response exceeds the maximum or minimum response size for the content group or has not yet received the minimum number of hits for the content group. 
        Possible values = ON, OFF 
    .PARAMETER Includenotreadyobjects 
        Include responses that have not yet reached a minimum number of hits before being cached. 
        Possible values = ON, OFF 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all cacheobject object(s).
    .PARAMETER Count
        If specified, the count of the cacheobject object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheobject
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCacheobject -GetAll 
        Get all cacheobject data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCacheobject -Count 
        Get the number of cacheobject objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheobject -name <string>
        Get cacheobject object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheobject -Filter @{ 'name'='<value>' }
        Get cacheobject data with a filter.
    .NOTES
        File Name : Invoke-NSGetCacheobject
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheobject/
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
        [string]$Url,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double]$Locator,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double]$Httpstatus,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Port,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('GET', 'POST')]
        [string]$Httpmethod,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Group,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ON', 'OFF')]
        [string]$Ignoremarkerobjects,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ON', 'OFF')]
        [string]$Includenotreadyobjects,

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
        Write-Verbose "Invoke-NSGetCacheobject: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cacheobject objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheobject -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheobject objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheobject -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheobject objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('url') ) { $arguments.Add('url', $url) } 
                if ( $PSBoundParameters.ContainsKey('locator') ) { $arguments.Add('locator', $locator) } 
                if ( $PSBoundParameters.ContainsKey('httpstatus') ) { $arguments.Add('httpstatus', $httpstatus) } 
                if ( $PSBoundParameters.ContainsKey('Hostname') ) { $arguments.Add('host', $Hostname) } 
                if ( $PSBoundParameters.ContainsKey('port') ) { $arguments.Add('port', $port) } 
                if ( $PSBoundParameters.ContainsKey('groupname') ) { $arguments.Add('groupname', $groupname) } 
                if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $arguments.Add('httpmethod', $httpmethod) } 
                if ( $PSBoundParameters.ContainsKey('group') ) { $arguments.Add('group', $group) } 
                if ( $PSBoundParameters.ContainsKey('ignoremarkerobjects') ) { $arguments.Add('ignoremarkerobjects', $ignoremarkerobjects) } 
                if ( $PSBoundParameters.ContainsKey('includenotreadyobjects') ) { $arguments.Add('includenotreadyobjects', $includenotreadyobjects) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheobject -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheobject configuration for property ''"

            } else {
                Write-Verbose "Retrieving cacheobject configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheobject -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCacheobject: Ended"
    }
}

function Invoke-NSUpdateCacheparameter {
    <#
    .SYNOPSIS
        Update Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache parameter resource.
    .PARAMETER Memlimit 
        Amount of memory available for storing the cache objects. In practice, the amount of memory available for caching can be less than half the total memory of the Citrix ADC. 
    .PARAMETER Via 
        String to include in the Via header. A Via header is inserted into all responses served from a content group if its Insert Via flag is set. 
    .PARAMETER Verifyusing 
        Criteria for deciding whether a cached object can be served for an incoming HTTP request. Available settings function as follows: 
        HOSTNAME - The URL, host name, and host port values in the incoming HTTP request header must match the cache policy. The IP address and the TCP port of the destination host are not evaluated. Do not use the HOSTNAME setting unless you are certain that no rogue client can access a rogue server through the cache. 
        HOSTNAME_AND_IP - The URL, host name, host port in the incoming HTTP request header, and the IP address and TCP port of 
        the destination server, must match the cache policy. 
        DNS - The URL, host name and host port in the incoming HTTP request, and the TCP port must match the cache policy. The host name is used for DNS lookup of the destination server's IP address, and is compared with the set of addresses returned by the DNS lookup. 
        Possible values = HOSTNAME, HOSTNAME_AND_IP, DNS 
    .PARAMETER Maxpostlen 
        Maximum number of POST body bytes to consider when evaluating parameters for a content group for which you have configured hit parameters and invalidation parameters. 
         
         
        Maximum value = 131072 
    .PARAMETER Prefetchmaxpending 
        Maximum number of outstanding prefetches in the Integrated Cache. 
    .PARAMETER Enablebypass 
        Evaluate the request-time policies before attempting hit selection. If set to NO, an incoming request for which a matching object is found in cache storage results in a response regardless of the policy configuration. 
        If the request matches a policy with a NOCACHE action, the request bypasses all cache processing. 
        This parameter does not affect processing of requests that match any invalidation policy. 
        Possible values = YES, NO 
    .PARAMETER Undefaction 
        Action to take when a policy cannot be evaluated. 
        Possible values = NOCACHE, RESET 
    .PARAMETER Enablehaobjpersist 
        The HA object persisting parameter. When this value is set to YES, cache objects can be synced to Secondary in a HA deployment. If set to NO, objects will never be synced to Secondary node. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCacheparameter 
        An example how to update cacheparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCacheparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheparameter/
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

        [double]$Memlimit,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Via,

        [ValidateSet('HOSTNAME', 'HOSTNAME_AND_IP', 'DNS')]
        [string]$Verifyusing,

        [double]$Maxpostlen,

        [double]$Prefetchmaxpending,

        [ValidateSet('YES', 'NO')]
        [string]$Enablebypass,

        [ValidateSet('NOCACHE', 'RESET')]
        [string]$Undefaction,

        [ValidateSet('YES', 'NO')]
        [string]$Enablehaobjpersist 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCacheparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSBoundParameters.ContainsKey('via') ) { $payload.Add('via', $via) }
            if ( $PSBoundParameters.ContainsKey('verifyusing') ) { $payload.Add('verifyusing', $verifyusing) }
            if ( $PSBoundParameters.ContainsKey('maxpostlen') ) { $payload.Add('maxpostlen', $maxpostlen) }
            if ( $PSBoundParameters.ContainsKey('prefetchmaxpending') ) { $payload.Add('prefetchmaxpending', $prefetchmaxpending) }
            if ( $PSBoundParameters.ContainsKey('enablebypass') ) { $payload.Add('enablebypass', $enablebypass) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('enablehaobjpersist') ) { $payload.Add('enablehaobjpersist', $enablehaobjpersist) }
            if ( $PSCmdlet.ShouldProcess("cacheparameter", "Update Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cacheparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateCacheparameter: Finished"
    }
}

function Invoke-NSUnsetCacheparameter {
    <#
    .SYNOPSIS
        Unset Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache parameter resource.
    .PARAMETER Memlimit 
        Amount of memory available for storing the cache objects. In practice, the amount of memory available for caching can be less than half the total memory of the Citrix ADC. 
    .PARAMETER Via 
        String to include in the Via header. A Via header is inserted into all responses served from a content group if its Insert Via flag is set. 
    .PARAMETER Verifyusing 
        Criteria for deciding whether a cached object can be served for an incoming HTTP request. Available settings function as follows: 
        HOSTNAME - The URL, host name, and host port values in the incoming HTTP request header must match the cache policy. The IP address and the TCP port of the destination host are not evaluated. Do not use the HOSTNAME setting unless you are certain that no rogue client can access a rogue server through the cache. 
        HOSTNAME_AND_IP - The URL, host name, host port in the incoming HTTP request header, and the IP address and TCP port of 
        the destination server, must match the cache policy. 
        DNS - The URL, host name and host port in the incoming HTTP request, and the TCP port must match the cache policy. The host name is used for DNS lookup of the destination server's IP address, and is compared with the set of addresses returned by the DNS lookup. 
        Possible values = HOSTNAME, HOSTNAME_AND_IP, DNS 
    .PARAMETER Maxpostlen 
        Maximum number of POST body bytes to consider when evaluating parameters for a content group for which you have configured hit parameters and invalidation parameters. 
         
         
        Maximum value = 131072 
    .PARAMETER Prefetchmaxpending 
        Maximum number of outstanding prefetches in the Integrated Cache. 
    .PARAMETER Enablebypass 
        Evaluate the request-time policies before attempting hit selection. If set to NO, an incoming request for which a matching object is found in cache storage results in a response regardless of the policy configuration. 
        If the request matches a policy with a NOCACHE action, the request bypasses all cache processing. 
        This parameter does not affect processing of requests that match any invalidation policy. 
        Possible values = YES, NO 
    .PARAMETER Undefaction 
        Action to take when a policy cannot be evaluated. 
        Possible values = NOCACHE, RESET 
    .PARAMETER Enablehaobjpersist 
        The HA object persisting parameter. When this value is set to YES, cache objects can be synced to Secondary in a HA deployment. If set to NO, objects will never be synced to Secondary node. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCacheparameter 
        An example how to unset cacheparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCacheparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheparameter
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

        [Boolean]$memlimit,

        [Boolean]$via,

        [Boolean]$verifyusing,

        [Boolean]$maxpostlen,

        [Boolean]$prefetchmaxpending,

        [Boolean]$enablebypass,

        [Boolean]$undefaction,

        [Boolean]$enablehaobjpersist 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCacheparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSBoundParameters.ContainsKey('via') ) { $payload.Add('via', $via) }
            if ( $PSBoundParameters.ContainsKey('verifyusing') ) { $payload.Add('verifyusing', $verifyusing) }
            if ( $PSBoundParameters.ContainsKey('maxpostlen') ) { $payload.Add('maxpostlen', $maxpostlen) }
            if ( $PSBoundParameters.ContainsKey('prefetchmaxpending') ) { $payload.Add('prefetchmaxpending', $prefetchmaxpending) }
            if ( $PSBoundParameters.ContainsKey('enablebypass') ) { $payload.Add('enablebypass', $enablebypass) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('enablehaobjpersist') ) { $payload.Add('enablehaobjpersist', $enablehaobjpersist) }
            if ( $PSCmdlet.ShouldProcess("cacheparameter", "Unset Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type cacheparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCacheparameter: Finished"
    }
}

function Invoke-NSGetCacheparameter {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Configuration for cache parameter resource.
    .PARAMETER GetAll 
        Retrieve all cacheparameter object(s).
    .PARAMETER Count
        If specified, the count of the cacheparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCacheparameter -GetAll 
        Get all cacheparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheparameter -name <string>
        Get cacheparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheparameter -Filter @{ 'name'='<value>' }
        Get cacheparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetCacheparameter
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheparameter/
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
        Write-Verbose "Invoke-NSGetCacheparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cacheparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving cacheparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCacheparameter: Ended"
    }
}

function Invoke-NSAddCachepolicy {
    <#
    .SYNOPSIS
        Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache policy resource.
    .PARAMETER Policyname 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created. 
    .PARAMETER Rule 
        Expression against which the traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Action to apply to content that matches the policy. 
        * CACHE or MAY_CACHE action - positive cachability policy 
        * NOCACHE or MAY_NOCACHE action - negative cachability policy 
        * INVAL action - Dynamic Invalidation Policy. 
        Possible values = CACHE, NOCACHE, MAY_CACHE, MAY_NOCACHE, INVAL 
    .PARAMETER Storeingroup 
        Name of the content group in which to store the object when the final result of policy evaluation is CACHE. The content group must exist before being mentioned here. Use the "show cache contentgroup" command to view the list of existing content groups. 
    .PARAMETER Invalgroups 
        Content group(s) to be invalidated when the INVAL action is applied. Maximum number of content groups that can be specified is 16. 
    .PARAMETER Invalobjects 
        Content groups(s) in which the objects will be invalidated if the action is INVAL. 
    .PARAMETER Undefaction 
        Action to be performed when the result of rule evaluation is undefined. 
        Possible values = NOCACHE, RESET 
    .PARAMETER PassThru 
        Return details about the created cachepolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCachepolicy -policyname <string> -rule <string> -action <string>
        An example how to add cachepolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddCachepolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy/
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
        [string]$Policyname,

        [Parameter(Mandatory)]
        [string]$Rule,

        [Parameter(Mandatory)]
        [ValidateSet('CACHE', 'NOCACHE', 'MAY_CACHE', 'MAY_NOCACHE', 'INVAL')]
        [string]$Action,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Storeingroup,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Invalgroups,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Invalobjects,

        [ValidateSet('NOCACHE', 'RESET')]
        [string]$Undefaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCachepolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                rule                 = $rule
                action               = $action
            }
            if ( $PSBoundParameters.ContainsKey('storeingroup') ) { $payload.Add('storeingroup', $storeingroup) }
            if ( $PSBoundParameters.ContainsKey('invalgroups') ) { $payload.Add('invalgroups', $invalgroups) }
            if ( $PSBoundParameters.ContainsKey('invalobjects') ) { $payload.Add('invalobjects', $invalobjects) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSCmdlet.ShouldProcess("cachepolicy", "Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cachepolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCachepolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCachepolicy: Finished"
    }
}

function Invoke-NSDeleteCachepolicy {
    <#
    .SYNOPSIS
        Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache policy resource.
    .PARAMETER Policyname 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCachepolicy -Policyname <string>
        An example how to delete cachepolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCachepolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy/
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
        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCachepolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$policyname", "Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cachepolicy -NitroPath nitro/v1/config -Resource $policyname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCachepolicy: Finished"
    }
}

function Invoke-NSUpdateCachepolicy {
    <#
    .SYNOPSIS
        Update Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache policy resource.
    .PARAMETER Policyname 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created. 
    .PARAMETER Rule 
        Expression against which the traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Action to apply to content that matches the policy. 
        * CACHE or MAY_CACHE action - positive cachability policy 
        * NOCACHE or MAY_NOCACHE action - negative cachability policy 
        * INVAL action - Dynamic Invalidation Policy. 
        Possible values = CACHE, NOCACHE, MAY_CACHE, MAY_NOCACHE, INVAL 
    .PARAMETER Storeingroup 
        Name of the content group in which to store the object when the final result of policy evaluation is CACHE. The content group must exist before being mentioned here. Use the "show cache contentgroup" command to view the list of existing content groups. 
    .PARAMETER Invalgroups 
        Content group(s) to be invalidated when the INVAL action is applied. Maximum number of content groups that can be specified is 16. 
    .PARAMETER Invalobjects 
        Content groups(s) in which the objects will be invalidated if the action is INVAL. 
    .PARAMETER Undefaction 
        Action to be performed when the result of rule evaluation is undefined. 
        Possible values = NOCACHE, RESET 
    .PARAMETER PassThru 
        Return details about the created cachepolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCachepolicy -policyname <string>
        An example how to update cachepolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCachepolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy/
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
        [string]$Policyname,

        [string]$Rule,

        [ValidateSet('CACHE', 'NOCACHE', 'MAY_CACHE', 'MAY_NOCACHE', 'INVAL')]
        [string]$Action,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Storeingroup,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Invalgroups,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Invalobjects,

        [ValidateSet('NOCACHE', 'RESET')]
        [string]$Undefaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCachepolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('storeingroup') ) { $payload.Add('storeingroup', $storeingroup) }
            if ( $PSBoundParameters.ContainsKey('invalgroups') ) { $payload.Add('invalgroups', $invalgroups) }
            if ( $PSBoundParameters.ContainsKey('invalobjects') ) { $payload.Add('invalobjects', $invalobjects) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSCmdlet.ShouldProcess("cachepolicy", "Update Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cachepolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCachepolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCachepolicy: Finished"
    }
}

function Invoke-NSUnsetCachepolicy {
    <#
    .SYNOPSIS
        Unset Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache policy resource.
    .PARAMETER Policyname 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created. 
    .PARAMETER Storeingroup 
        Name of the content group in which to store the object when the final result of policy evaluation is CACHE. The content group must exist before being mentioned here. Use the "show cache contentgroup" command to view the list of existing content groups. 
    .PARAMETER Invalgroups 
        Content group(s) to be invalidated when the INVAL action is applied. Maximum number of content groups that can be specified is 16. 
    .PARAMETER Invalobjects 
        Content groups(s) in which the objects will be invalidated if the action is INVAL. 
    .PARAMETER Undefaction 
        Action to be performed when the result of rule evaluation is undefined. 
        Possible values = NOCACHE, RESET
    .EXAMPLE
        PS C:\>Invoke-NSUnsetCachepolicy -policyname <string>
        An example how to unset cachepolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetCachepolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy
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
        [string]$Policyname,

        [Boolean]$storeingroup,

        [Boolean]$invalgroups,

        [Boolean]$invalobjects,

        [Boolean]$undefaction 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetCachepolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('storeingroup') ) { $payload.Add('storeingroup', $storeingroup) }
            if ( $PSBoundParameters.ContainsKey('invalgroups') ) { $payload.Add('invalgroups', $invalgroups) }
            if ( $PSBoundParameters.ContainsKey('invalobjects') ) { $payload.Add('invalobjects', $invalobjects) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSCmdlet.ShouldProcess("$policyname", "Unset Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type cachepolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetCachepolicy: Finished"
    }
}

function Invoke-NSRenameCachepolicy {
    <#
    .SYNOPSIS
        Rename Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for Integrated Cache policy resource.
    .PARAMETER Policyname 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created. 
    .PARAMETER Newname 
        New name for the cache policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created cachepolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCachepolicy -policyname <string> -newname <string>
        An example how to rename cachepolicy config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCachepolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy/
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
        [string]$Policyname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameCachepolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                newname              = $newname
            }

            if ( $PSCmdlet.ShouldProcess("cachepolicy", "Rename Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cachepolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCachepolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCachepolicy: Finished"
    }
}

function Invoke-NSGetCachepolicy {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Configuration for Integrated Cache policy resource.
    .PARAMETER Policyname 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created. 
    .PARAMETER GetAll 
        Retrieve all cachepolicy object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicy -GetAll 
        Get all cachepolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicy -Count 
        Get the number of cachepolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicy -name <string>
        Get cachepolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicy -Filter @{ 'name'='<value>' }
        Get cachepolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachepolicy
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy/
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
        [string]$Policyname,

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
        Write-Verbose "Invoke-NSGetCachepolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cachepolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachepolicy: Ended"
    }
}

function Invoke-NSGetCachepolicyBinding {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to cachepolicy.
    .PARAMETER Policyname 
        Name of the cache policy about which to display details. 
    .PARAMETER GetAll 
        Retrieve all cachepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicyBinding -GetAll 
        Get all cachepolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyBinding -name <string>
        Get cachepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyBinding -Filter @{ 'name'='<value>' }
        Get cachepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy_binding/
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
        [string]$Policyname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCachepolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cachepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachepolicyBinding: Ended"
    }
}

function Invoke-NSGetCachepolicyCacheglobalBinding {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Binding object showing the cacheglobal that can be bound to cachepolicy.
    .PARAMETER Policyname 
        Name of the cache policy about which to display details. 
    .PARAMETER GetAll 
        Retrieve all cachepolicy_cacheglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicy_cacheglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyCacheglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicyCacheglobalBinding -GetAll 
        Get all cachepolicy_cacheglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicyCacheglobalBinding -Count 
        Get the number of cachepolicy_cacheglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyCacheglobalBinding -name <string>
        Get cachepolicy_cacheglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyCacheglobalBinding -Filter @{ 'name'='<value>' }
        Get cachepolicy_cacheglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachepolicyCacheglobalBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy_cacheglobal_binding/
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
        [string]$Policyname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCachepolicyCacheglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cachepolicy_cacheglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_cacheglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy_cacheglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_cacheglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy_cacheglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_cacheglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy_cacheglobal_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_cacheglobal_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy_cacheglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_cacheglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachepolicyCacheglobalBinding: Ended"
    }
}

function Invoke-NSGetCachepolicyCachepolicylabelBinding {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Binding object showing the cachepolicylabel that can be bound to cachepolicy.
    .PARAMETER Policyname 
        Name of the cache policy about which to display details. 
    .PARAMETER GetAll 
        Retrieve all cachepolicy_cachepolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicy_cachepolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyCachepolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicyCachepolicylabelBinding -GetAll 
        Get all cachepolicy_cachepolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicyCachepolicylabelBinding -Count 
        Get the number of cachepolicy_cachepolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyCachepolicylabelBinding -name <string>
        Get cachepolicy_cachepolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyCachepolicylabelBinding -Filter @{ 'name'='<value>' }
        Get cachepolicy_cachepolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachepolicyCachepolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy_cachepolicylabel_binding/
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
        [string]$Policyname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCachepolicyCachepolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cachepolicy_cachepolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_cachepolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy_cachepolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_cachepolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy_cachepolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_cachepolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy_cachepolicylabel_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_cachepolicylabel_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy_cachepolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_cachepolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachepolicyCachepolicylabelBinding: Ended"
    }
}

function Invoke-NSGetCachepolicyCsvserverBinding {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to cachepolicy.
    .PARAMETER Policyname 
        Name of the cache policy about which to display details. 
    .PARAMETER GetAll 
        Retrieve all cachepolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicyCsvserverBinding -GetAll 
        Get all cachepolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicyCsvserverBinding -Count 
        Get the number of cachepolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyCsvserverBinding -name <string>
        Get cachepolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyCsvserverBinding -Filter @{ 'name'='<value>' }
        Get cachepolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachepolicyCsvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy_csvserver_binding/
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
        [string]$Policyname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCachepolicyCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cachepolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy_csvserver_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachepolicyCsvserverBinding: Ended"
    }
}

function Invoke-NSGetCachepolicyLbvserverBinding {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to cachepolicy.
    .PARAMETER Policyname 
        Name of the cache policy about which to display details. 
    .PARAMETER GetAll 
        Retrieve all cachepolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicyLbvserverBinding -GetAll 
        Get all cachepolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicyLbvserverBinding -Count 
        Get the number of cachepolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyLbvserverBinding -name <string>
        Get cachepolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicyLbvserverBinding -Filter @{ 'name'='<value>' }
        Get cachepolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachepolicyLbvserverBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicy_lbvserver_binding/
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
        [string]$Policyname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetCachepolicyLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cachepolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy_lbvserver_binding configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachepolicyLbvserverBinding: Ended"
    }
}

function Invoke-NSAddCachepolicylabel {
    <#
    .SYNOPSIS
        Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache policy label resource.
    .PARAMETER Labelname 
        Name for the label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the label is created. 
    .PARAMETER Evaluates 
        When to evaluate policies bound to this label: request-time or response-time. 
        Possible values = REQ, RES, MSSQL_REQ, MSSQL_RES, MYSQL_REQ, MYSQL_RES, HTTPQUIC_REQ, HTTPQUIC_RES 
    .PARAMETER PassThru 
        Return details about the created cachepolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCachepolicylabel -labelname <string> -evaluates <string>
        An example how to add cachepolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSAddCachepolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicylabel/
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateSet('REQ', 'RES', 'MSSQL_REQ', 'MSSQL_RES', 'MYSQL_REQ', 'MYSQL_RES', 'HTTPQUIC_REQ', 'HTTPQUIC_RES')]
        [string]$Evaluates,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCachepolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                evaluates           = $evaluates
            }

            if ( $PSCmdlet.ShouldProcess("cachepolicylabel", "Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cachepolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCachepolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCachepolicylabel: Finished"
    }
}

function Invoke-NSDeleteCachepolicylabel {
    <#
    .SYNOPSIS
        Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache policy label resource.
    .PARAMETER Labelname 
        Name for the label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the label is created.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCachepolicylabel -Labelname <string>
        An example how to delete cachepolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCachepolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicylabel/
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
        Write-Verbose "Invoke-NSDeleteCachepolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cachepolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCachepolicylabel: Finished"
    }
}

function Invoke-NSRenameCachepolicylabel {
    <#
    .SYNOPSIS
        Rename Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache policy label resource.
    .PARAMETER Labelname 
        Name for the label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the label is created. 
    .PARAMETER Newname 
        New name for the cache-policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created cachepolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-NSRenameCachepolicylabel -labelname <string> -newname <string>
        An example how to rename cachepolicylabel config Object(s).
    .NOTES
        File Name : Invoke-NSRenameCachepolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicylabel/
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(?>(?>[a-zA-Z0-9]|[_])+(?>[\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])*)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSRenameCachepolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("cachepolicylabel", "Rename Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cachepolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCachepolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-NSRenameCachepolicylabel: Finished"
    }
}

function Invoke-NSGetCachepolicylabel {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Configuration for cache policy label resource.
    .PARAMETER Labelname 
        Name for the label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the label is created. 
    .PARAMETER GetAll 
        Retrieve all cachepolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicylabel -GetAll 
        Get all cachepolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicylabel -Count 
        Get the number of cachepolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabel -name <string>
        Get cachepolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabel -Filter @{ 'name'='<value>' }
        Get cachepolicylabel data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachepolicylabel
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicylabel/
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
        Write-Verbose "Invoke-NSGetCachepolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cachepolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicylabel objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicylabel configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicylabel configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachepolicylabel: Ended"
    }
}

function Invoke-NSGetCachepolicylabelBinding {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to cachepolicylabel.
    .PARAMETER Labelname 
        Name of the cache-policy label about which to display information. 
    .PARAMETER GetAll 
        Retrieve all cachepolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabelBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicylabelBinding -GetAll 
        Get all cachepolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabelBinding -name <string>
        Get cachepolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabelBinding -Filter @{ 'name'='<value>' }
        Get cachepolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachepolicylabelBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicylabel_binding/
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
        Write-Verbose "Invoke-NSGetCachepolicylabelBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cachepolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicylabel_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicylabel_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachepolicylabelBinding: Ended"
    }
}

function Invoke-NSAddCachepolicylabelCachepolicyBinding {
    <#
    .SYNOPSIS
        Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to cachepolicylabel.
    .PARAMETER Labelname 
        Name of the cache policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the cache policy to bind to the policy label. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next-lower priority. 
    .PARAMETER Labeltype 
        Type of policy label to invoke: an unnamed label associated with a virtual server, or user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Invoke_labelname 
        Name of the policy label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created cachepolicylabel_cachepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCachepolicylabelCachepolicyBinding -labelname <string> -policyname <string> -priority <double>
        An example how to add cachepolicylabel_cachepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddCachepolicylabelCachepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicylabel_cachepolicy_binding/
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

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCachepolicylabelCachepolicyBinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("cachepolicylabel_cachepolicy_binding", "Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cachepolicylabel_cachepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCachepolicylabelCachepolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCachepolicylabelCachepolicyBinding: Finished"
    }
}

function Invoke-NSDeleteCachepolicylabelCachepolicyBinding {
    <#
    .SYNOPSIS
        Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to cachepolicylabel.
    .PARAMETER Labelname 
        Name of the cache policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the cache policy to bind to the policy label. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCachepolicylabelCachepolicyBinding -Labelname <string>
        An example how to delete cachepolicylabel_cachepolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCachepolicylabelCachepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicylabel_cachepolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteCachepolicylabelCachepolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCachepolicylabelCachepolicyBinding: Finished"
    }
}

function Invoke-NSGetCachepolicylabelCachepolicyBinding {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to cachepolicylabel.
    .PARAMETER Labelname 
        Name of the cache policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all cachepolicylabel_cachepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicylabel_cachepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabelCachepolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicylabelCachepolicyBinding -GetAll 
        Get all cachepolicylabel_cachepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicylabelCachepolicyBinding -Count 
        Get the number of cachepolicylabel_cachepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabelCachepolicyBinding -name <string>
        Get cachepolicylabel_cachepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabelCachepolicyBinding -Filter @{ 'name'='<value>' }
        Get cachepolicylabel_cachepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachepolicylabelCachepolicyBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicylabel_cachepolicy_binding/
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
        Write-Verbose "Invoke-NSGetCachepolicylabelCachepolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cachepolicylabel_cachepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicylabel_cachepolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicylabel_cachepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicylabel_cachepolicy_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicylabel_cachepolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachepolicylabelCachepolicyBinding: Ended"
    }
}

function Invoke-NSGetCachepolicylabelPolicybindingBinding {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to cachepolicylabel.
    .PARAMETER Labelname 
        Name of the cache policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all cachepolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabelPolicybindingBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicylabelPolicybindingBinding -GetAll 
        Get all cachepolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCachepolicylabelPolicybindingBinding -Count 
        Get the number of cachepolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabelPolicybindingBinding -name <string>
        Get cachepolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCachepolicylabelPolicybindingBinding -Filter @{ 'name'='<value>' }
        Get cachepolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetCachepolicylabelPolicybindingBinding
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cachepolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-NSGetCachepolicylabelPolicybindingBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cachepolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicylabel_policybinding_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicylabel_policybinding_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cachepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCachepolicylabelPolicybindingBinding: Ended"
    }
}

function Invoke-NSAddCacheselector {
    <#
    .SYNOPSIS
        Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache selector resource.
    .PARAMETER Selectorname 
        Name for the selector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Rule 
        One or multiple PIXL expressions for evaluating an HTTP request or response. 
    .PARAMETER PassThru 
        Return details about the created cacheselector item.
    .EXAMPLE
        PS C:\>Invoke-NSAddCacheselector -selectorname <string>
        An example how to add cacheselector config Object(s).
    .NOTES
        File Name : Invoke-NSAddCacheselector
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheselector/
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
        [string]$Selectorname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Rule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddCacheselector: Starting"
    }
    process {
        try {
            $payload = @{ selectorname = $selectorname }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSCmdlet.ShouldProcess("cacheselector", "Add Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cacheselector -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCacheselector -Filter $payload)
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
        Write-Verbose "Invoke-NSAddCacheselector: Finished"
    }
}

function Invoke-NSDeleteCacheselector {
    <#
    .SYNOPSIS
        Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache selector resource.
    .PARAMETER Selectorname 
        Name for the selector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteCacheselector -Selectorname <string>
        An example how to delete cacheselector config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteCacheselector
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheselector/
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
        [string]$Selectorname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteCacheselector: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$selectorname", "Delete Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type cacheselector -NitroPath nitro/v1/config -Resource $selectorname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteCacheselector: Finished"
    }
}

function Invoke-NSUpdateCacheselector {
    <#
    .SYNOPSIS
        Update Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object.
    .DESCRIPTION
        Configuration for cache selector resource.
    .PARAMETER Selectorname 
        Name for the selector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Rule 
        One or multiple PIXL expressions for evaluating an HTTP request or response. 
    .PARAMETER PassThru 
        Return details about the created cacheselector item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateCacheselector -selectorname <string>
        An example how to update cacheselector config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateCacheselector
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheselector/
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
        [string]$Selectorname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Rule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateCacheselector: Starting"
    }
    process {
        try {
            $payload = @{ selectorname = $selectorname }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSCmdlet.ShouldProcess("cacheselector", "Update Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type cacheselector -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetCacheselector -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateCacheselector: Finished"
    }
}

function Invoke-NSGetCacheselector {
    <#
    .SYNOPSIS
        Get Integrated Caching Configuration. The Integrated Caching feature is used to cache static and dynamic web application data. config object(s).
    .DESCRIPTION
        Configuration for cache selector resource.
    .PARAMETER Selectorname 
        Name for the selector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all cacheselector object(s).
    .PARAMETER Count
        If specified, the count of the cacheselector object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheselector
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetCacheselector -GetAll 
        Get all cacheselector data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetCacheselector -Count 
        Get the number of cacheselector objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheselector -name <string>
        Get cacheselector object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetCacheselector -Filter @{ 'name'='<value>' }
        Get cacheselector data with a filter.
    .NOTES
        File Name : Invoke-NSGetCacheselector
        Version   : v2311.1622
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cache/cacheselector/
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
        [string]$Selectorname,

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
        Write-Verbose "Invoke-NSGetCacheselector: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cacheselector objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheselector -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheselector objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheselector -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheselector objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheselector -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheselector configuration for property 'selectorname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheselector -NitroPath nitro/v1/config -Resource $selectorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cacheselector configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type cacheselector -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetCacheselector: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDi2Y804OqgHo24
# 4Yx0y/h9HIgXc7PLrYWMauxhnFU0+qCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQg/oOM4MS0FFg0jcm5Re0y/ygeNO2wbJTcXbm4mxBrQdMwDQYJKoZIhvcNAQEB
# BQAEggEAchHg1G11kQLYm3AbOFrDdHVl9CmHuuotMryyY1duSOYGpUrSw7n48POd
# gUCGHBjitnvPOvJTC/q5XivvRJ+YX0Gzh9HiUQj0s9tKQ5+P+8QFS+uhthtJXV8d
# BfFRQnkZS8XKBfNu4Fcu1QTfEhoj22HNj5aCpJhL3t+P747sBXbexprdudN2IyV3
# QfVDoRyrzcQBIGhlbU6XHQ0dOjW5QP11I6N3mw/FON7It2DvOF8wpKclR1oIwL11
# EyT/nRMXzEbr3DIUA/1TXF705dlls8w05DB1j6tFNZ1fBGyjm/Yuzz2jqEkvrsou
# f9dVkrB77hXSB1/8xhqQTYPWSBLVqw==
# SIG # End signature block
