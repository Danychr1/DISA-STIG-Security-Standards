<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-AU-000050) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000050

.DESCRIPTION
    Configures the system to audit successful process creation events.
Equivalent to setting: Computer Configuration > Windows Settings > Security Settings >
Advanced Audit Policy Configuration > System Audit Policies > Detailed Tracking > 'Audit Process Creation' → Success #>


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

Write-Host "`n[INFO] Applying STIG: WN11-AU-000050" -ForegroundColor Cyan

# -----------------------------
# Step 1: Enable Success auditing
# -----------------------------
Write-Host "[INFO] Enabling Success auditing for Process Creation..." -ForegroundColor Cyan
auditpol /set /subcategory:"Process Creation" /success:enable

# -----------------------------
# Step 2: Refresh Group Policy
# -----------------------------
Write-Host "[INFO] Refreshing Group Policy..." -ForegroundColor Cyan
gpupdate /force | Out-Null
Start-Sleep -Seconds 5

# -----------------------------
# Step 3: Verify the setting
# -----------------------------
Write-Host "[INFO] Verifying audit policy..." -ForegroundColor Yellow
$auditStatus = auditpol /get /subcategory:"Process Creation"
Write-Output $auditStatus

# -----------------------------
# Step 4: Confirm success
# -----------------------------
if ($auditStatus -match "Success") {
    Write-Host "`n[SUCCESS] Process Creation auditing for Success is ENABLED." -ForegroundColor Green
} else {
    Write-Warning "`n[WARNING] Audit Process Creation → Success may not be applied correctly."
}

Write-Host "`n[INFO] STIG WN11-AU-000050 remediation completed." -ForegroundColor Cyan
