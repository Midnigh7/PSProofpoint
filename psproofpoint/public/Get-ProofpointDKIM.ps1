<#
.SYNOPSIS

Gets the Proofpoint DKIM Settings.

.DESCRIPTION

Gets the Proofpoint DKIM Settings for Domain.

.PARAMETER Domain
Any domain in org.

.PARAMETER TargetDomain
Target domain for DKIM Settings

.PARAMETER Selector
Specific Selector 


.EXAMPLE

PS> Get-ProofpointDKIM  -Domain microsoft.com -targetdomain contoso.com


.EXAMPLE

PS> Get-ProofpointDKIM -Domain microsoft.com -targetdomain contoso.com -selector s12345

#>



Function Get-ProofpointDKIM{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    [Parameter(Mandatory=$true)]$TargetDomain,
    $Selector
  )
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
        $URI = "$PPURI/orgs/$Domain/domains/$TargetDomain/dkim"
        if($Selector){$URI = $URI + "/$Selector"}


      $Domain = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Domain
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  