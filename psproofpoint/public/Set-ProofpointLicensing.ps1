Function Set-ProofpointLicensing{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [int]$LicenseCount,
        [validateset ("Beginner", "Business", "Advanced", "Professional")] $LicensePackage,
        [switch]$Trial,
        [switch]$BeginnerPlus
        )
  
  $Body = @{

  }  
  
if($LicenseCount){
$Body =+ @{license_count = "$($LicenseCount)"}
}
if($LicensePackage){
    $Body =+ @{package = "$($LicensePackage)"}
    }


if($Trial){

        $TrialStatus = (Get-ProofpointLicensing -Domain $Domain).is_on_trial

        If($TrialStatus -eq "false"){
    $Body =+ @{is_on_trial = "true"}
    }else{
        $Body =+ @{is_on_trial = "false"} 
    }
}

if($BeginnerPlus){

    $BeginnerStatus = (Get-ProofpointLicensing -Domain $Domain).is_beginner_plus
    if($BeginnerStatus -eq "false"){
    $Body =+ @{is_beginner_plus = "true"}
    }else{
        $Body =+ @{is_beginner_plus = "false"}
    }

    }



  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/licensing" -Headers $PPheaders -Method put -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }