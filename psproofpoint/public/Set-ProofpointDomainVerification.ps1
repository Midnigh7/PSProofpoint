
<#
.SYNOPSIS

Sets Proofpoint Domain Verification Settings.

.DESCRIPTION

Sets Domain Verification settings for Proofpoint configured domain.

.PARAMETER Domain
Any Domain in org.

.PARAMETER TargetDomain
Target Domain

.PARAMETER Method
Sets method of verification, ("TXT", "META")

.EXAMPLE

PS> Set-ProofpointDomainVerification -Domain microsoft.com -TargetDomain "Contoso.com" -Method TXT

#> 

Function Set-ProofpointDomainVerification{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
    [Parameter(Mandatory=$true)] $Domain,
    [Parameter(Mandatory=$true)]$TargetDomain,
    [Parameter(Mandatory=$true)][validateset ("TXT", "META")]$Method
  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint."
      
    }
    try{


      $Validate = Invoke-RestMethod -Uri $PPURI/orgs/$domain/domains/$TargetDomain/verify/$Method -Headers $PPheaders -Method Put

      
      Return $Validate
    }Catch{
      Write-Output "$_"
    }
  
  }
  
  