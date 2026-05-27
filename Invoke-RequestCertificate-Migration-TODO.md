# Invoke-RequestCertificate Migration TODO

Date: 2026-05-25

## Goal

Migrate `GenLeCertForNS.ps1` into `J81.NSToolkit` as `Invoke-RequestCertificate` while preserving backward-compatible parameters and support-focused log output. The module version should eventually support multiple ACME providers through Posh-ACME and should use toolkit NetScaler functions instead of embedded REST helpers where practical.

## Current State

Implemented files:

- `C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\Public\Invoke-RequestCertificate.ps1`
- `C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.psd1`
- `C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\Public\Invoke-NSNitroApi.ps1`
- Working source copy: `C:\Users\JohnBillekens\GitHub\GenLeCertForNS\temp\Invoke-RequestCertificate.ps1`

Validated path:

- ACME server: `LE_STAGE`
- Validation method: `http`
- NetScaler target: `https://10.254.0.10`
- Config file: `C:\Users\JohnBillekens\GitHub\GenLeCertForNS\temp\config_domains_test.json`
- Wrapper-compatible command:

```powershell
$env:PSModulePath = 'C:\Users\JohnBillekens\GitHub\J81.NSToolkit;' + $env:PSModulePath
Remove-Module J81.NSToolkit,J81.NSToolkit.Config,Posh-ACME -Force -ErrorAction SilentlyContinue
Import-Module J81.NSToolkit -Force
Invoke-RequestCertificate -AutoRun -ConfigFile 'C:\Users\JohnBillekens\GitHub\GenLeCertForNS\temp\config_domains_test.json' -ForceCertRenew -NoConsoleOutput
```

Last successful staging result:

- `CN`: `365.j81.nl`
- `CertKeyName`: `TST-T-portal.j81.nl`
- `PfxPath`: `C:\Users\JohnBillekens\AppData\Local\Posh-ACME\LE_STAGE\295810323\365.j81.nl\fullchain.pfx`
- `Thumbprint`: `56AFDE5E8A504F61A509AE0558685AD86CA313E1`
- `NotAfter`: `2026-08-23 20:58:05`
- `LogFile`: `C:\Users\JohnBillekens\stack\Let's Encrypt\GenLE-Log.txt`

Known supporting changes:

