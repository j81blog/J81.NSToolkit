function Invoke-RequestCertificate {
    <#
    .SYNOPSIS
        Request an ACME certificate and deploy it to a NetScaler.
    .DESCRIPTION
        Compatibility-focused module version of GenLeCertForNS. This first converted path supports HTTP-01 validation through a NetScaler and deploys the resulting certificate to /nsconfig/ssl. The public parameter surface intentionally mirrors the legacy script so existing config files and wrappers keep binding.
    #>
    [CmdletBinding(DefaultParameterSetName = 'LECertificatesHTTP')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    param(
        [Parameter(ParameterSetName = 'Help', Mandatory = $true)][Alias('h')][Switch]$Help,
        [Parameter(ParameterSetName = 'CleanADC', Mandatory = $true)][Alias('CleanNS')][Switch]$CleanADC,
        [Parameter(ParameterSetName = 'CleanTestCertificate', Mandatory = $true)][Switch]$RemoveTestCertificates,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanTestCertificate')][Switch]$CleanPoshACMEStorage,
        [Parameter(ParameterSetName = 'CommandPolicy', Mandatory = $true)][Parameter(ParameterSetName = 'CommandPolicyUser', Mandatory = $true)][Parameter(ParameterSetName = 'LECertificatesHTTP', Mandatory = $true)][Parameter(ParameterSetName = 'LECertificatesDNS', Mandatory = $true)][Parameter(ParameterSetName = 'CleanADC', Mandatory = $true)][Parameter(ParameterSetName = 'CleanTestCertificate', Mandatory = $true)][Alias('URL', 'NSManagementURL')][String]$ManagementURL,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Parameter(ParameterSetName = 'CleanTestCertificate')][Alias('User', 'NSUsername', 'ADCUsername')][String]$Username,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Parameter(ParameterSetName = 'CleanTestCertificate')][Alias('NSPassword', 'ADCPassword')][Object]$Password,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Parameter(ParameterSetName = 'CleanTestCertificate')][Alias('NSCredential', 'ADCCredential')][System.Management.Automation.PSCredential]$Credential = [System.Management.Automation.PSCredential]::Empty,
        [Parameter(ParameterSetName = 'LECertificatesHTTP', Mandatory = $true)][Parameter(ParameterSetName = 'LECertificatesDNS', Mandatory = $true)][String]$CN,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][String[]]$SAN = @(),
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][String]$FriendlyName,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][ValidateSet('http', 'dns')][String]$ValidationMethod = 'http',
        [Parameter(ParameterSetName = 'LECertificatesDNS')][String]$DNSPlugin = 'Manual',
        [Parameter(ParameterSetName = 'LECertificatesDNS')][Object]$DNSParams = @{},
        [Parameter(ParameterSetName = 'LECertificatesDNS')][Int]$DNSWaitTime = 30,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Alias('NSCertNameToUpdate')][String]$CertKeyNameToUpdate,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$RemovePrevious,
        [Parameter(ParameterSetName = 'LECertificatesHTTP', Mandatory = $true)][Parameter(ParameterSetName = 'LECertificatesDNS', Mandatory = $true)][Parameter(ParameterSetName = 'CleanExpiredCerts', Mandatory = $true)][String]$CertDir,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Object]$PfxPassword = $null,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][String]$EmailAddress,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][ValidateScript({
                if ($_ -is [int] -or $_ -as [int]) {
                    $size = [int]$_
                    if ($size -lt 2048 -or $size -gt 4096 -or ($size % 128) -ne 0) { throw 'Unsupported RSA key size. Must be 2048-4096 and divisible by 128.' }
                    return $true
                }
                if ([string]$_ -notin @('ec-256', 'ec-384', 'ec-521')) { throw 'Unsupported key size. Use RSA 2048-4096 or ec-256, ec-384, ec-521.' }
                return $true
            })][Object]$KeyLength = 2048,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'AutoRun')][Switch]$Production,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Parameter(ParameterSetName = 'CleanTestCertificate')][Switch]$DisableLogging,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Parameter(ParameterSetName = 'CleanTestCertificate')][Alias('LogLocation')][String]$LogFile = '<DEFAULT>',
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Parameter(ParameterSetName = 'CleanTestCertificate')][ValidateSet('Error', 'Warning', 'Info', 'Debug', 'None')][String]$LogLevel = 'Info',
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Alias('SaveNSConfig')][Switch]$SaveADCConfig,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$SendMail,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][String[]]$SMTPTo,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][String]$SMTPFrom,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][System.Management.Automation.PSCredential]$SMTPCredential = [System.Management.Automation.PSCredential]::Empty,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][String]$SMTPServer,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Int]$SMTPPort = 25,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$SMTPUseSSL,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$LogAsAttachment,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$DisableIPCheck,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$IPv6,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$UpdateIIS,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$UpdateGlobalVPNCertBinding,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$GlobalVPNCertBindingIncludeCA,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][ValidateSet('Mandatory', 'Optional')][String]$GlobalVPNCertBindingCrlCheck,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][ValidateSet('Mandatory', 'Optional')][String]$GlobalVPNCertBindingOcspCheck,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][String]$IISSiteToUpdate = 'Default Web Site',
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][String]$PostPoSHScriptFilename,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Hashtable]$PostPoSHScriptExtraParameters = @{},
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Alias('NSCsVipName')][String[]]$CsVipName,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$UseLbVip,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Alias('NSCspName')][String]$CspName = 'csp_letsencrypt',
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][String]$CsaName = 'csa_letsencrypt',
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Alias('NSCsVipBinding')][String]$CsVipBinding = '11',
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Alias('NSSvcName')][String]$SvcName = 'svc_letsencrypt_cert_dummy',
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Alias('NSSvcDestination')][String]$SvcDestination = '1.2.3.4',
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Alias('NSLbName')][String]$LbName = 'lb_letsencrypt_cert',
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Alias('TD')][Int]$TrafficDomain = 0,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Alias('NSRspName')][String]$RspName = 'rsp_letsencrypt',
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'CleanADC')][Alias('NSRsaName')][String]$RsaName = 'rsa_letsencrypt',
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP', DontShow)][Parameter(ParameterSetName = 'LECertificatesDNS', DontShow)][Parameter(ParameterSetName = 'CleanADC', DontShow)][String[]]$Partitions = @('default'),
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$EnableVipBefore,
        [Parameter(ParameterSetName = 'LECertificatesDNS')][String]$AlternateDNSValidationDomain,
        [Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$AlternateDNSValidationDomainSkipCheck,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$UseNetScalerDNS,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$DisableVipAfter,
        [Parameter(ParameterSetName = 'CommandPolicy', Mandatory = $true)][Parameter(ParameterSetName = 'CommandPolicyUser', Mandatory = $true)][Switch]$CreateUserPermissions,
        [Parameter(ParameterSetName = 'CommandPolicy')][Parameter(ParameterSetName = 'CommandPolicyUser')][String]$NSCPName = 'script-GenLeCertForNS',
        [Parameter(ParameterSetName = 'CommandPolicyUser', Mandatory = $true)][Switch]$CreateApiUser,
        [Parameter(ParameterSetName = 'CommandPolicyUser', Mandatory = $true)][String]$ApiUsername,
        [Parameter(ParameterSetName = 'CommandPolicyUser', Mandatory = $true)][Object]$ApiPassword,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'AutoRun', Mandatory = $true)][String]$ConfigFile = $null,
        [Parameter(ParameterSetName = 'AutoRun', Mandatory = $true)][Switch]$AutoRun,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'AutoRun')][Alias('Force')][Switch]$ForceCertRenew,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Parameter(ParameterSetName = 'AutoRun')][Switch]$StopOnError,
        [Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Switch]$CleanExpiredCertsOnDisk,
        [Parameter(ParameterSetName = 'CleanExpiredCerts', Mandatory = $true)][Switch]$CleanAllExpiredCertsOnDisk,
        [Parameter(ParameterSetName = 'CleanExpiredCerts')][Parameter(ParameterSetName = 'LECertificatesHTTP')][Parameter(ParameterSetName = 'LECertificatesDNS')][Int16]$CleanExpiredCertsOnDiskDays = 100,
        [Switch]$NoConsoleOutput,
        [ValidateSet('LetsEncrypt', 'ZeroSSL', 'Google', 'SSLCom', 'Actalis', 'CustomAcme')][String]$CertificateProvider = 'LetsEncrypt',
        [String]$AcmeDirectoryUrl,
        [Switch]$UseModernPfxEncryption,
        [String]$PreferredChain,
        [String]$Profile,
        [String[]]$DnsAlias,
        [Int]$ValidationTimeout = 240,
        [Int]$LifetimeDays,
        [Switch]$AlwaysNewKey,
        [Switch]$RemoveUploadedPfx
    )

    begin {
        $script:RequestCertificateLogFile = $null
        $script:RequestCertificateLogLevel = $LogLevel

        $script:RequestCertificateNoConsoleOutput = [bool]$NoConsoleOutput
    }

    process {
        if ($Help) { Get-Help Invoke-RequestCertificate -Detailed; return }
        if ($CleanAllExpiredCertsOnDisk) {
            return Remove-RequestCertificateExpiredDiskCertificate -CertDir $CertDir -Days $CleanExpiredCertsOnDiskDays
        }

        Import-Module Posh-ACME -MinimumVersion 4.31.0 -ErrorAction Stop
        Import-Module J81.NSToolkit.Config -ErrorAction SilentlyContinue

        $scriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
        $settings = [pscustomobject]@{}
        $requests = @()
        if ($AutoRun) {
            if (-not (Test-Path -LiteralPath $ConfigFile)) { throw "Config file not found: $ConfigFile" }
            $config = Get-Content -LiteralPath $ConfigFile -Raw | ConvertFrom-Json
            $settings = $config.settings
            $requests = @($config.certrequests | Where-Object { $_.Enabled -ne $false })
            if (-not $ManagementURL) { $ManagementURL = $settings.ManagementURL }
            if (-not $Credential -or $Credential -eq [pscredential]::Empty) {
                if ($settings.ADCCredentialUsername -and $settings.ADCCredentialPassword) {
                    $Credential = [pscredential]::new($settings.ADCCredentialUsername, (ConvertFrom-RequestCertificateLegacySecret -Object $settings.ADCCredentialPassword))
                }
            }
            if ($settings.LogFile) { $LogFile = $settings.LogFile }
            if ($settings.LogLevel) { $LogLevel = $settings.LogLevel; $script:RequestCertificateLogLevel = $LogLevel }
        } else {
            $requests = @([pscustomobject]@{ Enabled = $true; CN = $CN; SANs = ($SAN -join ','); FriendlyName = $FriendlyName; CsVipName = $CsVipName; UseLbVip = [bool]$UseLbVip; EnableVipBefore = [bool]$EnableVipBefore; DisableVipAfter = [bool]$DisableVipAfter; CertKeyNameToUpdate = $CertKeyNameToUpdate; RemovePrevious = [bool]$RemovePrevious; CertDir = $CertDir; EmailAddress = $EmailAddress; KeyLength = $KeyLength; ValidationMethod = $ValidationMethod; DNSPlugin = $DNSPlugin; DNSParams = $DNSParams; DNSWaitTime = $DNSWaitTime; AlternateDNSValidationDomain = $AlternateDNSValidationDomain; AlternateDNSValidationDomainSkipCheck = [bool]$AlternateDNSValidationDomainSkipCheck; UseNetScalerDNS = [bool]$UseNetScalerDNS; ForceCertRenew = [bool]$ForceCertRenew; DisableIPCheck = [bool]$DisableIPCheck; PfxPassword = $PfxPassword; UpdateIIS = [bool]$UpdateIIS; IISSiteToUpdate = $IISSiteToUpdate; UpdateGlobalVPNCertBinding = [bool]$UpdateGlobalVPNCertBinding; GlobalVPNCertBindingIncludeCA = [bool]$GlobalVPNCertBindingIncludeCA; GlobalVPNCertBindingCrlCheck = $GlobalVPNCertBindingCrlCheck; GlobalVPNCertBindingOcspCheck = $GlobalVPNCertBindingOcspCheck; PostPoSHScriptFilename = $PostPoSHScriptFilename; PostPoSHScriptExtraParameters = $PostPoSHScriptExtraParameters; CleanExpiredCertsOnDisk = [bool]$CleanExpiredCertsOnDisk; CleanExpiredCertsOnDiskDays = $CleanExpiredCertsOnDiskDays })
            $settings = [pscustomobject]@{ ManagementURL = $ManagementURL; SvcName = $SvcName; SvcDestination = $SvcDestination; LbName = $LbName; RspName = $RspName; RsaName = $RsaName; CspName = $CspName; CsaName = $CsaName; CsVipBinding = $CsVipBinding; TrafficDomain = $TrafficDomain; SaveADCConfig = [bool]$SaveADCConfig; DisableIPCheck = [bool]$DisableIPCheck; SendMail = [bool]$SendMail; SMTPTo = $SMTPTo; SMTPFrom = $SMTPFrom; SMTPCredential = $SMTPCredential; SMTPServer = $SMTPServer; SMTPPort = $SMTPPort; SMTPUseSSL = [bool]$SMTPUseSSL; LogAsAttachment = [bool]$LogAsAttachment }
        }
        foreach ($name in 'SvcName', 'SvcDestination', 'LbName', 'RspName', 'RsaName', 'CspName', 'CsaName', 'CsVipBinding', 'TrafficDomain', 'SaveADCConfig', 'SendMail', 'SMTPTo', 'SMTPFrom', 'SMTPServer', 'SMTPPort', 'SMTPUseSSL', 'LogAsAttachment') {
            if (-not ($settings.PSObject.Properties.Name -contains $name)) { $settings | Add-Member -NotePropertyName $name -NotePropertyValue (Get-Variable $name -ValueOnly) }
        }
        if (-not ($settings.PSObject.Properties.Name -contains 'SMTPCredential')) { $settings | Add-Member -NotePropertyName SMTPCredential -NotePropertyValue $SMTPCredential }
        if (($settings.SMTPCredential -eq [pscredential]::Empty -or -not $settings.SMTPCredential -or $settings.SMTPCredential -isnot [pscredential]) -and $settings.SMTPCredentialUsername -and $settings.SMTPCredentialPassword) {
            $settings.SMTPCredential = [pscredential]::new($settings.SMTPCredentialUsername, (ConvertFrom-RequestCertificateLegacySecret -Object $settings.SMTPCredentialPassword))
        }
        if ($LogFile -eq '<DEFAULT>' -or [string]::IsNullOrWhiteSpace($LogFile)) { $LogFile = Join-Path $scriptRoot 'Invoke-RequestCertificate.log' }
        if (-not $DisableLogging) {
            $script:RequestCertificateLogFile = $LogFile
            Initialize-RequestCertificateLog -Path $LogFile
        }
        if (-not $Credential -or $Credential -eq [pscredential]::Empty) {
            if ($Username -and $Password) { $Credential = [pscredential]::new($Username, (ConvertFrom-RequestCertificateLegacySecret -Object $Password)) }
            else { throw 'No NetScaler credential specified. Use -Credential, -Username/-Password, or config file credentials.' }
        }
        if (-not $ManagementURL) { $ManagementURL = $settings.ManagementURL }
        $ManagementURL = ([string]$ManagementURL).TrimEnd('/') + '/'
        $settings.ManagementURL = $ManagementURL
        $configChanged = $false

        if ($AutoRun) {
            foreach ($propertyName in 'ADCCredentialPassword', 'SMTPCredentialPassword') {
                if (($settings.PSObject.Properties.Name -contains $propertyName) -and $settings.$propertyName -and ($settings.$propertyName.PSObject.Properties.Name -contains 'IsEncrypted') -and -not $settings.$propertyName.IsEncrypted) {
                    $settings.$propertyName = ConvertTo-RequestCertificateLegacySecret -Object $settings.$propertyName
                    $configChanged = $true
                }
            }

            foreach ($request in @($requests)) {
                if (($request.PSObject.Properties.Name -contains 'PfxPassword') -and $request.PfxPassword -and ($request.PfxPassword.PSObject.Properties.Name -contains 'IsEncrypted') -and -not $request.PfxPassword.IsEncrypted) {
                    $request.PfxPassword = ConvertTo-RequestCertificateLegacySecret -Object $request.PfxPassword
                    $configChanged = $true
                }
            }
        }

        $serverName = if ($AcmeDirectoryUrl) {
            $AcmeDirectoryUrl
        } elseif ($Production) {
            switch ($CertificateProvider) {
                'ZeroSSL' { 'ZEROSSL_PROD' }
                'Google' { 'GOOGLE_PROD' }
                'SSLCom' { 'SSLCOM_RSA' }
                'Actalis' { 'ACTALIS_PROD' }
                default { 'LE_PROD' }
            }
        } else {
            switch ($CertificateProvider) {
                'Google' { 'GOOGLE_STAGE' }
                default { 'LE_STAGE' }
            }
        }
        Write-RequestCertificateLog Info 'ACME' "Using ACME server '$serverName'. Production=$([bool]$Production)."
        Set-PAServer -DirectoryUrl $serverName -ErrorAction Stop | Out-Null
        if ($CleanPoshACMEStorage) {
            $acmeStorage = Join-Path $env:LOCALAPPDATA 'Posh-ACME'
            Remove-Item -LiteralPath $acmeStorage -Recurse -Force -ErrorAction SilentlyContinue
            New-Item -Path $acmeStorage -ItemType Directory -Force | Out-Null
        }

        Write-RequestCertificateLog Info 'NetScaler' "Connecting to $ManagementURL as $($Credential.UserName)."
        $nsSession = Connect-NSNode -ManagementURL $ManagementURL -Credential $Credential -PassThru -ErrorAction Stop
        if ($CreateUserPermissions -or $CreateApiUser) {
            $userParams = @{
                NSSession                   = $nsSession
                PolicyName                  = $NSCPName
                CsVipName                   = $CsVipName
                UseLbVip                    = [bool]$UseLbVip
                LbName                      = $LbName
                SvcName                     = $SvcName
                RspName                     = $RspName
                RsaName                     = $RsaName
                CspName                     = $CspName
                CsaName                     = $CsaName
                EnableVipBefore             = [bool]$EnableVipBefore
                DisableVipAfter             = [bool]$DisableVipAfter
                UseNetScalerDNS             = [bool]$UseNetScalerDNS
                UpdateGlobalVPNCertBinding  = [bool]$UpdateGlobalVPNCertBinding
                Partitions                  = $Partitions
                PruneExistingPolicyBindings = $true
                SaveADCConfig               = [bool]$SaveADCConfig
                PassThru                    = $true
            }
            if ($CreateApiUser) {
                $userParams.ApiUsername = $ApiUsername
                $userParams.ApiPassword = $ApiPassword
            }
            return New-NSRequestCertificateUser @userParams
        }
        if ($CleanADC) {
            return Remove-RequestCertificateNetScalerHttpValidationConfig -NSSession $nsSession -Settings $settings -CsVipName $CsVipName -RemoveCertificateFiles
        }
        if ($RemoveTestCertificates) {
            return Remove-RequestCertificateNetScalerTestCertificate -NSSession $nsSession -DeleteFromDevice
        }
        try {
            $ha = Invoke-NSGetHanode -NSSession $nsSession
            $node = @($ha.hanode)[0]
            if ($node -and $node.state -and $node.state -ne 'Primary') { throw "Connected NetScaler node is '$($node.state)', expected Primary." }
        } catch { Write-RequestCertificateLog Warning 'NetScaler' "Could not verify HA primary state: $($_.Exception.Message)" }

        $results = @()
        $allErrors = @()
        $httpValidationConfigInitialized = $false
        $httpValidationCleanupCsVipNames = @()
        try {
        foreach ($request in $requests) {
            $challengeBindings = @()
            $requestVipEnabled = $false
            try {
            Set-RequestCertificateNoteProperty -InputObject $request -Name ValidationMethod -Value $(if ($request.ValidationMethod) { ([string]$request.ValidationMethod).ToLowerInvariant() } else { 'http' })
            if ($request.CN -like '*`**' -or $request.SANs -like '*`**') { $request.ValidationMethod = 'dns' }
            Set-RequestCertificateNoteProperty -InputObject $request -Name UseLbVip -Value ([bool]$request.UseLbVip)
            $effectiveForceCertRenew = [bool]$ForceCertRenew -or [bool]$request.ForceCertRenew
            if ($request.ValidationMethod -eq 'http' -and -not $request.CsVipName -and -not $request.UseLbVip) { throw "CsVipName is required for HTTP validation unless UseLbVip is set. CN=$($request.CN)" }
            $domains = @($request.CN)
            if ($request.SANs) { $domains += ([string]$request.SANs -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }) }
            $domains = @($domains | Select-Object -Unique)
            if (-not $request.FriendlyName) { Set-RequestCertificateNoteProperty -InputObject $request -Name FriendlyName -Value $request.CN }
            if (-not $request.CertDir) { Set-RequestCertificateNoteProperty -InputObject $request -Name CertDir -Value $CertDir }
            if (-not (Test-Path -LiteralPath $request.CertDir)) { New-Item -ItemType Directory -Path $request.CertDir -Force | Out-Null }
            $renewalDecision = Test-RequestCertificateRenewalRequired -Request $request -Force:$effectiveForceCertRenew
            if (-not $renewalDecision.ShouldRenew) {
                Write-RequestCertificateLog Info 'CheckCertRenewal' "$($request.CN) skipped. $($renewalDecision.Reason)"
                $results += [pscustomobject]@{ CN = $request.CN; Domains = $domains; AcmeServer = $serverName; Production = [bool]$Production; ValidationMethod = $request.ValidationMethod; CertKeyName = $request.CertKeyNameToUpdate; PfxPath = $null; Thumbprint = $null; NotAfter = $renewalDecision.CertExpires; Status = 'Skipped'; Reason = $renewalDecision.Reason; LogFile = $script:RequestCertificateLogFile }
                continue
            }
            Write-RequestCertificateLog Info 'CheckCertRenewal' "$($request.CN) renewal required. $($renewalDecision.Reason)"
            if ($request.ValidationMethod -eq 'http' -and $request.EnableVipBefore) {
                foreach ($csVip in @($request.CsVipName)) { try { Invoke-NSEnableCsvserver -NSSession $nsSession -Name $csVip | Out-Null } catch { Write-RequestCertificateLog Warning 'NetScaler' "Could not enable CS VIP $csVip`: $($_.Exception.Message)" } }
                $requestVipEnabled = $true
            }
            $pfxSecret = if ($request.PfxPassword) { ConvertFrom-RequestCertificateLegacySecret -Object $request.PfxPassword } elseif ($PfxPassword) { ConvertFrom-RequestCertificateLegacySecret -Object $PfxPassword } else { ConvertTo-SecureString (New-RequestCertificatePassword) -AsPlainText -Force }
            Write-RequestCertificateLog Info 'ACME' "Ensuring ACME account for $($request.EmailAddress)."
            try { $account = Get-PAAccount -List -Refresh -ErrorAction Stop | Where-Object { $_.Contact -contains "mailto:$($request.EmailAddress)" -or $_.Contact -contains $request.EmailAddress } | Select-Object -First 1 } catch { $account = $null }
            $accountKeyLength = if ([string]$request.KeyLength -match '^\d+$') { [int]$request.KeyLength } else { 2048 }
            if (-not $account) { $account = New-PAAccount -Contact $request.EmailAddress -KeyLength $accountKeyLength -AcceptTOS -Force -ErrorAction Stop }
            Set-PAAccount -ID $account.ID -Force | Out-Null
                $cert = $null
                if ($request.ValidationMethod -eq 'dns') {
                    $acmeOptions = @{
                        DNSPlugin              = $DNSPlugin
                        DNSParams              = $DNSParams
                        DNSWaitTime            = $DNSWaitTime
                        UseModernPfxEncryption = [bool]$UseModernPfxEncryption
                        PreferredChain         = $PreferredChain
                        Profile                = $Profile
                        DnsAlias               = $DnsAlias
                        ValidationTimeout      = $ValidationTimeout
                        LifetimeDays           = $LifetimeDays
                        AlwaysNewKey           = [bool]$AlwaysNewKey
                    }
                    if ($request.AlternateDNSValidationDomain) {
                        $acmeOptions.DnsAlias = @($domains | ForEach-Object { $request.AlternateDNSValidationDomain })
                    }
                    $cert = Invoke-RequestCertificateDnsOrder -Request $request -Domains $domains -PfxSecret $pfxSecret -AcmeOptions $acmeOptions -Force:$effectiveForceCertRenew
                    if (-not $cert) { $cert = Get-PACertificate -MainDomain $request.CN -ErrorAction Stop }
                } else {
                    Write-RequestCertificateLog Info 'ACME' "Creating ACME HTTP order for $($domains -join ', ')."
                    $orderParams = @{ Domain = $domains; AlwaysNewKey = ([bool]$AlwaysNewKey -or $effectiveForceCertRenew); KeyLength = [string]$request.KeyLength; Force = $true; FriendlyName = $request.FriendlyName; PfxPassSecure = $pfxSecret }
                    if ($UseModernPfxEncryption) { $orderParams.UseModernPfxEncryption = $true }
                    if ($PreferredChain) { $orderParams.PreferredChain = $PreferredChain }
                    if ($Profile) { $orderParams.Profile = $Profile }
                    if ($LifetimeDays) { $orderParams.LifetimeDays = $LifetimeDays }
                    if ($ValidationTimeout) { $orderParams.ValidationTimeout = $ValidationTimeout }
                    if ($effectiveForceCertRenew) { try { Remove-PAOrder -MainDomain $request.CN -Force -ErrorAction SilentlyContinue | Out-Null } catch {} }
                    $order = New-PAOrder @orderParams -ErrorAction Stop
                    Initialize-RequestCertificateHttpValidationConfig -NSSession $nsSession -Settings $settings -Request $request
                    if (-not $request.UseLbVip) {
                        $httpValidationConfigInitialized = $true
                        $httpValidationCleanupCsVipNames = @($httpValidationCleanupCsVipNames + @($request.CsVipName) | Where-Object { $_ } | Select-Object -Unique)
                    }
                    $challengeBindings = Publish-RequestCertificateHttpChallenge -NSSession $nsSession -Settings $settings -Order $order -Account $account
                    Wait-RequestCertificateAuthorization -MainDomain $request.CN -TimeoutSeconds $ValidationTimeout | Out-Null
                    Write-RequestCertificateLog Info 'ACME' "Finalizing ACME order for $($request.CN)."
                    $null = Submit-OrderFinalize -Order (Get-PAOrder -MainDomain $request.CN -Refresh) -ErrorAction Stop
                    Wait-RequestCertificateOrderFinal -MainDomain $request.CN -TimeoutSeconds $ValidationTimeout | Out-Null
                    Write-RequestCertificateLog Info 'ACME' "Downloading ACME certificate artifacts for $($request.CN)."
                    $null = Complete-PAOrder -Order (Get-PAOrder -MainDomain $request.CN -Refresh) -ErrorAction Stop
                    $cert = Get-PACertificate -MainDomain $request.CN -ErrorAction Stop
                }
                $deploy = Install-RequestCertificateNetScalerCertificate -NSSession $nsSession -Settings $settings -Request $request -Certificate $cert -PfxSecret $pfxSecret -IsProduction:$Production
                $x509 = if ($cert.CertFile -and (Test-Path $cert.CertFile)) { [System.Security.Cryptography.X509Certificates.X509Certificate2]::new($cert.CertFile) } else { $null }
                try {
                    $completedOrder = Get-PAOrder -MainDomain $request.CN -Refresh -ErrorAction Stop
                    if ($completedOrder.CertExpires) {
                        Set-RequestCertificateNoteProperty -InputObject $request -Name CertExpires -Value $completedOrder.CertExpires
                        $configChanged = $true
                    }
                    if ($completedOrder.RenewAfter) {
                        Set-RequestCertificateNoteProperty -InputObject $request -Name RenewAfter -Value $completedOrder.RenewAfter
                        $configChanged = $true
                    }
                    Set-RequestCertificateNoteProperty -InputObject $request -Name CurrentCertIsProduction -Value ([bool]$Production)
                    $configChanged = $true
                } catch {
                    Write-RequestCertificateLog Debug 'CheckCertRenewal' "Could not update renewal metadata for $($request.CN): $($_.Exception.Message)"
                }
                if ($request.UpdateGlobalVPNCertBinding) {
                    Update-RequestCertificateGlobalVpnBinding -NSSession $nsSession -OldCertKeyName $request.CertKeyNameToUpdate -NewCertKeyName $deploy.CertKeyName -IncludeCA:$request.GlobalVPNCertBindingIncludeCA -CrlCheck $request.GlobalVPNCertBindingCrlCheck -OcspCheck $request.GlobalVPNCertBindingOcspCheck | Out-Null
                }
                if ($request.UpdateIIS) {
                    try { Update-RequestCertificateIisBinding -PfxPath $deploy.PfxPath -PfxSecret $pfxSecret -SiteName $request.IISSiteToUpdate | Out-Null }
                    catch { Write-RequestCertificateLog Warning 'IIS' "UpdateIIS failed: $($_.Exception.Message)" }
                }
                if ($request.PostPoSHScriptFilename) {
                    Invoke-RequestCertificatePostScript -ScriptPath $request.PostPoSHScriptFilename -ScriptRoot $scriptRoot -Thumbprint $(if ($x509) { $x509.Thumbprint } else { $cert.Thumbprint }) -PfxPath $deploy.PfxPath -PfxPassword (ConvertFrom-RequestCertificateLegacySecret -Object $pfxSecret -AsClearText) -ExtraParameters $request.PostPoSHScriptExtraParameters | Out-Null
                }
                if ($request.CleanExpiredCertsOnDisk) {
                    Remove-RequestCertificateExpiredDiskCertificate -CertDir $request.CertDir -Days $request.CleanExpiredCertsOnDiskDays -CN $request.CN | Out-Null
                }
                if ($RemoveUploadedPfx) {
                    try { Invoke-NSDeleteSystemfile -NSSession $nsSession -Filename $deploy.PfxFileName -Filelocation '/nsconfig/ssl/' | Out-Null }
                    catch { Write-RequestCertificateLog Debug 'Deploy' "Uploaded PFX cleanup skipped: $($_.Exception.Message)" }
                }
                if ($request.RemovePrevious -and $Production -and $request.CertKeyNameToUpdate -and $deploy.CertKeyName -ne $request.CertKeyNameToUpdate) {
                    try { Invoke-NSDeleteSslcertkey -NSSession $nsSession -Certkey $request.CertKeyNameToUpdate -Deletefromdevice | Out-Null }
                    catch { Write-RequestCertificateLog Warning 'Deploy' "RemovePrevious failed for '$($request.CertKeyNameToUpdate)': $($_.Exception.Message)" }
                }
                $result = [pscustomobject]@{ CN = $request.CN; Domains = $domains; AcmeServer = $serverName; Production = [bool]$Production; ValidationMethod = $request.ValidationMethod; CertKeyName = $deploy.CertKeyName; PfxPath = $deploy.PfxPath; Thumbprint = if ($x509) { $x509.Thumbprint } else { $cert.Thumbprint }; NotAfter = if ($x509) { $x509.NotAfter } else { $null }; Status = 'Success'; LogFile = $script:RequestCertificateLogFile }
                $results += $result
                Write-RequestCertificateLog Info 'Result' "Finished certificate request for $($request.CN); NetScaler certkey: $($deploy.CertKeyName)."
            } catch {
                Write-RequestCertificateLog Error 'Result' "Failed certificate request for $($request.CN): $($_.Exception.Message)"
                $allErrors += $_
                $results += [pscustomobject]@{ CN = $request.CN; Domains = $domains; AcmeServer = $serverName; Production = [bool]$Production; ValidationMethod = $request.ValidationMethod; CertKeyName = $request.CertKeyNameToUpdate; PfxPath = $null; Thumbprint = $null; NotAfter = $null; Status = 'Failed'; Reason = $_.Exception.Message; LogFile = $script:RequestCertificateLogFile }
                if ($StopOnError) { throw }
            } finally {
                Remove-RequestCertificateHttpChallengeBinding -NSSession $nsSession -ChallengeBindings $challengeBindings -Settings $settings
                if ($requestVipEnabled -and $request.ValidationMethod -eq 'http' -and $request.DisableVipAfter) { foreach ($csVip in @($request.CsVipName)) { try { Invoke-NSDisableCsvserver -NSSession $nsSession -Name $csVip | Out-Null } catch { Write-RequestCertificateLog Warning 'NetScaler' "Could not disable CS VIP $csVip`: $($_.Exception.Message)" } } }
            }
        }
        } finally {
            if ($httpValidationConfigInitialized) {
                Write-RequestCertificateLog Info 'Cleanup' 'Removing reusable NetScaler HTTP validation objects.'
                Remove-RequestCertificateNetScalerHttpValidationConfig -NSSession $nsSession -Settings $settings -CsVipName $httpValidationCleanupCsVipNames | Out-Null
            }
        }
        if ($settings.SendMail) {
            $subjectStatus = if ($allErrors.Count -gt 0) { 'failed' } else { 'completed' }
            $body = ($results | Format-List | Out-String)
            Send-RequestCertificateMail -Settings $settings -Subject "Invoke-RequestCertificate $subjectStatus" -Body $body -LogFile $script:RequestCertificateLogFile
        }
        if ($AutoRun -and $configChanged -and $ConfigFile) {
            try {
                Write-RequestCertificateLog Info 'ConfigFile' "Saving updated renewal metadata to '$ConfigFile'."
                if ($config.settings.PSObject.Properties.Name -contains 'SMTPCredential') {
                    $config.settings.PSObject.Properties.Remove('SMTPCredential')
                }
                $config | ConvertTo-Json -Depth 20 | Out-File -LiteralPath $ConfigFile -Encoding Unicode -Force
            } catch {
                Write-RequestCertificateLog Warning 'ConfigFile' "Could not save updated renewal metadata to '$ConfigFile': $($_.Exception.Message)"
            }
        }
        $results
    }
}

