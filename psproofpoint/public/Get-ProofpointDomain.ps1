Function Get-ProofpointDomain{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    $TargetDomain
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{
        $URI = "$PPURI/orgs/$Domain/domains"
        if($TargetDomainq){$URI = $URI + "/$TargetDomain"}


      $Domain = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Domain
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  