- `Invoke-NSNitroApi` ValidateSet was expanded to allow `POST` and `PUT`, because generated `J81.NSToolkit.Config` functions already use these methods.
- `Invoke-NSNitroApi` adds `UseBasicParsing` for Windows PowerShell/Desktop edition to avoid the `Invoke-WebRequest` script execution risk prompt.
- `Invoke-NSNitroApi` now supports `-Headers`, NITRO warning/onerror headers, safer query-string construction, terminating NITRO error records, warning emission for NITRO warnings, response metadata note properties, and `-RawResponse`.
- `Invoke-RequestCertificate` is exported from `J81.NSToolkit.psd1`.
- Private helper functions were moved to the module `Private` folder.
- Update 2026-05-25 21:10: inline helpers were moved into `J81.NSToolkit\Private`, and the same staging HTTP test passed.
- Update 2026-05-25 21:29: low-risk NetScaler calls were switched to generated `J81.NSToolkit.Config` functions and the same staging HTTP test passed. Remaining generic Nitro usage is limited to fallback unknown-resource handling and `sslcertkey?action=update` for cert/key replacement.
- Update 2026-05-25 21:49: certkey replacement was switched from generic `Invoke-RequestCertificateNitro` to generated `Invoke-NSChangeSslcertkey`. The same staging HTTP test passed. Private helper functions now have comment-based help blocks.
- Update 2026-05-25 21:59: `Invoke-NSNitroApi` now adds `UseBasicParsing` under Windows PowerShell/Desktop edition. The staging HTTP command completed under `powershell.exe` without the `Invoke-WebRequest` script execution warning.
- Update 2026-05-25 22:12: `Invoke-NSNitroApi -RawResponse` was validated with `GET hanode` against `https://10.254.0.10` and returned HTTP 200 with headers and raw content. The staging HTTP certificate request passed again with thumbprint `CC12AD1B4237AC9EB3B1294D99A165F68F5804A7`.
- Update 2026-05-25 22:58: implemented DNS validation via Posh-ACME `New-PACertificate`, `CleanADC`, `RemoveTestCertificates`, request log header/rotation/masking, per-request disk cleanup, mail hook, post-script hook, guarded IIS update, global VPN binding update, ACME advanced options (`UseModernPfxEncryption`, `PreferredChain`, `Profile`, `DnsAlias`, `ValidationTimeout`, `LifetimeDays`, `AlwaysNewKey`), uploaded PFX cleanup, and basic `RemovePrevious`. Existing HTTP staging flow passed after `CleanADC` removed the temporary objects and the flow recreated them. Latest staging thumbprint: `B49EF898244390C2BF8E7B5B98865B3A5D4B7FC5`.
- Update 2026-05-25 23:22: tested `Invoke-NSAddLbvserver` for non-addressable validation vServers. `Ipv46='0.0.0.0'` with no `Port`, and no `Ipv46`/no `Port`, both created `0.0.0.0:0`; `Port=$null` failed parameter validation. `Assert-RequestCertificateNSResource` now uses generated `Invoke-NSAddLbvserver` with `Ipv46='0.0.0.0'` and omits `Port` for this case. `CleanADC` plus staging HTTP recreation passed. Latest staging thumbprint: `2AA699B2810D69A579AFB0CFB65CAC5AB6991734`.
- Update 2026-05-26: added public `New-NSRequestCertificateUser` for the former `CreateUserPermissions` / `CreateApiUser` bootstrap flow. `Invoke-RequestCertificate` now bridges the legacy switches to the new function. The function creates/updates the three legacy command policies, optionally creates/updates the system user, binds policies with priorities 10/20/30, supports `-WhatIf`, `-PassThru`, `-SaveADCConfig`, `-Partitions`, DNS/VPN permission options, and optional binding pruning. Generated `systemcmdpolicy` functions reject legacy hyphenated policy names, so the function uses generated wrappers when names pass validation and generic NITRO only for command-policy operations that need legacy hyphenated names. `-WhatIf` validation against `https://10.254.0.10` succeeded without creating objects.

## Important Constraints

- Do not use `-Production` until explicitly approved.
- Preserve compatibility with legacy config files and wrappers.
- Preserve diagnostic log usefulness for user support.
- Code signatures are expected to be invalid after edits; re-signing is deferred.
- Alias `GenLeCertForNS` is deferred.
- DNS validation migration is deferred until HTTP validation is stable.
- The `J81.NSToolkit` worktree had unrelated existing changes during this work. Do not revert unrelated files.

## Migration Tasks

### 1. Move Inline Helpers To `Private` - Completed 2026-05-25

Created private functions under:

`C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\Private`

The module loader already dot-sources `Private\*.ps1`, so no loader change should be needed.

Implemented private function split:

- `Write-RequestCertificateLog.ps1`
  - From current `Write-RCLog`.
  - Preserve timestamp, component, severity, `-NoConsoleOutput`, and log level behavior.
  - Consider adding sensitive-word masking from legacy `Write-ToLogFile`.
- `ConvertFrom-RequestCertificateLegacySecret.ps1`
  - From current `ConvertFrom-RCLegacySecret`.
  - Must continue supporting legacy JSON password objects with `Password` and `IsEncrypted`.
  - Must continue supporting legacy AES key `(0..15)` data.
  - Add support for CLIXML credentials as a preferred non-RunAsAdmin path.
- `New-RequestCertificatePassword.ps1`
  - From current `New-RCPassword`.
  - Use `RandomNumberGenerator`.
- `Set-RequestCertificateNoteProperty.ps1`
  - From current `Set-RCNoteProperty`.
  - Needed for compatibility with config files missing newer fields.
