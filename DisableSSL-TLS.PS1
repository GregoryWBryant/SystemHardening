<#
.SYNOPSIS
    Disables specified SSL/TLS versions.

.DESCRIPTION
    This function allows you to selectively disable SSL 3.0, TLS 1.0, and/or TLS 1.1 
    on a Windows system.

.PARAMETER Version
    Specifies which versions to disable. Valid options are:
        "SSL3" (for SSL 3.0)
        "TLS10" (for TLS 1.0)
        "TLS11" (for TLS 1.1)
        "SSL3TLS10" (for SSL 3.0 and TLS 1.0)
        "All" (for all three versions)

.NOTES
    Compatibility Issues: Disabling these protocols might cause problems with older applications or devices that rely on them. Ensure compatibility before proceeding.
    Modern Alternatives: Newer protocols like TLS 1.2 and TLS 1.3 are available and provide better security.

.EXAMPLE
    Disable-SSLVersions -Version "SSL3"     # Disables only SSL 3.0
    Disable-SSLVersions -Version "SSL3TLS10" # Disables SSL 3.0 and TLS 1.0
    Disable-SSLVersions -Version "All"       # Disables all three versions
#>
function Disable-SSLVersions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet("SSL3", "TLS10", "TLS11", "SSL3TLS10", "All")]
        [string]$Version
    )

    # Disables SSL version 3, uses force to overwrite existing values
    if ($Version -eq "SSL3" -or $Version -eq "SSL3TLS10" -or $Version -eq "All") {
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" -Name "DisabledByDefault" -Value 1 -PropertyType DWORD -Force
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" -Name "Enabled" -Value 0 -PropertyType DWORD -Force
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" -Name "DisabledByDefault" -Value 1 -PropertyType DWORD -Force
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" -Name "Enabled" -Value 0 -PropertyType DWORD -Force
    }
    # Disables TLS version 1.0, uses force to overwrite existing values
    if ($Version -eq "TLS10" -or $Version -eq "SSL3TLS10" -or $Version -eq "All") {
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "DisabledByDefault" -Value 1 -PropertyType DWORD -Force
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "Enabled" -Value 0 -PropertyType DWORD -Force
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "DisabledByDefault" -Value 1 -PropertyType DWORD -Force
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "Enabled" -Value 0 -PropertyType DWORD -Force
    }
    # Disables TLS version 1.1, uses force to overwrite existing values
    if ($Version -eq "TLS11" -or $Version -eq "All") {
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "DisabledByDefault" -Value 1 -PropertyType DWORD -Force
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "Enabled" -Value 0 -PropertyType DWORD -Force
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "DisabledByDefault" -Value 1 -PropertyType DWORD -Force
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "Enabled" -Value 0 -PropertyType DWORD -Force
    }
}
