function ConvertFrom-RequestCertificateLegacySecret {
<#
    .SYNOPSIS
        Converts legacy request-certificate secret values.

    .DESCRIPTION
        Converts plain text, SecureString, PSCredential, and legacy JSON password
        objects into a SecureString or clear text value. Legacy encrypted values are
        decrypted with the historical static AES key used by GenLeCertForNS.

    .PARAMETER Object
        Secret object to convert.

    .PARAMETER AsClearText
        Returns the secret as clear text instead of SecureString.

    .NOTES
        Function  : ConvertFrom-RequestCertificateLegacySecret
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param(
        [object]$Object,
        [switch]$AsClearText
    )

    if ($null -eq $Object -or [string]::IsNullOrEmpty([string]$Object)) {
        if ($AsClearText) { return '' }
        return [securestring]::new()
    }

    if ($Object -is [securestring]) {
        if ($AsClearText) { return (New-Object pscredential ' ', $Object).GetNetworkCredential().Password }
        return $Object
    }

    if ($Object -is [string]) {
        if ($AsClearText) { return $Object }
        return ConvertTo-SecureString -String $Object -AsPlainText -Force
    }

    if ($Object -is [pscredential]) {
        if ($AsClearText) { return $Object.GetNetworkCredential().Password }
        return $Object.Password
    }

    if (($Object.PSObject.Properties.Name -contains 'Password') -and ($Object.PSObject.Properties.Name -contains 'IsEncrypted')) {
        if ($Object.Password -eq '<null>') {
            if ($AsClearText) { return '' }
            return [securestring]::new()
        }
        if ($Object.IsEncrypted) { $secure = ConvertTo-SecureString -Key (0..15) $Object.Password }
        else { $secure = ConvertTo-SecureString -String ([string]$Object.Password) -AsPlainText -Force }
        if ($AsClearText) { return (New-Object pscredential ' ', $secure).GetNetworkCredential().Password }
        return $secure
    }

    throw "Unsupported secret object type '$($Object.GetType().FullName)'."
}
