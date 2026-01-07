<#
 .SYNOPSIS
   Remediates DISA STIG WN11-CC-000197 by disabling Microsoft Consumer Experiences
    on Windows 11 systems.
    
.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000197


.TITLE
   Turn off Microsoft Consumer Experiences

.DESCRIPTION
  This PowerShell script configures the system to disable Microsoft Consumer
    Experiences (such as consumer apps, tips, and promotional content) in
    accordance with DISA Windows 11 STIG WN11-CC-000197.

    Policy Path:
    Computer Configuration >>
    Administrative Templates >>
    Windows Components >>
    Cloud Content >>
    Turn off Microsoft consumer experiences = Enabled


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_CC_000197_Remediation_Script.ps1
#>

# -------------------------------------------------
# Step 0: Ensure the script is run as Administrator
# -------------------------------------------------
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Error "This script must be run with Administrator privileges."
    exit 1
}

Write-Host "`n[INFO] Applying STIG WN11-CC-000197 - Turn off Microsoft Consumer Experiences" -ForegroundColor Cyan

# -------------------------------------------------
# Step 1: Configure registry-based policy
# -------------------------------------------------
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$regName = "DisableConsumerFeatures"
$regValue = 1   # 1 = Enabled (STIG-compliant)

try {
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord -Force

    Write-Host "[INFO] Policy configured: 'Turn off Microsoft consumer experiences' = Enabled" -ForegroundColor Cyan
}
catch {
    Write-Error "[ERROR] Failed to configure registry policy: $_"
    exit 1
}

# -------------------------------------------------
# Step 2: Verify compliance
# -------------------------------------------------
$appliedValue = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty $regName

if ($appliedValue -eq 1) {
    Write-Host "[SUCCESS] Microsoft Consumer Experiences are disabled (STIG compliant)." -ForegroundColor Green
} else {
    Write-Warning "[WARNING] STIG WN11-CC-000197 may not be fully applied."
}

Write-Host "[INFO] STIG WN11-CC-000197 remediation completed." -ForegroundColor Cyan
