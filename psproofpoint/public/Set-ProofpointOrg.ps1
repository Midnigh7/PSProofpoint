Function Set-ProofpointOrg{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [string]$Active
        )
  
  $Body = @{
   }  
  

$OrgStatus = (Get-ProofpointOrg -domain $Domain).is_active

if($OrgStatus -eq "true"){

$Body =+ @{is_active = "false"}

}else{
    $Body =+ @{is_active = "true"}
}



  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain" -Headers $PPheaders -Method patch -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }