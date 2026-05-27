# Invoke-NSNitroApi General Improvements

Date: 2026-05-26

## Purpose

This document tracks general, non-certificate-specific improvements for the shared `Invoke-NSNitroApi` function and the generated `J81.NSToolkit.Config` / `J81.NSToolkit.Stats` functions.

The goal is to improve correctness, diagnostics, and generated wrapper usability without breaking existing functions that already depend on `Invoke-NSNitroApi`.

## Current State

`Invoke-NSNitroApi` is the shared transport/helper used by generated NetScaler functions. It has already been improved with:

- `POST` and `PUT` method support.
- `-Headers`.
- `-RawResponse`.
- `X-NITRO-WARNING` and `X-NITRO-ONERROR` headers.
- Safer query-string construction.
- Windows PowerShell `-UseBasicParsing` to avoid the legacy `Invoke-WebRequest` script execution warning.
- Better NITRO error records.
- Warning output for NITRO `WARNING` severity.
- Response metadata note properties such as status code, URI, method, and raw content.

These changes should remain backward-compatible: default output should stay the parsed NITRO response object unless an explicit switch requests more metadata.

## Design Principles

- Do not break generated config/stat functions.
- Add optional parameters rather than changing defaults.
- Keep output shape stable by default.
- Keep raw response and diagnostic detail opt-in.
- Prefer generated functions for normal resource operations.
- Keep generic NITRO available for edge cases, generated-wrapper validation gaps, and newly added NITRO APIs.
- Use official NITRO behavior: error payloads include `errorcode`, `message`, and `severity`; bulk behavior can use `X-NITRO-ONERROR`; warnings can use `X-NITRO-WARNING`.

## Recommended `Invoke-NSNitroApi` Enhancements

### 1. Add Optional Not-Found Handling

Add optional parameters:

```powershell
[switch]$IgnoreNotFound
[int[]]$NotFoundErrorCode = @(258, 344, 538, 1540)
[switch]$ReturnNullOnNotFound
```

Expected behavior:

- Default behavior remains unchanged.
- When `-IgnoreNotFound` is specified and the NITRO `errorcode` is in `NotFoundErrorCode`, do not throw.
- If `-ReturnNullOnNotFound` is also specified, return `$null`.
- Otherwise return the parsed NITRO response with status/error metadata.

Why:

- Many idempotent flows need "missing object means create it".
- Avoids repeating local error parsing wrappers in higher-level functions.

Impact:

- Low if fully opt-in.
- Existing generated functions remain unchanged.

### 2. Add Structured NITRO Error Metadata

Add error metadata consistently to the response object and `ErrorRecord.TargetObject`:

- `NitroErrorCode`
- `NitroSeverity`
- `NitroMessage`
- `HttpStatusCode`
- `HttpStatusDescription`
- `Method`
- `Type`
- `Resource`
- `Action`
- `Uri`
- `RawContent`

Why:

- Makes troubleshooting easier.
- Lets callers make decisions without regex matching exception messages.

Impact:

- Low if added as note properties.
- Avoid changing existing `errorcode`, `message`, or `severity` fields.

### 3. Add `-ThrowOnWarning`

Add:

```powershell
[switch]$ThrowOnWarning
```

Expected behavior:

- Default: warnings are emitted as warnings but do not fail the call.
- With `-ThrowOnWarning`: NITRO `severity = WARNING` becomes a terminating error.

Why:

- Some automation wants warnings to be treated as policy failures.

Impact:

- Low because opt-in.

### 4. Add `-WarningAction` Friendly Behavior

Honor PowerShell `-WarningAction` more consistently:

- `SilentlyContinue`: suppress NITRO warnings.
- `Stop`: treat NITRO warnings as terminating errors.
- `Continue`: current warning behavior.

Why:

- Aligns NITRO warnings with normal PowerShell stream semantics.

Impact:

- Low to medium. Needs careful testing because generated wrappers may use `-GetWarning`.

