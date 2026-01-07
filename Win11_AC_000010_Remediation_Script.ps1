<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-AC-000010) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000010


.TITLE
  Configure Account Lockout Threshold

.DESCRIPTION
  Configures the system to lock an account after three invalid logon attempts
in compliance with DISA STIG WN11-AC-000010.

    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_AC_000010_Remediation_Script.ps1
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

Write-Host "`n[INFO] Applying STIG: WN11-AC-000010" -ForegroundColor Cyan

# -----------------------------
# Configure Account Lockout Threshold
# -----------------------------
net accounts /lockoutthreshold:3

Write-Host "[SUCCESS] Account lockout threshold set to 3 invalid attempts." -ForegroundColor Green

# -----------------------------
# Verification
# -----------------------------
Write-Host "`n[INFO] Verifying account lockout policy..." -ForegroundColor Cyan
net accounts

Write-Host "`n[INFO] STIG WN11-AC-000010 remediation completed." -ForegroundColor Cyan
