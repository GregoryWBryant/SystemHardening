<#
Sets up SMB security
This sets SMB to use and require signatures, this improves security by preventing Man-in-the-middle attacks.
#>

#Sets the variables in case they do not already exist
$WorkstatinoSMB.EnableSecuritySignature = 0
$ServerSMB.EnableSecuritySignature = 0
$ServerSMBRequired.RequireSecuritySignature = 0


#Checks the values and if it does not exist silently continue, value will still be 0 from the above.
$WorkstatinoSMB = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanmanWorkStation\Parameters" -Name "EnableSecuritySignature" -ErrorAction SilentlyContinue
$ServerSMB = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters" -Name "EnableSecuritySignature" -ErrorAction SilentlyContinue
$ServerSMBRequired = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters" -Name "requiresecuritysignature" -ErrorAction SilentlyContinue



#Checks each value and creates or updates them if not enabled
if($WorkstatinoSMB.EnableSecuritySignature -ne 1) {
    New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanmanWorkStation\Parameters" -Name "EnableSecuritySignature" -Value 1 -PropertyType DWORD -Force
}

if($ServerSMB.EnableSecuritySignature -ne 1) {
    New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters" -Name "EnableSecuritySignature" -Value 1 -PropertyType DWORD -Force
}

if($ServerSMBRequired.RequireSecuritySignature -ne 1) {
    New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters" -Name "requiresecuritysignature" -Value 1 -PropertyType DWORD -Force
}
