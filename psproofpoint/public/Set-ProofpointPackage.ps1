
<#
.SYNOPSIS

Sets Proofpoint Package Options.
.DESCRIPTION

Sets Package Options

.PARAMETER Domain
Any Domain in org.

.PARAMETER LicensePackage
("Beginner", "Business", "Advanced", "Professional")

.PARAMETER Activate
Activates Package
Deactivate with -Activate:$false
.PARAMETER ConfirmEULA

Confirms EULA
Deactivate with -ConfirmEULA:$false

.PARAMETER ExtendTrial
Extends Package Trial
Deactivate with -ExtendTrial:$false


.EXAMPLE

PS> Set-ProofpointPackage -Domain microsoft.com -LicensePackage "Beginner" -Activate:$False

#> 

Function Set-ProofpointPackage{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [validateset ("Beginner", "Business", "Advanced", "Professional")] $LicensePackage,
        [switch]$Activate,
        [Switch]$ConfirmEula,
        [string]$ExtendTrial
        )
        $PSBoundParameters| Out-Null
  $Body = @{
  }  
 
  switch ($PSBoundParameters.keys){
   "LicensePackage" {$Body += @{package = "$($PSBoundParameters["LicensePackage"])"}}
   "Activate" {$Body += @{is_activated = "$($PSBoundParameters["Activate"])"}}
   "ConfirmEula" {$Body += @{is_eula_confirmed = "$($PSBoundParameters["ConfirmEula"])"}}
   "ExtendTrial" {$Body += @{is_trial_extended = "$($PSBoundParameters["ExtendTrial"])"}}
  }


  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/package" -Headers $PPheaders -Method put -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }