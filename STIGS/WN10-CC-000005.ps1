<#
.SYNOPSIS
   This PowerShell script ensures that camera access from the lock screen is disabled.

.NOTES
    Author          : Daniel Asare
    LinkedIn        : https://www.linkedin.com/in/danielaasare/
    GitHub          : https://github.com/dasare/dasare
    Date Created    : 2025-06-02
    Last Modified   : 2025-06-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-CC-000005.ps1 
#>
# -------------------------------------------------------------------
# DISA STIG: WN10-CC-000005 – Camera access from the lock screen must be disabled
# -------------------------------------------------------------------

# 1. Define registry path and desired value
$regPath   = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Camera'
$valueName = 'AllowLockScreen'
$valueData = 0          # 0 = disable camera on lock screen

# 2. Create the Policies\Microsoft\Windows\Camera key if it doesn’t exist
if (-not (Test-Path -Path $regPath)) {
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' `
             -Name 'Camera' `
             -Force | Out-Null
}

# 3. Create or overwrite the AllowLockScreen DWORD to 0
Write-Host "Disabling camera access from the lock screen (AllowLockScreen = 0)..."
New-ItemProperty -Path $regPath `
                 -Name $valueName `
                 -PropertyType DWord `
                 -Value $valueData `
                 -Force | Out-Null

# 4. Confirm the new setting
$confirmed = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue
if ($null -ne $confirmed) {
    Write-Host ( "AllowLockScreen is now set to $($confirmed.AllowLockScreen)" )
} else {
    Write-Host "ERROR: Failed to read back AllowLockScreen from $regPath"
}
