function Invoke-NSUpdateSystemadmuserinfo {
    <#
    .SYNOPSIS
        Update System configuration. config Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Username 
        Name of adm-user to log in syslogs.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSystemadmuserinfo 
        An example how to update systemadmuserinfo config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSystemadmuserinfo
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemadmuserinfo/
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
        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSystemadmuserinfo: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSCmdlet.ShouldProcess("systemadmuserinfo", "Update System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemadmuserinfo -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateSystemadmuserinfo: Finished"
    }
}

function Invoke-NSEnableSystemautorestorefeature {
    <#
    .SYNOPSIS
        Enable System configuration. config Object.
    .DESCRIPTION
        Configuration for Enable/Disable the autorestore feature use to create restorepoint resource.
    .EXAMPLE
        PS C:\>Invoke-NSEnableSystemautorestorefeature 
        An example how to enable systemautorestorefeature config Object(s).
    .NOTES
        File Name : Invoke-NSEnableSystemautorestorefeature
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemautorestorefeature/
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
        Write-Verbose "Invoke-NSEnableSystemautorestorefeature: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemautorestorefeature -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableSystemautorestorefeature: Finished"
    }
}

function Invoke-NSDisableSystemautorestorefeature {
    <#
    .SYNOPSIS
        Disable System configuration. config Object.
    .DESCRIPTION
        Configuration for Enable/Disable the autorestore feature use to create restorepoint resource.
    .EXAMPLE
        PS C:\>Invoke-NSDisableSystemautorestorefeature 
        An example how to disable systemautorestorefeature config Object(s).
    .NOTES
        File Name : Invoke-NSDisableSystemautorestorefeature
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemautorestorefeature/
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
        Write-Verbose "Invoke-NSDisableSystemautorestorefeature: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemautorestorefeature -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableSystemautorestorefeature: Finished"
    }
}

function Invoke-NSCreateSystembackup {
    <#
    .SYNOPSIS
        Create System configuration. config Object.
    .DESCRIPTION
        Configuration for Backup Data for ns backup and restore resource.
    .PARAMETER Filename 
        Name of the backup file(*.tgz) to be restored. 
    .PARAMETER Uselocaltimezone 
        This option will create backup file with local timezone timestamp. 
    .PARAMETER Level 
        Level of data to be backed up. 
         
        Possible values = basic, full 
    .PARAMETER Includekernel 
        Use this option to add kernel in the backup file. 
         
        Possible values = NO, YES 
    .PARAMETER Comment 
        Comment specified at the time of creation of the backup file(*.tgz).
    .EXAMPLE
        PS C:\>Invoke-NSCreateSystembackup 
        An example how to create systembackup config Object(s).
    .NOTES
        File Name : Invoke-NSCreateSystembackup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systembackup/
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

        [string]$Filename,

        [boolean]$Uselocaltimezone,

        [ValidateSet('basic', 'full')]
        [string]$Level,

        [ValidateSet('NO', 'YES')]
        [string]$Includekernel,

        [string]$Comment 

    )
    begin {
        Write-Verbose "Invoke-NSCreateSystembackup: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('filename') ) { $payload.Add('filename', $filename) }
            if ( $PSBoundParameters.ContainsKey('uselocaltimezone') ) { $payload.Add('uselocaltimezone', $uselocaltimezone) }
            if ( $PSBoundParameters.ContainsKey('level') ) { $payload.Add('level', $level) }
            if ( $PSBoundParameters.ContainsKey('includekernel') ) { $payload.Add('includekernel', $includekernel) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess($Name, "Create System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systembackup -Action create -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSCreateSystembackup: Finished"
    }
}

function Invoke-NSRestoreSystembackup {
    <#
    .SYNOPSIS
        Restore System configuration. config Object.
    .DESCRIPTION
        Configuration for Backup Data for ns backup and restore resource.
    .PARAMETER Filename 
        Name of the backup file(*.tgz) to be restored. 
    .PARAMETER Skipbackup 
        Use this option to skip taking backup during restore operation.
    .EXAMPLE
        PS C:\>Invoke-NSRestoreSystembackup -filename <string>
        An example how to restore systembackup config Object(s).
    .NOTES
        File Name : Invoke-NSRestoreSystembackup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systembackup/
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
        [string]$Filename,

        [boolean]$Skipbackup 

    )
    begin {
        Write-Verbose "Invoke-NSRestoreSystembackup: Starting"
    }
    process {
        try {
            $payload = @{ filename = $filename }
            if ( $PSBoundParameters.ContainsKey('skipbackup') ) { $payload.Add('skipbackup', $skipbackup) }
            if ( $PSCmdlet.ShouldProcess($Name, "Restore System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systembackup -Action restore -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSRestoreSystembackup: Finished"
    }
}

function Invoke-NSAddSystembackup {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Configuration for Backup Data for ns backup and restore resource.
    .PARAMETER Filename 
        Name of the backup file(*.tgz) to be restored. 
    .PARAMETER PassThru 
        Return details about the created systembackup item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystembackup -filename <string>
        An example how to add systembackup config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystembackup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systembackup/
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
        [string]$Filename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystembackup: Starting"
    }
    process {
        try {
            $payload = @{ filename = $filename }

            if ( $PSCmdlet.ShouldProcess("systembackup", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systembackup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystembackup -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystembackup: Finished"
    }
}

function Invoke-NSDeleteSystembackup {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Configuration for Backup Data for ns backup and restore resource.
    .PARAMETER Filename 
        Name of the backup file(*.tgz) to be restored.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystembackup -Filename <string>
        An example how to delete systembackup config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystembackup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systembackup/
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
        [string]$Filename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystembackup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$filename", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systembackup -NitroPath nitro/v1/config -Resource $filename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystembackup: Finished"
    }
}

function Invoke-NSGetSystembackup {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for Backup Data for ns backup and restore resource.
    .PARAMETER Filename 
        Name of the backup file(*.tgz) to be restored. 
    .PARAMETER GetAll 
        Retrieve all systembackup object(s).
    .PARAMETER Count
        If specified, the count of the systembackup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystembackup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystembackup -GetAll 
        Get all systembackup data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystembackup -Count 
        Get the number of systembackup objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystembackup -name <string>
        Get systembackup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystembackup -Filter @{ 'name'='<value>' }
        Get systembackup data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystembackup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systembackup/
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
        [string]$Filename,

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
        Write-Verbose "Invoke-NSGetSystembackup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systembackup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systembackup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systembackup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systembackup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systembackup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systembackup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systembackup configuration for property 'filename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systembackup -NitroPath nitro/v1/config -Resource $filename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systembackup configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systembackup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystembackup: Ended"
    }
}

function Invoke-NSAddSystemcmdpolicy {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Configuration for command policy resource.
    .PARAMETER Policyname 
        Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER Action 
        Action to perform when a request matches the policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Cmdspec 
        Regular expression specifying the data that matches the policy. 
    .PARAMETER PassThru 
        Return details about the created systemcmdpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemcmdpolicy -policyname <string> -action <string> -cmdspec <string>
        An example how to add systemcmdpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemcmdpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcmdpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [ValidateSet('ALLOW', 'DENY')]
        [string]$Action,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cmdspec,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemcmdpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                action               = $action
                cmdspec              = $cmdspec
            }

            if ( $PSCmdlet.ShouldProcess("systemcmdpolicy", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemcmdpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemcmdpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemcmdpolicy: Finished"
    }
}

function Invoke-NSDeleteSystemcmdpolicy {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Configuration for command policy resource.
    .PARAMETER Policyname 
        Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy').
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemcmdpolicy -Policyname <string>
        An example how to delete systemcmdpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemcmdpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcmdpolicy/
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
        Write-Verbose "Invoke-NSDeleteSystemcmdpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$policyname", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemcmdpolicy -NitroPath nitro/v1/config -Resource $policyname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemcmdpolicy: Finished"
    }
}

function Invoke-NSUpdateSystemcmdpolicy {
    <#
    .SYNOPSIS
        Update System configuration. config Object.
    .DESCRIPTION
        Configuration for command policy resource.
    .PARAMETER Policyname 
        Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER Action 
        Action to perform when a request matches the policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Cmdspec 
        Regular expression specifying the data that matches the policy. 
    .PARAMETER PassThru 
        Return details about the created systemcmdpolicy item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSystemcmdpolicy -policyname <string> -action <string> -cmdspec <string>
        An example how to update systemcmdpolicy config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSystemcmdpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcmdpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [ValidateSet('ALLOW', 'DENY')]
        [string]$Action,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cmdspec,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSystemcmdpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                action               = $action
                cmdspec              = $cmdspec
            }

            if ( $PSCmdlet.ShouldProcess("systemcmdpolicy", "Update System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemcmdpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemcmdpolicy -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateSystemcmdpolicy: Finished"
    }
}

function Invoke-NSGetSystemcmdpolicy {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for command policy resource.
    .PARAMETER Policyname 
        Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER GetAll 
        Retrieve all systemcmdpolicy object(s).
    .PARAMETER Count
        If specified, the count of the systemcmdpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcmdpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemcmdpolicy -GetAll 
        Get all systemcmdpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemcmdpolicy -Count 
        Get the number of systemcmdpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcmdpolicy -name <string>
        Get systemcmdpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcmdpolicy -Filter @{ 'name'='<value>' }
        Get systemcmdpolicy data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemcmdpolicy
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcmdpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-NSGetSystemcmdpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcmdpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcmdpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcmdpolicy objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcmdpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcmdpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcmdpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcmdpolicy configuration for property 'policyname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcmdpolicy -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemcmdpolicy configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcmdpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemcmdpolicy: Ended"
    }
}

function Invoke-NSUpdateSystemcollectionparam {
    <#
    .SYNOPSIS
        Update System configuration. config Object.
    .DESCRIPTION
        Configuration for collection parameter resource.
    .PARAMETER Communityname 
        SNMPv1 community name for authentication. 
    .PARAMETER Loglevel 
        specify the log level. Possible values CRITICAL,WARNING,INFO,DEBUG1,DEBUG2. 
    .PARAMETER Datapath 
        specify the data path to the database.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSystemcollectionparam 
        An example how to update systemcollectionparam config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSystemcollectionparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcollectionparam/
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

        [string]$Communityname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Loglevel,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Datapath 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSystemcollectionparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('communityname') ) { $payload.Add('communityname', $communityname) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('datapath') ) { $payload.Add('datapath', $datapath) }
            if ( $PSCmdlet.ShouldProcess("systemcollectionparam", "Update System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemcollectionparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateSystemcollectionparam: Finished"
    }
}

function Invoke-NSUnsetSystemcollectionparam {
    <#
    .SYNOPSIS
        Unset System configuration. config Object.
    .DESCRIPTION
        Configuration for collection parameter resource.
    .PARAMETER Communityname 
        SNMPv1 community name for authentication. 
    .PARAMETER Loglevel 
        specify the log level. Possible values CRITICAL,WARNING,INFO,DEBUG1,DEBUG2. 
    .PARAMETER Datapath 
        specify the data path to the database.
    .EXAMPLE
        PS C:\>Invoke-NSUnsetSystemcollectionparam 
        An example how to unset systemcollectionparam config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetSystemcollectionparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcollectionparam
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

        [Boolean]$communityname,

        [Boolean]$loglevel,

        [Boolean]$datapath 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetSystemcollectionparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('communityname') ) { $payload.Add('communityname', $communityname) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('datapath') ) { $payload.Add('datapath', $datapath) }
            if ( $PSCmdlet.ShouldProcess("systemcollectionparam", "Unset System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type systemcollectionparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetSystemcollectionparam: Finished"
    }
}

function Invoke-NSGetSystemcollectionparam {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for collection parameter resource.
    .PARAMETER GetAll 
        Retrieve all systemcollectionparam object(s).
    .PARAMETER Count
        If specified, the count of the systemcollectionparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcollectionparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemcollectionparam -GetAll 
        Get all systemcollectionparam data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcollectionparam -name <string>
        Get systemcollectionparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcollectionparam -Filter @{ 'name'='<value>' }
        Get systemcollectionparam data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemcollectionparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcollectionparam/
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
        Write-Verbose "Invoke-NSGetSystemcollectionparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcollectionparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcollectionparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcollectionparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcollectionparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcollectionparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcollectionparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcollectionparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcollectionparam configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcollectionparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemcollectionparam: Ended"
    }
}

