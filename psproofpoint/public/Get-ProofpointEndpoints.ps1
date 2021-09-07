Function Get-ProofpointEndpoints{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$TargetDomain
  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
    
      $Endpoints = Invoke-RestMethod -Uri $PPURI/endpoints/$TargetDomain -Headers $PPheaders
     
      Return $Endpoints
    }Catch{
      Write-Output "$_"
    }
  
  }
  
