function Test-RequestCertificateRenewalRequired {
<#
    .SYNOPSIS
        Determines whether a certificate request should be renewed.

    .DESCRIPTION
        Evaluates legacy GenLeCertForNS CertExpires and RenewAfter metadata. A
        request is renewed when forced, when RenewAfter is missing or invalid, or
        when the current time is equal to or later than RenewAfter.

    .PARAMETER Request
        Certificate request object from command parameters or an AutoRun config
        file.

    .PARAMETER Force
        Forces renewal regardless of CertExpires or RenewAfter values.

    .NOTES
        Function  : Test-RequestCertificateRenewalRequired
        Author    : John Billekens
        Copyright : Copyright (c) John Billekens Consultancy
        Version   : 2026.0527.2130
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [object]$Request,

        [Parameter()]
        [switch]$Force
    )

    function ConvertFrom-RequestCertificateDateValue {
        [CmdletBinding()]
        param(
            [Parameter()]
            [object]$Value
        )

        if ($null -eq $Value -or [string]::IsNullOrWhiteSpace([string]$Value)) {
            return $null
        }

        if ($Value -is [datetime]) {
            return [datetime]$Value
        }

        $dateValue = [string]$Value
        if ($dateValue -match '^/Date\((?<Milliseconds>-?\d+)\)/$') {
            return ([datetimeoffset]::FromUnixTimeMilliseconds([int64]$Matches.Milliseconds)).LocalDateTime
        }

        try {
            return [datetime]::Parse(
                $dateValue,
                [System.Globalization.CultureInfo]::InvariantCulture,
                [System.Globalization.DateTimeStyles]::AssumeUniversal -bor [System.Globalization.DateTimeStyles]::AdjustToUniversal
            ).ToLocalTime()
        } catch {
            return $null
        }
    }

    $now = Get-Date
    $certExpires = ConvertFrom-RequestCertificateDateValue -Value $Request.CertExpires
    $renewAfter = ConvertFrom-RequestCertificateDateValue -Value $Request.RenewAfter
    $expireDays = if ($certExpires) { [int]($certExpires - $now).TotalDays } else { $null }
    $renewAfterDays = if ($renewAfter) { [int]($renewAfter - $now).TotalDays } else { $null }

    if ($Force) {
        return [pscustomobject]@{
            ShouldRenew    = $true
            Reason         = 'ForceCertRenew was specified.'
            CertExpires    = $certExpires
            RenewAfter     = $renewAfter
            ExpireDays     = $expireDays
            RenewAfterDays = $renewAfterDays
        }
    }

    if (-not $renewAfter) {
        return [pscustomobject]@{
            ShouldRenew    = $true
            Reason         = 'RenewAfter is missing or invalid.'
            CertExpires    = $certExpires
            RenewAfter     = $renewAfter
            ExpireDays     = $expireDays
            RenewAfterDays = $renewAfterDays
        }
    }

    if ($now -lt $renewAfter) {
        return [pscustomobject]@{
            ShouldRenew    = $false
            Reason         = "Certificate can be replaced after $($renewAfter.ToString('yyyy-MM-dd HH:mm:ss'))."
            CertExpires    = $certExpires
            RenewAfter     = $renewAfter
            ExpireDays     = $expireDays
            RenewAfterDays = $renewAfterDays
        }
    }

    [pscustomobject]@{
        ShouldRenew    = $true
        Reason         = "RenewAfter has passed ($($renewAfter.ToString('yyyy-MM-dd HH:mm:ss')))."
        CertExpires    = $certExpires
        RenewAfter     = $renewAfter
        ExpireDays     = $expireDays
        RenewAfterDays = $renewAfterDays
    }
}