function Invoke-NSGetSystemcore {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for core resource.
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systemcore object(s).
    .PARAMETER Count
        If specified, the count of the systemcore object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcore
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemcore -GetAll 
        Get all systemcore data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcore -name <string>
        Get systemcore object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcore -Filter @{ 'name'='<value>' }
        Get systemcore data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemcore
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcore/
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
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemcore: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcore objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcore -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcore objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcore -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcore objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcore -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcore configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcore configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcore -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemcore: Ended"
    }
}

function Invoke-NSGetSystemcountergroup {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for counter group resource.
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systemcountergroup object(s).
    .PARAMETER Count
        If specified, the count of the systemcountergroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcountergroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemcountergroup -GetAll 
        Get all systemcountergroup data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcountergroup -name <string>
        Get systemcountergroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcountergroup -Filter @{ 'name'='<value>' }
        Get systemcountergroup data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemcountergroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcountergroup/
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
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemcountergroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcountergroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcountergroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcountergroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcountergroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcountergroup objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcountergroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcountergroup configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcountergroup configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcountergroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemcountergroup: Ended"
    }
}

function Invoke-NSGetSystemcounters {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for counters resource.
    .PARAMETER Countergroup 
        Specify the (counter) group name which contains all the counters specific tot his particular group. 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systemcounters object(s).
    .PARAMETER Count
        If specified, the count of the systemcounters object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcounters
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemcounters -GetAll 
        Get all systemcounters data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcounters -name <string>
        Get systemcounters object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcounters -Filter @{ 'name'='<value>' }
        Get systemcounters data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemcounters
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcounters/
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
        [string]$Countergroup,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemcounters: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcounters objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcounters -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcounters objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcounters -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcounters objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('countergroup') ) { $arguments.Add('countergroup', $countergroup) } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcounters -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcounters configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcounters configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcounters -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemcounters: Ended"
    }
}

function Invoke-NSUpdateSystemcpuparam {
    <#
    .SYNOPSIS
        Update System configuration. config Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Pemode 
        Set PEmode to DEFAULT/CPUBOUND. Distribute the PE weights equally if PEmode is set to CPUBOUND. 
        Possible values = DEFAULT, CPUBOUND
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSystemcpuparam 
        An example how to update systemcpuparam config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSystemcpuparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcpuparam/
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

        [ValidateSet('DEFAULT', 'CPUBOUND')]
        [string]$Pemode 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSystemcpuparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('pemode') ) { $payload.Add('pemode', $pemode) }
            if ( $PSCmdlet.ShouldProcess("systemcpuparam", "Update System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemcpuparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateSystemcpuparam: Finished"
    }
}

function Invoke-NSUnsetSystemcpuparam {
    <#
    .SYNOPSIS
        Unset System configuration. config Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Pemode 
        Set PEmode to DEFAULT/CPUBOUND. Distribute the PE weights equally if PEmode is set to CPUBOUND. 
        Possible values = DEFAULT, CPUBOUND
    .EXAMPLE
        PS C:\>Invoke-NSUnsetSystemcpuparam 
        An example how to unset systemcpuparam config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetSystemcpuparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcpuparam
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

        [Boolean]$pemode 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetSystemcpuparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('pemode') ) { $payload.Add('pemode', $pemode) }
            if ( $PSCmdlet.ShouldProcess("systemcpuparam", "Unset System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type systemcpuparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetSystemcpuparam: Finished"
    }
}

function Invoke-NSGetSystemcpuparam {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER GetAll 
        Retrieve all systemcpuparam object(s).
    .PARAMETER Count
        If specified, the count of the systemcpuparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcpuparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemcpuparam -GetAll 
        Get all systemcpuparam data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemcpuparam -Count 
        Get the number of systemcpuparam objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcpuparam -name <string>
        Get systemcpuparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemcpuparam -Filter @{ 'name'='<value>' }
        Get systemcpuparam data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemcpuparam
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemcpuparam/
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
        Write-Verbose "Invoke-NSGetSystemcpuparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcpuparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcpuparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcpuparam objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcpuparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcpuparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcpuparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcpuparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcpuparam configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemcpuparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemcpuparam: Ended"
    }
}

function Invoke-NSGetSystemdatasource {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for historical datasource resource.
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systemdatasource object(s).
    .PARAMETER Count
        If specified, the count of the systemdatasource object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemdatasource
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemdatasource -GetAll 
        Get all systemdatasource data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemdatasource -name <string>
        Get systemdatasource object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemdatasource -Filter @{ 'name'='<value>' }
        Get systemdatasource data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemdatasource
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemdatasource/
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
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemdatasource: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemdatasource objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemdatasource -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemdatasource objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemdatasource -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemdatasource objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemdatasource -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemdatasource configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemdatasource configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemdatasource -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemdatasource: Ended"
    }
}

function Invoke-NSGetSystementity {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for entity resource.
    .PARAMETER Type 
        Specify the entity type. 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER Core 
        Specify core ID of the PE in nCore. 
    .PARAMETER GetAll 
        Retrieve all systementity object(s).
    .PARAMETER Count
        If specified, the count of the systementity object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystementity
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystementity -GetAll 
        Get all systementity data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystementity -name <string>
        Get systementity object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystementity -Filter @{ 'name'='<value>' }
        Get systementity data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystementity
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systementity/
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
        [string]$Type,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Datasource,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Core,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystementity: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systementity objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementity -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systementity objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementity -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systementity objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) } 
                if ( $PSBoundParameters.ContainsKey('core') ) { $arguments.Add('core', $core) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementity -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systementity configuration for property ''"

            } else {
                Write-Verbose "Retrieving systementity configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementity -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystementity: Ended"
    }
}

function Invoke-NSDeleteSystementitydata {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Configuration for entity data resource.
    .PARAMETER Type 
        Specify the entity type. 
    .PARAMETER Name 
        Specify the entity name. 
    .PARAMETER Alldeleted 
        Specify this if you would like to delete information about all deleted entities from the database. 
    .PARAMETER Allinactive 
        Specify this if you would like to delete information about all inactive entities from the database. 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER Core 
        Specify core ID of the PE in nCore.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystementitydata 
        An example how to delete systementitydata config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystementitydata
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systementitydata/
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

        [string]$Type,

        [string]$Name,

        [boolean]$Alldeleted,

        [boolean]$Allinactive,

        [string]$Datasource,

        [int]$Core 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystementitydata: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Alldeleted') ) { $arguments.Add('alldeleted', $Alldeleted) }
            if ( $PSBoundParameters.ContainsKey('Allinactive') ) { $arguments.Add('allinactive', $Allinactive) }
            if ( $PSBoundParameters.ContainsKey('Datasource') ) { $arguments.Add('datasource', $Datasource) }
            if ( $PSBoundParameters.ContainsKey('Core') ) { $arguments.Add('core', $Core) }
            if ( $PSCmdlet.ShouldProcess("systementitydata", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systementitydata -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystementitydata: Finished"
    }
}

function Invoke-NSGetSystementitydata {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for entity data resource.
    .PARAMETER Type 
        Specify the entity type. 
    .PARAMETER Name 
        Specify the entity name. 
    .PARAMETER Counters 
        Specify the counters to be collected. 
    .PARAMETER Starttime 
        Specify start time in mmddyyyyhhmm to start collecting values from that timestamp. 
    .PARAMETER Endtime 
        Specify end time in mmddyyyyhhmm upto which values have to be collected. 
    .PARAMETER Last 
        Last is literal way of saying a certain time period from the current moment. Example: -last 1 hour, -last 1 day, et cetera. 
    .PARAMETER Unit 
        Specify the time period from current moment. Example 1 x where x = hours/ days/ years. 
        Possible values = HOURS, DAYS, MONTHS 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER Core 
        Specify core ID of the PE in nCore. 
    .PARAMETER GetAll 
        Retrieve all systementitydata object(s).
    .PARAMETER Count
        If specified, the count of the systementitydata object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystementitydata
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystementitydata -GetAll 
        Get all systementitydata data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystementitydata -name <string>
        Get systementitydata object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystementitydata -Filter @{ 'name'='<value>' }
        Get systementitydata data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystementitydata
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systementitydata/
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
        [string]$Type,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Name,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Counters,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Starttime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Endtime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Last,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HOURS', 'DAYS', 'MONTHS')]
        [string]$Unit,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Datasource,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Core,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystementitydata: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systementitydata objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementitydata -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systementitydata objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementitydata -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systementitydata objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('name') ) { $arguments.Add('name', $name) } 
                if ( $PSBoundParameters.ContainsKey('counters') ) { $arguments.Add('counters', $counters) } 
                if ( $PSBoundParameters.ContainsKey('starttime') ) { $arguments.Add('starttime', $starttime) } 
                if ( $PSBoundParameters.ContainsKey('endtime') ) { $arguments.Add('endtime', $endtime) } 
                if ( $PSBoundParameters.ContainsKey('last') ) { $arguments.Add('last', $last) } 
                if ( $PSBoundParameters.ContainsKey('unit') ) { $arguments.Add('unit', $unit) } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) } 
                if ( $PSBoundParameters.ContainsKey('core') ) { $arguments.Add('core', $core) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementitydata -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systementitydata configuration for property ''"

            } else {
                Write-Verbose "Retrieving systementitydata configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementitydata -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystementitydata: Ended"
    }
}

function Invoke-NSGetSystementitytype {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for entity type resource.
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systementitytype object(s).
    .PARAMETER Count
        If specified, the count of the systementitytype object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystementitytype
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystementitytype -GetAll 
        Get all systementitytype data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystementitytype -name <string>
        Get systementitytype object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystementitytype -Filter @{ 'name'='<value>' }
        Get systementitytype data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystementitytype
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systementitytype/
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
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystementitytype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systementitytype objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementitytype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systementitytype objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementitytype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systementitytype objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementitytype -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systementitytype configuration for property ''"

            } else {
                Write-Verbose "Retrieving systementitytype configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systementitytype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystementitytype: Ended"
    }
}

function Invoke-NSGetSystemeventhistory {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for event history resource.
    .PARAMETER Starttime 
        Specify start time in mmddyyyyhhmm to start collecting values from that timestamp. 
    .PARAMETER Endtime 
        Specify end time in mmddyyyyhhmm upto which values have to be collected. 
    .PARAMETER Last 
        Last is literal way of saying a certain time period from the current moment. Example: -last 1 hour, -last 1 day, et cetera. 
    .PARAMETER Unit 
        Specify the time period from current moment. Example 1 x where x = hours/ days/ years. 
        Possible values = HOURS, DAYS, MONTHS 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systemeventhistory object(s).
    .PARAMETER Count
        If specified, the count of the systemeventhistory object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemeventhistory
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemeventhistory -GetAll 
        Get all systemeventhistory data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemeventhistory -name <string>
        Get systemeventhistory object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemeventhistory -Filter @{ 'name'='<value>' }
        Get systemeventhistory data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemeventhistory
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemeventhistory/
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
        [string]$Starttime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Endtime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Last,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HOURS', 'DAYS', 'MONTHS')]
        [string]$Unit,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemeventhistory: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemeventhistory objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemeventhistory -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemeventhistory objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemeventhistory -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemeventhistory objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('starttime') ) { $arguments.Add('starttime', $starttime) } 
                if ( $PSBoundParameters.ContainsKey('endtime') ) { $arguments.Add('endtime', $endtime) } 
                if ( $PSBoundParameters.ContainsKey('last') ) { $arguments.Add('last', $last) } 
                if ( $PSBoundParameters.ContainsKey('unit') ) { $arguments.Add('unit', $unit) } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemeventhistory -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemeventhistory configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemeventhistory configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemeventhistory -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemeventhistory: Ended"
    }
}

function Invoke-NSEnableSystemextramgmtcpu {
    <#
    .SYNOPSIS
        Enable System configuration. config Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .EXAMPLE
        PS C:\>Invoke-NSEnableSystemextramgmtcpu 
        An example how to enable systemextramgmtcpu config Object(s).
    .NOTES
        File Name : Invoke-NSEnableSystemextramgmtcpu
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemextramgmtcpu/
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
        Write-Verbose "Invoke-NSEnableSystemextramgmtcpu: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemextramgmtcpu -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSEnableSystemextramgmtcpu: Finished"
    }
}

function Invoke-NSDisableSystemextramgmtcpu {
    <#
    .SYNOPSIS
        Disable System configuration. config Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .EXAMPLE
        PS C:\>Invoke-NSDisableSystemextramgmtcpu 
        An example how to disable systemextramgmtcpu config Object(s).
    .NOTES
        File Name : Invoke-NSDisableSystemextramgmtcpu
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemextramgmtcpu/
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
        Write-Verbose "Invoke-NSDisableSystemextramgmtcpu: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemextramgmtcpu -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSDisableSystemextramgmtcpu: Finished"
    }
}

function Invoke-NSGetSystemextramgmtcpu {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
         
        Maximum value = 31 
    .PARAMETER GetAll 
        Retrieve all systemextramgmtcpu object(s).
    .PARAMETER Count
        If specified, the count of the systemextramgmtcpu object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemextramgmtcpu
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemextramgmtcpu -GetAll 
        Get all systemextramgmtcpu data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemextramgmtcpu -name <string>
        Get systemextramgmtcpu object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemextramgmtcpu -Filter @{ 'name'='<value>' }
        Get systemextramgmtcpu data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemextramgmtcpu
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemextramgmtcpu/
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
        Write-Verbose "Invoke-NSGetSystemextramgmtcpu: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemextramgmtcpu objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemextramgmtcpu -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemextramgmtcpu objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemextramgmtcpu -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemextramgmtcpu objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemextramgmtcpu -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemextramgmtcpu configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemextramgmtcpu configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemextramgmtcpu -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemextramgmtcpu: Ended"
    }
}

function Invoke-NSAddSystemfile {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Configuration for file resource.
    .PARAMETER Filename 
        Name of the file. It should not include filepath. 
    .PARAMETER Filecontent 
        file content in Base64 format. 
    .PARAMETER Filelocation 
        location of the file on Citrix ADC. 
    .PARAMETER Fileencoding 
        encoding type of the file content.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemfile -filename <string> -filecontent <string> -filelocation <string>
        An example how to add systemfile config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemfile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemfile/
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
        [string]$Filename,

        [Parameter(Mandatory)]
        [string]$Filecontent,

        [Parameter(Mandatory)]
        [string]$Filelocation,

        [string]$Fileencoding = '"BASE64"' 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemfile: Starting"
    }
    process {
        try {
            $payload = @{ filename = $filename
                filecontent        = $filecontent
                filelocation       = $filelocation
            }
            if ( $PSBoundParameters.ContainsKey('fileencoding') ) { $payload.Add('fileencoding', $fileencoding) }
            if ( $PSCmdlet.ShouldProcess("systemfile", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemfile -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSAddSystemfile: Finished"
    }
}

function Invoke-NSDeleteSystemfile {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Configuration for file resource.
    .PARAMETER Filename 
        Name of the file. It should not include filepath. 
    .PARAMETER Filelocation 
        location of the file on Citrix ADC.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemfile -Filename <string>
        An example how to delete systemfile config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemfile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemfile/
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
        [string]$Filename,

        [string]$Filelocation 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystemfile: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Filelocation') ) { $arguments.Add('filelocation', $Filelocation) }
            if ( $PSCmdlet.ShouldProcess("$filename", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemfile -NitroPath nitro/v1/config -Resource $filename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemfile: Finished"
    }
}

function Invoke-NSGetSystemfile {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for file resource.
    .PARAMETER Filename 
        Name of the file. It should not include filepath. 
    .PARAMETER Filelocation 
        location of the file on Citrix ADC. 
    .PARAMETER GetAll 
        Retrieve all systemfile object(s).
    .PARAMETER Count
        If specified, the count of the systemfile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemfile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemfile -GetAll 
        Get all systemfile data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemfile -name <string>
        Get systemfile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemfile -Filter @{ 'name'='<value>' }
        Get systemfile data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemfile
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemfile/
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
        [string]$Filename,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Filelocation,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemfile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemfile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemfile objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemfile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemfile objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('filename') ) { $arguments.Add('filename', $filename) } 
                if ( $PSBoundParameters.ContainsKey('filelocation') ) { $arguments.Add('filelocation', $filelocation) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemfile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemfile configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemfile configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemfile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemfile: Ended"
    }
}

function Invoke-NSAddSystemglobalAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemglobalAuditnslogpolicyBinding 
        An example how to add systemglobal_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemglobalAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_auditnslogpolicy_binding/
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

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemglobalAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_auditnslogpolicy_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemglobalAuditnslogpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemglobalAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteSystemglobalAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemglobalAuditnslogpolicyBinding 
        An example how to delete systemglobal_auditnslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemglobalAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuditnslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_auditnslogpolicy_binding", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuditnslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetSystemglobalAuditnslogpolicyBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuditnslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuditnslogpolicyBinding -GetAll 
        Get all systemglobal_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuditnslogpolicyBinding -Count 
        Get the number of systemglobal_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuditnslogpolicyBinding -name <string>
        Get systemglobal_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuditnslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get systemglobal_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemglobalAuditnslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-NSGetSystemglobalAuditnslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_auditnslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemglobalAuditnslogpolicyBinding: Ended"
    }
}

function Invoke-NSAddSystemglobalAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemglobalAuditsyslogpolicyBinding 
        An example how to add systemglobal_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemglobalAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_auditsyslogpolicy_binding/
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

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemglobalAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_auditsyslogpolicy_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemglobalAuditsyslogpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemglobalAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteSystemglobalAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemglobalAuditsyslogpolicyBinding 
        An example how to delete systemglobal_auditsyslogpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemglobalAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuditsyslogpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_auditsyslogpolicy_binding", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuditsyslogpolicyBinding: Finished"
    }
}

function Invoke-NSGetSystemglobalAuditsyslogpolicyBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuditsyslogpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuditsyslogpolicyBinding -GetAll 
        Get all systemglobal_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuditsyslogpolicyBinding -Count 
        Get the number of systemglobal_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuditsyslogpolicyBinding -name <string>
        Get systemglobal_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuditsyslogpolicyBinding -Filter @{ 'name'='<value>' }
        Get systemglobal_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemglobalAuditsyslogpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-NSGetSystemglobalAuditsyslogpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemglobalAuditsyslogpolicyBinding: Ended"
    }
}

function Invoke-NSAddSystemglobalAuthenticationldappolicyBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationldappolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationldappolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemglobalAuthenticationldappolicyBinding 
        An example how to add systemglobal_authenticationldappolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemglobalAuthenticationldappolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationldappolicy_binding/
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

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemglobalAuthenticationldappolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationldappolicy_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_authenticationldappolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemglobalAuthenticationldappolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemglobalAuthenticationldappolicyBinding: Finished"
    }
}

function Invoke-NSDeleteSystemglobalAuthenticationldappolicyBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationldappolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemglobalAuthenticationldappolicyBinding 
        An example how to delete systemglobal_authenticationldappolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemglobalAuthenticationldappolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationldappolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuthenticationldappolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationldappolicy_binding", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemglobal_authenticationldappolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuthenticationldappolicyBinding: Finished"
    }
}

function Invoke-NSGetSystemglobalAuthenticationldappolicyBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authenticationldappolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_authenticationldappolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationldappolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationldappolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuthenticationldappolicyBinding -GetAll 
        Get all systemglobal_authenticationldappolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuthenticationldappolicyBinding -Count 
        Get the number of systemglobal_authenticationldappolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationldappolicyBinding -name <string>
        Get systemglobal_authenticationldappolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationldappolicyBinding -Filter @{ 'name'='<value>' }
        Get systemglobal_authenticationldappolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemglobalAuthenticationldappolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationldappolicy_binding/
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
        Write-Verbose "Invoke-NSGetSystemglobalAuthenticationldappolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_authenticationldappolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationldappolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationldappolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationldappolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationldappolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationldappolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationldappolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationldappolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationldappolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemglobalAuthenticationldappolicyBinding: Ended"
    }
}

function Invoke-NSAddSystemglobalAuthenticationlocalpolicyBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationlocalpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationlocalpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemglobalAuthenticationlocalpolicyBinding 
        An example how to add systemglobal_authenticationlocalpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemglobalAuthenticationlocalpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationlocalpolicy_binding/
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

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemglobalAuthenticationlocalpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationlocalpolicy_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_authenticationlocalpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemglobalAuthenticationlocalpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemglobalAuthenticationlocalpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteSystemglobalAuthenticationlocalpolicyBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationlocalpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemglobalAuthenticationlocalpolicyBinding 
        An example how to delete systemglobal_authenticationlocalpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemglobalAuthenticationlocalpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationlocalpolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuthenticationlocalpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationlocalpolicy_binding", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemglobal_authenticationlocalpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuthenticationlocalpolicyBinding: Finished"
    }
}

function Invoke-NSGetSystemglobalAuthenticationlocalpolicyBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authenticationlocalpolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_authenticationlocalpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationlocalpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationlocalpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuthenticationlocalpolicyBinding -GetAll 
        Get all systemglobal_authenticationlocalpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuthenticationlocalpolicyBinding -Count 
        Get the number of systemglobal_authenticationlocalpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationlocalpolicyBinding -name <string>
        Get systemglobal_authenticationlocalpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationlocalpolicyBinding -Filter @{ 'name'='<value>' }
        Get systemglobal_authenticationlocalpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemglobalAuthenticationlocalpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationlocalpolicy_binding/
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
        Write-Verbose "Invoke-NSGetSystemglobalAuthenticationlocalpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_authenticationlocalpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationlocalpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationlocalpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationlocalpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationlocalpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemglobalAuthenticationlocalpolicyBinding: Ended"
    }
}

