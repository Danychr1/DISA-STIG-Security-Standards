<#
 .SYNOPSIS
    Remediates DISA STIG WN11-AU-000050 by enabling auditing of successful process creation events on Windows 11 systems.

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
    This script configures Windows 11 to audit successful process creation events and includes command-line arguments in those audit logs, as required by DISA STIG WN11-AU-000050.


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
# Step 0: Ensure Administrator
# -----------------------------
if (-not ([Security.Principal.WindowsPrincipal]
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

Write-Host "`n[INFO] Applying STIG WN11-AU-000050..." -ForegroundColor Cyan

# -----------------------------
# Step 1: Enable Success auditing
# -----------------------------
Write-Host "[INFO] Enabling Success auditing for Process Creation..." -ForegroundColor Cyan
auditpol /set /subcategory:"Process Creation" /success:enable | Out-Null

# -----------------------------
# Step 2: Enable command-line logging
# -----------------------------
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit"

if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

Set-ItemProperty -Path $regPath `
    -Name "ProcessCreationIncludeCmdLine_Enabled" `
    -Value 1 `
    -Type DWord

Write-Host "[INFO] Command-line logging for process creation enabled." -ForegroundColor Cyan

# -----------------------------
# Step 3: Refresh policy
# -----------------------------
Write-Host "[INFO] Refreshing Group Policy..." -ForegroundColor Cyan
gpupdate /force | Out-Null
Start-Sleep -Seconds 3

# -----------------------------
# Step 4: Verify configuration
# -----------------------------
Write-Host "[INFO] Verifying audit configuration..." -ForegroundColor Yellow
$auditStatus = auditpol /get /subcategory:"Process Creation"
$auditStatus

$cmdLineAudit = Get-ItemProperty -Path $regPath -Name "ProcessCreationIncludeCmdLine_Enabled" -ErrorAction SilentlyContinue

# -----------------------------
# Step 5: Confirmation
# -----------------------------
if ($auditStatus -match "Success" -and $cmdLineAudit.ProcessCreationIncludeCmdLine_Enabled -eq 1) {
    Write-Host "`n[SUCCESS] STIG WN11-AU-000050 successfully applied and persistent." -ForegroundColor Green
} else {
    Write-Warning "`n[WARNING] STIG WN11-AU-000050 may not be fully applied."
}

Write-Host "`n[INFO] STIG WN11-AU-000050 remediation completed." -ForegroundColor Cyan
