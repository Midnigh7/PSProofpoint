<#
.SYNOPSIS

Gets the Proofpoint User Information for doamin.

.DESCRIPTION

Gets the Proofpoint Users for specified Domain.

.PARAMETER Domain
Specified Domain in org.

.PARAMETER UserEmail
Get Specific User

.EXAMPLE

PS> Get-ProofpointUser -Domain microsoft.com 

.EXAMPLE

PS> Get-ProofpointUser -Domain microsoft.com -UserEmail Bill.Gates@microsoft.com

#> 






Function Get-ProofpointUser{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    $UserEmail
  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint."
      
    }
    try{




        $URI = "$PPURI/orgs/$Domain/users"
        if($UserEmail){$URI = $URI + "/$UserEmail"}
      $Users = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Users.users
    }Catch{
      Write-Output "$_"
    }
  
  }
  
  