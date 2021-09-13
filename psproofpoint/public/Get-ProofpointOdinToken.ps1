<#
.SYNOPSIS

Gets the Proofpoint Odin Token for User.

.DESCRIPTION

Gets the Proofpoint Odin token for specified User for impersionation.

.PARAMETER Domain
Specified Domain for endpoint.

.PARAMETER UserEmail
Specified Domain for endpoint.


.EXAMPLE

PS> Get-ProofpointOdinToken -Domain microsoft.com -UserEmail Bill.Gates@microsoft.com

#>







Function Get-ProofpointOdinToken{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [Parameter(Mandatory=$true)]
        [string]$UserEmail
        )
  
  $Body = @{
    user_to_impersonate= "$($UserEmail)"

  }  
  
  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/token/$Domain" -Headers $PPheaders -Method post -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }