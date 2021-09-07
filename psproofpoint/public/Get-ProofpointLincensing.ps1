Function Get-ProofpointLicensing{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain
  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint."
      
    }
    try{
    
      $License = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/licensing -Headers $PPheaders
     
      Return $License
    }Catch{
      Write-Output "$_"
    }
  
  }
  
