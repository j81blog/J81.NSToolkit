function Save-NSLogonParams {
    <#
    .SYNOPSIS
        Save the logon parameters to an internal variable
    .DESCRIPTION
        Save the logon parameters to an internal variable
    .PARAMETER NSSession
        Specify a current NSSession object
    .PARAMETER ManagementURL
        Specify the URL of the NetScaler Management Service
    .PARAMETER Credential
        Specify the credentials to use for the connection
    .EXAMPLE
        PS C:\>Save-NSLogonParams -Credential (Get-Credential) -ManagementURL https://netscaler.company.com
        Save the credential and management URL to the internal variable
    .NOTES
        File Name : Get-NSSession
        Version   : v2401.3122.0
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    NS 13.0 and up
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [PSObject]$NSSession,

        [Parameter()]
        [string]$ManagementURL,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty
    )

    if ($NSSession.IsConnected -eq $true) {
        Write-Verbose "Saving NSSession to internal variable"
        $nsToolkitCommon.ModuleValues.NSSession = $NSSession
    }
    if ([String]::IsNullOrEmpty($ManagementURL) -eq $false) {
        Write-Verbose "Saving ManagementURL to internal variable"
        $nsToolkitCommon.ModuleValues.ManagementURL = $ManagementURL
    }
    if ($Credential -ne [System.Management.Automation.PSCredential]::Empty) {
        Write-Verbose "Saving Credential to internal variable"
        $nsToolkitCommon.ModuleValues.Credential = $Credential
    }
}

