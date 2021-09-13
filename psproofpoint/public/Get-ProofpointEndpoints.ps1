<#
.SYNOPSIS

Gets the Proofpoint Domain Endpoint.

.DESCRIPTION

Gets the Proofpoint Endpoint for specified domain.

.PARAMETER Domain
Specified Domain for endpoint.

.EXAMPLE

PS> Get-ProofpointEndpoints -Domain microsoft.com

#>




Function Get-ProofpointEndpoints{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain
  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
    
      $Endpoints = Invoke-RestMethod -Uri $PPURI/endpoints/$Domain -Headers $PPheaders
     
      Return $Endpoints
    }Catch{
      Write-Output "$_"
    }
  
  }
  
