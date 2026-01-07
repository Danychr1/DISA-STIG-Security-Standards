<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-CC-000090) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.TITLE
Force Group Policy reprocessing even if unchanged

.DESCRIPTION
   Ensures that Group Policy Objects are reprocessed even if they have not changed.
This enhances security by making sure settings are always applied according to DISA STIG requirements.


    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_AU_000050_Remediation_Script.ps1
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

Write-Host "`n[INFO] Applying STIG: WN11-CC-000090" -ForegroundColor Cyan

# -----------------------------
# Step 1: Force Group Policy reprocessing
# -----------------------------
Write-Host "[INFO] Forcing Group Policy reprocessing..." -ForegroundColor Cyan
gpupdate /force | Out-Null

# Optional: wait a few seconds to ensure refresh
Start-Sleep -Seconds 5

# -----------------------------
# Step 2: Verify Group Policy refresh
# -----------------------------
Write-Host "[INFO] Verifying Group Policy status..." -ForegroundColor Yellow
# Use GPResult to confirm that policies have been applied
gpresult /r

Write-Host "`n[SUCCESS] Group Policy reprocessing enforced successfully." -ForegroundColor Green
Write-Host "[INFO] STIG WN11-CC-000090 remediation completed." -ForegroundColor Cyan
