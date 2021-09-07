Function Get-ProofpointProducts{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    $Product
  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint."
      
    }
    try{


      $Products = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/products -Headers $PPheaders
     
      Return $Products
    }Catch{
      Write-Output "$_"
    }
  
  }
  
  