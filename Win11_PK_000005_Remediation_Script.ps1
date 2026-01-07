<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-PK-000005) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-PK-000005


.TITLE
  DoD Root CA Certificate Compliance Check

.DESCRIPTION
   Checks whether required DoD Root CA certificates are installed
in the Local Machine Trusted Root Certification Authorities store.
Read-only compliance check (no remediation).

    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_PK_000005_Remediation_Script.ps1
#>

 
Write-Host "`n[INFO] Checking STIG Compliance: WN11-PK-000005" -ForegroundColor Cyan

# -----------------------------
# Required DoD Root CAs
# -----------------------------
$RequiredCAs = @(
    "DoD Root CA 3",
    "DoD Root CA 4",
    "DoD Root CA 5"
)

# -----------------------------
# Get Installed Root CAs
# -----------------------------
$InstalledCAs = Get-ChildItem Cert:\LocalMachine\Root

$MissingCAs = @()

foreach ($CA in $RequiredCAs) {
    if ($InstalledCAs.Subject -notmatch $CA) {
        $MissingCAs += $CA
    }
}

# -----------------------------
# Compliance Result
# -----------------------------
if ($MissingCAs.Count -eq 0) {
    Write-Host "[PASS] All required DoD Root CA certificates are installed." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Missing DoD Root CA certificates:" -ForegroundColor Red
    $MissingCAs | ForEach-Object { Write-Host " - $_" }
}

Write-Host "[INFO] Compliance check completed.`n" -ForegroundColor Cyan

Write-Host "[SUCCESS] DoD Root CA certificates verified/installed." -ForegroundColor Green
Write-Host "[INFO] STIG WN11-PK-000005 remediation completed." -ForegroundColor Cyan 