- `Invoke-RequestCertificateNitro.ps1`
  - From current `Invoke-RCNitro`.
  - Long-term goal: reduce direct generic Nitro calls by using generated `J81.NSToolkit.Config` functions.
  - Keep robust error-context messages such as `GET sslcertkey/name failed: [1540] Certificate does not exist`.
- `Assert-RequestCertificateNSResource.ps1`
  - From current `Assert-RCExistsOrCreate`.
  - Should treat known Nitro not-found codes as missing.
- `Initialize-RequestCertificateHttpValidationConfig.ps1`
  - From current `Initialize-RCHttpValidationConfig`.
  - Should use generated functions where possible:
    - `Invoke-NSEnableNsfeature`
    - `Invoke-NSAddService`
    - `Invoke-NSAddLbvserver`
    - `Invoke-NSAddLbvserverServiceBinding`
    - `Invoke-NSAddCsaction`
    - `Invoke-NSUpdateCsaction`
    - `Invoke-NSAddCspolicy`
    - `Invoke-NSUpdateCspolicy`
    - `Invoke-NSAddCsvserverCspolicyBinding`
- `Publish-RequestCertificateHttpChallenge.ps1`
  - From current `Publish-RCHttpChallenges`.
  - Should use generated responder functions where possible:
    - `Invoke-NSAddResponderaction`
    - `Invoke-NSAddResponderpolicy`
    - `Invoke-NSAddLbvserverResponderpolicyBinding`
- `Remove-RequestCertificateHttpChallenge.ps1`
  - From current `Remove-RCHttpChallengeBindings`.
  - Should use generated delete/unbind functions.
- `Wait-RequestCertificateAuthorization.ps1`
  - From current `Wait-RCOrderValid`.
- `Wait-RequestCertificateOrderFinal.ps1`
  - From current `Wait-RCOrderFinal`.
- `Copy-RequestCertificateFileToNS.ps1`
  - From current `Copy-RCFileToNS`.
  - Keep idempotent replacement of existing `/nsconfig/ssl/` files.
  - Prefer generated `Invoke-NSAddSystemfile` and `Invoke-NSDeleteSystemfile`.
- `Install-RequestCertificateOnNS.ps1`
  - From current `Install-RCCertificateOnNS`.
  - Prefer generated functions:
    - `Invoke-NSAddSslcertkey`
    - `Invoke-NSUpdateSslcertkey`
    - `Invoke-NSGetSslcertkey`
    - `Invoke-NSSaveNsconfig` or equivalent generated save function.

Remaining follow-up after extraction:

- Add Pester tests for each private helper that does not require a live NetScaler.
- Continue replacing generic Nitro calls with generated `J81.NSToolkit.Config` functions.

### 2. Remove Or Reduce RunAsAdmin Requirement

Legacy script has `#Requires -RunAsAdministrator`; the module function currently does not. Keep it that way.

Tasks:

- Audit any remaining behavior that assumes admin rights.
- Avoid local machine certificate store writes unless the user explicitly asks for `-UpdateIIS` or other local deployment.
- Store cert files in Posh-ACME profile storage or user-writable `CertDir`.
- Prefer `PSCredential`, CLIXML credentials, SecretManagement, or config file credentials over DPAPI patterns that require the same elevated token.
- If local deployment requires elevation, detect it only for that specific operation and throw an actionable error instead of requiring the whole certificate request to run as admin.
- Add a log header field for `RunAsAdmin` as diagnostic info only, not as a requirement.

### 3. Complete Posh-ACME Support - Mostly Completed 2026-05-25

Current implementation is not full Posh-ACME support. It supports a manual HTTP-01 order/finalize/download flow for the validated NetScaler path.

Add public parameters or config fields for these Posh-ACME capabilities:

- ACME server selection:
  - Existing: `-Production`, `-AcmeDirectoryUrl`, `-CertificateProvider`.
  - Add short-name validation or mapping for `LE_STAGE`, `LE_PROD`, `ZEROSSL_PROD`, `GOOGLE_PROD`, `GOOGLE_STAGE`, `SSLCOM_RSA`, `SSLCOM_ECC`, `ACTALIS_PROD`, and custom directory URLs.
