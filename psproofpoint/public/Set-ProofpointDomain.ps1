Function Set-ProofpointDomain{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [string]$TargetDomain,
        [switch]$IsRelay,
        [Switch]$IsActive,
        [string]$Destination
        )
  
  $Body = @{
    name= "$($TargetDomain)"
    is_active = "$(if($IsActive){"true"}else{"false"})"
    is_relay = "$(if($IsRelay){"true"}else{"false"})"
    destination = "$(if($Destination){"true"}else{"false"})"
  }  
  
  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/domains/$TargetDomain" -Headers $PPheaders -Method put -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }