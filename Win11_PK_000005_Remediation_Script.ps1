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
  Install DoD Root CA Certificates

.DESCRIPTION
   Installs Department of Defense (DoD) Root CA certificates into the
Trusted Root Certification Authorities store for the Local Computer,
in compliance with DISA STIG WN11-PK-000005.

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


# -----------------------------
# Admin Check
# -----------------------------
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Error "This script must be run as Administrator."
    Exit 1
}

Write-Host "`n[INFO] Applying STIG: WN11-PK-000005" -ForegroundColor Cyan

# -----------------------------
# Certificate Source Folder
# -----------------------------
$CertPath = "C:\DoD_Certs"

If (-not (Test-Path $CertPath)) {
    Write-Error "Certificate directory not found: $CertPath"
    Exit 1
}

# -----------------------------
# Install Certificates
# -----------------------------
$CertFiles = Get-ChildItem -Path $CertPath -Filter *.cer

If ($CertFiles.Count -eq 0) {
    Write-Error "No .cer files found in $CertPath"
    Exit 1
}

foreach ($Cert in $CertFiles) {
    Write-Host "[INFO] Installing $($Cert.Name)..."
    Import-Certificate `
        -FilePath $Cert.FullName `
        -CertStoreLocation "Cert:\LocalMachine\Root" `
        | Out-Null
}

Write-Host "[SUCCESS] DoD Root CA certificates installed successfully." -ForegroundColor Green
Write-Host "[INFO] STIG WN11-PK-000005 remediation completed." -ForegroundColor Cyan
