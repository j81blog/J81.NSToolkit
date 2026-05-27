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
    'Import-NSToolkitConfigModule',
    'Import-NSToolkitStatsModule'
)
