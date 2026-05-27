function Assert-RequestCertificateNSResource {
<#
    .SYNOPSIS
        Ensures a NetScaler resource exists.

    .DESCRIPTION
        Checks whether a NetScaler resource exists and creates it when missing.
        Generated J81.NSToolkit.Config functions are used for mapped resource types.

    .PARAMETER NSSession
        Existing NetScaler session returned by Connect-NSNode.

    .PARAMETER Type
        Nitro resource type.

    .PARAMETER Resource
        Resource name to verify.

    .PARAMETER Payload
        Payload used to create the resource when missing.

    .PARAMETER Action
        Optional Nitro action used by the fallback generic create path.

    .NOTES
        Function  : Assert-RequestCertificateNSResource
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object]$NSSession,
        [Parameter(Mandatory)][string]$Type,
        [Parameter(Mandatory)][string]$Resource,
        [Parameter(Mandatory)][hashtable]$Payload,
        [string]$Action
    )

    try {
        $found = switch ($Type) {
            'service' { Invoke-NSGetService -NSSession $NSSession -Name $Resource }
            'lbvserver' { Invoke-NSGetLbvserver -NSSession $NSSession -Name $Resource }
            default { Invoke-RequestCertificateNitro -NSSession $NSSession -Method GET -Type $Type -Resource $Resource -IgnoreNotFound }
        }
    } catch {
        if ($_.Exception.Message -match '404|Not Found|No such resource|No Service|No such|\[258\]|\[344\]') { $found = $null }
        else { throw }
    }
    if ($null -eq $found) {
        Write-RequestCertificateLog Info 'NetScaler' "Creating $Type '$Resource'."
        switch ($Type) {
            'service' {
                $params = @{
                    NSSession     = $NSSession
                    Name          = $Payload.name
                    Ip            = $Payload.ip
                    Servicetype   = $Payload.servicetype
                    Port          = [int]$Payload.port
                    Healthmonitor = $Payload.healthmonitor
                }
                if ($Payload.ContainsKey('td')) { $params.Td = [int]$Payload.td }
                Invoke-NSAddService @params | Out-Null
            }
            'lbvserver' {
                if ([int]$Payload.port -eq 0) {
                    $params = @{
                        NSSession   = $NSSession
                        Name        = $Payload.name
                        Servicetype = $Payload.servicetype
                        Ipv46       = $Payload.ipv46
                    }
                    if ($Payload.ContainsKey('td')) { $params.Td = [int]$Payload.td }
                    Invoke-NSAddLbvserver @params | Out-Null
                } else {
                    $params = @{
                        NSSession   = $NSSession
                        Name        = $Payload.name
                        Servicetype = $Payload.servicetype
                        Ipv46       = $Payload.ipv46
                        Port        = [int]$Payload.port
                    }
                    if ($Payload.ContainsKey('td')) { $params.Td = [int]$Payload.td }
                    Invoke-NSAddLbvserver @params | Out-Null
                }
            }
            default {
                $createParams = @{ NSSession = $NSSession; Method = 'POST'; Type = $Type; Payload = $Payload }
                if ($Action) { $createParams.Action = $Action }
                Invoke-RequestCertificateNitro @createParams | Out-Null
            }
        }
    } else {
        Write-RequestCertificateLog Debug 'NetScaler' "$Type '$Resource' already exists."
    }
}
