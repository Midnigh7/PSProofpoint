Function Get-ProofpointEndpoints{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$TargetDomain
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{
    
      $Endpoints = Invoke-RestMethod -Uri $PPURI/endpoints/$TargetDomain -Headers $PPheaders
     
      Return $Endpoints
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
