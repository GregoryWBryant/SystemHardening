<#
Disables NetBios
Netbios is a legacy protocol. It is very chatty with lots of broadcasts and when used with its defaults settings, it can be used by the bad guys to gather information about your network for further attacks.
#>

#Sets Variable incase try fails due to property not existing.
$NetBiosStatus = 1

#Get Value of registry value
$NetBiosStatus = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient\" -Name EnableMultiCast -ErrorAction SilentlyContinue

#Does nothing if it fails.
Catch {}

If ($NetBiosStatus -ne 0) {

    #Checks if path exist and creates it if not.
    If (Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient") {
        New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT" -Name DNSClient  -Force
    }

    #Sets Registry value to disable Netbios.
    New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name EnableMultiCast -Value 0 -PropertyType DWORD  -Force
}