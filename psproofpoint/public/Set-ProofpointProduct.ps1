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
  
  $Body = @{
    variant= "$($Variant)"
  }  
  

  if($Trial){
    $TrialStatus = (Get-ProofpointProduct -Domain $Domain -Product $Product).is_on_trial

    If($TrialStatus -eq "false"){
$Body =+ @{is_on_trial = "true"}
}else{
    $Body =+ @{is_on_trial = "false"} 
}
}


if($AutoRenew){
    $AutoRenewStatus = (Get-ProofpointProduct -Domain $Domain -Product $Product).auto_renew

    If($AutoRenewStatus -eq "false"){
$Body =+ @{is_on_trial = "true"}
}else{
    $Body =+ @{is_on_trial = "false"} 
}
}


If($ExtendTrial){
    $Body =+ @{is_trial_extended = "true"}

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