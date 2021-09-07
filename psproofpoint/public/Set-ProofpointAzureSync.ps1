Function Set-ProofpointAzureSync{
  [CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]$Domain,
    [Parameter(Mandatory=$true)]
    [string]$AppID,
    [Parameter(Mandatory=$true)][string]$AppPW,
    [switch]$DisableLogin,
    [ValidateSet ("silent_User","end_user")] $UserRole = "end_user",
    [int]$SyncHours = "1",
    [ValidateSet ("Active Users", "Distribution Groups", "Security Groups")][array]$SyncObjects,
    [switch]$AddUsers,
    [switch]$UpdateUsers,
    [switch]$RemoveDeletedUsers,
    [switch]$AddGroups,
    [switch]$UpdateGroups,
    [switch]$RemoveDeletedGroups
)

$Body = @"
{
  "primary_domain": "$($Domain)",
  "application_id": "$($azureAppId)",
  "ad_key": "$($AppPW)",
  "disable_login": $(if($DisableLogin){"true"}else{"false"}),
  "default_user_role_name": "$($UserRole)",
  "sync_frequency": $($SyncHours),
  "sync_active_users": $(if("Active Users" -in $SyncObjects){"true"}else{"false"}),
  "sync_distribution_groups": $(if("Distribution Groups" -in $SyncObjects){"true"}else{"false"}),
  "sync_security_groups": $(if("Security Groups" -in $SyncObjects){"true"}else{"false"}),
  "add_users": $(if($AddUsers){"true"}else{"false"}),
  "update_users": $(if($UpdateUsers){"true"}else{"false"}),
  "remove_deleted_users": $(if($RemoveDeletedUsers){"true"}else{"false"}),
  "add_groups": $(if($AddGroups){"true"}else{"false"}),
  "update_groups": $(if($UpdateGroups){"true"}else{"false"}),
  "remove_deleted_groups": $(if($RemoveDeletedGroups){"true"}else{"false"})
}
"@

if(!($PPheaders)){

  Write-Error "Not Connected to Proofpoint." 
 
}




try{
Invoke-RestMethod -Uri "$BaseURI/$Domain/settings/azure" -Headers $Headers -Method Put -Body $Body
}Catch{
  Write-Output "$_"
}

}