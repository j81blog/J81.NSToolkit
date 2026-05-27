function New-RequestCertificatePassword {
<#
    .SYNOPSIS
        Generates a random password for certificate artifacts.

    .DESCRIPTION
        Generates a random password with RandomNumberGenerator for use as a temporary
        PFX password when no explicit password is provided.

    .PARAMETER Length
        Number of characters to generate.

    .NOTES
        Function  : New-RequestCertificatePassword
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param([int]$Length = 20)

    $chars = 'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789!@$%+=?'.ToCharArray()
    $bytes = [byte[]]::new($Length)
    [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
    -join ($bytes | ForEach-Object { $chars[$_ % $chars.Length] })
}
