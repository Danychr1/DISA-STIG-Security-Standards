<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-SO-000075) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000075


.TITLE
   Configure required legal notice before console logon

.DESCRIPTION
   Sets the legal notice caption and text that appear before Windows logon, 
in compliance with DISA Windows 11 STIG WN11-SO-000075.

    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_SO_000075_Remediation_Script.ps1
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

Write-Host "`n[INFO] Applying STIG: WN11-SO-000075 - Legal Notice before logon" -ForegroundColor Cyan

# -----------------------------
# Step 1: Set the registry keys for Legal Notice
# -----------------------------
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$captionName = "LegalNoticeCaption"
$textName    = "LegalNoticeText"

# Legal notice content (can be customized)
$captionText = "Authorized Use Only"
$bodyText    = "This system is for authorized users only. All activities are monitored and recorded."

# Apply registry values
Set-ItemProperty -Path $regPath -Name $captionName -Value $captionText -Type String
Set-ItemProperty -Path $regPath -Name $textName -Value $bodyText -Type String

Write-Host "[INFO] Legal Notice caption and text have been set." -ForegroundColor Cyan

# -----------------------------
# Step 2: Verify the setting
# -----------------------------
$regCaption = (Get-ItemProperty -Path $regPath -Name $captionName).$captionName
$regText    = (Get-ItemProperty -Path $regPath -Name $textName).$textName

If (($regCaption -eq $captionText) -and ($regText -eq $bodyText)) {
    Write-Host "[SUCCESS] Legal Notice is correctly configured." -ForegroundColor Green
} else {
    Write-Warning "[WARNING] Legal Notice may not have been applied correctly."
}

Write-Host "[INFO] STIG WN11-SO-000075 remediation completed." -ForegroundColor Cyan
