Function Get-ProofpointLicensing{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{
    
      $License = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/licensing -Headers $PPheaders
     
      Return $License
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
