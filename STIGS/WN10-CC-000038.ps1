<#
.SYNOPSIS
   This PowerShell script ensures that WDigest authentication is disabled by setting UseLogonCredential = 0.

.NOTES
    Author          : Daniel Asare
    LinkedIn        : https://www.linkedin.com/in/danielaasare/
    GitHub          : https://github.com/dasare/dasare
    Date Created    : 2025-06-02
    Last Modified   : 2025-06-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000038

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-CC-000038.ps1 
#>
# -------------------------------------------------------------------
# DISA STIG: WN10-CC-000038 – WDigest Authentication must be disabled
# -------------------------------------------------------------------

# 1. Define registry path and desired value
$regPath   = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest'
$valueName = 'UseLogonCredential'
$valueData = 0   # 0 = disable WDigest

# 2. Create the SecurityProviders\WDigest key if it doesn’t exist
if (-not (Test-Path -Path $regPath)) {
    New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders' `
             -Name 'WDigest' `
             -Force | Out-Null
}

# 3. Create or overwrite the UseLogonCredential DWORD to 0
Write-Host "Disabling WDigest (UseLogonCredential = 0)..."
New-ItemProperty -Path $regPath `
                 -Name $valueName `
                 -PropertyType DWord `
                 -Value $valueData `
                 -Force | Out-Null

# 4. Confirm the new setting
$wdigestVal = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue
if ($null -ne $wdigestVal) {
    Write-Host ("UseLogonCredential is now set to {0}" -f $wdigestVal.UseLogonCredential)
} else {
    Write-Host "ERROR: Failed to create or read back UseLogonCredential under $regPath"
}
