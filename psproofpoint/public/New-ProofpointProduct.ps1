Function New-ProofpointProduct{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [string]$Name,
        [string]$Variant,
        [switch]$AutoRenew,
        [switch]$Trial
        )
$Body = @{
    label= "$($Name)"
    variant = "$($Variant)"
    auto_renew = "$(if($AutoRenew){"true"}else{"false"})"
    is_trial = "$(if($Trial){"true"}else{"false"})"
    }  
    
    $jsonBody = $Body | ConvertTo-Json 

  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/products" -Headers $PPheaders -Method Post -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }