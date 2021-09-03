Function Get-ProofpointTenant{
  [CmdletBinding()]
Param(
    $Domain,
    $Tenant
)


if(!($PPHeader)){

    Write-Host "Not Connected to Proofpoint." -ForegroundColor Red
    exit
  }
  try{
    $OrgList = Invoke-RestMethod -Uri $PPURI/orgs/$Domain/orgs -Headers $PPheaders
    $TenantOrg = $OrgList.orgs | Where-Object {$_.name -eq "$Tenant"}
    
    Return $TenantOrg
  }Catch{
    Write-host "$_" -ForegroundColor Red
  }

}

