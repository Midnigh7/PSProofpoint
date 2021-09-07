Function Get-ProofpointBilling{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
      [switch]$Orgs
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{

        $URI = "$PPURI/billing/$Domain/"
        if($Orgs){ $URI = $URI + "/orgs" }

      $PPBilling = Invoke-RestMethod -Uri $URI -Headers $PPheaders

      
      Return $PPBilling
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  