Function Set-ProofpointDomainVerification{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)] $Domain,
    [Parameter(Mandatory=$true)]$TargetDomain,
    [Parameter(Mandatory=$true)][validateset ("TXT", "META")]$Method
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{


      $Validate = Invoke-RestMethod -Uri $PPURI/orgs/$domain/domains/$TargetDomain/verify/$Method -Headers $PPheaders -Method Put

      
      Return $Validate
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  