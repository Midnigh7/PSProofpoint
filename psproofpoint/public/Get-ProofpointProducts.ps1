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
  
  