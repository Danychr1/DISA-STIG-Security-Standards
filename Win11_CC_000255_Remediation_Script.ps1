<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-CC-000255) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000255


.TITLE
  Require Hardware Security Device for Windows Hello for Business

.DESCRIPTION
  Configures Windows 11 to require the use of a hardware-backed
security device (TPM) for Windows Hello for Business authentication,
in compliance with DISA STIG WN11-CC-000255.

    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_CC_000255_Remediation_Script.ps1
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

Write-Host "`n[INFO] Applying STIG: WN11-CC-000255" -ForegroundColor Cyan

# -----------------------------
# Registry Path
# -----------------------------
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork"

If (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# -----------------------------
# Require Hardware Security Device
# -----------------------------
Set-ItemProperty `
    -Path $regPath `
    -Name "RequireSecurityDevice" `
    -Type DWord `
    -Value 1

Write-Host "[SUCCESS] Hardware security device requirement enabled." -ForegroundColor Green
Write-Host "[INFO] STIG WN11-CC-000255 remediation completed." -ForegroundColor Cyan
Write-Host "[NOTE] A sign-out or reboot may be required for enforcement." -ForegroundColor Yellow
