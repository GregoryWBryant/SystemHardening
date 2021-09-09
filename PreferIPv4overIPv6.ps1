<#
Sets device to prefer IPv4 over IPv6
By default Windows trust and prefers IPv6 over IPv4, while if you are using IPv6 that may be great but for most of the world it can lead to issues. 
Since IPv6 information is ditrubuted automatically it easy to plant a black box that gives out IPv6 information such as DNS and hijack the DNS in an enviroment since it will be preferred to IPv4 settings you are handing out 
#>

$IPVersionPreference.DisabledComponents = 0

$IPVersionPreference = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\" -Name DisabledComponents


if($IPVersionPreference.DisabledComponents -ne 32) {
    #Sets the computer to prefer IPv4 over IPv6
    New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\" -Name DisabledComponents -Value 32 -PropertyType DWORD  -Force
}
