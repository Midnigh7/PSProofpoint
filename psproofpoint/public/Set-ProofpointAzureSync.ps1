<#
.SYNOPSIS

Sets Proofpoint Azure AD Syncing.

.DESCRIPTION

Sets org Azure AD Syncing.

.PARAMETER Domain
Any Domain in org.

.PARAMETER AppID
Azure AppID 

.PARAMETER AppPW
Azure Application Password 

.PARAMETER DisableLogin
Switch to disable login

.PARAMETER UserRole
User role to sync users, ("silent_User","end_user")

.PARAMETER SyncHours
Number of hours to sync

.PARAMETER SyncActiveUsers
Switch to Sync Active User Accounts

.PARAMETER SyncDistGroups
Switch to Sync Distribution Groups

.PARAMETER SyncSecGroups
Switch to Sync Security Groups

.PARAMETER AddUser
Switch to Add new users

.PARAMETER UpdateUsers
Switch to Update Users

.PARAMETER RemoveDeletedUsers
Switch to remove users that have been deleted

.PARAMETER AddGroups
Switch to Add new groups

.PARAMETER UpdateGroups
Switch to Update groups

.PARAMETER RemoveDeletedGroups
Switch to remove groups that have been deleted


.EXAMPLE

PS> Set-ProofpointAzureSync -Domain microsoft.com -AppID $AppID -AppPW $AppPassword -UserRole "end-user" -SyncActiveUsers -SyncDistGroups -SyncSecGroups -AddUsers -UpdateUsers -RemoveDeletedUsers -Addgroups -UpdateGroups -RemoveDeletedGroups

#> 

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