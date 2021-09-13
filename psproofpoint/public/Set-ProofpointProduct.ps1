

<#
.SYNOPSIS

Sets Proofpoint Product Options.
.DESCRIPTION

Sets Product Options

.PARAMETER Domain
Any Domain in org.

.PARAMETER Product
Product Name

.PARAMETER Variant
Variant Name

.PARAMETER AutoRenew
Enable/Disable Auto Renew
Deactivate with -AutoRenew:$false

.PARAMETER Trial
Enable/Disable Trial
Deactivate with -Trial:$false

.PARAMETER ExtendTrial
Extends Package Trial
Deactivate with -ExtendTrial:$false


.EXAMPLE

PS> Set-ProofpointPackage -Domain microsoft.com -LicensePackage "Beginner" -Activate:$False

#> 

Function Set-ProofpointProduct{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [Parameter(Mandatory=$true)]
        [string]$Product,
        [string]$Variant,
        [switch]$AutoRenew,
        [switch]$Trial,
        [Switch]$ExtendTrial
         )
         $PSBoundParameters| Out-Null
  $Body = @{
  }  
  
  switch ($PSBoundParameters.keys){

    "Variant" {$Body += @{variant = "$($PSBoundParameters["Variant"])"}}
    "AutoRenew" {$Body += @{auto_renew = "$($PSBoundParameters["AutoRenew"])"}}
    "Trial" {$Body += @{is_on_trial = "$($PSBoundParameters["Trial"])"}}
    "ExtendTrial" {$Body += @{is_trial_extended = "$($PSBoundParameters["ExtendTrial"])"}}
  }


  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/products/$Product" -Headers $PPheaders -Method patch -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }