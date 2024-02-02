function Invoke-NSJoinCluster {
    <#
    .SYNOPSIS
        Join Cluster commands. config Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Clip 
        Cluster IP address to which to add the node. 
    .PARAMETER Password 
        Password for the nsroot account of the configuration coordinator (CCO).
    .EXAMPLE
        PS C:\>Invoke-NSJoinCluster -clip <string> -password <string>
        An example how to join cluster config Object(s).
    .NOTES
        File Name : Invoke-NSJoinCluster
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/cluster/
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
        [string]$Clip,

        [Parameter(Mandatory)]
        [string]$Password 

    )
    begin {
        Write-Verbose "Invoke-NSJoinCluster: Starting"
    }
    process {
        try {
            $payload = @{ clip = $clip
                password       = $password
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Join Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type cluster -Action join -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSJoinCluster: Finished"
    }
}

function Invoke-NSSyncClusterfiles {
    <#
    .SYNOPSIS
        Sync Cluster commands. config Object.
    .DESCRIPTION
        Configuration for files resource.
    .PARAMETER Mode 
        The directories and files to be synchronized. The available settings function as follows: 
        Mode Paths 
        all /nsconfig/ssl/ 
        /var/netscaler/ssl/ 
        /var/vpn/bookmark/ 
        /nsconfig/dns/ 
        /nsconfig/monitors/ 
        /nsconfig/nstemplates/ 
        /nsconfig/ssh/ 
        /nsconfig/rc.netscaler 
        /nsconfig/resolv.conf 
        /nsconfig/inetd.conf 
        /nsconfig/syslog.conf 
        /nsconfig/ntp.conf 
        /nsconfig/httpd.conf 
        /nsconfig/sshd_config 
        /nsconfig/hosts 
        /nsconfig/enckey 
        /var/nslw.bin/etc/krb5.conf 
        /var/nslw.bin/etc/krb5.keytab 
        /var/lib/likewise/db/ 
        /var/download/ 
        /var/wi/tomcat/webapps/ 
        /var/wi/tomcat/conf/Catalina/localhost/ 
        /var/wi/java_home/lib/security/cacerts 
        /var/wi/java_home/jre/lib/security/cacerts 
        /var/netscaler/locdb/ 
        ssl /nsconfig/ssl/ 
        /var/netscaler/ssl/ 
        bookmarks /var/vpn/bookmark/ 
        dns /nsconfig/dns/ 
        imports /var/download/ 
        misc /nsconfig/license/ 
        /nsconfig/rc.conf 
        all_plus_misc Includes *all* files and /nsconfig/license/ and /nsconfig/rc.conf. 
         
        Possible values = all, bookmarks, ssl, imports, misc, dns, krb, AAA, app_catalog, all_plus_misc, all_minus_misc
    .EXAMPLE
        PS C:\>Invoke-NSSyncClusterfiles 
        An example how to sync clusterfiles config Object(s).
    .NOTES
        File Name : Invoke-NSSyncClusterfiles
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterfiles/
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

        [ValidateSet('all', 'bookmarks', 'ssl', 'imports', 'misc', 'dns', 'krb', 'AAA', 'app_catalog', 'all_plus_misc', 'all_minus_misc')]
        [string[]]$Mode 

    )
    begin {
        Write-Verbose "Invoke-NSSyncClusterfiles: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('mode') ) { $payload.Add('mode', $mode) }
            if ( $PSCmdlet.ShouldProcess($Name, "Sync Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type clusterfiles -Action sync -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSSyncClusterfiles: Finished"
    }
}

function Invoke-NSAddClusterinstance {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
         
        Maximum value = 16 
    .PARAMETER Deadinterval 
        Amount of time, in seconds, after which nodes that do not respond to the heartbeats are assumed to be down.If the value is less than 3 sec, set the helloInterval parameter to 200 msec. 
         
         
        Maximum value = 60 
    .PARAMETER Hellointerval 
        Interval, in milliseconds, at which heartbeats are sent to each cluster node to check the health status.Set the value to 200 msec, if the deadInterval parameter is less than 3 sec. 
         
         
        Maximum value = 1000 
    .PARAMETER Preemption 
        Preempt a cluster node that is configured as a SPARE if an ACTIVE node becomes available. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Quorumtype 
        Quorum Configuration Choices - "Majority" (recommended) requires majority of nodes to be online for the cluster to be UP. "None" relaxes this requirement. 
         
        Possible values = MAJORITY, NONE 
    .PARAMETER Inc 
        This option is required if the cluster nodes reside on different networks. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled. 
         
        Possible values = YES, NO 
    .PARAMETER Backplanebasedview 
        View based on heartbeat only on bkplane interface. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncstatusstrictmode 
        strict mode for sync status of cluster. Depending on the the mode if there are any errors while applying config, sync status is displayed accordingly. By default the flag is disabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dfdretainl2params 
        flag to add ext l2 header during steering. By default the flag is disabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Clusterproxyarp 
        This field controls the proxy arp feature in cluster. By default the flag is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created clusterinstance item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusterinstance -clid <double>
        An example how to add clusterinstance config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusterinstance
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterinstance/
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
        [double]$Clid,

        [double]$Deadinterval = '3',

        [double]$Hellointerval = '200',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Preemption = 'DISABLED',

        [ValidateSet('MAJORITY', 'NONE')]
        [string]$Quorumtype = 'MAJORITY',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Inc = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal = 'DISABLED',

        [ValidateSet('YES', 'NO')]
        [string]$Retainconnectionsoncluster = 'NO',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Backplanebasedview = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Syncstatusstrictmode = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dfdretainl2params = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Clusterproxyarp = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusterinstance: Starting"
    }
    process {
        try {
            $payload = @{ clid = $clid }
            if ( $PSBoundParameters.ContainsKey('deadinterval') ) { $payload.Add('deadinterval', $deadinterval) }
            if ( $PSBoundParameters.ContainsKey('hellointerval') ) { $payload.Add('hellointerval', $hellointerval) }
            if ( $PSBoundParameters.ContainsKey('preemption') ) { $payload.Add('preemption', $preemption) }
            if ( $PSBoundParameters.ContainsKey('quorumtype') ) { $payload.Add('quorumtype', $quorumtype) }
            if ( $PSBoundParameters.ContainsKey('inc') ) { $payload.Add('inc', $inc) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('retainconnectionsoncluster') ) { $payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ( $PSBoundParameters.ContainsKey('backplanebasedview') ) { $payload.Add('backplanebasedview', $backplanebasedview) }
            if ( $PSBoundParameters.ContainsKey('syncstatusstrictmode') ) { $payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
            if ( $PSBoundParameters.ContainsKey('dfdretainl2params') ) { $payload.Add('dfdretainl2params', $dfdretainl2params) }
            if ( $PSBoundParameters.ContainsKey('clusterproxyarp') ) { $payload.Add('clusterproxyarp', $clusterproxyarp) }
            if ( $PSCmdlet.ShouldProcess("clusterinstance", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type clusterinstance -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusterinstance -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusterinstance: Finished"
    }
}

function Invoke-NSDeleteClusterinstance {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
         
        Maximum value = 16
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusterinstance -Clid <double>
        An example how to delete clusterinstance config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusterinstance
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterinstance/
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
        [double]$Clid 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusterinstance: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$clid", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusterinstance -NitroPath nitro/v1/config -Resource $clid -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusterinstance: Finished"
    }
}

function Invoke-NSUpdateClusterinstance {
    <#
    .SYNOPSIS
        Update Cluster commands. config Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
         
        Maximum value = 16 
    .PARAMETER Deadinterval 
        Amount of time, in seconds, after which nodes that do not respond to the heartbeats are assumed to be down.If the value is less than 3 sec, set the helloInterval parameter to 200 msec. 
         
         
        Maximum value = 60 
    .PARAMETER Hellointerval 
        Interval, in milliseconds, at which heartbeats are sent to each cluster node to check the health status.Set the value to 200 msec, if the deadInterval parameter is less than 3 sec. 
         
         
        Maximum value = 1000 
    .PARAMETER Preemption 
        Preempt a cluster node that is configured as a SPARE if an ACTIVE node becomes available. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Quorumtype 
        Quorum Configuration Choices - "Majority" (recommended) requires majority of nodes to be online for the cluster to be UP. "None" relaxes this requirement. 
         
        Possible values = MAJORITY, NONE 
    .PARAMETER Inc 
        This option is required if the cluster nodes reside on different networks. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nodegroup 
        The node group in a Cluster system used for transition from L2 to L3. 
    .PARAMETER Retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled. 
         
        Possible values = YES, NO 
    .PARAMETER Backplanebasedview 
        View based on heartbeat only on bkplane interface. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncstatusstrictmode 
        strict mode for sync status of cluster. Depending on the the mode if there are any errors while applying config, sync status is displayed accordingly. By default the flag is disabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dfdretainl2params 
        flag to add ext l2 header during steering. By default the flag is disabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Clusterproxyarp 
        This field controls the proxy arp feature in cluster. By default the flag is enabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created clusterinstance item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateClusterinstance -clid <double>
        An example how to update clusterinstance config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateClusterinstance
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterinstance/
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
        [double]$Clid,

        [double]$Deadinterval,

        [double]$Hellointerval,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Preemption,

        [ValidateSet('MAJORITY', 'NONE')]
        [string]$Quorumtype,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Inc,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal,

        [string]$Nodegroup,

        [ValidateSet('YES', 'NO')]
        [string]$Retainconnectionsoncluster,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Backplanebasedview,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Syncstatusstrictmode,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dfdretainl2params,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Clusterproxyarp,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateClusterinstance: Starting"
    }
    process {
        try {
            $payload = @{ clid = $clid }
            if ( $PSBoundParameters.ContainsKey('deadinterval') ) { $payload.Add('deadinterval', $deadinterval) }
            if ( $PSBoundParameters.ContainsKey('hellointerval') ) { $payload.Add('hellointerval', $hellointerval) }
            if ( $PSBoundParameters.ContainsKey('preemption') ) { $payload.Add('preemption', $preemption) }
            if ( $PSBoundParameters.ContainsKey('quorumtype') ) { $payload.Add('quorumtype', $quorumtype) }
            if ( $PSBoundParameters.ContainsKey('inc') ) { $payload.Add('inc', $inc) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('nodegroup') ) { $payload.Add('nodegroup', $nodegroup) }
            if ( $PSBoundParameters.ContainsKey('retainconnectionsoncluster') ) { $payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ( $PSBoundParameters.ContainsKey('backplanebasedview') ) { $payload.Add('backplanebasedview', $backplanebasedview) }
            if ( $PSBoundParameters.ContainsKey('syncstatusstrictmode') ) { $payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
            if ( $PSBoundParameters.ContainsKey('dfdretainl2params') ) { $payload.Add('dfdretainl2params', $dfdretainl2params) }
            if ( $PSBoundParameters.ContainsKey('clusterproxyarp') ) { $payload.Add('clusterproxyarp', $clusterproxyarp) }
            if ( $PSCmdlet.ShouldProcess("clusterinstance", "Update Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusterinstance -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusterinstance -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateClusterinstance: Finished"
    }
}

function Invoke-NSUnsetClusterinstance {
    <#
    .SYNOPSIS
        Unset Cluster commands. config Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
         
        Maximum value = 16 
    .PARAMETER Deadinterval 
        Amount of time, in seconds, after which nodes that do not respond to the heartbeats are assumed to be down.If the value is less than 3 sec, set the helloInterval parameter to 200 msec. 
         
         
        Maximum value = 60 
    .PARAMETER Hellointerval 
        Interval, in milliseconds, at which heartbeats are sent to each cluster node to check the health status.Set the value to 200 msec, if the deadInterval parameter is less than 3 sec. 
         
         
        Maximum value = 1000 
    .PARAMETER Preemption 
        Preempt a cluster node that is configured as a SPARE if an ACTIVE node becomes available. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Quorumtype 
        Quorum Configuration Choices - "Majority" (recommended) requires majority of nodes to be online for the cluster to be UP. "None" relaxes this requirement. 
         
        Possible values = MAJORITY, NONE 
    .PARAMETER Inc 
        This option is required if the cluster nodes reside on different networks. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nodegroup 
        The node group in a Cluster system used for transition from L2 to L3. 
    .PARAMETER Retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled. 
         
        Possible values = YES, NO 
    .PARAMETER Backplanebasedview 
        View based on heartbeat only on bkplane interface. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncstatusstrictmode 
        strict mode for sync status of cluster. Depending on the the mode if there are any errors while applying config, sync status is displayed accordingly. By default the flag is disabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dfdretainl2params 
        flag to add ext l2 header during steering. By default the flag is disabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Clusterproxyarp 
        This field controls the proxy arp feature in cluster. By default the flag is enabled. 
         
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-NSUnsetClusterinstance -clid <double>
        An example how to unset clusterinstance config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetClusterinstance
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterinstance
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

        [double]$Clid,

        [Boolean]$deadinterval,

        [Boolean]$hellointerval,

        [Boolean]$preemption,

        [Boolean]$quorumtype,

        [Boolean]$inc,

        [Boolean]$processlocal,

        [Boolean]$nodegroup,

        [Boolean]$retainconnectionsoncluster,

        [Boolean]$backplanebasedview,

        [Boolean]$syncstatusstrictmode,

        [Boolean]$dfdretainl2params,

        [Boolean]$clusterproxyarp 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetClusterinstance: Starting"
    }
    process {
        try {
            $payload = @{ clid = $clid }
            if ( $PSBoundParameters.ContainsKey('deadinterval') ) { $payload.Add('deadinterval', $deadinterval) }
            if ( $PSBoundParameters.ContainsKey('hellointerval') ) { $payload.Add('hellointerval', $hellointerval) }
            if ( $PSBoundParameters.ContainsKey('preemption') ) { $payload.Add('preemption', $preemption) }
            if ( $PSBoundParameters.ContainsKey('quorumtype') ) { $payload.Add('quorumtype', $quorumtype) }
            if ( $PSBoundParameters.ContainsKey('inc') ) { $payload.Add('inc', $inc) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('nodegroup') ) { $payload.Add('nodegroup', $nodegroup) }
            if ( $PSBoundParameters.ContainsKey('retainconnectionsoncluster') ) { $payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ( $PSBoundParameters.ContainsKey('backplanebasedview') ) { $payload.Add('backplanebasedview', $backplanebasedview) }
            if ( $PSBoundParameters.ContainsKey('syncstatusstrictmode') ) { $payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
            if ( $PSBoundParameters.ContainsKey('dfdretainl2params') ) { $payload.Add('dfdretainl2params', $dfdretainl2params) }
            if ( $PSBoundParameters.ContainsKey('clusterproxyarp') ) { $payload.Add('clusterproxyarp', $clusterproxyarp) }
            if ( $PSCmdlet.ShouldProcess("$clid", "Unset Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type clusterinstance -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetClusterinstance: Finished"
    }
}

function Invoke-NSEnableClusterinstance {
    <#
    .SYNOPSIS
        Enable Cluster commands. config Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
         
        Maximum value = 16
    .EXAMPLE
        PS C:\>Invoke-NSEnableClusterinstance -clid <double>
        An example how to enable clusterinstance config Object(s).
    .NOTES
        File Name : Invoke-NSEnableClusterinstance
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterinstance/
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
        [double]$Clid 

    )
    begin {
        Write-Verbose "Invoke-NSEnableClusterinstance: Starting"
    }
    process {
        try {
            $payload = @{ clid = $clid }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type clusterinstance -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableClusterinstance: Finished"
    }
}

function Invoke-NSDisableClusterinstance {
    <#
    .SYNOPSIS
        Disable Cluster commands. config Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
         
        Maximum value = 16
    .EXAMPLE
        PS C:\>Invoke-NSDisableClusterinstance -clid <double>
        An example how to disable clusterinstance config Object(s).
    .NOTES
        File Name : Invoke-NSDisableClusterinstance
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterinstance/
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
        [double]$Clid 

    )
    begin {
        Write-Verbose "Invoke-NSDisableClusterinstance: Starting"
    }
    process {
        try {
            $payload = @{ clid = $clid }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type clusterinstance -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableClusterinstance: Finished"
    }
}

function Invoke-NSGetClusterinstance {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
         
        Maximum value = 16 
    .PARAMETER GetAll 
        Retrieve all clusterinstance object(s).
    .PARAMETER Count
        If specified, the count of the clusterinstance object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterinstance
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusterinstance -GetAll 
        Get all clusterinstance data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusterinstance -Count 
        Get the number of clusterinstance objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterinstance -name <string>
        Get clusterinstance object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterinstance -Filter @{ 'name'='<value>' }
        Get clusterinstance data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusterinstance
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterinstance/
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
        [double]$Clid,

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
        Write-Verbose "Invoke-NSGetClusterinstance: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clusterinstance objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance configuration for property 'clid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusterinstance: Ended"
    }
}

function Invoke-NSGetClusterinstanceBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to clusterinstance.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
         
        Maximum value = 16 
    .PARAMETER GetAll 
        Retrieve all clusterinstance_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusterinstance_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterinstanceBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusterinstanceBinding -GetAll 
        Get all clusterinstance_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterinstanceBinding -name <string>
        Get clusterinstance_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterinstanceBinding -Filter @{ 'name'='<value>' }
        Get clusterinstance_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusterinstanceBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterinstance_binding/
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
        [double]$Clid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetClusterinstanceBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusterinstance_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance_binding configuration for property 'clid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusterinstanceBinding: Ended"
    }
}

function Invoke-NSGetClusterinstanceClusternodeBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the clusternode that can be bound to clusterinstance.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
         
        Maximum value = 16 
    .PARAMETER GetAll 
        Retrieve all clusterinstance_clusternode_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusterinstance_clusternode_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterinstanceClusternodeBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusterinstanceClusternodeBinding -GetAll 
        Get all clusterinstance_clusternode_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusterinstanceClusternodeBinding -Count 
        Get the number of clusterinstance_clusternode_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterinstanceClusternodeBinding -name <string>
        Get clusterinstance_clusternode_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterinstanceClusternodeBinding -Filter @{ 'name'='<value>' }
        Get clusterinstance_clusternode_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusterinstanceClusternodeBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterinstance_clusternode_binding/
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
        [double]$Clid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetClusterinstanceClusternodeBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusterinstance_clusternode_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance_clusternode_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance_clusternode_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance_clusternode_binding configuration for property 'clid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance_clusternode_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusterinstanceClusternodeBinding: Ended"
    }
}

function Invoke-NSAddClusternode {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Configuration for cluster node resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER Ipaddress 
        Citrix ADC IP (NSIP) address of the appliance to add to the cluster. Must be an IPv4 address. 
    .PARAMETER State 
        Admin state of the cluster node. The available settings function as follows: 
        ACTIVE - The node serves traffic. 
        SPARE - The node does not serve traffic unless an ACTIVE node goes down. 
        PASSIVE - The node does not serve traffic, unless you change its state. PASSIVE state is useful during temporary maintenance activities in which you want the node to take part in the consensus protocol but not to serve traffic. 
         
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER Backplane 
        Interface through which the node communicates with the other nodes in the cluster. Must be specified in the three-tuple form n/c/u, where n represents the node ID and c/u refers to the interface on the appliance. 
    .PARAMETER Priority 
        Preference for selecting a node as the configuration coordinator. The node with the lowest priority value is selected as the configuration coordinator. 
        When the current configuration coordinator goes down, the node with the next lowest priority is made the new configuration coordinator. When the original node comes back up, it will preempt the new configuration coordinator and take over as the configuration coordinator. 
        Note: When priority is not configured for any of the nodes or if multiple nodes have the same priority, the cluster elects one of the nodes as the configuration coordinator. 
         
         
        Maximum value = 31 
    .PARAMETER Nodegroup 
        The default node group in a Cluster system. 
    .PARAMETER Delay 
        Applicable for Passive node and node becomes passive after this timeout (in minutes). 
         
         
        Maximum value = 1440 
    .PARAMETER Tunnelmode 
        To set the tunnel mode. 
         
        Possible values = NONE, GRE, UDP 
    .PARAMETER PassThru 
        Return details about the created clusternode item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternode -nodeid <double> -ipaddress <string>
        An example how to add clusternode config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternode
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternode/
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
        [double]$Nodeid,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipaddress,

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$State = 'PASSIVE',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backplane,

        [double]$Priority = '31',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Nodegroup = 'DEFAULT_NG',

        [double]$Delay = '0',

        [ValidateSet('NONE', 'GRE', 'UDP')]
        [string]$Tunnelmode = 'NONE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternode: Starting"
    }
    process {
        try {
            $payload = @{ nodeid = $nodeid
                ipaddress        = $ipaddress
            }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('backplane') ) { $payload.Add('backplane', $backplane) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nodegroup') ) { $payload.Add('nodegroup', $nodegroup) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('tunnelmode') ) { $payload.Add('tunnelmode', $tunnelmode) }
            if ( $PSCmdlet.ShouldProcess("clusternode", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type clusternode -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternode -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternode: Finished"
    }
}

function Invoke-NSUpdateClusternode {
    <#
    .SYNOPSIS
        Update Cluster commands. config Object.
    .DESCRIPTION
        Configuration for cluster node resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER State 
        Admin state of the cluster node. The available settings function as follows: 
        ACTIVE - The node serves traffic. 
        SPARE - The node does not serve traffic unless an ACTIVE node goes down. 
        PASSIVE - The node does not serve traffic, unless you change its state. PASSIVE state is useful during temporary maintenance activities in which you want the node to take part in the consensus protocol but not to serve traffic. 
         
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER Backplane 
        Interface through which the node communicates with the other nodes in the cluster. Must be specified in the three-tuple form n/c/u, where n represents the node ID and c/u refers to the interface on the appliance. 
    .PARAMETER Priority 
        Preference for selecting a node as the configuration coordinator. The node with the lowest priority value is selected as the configuration coordinator. 
        When the current configuration coordinator goes down, the node with the next lowest priority is made the new configuration coordinator. When the original node comes back up, it will preempt the new configuration coordinator and take over as the configuration coordinator. 
        Note: When priority is not configured for any of the nodes or if multiple nodes have the same priority, the cluster elects one of the nodes as the configuration coordinator. 
         
         
        Maximum value = 31 
    .PARAMETER Delay 
        Applicable for Passive node and node becomes passive after this timeout (in minutes). 
         
         
        Maximum value = 1440 
    .PARAMETER Tunnelmode 
        To set the tunnel mode. 
         
        Possible values = NONE, GRE, UDP 
    .PARAMETER PassThru 
        Return details about the created clusternode item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateClusternode -nodeid <double>
        An example how to update clusternode config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateClusternode
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternode/
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
        [double]$Nodeid,

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$State,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backplane,

        [double]$Priority,

        [double]$Delay,

        [ValidateSet('NONE', 'GRE', 'UDP')]
        [string]$Tunnelmode,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateClusternode: Starting"
    }
    process {
        try {
            $payload = @{ nodeid = $nodeid }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('backplane') ) { $payload.Add('backplane', $backplane) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('tunnelmode') ) { $payload.Add('tunnelmode', $tunnelmode) }
            if ( $PSCmdlet.ShouldProcess("clusternode", "Update Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternode -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternode -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateClusternode: Finished"
    }
}

function Invoke-NSUnsetClusternode {
    <#
    .SYNOPSIS
        Unset Cluster commands. config Object.
    .DESCRIPTION
        Configuration for cluster node resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER State 
        Admin state of the cluster node. The available settings function as follows: 
        ACTIVE - The node serves traffic. 
        SPARE - The node does not serve traffic unless an ACTIVE node goes down. 
        PASSIVE - The node does not serve traffic, unless you change its state. PASSIVE state is useful during temporary maintenance activities in which you want the node to take part in the consensus protocol but not to serve traffic. 
         
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER Backplane 
        Interface through which the node communicates with the other nodes in the cluster. Must be specified in the three-tuple form n/c/u, where n represents the node ID and c/u refers to the interface on the appliance. 
    .PARAMETER Priority 
        Preference for selecting a node as the configuration coordinator. The node with the lowest priority value is selected as the configuration coordinator. 
        When the current configuration coordinator goes down, the node with the next lowest priority is made the new configuration coordinator. When the original node comes back up, it will preempt the new configuration coordinator and take over as the configuration coordinator. 
        Note: When priority is not configured for any of the nodes or if multiple nodes have the same priority, the cluster elects one of the nodes as the configuration coordinator. 
         
         
        Maximum value = 31 
    .PARAMETER Delay 
        Applicable for Passive node and node becomes passive after this timeout (in minutes). 
         
         
        Maximum value = 1440 
    .PARAMETER Tunnelmode 
        To set the tunnel mode. 
         
        Possible values = NONE, GRE, UDP
    .EXAMPLE
        PS C:\>Invoke-NSUnsetClusternode -nodeid <double>
        An example how to unset clusternode config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetClusternode
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternode
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

        [double]$Nodeid,

        [Boolean]$state,

        [Boolean]$backplane,

        [Boolean]$priority,

        [Boolean]$delay,

        [Boolean]$tunnelmode 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetClusternode: Starting"
    }
    process {
        try {
            $payload = @{ nodeid = $nodeid }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('backplane') ) { $payload.Add('backplane', $backplane) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('tunnelmode') ) { $payload.Add('tunnelmode', $tunnelmode) }
            if ( $PSCmdlet.ShouldProcess("$nodeid", "Unset Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type clusternode -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetClusternode: Finished"
    }
}

function Invoke-NSDeleteClusternode {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Configuration for cluster node resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER Clearnodegroupconfig 
        Option to remove nodegroup config. 
         
        Possible values = YES, NO 
    .PARAMETER Force 
        Node will be removed from cluster without prompting for user confirmation.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternode -Nodeid <double>
        An example how to delete clusternode config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternode
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternode/
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
        [double]$Nodeid,

        [string]$Clearnodegroupconfig,

        [boolean]$Force 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternode: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Clearnodegroupconfig') ) { $arguments.Add('clearnodegroupconfig', $Clearnodegroupconfig) }
            if ( $PSBoundParameters.ContainsKey('Force') ) { $arguments.Add('force', $Force) }
            if ( $PSCmdlet.ShouldProcess("$nodeid", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternode -NitroPath nitro/v1/config -Resource $nodeid -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternode: Finished"
    }
}

function Invoke-NSGetClusternode {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Configuration for cluster node resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all clusternode object(s).
    .PARAMETER Count
        If specified, the count of the clusternode object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternode
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternode -GetAll 
        Get all clusternode data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternode -Count 
        Get the number of clusternode objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternode -name <string>
        Get clusternode object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternode -Filter @{ 'name'='<value>' }
        Get clusternode data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternode
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternode/
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
        [double]$Nodeid,

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
        Write-Verbose "Invoke-NSGetClusternode: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clusternode objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode configuration for property 'nodeid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternode: Ended"
    }
}

function Invoke-NSGetClusternodeBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to clusternode.
    .PARAMETER Nodeid 
        ID of the cluster node for which to display information. If an ID is not provided, information about all nodes is shown. 
         
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all clusternode_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternode_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodeBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodeBinding -GetAll 
        Get all clusternode_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodeBinding -name <string>
        Get clusternode_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodeBinding -Filter @{ 'name'='<value>' }
        Get clusternode_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodeBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternode_binding/
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
        [double]$Nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetClusternodeBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternode_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode_binding configuration for property 'nodeid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodeBinding: Ended"
    }
}

function Invoke-NSAddClusternodeRoutemonitorBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the routemonitor that can be bound to clusternode.
    .PARAMETER Nodeid 
        A number that uniquely identifies the cluster node. . 
         
        Maximum value = 31 
    .PARAMETER Routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER Netmask 
        The netmask. 
    .PARAMETER PassThru 
        Return details about the created clusternode_routemonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodeRoutemonitorBinding -nodeid <double> -routemonitor <string>
        An example how to add clusternode_routemonitor_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodeRoutemonitorBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternode_routemonitor_binding/
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
        [double]$Nodeid,

        [Parameter(Mandatory)]
        [string]$Routemonitor,

        [string]$Netmask,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodeRoutemonitorBinding: Starting"
    }
    process {
        try {
            $payload = @{ nodeid = $nodeid
                routemonitor     = $routemonitor
            }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSCmdlet.ShouldProcess("clusternode_routemonitor_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternode_routemonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodeRoutemonitorBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodeRoutemonitorBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodeRoutemonitorBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the routemonitor that can be bound to clusternode.
    .PARAMETER Nodeid 
        A number that uniquely identifies the cluster node. . 
         
        Maximum value = 31 
    .PARAMETER Routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER Netmask 
        The netmask.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodeRoutemonitorBinding -Nodeid <double>
        An example how to delete clusternode_routemonitor_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodeRoutemonitorBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternode_routemonitor_binding/
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
        [double]$Nodeid,

        [string]$Routemonitor,

        [string]$Netmask 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodeRoutemonitorBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Routemonitor') ) { $arguments.Add('routemonitor', $Routemonitor) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSCmdlet.ShouldProcess("$nodeid", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Resource $nodeid -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodeRoutemonitorBinding: Finished"
    }
}

function Invoke-NSGetClusternodeRoutemonitorBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the routemonitor that can be bound to clusternode.
    .PARAMETER Nodeid 
        A number that uniquely identifies the cluster node. . 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all clusternode_routemonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternode_routemonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodeRoutemonitorBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodeRoutemonitorBinding -GetAll 
        Get all clusternode_routemonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodeRoutemonitorBinding -Count 
        Get the number of clusternode_routemonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodeRoutemonitorBinding -name <string>
        Get clusternode_routemonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodeRoutemonitorBinding -Filter @{ 'name'='<value>' }
        Get clusternode_routemonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodeRoutemonitorBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternode_routemonitor_binding/
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
        [double]$Nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetClusternodeRoutemonitorBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternode_routemonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode_routemonitor_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode_routemonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode_routemonitor_binding configuration for property 'nodeid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode_routemonitor_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodeRoutemonitorBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroup {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Configuration for Node group object type resource.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Strict 
        Specifies whether cluster nodes, that are not part of the nodegroup, will be used as backup for the nodegroup. 
        * Enabled - When one of the nodes goes down, no other cluster node is picked up to replace it. When the node comes up, it will continue being part of the nodegroup. 
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced. 
         
        Possible values = YES, NO 
    .PARAMETER Sticky 
        Only one node can be bound to nodegroup with this option enabled. It specifies whether to prempt the traffic for the entities bound to nodegroup when owner node goes down and rejoins the cluster. 
        * Enabled - When owner node goes down, backup node will become the owner node and takes the traffic for the entities bound to the nodegroup. When bound node rejoins the cluster, traffic for the entities bound to nodegroup will not be steered back to this bound node. Current owner will have the ownership till it goes down. 
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced. 
         
        Possible values = YES, NO 
    .PARAMETER State 
        State of the nodegroup. All the nodes binding to this nodegroup must have the same state. ACTIVE/SPARE/PASSIVE. 
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER Priority 
        Priority of Nodegroup. This priority is used for all the nodes bound to the nodegroup for Nodegroup selection. 
         
        Maximum value = 31 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroup -name <string>
        An example how to add clusternodegroup config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup/
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

        [ValidateSet('YES', 'NO')]
        [string]$Strict = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Sticky = 'NO',

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$State,

        [double]$Priority,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('strict') ) { $payload.Add('strict', $strict) }
            if ( $PSBoundParameters.ContainsKey('sticky') ) { $payload.Add('sticky', $sticky) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type clusternodegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroup -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroup: Finished"
    }
}

function Invoke-NSUpdateClusternodegroup {
    <#
    .SYNOPSIS
        Update Cluster commands. config Object.
    .DESCRIPTION
        Configuration for Node group object type resource.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Strict 
        Specifies whether cluster nodes, that are not part of the nodegroup, will be used as backup for the nodegroup. 
        * Enabled - When one of the nodes goes down, no other cluster node is picked up to replace it. When the node comes up, it will continue being part of the nodegroup. 
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced. 
         
        Possible values = YES, NO 
    .PARAMETER State 
        State of the nodegroup. All the nodes binding to this nodegroup must have the same state. ACTIVE/SPARE/PASSIVE. 
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER Priority 
        Priority of Nodegroup. This priority is used for all the nodes bound to the nodegroup for Nodegroup selection. 
         
        Maximum value = 31 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateClusternodegroup -name <string>
        An example how to update clusternodegroup config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateClusternodegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup/
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

        [ValidateSet('YES', 'NO')]
        [string]$Strict,

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$State,

        [double]$Priority,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateClusternodegroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('strict') ) { $payload.Add('strict', $strict) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup", "Update Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroup -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateClusternodegroup: Finished"
    }
}

function Invoke-NSUnsetClusternodegroup {
    <#
    .SYNOPSIS
        Unset Cluster commands. config Object.
    .DESCRIPTION
        Configuration for Node group object type resource.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Strict 
        Specifies whether cluster nodes, that are not part of the nodegroup, will be used as backup for the nodegroup. 
        * Enabled - When one of the nodes goes down, no other cluster node is picked up to replace it. When the node comes up, it will continue being part of the nodegroup. 
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced. 
         
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-NSUnsetClusternodegroup -name <string>
        An example how to unset clusternodegroup config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetClusternodegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup
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

        [Boolean]$strict 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetClusternodegroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('strict') ) { $payload.Add('strict', $strict) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type clusternodegroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetClusternodegroup: Finished"
    }
}

function Invoke-NSDeleteClusternodegroup {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Configuration for Node group object type resource.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroup -Name <string>
        An example how to delete clusternodegroup config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup/
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
        Write-Verbose "Invoke-NSDeleteClusternodegroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroup: Finished"
    }
}

function Invoke-NSGetClusternodegroup {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Configuration for Node group object type resource.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER GetAll 
        Retrieve all clusternodegroup object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroup -GetAll 
        Get all clusternodegroup data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroup -Count 
        Get the number of clusternodegroup objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroup -name <string>
        Get clusternodegroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroup -Filter @{ 'name'='<value>' }
        Get clusternodegroup data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup/
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
        Write-Verbose "Invoke-NSGetClusternodegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clusternodegroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroup: Ended"
    }
}

function Invoke-NSAddClusternodegroupAuthenticationvserverBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_authenticationvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupAuthenticationvserverBinding -name <string>
        An example how to add clusternodegroup_authenticationvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupAuthenticationvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_authenticationvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupAuthenticationvserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_authenticationvserver_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_authenticationvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupAuthenticationvserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupAuthenticationvserverBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupAuthenticationvserverBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupAuthenticationvserverBinding 
        An example how to delete clusternodegroup_authenticationvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupAuthenticationvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_authenticationvserver_binding/
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

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupAuthenticationvserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_authenticationvserver_binding", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupAuthenticationvserverBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupAuthenticationvserverBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_authenticationvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_authenticationvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupAuthenticationvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupAuthenticationvserverBinding -GetAll 
        Get all clusternodegroup_authenticationvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupAuthenticationvserverBinding -Count 
        Get the number of clusternodegroup_authenticationvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupAuthenticationvserverBinding -name <string>
        Get clusternodegroup_authenticationvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupAuthenticationvserverBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_authenticationvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupAuthenticationvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_authenticationvserver_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupAuthenticationvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_authenticationvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_authenticationvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_authenticationvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_authenticationvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_authenticationvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupAuthenticationvserverBinding: Ended"
    }
}

function Invoke-NSGetClusternodegroupBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to be displayed. If a name is not provided, information about all nodegroups is displayed. 
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupBinding -GetAll 
        Get all clusternodegroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupBinding -name <string>
        Get clusternodegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroupClusternodeBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the clusternode that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Node 
        Nodes in the nodegroup. 
         
        Maximum value = 31 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_clusternode_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupClusternodeBinding -name <string>
        An example how to add clusternodegroup_clusternode_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupClusternodeBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_clusternode_binding/
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

        [double]$Node,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupClusternodeBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('node') ) { $payload.Add('node', $node) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_clusternode_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_clusternode_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupClusternodeBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupClusternodeBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupClusternodeBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the clusternode that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Node 
        Nodes in the nodegroup. 
         
        Maximum value = 31
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupClusternodeBinding 
        An example how to delete clusternodegroup_clusternode_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupClusternodeBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_clusternode_binding/
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

        [double]$Node 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupClusternodeBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Node') ) { $arguments.Add('node', $Node) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_clusternode_binding", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupClusternodeBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupClusternodeBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the clusternode that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_clusternode_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_clusternode_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupClusternodeBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupClusternodeBinding -GetAll 
        Get all clusternodegroup_clusternode_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupClusternodeBinding -Count 
        Get the number of clusternodegroup_clusternode_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupClusternodeBinding -name <string>
        Get clusternodegroup_clusternode_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupClusternodeBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_clusternode_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupClusternodeBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_clusternode_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupClusternodeBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_clusternode_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_clusternode_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_clusternode_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_clusternode_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_clusternode_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupClusternodeBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroupCrvserverBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_crvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupCrvserverBinding -name <string>
        An example how to add clusternodegroup_crvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupCrvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_crvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupCrvserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_crvserver_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_crvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupCrvserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupCrvserverBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupCrvserverBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupCrvserverBinding 
        An example how to delete clusternodegroup_crvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupCrvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_crvserver_binding/
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

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupCrvserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_crvserver_binding", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupCrvserverBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupCrvserverBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupCrvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupCrvserverBinding -GetAll 
        Get all clusternodegroup_crvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupCrvserverBinding -Count 
        Get the number of clusternodegroup_crvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupCrvserverBinding -name <string>
        Get clusternodegroup_crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupCrvserverBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupCrvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_crvserver_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupCrvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_crvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_crvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_crvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupCrvserverBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroupCsvserverBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_csvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupCsvserverBinding -name <string>
        An example how to add clusternodegroup_csvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupCsvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_csvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupCsvserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_csvserver_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_csvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupCsvserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupCsvserverBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupCsvserverBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupCsvserverBinding 
        An example how to delete clusternodegroup_csvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupCsvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_csvserver_binding/
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

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupCsvserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_csvserver_binding", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupCsvserverBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupCsvserverBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupCsvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupCsvserverBinding -GetAll 
        Get all clusternodegroup_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupCsvserverBinding -Count 
        Get the number of clusternodegroup_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupCsvserverBinding -name <string>
        Get clusternodegroup_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupCsvserverBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupCsvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_csvserver_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupCsvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_csvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_csvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_csvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupCsvserverBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroupGslbsiteBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the gslbsite that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Gslbsite 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_gslbsite_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupGslbsiteBinding -name <string>
        An example how to add clusternodegroup_gslbsite_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupGslbsiteBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_gslbsite_binding/
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

        [string]$Gslbsite,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupGslbsiteBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('gslbsite') ) { $payload.Add('gslbsite', $gslbsite) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_gslbsite_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_gslbsite_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupGslbsiteBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupGslbsiteBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupGslbsiteBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the gslbsite that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Gslbsite 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupGslbsiteBinding 
        An example how to delete clusternodegroup_gslbsite_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupGslbsiteBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_gslbsite_binding/
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

        [string]$Gslbsite 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupGslbsiteBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Gslbsite') ) { $arguments.Add('gslbsite', $Gslbsite) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_gslbsite_binding", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupGslbsiteBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupGslbsiteBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the gslbsite that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_gslbsite_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_gslbsite_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupGslbsiteBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupGslbsiteBinding -GetAll 
        Get all clusternodegroup_gslbsite_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupGslbsiteBinding -Count 
        Get the number of clusternodegroup_gslbsite_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupGslbsiteBinding -name <string>
        Get clusternodegroup_gslbsite_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupGslbsiteBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_gslbsite_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupGslbsiteBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_gslbsite_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupGslbsiteBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_gslbsite_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_gslbsite_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbsite_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbsite_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_gslbsite_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupGslbsiteBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroupGslbvserverBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_gslbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupGslbvserverBinding -name <string>
        An example how to add clusternodegroup_gslbvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupGslbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_gslbvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupGslbvserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_gslbvserver_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_gslbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupGslbvserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupGslbvserverBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupGslbvserverBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupGslbvserverBinding 
        An example how to delete clusternodegroup_gslbvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupGslbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_gslbvserver_binding/
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

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupGslbvserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_gslbvserver_binding", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupGslbvserverBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupGslbvserverBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_gslbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_gslbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupGslbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupGslbvserverBinding -GetAll 
        Get all clusternodegroup_gslbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupGslbvserverBinding -Count 
        Get the number of clusternodegroup_gslbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupGslbvserverBinding -name <string>
        Get clusternodegroup_gslbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupGslbvserverBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_gslbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupGslbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_gslbvserver_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupGslbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_gslbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_gslbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_gslbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupGslbvserverBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroupLbvserverBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_lbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupLbvserverBinding -name <string>
        An example how to add clusternodegroup_lbvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_lbvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupLbvserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_lbvserver_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_lbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupLbvserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupLbvserverBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupLbvserverBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupLbvserverBinding 
        An example how to delete clusternodegroup_lbvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_lbvserver_binding/
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

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupLbvserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_lbvserver_binding", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupLbvserverBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupLbvserverBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupLbvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupLbvserverBinding -GetAll 
        Get all clusternodegroup_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupLbvserverBinding -Count 
        Get the number of clusternodegroup_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupLbvserverBinding -name <string>
        Get clusternodegroup_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupLbvserverBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupLbvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_lbvserver_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupLbvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_lbvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_lbvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_lbvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupLbvserverBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroupNslimitidentifierBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the nslimitidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER Identifiername 
        stream identifier and rate limit identifier that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_nslimitidentifier_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupNslimitidentifierBinding -name <string>
        An example how to add clusternodegroup_nslimitidentifier_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupNslimitidentifierBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_nslimitidentifier_binding/
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

        [string]$Identifiername,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupNslimitidentifierBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('identifiername') ) { $payload.Add('identifiername', $identifiername) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_nslimitidentifier_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_nslimitidentifier_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupNslimitidentifierBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupNslimitidentifierBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupNslimitidentifierBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the nslimitidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER Identifiername 
        stream identifier and rate limit identifier that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupNslimitidentifierBinding -Name <string>
        An example how to delete clusternodegroup_nslimitidentifier_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupNslimitidentifierBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_nslimitidentifier_binding/
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

        [string]$Identifiername 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupNslimitidentifierBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Identifiername') ) { $arguments.Add('identifiername', $Identifiername) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupNslimitidentifierBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupNslimitidentifierBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the nslimitidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_nslimitidentifier_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_nslimitidentifier_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupNslimitidentifierBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupNslimitidentifierBinding -GetAll 
        Get all clusternodegroup_nslimitidentifier_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupNslimitidentifierBinding -Count 
        Get the number of clusternodegroup_nslimitidentifier_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupNslimitidentifierBinding -name <string>
        Get clusternodegroup_nslimitidentifier_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupNslimitidentifierBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_nslimitidentifier_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupNslimitidentifierBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_nslimitidentifier_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupNslimitidentifierBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_nslimitidentifier_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_nslimitidentifier_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_nslimitidentifier_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_nslimitidentifier_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup_nslimitidentifier_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupNslimitidentifierBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroupServiceBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the service that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Service 
        name of the service bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_service_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupServiceBinding -name <string>
        An example how to add clusternodegroup_service_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupServiceBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_service_binding/
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

        [string]$Service,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupServiceBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('service') ) { $payload.Add('service', $service) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_service_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_service_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupServiceBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupServiceBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupServiceBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the service that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Service 
        name of the service bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupServiceBinding 
        An example how to delete clusternodegroup_service_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupServiceBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_service_binding/
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

        [string]$Service 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupServiceBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Service') ) { $arguments.Add('service', $Service) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_service_binding", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupServiceBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupServiceBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the service that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_service_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_service_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupServiceBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupServiceBinding -GetAll 
        Get all clusternodegroup_service_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupServiceBinding -Count 
        Get the number of clusternodegroup_service_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupServiceBinding -name <string>
        Get clusternodegroup_service_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupServiceBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_service_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupServiceBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_service_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupServiceBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_service_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_service_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_service_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_service_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_service_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupServiceBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroupStreamidentifierBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the streamidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER Identifiername 
        stream identifier and rate limit identifier that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_streamidentifier_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupStreamidentifierBinding -name <string>
        An example how to add clusternodegroup_streamidentifier_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupStreamidentifierBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_streamidentifier_binding/
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

        [string]$Identifiername,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupStreamidentifierBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('identifiername') ) { $payload.Add('identifiername', $identifiername) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_streamidentifier_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_streamidentifier_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupStreamidentifierBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupStreamidentifierBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupStreamidentifierBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the streamidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER Identifiername 
        stream identifier and rate limit identifier that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupStreamidentifierBinding -Name <string>
        An example how to delete clusternodegroup_streamidentifier_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupStreamidentifierBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_streamidentifier_binding/
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

        [string]$Identifiername 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupStreamidentifierBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Identifiername') ) { $arguments.Add('identifiername', $Identifiername) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupStreamidentifierBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupStreamidentifierBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the streamidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_streamidentifier_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_streamidentifier_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupStreamidentifierBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupStreamidentifierBinding -GetAll 
        Get all clusternodegroup_streamidentifier_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupStreamidentifierBinding -Count 
        Get the number of clusternodegroup_streamidentifier_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupStreamidentifierBinding -name <string>
        Get clusternodegroup_streamidentifier_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupStreamidentifierBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_streamidentifier_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupStreamidentifierBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_streamidentifier_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupStreamidentifierBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_streamidentifier_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_streamidentifier_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_streamidentifier_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_streamidentifier_binding configuration for property 'name'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup_streamidentifier_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupStreamidentifierBinding: Ended"
    }
}

function Invoke-NSAddClusternodegroupVpnvserverBinding {
    <#
    .SYNOPSIS
        Add Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_vpnvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddClusternodegroupVpnvserverBinding -name <string>
        An example how to add clusternodegroup_vpnvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddClusternodegroupVpnvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_vpnvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddClusternodegroupVpnvserverBinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_vpnvserver_binding", "Add Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_vpnvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetClusternodegroupVpnvserverBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddClusternodegroupVpnvserverBinding: Finished"
    }
}

function Invoke-NSDeleteClusternodegroupVpnvserverBinding {
    <#
    .SYNOPSIS
        Delete Cluster commands. config Object.
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteClusternodegroupVpnvserverBinding 
        An example how to delete clusternodegroup_vpnvserver_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteClusternodegroupVpnvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_vpnvserver_binding/
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

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteClusternodegroupVpnvserverBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_vpnvserver_binding", "Delete Cluster commands. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteClusternodegroupVpnvserverBinding: Finished"
    }
}

function Invoke-NSGetClusternodegroupVpnvserverBinding {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupVpnvserverBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupVpnvserverBinding -GetAll 
        Get all clusternodegroup_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusternodegroupVpnvserverBinding -Count 
        Get the number of clusternodegroup_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupVpnvserverBinding -name <string>
        Get clusternodegroup_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusternodegroupVpnvserverBinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusternodegroupVpnvserverBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusternodegroup_vpnvserver_binding/
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
        Write-Verbose "Invoke-NSGetClusternodegroupVpnvserverBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_vpnvserver_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_vpnvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_vpnvserver_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusternodegroupVpnvserverBinding: Ended"
    }
}

function Invoke-NSClearClusterpropstatus {
    <#
    .SYNOPSIS
        Clear Cluster commands. config Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .EXAMPLE
        PS C:\>Invoke-NSClearClusterpropstatus 
        An example how to clear clusterpropstatus config Object(s).
    .NOTES
        File Name : Invoke-NSClearClusterpropstatus
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterpropstatus/
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
        Write-Verbose "Invoke-NSClearClusterpropstatus: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type clusterpropstatus -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSClearClusterpropstatus: Finished"
    }
}

function Invoke-NSGetClusterpropstatus {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all clusterpropstatus object(s).
    .PARAMETER Count
        If specified, the count of the clusterpropstatus object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterpropstatus
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusterpropstatus -GetAll 
        Get all clusterpropstatus data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetClusterpropstatus -Count 
        Get the number of clusterpropstatus objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterpropstatus -name <string>
        Get clusterpropstatus object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClusterpropstatus -Filter @{ 'name'='<value>' }
        Get clusterpropstatus data with a filter.
    .NOTES
        File Name : Invoke-NSGetClusterpropstatus
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clusterpropstatus/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-NSGetClusterpropstatus: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clusterpropstatus objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterpropstatus objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterpropstatus objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterpropstatus configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusterpropstatus configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClusterpropstatus: Ended"
    }
}

