Function Set-ProofpointAzureSync{
  [CmdletBinding(SupportsShouldProcess = $true)]
Param(
    [Parameter(Mandatory=$true)]
    [string]$Domain,
    [Parameter(Mandatory=$true)]
    [string]$AppID,
    [Parameter(Mandatory=$true)][string]$AppPW,
    [switch]$DisableLogin,
    [ValidateSet ("silent_User","end_user")] $UserRole = "end_user",
    [int]$SyncHours = "1",
    [switch]$SyncActiveUsers,
    [switch]$SyncDistGroups,
    [switch]$SyncSecGroups,
    [switch]$AddUsers,
    [switch]$UpdateUsers,
    [switch]$RemoveDeletedUsers,
    [switch]$AddGroups,
    [switch]$UpdateGroups,
    [switch]$RemoveDeletedGroups
)

$Body = @{
  primary_domain= "$($Domain)"
  application_id= "$($azureAppId)"
  ad_key= "$($AppPW)"
  disable_login= $(if($DisableLogin){"true"}else{"false"})
  default_user_role_name= "$($UserRole)"
  sync_frequency= $($SyncHours)
  sync_active_users= $(if($SyncActiveUsers){"true"}else{"false"})
  sync_distribution_groups= $(if($SyncDistGroups){"true"}else{"false"})
  sync_security_groups= $(if($SyncSecGroups){"true"}else{"false"})
  add_users= $(if($AddUsers){"true"}else{"false"})
  update_users= $(if($UpdateUsers){"true"}else{"false"})
  remove_deleted_users= $(if($RemoveDeletedUsers){"true"}else{"false"})
  add_groups= $(if($AddGroups){"true"}else{"false"})
  update_groups= $(if($UpdateGroups){"true"}else{"false"})
  remove_deleted_groups= $(if($RemoveDeletedGroups){"true"}else{"false"})
}

$jsonBody = $Body | ConvertTo-Json


if(!($PPheaders)){

  Write-Error "Not Connected to Proofpoint." 
 
}




try{
Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/settings/azure" -Headers $PPheaders -Method Put -Body $jsonBody -ContentType 'application/json'
}Catch{
  Write-Output "$_"
}

}