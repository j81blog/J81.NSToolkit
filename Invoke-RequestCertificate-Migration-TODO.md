# Invoke-RequestCertificate Migration TODO

Date: 2026-05-27

## Goal

Migrate `C:\Users\JohnBillekens\GitHub\GenLeCertForNS\GenLeCertForNS.ps1` into `J81.NSToolkit` as `Invoke-RequestCertificate` while preserving backward-compatible parameters, config-file compatibility, and support-focused logging.

The migrated function must keep the original HTTP validation behavior through Citrix NetScaler/ADC, support DNS validation through Posh-ACME plugins, and eventually support other ACME certificate providers beyond Let's Encrypt.

## Current Summary

The main HTTP staging path is working.

Validated:

- AutoRun config loading.
- ACME staging server only: `LE_STAGE`.
- HTTP-01 validation through NetScaler responder objects.
- Certificate upload/update to NetScaler.
- Renewal skip based on legacy `RenewAfter`.
- Forced renewal with `-ForceCertRenew`.
- Per-request responder object cleanup.
- End-of-batch reusable HTTP validation object cleanup.
- Config update of `CertExpires`, `RenewAfter`, and `CurrentCertIsProduction`.
- Config encryption of legacy password objects with `IsEncrypted = false`.
- Mail sending with Gmail on port `587` and SSL enabled.
- Root module export surface after the updated toolkit layout.

Not validated yet:

- Production ACME.
- DNS provider live API validation.
- `UseLbVip` beyond smoke coverage.
- Full partition iteration.
- IIS update on a real target.
- Global VPN binding update on a real target after the latest changes.

## Active Module Layout

Primary files:

- `C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.psd1`
- `C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.psm1`
- `C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.Common\Public\Invoke-RequestCertificate.ps1`
- `C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.Common\Public\New-NSRequestCertificateUser.ps1`
- `C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.Common\Public\Invoke-NSNitroApi.ps1`
- `C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.Common\Private\*.ps1`

Important private helpers:

- `Assert-RequestCertificateNSResource.ps1`
- `ConvertFrom-RequestCertificateLegacySecret.ps1`
- `ConvertTo-RequestCertificateLegacySecret.ps1`
- `ConvertTo-RequestCertificateHashtable.ps1`
- `Copy-RequestCertificateNetScalerFile.ps1`
- `Initialize-RequestCertificateHttpValidationConfig.ps1`
- `Install-RequestCertificateNetScalerCertificate.ps1`
- `Invoke-RequestCertificateDnsOrder.ps1`
- `Invoke-RequestCertificateNitro.ps1`
- `Invoke-RequestCertificatePostScript.ps1`
- `New-RequestCertificatePassword.ps1`
- `Publish-RequestCertificateHttpChallenge.ps1`
- `Remove-RequestCertificateExpiredDiskCertificate.ps1`
- `Remove-RequestCertificateHttpChallengeBinding.ps1`
- `Remove-RequestCertificateNetScalerHttpValidationConfig.ps1`
- `Remove-RequestCertificateNetScalerTestCertificate.ps1`
- `Send-RequestCertificateMail.ps1`
- `Set-RequestCertificateNoteProperty.ps1`
- `Test-RequestCertificateRenewalRequired.ps1`
- `Update-RequestCertificateGlobalVpnBinding.ps1`
- `Update-RequestCertificateIisBinding.ps1`
- `Wait-RequestCertificateAuthorization.ps1`
- `Wait-RequestCertificateOrderFinal.ps1`
- `Write-RequestCertificateLog.ps1`

## Current Git State

Known modified files in `C:\Users\JohnBillekens\GitHub\J81.NSToolkit`:

- `Invoke-RequestCertificate-Migration-TODO.md`
- `J81.NSToolkit/J81.NSToolkit.psm1`
- `J81.NSToolkit/J81.NSToolkit.Common/Public/Invoke-RequestCertificate.ps1`
- `J81.NSToolkit/J81.NSToolkit.Common/Private/Initialize-RequestCertificateHttpValidationConfig.ps1`
- `J81.NSToolkit/J81.NSToolkit.Common/Private/Invoke-RequestCertificateDnsOrder.ps1`
- `J81.NSToolkit/J81.NSToolkit.Common/Private/Remove-RequestCertificateNetScalerHttpValidationConfig.ps1`
- `README.md`

Known untracked files:

- `J81.NSToolkit/J81.NSToolkit.Common/Private/ConvertTo-RequestCertificateLegacySecret.ps1`
- `J81.NSToolkit/J81.NSToolkit.Common/Private/Test-RequestCertificateRenewalRequired.ps1`

Do not revert unrelated user changes. `README.md` was already modified in the working tree and should be reviewed before editing further.

## Test Environment

NetScaler/ADC:

- Management URL: `https://10.254.0.10`
- Credentials: `C:\Users\JohnBillekens\GitHub\GenLeCertForNS\temp\Credential.xml`
- Test config: `C:\Users\JohnBillekens\GitHub\GenLeCertForNS\temp\config_domains_test.json`
- Test domain: `365.j81.nl`
- Test CS VIP: `cs_j81.nl_http`
- Certkey updated in staging tests: `TST-T-portal.j81.nl`

Never use `-Production` unless explicitly approved.

Use direct manifest import for the current nested module layout:

```powershell
$Manifest = 'C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.psd1'
Remove-Module J81.NSToolkit,J81.NSToolkit.Common,J81.NSToolkit.Config,J81.NSToolkit.Stats,Posh-ACME -Force -ErrorAction SilentlyContinue
Import-Module $Manifest -Force
Get-Command Invoke-RequestCertificate,Invoke-NSNitroApi,Connect-NSNode
```

## Latest Validated Commands

No-force staging run, expected to skip renewal and send mail:

```powershell
$Manifest = 'C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.psd1'
Remove-Module J81.NSToolkit,J81.NSToolkit.Common,J81.NSToolkit.Config,J81.NSToolkit.Stats,Posh-ACME -Force -ErrorAction SilentlyContinue
Import-Module $Manifest -Force
Invoke-RequestCertificate -AutoRun -ConfigFile 'C:\Users\JohnBillekens\GitHub\GenLeCertForNS\temp\config_domains_test.json' -NoConsoleOutput
```

Latest no-force result:

- `CN`: `365.j81.nl`
- `Status`: `Skipped`
- `Reason`: `Certificate can be replaced after 2026-07-25 21:09:36.`
- `Mail`: `Completion mail sent to john@j81.nl.`
- `LogFile`: `C:\Users\JohnBillekens\stack\Let's Encrypt\GenLE-Log.txt`

Forced staging renewal command:

```powershell
$Manifest = 'C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.psd1'
Remove-Module J81.NSToolkit,J81.NSToolkit.Common,J81.NSToolkit.Config,J81.NSToolkit.Stats,Posh-ACME -Force -ErrorAction SilentlyContinue
Import-Module $Manifest -Force
Invoke-RequestCertificate -AutoRun -ConfigFile 'C:\Users\JohnBillekens\GitHub\GenLeCertForNS\temp\config_domains_test.json' -ForceCertRenew -NoConsoleOutput
```

Latest forced staging certificate result:

- `CN`: `365.j81.nl`
- `AcmeServer`: `LE_STAGE`
- `Production`: `False`
- `ValidationMethod`: `http`
- `CertKeyName`: `TST-T-portal.j81.nl`
- `PfxPath`: `C:\Users\JohnBillekens\AppData\Local\Posh-ACME\LE_STAGE\296367263\365.j81.nl\fullchain.pfx`
- `Thumbprint`: `12BEABD74403331E4E627B526B0C3C31F00EA5B9`
- `NotAfter`: `2026-08-25 20:25:31`

## Latest NetScaler Cleanup Validation

After the forced staging run, these objects were verified absent:

- `rsp_letsencrypt_101`
- `rsa_letsencrypt_101`
- `csp_letsencrypt`
- `csa_letsencrypt`
- `svc_letsencrypt_cert_dummy`
- `lb_letsencrypt_cert`

Current cleanup model:

