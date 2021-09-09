Function Remove-ProofpointDomain{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [string]$TargetDomain
        )
  

  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/domains/$TargetDomain" -Headers $PPheaders -Method Delete
  }Catch{
    Write-Output "$_"
  }
  
  }