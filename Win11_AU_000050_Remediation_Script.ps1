<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-CC-000315) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

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

# Ensure script runs as Administrator
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Error "This script must be run as Administrator."
    Exit 1
}

Write-Host "Configuring Audit Process Creation → Success..." -ForegroundColor Cyan

# Enable Success auditing for Process Creation
auditpol /set /subcategory:"Process Creation" /success:enable

# Verify configuration
Write-Host "`nVerifying audit policy..." -ForegroundColor Yellow
$auditStatus = auditpol /get /subcategory:"Process Creation"

Write-Output $auditStatus

# Confirm
if ($auditStatus -match "Success\s+Enabled") {
    Write-Host "`nSUCCESS: Audit Process Creation → Success is enabled." -ForegroundColor Green
} else {
    Write-Warning "WARNING: Audit policy may not have been applied correctly."
}

# Optional: Refresh Group Policy
Write-Host "Refreshing Group Policy..."
gpupdate /target:computer /force | Out-Null
Write-Host "Group Policy refreshed successfully." -ForegroundColor Green


