<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-CC-000005) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000005


.TITLE
  Block connections to non-domain networks when on domain network

.DESCRIPTION
  This script ensures that camera access from the lock screen is disabled on Windows 11 devices. If the device does not have a camera, the script marks the STIG as Not Applicable (NA)

    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_CC_000005_Remediation_Script.ps1
#>
# Function to check if a camera exists
function Test-Camera {
    $cameras = Get-PnpDevice -Class Camera -Status OK -ErrorAction SilentlyContinue
    if ($cameras) {
        return $true
    } else {
        return $false
    }
}

# Main remediation
try {
    if (Test-Camera) {
        # Path to the registry key for lock screen camera
        $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

        # Create the key if it doesn't exist
        if (-not (Test-Path $regPath)) {
            New-Item -Path $regPath -Force | Out-Null
        }

        # Set 'NoLockScreenCamera' to 1 (Enabled)
        Set-ItemProperty -Path $regPath -Name "NoLockScreenCamera" -Value 1 -Type DWord

        Write-Host "[INFO] STIG WN11-CC-000005 remediation applied: Lock screen camera disabled." -ForegroundColor Cyan
    } else {
        Write-Host "[INFO] STIG WN11-CC-000005 marked as NA: No camera detected on this device." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "[ERROR] Failed to apply STIG WN11-CC-000005 remediation: $_" -ForegroundColor Red
}

