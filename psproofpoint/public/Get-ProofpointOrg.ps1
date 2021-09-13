<#
.SYNOPSIS

Gets the Proofpoint Org Information.

.DESCRIPTION

Gets the Proofpoint Org Information for specified Domain and/or Children\.

.PARAMETER Domain
Specified Domain in org.

.PARAMETER Children
Flag to get child informationm


.EXAMPLE

PS> Get-ProofpointOrg -Domain microsoft.com

.EXAMPLE

PS> Get-ProofpointOrg -Domain microsoft.com -children

#> 


Function Get-ProofpointOrg{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    [switch]$Children
  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
        $URI = "$PPURI/orgs/$Domain"
        if($Children){$URI = $URI + "/orgs"} 
      $Org = Invoke-RestMethod -Uri $URI  -Headers $PPheaders
      
      
      
      If($Children){
        $Org = $Org.orgs  
         }
      Return $Org
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  