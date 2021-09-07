Function Get-ProofpointFeatures{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{


      $Features = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/features -Headers $PPheaders
     
      Return $Features
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  