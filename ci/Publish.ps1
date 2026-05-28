[CmdletBinding()]
param(
    [Parameter()]
    [string]$GitRef = $env:GITHUB_REF,

    [Parameter()]
    [string]$PSGalleryApiKey = $env:PSGALLERY_API_KEY,

    [Parameter()]
    [string]$PSTestGalleryApiKey = $env:PSTESTGALLERY_API_KEY,

    [Parameter()]
    [switch]$WhatIfPublish
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path -Path (Join-Path -Path $PSScriptRoot -ChildPath '..')).Path
$env:PSModulePath = "$repoRoot;$env:PSModulePath"

$modules = @(
    @{ Name = 'J81.NSToolkit.Common'; Path = '.\J81.NSToolkit\J81.NSToolkit.Common'; Manifest = '.\J81.NSToolkit\J81.NSToolkit.Common\J81.NSToolkit.Common.psd1' },
    @{ Name = 'J81.NSToolkit'; Path = '.\J81.NSToolkit'; Manifest = '.\J81.NSToolkit\J81.NSToolkit.psd1' },
    @{ Name = 'J81.NSToolkit.Config'; Path = '.\J81.NSToolkit\J81.NSToolkit.Config'; Manifest = '.\J81.NSToolkit\J81.NSToolkit.Config\J81.NSToolkit.Config.psd1' },
    @{ Name = 'J81.NSToolkit.Stats'; Path = '.\J81.NSToolkit\J81.NSToolkit.Stats'; Manifest = '.\J81.NSToolkit\J81.NSToolkit.Stats\J81.NSToolkit.Stats.psd1' },
    @{ Name = 'J81.NSToolkit.Bundle'; Path = '.\J81.NSToolkit\J81.NSToolkit.Bundle'; Manifest = '.\J81.NSToolkit\J81.NSToolkit.Bundle\J81.NSToolkit.Bundle.psd1' }
)

if ($GitRef -eq 'refs/heads/main') {
    $repository = 'PSGallery'
    $apiKey = $PSGalleryApiKey
} elseif ($GitRef -eq 'refs/heads/dev') {
    $repository = 'PSTestGallery'
    $apiKey = $PSTestGalleryApiKey
} else {
    throw "Unsupported branch ref '$GitRef'. Publishing is supported only from refs/heads/main and refs/heads/dev."
}

if ([string]::IsNullOrWhiteSpace($apiKey)) {
    throw "Missing API key for repository '$repository'."
}

Import-Module -Name PowerShellGet -Force -ErrorAction Stop

if ($repository -eq 'PSTestGallery' -and -not (Get-PSRepository -Name 'PSTestGallery' -ErrorAction SilentlyContinue)) {
    Register-PSRepository `
        -Name 'PSTestGallery' `
        -SourceLocation 'https://www.poshtestgallery.com/api/v2' `
        -PublishLocation 'https://www.poshtestgallery.com/api/v2/package/' `
        -ScriptSourceLocation 'https://www.poshtestgallery.com/api/v2/items/psscript' `
        -ScriptPublishLocation 'https://www.poshtestgallery.com/api/v2/package/' `
        -InstallationPolicy Trusted
}

foreach ($module in $modules) {
    $manifestPath = Join-Path -Path $repoRoot -ChildPath $module.Manifest
    $publishPath = Join-Path -Path $repoRoot -ChildPath $module.Path

    $manifest = Test-ModuleManifest -Path $manifestPath
    [Version]$version = $manifest.Version

    $exists = $false
    try {
        $null = Find-Module -Name $module.Name -Repository $repository -RequiredVersion $version -ErrorAction Stop
        $exists = $true
    } catch {
        $exists = $false
    }

    if ($exists) {
        Write-Warning "$($module.Name) $version already exists in $repository. Skipping."
        continue
    }

    if ($WhatIfPublish) {
        Write-Host "[WhatIf] Would publish $($module.Name) $version to $repository from '$publishPath'."
        continue
    }

    Publish-Module -Path $publishPath -Repository $repository -NuGetApiKey $apiKey -ErrorAction Stop
    Write-Host "$($module.Name) $version published to $repository."
}
