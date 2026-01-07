<#
 .SYNOPSIS
    Remediates DISA STIG WN11-CC-000090 by disabling
    "Always install with elevated privileges".

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000090

.TITLE
Force Group Policy reprocessing even if unchanged

.DESCRIPTION
   This script disables the Windows Installer policy that allows
    MSI packages to be installed with elevated privileges.
    The setting is enforced for both Computer and User scopes
    to fully comply with DISA STIG requirements.


    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_CC_000090_Remediation_Script.ps1
#>

# -----------------------------
# Step 0: Ensure Administrator
# -----------------------------
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Error "This script must be run as Administrator."
    exit 1
}

Write-Host "`n[INFO] Applying STIG WN11-CC-000090 remediation..." -ForegroundColor Cyan

# -----------------------------
# Step 1: Define Registry Paths
# -----------------------------
$regPaths = @(
    "HKLM:\Software\Policies\Microsoft\Windows\Installer",
    "HKCU:\Software\Policies\Microsoft\Windows\Installer"
)

# -----------------------------
# Step 2: Disable AlwaysInstallElevated
# -----------------------------
foreach ($path in $regPaths) {

    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
    }

    Set-ItemProperty -Path $path `
        -Name "AlwaysInstallElevated" `
        -Value 0 `
        -Type DWord

    Write-Host "[INFO] Set AlwaysInstallElevated = 0 at $path" -ForegroundColor Yellow
}

# -----------------------------
# Step 3: Apply Group Policy
# -----------------------------
Write-Host "[INFO] Refreshing Group Policy..." -ForegroundColor Cyan
gpupdate /force | Out-Null

Write-Host "`n[SUCCESS] STIG WN11-CC-000090 remediation completed successfully." -ForegroundColor Green
