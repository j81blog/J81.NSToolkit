function Set-RequestCertificateNoteProperty {
<#
    .SYNOPSIS
        Sets or adds a note property on an object.

    .DESCRIPTION
        Updates an existing property or adds a note property when legacy config
        objects do not contain newer fields.

    .PARAMETER InputObject
        Object to update.

    .PARAMETER Name
        Property name to set.

    .PARAMETER Value
        Property value to assign.

    .NOTES
        Function  : Set-RequestCertificateNoteProperty
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0525.2137
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [object]$InputObject,

        [Parameter(Mandatory)]
        [string]$Name,

        [object]$Value
    )

    if ($InputObject.PSObject.Properties.Name -contains $Name) {
        $InputObject.$Name = $Value
    } else {
        $InputObject | Add-Member -MemberType NoteProperty -Name $Name -Value $Value -Force
    }
}
