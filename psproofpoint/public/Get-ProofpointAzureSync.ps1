Function Get-ProofpointAzureSync{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{
      $AzureStatus = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/settings/azure -Headers $PPheaders
     
      Return $AzureStatus
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  