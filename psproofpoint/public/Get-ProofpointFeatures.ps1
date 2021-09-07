Function Get-ProofpointFeatures{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain
  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint."
      
    }
    try{


      $Features = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/features -Headers $PPheaders
     
      Return $Features
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  