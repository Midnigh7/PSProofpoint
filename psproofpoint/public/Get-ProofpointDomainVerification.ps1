Function Get-ProofpointDomainVerification{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    [Parameter(Mandatory=$true)]$TargetDomain
  )
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
      $DomainVerificationCode = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/domains/$TargetDomain/verification-code -Headers $PPheaders
     
      Return $DomainVerificationCode
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  