- Responder challenge action/policy/binding objects are removed per request in the per-request `finally` block.
- Reusable HTTP validation objects are cleaned once after the batch in an outer `finally`.
- Explicit `-CleanADC` also removes known uploaded validation PFX files when called manually.
- Normal end-of-batch cleanup does not delete uploaded certificate files by default.

## Latest Mail And Credential Status

Mail is working with:

- SMTP server: `smtp.gmail.com`
- SMTP port: `587`
- `SMTPUseSSL`: `True`
- Credential source: `SMTPCredentialUsername` plus `SMTPCredentialPassword`

Credential behavior:

- Runtime JSON `SMTPCredential` objects are ignored and removed before config save.
- `SMTPCredentialPassword` nodes with `IsEncrypted = false` are rewritten encrypted.
- `ADCCredentialPassword` and per-request `PfxPassword` nodes with `IsEncrypted = false` are also rewritten encrypted.
- Config save uses the legacy JSON object shape:

```json
{
  "Password": "<encrypted string>",
  "IsEncrypted": true
}
```

## Implemented Behavior

### HTTP Validation

Implemented and live-tested:

- NetScaler HTTP-01 challenge responder flow.
- CS policy/action to route `/.well-known/acme-challenge/` traffic to the validation LB vServer.
- Non-addressable LB vServer behavior using `0.0.0.0:0`.
- Per-challenge responder action/policy creation and cleanup.
- Reusable validation service/LB/CS cleanup after all requests.
- Optional VIP enable/disable around validation.
- Idempotent handling of existing validation objects.

### Multiple Certificate Requests

Implemented:

- AutoRun loads all enabled `certrequests`.
- Main loop processes all enabled requests.
- Per-request failures are recorded and the loop continues by default.
- `-StopOnError` restores fail-fast behavior for callers that require it.

### Renewal Logic

Implemented:

- `Test-RequestCertificateRenewalRequired` evaluates legacy `CertExpires` and `RenewAfter`.
- Requests are skipped when `RenewAfter` is in the future.
- Requests are renewed when forced, when `RenewAfter` is missing/invalid, or when `RenewAfter` has passed.
- Global `-ForceCertRenew` affects the current run but is not persisted into each config request.
- Successful orders update `CertExpires`, `RenewAfter`, and `CurrentCertIsProduction` in the AutoRun config.

### DNS Validation

Implemented but not live provider-tested:

- DNS path uses Posh-ACME `New-PACertificate`.
- `DNSPlugin`, `DNSParams`, and `DNSWaitTime` are mapped to Posh-ACME.
- `DNSParams` supports hashtable, PSCustomObject, or `key=value;key=value` string values.
- `AlternateDNSValidationDomain` maps to `DnsAlias`.

Still missing:

- `UseNetScalerDNS` as a DNS challenge provider path.
- DNS provider-specific live validation after the user confirms a working provider/API.

### ACME Provider Support

Implemented:

- Default non-production: `LE_STAGE`.
- Default production mappings:
  - `LetsEncrypt` -> `LE_PROD`
  - `ZeroSSL` -> `ZEROSSL_PROD`
  - `Google` -> `GOOGLE_PROD`
  - `SSLCom` -> `SSLCOM_RSA`
  - `Actalis` -> `ACTALIS_PROD`
- Non-production Google maps to `GOOGLE_STAGE`.
- `AcmeDirectoryUrl` overrides the mapping.
- Advanced Posh-ACME options exposed:
  - `UseModernPfxEncryption`
  - `PreferredChain`
  - `Profile`
  - `DnsAlias`
  - `ValidationTimeout`
  - `LifetimeDays`
  - `AlwaysNewKey`

Still deferred:

- External CSR/key-file support.
- Production validation.

### Certificate Deployment

Implemented:

- Upload/replace PFX under `/nsconfig/ssl/`.
- Add/update NetScaler SSL certkey.
- Staging certkeys are prefixed with `TST-`.
- Generated `Invoke-NSChangeSslcertkey` is used for cert/key replacement behavior.
- Optional uploaded PFX cleanup through `-RemoveUploadedPfx`.
- Basic `-RemovePrevious` behavior for production when old and new certkey names differ.

