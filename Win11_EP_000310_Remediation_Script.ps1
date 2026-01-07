<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-EP-000310) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-EP-000310


.TITLE
   Enable Kernel DMA Protection – Block All for incompatible devices

.DESCRIPTION
   Configures the system to enable Kernel DMA Protection and blocks enumeration
     of external devices incompatible with DMA protection, in compliance with DISA Windows 11 STIG WN11-EP-000310.

    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_EP_000310_Remediation_Script.ps1
#>

# -----------------------------
# Step 0: Ensure running as Admin
# -----------------------------
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Error "This script must be run as Administrator."
    Exit 1
}

Write-Host "`n[INFO] Applying STIG: WN11-EP-000310 - Kernel DMA Protection" -ForegroundColor Cyan

# -----------------------------
# Step 1: Enable Kernel DMA Protection GPO
# -----------------------------
# Registry path for Kernel DMA Protection GPO
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\KernelDMAProtection"
$regName = "DmaSecurityPolicy"

# Create key if it doesn't exist
If (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set 'DmaSecurityPolicy' to 1 (Block All)
# 0 = Off, 1 = Block All, 2 = Allow Standard
Set-ItemProperty -Path $regPath -Name $regName -Value 1 -Type DWord

Write-Host "[INFO] Kernel DMA Protection set to 'Block All'" -ForegroundColor Cyan

# -----------------------------
# Step 2: Verify the setting
# -----------------------------
$regValue = Get-ItemProperty -Path $regPath -Name $regName | Select-Object -ExpandProperty DmaSecurityPolicy

If ($regValue -eq 1) {
    Write-Host "[SUCCESS] Kernel DMA Protection is ENABLED with 'Block All' policy." -ForegroundColor Green
} else {
    Write-Warning "[WARNING] Kernel DMA Protection policy may not have been applied correctly."
}

Write-Host "[INFO] STIG WN11-EP-000310 remediation completed." -ForegroundColor Cyan
