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

$ProgressPreference = [System.Management.Automation.ActionPreference]::SilentlyContinue
$WarningPreference = [System.Management.Automation.ActionPreference]::SilentlyContinue

if (Get-Variable -Name projectRoot -ErrorAction "SilentlyContinue") {
    # Configure the test environment
    $testsPath = Join-Path -Path $projectRoot -ChildPath "Tests"
    Write-Host "Tests path........:$testsPath"
    $testOutput = Join-Path -Path $projectRoot -ChildPath "TestsResults.xml"
    Write-Host "Output path.......:$testOutput"
    $testConfig = New-PesterConfiguration -Hashtable @{
        Run        = @{
            Path     = $testsPath
            PassThru = $True
        }
        TestResult = @{
            Enabled      = $true
            OutputFormat = "NUnitXml"
            OutputPath   = $testOutput
        }
        Output     = @{
            Verbosity = "Detailed"
        }
    }

    # Invoke Pester tests
    $res = Invoke-Pester -Configuration $testConfig

    if ($res.FailedCount -gt 0) { Throw "$($res.FailedCount) tests failed." }
} else {
    Write-Warning -Message "Required variable does not exist: projectRoot."
}

# Line break for readability in AppVeyor console
Write-Host ""