### 5. Add Better Query Encoding Helpers

Centralize query encoding for:

- `args`
- `filter`
- `view=summary`
- arbitrary query values

Make sure name/value separators required by NITRO remain unescaped where needed, while values are safely escaped.

Why:

- Avoid malformed URLs when multiple query sections are combined.
- Avoid regressions from ad hoc query string construction.

Impact:

- Medium. URI construction touches all callers, so keep tests broad.

### 6. Add Optional Request/Response Timing

Add response metadata:

- `DurationMs`
- `StartedAt`
- `EndedAt`

Why:

- Useful for slow ADCs, HA failovers, or network diagnosis.

Impact:

- Low if metadata-only.

### 7. Add Optional Retry Policy

Add optional parameters:

```powershell
[int]$RetryCount = 0
[int]$RetryDelaySeconds = 1
[int[]]$RetryStatusCode = @(429, 500, 502, 503, 504)
```

Only retry safe/idempotent reads by default. For write operations, require an explicit opt-in:

```powershell
[switch]$RetryUnsafeMethods
```

Why:

- NITRO can temporarily fail during HA transitions, reboots, or management-plane load.

Impact:

- Medium. Must avoid duplicating non-idempotent writes.

### 8. Add Session Expiration Awareness

If `NSSession.SessionExpiration` is present and expired:

- Emit a clear error before sending the request, or
- optionally refresh/reconnect if a credential callback is available later.

Why:

- Current failures after timeout may be less actionable.

Impact:

- Low if only a clearer error is added.
- Higher if automatic reconnect is added; defer auto reconnect.

### 9. Normalize `GET (ALL)` / `GetAll`

Current generated functions typically expose `-GetAll`. Ensure the transport helper has clear support for generated `GET` operations where:

- resource omitted means collection GET,
- resource supplied means single resource GET,
- `count=yes`, `view=summary`, and filters are consistently handled.

Why:

- Reduces generator complexity and subtle differences across generated functions.

Impact:

- Medium. Requires generated wrapper audit.

### 10. Improve Raw Response Contract

Current `-RawResponse` should remain, but document and stabilize the contract:

```powershell
[pscustomobject]@{
    Response
    StatusCode
    StatusDescription
    Headers
    Uri
    Method
    RequestHeaders
    RequestBody
    RawContent
}
```

Suggested additions:

- `DurationMs`
- `NitroErrorCode`
- `NitroSeverity`
- `NitroMessage`

Why:

- Enables external callers to rely on this shape.

Impact:

- Low if additive.

## Generated Config/Stat Function Improvements

### 1. Generated Parameter Validation Should Match NITRO Reality

Some generated wrappers appear stricter than the ADC API behavior.

Known example:

- `Invoke-NSAddLbvserver -Port $null` converts to `0` and fails validation.
- Omitting `-Port` creates a non-addressable `0.0.0.0:0` LB vServer successfully.
- `Invoke-NSAddLbvserver -Ipv46 '0.0.0.0'` without `-Port` also creates `0.0.0.0:0`.

Recommendation:

- For optional NITRO fields, do not force validation when the parameter is not supplied.
- Avoid treating `$null` as a supplied value if the generator can omit it.
- Where NITRO supports `0`, generated validation should allow `0`, or the generated wrapper should omit the field when `$null`.

Impact:

- Medium. Validation changes can alter client-side failure behavior.
- Should be tested per API.

### 2. Preserve Legacy-Compatible Names Where ADC Allows Them

Known example:

- `systemcmdpolicy` generated wrappers validate `Policyname` with a pattern that rejects hyphens.
- Legacy and ADC-accepted names such as `script-GenLeCertForNS-Basics` require generic NITRO fallback.

Recommendation:

- Revisit generated `ValidatePattern` rules against the official NITRO schema and actual ADC behavior.
- Prefer server-side validation for name fields unless the generated constraint is known to be exact.

Impact:

