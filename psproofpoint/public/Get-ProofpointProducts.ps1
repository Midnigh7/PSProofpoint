Function Get-ProofpointProducts{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{


      $Products = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/products -Headers $PPheaders
     
      Return $Products
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  