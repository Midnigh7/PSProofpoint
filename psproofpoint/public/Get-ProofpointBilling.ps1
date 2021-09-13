<#
.SYNOPSIS

Gets the Proofpoint Billing Settings.

.DESCRIPTION

Gets the Proofpoint Billing Settings for Domains and Child Companies.

.PARAMETER Domain
Target Domain 

.PARAMETER Children
Gets Child objects

.EXAMPLE

PS> Get-ProofpointBilling -Domain microsoft.com


.EXAMPLE

PS> Get-ProofpointBilling -Domain microsoft.com -Children

#>



Function Get-ProofpointBilling{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
      [switch]$Children
  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{

        $URI = "$PPURI/billing/$Domain/"
        if($Children){ $URI = $URI + "/orgs" }

      $Billing = Invoke-RestMethod -Uri $URI -Headers $PPheaders

      
      Return $Billing
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  