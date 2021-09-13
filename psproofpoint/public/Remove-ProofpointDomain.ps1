<#
.SYNOPSIS

Removes a Proofpoint Domain.

.DESCRIPTION

Removes a Proofpoint Domain.

.PARAMETER Domain
Any Domain in org.

.PARAMETER TargetDomain
Domain to remove


.EXAMPLE

PS> Remove-ProofpointDomain -Domain microsoft.com -TargetDomain Contoso.com

#> 

Function Remove-ProofpointDomain{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [string]$TargetDomain
        )
  

  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/domains/$TargetDomain" -Headers $PPheaders -Method Delete
  }Catch{
    Write-Output "$_"
  }
  
  }