function Invoke-NSForceClustersync {
    <#
    .SYNOPSIS
        Force Cluster commands. config Object.
    .DESCRIPTION
        Configuration for sync resource.
    .EXAMPLE
        PS C:\>Invoke-NSForceClustersync 
        An example how to force clustersync config Object(s).
    .NOTES
        File Name : Invoke-NSForceClustersync
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clustersync/
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
        Write-Verbose "Invoke-NSForceClustersync: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Force Cluster commands. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type clustersync -Action force -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSForceClustersync: Finished"
    }
}

function Invoke-NSGetClustersyncfailures {
    <#
    .SYNOPSIS
        Get Cluster commands. config object(s).
    .DESCRIPTION
        Configuration for Cluster sync failures resource.
    .PARAMETER GetAll 
        Retrieve all clustersyncfailures object(s).
    .PARAMETER Count
        If specified, the count of the clustersyncfailures object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetClustersyncfailures
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetClustersyncfailures -GetAll 
        Get all clustersyncfailures data.
    .EXAMPLE
        PS C:\>Invoke-NSGetClustersyncfailures -name <string>
        Get clustersyncfailures object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetClustersyncfailures -Filter @{ 'name'='<value>' }
        Get clustersyncfailures data with a filter.
    .NOTES
        File Name : Invoke-NSGetClustersyncfailures
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/cluster/clustersyncfailures/
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
        Write-Verbose "Invoke-NSGetClustersyncfailures: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clustersyncfailures objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clustersyncfailures -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clustersyncfailures objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clustersyncfailures -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clustersyncfailures objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clustersyncfailures -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clustersyncfailures configuration for property ''"

            } else {
                Write-Verbose "Retrieving clustersyncfailures configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type clustersyncfailures -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetClustersyncfailures: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCBgE3z+BgQB2TN
# jO1/H5ObyRioEJG1bnvnEVxCWBp0JqCCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQgZ7wZOdRJCIxWQ5d2fwJHpiV8V97O+ZPv26KYNYRU0vMwDQYJ
# KoZIhvcNAQEBBQAEggEAYFiI3Skw52cm+BkoXhVUNEq4/BTwnAkwRZfycUv2synY
# UJOy0CVHHJUG5xI3uro6Jr8cuLvWaE+qMZJhybiSVViZrPZ6D8TC/FrfWFV64ON5
# qRUSI3K0Yb5GwaL/qxhM0tDwW3BZicYiA3j3I2LMlUs730BcNklqETdXnihiEZId
# r5K9Oh+AvXlcn8L0EsOhpKN3RruQyVGjsh3BnIp35YK1I6WRanTd1SxuK/qDBL3K
# IcBVMUAJFRmEetmOeTcdvd9yCe3Oz3KCl0nC1xW7HsA2XU8JCz7ZO6RtMFcbrNJO
# MjHseRB6NgVm7PliAl19BwHtBJnTWlvtm5COHkUdtKGCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQyMDFaMD8GCSqG
# SIb3DQEJBDEyBDDVwsEmRMHEJy0lMEsKCYo9dsPgvY4DEO7jbPfMNizdUUFPAlZG
# BUfXMKKsg5awVHAwDQYJKoZIhvcNAQEBBQAEggIAQlT1E4GJ0STG4A2iNi67qleR
# q7cw819AYhaoWRGinfIW6lspoS3G2lJZxCE0r7iJTdTu8brnXBolQ77S5idddPJX
# esX7UQWkmWhgCzW4MpgdWcNrnrkGnOg/Qzvxod+rNKkCjSWnFNYr7LKxxMwqs6xA
# 9cUoy1CuN9OlZchpoCOCUxWl3ETa4NmSjvs17pW7YGlS3wyaNF4UqVAxRkC5hBSy
# kynWCM/Tglg2TVx+/9bmJIsWx9UqzqeqPTxj+ByEWi0rKhM1a4YZNNddgdBU2eKw
# XG5mESkJDXC4MOjFhMX6kPmy9uT6OKAT+z5pqsJCNkfdKRLjeHzbYtV+Xn8UjMpH
# 6qHG/W7tE4GhYU7R1rBqmQzrvSuaO25vqchnK2R1Z0q4+mMXeYLFDwwfEgb12q0r
# oKGXWv2BrHWXhVG8xrf7z9k/z75wkSezG98QtbdziQGnLlTZEJdFZbvDDEiZ/Vhc
# oU2SAUXYxXldtNF3w3bvHoyRzbPGRYgo4s5yrlr6dUgVHrx9RPA+mYVb4e60Y0bK
# O4OA87iJmf9l0RdMt/wIAdqcmWPt5sTiBPJYqRJjY5LwdAIwFstykSfEE9htdcgF
# kbaP6Uh0ZR7XS459iK2cYTZ+qmC9nnrBFXMtudAsZbpsUsUTznhEsVn/BQ6hSY48
# m7Ivgoe1C0pnFVluTwI=
# SIG # End signature block
