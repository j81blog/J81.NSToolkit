function ConvertTo-RequestCertificateHashtable {
<#
    .SYNOPSIS
        Converts legacy request-certificate objects into hashtables.

    .DESCRIPTION
        Converts hashtables, PSCustomObjects, and semicolon-delimited key/value strings
        into a hashtable. This is primarily used for legacy DNSParams and post-script
        extra parameter compatibility.

    .PARAMETER InputObject
        Object to convert.

    .NOTES
        Function  : ConvertTo-RequestCertificateHashtable
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2218
#>
    [CmdletBinding()]
    param(
        [object]$InputObject
    )

    if ($null -eq $InputObject) { return @{} }
    if ($InputObject -is [hashtable]) { return $InputObject }

    $result = @{}
    if ($InputObject -is [string]) {
        foreach ($part in ($InputObject -split ';')) {
            if ([string]::IsNullOrWhiteSpace($part)) { continue }
            $name, $value = $part -split '=', 2
            if (-not [string]::IsNullOrWhiteSpace($name)) {
                $result[$name.Trim()] = if ($null -ne $value) { $value.Trim() } else { '' }
            }
        }
        return $result
    }

    foreach ($property in $InputObject.PSObject.Properties) {
        $result[$property.Name] = $property.Value
    }
    return $result
}