function Invoke-NSAddSystemglobalAuthenticationpolicyBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. Applicable only for advanced authentication policies. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemglobalAuthenticationpolicyBinding 
        An example how to add systemglobal_authenticationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemglobalAuthenticationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationpolicy_binding/
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

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemglobalAuthenticationpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationpolicy_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_authenticationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemglobalAuthenticationpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemglobalAuthenticationpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteSystemglobalAuthenticationpolicyBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemglobalAuthenticationpolicyBinding 
        An example how to delete systemglobal_authenticationpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemglobalAuthenticationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationpolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuthenticationpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationpolicy_binding", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemglobal_authenticationpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuthenticationpolicyBinding: Finished"
    }
}

function Invoke-NSGetSystemglobalAuthenticationpolicyBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authenticationpolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_authenticationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuthenticationpolicyBinding -GetAll 
        Get all systemglobal_authenticationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuthenticationpolicyBinding -Count 
        Get the number of systemglobal_authenticationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationpolicyBinding -name <string>
        Get systemglobal_authenticationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationpolicyBinding -Filter @{ 'name'='<value>' }
        Get systemglobal_authenticationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemglobalAuthenticationpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationpolicy_binding/
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
        Write-Verbose "Invoke-NSGetSystemglobalAuthenticationpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_authenticationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemglobalAuthenticationpolicyBinding: Ended"
    }
}

function Invoke-NSAddSystemglobalAuthenticationradiuspolicyBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationradiuspolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationradiuspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemglobalAuthenticationradiuspolicyBinding 
        An example how to add systemglobal_authenticationradiuspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemglobalAuthenticationradiuspolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationradiuspolicy_binding/
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

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemglobalAuthenticationradiuspolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationradiuspolicy_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_authenticationradiuspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemglobalAuthenticationradiuspolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemglobalAuthenticationradiuspolicyBinding: Finished"
    }
}

function Invoke-NSDeleteSystemglobalAuthenticationradiuspolicyBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationradiuspolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemglobalAuthenticationradiuspolicyBinding 
        An example how to delete systemglobal_authenticationradiuspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemglobalAuthenticationradiuspolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationradiuspolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuthenticationradiuspolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationradiuspolicy_binding", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemglobal_authenticationradiuspolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuthenticationradiuspolicyBinding: Finished"
    }
}

function Invoke-NSGetSystemglobalAuthenticationradiuspolicyBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authenticationradiuspolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_authenticationradiuspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationradiuspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationradiuspolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuthenticationradiuspolicyBinding -GetAll 
        Get all systemglobal_authenticationradiuspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuthenticationradiuspolicyBinding -Count 
        Get the number of systemglobal_authenticationradiuspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationradiuspolicyBinding -name <string>
        Get systemglobal_authenticationradiuspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationradiuspolicyBinding -Filter @{ 'name'='<value>' }
        Get systemglobal_authenticationradiuspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemglobalAuthenticationradiuspolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationradiuspolicy_binding/
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
        Write-Verbose "Invoke-NSGetSystemglobalAuthenticationradiuspolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_authenticationradiuspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationradiuspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationradiuspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationradiuspolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationradiuspolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemglobalAuthenticationradiuspolicyBinding: Ended"
    }
}

function Invoke-NSAddSystemglobalAuthenticationtacacspolicyBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationtacacspolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationtacacspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemglobalAuthenticationtacacspolicyBinding 
        An example how to add systemglobal_authenticationtacacspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemglobalAuthenticationtacacspolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationtacacspolicy_binding/
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

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemglobalAuthenticationtacacspolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationtacacspolicy_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_authenticationtacacspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemglobalAuthenticationtacacspolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemglobalAuthenticationtacacspolicyBinding: Finished"
    }
}

function Invoke-NSDeleteSystemglobalAuthenticationtacacspolicyBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the authenticationtacacspolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemglobalAuthenticationtacacspolicyBinding 
        An example how to delete systemglobal_authenticationtacacspolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemglobalAuthenticationtacacspolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationtacacspolicy_binding/
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuthenticationtacacspolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationtacacspolicy_binding", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemglobal_authenticationtacacspolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemglobalAuthenticationtacacspolicyBinding: Finished"
    }
}

function Invoke-NSGetSystemglobalAuthenticationtacacspolicyBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the authenticationtacacspolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_authenticationtacacspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationtacacspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationtacacspolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuthenticationtacacspolicyBinding -GetAll 
        Get all systemglobal_authenticationtacacspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalAuthenticationtacacspolicyBinding -Count 
        Get the number of systemglobal_authenticationtacacspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationtacacspolicyBinding -name <string>
        Get systemglobal_authenticationtacacspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalAuthenticationtacacspolicyBinding -Filter @{ 'name'='<value>' }
        Get systemglobal_authenticationtacacspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemglobalAuthenticationtacacspolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_authenticationtacacspolicy_binding/
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
        Write-Verbose "Invoke-NSGetSystemglobalAuthenticationtacacspolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_authenticationtacacspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationtacacspolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationtacacspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationtacacspolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationtacacspolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemglobalAuthenticationtacacspolicyBinding: Ended"
    }
}

function Invoke-NSGetSystemglobalBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobalBinding -GetAll 
        Get all systemglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalBinding -name <string>
        Get systemglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobalBinding -Filter @{ 'name'='<value>' }
        Get systemglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemglobalBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobal_binding/
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
        Write-Verbose "Invoke-NSGetSystemglobalBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemglobalBinding: Ended"
    }
}

function Invoke-NSGetSystemglobaldata {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for global counter data resource.
    .PARAMETER Counters 
        Specify the counters to be collected. 
    .PARAMETER Countergroup 
        Specify the (counter) group name which contains all the counters specific to this particular group. 
    .PARAMETER Starttime 
        Specify start time in mmddyyyyhhmm to start collecting values from that timestamp. 
    .PARAMETER Endtime 
        Specify end time in mmddyyyyhhmm upto which values have to be collected. 
    .PARAMETER Last 
        Last is literal way of saying a certain time period from the current moment. Example: -last 1 hour, -last 1 day, et cetera. 
    .PARAMETER Unit 
        Specify the time period from current moment. Example 1 x where x = hours/ days/ years. 
        Possible values = HOURS, DAYS, MONTHS 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER Core 
        Specify core ID of the PE in nCore. 
    .PARAMETER GetAll 
        Retrieve all systemglobaldata object(s).
    .PARAMETER Count
        If specified, the count of the systemglobaldata object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobaldata
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemglobaldata -GetAll 
        Get all systemglobaldata data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobaldata -name <string>
        Get systemglobaldata object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemglobaldata -Filter @{ 'name'='<value>' }
        Get systemglobaldata data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemglobaldata
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemglobaldata/
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
        [string]$Counters,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Countergroup,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Starttime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Endtime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Last,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HOURS', 'DAYS', 'MONTHS')]
        [string]$Unit,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Datasource,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Core,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemglobaldata: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemglobaldata objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobaldata -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobaldata objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobaldata -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobaldata objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('counters') ) { $arguments.Add('counters', $counters) } 
                if ( $PSBoundParameters.ContainsKey('countergroup') ) { $arguments.Add('countergroup', $countergroup) } 
                if ( $PSBoundParameters.ContainsKey('starttime') ) { $arguments.Add('starttime', $starttime) } 
                if ( $PSBoundParameters.ContainsKey('endtime') ) { $arguments.Add('endtime', $endtime) } 
                if ( $PSBoundParameters.ContainsKey('last') ) { $arguments.Add('last', $last) } 
                if ( $PSBoundParameters.ContainsKey('unit') ) { $arguments.Add('unit', $unit) } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) } 
                if ( $PSBoundParameters.ContainsKey('core') ) { $arguments.Add('core', $core) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobaldata -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobaldata configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobaldata configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemglobaldata -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemglobaldata: Ended"
    }
}

function Invoke-NSAddSystemgroup {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Configuration for system group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
         
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds.If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces of the system users in the group. By default allowed from both API and CLI interfaces. If management interface for a group is set to API, then all users under this group will not allowed to access NS through CLI. GUI interface will come under API interface. 
         
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemgroup item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemgroup -groupname <string>
        An example how to add systemgroup config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemgroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Groupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Promptstring,

        [double]$Timeout,

        [ValidateSet('CLI', 'API')]
        [string[]]$Allowedmanagementinterface = 'NS_INTERFACE_ALL',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemgroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSCmdlet.ShouldProcess("systemgroup", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemgroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemgroup -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemgroup: Finished"
    }
}

function Invoke-NSDeleteSystemgroup {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Configuration for system group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group').
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemgroup -Groupname <string>
        An example how to delete systemgroup config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemgroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup/
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
        [string]$Groupname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystemgroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemgroup -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemgroup: Finished"
    }
}

function Invoke-NSUpdateSystemgroup {
    <#
    .SYNOPSIS
        Update System configuration. config Object.
    .DESCRIPTION
        Configuration for system group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
         
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds.If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces of the system users in the group. By default allowed from both API and CLI interfaces. If management interface for a group is set to API, then all users under this group will not allowed to access NS through CLI. GUI interface will come under API interface. 
         
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemgroup item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSystemgroup -groupname <string>
        An example how to update systemgroup config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSystemgroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Groupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Promptstring,

        [double]$Timeout,

        [ValidateSet('CLI', 'API')]
        [string[]]$Allowedmanagementinterface,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSystemgroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSCmdlet.ShouldProcess("systemgroup", "Update System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemgroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemgroup -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateSystemgroup: Finished"
    }
}

function Invoke-NSUnsetSystemgroup {
    <#
    .SYNOPSIS
        Unset System configuration. config Object.
    .DESCRIPTION
        Configuration for system group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
         
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds.If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces of the system users in the group. By default allowed from both API and CLI interfaces. If management interface for a group is set to API, then all users under this group will not allowed to access NS through CLI. GUI interface will come under API interface. 
         
        Possible values = CLI, API
    .EXAMPLE
        PS C:\>Invoke-NSUnsetSystemgroup -groupname <string>
        An example how to unset systemgroup config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetSystemgroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Groupname,

        [Boolean]$promptstring,

        [Boolean]$timeout,

        [Boolean]$allowedmanagementinterface 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetSystemgroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Unset System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type systemgroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetSystemgroup: Finished"
    }
}

function Invoke-NSGetSystemgroup {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for system group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER GetAll 
        Retrieve all systemgroup object(s).
    .PARAMETER Count
        If specified, the count of the systemgroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemgroup -GetAll 
        Get all systemgroup data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemgroup -Count 
        Get the number of systemgroup objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroup -name <string>
        Get systemgroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroup -Filter @{ 'name'='<value>' }
        Get systemgroup data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemgroup
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Groupname,

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
        Write-Verbose "Invoke-NSGetSystemgroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemgroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemgroup: Ended"
    }
}

function Invoke-NSGetSystemgroupBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group about which to display information. 
    .PARAMETER GetAll 
        Retrieve all systemgroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemgroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemgroupBinding -GetAll 
        Get all systemgroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupBinding -name <string>
        Get systemgroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupBinding -Filter @{ 'name'='<value>' }
        Get systemgroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemgroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup_binding/
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
        [string]$Groupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemgroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemgroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemgroupBinding: Ended"
    }
}

