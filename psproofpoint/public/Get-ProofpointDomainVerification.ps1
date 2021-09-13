<#
.SYNOPSIS

Gets the Proofpoint Domain Verification Settings.

.DESCRIPTION

Gets the Proofpoint Domain Verification Settings.

.PARAMETER Domain
Any domain in org.

.PARAMETER TargetDomain
Target domain


.EXAMPLE

PS> Get-ProofpointDomainVerification -Domain microsoft.com -targetdomain contoso.com

#>



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
  
  