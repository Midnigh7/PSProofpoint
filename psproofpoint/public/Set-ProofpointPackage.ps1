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
  }  
 
  switch ($PSBoundParameters.keys){
   "Activate" {$Body += @{is_activated = "$($PSBoundParameters["Activate"])"}}
   "ConfirmEula" {$Body += @{is_eula_confirmed = "$($PSBoundParameters["ConfirmEula"])"}}
   "ExtendTrial" {$Body += @{is_trial_extended = "$($PSBoundParameters["ExtendTrial"])"}}
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