function Invoke-NSAddSystemgroupNspartitionBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Partitionname 
        Name of the Partition to bind to the system group. 
    .PARAMETER PassThru 
        Return details about the created systemgroup_nspartition_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemgroupNspartitionBinding -groupname <string>
        An example how to add systemgroup_nspartition_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemgroupNspartitionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup_nspartition_binding/
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
        [string]$Groupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Partitionname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemgroupNspartitionBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('partitionname') ) { $payload.Add('partitionname', $partitionname) }
            if ( $PSCmdlet.ShouldProcess("systemgroup_nspartition_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemgroup_nspartition_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemgroupNspartitionBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemgroupNspartitionBinding: Finished"
    }
}

function Invoke-NSDeleteSystemgroupNspartitionBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Partitionname 
        Name of the Partition to bind to the system group.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemgroupNspartitionBinding -Groupname <string>
        An example how to delete systemgroup_nspartition_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemgroupNspartitionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup_nspartition_binding/
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
        [string]$Groupname,

        [string]$Partitionname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystemgroupNspartitionBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Partitionname') ) { $arguments.Add('partitionname', $Partitionname) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemgroupNspartitionBinding: Finished"
    }
}

function Invoke-NSGetSystemgroupNspartitionBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER GetAll 
        Retrieve all systemgroup_nspartition_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemgroup_nspartition_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupNspartitionBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemgroupNspartitionBinding -GetAll 
        Get all systemgroup_nspartition_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemgroupNspartitionBinding -Count 
        Get the number of systemgroup_nspartition_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupNspartitionBinding -name <string>
        Get systemgroup_nspartition_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupNspartitionBinding -Filter @{ 'name'='<value>' }
        Get systemgroup_nspartition_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemgroupNspartitionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup_nspartition_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemgroupNspartitionBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemgroup_nspartition_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_nspartition_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_nspartition_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_nspartition_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_nspartition_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemgroupNspartitionBinding: Ended"
    }
}

function Invoke-NSAddSystemgroupSystemcmdpolicyBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Policyname 
        The name of command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER PassThru 
        Return details about the created systemgroup_systemcmdpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemgroupSystemcmdpolicyBinding -groupname <string>
        An example how to add systemgroup_systemcmdpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemgroupSystemcmdpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup_systemcmdpolicy_binding/
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
        [string]$Groupname,

        [string]$Policyname,

        [double]$Priority,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemgroupSystemcmdpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSCmdlet.ShouldProcess("systemgroup_systemcmdpolicy_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemgroup_systemcmdpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemgroupSystemcmdpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemgroupSystemcmdpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteSystemgroupSystemcmdpolicyBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Policyname 
        The name of command policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemgroupSystemcmdpolicyBinding -Groupname <string>
        An example how to delete systemgroup_systemcmdpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemgroupSystemcmdpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup_systemcmdpolicy_binding/
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
        [string]$Groupname,

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystemgroupSystemcmdpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemgroupSystemcmdpolicyBinding: Finished"
    }
}

function Invoke-NSGetSystemgroupSystemcmdpolicyBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER GetAll 
        Retrieve all systemgroup_systemcmdpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemgroup_systemcmdpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupSystemcmdpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemgroupSystemcmdpolicyBinding -GetAll 
        Get all systemgroup_systemcmdpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemgroupSystemcmdpolicyBinding -Count 
        Get the number of systemgroup_systemcmdpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupSystemcmdpolicyBinding -name <string>
        Get systemgroup_systemcmdpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupSystemcmdpolicyBinding -Filter @{ 'name'='<value>' }
        Get systemgroup_systemcmdpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemgroupSystemcmdpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup_systemcmdpolicy_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemgroupSystemcmdpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemgroup_systemcmdpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_systemcmdpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_systemcmdpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_systemcmdpolicy_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_systemcmdpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemgroupSystemcmdpolicyBinding: Ended"
    }
}

function Invoke-NSAddSystemgroupSystemuserBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the systemuser that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Username 
        The system user. 
    .PARAMETER PassThru 
        Return details about the created systemgroup_systemuser_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemgroupSystemuserBinding -groupname <string>
        An example how to add systemgroup_systemuser_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemgroupSystemuserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup_systemuser_binding/
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
        [string]$Groupname,

        [string]$Username,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemgroupSystemuserBinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSCmdlet.ShouldProcess("systemgroup_systemuser_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemgroup_systemuser_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemgroupSystemuserBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemgroupSystemuserBinding: Finished"
    }
}

function Invoke-NSDeleteSystemgroupSystemuserBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the systemuser that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Username 
        The system user.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemgroupSystemuserBinding -Groupname <string>
        An example how to delete systemgroup_systemuser_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemgroupSystemuserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup_systemuser_binding/
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
        [string]$Groupname,

        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystemgroupSystemuserBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Username') ) { $arguments.Add('username', $Username) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemgroupSystemuserBinding: Finished"
    }
}

function Invoke-NSGetSystemgroupSystemuserBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the systemuser that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER GetAll 
        Retrieve all systemgroup_systemuser_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemgroup_systemuser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupSystemuserBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemgroupSystemuserBinding -GetAll 
        Get all systemgroup_systemuser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemgroupSystemuserBinding -Count 
        Get the number of systemgroup_systemuser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupSystemuserBinding -name <string>
        Get systemgroup_systemuser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemgroupSystemuserBinding -Filter @{ 'name'='<value>' }
        Get systemgroup_systemuser_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemgroupSystemuserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemgroup_systemuser_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemgroupSystemuserBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemgroup_systemuser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_systemuser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_systemuser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_systemuser_binding configuration for property 'groupname'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_systemuser_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemgroupSystemuserBinding: Ended"
    }
}

