<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-CC-000110) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

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
   Configures the system to prevent printing over HTTP, in compliance with
   DISA Windows 11 STIG WN11-CC-000110.

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

# -----------------------------
# Step 0: Ensure running as Admin
# -----------------------------
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Error "This script must be run as Administrator."
    Exit 1
}

Write-Host "`n[INFO] Applying STIG: WN11-CC-000110 - Turn off Printing over HTTP" -ForegroundColor Cyan

# -----------------------------
# Step 1: Set the GPO via registry
# -----------------------------
# Registry path for this policy
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Internet Communication Management\Internet Communication settings"
$regName = "TurnOffPrintingHTTP"

# Create key if it doesn't exist
If (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set value to 1 = Enabled
Set-ItemProperty -Path $regPath -Name $regName -Value 1 -Type DWord

Write-Host "[INFO] 'Turn off printing over HTTP' policy set to Enabled" -ForegroundColor Cyan

# -----------------------------
# Step 2: Verify the setting
# -----------------------------
$regValue = Get-ItemProperty -Path $regPath -Name $regName | Select-Object -ExpandProperty TurnOffPrintingHTTP

If ($regValue -eq 1) {
    Write-Host "[SUCCESS] Printing over HTTP is DISABLED." -ForegroundColor Green
} else {
    Write-Warning "[WARNING] Printing over HTTP policy may not have been applied correctly."
}

Write-Host "[INFO] STIG WN11-CC-000110 remediation completed." -ForegroundColor Cyan

