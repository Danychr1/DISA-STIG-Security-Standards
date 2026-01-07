<#
 .SYNOPSIS
    This PowerShell script ensures that the associated STIG-ID (WN11-EP-000310) vulnerability is remediated installes feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Dany Christel
    LinkedIn        : https://www.linkedin.com/in/dany-christel/
    GitHub          : https://github.com/Danychr1
    Date Created    : 1/05/2026
    Last Modified   : 1/06/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-EP-000310

.TITLE
Force Group Policy reprocessing even if unchanged

.DESCRIPTION
   Ensures that Group Policy Objects are reprocessed even if they have not changed.
This enhances security by making sure settings are always applied according to DISA STIG requirements.


    This enforces:


.TESTED ON
    Date(s) Tested  : 01/06/2026
    Tested By       : Dany Christel
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.7462

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Win11_EP_000310_Remediation_Script.ps1
#>
