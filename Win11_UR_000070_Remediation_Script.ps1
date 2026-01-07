<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-UR-000070) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-UR-000070


.TITLE
   Deny access to this computer from the network

.DESCRIPTION
   Configures the 'Deny access to this computer from the network' user right
to block highly privileged domain accounts, local accounts, and unauthenticated access,
in compliance with DISA Windows 11 STIG WN11-UR-000070.

    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_UR_000070_Remediation_Script.ps1
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

Write-Host "`n[INFO] Applying STIG: WN11-UR-000070" -ForegroundColor Cyan

# -----------------------------
# Define accounts to deny
# -----------------------------
$denyAccounts = @(
    "Enterprise Admins",
    "Domain Admins",
    "Local account",
    "ANONYMOUS LOGON"
)

# -----------------------------
# Export current security policy
# -----------------------------
$tempInf = "$env:TEMP\WN11_UR_000070.inf"
$tempSdb = "$env:TEMP\WN11_UR_000070.sdb"

secedit /export /cfg $tempInf /quiet

# -----------------------------
# Read and modify INF
# -----------------------------
$content = Get-Content $tempInf

# Remove existing DenyNetworkLogonRight if present
$content = $content | Where-Object { $_ -notmatch "^SeDenyNetworkLogonRight" }

# Build new entry
$denyLine = "SeDenyNetworkLogonRight = " + ($denyAccounts -join ",")

# Insert under [Privilege Rights]
$index = $content.IndexOf("[Privilege Rights]")
$index++

$content = $content[0..$index] + $denyLine + $content[($index + 1)..($content.Length - 1)]

# Save updated policy
Set-Content -Path $tempInf -Value $content -Encoding Unicode

# -----------------------------
# Apply security policy
# -----------------------------
secedit /configure /db $tempSdb /cfg $tempInf /areas USER_RIGHTS /quiet

Write-Host "[INFO] User right applied successfully." -ForegroundColor Cyan

# -----------------------------
# Cleanup
# -----------------------------
Remove-Item $tempInf, $tempSdb -Force -ErrorAction SilentlyContinue

Write-Host "[SUCCESS] 'Deny access to this computer from the network' is configured per STIG." -ForegroundColor Green
Write-Host "[INFO] STIG WN11-UR-000070 remediation completed." -ForegroundColor Cyan
