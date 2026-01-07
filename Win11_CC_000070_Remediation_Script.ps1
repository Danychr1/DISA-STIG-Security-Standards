<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-CC-000070) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000070


.TITLE
   Enable Virtualization-Based Security (VBS)

.DESCRIPTION
   Enables Virtualization-Based Security on Windows 11 and configures
the platform security level to Secure Boot, in compliance with
DISA STIG WN11-CC-000070.

    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_CC_000070_Remediation_Script.ps1
#>

# -----------------------------
# Admin Check
# -----------------------------
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Error "This script must be run as Administrator."
    Exit 1
}

Write-Host "`n[INFO] Applying STIG: WN11-CC-000070" -ForegroundColor Cyan

# -----------------------------
# Registry Path
# -----------------------------
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard"

If (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# -----------------------------
# Enable VBS
# -----------------------------
Set-ItemProperty `
    -Path $regPath `
    -Name "EnableVirtualizationBasedSecurity" `
    -Type DWord `
    -Value 1

# -----------------------------
# Platform Security Level
# 1 = Secure Boot
# 3 = Secure Boot with DMA Protection
# -----------------------------
Set-ItemProperty `
    -Path $regPath `
    -Name "RequirePlatformSecurityFeatures" `
    -Type DWord `
    -Value 1

# -----------------------------
# Enable Credential Guard / HVCI Support
# -----------------------------
Set-ItemProperty `
    -Path $regPath `
    -Name "HypervisorEnforcedCodeIntegrity" `
    -Type DWord `
    -Value 1

Write-Host "[SUCCESS] Virtualization-Based Security enabled per STIG." -ForegroundColor Green
Write-Host "[INFO] STIG WN11-CC-000070 remediation completed." -ForegroundColor Cyan
Write-Host "[NOTE] A system reboot is required for changes to take effect." -ForegroundColor Yellow
