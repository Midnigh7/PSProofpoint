
<#
.SYNOPSIS

Sets Proofpoint Domain Features.
.DESCRIPTION

Sets Domain Verification settings for Proofpoint configured domain.

.PARAMETER Domain
Any Domain in org.

.PARAMETER LicenseCount
Number of licese seats

.PARAMETER LicensePackage
License Package, ("Beginner", "Business", "Advanced", "Professional")

.PARAMETER Trial
Enables/Disables Trial
Disable with -Trial:$False

.PARAMETER BeginnerPlus
Enables/Disables Beginner Plus
Disable with -BeginnerPlus:$False

.EXAMPLE

PS> Set-ProofpointLicense -Domain microsoft.com -LicenseCount 10 -LicensePackage Business -Trial:$False

#> 



Function Set-ProofpointLicensing{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [int]$LicenseCount,
        [validateset ("Beginner", "Business", "Advanced", "Professional")] $LicensePackage,
        [switch]$Trial,
        [switch]$BeginnerPlus
        )
        $PSBoundParameters| Out-Null
  $Body = @{

  }  
  
  switch ($PSBoundParameters.keys){
    "LicenseCount" {$Body += @{license_count = "$($PSBoundParameters["AttachmentDefense"])"}}
    "LicensePackage" {$Body += @{package= "$($PSBoundParameters["LicensePackage"])"}}
    "Trial" {$Body += @{is_on_trial = "$($PSBoundParameters["Trial"])"}}
    "BeginnerPlus" {$Body += @{is_beginner_plus = "$($PSBoundParameters["BeginnerPlus"])"}}
  }

  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/licensing" -Headers $PPheaders -Method put -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }