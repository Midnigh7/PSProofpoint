Function Get-ProofpointOrg{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    [switch]$Children
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
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
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  