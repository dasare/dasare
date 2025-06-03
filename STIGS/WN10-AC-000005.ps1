<#
.SYNOPSIS
    This PowerShell script ensures that the account lockout duration is set to 15 minutes.

.NOTES
    Author          : Daniel Asare
    LinkedIn        : https://www.linkedin.com/in/danielaasare/
    GitHub          : https://github.com/dasare/dasare
    Date Created    : 2025-06-02
    Last Modified   : 2025-06-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000005).ps1 
#>
# 1. Ensure this script is running elevated (Admin).
#    For a quick check, try creating a file under HKLM or writing to HKLM:\ directly.
#    If it fails, re-launch PowerShell “as Administrator.”

Write-Host "Setting Account Lockout Duration to 15 minutes..."
& net accounts /lockoutduration:15

# Confirm the change
$lockoutDuration = (& net accounts) -match "Lockout duration"
Write-Host $lockoutDuration
