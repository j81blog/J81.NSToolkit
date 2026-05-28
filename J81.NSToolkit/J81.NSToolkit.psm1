[CmdletBinding()]
param()

function Import-NSToolkitConfigModule {
    [CmdletBinding()]
    param(
        [switch]$Force
    )

    Import-Module -Name 'J81.NSToolkit.Config' -Force:$Force -ErrorAction Stop | Out-Null
}

function Import-NSToolkitStatsModule {
    [CmdletBinding()]
    param(
        [switch]$Force
    )

    Import-Module -Name 'J81.NSToolkit.Stats' -Force:$Force -ErrorAction Stop | Out-Null
}

Export-ModuleMember -Function @(
    'Connect-NSHANodes',
    'Connect-NSNode',
    'Disconnect-NSNode',
    'Expand-NSResult',
    'Get-NSSession',
    'Invoke-NSCleanCertKeyFiles',
    'Invoke-NSGetSystemFileDirectories',
    'Invoke-NSNitroApi',
    'Invoke-RequestCertificate',
    'Import-NSToolkitConfigModule',
    'Import-NSToolkitStatsModule',
    'New-NSRequestCertificateUser',
    'Remove-NSSystemFile',
    'Save-NSLogonParams'
)
