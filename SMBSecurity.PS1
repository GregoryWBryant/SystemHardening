<#
.SYNOPSIS
    Configures SMB signing settings.

.DESCRIPTION
    This function allows you to enable or require SMB signing on both the workstation (client) and server sides. SMB signing enhances security by protecting against man-in-the-middle (MitM) and SMB relay attacks.

.PARAMETER Mode
    Specifies the SMB signing mode. Allowed values:
        "Enable" - Enables SMB signing (recommended for most environments), setting only applies to SMBv1 enviorments.
            SMBv2, and SMBv3 ignore this as it is already enabled.
        "Require" - Requires SMB signing (more secure, but might cause compatibility issues with older devices).

.NOTES
    Be cautious when requiring SMB signing, as it might cause connectivity issues with older devices or systems that don't support it.
    If set to Required and you have clients that don't support SMB signing, they won't be able to connect.


.EXAMPLE
    Configure-SMBSigning -Mode "Enable"  # Enables SMB signing on both client and server
    Configure-SMBSigning -Mode "Require" # Requires SMB signing on both client and server
#>
function Configure-SMBSigning {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet("Enable", "Require")]
        [string]$Mode
    )

    $signingValue = if ($Mode -eq "Enable") { 0 } else { 1 } # 0 for Do not Require, 1 for Required

    # Enable signing on the workstation (client) side
    New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanmanWorkStation\Parameters" -Name "EnableSecuritySignature" -Value 1 -PropertyType DWORD -Force
    # Set or clear the requirement for signing on the workstation side
    New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanmanWorkStation\Parameters" -Name "RequireSecuritySignature" -Value $signingValue -PropertyType DWORD -Force

    # Enable signing on the server side
    New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters" -Name "EnableSecuritySignature" -Value 1 -PropertyType DWORD -Force
    # Set or clear the requirement for signing on the server side
    New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters" -Name "RequireSecuritySignature" -Value $signingValue -PropertyType DWORD -Force

}