- Certificate key type:
  - Support RSA and ECDSA key lengths, for example `2048`, `3072`, `4096`, `ec-256`, `ec-384`.
  - Current `KeyLength` validation only permits RSA integer sizes.
- PFX behavior:
  - Expose `UseModernPfxEncryption`.
  - Ensure `PfxPassSecure` is applied before artifact download.
- Preferred chain:
  - Expose `PreferredChain`.
- ACME profiles:
  - Expose `Profile` if the selected CA supports profiles.
- ARI / renewal:
  - Investigate `Submit-Renewal`, renewal windows, and ARI-related properties.
  - Avoid unconditional `Force`/new-key behavior unless requested.
- Account behavior:
  - Preserve multiple account support by email/contact.
  - Add explicit account selection if needed.
  - Add `AcceptTOS` behavior/confirmation for production.
- Plugin behavior:
  - Support DNS plugins via `Plugin`/`PluginArgs` or legacy `DNSPlugin`/`DNSParams`.
  - Support per-domain plugin arrays.
  - Support `DnsAlias`.
  - Support DNS account challenge features if needed later.
- External CSR/key:
  - Add optional CSR/key-file paths once NetScaler private key generation/import behavior is decided.

Implemented:

- `CertificateProvider` maps non-production to `LE_STAGE` or `GOOGLE_STAGE`, and production to `LE_PROD`, `ZEROSSL_PROD`, `GOOGLE_PROD`, `SSLCOM_RSA`, or `ACTALIS_PROD`; `AcmeDirectoryUrl` still overrides the mapping.
- `KeyLength` accepts RSA integer values and `ec-256`, `ec-384`, `ec-521`.
- `UseModernPfxEncryption`, `PreferredChain`, `Profile`, `DnsAlias`, `ValidationTimeout`, `LifetimeDays`, and `AlwaysNewKey` are exposed and passed to Posh-ACME where applicable.
- HTTP validation still uses the manual NetScaler responder flow.
- DNS validation uses Posh-ACME `New-PACertificate`, which handles challenge publish/ack/finalize/download through the selected DNS plugin.

Remaining:

- External CSR/key-file support is still deferred.
- DNS provider-specific live validation is still pending user confirmation of a working provider/API.

### 4. Re-implement DNS Validation - Implemented, Provider Live Test Pending

Current DNS path uses Posh-ACME `New-PACertificate`.

Tasks:

- Re-read legacy DNS flow in `GenLeCertForNS.ps1`.
- Map legacy `DNSPlugin`, `DNSParams`, `DNSWaitTime`, `AlternateDNSValidationDomain`, `AlternateDNSValidationDomainSkipCheck`, and `UseNetScalerDNS` to Posh-ACME.
- Test one real DNS provider after the user confirms the API still works.
- Keep HTTP validation independent of DNS provider configuration.
- Add tests for config normalization and plugin argument conversion without calling external DNS APIs.

Notes:

- `DNSParams` supports hashtable, PSCustomObject, or `key=value;key=value` string values.
- `AlternateDNSValidationDomain` is mapped to `DnsAlias` for each requested domain.
- `UseNetScalerDNS` is not separately implemented yet; Posh-ACME DNS plugins are the active DNS path.

### 5. Implement Remaining Legacy Functional Areas - Partly Completed 2026-05-25

Currently explicit not-implemented or incomplete areas:

- `-CreateUserPermissions`
- `-CreateApiUser`
- `-CleanADC` - implemented for HTTP validation objects.
- `-RemoveTestCertificates` - implemented for `TST-*` and obvious staging issuer certkeys.
- `-UpdateIIS` - implemented with explicit Windows/WebAdministration/import behavior; requires permissions only when used.
- `-SendMail` - implemented with legacy SMTP parameters. `Send-MailMessage` warnings are suppressed; failures are logged.
- `-PostPoSHScriptFilename` - implemented with legacy `Thumbprint`, `PFXfilename`, and `PFXPassword` arguments.
- `-UpdateGlobalVPNCertBinding` - implemented for global VPN SSL certkey binding replacement/add.
- `-GlobalVPNCertBindingIncludeCA` - implemented.
- `-GlobalVPNCertBindingCrlCheck` - implemented.
- `-GlobalVPNCertBindingOcspCheck` - implemented.
- `-RemovePrevious` - basic implementation for production when new certkey differs from the old certkey.
- `-CleanExpiredCertsOnDisk` - implemented per request.
- `-CleanAllExpiredCertsOnDisk` should be reviewed; basic local cleanup exists but needs parity verification.
- Partition support via `-Partitions`.
- HA-awareness via `Invoke-ADCGetHanode` or toolkit equivalent.
- Support for `UseLbVip` path beyond the current smoke coverage.

