[OutputType()]
param (
    $ModuleName = 'AppVentiX'
)
Write-Host ""
Write-Host "Script............: $($myInvocation.myCommand.name)"

# Set variables
if (Test-Path -Path 'env:GITHUB_WORKSPACE') {
    # Github Testing
    $environment = "GITHUB"
    Write-Host "GITHUB_RUN_NUMBER.: ${env:GITHUB_RUN_NUMBER}"
    Write-Host "GITHUB Branch.....: ${env:GITHUB_REF_NAME}"
} else {
    # Local Testing
    $environment = "LOCAL"
}

$projectRoot = ( Resolve-Path -Path ( Split-Path -Parent -Path $PSScriptRoot ) ).Path
$moduleRoot = (Join-Path -Path $projectRoot -ChildPath "AppVentiX")

Import-Module -Name PowerShellGet -Force
Write-Host "Environment.......: $environment"
Write-Host "Module root.......: $moduleRoot"

$psTestGalleryUri = 'https://www.poshtestgallery.com/api/v2/'
Register-PackageSource -Trusted -ProviderName 'PowerShellGet' -Name 'PSTestGallery' -Location $psTestGalleryUri -Force -ErrorAction SilentlyContinue | Out-Null

$moduleManifest = Test-ModuleManifest -Path (Join-Path -Path $moduleRoot -ChildPath "$($ModuleName).psd1")

if ($moduleManifest) {
    Write-Host "Module manifest...: $($moduleManifest.Name)"
    Write-Host "Module name.......: $($ModuleName)"
    Write-Host "Module version....: $($moduleManifest.Version)"
} else {
    Write-Error "Module manifest not found." -ErrorAction Stop
}


$environments = @{}
$environments['dev'] = @{
    NugetApiKey = ${env:NugetApiKeyDev}
    Path        = $moduleRoot
    Repository  = 'PSTestGallery'
    ErrorAction = "Stop"
}
$environments['main'] = @{
    NugetApiKey = ${env:NugetApiKey}
    Path        = $moduleRoot
    Repository  = 'PSGallery'
    ErrorAction = "Stop"
}

$existingModules = Find-Module -Name $ModuleName -Repository $($environments["${env:GITHUB_REF_NAME}"].Repository) -ErrorAction SilentlyContinue -AllVersions

Write-Host "Gallery...........: $($environments["${env:GITHUB_REF_NAME}"].Repository)"
$params = $environments["${env:GITHUB_REF_NAME}"]
if ($($moduleManifest.Version).ToString() -in $existingModules.Version) {
    Write-Host "Module version....: $($moduleManifest.Version) already exists in $($environments["${env:GITHUB_REF_NAME}"].Repository)." -ForegroundColor Cyan
} else {
    Write-Host "Module version....: $($moduleManifest.Version) does not yet exist in $($environments["${env:GITHUB_REF_NAME}"].Repository)." -ForegroundColor Cyan
    Write-Host "Publishing module to $($environments["${env:GITHUB_REF_NAME}"].Repository)..."
    Publish-Module @params
}

Write-Host "Cleaning up..."
Unregister-PSRepository -Name PSTestGallery -ErrorAction SilentlyContinue | Out-Null
Write-Host "Publishing finished."