function Invoke-NSCheckSystemhwerror {
    <#
    .SYNOPSIS
        Check System configuration. config Object.
    .DESCRIPTION
        Configuration for Hardware errors resource.
    .PARAMETER Diskcheck 
        Perform only disk error checking.
    .EXAMPLE
        PS C:\>Invoke-NSCheckSystemhwerror -diskcheck <boolean>
        An example how to check systemhwerror config Object(s).
    .NOTES
        File Name : Invoke-NSCheckSystemhwerror
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemhwerror/
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
        [boolean]$Diskcheck 

    )
    begin {
        Write-Verbose "Invoke-NSCheckSystemhwerror: Starting"
    }
    process {
        try {
            $payload = @{ diskcheck = $diskcheck }

            if ( $PSCmdlet.ShouldProcess($Name, "Check System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemhwerror -Action check -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSCheckSystemhwerror: Finished"
    }
}

function Invoke-NSChangeSystemkek {
    <#
    .SYNOPSIS
        Change System configuration. config Object.
    .DESCRIPTION
        Configuration for Key encryption Key resource.
    .PARAMETER Level 
        Type of update KEK to be performed. 
        *basic : The level basic will backup old keys and create new keys and respond back. 
        *extended : The level extended will backup old keys and create new keys, update 
        ns.conf, nscfg.db, all ns.conf for same release, in all partitions. While doing so 
        will block all config changes and once done shall respond back. 
        Possible values = basic, extended
    .EXAMPLE
        PS C:\>Invoke-NSChangeSystemkek -level <string>
        An example how to change systemkek config Object(s).
    .NOTES
        File Name : Invoke-NSChangeSystemkek
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemkek/
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
        [ValidateSet('basic', 'extended')]
        [string]$Level 
    )
    begin {
        Write-Verbose "Invoke-NSChangeSystemkek: Starting"
    }
    process {
        try {
            $payload = @{ level = $level }

            if ( $PSCmdlet.ShouldProcess("systemkek", "Change System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemkek -Action update -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSChangeSystemkek: Finished"
    }
}

function Invoke-NSUpdateSystemparameter {
    <#
    .SYNOPSIS
        Update System configuration. config Object.
    .DESCRIPTION
        Configuration for system parameter resource.
    .PARAMETER Rbaonresponse 
        Enable or disable Role-Based Authentication (RBA) on responses. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
         
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Natpcbforceflushlimit 
        Flush the system if the number of Network Address Translation Protocol Control Blocks (NATPCBs) exceeds this value. 
    .PARAMETER Natpcbrstontimeout 
        Send a reset signal to client and server connections when their NATPCBs time out. Avoids the buildup of idle TCP connections on both the sides. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument is enabled, Timeout can have values in the range [300-86400] seconds. 
        If Restrictedtimeout argument is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Localauth 
        When enabled, local users can access Citrix ADC even when external authentication is configured. When disabled, local users are not allowed to access the Citrix ADC, Local users can access the Citrix ADC only when the configured external authentication servers are unavailable. This parameter is not applicable to SSH Key-based authentication. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Minpasswordlen 
        Minimum length of system user password. When strong password is enabled default minimum length is 8. User entered value can be greater than or equal to 8. Default mininum value is 1 when strong password is disabled. Maximum value is 127 in both cases. 
         
        Maximum value = 127 
    .PARAMETER Strongpassword 
        After enabling strong password (enableall / enablelocal - not included in exclude list), all the passwords / sensitive information must have - Atleast 1 Lower case character, Atleast 1 Upper case character, Atleast 1 numeric character, Atleast 1 special character ( ~, `, !, @, #, $, %, ^, &amp;, *, -, _, =, +, {, }, [, ], |, \, :, &lt;, &gt;, /, .,,, " "). Exclude list in case of enablelocal is - NS_FIPS, NS_CRL, NS_RSAKEY, NS_PKCS12, NS_PKCS8, NS_LDAP, NS_TACACS, NS_TACACSACTION, NS_RADIUS, NS_RADIUSACTION, NS_ENCRYPTION_PARAMS. So no Strong Password checks will be performed on these ObjectType commands for enablelocal case. 
         
        Possible values = enableall, enablelocal, disabled 
    .PARAMETER Restrictedtimeout 
        Enable/Disable the restricted timeout behaviour. When enabled, timeout cannot be configured beyond admin configured timeout and also it will have the [minimum - maximum] range check. When disabled, timeout will have the old behaviour. By default the value is disabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Fipsusermode 
        Use this option to set the FIPS mode for key user-land processes. When enabled, these user-land processes will operate in FIPS mode. In this mode, these processes will use FIPS 140-2 certified crypto algorithms. 
        With a FIPS license, it is enabled by default and cannot be disabled. 
        Without a FIPS license, it is disabled by default, wherein these user-land processes will not operate in FIPS mode. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Doppler 
        Enable or disable Doppler. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Googleanalytics 
        Enable or disable Google analytics. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Totalauthtimeout 
        Total time a request can take for authentication/authorization. 
         
         
        Maximum value = 120 
    .PARAMETER Cliloglevel 
        Audit log level, which specifies the types of events to log for cli executed commands. 
        Available values function as follows: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
         
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Forcepasswordchange 
        Enable or disable force password change for nsroot user. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Basicauth 
        Enable or disable basic authentication for Nitro API. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Reauthonauthparamchange 
        Enable or disable External user reauthentication when authentication parameter changes. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Removesensitivefiles 
        Use this option to remove the sensitive files from the system like authorise keys, public keys etc. The commands which will remove sensitive files when this system paramter is enabled are rm cluster instance, rm cluster node, rm ha node, clear config full, join cluster and add cluster instance. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxsessionperuser 
        Maximum number of client connection allowed per user.The maxsessionperuser value ranges from 1 to 40. 
         
        Maximum value = 40 
    .PARAMETER Daystoexpire 
        nsroot password expire days. 
         
        Maximum value = 500 
    .PARAMETER Warnpriorndays 
        Number of days before which password expiration warning would be thrown with respect to datstoexpire. 
         
        Maximum value = 40
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSystemparameter 
        An example how to update systemparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSystemparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemparameter/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Rbaonresponse,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Promptstring,

        [double]$Natpcbforceflushlimit,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Natpcbrstontimeout,

        [double]$Timeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Localauth,

        [double]$Minpasswordlen,

        [ValidateSet('enableall', 'enablelocal', 'disabled')]
        [string]$Strongpassword,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Restrictedtimeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Fipsusermode,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Doppler,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Googleanalytics,

        [double]$Totalauthtimeout,

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$Cliloglevel,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Forcepasswordchange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Basicauth,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Reauthonauthparamchange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Removesensitivefiles,

        [double]$Maxsessionperuser,

        [double]$Daystoexpire,

        [double]$Warnpriorndays 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSystemparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('rbaonresponse') ) { $payload.Add('rbaonresponse', $rbaonresponse) }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('natpcbforceflushlimit') ) { $payload.Add('natpcbforceflushlimit', $natpcbforceflushlimit) }
            if ( $PSBoundParameters.ContainsKey('natpcbrstontimeout') ) { $payload.Add('natpcbrstontimeout', $natpcbrstontimeout) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('localauth') ) { $payload.Add('localauth', $localauth) }
            if ( $PSBoundParameters.ContainsKey('minpasswordlen') ) { $payload.Add('minpasswordlen', $minpasswordlen) }
            if ( $PSBoundParameters.ContainsKey('strongpassword') ) { $payload.Add('strongpassword', $strongpassword) }
            if ( $PSBoundParameters.ContainsKey('restrictedtimeout') ) { $payload.Add('restrictedtimeout', $restrictedtimeout) }
            if ( $PSBoundParameters.ContainsKey('fipsusermode') ) { $payload.Add('fipsusermode', $fipsusermode) }
            if ( $PSBoundParameters.ContainsKey('doppler') ) { $payload.Add('doppler', $doppler) }
            if ( $PSBoundParameters.ContainsKey('googleanalytics') ) { $payload.Add('googleanalytics', $googleanalytics) }
            if ( $PSBoundParameters.ContainsKey('totalauthtimeout') ) { $payload.Add('totalauthtimeout', $totalauthtimeout) }
            if ( $PSBoundParameters.ContainsKey('cliloglevel') ) { $payload.Add('cliloglevel', $cliloglevel) }
            if ( $PSBoundParameters.ContainsKey('forcepasswordchange') ) { $payload.Add('forcepasswordchange', $forcepasswordchange) }
            if ( $PSBoundParameters.ContainsKey('basicauth') ) { $payload.Add('basicauth', $basicauth) }
            if ( $PSBoundParameters.ContainsKey('reauthonauthparamchange') ) { $payload.Add('reauthonauthparamchange', $reauthonauthparamchange) }
            if ( $PSBoundParameters.ContainsKey('removesensitivefiles') ) { $payload.Add('removesensitivefiles', $removesensitivefiles) }
            if ( $PSBoundParameters.ContainsKey('maxsessionperuser') ) { $payload.Add('maxsessionperuser', $maxsessionperuser) }
            if ( $PSBoundParameters.ContainsKey('daystoexpire') ) { $payload.Add('daystoexpire', $daystoexpire) }
            if ( $PSBoundParameters.ContainsKey('warnpriorndays') ) { $payload.Add('warnpriorndays', $warnpriorndays) }
            if ( $PSCmdlet.ShouldProcess("systemparameter", "Update System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUpdateSystemparameter: Finished"
    }
}

function Invoke-NSUnsetSystemparameter {
    <#
    .SYNOPSIS
        Unset System configuration. config Object.
    .DESCRIPTION
        Configuration for system parameter resource.
    .PARAMETER Minpasswordlen 
        Minimum length of system user password. When strong password is enabled default minimum length is 8. User entered value can be greater than or equal to 8. Default mininum value is 1 when strong password is disabled. Maximum value is 127 in both cases. 
         
        Maximum value = 127 
    .PARAMETER Rbaonresponse 
        Enable or disable Role-Based Authentication (RBA) on responses. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
         
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Natpcbforceflushlimit 
        Flush the system if the number of Network Address Translation Protocol Control Blocks (NATPCBs) exceeds this value. 
    .PARAMETER Natpcbrstontimeout 
        Send a reset signal to client and server connections when their NATPCBs time out. Avoids the buildup of idle TCP connections on both the sides. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument is enabled, Timeout can have values in the range [300-86400] seconds. 
        If Restrictedtimeout argument is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Localauth 
        When enabled, local users can access Citrix ADC even when external authentication is configured. When disabled, local users are not allowed to access the Citrix ADC, Local users can access the Citrix ADC only when the configured external authentication servers are unavailable. This parameter is not applicable to SSH Key-based authentication. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Strongpassword 
        After enabling strong password (enableall / enablelocal - not included in exclude list), all the passwords / sensitive information must have - Atleast 1 Lower case character, Atleast 1 Upper case character, Atleast 1 numeric character, Atleast 1 special character ( ~, `, !, @, #, $, %, ^, &amp;, *, -, _, =, +, {, }, [, ], |, \, :, &lt;, &gt;, /, .,,, " "). Exclude list in case of enablelocal is - NS_FIPS, NS_CRL, NS_RSAKEY, NS_PKCS12, NS_PKCS8, NS_LDAP, NS_TACACS, NS_TACACSACTION, NS_RADIUS, NS_RADIUSACTION, NS_ENCRYPTION_PARAMS. So no Strong Password checks will be performed on these ObjectType commands for enablelocal case. 
         
        Possible values = enableall, enablelocal, disabled 
    .PARAMETER Restrictedtimeout 
        Enable/Disable the restricted timeout behaviour. When enabled, timeout cannot be configured beyond admin configured timeout and also it will have the [minimum - maximum] range check. When disabled, timeout will have the old behaviour. By default the value is disabled. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Fipsusermode 
        Use this option to set the FIPS mode for key user-land processes. When enabled, these user-land processes will operate in FIPS mode. In this mode, these processes will use FIPS 140-2 certified crypto algorithms. 
        With a FIPS license, it is enabled by default and cannot be disabled. 
        Without a FIPS license, it is disabled by default, wherein these user-land processes will not operate in FIPS mode. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Doppler 
        Enable or disable Doppler. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Googleanalytics 
        Enable or disable Google analytics. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Totalauthtimeout 
        Total time a request can take for authentication/authorization. 
         
         
        Maximum value = 120 
    .PARAMETER Cliloglevel 
        Audit log level, which specifies the types of events to log for cli executed commands. 
        Available values function as follows: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
         
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Forcepasswordchange 
        Enable or disable force password change for nsroot user. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Basicauth 
        Enable or disable basic authentication for Nitro API. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Reauthonauthparamchange 
        Enable or disable External user reauthentication when authentication parameter changes. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Removesensitivefiles 
        Use this option to remove the sensitive files from the system like authorise keys, public keys etc. The commands which will remove sensitive files when this system paramter is enabled are rm cluster instance, rm cluster node, rm ha node, clear config full, join cluster and add cluster instance. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxsessionperuser 
        Maximum number of client connection allowed per user.The maxsessionperuser value ranges from 1 to 40. 
         
        Maximum value = 40 
    .PARAMETER Daystoexpire 
        nsroot password expire days. 
         
        Maximum value = 500 
    .PARAMETER Warnpriorndays 
        Number of days before which password expiration warning would be thrown with respect to datstoexpire. 
         
        Maximum value = 40
    .EXAMPLE
        PS C:\>Invoke-NSUnsetSystemparameter 
        An example how to unset systemparameter config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetSystemparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemparameter
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

        [Boolean]$minpasswordlen,

        [Boolean]$rbaonresponse,

        [Boolean]$promptstring,

        [Boolean]$natpcbforceflushlimit,

        [Boolean]$natpcbrstontimeout,

        [Boolean]$timeout,

        [Boolean]$localauth,

        [Boolean]$strongpassword,

        [Boolean]$restrictedtimeout,

        [Boolean]$fipsusermode,

        [Boolean]$doppler,

        [Boolean]$googleanalytics,

        [Boolean]$totalauthtimeout,

        [Boolean]$cliloglevel,

        [Boolean]$forcepasswordchange,

        [Boolean]$basicauth,

        [Boolean]$reauthonauthparamchange,

        [Boolean]$removesensitivefiles,

        [Boolean]$maxsessionperuser,

        [Boolean]$daystoexpire,

        [Boolean]$warnpriorndays 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetSystemparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('minpasswordlen') ) { $payload.Add('minpasswordlen', $minpasswordlen) }
            if ( $PSBoundParameters.ContainsKey('rbaonresponse') ) { $payload.Add('rbaonresponse', $rbaonresponse) }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('natpcbforceflushlimit') ) { $payload.Add('natpcbforceflushlimit', $natpcbforceflushlimit) }
            if ( $PSBoundParameters.ContainsKey('natpcbrstontimeout') ) { $payload.Add('natpcbrstontimeout', $natpcbrstontimeout) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('localauth') ) { $payload.Add('localauth', $localauth) }
            if ( $PSBoundParameters.ContainsKey('strongpassword') ) { $payload.Add('strongpassword', $strongpassword) }
            if ( $PSBoundParameters.ContainsKey('restrictedtimeout') ) { $payload.Add('restrictedtimeout', $restrictedtimeout) }
            if ( $PSBoundParameters.ContainsKey('fipsusermode') ) { $payload.Add('fipsusermode', $fipsusermode) }
            if ( $PSBoundParameters.ContainsKey('doppler') ) { $payload.Add('doppler', $doppler) }
            if ( $PSBoundParameters.ContainsKey('googleanalytics') ) { $payload.Add('googleanalytics', $googleanalytics) }
            if ( $PSBoundParameters.ContainsKey('totalauthtimeout') ) { $payload.Add('totalauthtimeout', $totalauthtimeout) }
            if ( $PSBoundParameters.ContainsKey('cliloglevel') ) { $payload.Add('cliloglevel', $cliloglevel) }
            if ( $PSBoundParameters.ContainsKey('forcepasswordchange') ) { $payload.Add('forcepasswordchange', $forcepasswordchange) }
            if ( $PSBoundParameters.ContainsKey('basicauth') ) { $payload.Add('basicauth', $basicauth) }
            if ( $PSBoundParameters.ContainsKey('reauthonauthparamchange') ) { $payload.Add('reauthonauthparamchange', $reauthonauthparamchange) }
            if ( $PSBoundParameters.ContainsKey('removesensitivefiles') ) { $payload.Add('removesensitivefiles', $removesensitivefiles) }
            if ( $PSBoundParameters.ContainsKey('maxsessionperuser') ) { $payload.Add('maxsessionperuser', $maxsessionperuser) }
            if ( $PSBoundParameters.ContainsKey('daystoexpire') ) { $payload.Add('daystoexpire', $daystoexpire) }
            if ( $PSBoundParameters.ContainsKey('warnpriorndays') ) { $payload.Add('warnpriorndays', $warnpriorndays) }
            if ( $PSCmdlet.ShouldProcess("systemparameter", "Unset System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type systemparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetSystemparameter: Finished"
    }
}

function Invoke-NSGetSystemparameter {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for system parameter resource.
    .PARAMETER GetAll 
        Retrieve all systemparameter object(s).
    .PARAMETER Count
        If specified, the count of the systemparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemparameter -GetAll 
        Get all systemparameter data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemparameter -name <string>
        Get systemparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemparameter -Filter @{ 'name'='<value>' }
        Get systemparameter data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemparameter
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemparameter/
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
        Write-Verbose "Invoke-NSGetSystemparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemparameter objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemparameter configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemparameter: Ended"
    }
}

function Invoke-NSCreateSystemrestorepoint {
    <#
    .SYNOPSIS
        Create System configuration. config Object.
    .DESCRIPTION
        Configuration for Setting restorepoints for auto restore resource.
    .PARAMETER Filename 
        Name of the restore point.
    .EXAMPLE
        PS C:\>Invoke-NSCreateSystemrestorepoint -filename <string>
        An example how to create systemrestorepoint config Object(s).
    .NOTES
        File Name : Invoke-NSCreateSystemrestorepoint
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemrestorepoint/
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
        [ValidateLength(1, 63)]
        [string]$Filename 

    )
    begin {
        Write-Verbose "Invoke-NSCreateSystemrestorepoint: Starting"
    }
    process {
        try {
            $payload = @{ filename = $filename }

            if ( $PSCmdlet.ShouldProcess($Name, "Create System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemrestorepoint -Action create -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSCreateSystemrestorepoint: Finished"
    }
}

function Invoke-NSDeleteSystemrestorepoint {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Configuration for Setting restorepoints for auto restore resource.
    .PARAMETER Filename 
        Name of the restore point.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemrestorepoint -Filename <string>
        An example how to delete systemrestorepoint config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemrestorepoint
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemrestorepoint/
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
        [string]$Filename 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystemrestorepoint: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$filename", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemrestorepoint -NitroPath nitro/v1/config -Resource $filename -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemrestorepoint: Finished"
    }
}

function Invoke-NSGetSystemrestorepoint {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for Setting restorepoints for auto restore resource.
    .PARAMETER Filename 
        Name of the restore point. 
    .PARAMETER GetAll 
        Retrieve all systemrestorepoint object(s).
    .PARAMETER Count
        If specified, the count of the systemrestorepoint object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemrestorepoint
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemrestorepoint -GetAll 
        Get all systemrestorepoint data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemrestorepoint -Count 
        Get the number of systemrestorepoint objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemrestorepoint -name <string>
        Get systemrestorepoint object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemrestorepoint -Filter @{ 'name'='<value>' }
        Get systemrestorepoint data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemrestorepoint
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemrestorepoint/
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
        [ValidateLength(1, 63)]
        [string]$Filename,

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
        Write-Verbose "Invoke-NSGetSystemrestorepoint: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemrestorepoint objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemrestorepoint -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemrestorepoint objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemrestorepoint -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemrestorepoint objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemrestorepoint -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemrestorepoint configuration for property 'filename'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemrestorepoint -NitroPath nitro/v1/config -Resource $filename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemrestorepoint configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemrestorepoint -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemrestorepoint: Ended"
    }
}

function Invoke-NSKillSystemsession {
    <#
    .SYNOPSIS
        Kill System configuration. config Object.
    .DESCRIPTION
        Configuration for system session resource.
    .PARAMETER Sid 
        ID of the system session about which to display information. 
    .PARAMETER All 
        Terminate all the system sessions except the current session.
    .EXAMPLE
        PS C:\>Invoke-NSKillSystemsession 
        An example how to kill systemsession config Object(s).
    .NOTES
        File Name : Invoke-NSKillSystemsession
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemsession/
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

        [double]$Sid,

        [boolean]$All 

    )
    begin {
        Write-Verbose "Invoke-NSKillSystemsession: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sid') ) { $payload.Add('sid', $sid) }
            if ( $PSBoundParameters.ContainsKey('all') ) { $payload.Add('all', $all) }
            if ( $PSCmdlet.ShouldProcess($Name, "Kill System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemsession -Action kill -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSKillSystemsession: Finished"
    }
}

function Invoke-NSGetSystemsession {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for system session resource.
    .PARAMETER Sid 
        ID of the system session about which to display information. 
    .PARAMETER GetAll 
        Retrieve all systemsession object(s).
    .PARAMETER Count
        If specified, the count of the systemsession object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemsession
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemsession -GetAll 
        Get all systemsession data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemsession -Count 
        Get the number of systemsession objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemsession -name <string>
        Get systemsession object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemsession -Filter @{ 'name'='<value>' }
        Get systemsession data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemsession
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemsession/
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
        [double]$Sid,

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
        Write-Verbose "Invoke-NSGetSystemsession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemsession objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemsession objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemsession objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemsession -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemsession configuration for property 'sid'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemsession -NitroPath nitro/v1/config -Resource $sid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemsession configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemsession: Ended"
    }
}

function Invoke-NSDeleteSystemsshkey {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Name 
        URL \(protocol, host, path, and file name\) from where the location file will be imported. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Sshkeytype 
        The type of the ssh key whether public or private key. 
        Possible values = PRIVATE, PUBLIC
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemsshkey -Name <string>
        An example how to delete systemsshkey config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemsshkey
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemsshkey/
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

        [string]$Sshkeytype 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystemsshkey: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Sshkeytype') ) { $arguments.Add('sshkeytype', $Sshkeytype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemsshkey -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemsshkey: Finished"
    }
}

function Invoke-NSImportSystemsshkey {
    <#
    .SYNOPSIS
        Import System configuration. config Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Name 
        URL \(protocol, host, path, and file name\) from where the location file will be imported. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Src 
        URL \(protocol, host, path, and file name\) from where the location file will be imported. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Sshkeytype 
        The type of the ssh key whether public or private key. 
        Possible values = PRIVATE, PUBLIC
    .EXAMPLE
        PS C:\>Invoke-NSImportSystemsshkey -name <string> -src <string> -sshkeytype <string>
        An example how to import systemsshkey config Object(s).
    .NOTES
        File Name : Invoke-NSImportSystemsshkey
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemsshkey/
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
        [ValidateLength(1, 255)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateSet('PRIVATE', 'PUBLIC')]
        [string]$Sshkeytype 

    )
    begin {
        Write-Verbose "Invoke-NSImportSystemsshkey: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                src            = $src
                sshkeytype     = $sshkeytype
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Import System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemsshkey -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSImportSystemsshkey: Finished"
    }
}

function Invoke-NSGetSystemsshkey {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Sshkeytype 
        The type of the ssh key whether public or private key. 
        Possible values = PRIVATE, PUBLIC 
    .PARAMETER GetAll 
        Retrieve all systemsshkey object(s).
    .PARAMETER Count
        If specified, the count of the systemsshkey object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemsshkey
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemsshkey -GetAll 
        Get all systemsshkey data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemsshkey -name <string>
        Get systemsshkey object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemsshkey -Filter @{ 'name'='<value>' }
        Get systemsshkey data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemsshkey
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemsshkey/
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
        [ValidateSet('PRIVATE', 'PUBLIC')]
        [string]$Sshkeytype,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemsshkey: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemsshkey objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemsshkey -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemsshkey objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemsshkey -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemsshkey objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('sshkeytype') ) { $arguments.Add('sshkeytype', $sshkeytype) }
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemsshkey -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemsshkey configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemsshkey configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemsshkey -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemsshkey: Ended"
    }
}

