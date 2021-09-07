Function Get-ProofpointUser{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    $UserEmail
  )
  
  
  if(!($PPheaders)){
  
      Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
      
    }
    try{




        $URI = "$PPURI/orgs/$Domain/users"
        if($UserEmail){$URI = $URI + "/$UserEmail"}
      $Users = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Users.users
    }Catch{
      Write-host "$_" -ForegroundColor Red
    }
  
  }
  
  