Still needs review:

- Chain/link behavior for ADC versions or environments that require CA certkey linking.
- Whether `TST-` should apply to every non-production provider or only Let's Encrypt staging.
- Production `-RemovePrevious` behavior needs live-safe validation.

### User/Permission Bootstrap

Implemented in separate public function:

- `New-NSRequestCertificateUser`
- Legacy bridge from `Invoke-RequestCertificate -CreateUserPermissions`
- Legacy bridge from `Invoke-RequestCertificate -CreateApiUser`

Supported:

- Creates/updates the three legacy command policies.
- Optionally creates/updates the system user.
- Binds policies with priorities `10`, `20`, `30`.
- Supports `-WhatIf`, `-PassThru`, `-SaveADCConfig`, `-Partitions`, DNS/VPN permission options, and optional binding pruning.
- Uses generated wrappers where possible and generic Nitro only where legacy hyphenated command-policy names require it.

Validated:

- `-WhatIf` against `https://10.254.0.10` succeeded without creating objects.

### Other Legacy Functional Areas

Implemented:

- `-CleanADC`
- `-RemoveTestCertificates`
- `-UpdateIIS` with explicit local Windows/WebAdministration behavior
- `-SendMail`
- `-PostPoSHScriptFilename`
- `-UpdateGlobalVPNCertBinding`
- `-GlobalVPNCertBindingIncludeCA`
- `-GlobalVPNCertBindingCrlCheck`
- `-GlobalVPNCertBindingOcspCheck`
- `-CleanExpiredCertsOnDisk`
- `-CleanAllExpiredCertsOnDisk` basic local cleanup

Needs validation:

- `-UpdateIIS` on a real local IIS target.
- `-UpdateGlobalVPNCertBinding` after the latest changes.
- `-CleanAllExpiredCertsOnDisk` parity with the original script.

## NetScaler API Usage

Generated `J81.NSToolkit.Config` functions are used for most HTTP path actions:

- `Invoke-NSEnableNsfeature`
- `Invoke-NSGetHanode`
- `Invoke-NSGetCsvserver`
- `Invoke-NSGetService`
- `Invoke-NSAddService`
- `Invoke-NSGetLbvserver`
- `Invoke-NSAddLbvserver`
- `Invoke-NSGetLbvserverServiceBinding`
- `Invoke-NSAddLbvserverServiceBinding`
- `Invoke-NSAddCsaction`
- `Invoke-NSUpdateCsaction`
- `Invoke-NSAddCspolicy`
- `Invoke-NSUpdateCspolicy`
- `Invoke-NSAddCsvserverCspolicyBinding`
- `Invoke-NSEnableCsvserver`
- `Invoke-NSDisableCsvserver`
- `Invoke-NSAddResponderaction`
- `Invoke-NSAddResponderpolicy`
- `Invoke-NSAddLbvserverResponderpolicyBinding`
- `Invoke-NSDeleteLbvserverResponderpolicyBinding`
- `Invoke-NSDeleteResponderpolicy`
- `Invoke-NSDeleteResponderaction`
- `Invoke-NSAddSystemfile`
- `Invoke-NSDeleteSystemfile`
- `Invoke-NSGetSslcertkey`
- `Invoke-NSAddSslcertkey`
- `Invoke-NSChangeSslcertkey`
- `Invoke-NSSaveNsconfig`

Remaining generic Nitro usage:

- `Assert-RequestCertificateNSResource.ps1` keeps fallback generic get/create behavior.
- `Invoke-RequestCertificateNitro.ps1` remains as a private fallback and error-normalization helper.
- Command-policy operations in `New-NSRequestCertificateUser` may use generic Nitro for legacy hyphenated policy names.

Future task:

- Replace generic calls with generated functions only where generated coverage exposes the same Nitro behavior and does not reduce compatibility.

## Invoke-NSNitroApi Status

Expected improvements from earlier work:

- `POST` and `PUT` allowed.
- `UseBasicParsing` under Windows PowerShell/Desktop edition.
- `-Headers`.
- `X-NITRO-WARNING` and `X-NITRO-ONERROR`.
- Safer query-string construction.
- Terminating NITRO error records.
- Warning emission for NITRO warnings.
- Response metadata note properties.
- `-RawResponse`.

