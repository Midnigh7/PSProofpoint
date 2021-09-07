Function Get-ProofpointAzureSync{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain
  )
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
      $AzureStatus = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/settings/azure -Headers $PPheaders
     
      Return $AzureStatus
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  