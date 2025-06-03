<#
.SYNOPSIS
   This PowerShell script ensures that FIPS-compliant algorithms for encryption, hashing, and signing are enforced by enabling the FIPS algorithm policy.(Enabled = 1)

.NOTES
    Author          : Daniel Asare
    LinkedIn        : https://www.linkedin.com/in/danielaasare/
    GitHub          : https://github.com/dasare/dasare
    Date Created    : 2025-06-02
    Last Modified   : 2025-06-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000230

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\WN10-SO-000230.ps1 
#>
# -------------------------------------------------------------------
# DISA STIG: WN10-SO-000230 – The system must be configured to use FIPS-compliant algorithms for encryption, hashing, and signing
# -------------------------------------------------------------------

# 1. Define registry path and desired value
$regPath   = 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\FipsAlgorithmPolicy'
$valueName = 'Enabled'
$valueData = 1   # 1 = enable FIPS algorithm policy

# 2. Create the Lsa\FipsAlgorithmPolicy key if it doesn’t exist
if (-not (Test-Path -Path $regPath)) {
    New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' `
             -Name 'FipsAlgorithmPolicy' `
             -Force | Out-Null
}

# 3. Create or overwrite the Enabled DWORD to 1
Write-Host "Enabling FIPS-compliant algorithms (Enabled = 1)..."
New-ItemProperty -Path $regPath `
                 -Name $valueName `
                 -PropertyType DWord `
                 -Value $valueData `
                 -Force | Out-Null

# 4. Confirm the new setting
$confirmed = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue
if ($null -ne $confirmed) {
    Write-Host ("Enabled is now set to {0}" -f $confirmed.Enabled)
} else {
    Write-Host "ERROR: Failed to create or read back Enabled under $regPath"
}
