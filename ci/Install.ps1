[OutputType()]
param ()
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
Write-Host "Environment.......: $environment"
Write-Host "Project root......: $ProjectRoot"

# Install packages

if (-Not ($packageProvider = Get-PackageProvider -ListAvailable | Where-Object { $_.Name -like "Nuget" -and $_.Version -ge $([System.Version]"2.8.5.208") })) {
    Install-PackageProvider -Name NuGet -MinimumVersion "2.8.5.208" -Force
}

If (Get-PSRepository -Name PSGallery | Where-Object { $_.InstallationPolicy -ne "Trusted" }) {
    Write-Host "Trust repository..: PSGallery." -ForegroundColor Cyan
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}
$Modules = @('PowerShellGet', 'Pester', 'PSScriptAnalyzer', 'posh-git', 'MarkdownPS')
ForEach ($Module in $Modules) {
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "Checking module...: $Module." -ForegroundColor Cyan
    If ([System.Version]((Find-Module -Name $Module | Sort-Object -Property Version -Descending | Select-Object -First 1).Version) -gt [System.Version](Get-Module -Name $Module -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1).Version) {
        Write-Host "Installing module.: $Module." -ForegroundColor Cyan
        Install-Module -Name $Module -SkipPublisherCheck -Force
        Write-Host "Loading...........: $Module" -ForegroundColor Cyan
        Import-Module -Name $Module -Force
    } else {
        Write-Host "Loading...........: $Module" -ForegroundColor Cyan
        Import-Module -Name $Module -Force
    }
}