function Invoke-NSAddSystemuser {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Configuration for system user resource.
    .PARAMETER Username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user'). 
    .PARAMETER Password 
        Password for the system user. Can include any ASCII character. 
    .PARAMETER Externalauth 
        Whether to use external authentication servers for the system user authentication or not. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
         
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds. If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Logging 
        Users logging privilege. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxsession 
        Maximum number of client connection allowed per user. 
         
        Maximum value = 40 
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces to the system user. By default user is allowed from both API and CLI interfaces. If management interface for a user is set to API, then user is not allowed to access NS through CLI. GUI interface will come under API interface. 
         
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemuser item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemuser -username <string> -password <string>
        An example how to add systemuser config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemuser
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Externalauth = 'ENABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Promptstring,

        [double]$Timeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logging = 'DISABLED',

        [double]$Maxsession,

        [ValidateSet('CLI', 'API')]
        [string[]]$Allowedmanagementinterface = 'NS_INTERFACE_ALL',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemuser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username
                password           = $password
            }
            if ( $PSBoundParameters.ContainsKey('externalauth') ) { $payload.Add('externalauth', $externalauth) }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('maxsession') ) { $payload.Add('maxsession', $maxsession) }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSCmdlet.ShouldProcess("systemuser", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method POST -NitroPath nitro/v1/config -Type systemuser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemuser -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemuser: Finished"
    }
}

function Invoke-NSDeleteSystemuser {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Configuration for system user resource.
    .PARAMETER Username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user').
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemuser -Username <string>
        An example how to delete systemuser config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemuser
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser/
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
        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystemuser: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$username", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemuser -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemuser: Finished"
    }
}

function Invoke-NSUpdateSystemuser {
    <#
    .SYNOPSIS
        Update System configuration. config Object.
    .DESCRIPTION
        Configuration for system user resource.
    .PARAMETER Username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user'). 
    .PARAMETER Password 
        Password for the system user. Can include any ASCII character. 
    .PARAMETER Externalauth 
        Whether to use external authentication servers for the system user authentication or not. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
         
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds. If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Logging 
        Users logging privilege. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxsession 
        Maximum number of client connection allowed per user. 
         
        Maximum value = 40 
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces to the system user. By default user is allowed from both API and CLI interfaces. If management interface for a user is set to API, then user is not allowed to access NS through CLI. GUI interface will come under API interface. 
         
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemuser item.
    .EXAMPLE
        PS C:\>Invoke-NSUpdateSystemuser -username <string>
        An example how to update systemuser config Object(s).
    .NOTES
        File Name : Invoke-NSUpdateSystemuser
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Externalauth,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Promptstring,

        [double]$Timeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logging,

        [double]$Maxsession,

        [ValidateSet('CLI', 'API')]
        [string[]]$Allowedmanagementinterface,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSUpdateSystemuser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSBoundParameters.ContainsKey('externalauth') ) { $payload.Add('externalauth', $externalauth) }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('maxsession') ) { $payload.Add('maxsession', $maxsession) }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSCmdlet.ShouldProcess("systemuser", "Update System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemuser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemuser -Filter $payload)
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
        Write-Verbose "Invoke-NSUpdateSystemuser: Finished"
    }
}

