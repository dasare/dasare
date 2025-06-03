<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Daniel Asare
    LinkedIn        : https://www.linkedin.com/in/danielaasare/
    GitHub          : https://github.com/dasare/dasare
    Date Created    : 2025-06-02
    Last Modified   : 2025-06-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

1. Define the desired registry path and value
$regPath   = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
$valueName = 'MaxSize'
$valueData = 0x00008000   # DWORD: 0x00008000 = 32768

# 2. Ensure the parent key exists (create it if necessary)
if (-not (Test-Path -Path $regPath)) {
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog' `
             -Name 'Application' `
             -Force | Out-Null
}

# 3. Create or overwrite the “MaxSize” DWORD under that key
New-ItemProperty -Path $regPath `
                 -Name $valueName `
                 -PropertyType DWord `
                 -Value $valueData `
                 -Force | Out-Null

# 4. Output a confirmation message using (-f) inside parentheses
Write-Host ( "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application\$valueName is now set to 0x{0:X8}" -f $valueData )
