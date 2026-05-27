function Copy-RequestCertificateNetScalerFile {
<#
    .SYNOPSIS
        Uploads a local certificate file to a NetScaler appliance.

    .DESCRIPTION
        Uploads a local file to /nsconfig/ssl by using the generated systemfile
        functions. If the file already exists on the appliance, the existing file is
        deleted and the upload is retried.

    .PARAMETER NSSession
        Existing NetScaler session returned by Connect-NSNode.

    .PARAMETER Path
        Local path to the file that must be uploaded.

    .PARAMETER FileName
        Target file name to use under /nsconfig/ssl on the NetScaler appliance.

    .NOTES
        Function  : Copy-RequestCertificateNetScalerFile
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [object]$NSSession,

        [Parameter(Mandatory)]
        [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
        [string]$Path,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$FileName
    )

    $Bytes = [System.IO.File]::ReadAllBytes($Path)
    $FileContent = [Convert]::ToBase64String($Bytes)
    $AddParams = @{
        NSSession    = $NSSession
        Filename     = $FileName
        Filecontent  = $FileContent
        Filelocation = '/nsconfig/ssl/'
        Fileencoding = 'BASE64'
    }

    try {
        Invoke-NSAddSystemfile @AddParams | Out-Null
    } catch {
        if ($_.Exception.Message -notmatch 'File already exists|\[1642\]') { throw }
        Write-RequestCertificateLog Info 'NetScaler' "Replacing existing uploaded file '$FileName'."
        try {
            $DeleteParams = @{
                NSSession    = $NSSession
                Filename     = $FileName
                Filelocation = '/nsconfig/ssl/'
            }
            Invoke-NSDeleteSystemfile @DeleteParams | Out-Null
        } catch {
            if ($_.Exception.Message -notmatch '404|Not Found|No such resource|No such|\[258\]') { throw }
        }
        Invoke-NSAddSystemfile @AddParams | Out-Null
    }
}