Implemented in separate public function:

- `New-NSRequestCertificateUser`
- `Invoke-RequestCertificate -CreateUserPermissions`
- `Invoke-RequestCertificate -CreateApiUser`

Still not implemented:

- Full partition iteration via `-Partitions`
- `UseNetScalerDNS` as a DNS challenge provider path

CleanADC / NetScaler cleanup scope:

- Remove temporary responder policy bindings from `lb_letsencrypt_cert`.
- Remove temporary responder policies named from `rsp_letsencrypt*`.
- Remove temporary responder actions named from `rsa_letsencrypt*`.
- Remove content switching policy bindings from all configured `CsVipName` values.
- Remove `csp_letsencrypt` content switching policy when it is not used elsewhere.
- Remove `csa_letsencrypt` content switching action when it is not used elsewhere.
- Remove `svc_letsencrypt_cert_dummy` binding from `lb_letsencrypt_cert`.
- Remove `lb_letsencrypt_cert` when it was created by this function and has no remaining required bindings.
- Remove `svc_letsencrypt_cert_dummy` when it was created by this function.
- Optionally remove uploaded staging PFX files such as `TST-fullchain.pfx` after successful import or during cleanup.
- Keep cleanup idempotent and safe: missing objects should be logged at Debug level, not treated as failure.
- Do not remove user-owned CS VIPs, production certificate keys, or unrelated responder/content-switching objects.

For each area:

- Compare legacy behavior.
- Identify generated `J81.NSToolkit.Config` function names.
- Add idempotency for pre-existing NetScaler objects.
- Add log messages that preserve support value.
- Add staging/live-safe tests where possible.

### 6. Improve NetScaler API Usage - Mostly Completed For HTTP Path

The current HTTP implementation now uses generated `J81.NSToolkit.Config` functions for most NetScaler actions.

Converted generated calls:

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
- `Invoke-NSSaveNsconfig`

Remaining generic Nitro usage:

- `Assert-RequestCertificateNSResource.ps1` keeps fallback generic get/create behavior for resource types that are not explicitly mapped yet.
- `Invoke-RequestCertificateNitro.ps1` remains as a private fallback and error-normalization helper.

Certkey update note:

- `Invoke-NSUpdateSslcertkey` maps to plain `PUT sslcertkey` and exposes monitor settings only.
- `Invoke-NSChangeSslcertkey` maps to `POST sslcertkey?action=update` and exposes `Cert`, `Key`, `Inform`, `Passplain`, and `Nodomaincheck`; this is the generated function used for certificate/key replacement.

Tasks:

- Replace remaining generic calls with generated functions only where generated coverage exposes the same Nitro behavior.
- Keep generic wrapper for gaps in generated coverage or for better error handling.
- Add missing generated wrappers if an API exists in Nitro but not in the module.
- Normalize handling of known Nitro idempotency errors:
  - `[258] No such resource`
  - `[344] No Service`
  - `[538] Action does not exist`
  - `[528] Action name is already in use`
  - `[1540] Certificate does not exist`
  - `[1642] Cannot create output file. File already exists`
- Add helper tests for error classification.

### 7. Certificate Deployment Hardening

Tasks:

