<#
.SYNOPSIS

Removes a Proofpoint Org.

.DESCRIPTION

Removes a Proofpoint Org.

.PARAMETER Domain
Any Domain in org.


.EXAMPLE

PS> Remove-ProofpointOrg -Domain microsoft.com

#> 

Function Remove-ProofpointOrg{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain
        )
  

  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain" -Headers $PPheaders -Method Delete
  }Catch{
    Write-Output "$_"
  }
  
  }