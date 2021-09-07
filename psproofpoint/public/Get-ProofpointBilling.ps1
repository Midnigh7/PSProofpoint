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
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  