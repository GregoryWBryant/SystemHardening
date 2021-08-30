<#
Disables NetBios
Netbios is a legacy protocol. It is very chatty with lots of broadcasts and when used with its defaults settings, it can be used by the bad guys to gather information about your network for further attacks.
#>

#Get a list of all network interfaces
$Interfaces = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"

#Loops through and updates each to disable NetBios
Get-ChildItem $Interfaces | foreach { Set-ItemProperty -Path "$regkey\$($_.pschildname)" -Name NetbiosOptions -Value 2 -Verbose}