- Medium. Loosening validation is usually backward-compatible, but may allow requests the ADC later rejects.

### 3. Generate Consistent `-PassThru`

Many generated add/update/bind functions support `-PassThru`. Ensure consistency:

- Add functions should return the created object or NITRO response with `-PassThru`.
- Update functions should return updated object or response with `-PassThru`.
- Delete/unbind functions can return response metadata with `-PassThru`.

Impact:

- Low if default remains unchanged.

### 4. Generate Common Error Handling Options

Generated functions could expose and forward:

- `-RawResponse`
- `-IgnoreNotFound`
- `-ReturnNullOnNotFound`
- `-ThrowOnWarning`

Why:

- Avoid every caller needing to call `Invoke-NSNitroApi` directly for common automation behavior.

Impact:

- Low if optional.
- Requires generator changes.

### 5. Generated Function Naming Audit

Confirm naming is consistent for bindings and actions:

- Resource operation wrappers should map clearly to NITRO operation names.
- Action operations should use generated verb/noun names that reveal the NITRO action where possible.

Known good example:

- `Invoke-NSChangeSslcertkey` maps to `POST sslcertkey?action=update`, which is the correct wrapper for certificate/key replacement.

Potential documentation task:

- Add a generated-name-to-NITRO-operation mapping table for ambiguous resources.

### 6. Stat Module Parity

For `J81.NSToolkit.Stats`, review:

- `-RawResponse` support.
- query/filter/count support.
- consistent object output.
- handling of stat endpoints that return partial data or empty arrays.
- timing metadata for performance diagnostics.

Impact:

- Low to medium depending on generator design.

## Test Plan

### Static Tests

```powershell
$env:PSModulePath = 'C:\Users\JohnBillekens\GitHub\J81.NSToolkit;' + $env:PSModulePath
Remove-Module J81.NSToolkit,J81.NSToolkit.Config,J81.NSToolkit.Stats -Force -ErrorAction SilentlyContinue
Import-Module J81.NSToolkit -Force
Test-ModuleManifest 'C:\Users\JohnBillekens\GitHub\J81.NSToolkit\J81.NSToolkit\J81.NSToolkit.psd1'
```

### Transport Tests

- GET single resource.
- GET collection.
- GET collection with filter.
- GET with summary view.
- POST add.
- PUT update.
- POST action.
- DELETE.
- Bulk operation with `X-NITRO-ONERROR`.
- Warning operation with `X-NITRO-WARNING`.
- Error operation with `-RawResponse`.
- Not-found operation with and without `-IgnoreNotFound`.

### Generated Wrapper Regression Tests

- Existing generated config functions still import.
- Existing generated stat functions still import.
- Existing wrappers preserve default output.
- Existing wrappers preserve error behavior unless new opt-in parameters are used.
- Edge validation tests:
  - non-addressable LB vServer create without `Port`.
  - legacy command policy name with hyphens.
  - names with allowed ADC characters across common resources.

## Suggested Implementation Order

1. Add structured error metadata to `Invoke-NSNitroApi`.
2. Add `-IgnoreNotFound` and `-ReturnNullOnNotFound`.
3. Stabilize and document `-RawResponse`.
4. Add warning behavior improvements.
5. Add timing metadata.
6. Review generated validation patterns for known mismatches.
7. Add generator support for forwarding safe optional transport switches.
8. Add Pester tests for transport behavior.
9. Add Pester tests for generated wrapper edge cases.
10. Review stat module parity.

## Current Known Generic Fallback Reasons

These are general module improvement candidates, not certificate-specific goals:

- `systemcmdpolicy` generated wrappers reject legacy hyphenated names that ADC accepts.
- Some generated parameter validation is stricter than the ADC behavior, such as nullable/omitted port behavior for non-addressable LB vServers.
- A private wrapper may still be useful for domain-specific idempotency and error messages, but common behavior should move into `Invoke-NSNitroApi` as opt-in switches.
