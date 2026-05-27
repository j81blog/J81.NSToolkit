function Invoke-RequestCertificatePostScript {
<#
    .SYNOPSIS
        Runs a post-certificate PowerShell script.

    .DESCRIPTION
        Executes a configured script after successful certificate deployment. The
        script receives legacy-compatible Thumbprint, PFXfilename, and PFXPassword
        parameters plus optional extra parameters.

    .PARAMETER ScriptPath
        Script path or script name.

    .PARAMETER ScriptRoot
        Root used to resolve relative script names from the scripts folder.

    .PARAMETER Thumbprint
        Certificate thumbprint.

    .PARAMETER PfxPath
        PFX file path.

    .PARAMETER PfxPassword
        PFX password in clear text.

    .PARAMETER ExtraParameters
        Additional named parameters.

    .NOTES
        Function  : Invoke-RequestCertificatePostScript
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2218
#>
    [CmdletBinding()]
    param(
        [string]$ScriptPath,
        [string]$ScriptRoot,
        [string]$Thumbprint,
        [string]$PfxPath,
        [string]$PfxPassword,
        [object]$ExtraParameters
    )

    if ([string]::IsNullOrWhiteSpace($ScriptPath)) { return $null }
    if (-not (Split-Path -Path $ScriptPath -Parent -ErrorAction SilentlyContinue)) {
        $ScriptPath = Join-Path -Path (Join-Path -Path $ScriptRoot -ChildPath 'scripts') -ChildPath $ScriptPath
    }
    $resolved = try { (Resolve-Path -LiteralPath $ScriptPath -ErrorAction Stop).Path } catch { $null }
    if (-not $resolved) {
        Write-RequestCertificateLog Error 'PostScript' "Post script not found: $ScriptPath"
        return [pscustomobject]@{ Status = 'NotFound'; ScriptPath = $ScriptPath; ExitCode = $null }
    }

    $extra = ConvertTo-RequestCertificateHashtable -InputObject $ExtraParameters
    try {
        Write-RequestCertificateLog Info 'PostScript' "Executing post script '$resolved'."
        $output = & $resolved -Thumbprint $Thumbprint -PFXfilename $PfxPath -PFXPassword $PfxPassword @extra *>&1
        foreach ($line in @($output)) { Write-RequestCertificateLog Debug 'PostScript' ([string]$line) }
        return [pscustomobject]@{ Status = 'Completed'; ScriptPath = $resolved; ExitCode = $global:LASTEXITCODE }
    } catch {
        Write-RequestCertificateLog Error 'PostScript' "Post script failed: $($_.Exception.Message)"
        return [pscustomobject]@{ Status = 'Failed'; ScriptPath = $resolved; ExitCode = $global:LASTEXITCODE; Message = $_.Exception.Message }
    }
}
