<#
.SYNOPSIS

Gets the Proofpoint Domain Features.

.DESCRIPTION

Gets the Proofpoint Features for specified domain.

.PARAMETER Domain
Specified Domain for endpoint.

.EXAMPLE

PS> Get-ProofpointFeatures -Domain microsoft.com

#>





Function Get-ProofpointFeatures{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain
  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint."
      
    }
    try{


      $Features = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/features -Headers $PPheaders
     
      Return $Features
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  