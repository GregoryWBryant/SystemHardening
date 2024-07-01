<#
    Disables LLMNR (Link-Local Multicast Name Resolution) in Windows

    Why disable LLMNR?
        Susceptible to LLMNR poisoning attacks, which can lead to credential theft.
        Not usually necessary: Most networks use DNS for name resolution, making LLMNR redundant.
#>

# Sets a default variable to track if LLMNR is enabled (1 = enabled)
$LLMNRStatus = 1 

# Try to read the current LLMNR configuration from the registry
try {
    $LLMNRStatus = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient\" -Name EnableMultiCast
}

# If the registry key doesn't exist yet, do nothing (catch the error)
catch {}

# Check if LLMNR is enabled (non-zero value)
If ($LLMNRStatus -ne 0) { 

    # If the registry path doesn't exist, create it
    If (!(Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient")) {
        New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT" -Name DNSClient -Force
    }

    # Set the registry value to disable LLMNR (0 = disabled)
    New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name EnableMultiCast -Value 0 -PropertyType DWORD -Force
}