function Invoke-NSUnsetSystemuser {
    <#
    .SYNOPSIS
        Unset System configuration. config Object.
    .DESCRIPTION
        Configuration for system user resource.
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces to the system user. By default user is allowed from both API and CLI interfaces. If management interface for a user is set to API, then user is not allowed to access NS through CLI. GUI interface will come under API interface. 
         
        Possible values = CLI, API 
    .PARAMETER Username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user'). 
    .PARAMETER Externalauth 
        Whether to use external authentication servers for the system user authentication or not. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
         
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds. If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Logging 
        Users logging privilege. 
         
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxsession 
        Maximum number of client connection allowed per user. 
         
        Maximum value = 40
    .EXAMPLE
        PS C:\>Invoke-NSUnsetSystemuser -username <string>
        An example how to unset systemuser config Object(s).
    .NOTES
        File Name : Invoke-NSUnsetSystemuser
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser
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

        [Boolean]$allowedmanagementinterface,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

        [Boolean]$externalauth,

        [Boolean]$promptstring,

        [Boolean]$timeout,

        [Boolean]$logging,

        [Boolean]$maxsession 
    )
    begin {
        Write-Verbose "Invoke-NSUnsetSystemuser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSBoundParameters.ContainsKey('externalauth') ) { $payload.Add('externalauth', $externalauth) }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('maxsession') ) { $payload.Add('maxsession', $maxsession) }
            if ( $PSCmdlet.ShouldProcess("$username", "Unset System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method POST -Type systemuser -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-NSUnsetSystemuser: Finished"
    }
}

function Invoke-NSGetSystemuser {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Configuration for system user resource.
    .PARAMETER Username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
         
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user'). 
    .PARAMETER GetAll 
        Retrieve all systemuser object(s).
    .PARAMETER Count
        If specified, the count of the systemuser object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuser
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemuser -GetAll 
        Get all systemuser data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemuser -Count 
        Get the number of systemuser objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuser -name <string>
        Get systemuser object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuser -Filter @{ 'name'='<value>' }
        Get systemuser data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemuser
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

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
        Write-Verbose "Invoke-NSGetSystemuser: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemuser objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemuser: Ended"
    }
}

function Invoke-NSGetSystemuserBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to systemuser.
    .PARAMETER Username 
        Name of a system user about whom to display information. 
    .PARAMETER GetAll 
        Retrieve all systemuser_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemuser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemuserBinding -GetAll 
        Get all systemuser_binding data.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserBinding -name <string>
        Get systemuser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserBinding -Filter @{ 'name'='<value>' }
        Get systemuser_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemuserBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser_binding/
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
        [string]$Username,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemuserBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemuser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemuserBinding: Ended"
    }
}

function Invoke-NSAddSystemuserNspartitionBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER Partitionname 
        Name of the Partition to bind to the system user. 
    .PARAMETER PassThru 
        Return details about the created systemuser_nspartition_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemuserNspartitionBinding -username <string>
        An example how to add systemuser_nspartition_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemuserNspartitionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser_nspartition_binding/
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
        [string]$Username,

        [string]$Partitionname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemuserNspartitionBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('partitionname') ) { $payload.Add('partitionname', $partitionname) }
            if ( $PSCmdlet.ShouldProcess("systemuser_nspartition_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemuser_nspartition_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemuserNspartitionBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemuserNspartitionBinding: Finished"
    }
}

function Invoke-NSDeleteSystemuserNspartitionBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER Partitionname 
        Name of the Partition to bind to the system user.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemuserNspartitionBinding -Username <string>
        An example how to delete systemuser_nspartition_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemuserNspartitionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser_nspartition_binding/
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
        [string]$Username,

        [string]$Partitionname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystemuserNspartitionBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Partitionname') ) { $arguments.Add('partitionname', $Partitionname) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemuserNspartitionBinding: Finished"
    }
}

function Invoke-NSGetSystemuserNspartitionBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER GetAll 
        Retrieve all systemuser_nspartition_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemuser_nspartition_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserNspartitionBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemuserNspartitionBinding -GetAll 
        Get all systemuser_nspartition_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemuserNspartitionBinding -Count 
        Get the number of systemuser_nspartition_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserNspartitionBinding -name <string>
        Get systemuser_nspartition_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserNspartitionBinding -Filter @{ 'name'='<value>' }
        Get systemuser_nspartition_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemuserNspartitionBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser_nspartition_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemuserNspartitionBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemuser_nspartition_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_nspartition_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_nspartition_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_nspartition_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_nspartition_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemuserNspartitionBinding: Ended"
    }
}

function Invoke-NSAddSystemuserSystemcmdpolicyBinding {
    <#
    .SYNOPSIS
        Add System configuration. config Object.
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER Policyname 
        The name of command policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER PassThru 
        Return details about the created systemuser_systemcmdpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-NSAddSystemuserSystemcmdpolicyBinding -username <string>
        An example how to add systemuser_systemcmdpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSAddSystemuserSystemcmdpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser_systemcmdpolicy_binding/
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
        [string]$Username,

        [string]$Policyname,

        [double]$Priority,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-NSAddSystemuserSystemcmdpolicyBinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSCmdlet.ShouldProcess("systemuser_systemcmdpolicy_binding", "Add System configuration. config Object") ) {
                $result = Invoke-NSNitroApi -NSSession $NSSession -Method PUT -NitroPath nitro/v1/config -Type systemuser_systemcmdpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-NSGetSystemuserSystemcmdpolicyBinding -Filter $payload)
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
        Write-Verbose "Invoke-NSAddSystemuserSystemcmdpolicyBinding: Finished"
    }
}

function Invoke-NSDeleteSystemuserSystemcmdpolicyBinding {
    <#
    .SYNOPSIS
        Delete System configuration. config Object.
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER Policyname 
        The name of command policy.
    .EXAMPLE
        PS C:\>Invoke-NSDeleteSystemuserSystemcmdpolicyBinding -Username <string>
        An example how to delete systemuser_systemcmdpolicy_binding config Object(s).
    .NOTES
        File Name : Invoke-NSDeleteSystemuserSystemcmdpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser_systemcmdpolicy_binding/
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
        [string]$Username,

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-NSDeleteSystemuserSystemcmdpolicyBinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete System configuration. config Object") ) {
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method DELETE -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Write-Verbose "Invoke-NSDeleteSystemuserSystemcmdpolicyBinding: Finished"
    }
}

function Invoke-NSGetSystemuserSystemcmdpolicyBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER GetAll 
        Retrieve all systemuser_systemcmdpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemuser_systemcmdpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserSystemcmdpolicyBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemuserSystemcmdpolicyBinding -GetAll 
        Get all systemuser_systemcmdpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemuserSystemcmdpolicyBinding -Count 
        Get the number of systemuser_systemcmdpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserSystemcmdpolicyBinding -name <string>
        Get systemuser_systemcmdpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserSystemcmdpolicyBinding -Filter @{ 'name'='<value>' }
        Get systemuser_systemcmdpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemuserSystemcmdpolicyBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser_systemcmdpolicy_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemuserSystemcmdpolicyBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemuser_systemcmdpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_systemcmdpolicy_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_systemcmdpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_systemcmdpolicy_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_systemcmdpolicy_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemuserSystemcmdpolicyBinding: Ended"
    }
}

function Invoke-NSGetSystemuserSystemgroupBinding {
    <#
    .SYNOPSIS
        Get System configuration. config object(s).
    .DESCRIPTION
        Binding object showing the systemgroup that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER GetAll 
        Retrieve all systemuser_systemgroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemuser_systemgroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserSystemgroupBinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemuserSystemgroupBinding -GetAll 
        Get all systemuser_systemgroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-NSGetSystemuserSystemgroupBinding -Count 
        Get the number of systemuser_systemgroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserSystemgroupBinding -name <string>
        Get systemuser_systemgroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-NSGetSystemuserSystemgroupBinding -Filter @{ 'name'='<value>' }
        Get systemuser_systemgroup_binding data with a filter.
    .NOTES
        File Name : Invoke-NSGetSystemuserSystemgroupBinding
        Version   : v2311.2021
        Author    : John Billekens
        Reference : https://developer-docs.netscaler.com/en-us/adc-nitro-api/current-release/configuration/system/systemuser_systemgroup_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-NSGetSystemuserSystemgroupBinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemuser_systemgroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_systemgroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_systemgroup_binding objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_systemgroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_systemgroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_systemgroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_systemgroup_binding configuration for property 'username'"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_systemgroup_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_systemgroup_binding configuration objects"
                $response = Invoke-NSNitroApi -NSSession $NSSession -Method GET -Type systemuser_systemgroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-NSGetSystemuserSystemgroupBinding: Ended"
    }
}

# SIG # Begin signature block
# MIIkmgYJKoZIhvcNAQcCoIIkizCCJIcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDmHEVizyzMt4qS
# Rag8kxawkmwcdg4TMOac0/EoLOUms6CCHl4wggTzMIID26ADAgECAhAsJ03zZBC0
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
# hkiG9w0BCQQxIgQgbkvNADzeAcAhukmAlR6ZjfP0aLFyY1yARajzNb99VFIwDQYJ
# KoZIhvcNAQEBBQAEggEAJYKokkt2oUAmVIl1cwc/8qBgdL1htuldOtWN2aYbuk8P
# yABHGs5y6e5Lkp7g/udQRVpQc5wAyS6HcvivQqd3D70voxRXTiRDV4ENv6zgH6xl
# uyPQPxeUW1vc/K5UTDEs1lsakuyGNXdyaDZLPhMIBC+R8hncwCWRKu0Uqvb+RJrC
# 6Jvhjuw/RGMZssYfPga/9+DeHJPam44J98U8y0pJB2bIcMuL1u5IVWezvYjVpK8q
# oc/d9EBINR30bBF4L4ZlKy2sIlLNeFSYPGgrTOVqlIQ+ZfWka7oTPXj7pMwkHhg6
# 4hsz8cZphMNC9EcvrNTN6h9JKx6zrAs/L8KmwMOugqGCA0swggNHBgkqhkiG9w0B
# CQYxggM4MIIDNAIBATCBkTB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EC
# EDlMJeF8oG0nqGXiO9kdItQwDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMx
# CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjAyMDQzNDlaMD8GCSqG
# SIb3DQEJBDEyBDAkewGCFFrbcDLNxi3D3JWluwzSdNsl7cP2gh6VCZ8mnCBF4r3z
# +0vI1OAI2aNCjcEwDQYJKoZIhvcNAQEBBQAEggIAfFA5xs1KrDSueuzXhykPksFJ
# FD3veBkSEhPwQ/dbnEd+hKbt8O+f4+kMM6r9kAzdt3Re7Plgn6HJp9j7/+FyV2L6
# gNR35cjj7ArUAHnWhaDL+yXDZ9naIwkDdlMXMc4YblKwFAHakOEvzdaa0aLrOAnK
# xtpy/lMySKh8tpdS3IOHoI9+z1+x4osrue2+GxQZI8YCJRLuoJZa07IIzIQeb8Yg
# TwZzzmE5z9Hoi7JGpeiRtCRl4FYtRjdinGDawjPso2p68eebMqLSZfb7+EHx+b34
# zRzNEk1RisCJv/CYedwVMzIFwdFoN+J9lgtlGlrS/w8fAoT/YR4e1ZgRRqh6bGDi
# 08sQEyiheywBlnC2pya4CmZdC5WTD/gEg/9/xMrbTDvUnZSMhopOo8t7L02XZb1o
# 2SUdYLrJkC6PhnglZqr+ywpBOcuyS02xN+kEYqttToXHSmZkRdgwXCYTqwY06g4K
# t35rtoo+CsDudZujARXaVrjM0xSWdIemngXO73eM6hj9+BOcBMw3+of4+1pj0QN/
# /njL4VrwWQrG319/geCUmgLoQnpgmN3FdLA1ldBNfzY/zuI5WS0OWIYKxR+mv+Sm
# oPGh4/m41O5ktBKs0HSy6F/GhT3YL03i/+G1L/1cw7OV9/qKI+WY5Z3rO9nXfdrQ
# DmsnxhMSg2LiIc93uhs=
# SIG # End signature block
