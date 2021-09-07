Function Get-ProofpointDomainVerification{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    [Parameter(Mandatory=$true)]$TargetDomain
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{
      $DomainVerificationCode = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/domains/$TargetDomain/verification-code -Headers $PPheaders
     
      Return $DomainVerificationCode
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  