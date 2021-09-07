Function Get-ProofpointDomain{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    $TargetDomain
  )
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
        $URI = "$PPURI/orgs/$Domain/domains"
        if($TargetDomainq){$URI = $URI + "/$TargetDomain"}


      $Domain = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Domain
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  