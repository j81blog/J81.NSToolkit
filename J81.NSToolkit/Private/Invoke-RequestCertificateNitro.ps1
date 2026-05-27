function Invoke-RequestCertificateNitro {
<#
    .SYNOPSIS
        Invokes a NetScaler Nitro API request for certificate operations.

    .DESCRIPTION
        Wraps Invoke-NSNitroApi for Nitro operations that are not covered by a
        generated J81.NSToolkit.Config function or need normalized not-found handling.

    .PARAMETER NSSession
        Existing NetScaler session returned by Connect-NSNode.

    .PARAMETER Method
        HTTP or Nitro method to pass to Invoke-NSNitroApi.

    .PARAMETER Type
        Nitro resource type.

    .PARAMETER Resource
        Optional Nitro resource name.

    .PARAMETER Action
        Optional Nitro action query value.

    .PARAMETER Arguments
        Nitro arguments hashtable.

    .PARAMETER Filters
        Nitro filter hashtable.

    .PARAMETER Payload
        Nitro request payload.

    .PARAMETER IgnoreNotFound
        Treats known Nitro not-found responses as a null result.

    .NOTES
        Function  : Invoke-RequestCertificateNitro
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object]$NSSession,
        [Parameter(Mandatory)][string]$Method,
        [Parameter(Mandatory)][string]$Type,
        [string]$Resource,
        [string]$Action,
        [hashtable]$Arguments = @{},
        [hashtable]$Filters = @{},
        [hashtable]$Payload = @{},
        [switch]$IgnoreNotFound
    )

    $oldPreference = $ErrorActionPreference
    try {
        $params = @{ NSSession = $NSSession; Method = $Method; Type = $Type; NitroPath = 'nitro/v1/config'; GetWarning = $true }
        if ($Resource) { $params.Resource = $Resource }
        if ($Action) { $params.Action = $Action }
        if ($Arguments.Count -gt 0) { $params.Arguments = $Arguments }
        if ($Filters.Count -gt 0) { $params.Filters = $Filters }
        if ($Payload.Count -gt 0) { $params.Payload = $Payload }

        $ErrorActionPreference = if ($IgnoreNotFound) { 'SilentlyContinue' } else { 'Stop' }
        $response = Invoke-NSNitroApi @params
        if ($response.severity -eq 'ERROR') {
            $target = if ($Resource) { "$Type/$Resource" } else { $Type }
            $message = "$Method $target"
            if ($Action) { $message += "?action=$Action" }
            $message += " failed: [$($response.errorcode)] $($response.message)"
            if ($IgnoreNotFound -and ($message -match '404|Not Found|No such resource|No Service|No such|Certificate does not exist|\[258\]|\[344\]|\[1540\]')) { return $null }
            throw $message
        }
        return $response
    } catch {
        if ($IgnoreNotFound -and ($_.Exception.Message -match '404|Not Found|No such resource|No Service|No such|Certificate does not exist|\[258\]|\[344\]|\[1540\]')) { return $null }
        throw
    } finally {
        $ErrorActionPreference = $oldPreference
    }
}
