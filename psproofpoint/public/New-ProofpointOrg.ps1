Function New-ProofpointOrg{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
      [Parameter(Mandatory=$true)]
      [string]$Domain,
      [Parameter(Mandatory=$true)]
      [string]$Name,
      [Parameter(Mandatory=$true)][int]$UserLicense,
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
    "primary_domain": "mydomain.com",
    "name": "My Company Inc.",
    "is_active": true,
    "type": "organization",
    "eid": 123456,
    "organization_hierarchy": [
      "123456 : 'My Company Inc.'",
      "1234 : 'My parent Org'",
      "4567 : 'My parent's parent Org'"
    ],
    "licensing_package": "professional",
    "is_on_trial": false,
    "user_licenses": 100,
    "active_users": 75,
    "when_renewal": "2018/01/15",
    "is_beginner_plus": false,
    "is_beginner_plus_enabled": false,
    "www": "https://www.mydomain.com",
    "address": "123 Forest Road, Townsville",
    "postcode": "12345",
    "stateprov": "CA",
    "country": "US",
    "phone": "555-123-456",
    "admin_user": {
      "uid": 123456,
      "primary_email": "john.smith@mydomain.com",
      "is_active": true,
      "type": "organization_admin",
      "send_welcome_email": false,
      "firstname": "John",
      "surname": "Smith",
      "alias_emails": [
        "john@mydomain.com",
        "jsmith@mydomain.com"
      ],
      "safe_list_senders": [
        "jane@gooddomain.com",
        "bill@anothergooddomain.com"
      ],
      "block_list_senders": [
        "bob@baddomain.com",
        "orders@anotherbaddomain.com"
      ],
      "is_billable": true,
      "odin_settings": {
        "can_impersonate": false,
        "is_imitable": false
      },
      "read_only_user": false
    },
    "domains": [
      {
        "name": "mydomain.com",
        "is_active": false,
        "is_relay": false,
        "destination": "10.20.30.40",
        "failovers": [
          "10.30.40.50",
          "10.40.50.60"
        ]
      }
    ],
    "outgoing_servers": [
      "10.20.30.40",
      "10.30.40.50"
    ],
    "safe_list_senders": [
      "jane@gooddomain.com",
      "bill@anothergooddomain.com"
    ],
    "block_list_senders": [
      "bob@baddomain.com",
      "orders@anotherbaddomain.com"
    ],
    "ldap_url": "",
    "ldap_username": "",
    "ldap_basedn": "",
    "is_smtp_discovery_enabled": true,
    "account_template_id": null,
    "send_welcome_email": false,
    "odin_capabilities": "none",
    "billing_method": "Annual"
  }
"@
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$BaseURI/$Domain/orgs" -Headers $Headers -Method Put -Body $Body
  }Catch{
    Write-Output "$_"
  }
  
  }