<#
    Sets device to prefer IPv4 over IPv6

    Why prefer IPv4 over IPv6 (in most cases)?
        While IPv6 is the future and necessary due to the exhaustion of IPv4 addresses externally, most internal networks still predominantly use IPv4.
        Security Concerns
            IPv6's automatic configuration mechanisms can be exploited in certain scenarios to hijack DNS or perform other attacks.
        Compatibility Issues
            Some older devices or software might not work correctly with IPv6, leading to unexpected problems.

    Note
        IPv6-Only Networks: If you are in an environment that exclusively uses IPv6, DO NOT make this change, as it will break connectivity.
#>

#Sets a default value in case the registry key doesn't exist yet.
$IPv6DisabledComponents = 0 

#Get the current IPv6 preference configuration from the registry
$IPv6DisabledComponents = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\" -Name DisabledComponents -ErrorAction SilentlyContinue


#Check if IPv6 is not already preferred (value is not 32)
if($IPv6DisabledComponents -ne 32) {
    #Sets the DisabledComponents value to 32, which makes the computer prefer IPv4 over IPv6
    New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\" -Name DisabledComponents -Value 32 -PropertyType DWORD -Force
}
