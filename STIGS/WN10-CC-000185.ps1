<#
.SYNOPSIS
    This PowerShell script ensures that Autorun is disabled on all drive types by setting the NoDriveTypeAutoRun registry value to 0xFF.

.NOTES
    Author          : Daniel Asare
    LinkedIn        : https://www.linkedin.com/in/danielaasare/
    GitHub          : https://github.com/dasare/dasare
    Date Created    : 2025-06-02
    Last Modified   : 2025-06-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000185

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000185).ps1 
#>
# -------------------------------------------------------------------
# DISA STIG: WN10-CC-000185 – Prevent default Autorun behavior
# Synopsis:  Ensures that Autorun is disabled on all drive types by setting 
#            NoDriveTypeAutoRun = 0xFF under HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer
# -------------------------------------------------------------------

# 1. Define the registry path and desired value
$regPath   = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$valueName = 'NoDriveTypeAutoRun'
$valueData = 0x000000FF   # 0xFF disables Autorun on all drive types

# 2. Create the Policies\Explorer key if it doesn’t exist
if (-not (Test-Path -Path $regPath)) {
    New-Item -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies' `
             -Name 'Explorer' `
             -Force | Out-Null
}

# 3. Create or overwrite the NoDriveTypeAutoRun DWORD to 0xFF
Write-Host "Disabling Autorun (NoDriveTypeAutoRun = 0xFF)..." 
New-ItemProperty -Path $regPath `
                 -Name $valueName `
                 -PropertyType DWord `
                 -Value $valueData `
                 -Force | Out-Null

# 4. Confirm the new setting
$confirmed = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue
if ($null -ne $confirmed) {
    Write-Host ( "NoDriveTypeAutoRun is now set to 0x{0:X2}" -f $confirmed.NoDriveTypeAutoRun )
} else {
    Write-Host "ERROR: Failed to read back NoDriveTypeAutoRun from $regPath"
}
