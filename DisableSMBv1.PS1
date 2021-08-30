<#

Disables SMBv1, do not do if you have older OS's such as 2003 Servers or Windows XP :(
SMBv1 is older and has quite a few exploits such as Eternal Blue, it has been replaced by SMBv2 and SMBv3 on newer systems.

#>

#Gets information about SMBv1
$SMBv1State = Get-WindowsOptionalFeature -Online -FeatureName smb1protocol


#Checks if it is disabled
If ($SMBv1State.State -ne "Disabled") {
    #Disables SMBv1
    Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol
}
