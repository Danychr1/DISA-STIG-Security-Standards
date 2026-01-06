 <#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-CC-000315) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/05/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.DESCRIPTION
    This script sets the following registry value: Standard user accounts must not be granted elevated privileges.
    Enabling Windows Installer to elevate privileges when installing applications can allow malicious persons 
    and applications to gain full control of a system. 


    This enforces:


.TESTED ON
    Date(s) Tested  : 01/05/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_CC_000315_Remediation_Script.ps1
#>

# # ============================================================
# Disable "Always install with elevated privileges."
# Windows Installer Security Hardening
# ============================================================

$registryPaths = @(
    "HKLM:\Software\Policies\Microsoft\Windows\Installer",
    "HKCU:\Software\Policies\Microsoft\Windows\Installer"
)

foreach ($path in $registryPaths) {
    # Create registry path if it does not exist
    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
    }

    # Set AlwaysInstallElevated to Disabled (0)
    Set-ItemProperty -Path $path -Name "AlwaysInstallElevated" -Type DWord -Value 0
}

Write-Output "✔ 'Always install with elevated privileges' has been DISABLED for Computer and User."

# Optional: Refresh Group Policy
Write-Host "Refreshing Group Policy..."
gpupdate /target:computer /force | Out-Null
Write-Host "Group Policy refreshed successfully." -ForegroundColor Green
 
