Function Get-ProofpointDKIM{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    [Parameter(Mandatory=$true)]$TargetDomain,
    $Selector
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{
        $URI = "$PPURI/orgs/$Domain/domains/$TargetDomain/dkim"
        if($Selector){$URI = $URI + "/$Selector"}


      $Domain = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Domain
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  