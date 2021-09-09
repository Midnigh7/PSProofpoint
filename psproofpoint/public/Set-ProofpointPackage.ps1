Function Set-ProofpointPackage{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [validateset ("Beginner", "Business", "Advanced", "Professional")] $LicensePackage,
        [switch]$Activate,
        [Switch]$ConfirmEula,
        [string]$ExtendTrial
        )
  
  $Body = @{
    package= "$($LicensePackage)"
    is_activated = "$(if($Activate){"true"}else{"false"})"
    is_eula_confirmed = "$(if($ConfirmEula){"true"}else{"false"})"
    is_trial_extended = "$(if($ExtendTrial){"true"}else{"false"})"
  }  
  
  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/package" -Headers $PPheaders -Method put -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }