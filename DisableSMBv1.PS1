<#
.SYNOPSIS
    Disables the SMBv1 protocol on a Windows system.

.DESCRIPTION
    This function checks if SMBv1 is enabled and, if so, disables it. SMBv1 is a legacy 
    protocol with known vulnerabilities and should be avoided if possible.

.EXAMPLE
    Disable-SMBv1  # Runs the function to disable SMBv1
#>
function Disable-SMBv1 {
    # Get the current state of the SMBv1 feature
    $SMBv1State = Get-WindowsOptionalFeature -Online -FeatureName smb1protocol

    # Check if SMBv1 is already disabled
    if ($SMBv1State.State -ne "Disabled") {
        Write-Verbose "SMBv1 is currently enabled. Disabling..."
        # Disable the SMBv1 feature (this requires a system restart)
        Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol -NoRestart 
        Write-Warning "SMBv1 has been disabled. A system restart is required to complete the change."
    } else {
        Write-Verbose "SMBv1 is already disabled."
    }
}