- Verify whether `sslcertkey` update vs add behaves correctly across ADC versions.
- Confirm `inform=PFX`, `passplain`, `cert`, and file path fields across target ADC versions.
- Decide whether to keep `TST-` certkey prefix for all non-production providers or only Let's Encrypt staging.
- Add optional cleanup for uploaded PFX files after successful import.
- Add optional cleanup for previous certkeys when `-RemovePrevious` is used.
- Add chain/link behavior if ADC requires CA certkey linking.
- Support update of existing SSL bindings, including global VPN binding, with generated functions.

### 8. Logging And Supportability - Mostly Completed 2026-05-25

Tasks:

- Port useful behavior from legacy `Write-ToLogFile`:
  - Header block.
  - PowerShell version and OS details.
  - module versions.
  - RunAsAdmin status.
  - log rotation.
  - sensitive value masking.
  - exception detail formatting.
- Keep concise console behavior with `-NoConsoleOutput`.
- Add `-Verbose` integration without losing existing log file semantics.
- Add a support bundle option later if useful.

Implemented:

- Log header, OS/PowerShell/module details, elevation diagnostic, log rotation, and sensitive value masking.
- Console output remains concise and honors `-NoConsoleOutput` for module messages. Third-party warnings are suppressed where they were noisy and already handled by our own logging.

Remaining:

- Rich exception detail formatting can still be improved beyond the current message-level logging.
- `-Verbose` integration can be deepened later.

### 9. Testing Plan

Static checks:

```powershell
$env:PSModulePath = 'C:\Users\JohnBillekens\GitHub\J81.NSToolkit;' + $env:PSModulePath
Remove-Module J81.NSToolkit,J81.NSToolkit.Config,Posh-ACME -Force -ErrorAction SilentlyContinue
Import-Module J81.NSToolkit -Force
Get-Command Invoke-RequestCertificate
Test-ModuleManifest 'C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.psd1'
```

Staging HTTP live test:

```powershell
$env:PSModulePath = 'C:\Users\JohnBillekens\GitHub\J81.NSToolkit;' + $env:PSModulePath
Remove-Module J81.NSToolkit,J81.NSToolkit.Config,Posh-ACME -Force -ErrorAction SilentlyContinue
Import-Module J81.NSToolkit -Force
Invoke-RequestCertificate -AutoRun -ConfigFile 'C:\Users\JohnBillekens\GitHub\GenLeCertForNS\temp\config_domains_test.json' -ForceCertRenew -NoConsoleOutput
```

Never include `-Production` unless explicitly approved.

Regression checks after private helper extraction:

- Confirm command still returns `Status = Success`.
- Confirm temporary responder policies/actions are removed in `finally`.
- Confirm existing `csa_letsencrypt`, `csp_letsencrypt`, `svc_letsencrypt_cert_dummy`, and `lb_letsencrypt_cert` are handled idempotently.
- Confirm existing PFX upload is replaced cleanly.
- Confirm `TST-T-portal.j81.nl` is added/updated as expected.

### 10. Suggested Implementation Order

1. Extract private helpers without behavior changes.
2. Add Pester tests around config normalization, secret conversion, Nitro error classification, and ACME flow decisions.
3. Replace generic Nitro calls with generated toolkit functions.
4. Restore detailed logging/header/sensitive masking.
5. Add Posh-ACME advanced parameters. - Completed for the common exposed options.
6. Rework renewal behavior to avoid unnecessary new orders. - Still pending.
7. Re-implement DNS validation. - Implemented through Posh-ACME, provider test pending.
8. Implement remaining legacy switches one by one. - Partly completed; bootstrap/API user and partition work remain.
9. Add alias `GenLeCertForNS` when the public behavior is complete enough.
10. Re-sign module files.

## Open Questions

- Should the TODO live in the module repo as well as this source repo?
- Should `Invoke-RequestCertificate` keep the legacy TSV-ish log format exactly, or is a slightly normalized format acceptable if the same facts are present?
- Should the default ACME flow use `New-PACertificate` for DNS paths and keep the manual HTTP flow for NetScaler responder integration?
- Should staging certkeys always be prefixed with `TST-`, even for non-Let's Encrypt ACME providers?
- Which DNS provider should be used first when DNS validation is resumed?
