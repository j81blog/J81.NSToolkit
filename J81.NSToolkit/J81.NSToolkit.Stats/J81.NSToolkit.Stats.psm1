[CmdletBinding()]
Param()

$classPath = Join-Path -Path $(Split-Path -Path $PSScriptRoot -Parent) -ChildPath 'J81.NSToolkit.Common\Internal\Classes.psm1'
if (Test-Path $classPath) {
    #this is to get the class definitions shared between modules
    $useBlock = [ScriptBlock]::Create("using module '$classPath'")
    . $useBlock
}

$nsToolkitStats = New-Object Settings

# Get public and private function definition files.
$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction Ignore -Recurse)
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction Ignore -Recurse )

# Dot source the files
Foreach ($import in @($Public + $Private)) {
    Try {
        . $import.FullName
    } Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

