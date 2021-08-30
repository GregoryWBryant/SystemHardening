<#
WPAD automatically queries the network to see if you are supposed to use a proxy
This is exploited by broadcasting information and attempting to introdcue a man-in-the-middle
If your company does assign a proxy do not do this.
#>

#Setrs variable incase registry didn't exist
$WinHttpAutoProxySvcStartupType.Start = 3

#Checks Registry for setting
$WinHttpAutoProxySvcStartupType = Get-ItemProperty  "HKLM:\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" -Name Start


if($WinHttpAutoProxySvcStartupType.Start -ne 4) {
    #Sets registry to 4 which disables the service
    New-ItemProperty  "HKLM:\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" -Name Start -Value 4 -PropertyType DWORD  -Force
}
