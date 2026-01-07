<#
 .SYNOPSIS
    Remediates DISA STIG WN11-CC-000110 by disabling Printing over HTTP.
.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110


.TITLE
   Prevent Printing over HTTP

.DESCRIPTION
   This PowerShell script configures the Windows 11 system to prevent
    printing over HTTP by enabling the policy:
    "Turn off printing over HTTP".

    This setting is required to comply with DISA Windows 11 STIG
    WN11-CC-000110 and helps reduce attack surface by preventing
    insecure print traffic.

    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_CC_000110_Remediation_Script.ps1
#>

# -------------------------------------------------
# Step 0: Ensure script is running as Administrator
# -------------------------------------------------
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Error "This script must be run as Administrator."
    exit 1
}

Write-Host "`n[INFO] Applying STIG WN11-CC-000110 - Turn off Printing over HTTP" -ForegroundColor Cyan

# -------------------------------------------------
# Step 1: Configure registry-based Group Policy
# -------------------------------------------------
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Internet Communication Management\Internet Communication settings"
$RegName = "TurnOffPrintingHTTP"
$RegValue = 1   # 1 = Enabled (Printing over HTTP disabled)

if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type DWord

Write-Host "[INFO] Registry policy configured successfully." -ForegroundColor Cyan

# -------------------------------------------------
# Step 2: Validate configuration
# -------------------------------------------------
$CurrentValue = Get-ItemProperty -Path $RegPath -Name $RegName -ErrorAction SilentlyContinue |
                Select-Object -ExpandProperty $RegName

if ($CurrentValue -eq 1) {
    Write-Host "[SUCCESS] Printing over HTTP is DISABLED (STIG compliant)." -ForegroundColor Green
} else {
    Write-Warning "[WARNING] Printing over HTTP policy validation failed."
}

Write-Host "[INFO] STIG WN11-CC-000110 remediation completed." -ForegroundColor Cyan
