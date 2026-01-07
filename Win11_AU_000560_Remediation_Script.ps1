<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-AU-000560) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000560


.TITLE
  Audit Other Logon/Logoff Events - Success

.DESCRIPTION
  Configures Windows 11 to audit successful "Other Logon/Logoff Events"
in compliance with DISA STIG WN11-AU-000560.

    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_AU_000560_Remediation_Script.ps1
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

Write-Host "`n[INFO] Applying STIG: WN11-AU-000560" -ForegroundColor Cyan

# -----------------------------
# Configure Audit Policy
# -----------------------------
auditpol /set `
    /subcategory:"Other Logon/Logoff Events" `
    /success:enable `
    /failure:disable | Out-Null

# -----------------------------
# Verification
# -----------------------------
Write-Host "`n[INFO] Verifying audit policy..." -ForegroundColor Cyan
$auditCheck = auditpol /get /subcategory:"Other Logon/Logoff Events"

$auditCheck | ForEach-Object { Write-Host $_ }

If ($auditCheck -match "Success") {
    Write-Host "`n[SUCCESS] Other Logon/Logoff Events auditing (Success) is ENABLED." -ForegroundColor Green
} Else {
    Write-Warning "Audit policy may not have applied correctly. A GP refresh or reboot may be required."
}

Write-Host "`n[INFO] STIG WN11-AU-000560 remediation completed." -ForegroundColor Cyan
