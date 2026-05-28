function Invoke-RequestCertificateDnsOrder {
<#
    .SYNOPSIS
        Requests an ACME certificate using Posh-ACME DNS validation.

    .DESCRIPTION
        Uses Posh-ACME New-PACertificate to create, validate, finalize, and download
        a certificate through DNS plugin validation. Legacy DNSParams values are
        converted into PluginArgs.

    .PARAMETER Request
        Certificate request object.

    .PARAMETER Domains
        Domains for the certificate order.

    .PARAMETER PfxSecret
        PFX password as SecureString.

    .PARAMETER AcmeOptions
        Normalized ACME options hashtable.

    .PARAMETER Force
        Forces Posh-ACME to renew the DNS validated certificate.

    .NOTES
        Function  : Invoke-RequestCertificateDnsOrder
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2218
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object]$Request,
        [Parameter(Mandatory)][string[]]$Domains,
        [Parameter(Mandatory)][securestring]$PfxSecret,
        [Parameter(Mandatory)][hashtable]$AcmeOptions,
        [switch]$Force
    )

    $plugin = if ($Request.DNSPlugin) { $Request.DNSPlugin } elseif ($AcmeOptions.DNSPlugin) { $AcmeOptions.DNSPlugin } else { 'Manual' }
    $pluginArgs = if ($Request.DNSParams) { ConvertTo-RequestCertificateHashtable -InputObject $Request.DNSParams } else { ConvertTo-RequestCertificateHashtable -InputObject $AcmeOptions.DNSParams }

    $params = @{
        Domain          = $Domains
        Contact         = $Request.EmailAddress
        AcceptTOS       = $true
        Plugin          = $plugin
        PluginArgs      = $pluginArgs
        DnsSleep        = if ($Request.DNSWaitTime) { [int]$Request.DNSWaitTime } else { [int]$AcmeOptions.DNSWaitTime }
        PfxPassSecure   = $PfxSecret
        FriendlyName    = $Request.FriendlyName
        Force           = ([bool]$Force -or [bool]$Request.ForceCertRenew)
        ErrorAction     = 'Stop'
    }
    if ($Request.KeyLength) { $params.CertKeyLength = [string]$Request.KeyLength }
    if ($AcmeOptions.UseModernPfxEncryption) { $params.UseModernPfxEncryption = $true }
    if ($AcmeOptions.PreferredChain) { $params.PreferredChain = $AcmeOptions.PreferredChain }
    if ($AcmeOptions.Profile) { $params.Profile = $AcmeOptions.Profile }
    if ($AcmeOptions.LifetimeDays) { $params.LifetimeDays = [int]$AcmeOptions.LifetimeDays }
    if ($AcmeOptions.ValidationTimeout) { $params.ValidationTimeout = [int]$AcmeOptions.ValidationTimeout }
    if ($AcmeOptions.DnsAlias) { $params.DnsAlias = $AcmeOptions.DnsAlias }
    if ($AcmeOptions.AlwaysNewKey) { $params.AlwaysNewKey = $true }

    Write-RequestCertificateLog Info 'ACME' "Requesting DNS certificate for $($Domains -join ', ') using plugin '$plugin'."
    New-PACertificate @params
}
