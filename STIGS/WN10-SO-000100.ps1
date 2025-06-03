<#
.SYNOPSIS
   This PowerShell script ensures that the SMB client is configured to always perform packet signing by setting RequireSecuritySignature = 1.

.NOTES
    Author          : Daniel Asare
    LinkedIn        : https://www.linkedin.com/in/danielaasare/
    GitHub          : https://github.com/dasare/dasare
    Date Created    : 2025-06-02
    Last Modified   : 2025-06-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000100

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-SO-000100.ps1 
#>
# -------------------------------------------------------------------
# DISA STIG: WN10-SO-000100 – The Windows SMB client must be configured to always perform SMB packet signing
# -------------------------------------------------------------------

# 1. Define registry path and desired value
$regPath   = 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters'
$valueName = 'RequireSecuritySignature'
$valueData = 1   # 1 = always sign SMB client packets

# 2. Create the LanmanWorkstation\Parameters key if it doesn’t exist
if (-not (Test-Path -Path $regPath)) {
    New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation' `
             -Name 'Parameters' `
             -Force | Out-Null
}

# 3. Create or overwrite the RequireSecuritySignature DWORD to 1
Write-Host "Enabling SMB client packet signing (RequireSecuritySignature = 1)..."
New-ItemProperty -Path $regPath `
                 -Name $valueName `
                 -PropertyType DWord `
                 -Value $valueData `
                 -Force | Out-Null

# 4. Confirm the new setting
$confirmed = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue
if ($null -ne $confirmed) {
    Write-Host ("RequireSecuritySignature is now set to {0}" -f $confirmed.RequireSecuritySignature)
} else {
    Write-Host "ERROR: Failed to create or read back RequireSecuritySignature under $regPath"
}
