<#
    Disables NetBios

    Why disable NetBios
        Legacy protocol: Outdated and no longer needed in most modern networks.
        Security risk: Generates excessive network traffic and can expose information about your systems to potential attackers.
#>

# Get the base registry path for NetBIOS interface settings
$InterfaceBasePath = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"

# Loop through each network interface found in the registry
Get-ChildItem $InterfaceBasePath | ForEach-Object { 
    # Construct the full registry path for the current interface
    $regkey = "$InterfaceBasePath\$($_.pschildname)"
    
    # Set the NetbiosOptions value to 2 (disabled)
    Set-ItemProperty -Path $regkey -Name NetbiosOptions -Value 2 -Verbose
} 
