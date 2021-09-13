<#
.SYNOPSIS

Created a Proofpoint Domain for org.

.DESCRIPTION

Adds a new domain to the Proofpoint org.

.PARAMETER Domain
Any Domain in org.

.PARAMETER TargetDomain
Get Specific User

.PARAMETER Destination
Sets relay destination

.PARAMETER IsRelay
Enables domain to relay

.PARAMETER IsActive
Enables Domain

.EXAMPLE

PS> New-ProofpointDomain -Domain microsoft.com -TargetDomain Contoso.com -IsRelay -Destination MicrosoftDomain.onmicrosoft.com

#> 







Function New-ProofpointDomain{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [string]$TargetDomain,
        [switch]$IsRelay,
        [Switch]$IsActive,
        [string]$Destination
        )
  
  $Body = @{
    name= "$($TargetDomain)"
    is_active = "$(if($IsActive){"true"}else{"false"})"
    is_relay = "$(if($IsRelay){"true"}else{"false"})"
    destination = "$(if($Destination){"true"}else{"false"})"
  }  
  
  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/domains" -Headers $PPheaders -Method post -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }