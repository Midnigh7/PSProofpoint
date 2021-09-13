<#
.SYNOPSIS

Gets the Proofpoint Product Information.

.DESCRIPTION

Gets the Proofpoint Product Information for specified Domain and/or specific Product.

.PARAMETER Domain
Specified Domain in org.

.PARAMETER Product
Specific Product


.EXAMPLE

PS> Get-ProofpointProduct -Domain microsoft.com

.EXAMPLE

PS> Get-ProofpointProduct -Domain microsoft.com -Product Product1

#> 




Function Get-ProofpointProducts{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    $Product
  )
  
  $URI = "$PPURI/orgs/$Domain/products"
  if($Products){
    $URI = $URI + "/$Product"
  }
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint."
      
    }
    try{


      $Products = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Products
    }Catch{
      Write-Output "$_"
    }
  
  }
  
  