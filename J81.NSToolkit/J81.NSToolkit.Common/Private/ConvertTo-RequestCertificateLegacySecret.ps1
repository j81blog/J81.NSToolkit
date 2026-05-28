function ConvertTo-RequestCertificateLegacySecret {
<#
    .SYNOPSIS
        Converts a secret to the legacy encrypted JSON secret object.

    .DESCRIPTION
        Converts plain text, SecureString, PSCredential, and existing legacy
        password objects to the GenLeCertForNS-compatible JSON representation
        with Password and IsEncrypted properties. Encryption uses the historical
        static AES key so existing config files remain portable in the same way
        as the legacy script.

    .PARAMETER Object
        Secret object to convert.

    .NOTES
        Function  : ConvertTo-RequestCertificateLegacySecret
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0527.2145
#>
    [CmdletBinding()]
    param(
        [Parameter()]
        [object]$Object
    )

    if ($null -eq $Object -or [string]::IsNullOrEmpty([string]$Object)) {
        return [pscustomobject]@{
            Password    = '<null>'
            IsEncrypted = $false
        }
    }

    $secure = ConvertFrom-RequestCertificateLegacySecret -Object $Object
    [pscustomobject]@{
        Password    = ConvertFrom-SecureString -SecureString $secure -Key (0..15)
        IsEncrypted = $true
    }
}
