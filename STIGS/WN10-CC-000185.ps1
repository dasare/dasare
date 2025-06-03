<#
.SYNOPSIS
   This PowerShell script ensures that the default Autorun behavior is set to “Do not execute any autorun commands” by creating a NoAutorun = 1 DWORD.

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
    Example syntax:
    PS C:\> .\WN10-CC-000185.ps1 
#>
# -------------------------------------------------------------------
# DISA STIG: WN10-CC-000185 – The default Autorun behavior must be configured to prevent execution of any Autorun commands
# -------------------------------------------------------------------

# 1. Define the registry path and desired value
$regPath   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$valueName = 'NoAutorun'
$valueData = 1    # 1 = Do not execute any autorun commands :contentReference[oaicite:1]{index=1}

# 2. Create the Policies\Explorer key if it doesn’t exist
if (-not (Test-Path -Path $regPath)) {
    New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies' `
             -Name 'Explorer' `
             -Force | Out-Null
}

# 3. Create or overwrite the NoAutorun DWORD to 1
Write-Host "Setting NoAutorun = 1 to prevent any Autorun commands..."
New-ItemProperty -Path $regPath `
                 -Name $valueName `
                 -PropertyType DWord `
                 -Value $valueData `
                 -Force | Out-Null

# 4. Confirm the new setting
$confirmed = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue
if ($null -ne $confirmed) {
    Write-Host ("NoAutorun is now set to {0}" -f $confirmed.NoAutorun)
} else {
    Write-Host "ERROR: Failed to create or read back NoAutorun under $regPath"
}
