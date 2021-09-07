Function Get-ProofpointStats{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    [switch]$Children

  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
        $URI = "$PPURI/stats/$Domain/partner"
        if($Children){$URI = $URI + "/$orgs"}
      $Stats = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Stats
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  