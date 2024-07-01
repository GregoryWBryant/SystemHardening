<#
    Disables WPAD (Web Proxy Auto-Discovery Protocol)

    Why disable WPAD?
        Security Risk
            WPAD can be exploited to inject malicious proxy settings into your network, potentially leading to man-in-the-middle attacks.
        Privacy Concern
            WPAD broadcasts information about your network and browsing habits.

    Note
        Corporate Environments: Do NOT disable WPAD if your company requires it to automatically configure proxy settings for your network.
        Such as using Group Policies to set Proxy settings for using a Proxy as a Web Filter.
#>

#Sets a default value in case the registry key doesn't exist yet.
$WPADStartupType = 3  

#Get the current WPAD startup configuration from the registry
$WPADStartupType = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" -Name Start -ErrorAction SilentlyContinue

# Check if WPAD is enabled (non-4 value)
if ($WPADStartupType -ne 4) {
    # Set the registry value to 4 (disabled) for the WinHttpAutoProxySvc service
    New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" -Name Start -Value 4 -PropertyType DWORD -Force
}