Important current caveat:

- After a toolkit update, verify these changes still exist. An earlier post-update check showed `-RawResponse` and `UseBasicParsing` were missing from the refreshed `Invoke-NSNitroApi` even though the older TODO claimed they were implemented.

Verification command:

```powershell
rg -n "RawResponse|UseBasicParsing|X-NITRO-WARNING|X-NITRO-ONERROR|RemainingArguments|Invoke-WebRequest|Invoke-RestMethod" 'C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.Common\Public\Invoke-NSNitroApi.ps1'
```

## Logging And Supportability

Implemented:

- Log header.
- PowerShell, OS, module, Posh-ACME, and elevation diagnostics.
- Log rotation.
- Sensitive value masking.
- Concise console output.
- `-NoConsoleOutput`.
- Mail failure/success logging.

Still open:

- Rich exception detail formatting beyond current message-level logging.
- Deeper `-Verbose` integration.
- Optional support bundle export.

Known minor issue:

- The log header recently reported `J81.NSToolkit version : 2311.2021` while `Get-Command Invoke-RequestCertificate` reported module version `2402.222.2`. This likely comes from nested module version detection and should be corrected so support logs show the root module version clearly.

## RunAsAdmin Status

The module function does not require `#Requires -RunAsAdministrator`.

Current behavior:

- Normal certificate request, NetScaler upload, and mail do not require elevation.
- `-UpdateIIS` may require local admin permissions because it writes to the local machine certificate store and IIS bindings.

Open:

- Add targeted elevation checks for `-UpdateIIS` only.
- Avoid any future broad RunAsAdmin requirement.

## Open Work

High priority:

- DNS provider live validation.
- Verify `Invoke-NSNitroApi` still contains the intended improvements after the toolkit update.
- Add Pester tests for renewal skip, config encryption, and mail credential normalization.
- Add Pester tests for HTTP cleanup planning/idempotency where possible without live NetScaler.
- Review current `README.md` changes and decide whether to keep/update them.

Medium priority:

- Full `-Partitions` iteration.
- `UseNetScalerDNS` DNS challenge provider path.
- Broader `UseLbVip` validation.
- Production-safe validation plan for `-RemovePrevious`.
- Real-target validation for `-UpdateIIS` and `-UpdateGlobalVPNCertBinding`.
- `CleanAllExpiredCertsOnDisk` parity review.

Deferred:

- `GenLeCertForNS` alias.
- External CSR/key-file support.
- Code signing.
- Production ACME run.
- MailKit or another SMTP implementation for implicit TLS on port `465`; current working Gmail path is port `587` with SSL/STARTTLS.

## Suggested Next Implementation Order

1. Verify `Invoke-NSNitroApi` current implementation and re-apply non-breaking improvements if missing.
2. Add Pester tests around the new private helpers:
   - `Test-RequestCertificateRenewalRequired`
   - `ConvertFrom-RequestCertificateLegacySecret`
   - `ConvertTo-RequestCertificateLegacySecret`
   - `ConvertTo-RequestCertificateHashtable`
3. Add tests for AutoRun config update/encryption behavior.
4. Clean up stale README/TODO references and align module import examples with the nested manifest path.
5. Validate DNS provider path once the provider/API is confirmed.
6. Validate `UseLbVip`.
7. Validate `UpdateGlobalVPNCertBinding`.
8. Implement partition iteration.
9. Add alias `GenLeCertForNS` when public behavior is stable.
10. Re-sign module files.

## Open Questions

- Which DNS provider/API should be used first for live DNS validation?
- Should staging certkeys always use the `TST-` prefix for every ACME provider?
- Should the module support implicit TLS SMTP on port `465` through MailKit, or is port `587` sufficient?
- Should root module examples always import from the explicit `J81.NSToolkit.psd1` path during development?
- Should `UseNetScalerDNS` be implemented as a Posh-ACME DNS plugin adapter or as a custom internal challenge publisher?
