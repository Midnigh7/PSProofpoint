Function Set-ProofpointProduct{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [Parameter(Mandatory=$true)]
        [string]$Product,
        [string]$Variant,
        [switch]$AutoRenew,
        [switch]$Trial,
        [Switch]$ExtendTrial
         )
         $PSBoundParameters| Out-Null
  $Body = @{
  }  
  
  switch ($PSBoundParameters.keys){

    "Variant" {$Body += @{variant = "$($PSBoundParameters["Variant"])"}}
    "AutoRenew" {$Body += @{auto_renew = "$($PSBoundParameters["AutoRenew"])"}}
    "Trial" {$Body += @{is_on_trial = "$($PSBoundParameters["Trial"])"}}
    "ExtendTrial" {$Body += @{is_trial_extended = "$($PSBoundParameters["ExtendTrial"])"}}
  }


  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/products/$Product" -Headers $PPheaders -Method patch -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }