<#
.SYNOPSIS

Creates a Proofpoint org.

.DESCRIPTION

Adds a new Proofpoint org.

.PARAMETER Domain
Any Domain in org.

.PARAMETER PrimaryDomain
Primary domain for new org.

.PARAMETER Name
Name of new org.

.PARAMETER UserLicense
Number of user licenses.

.PARAMETER LicensePackage
License package to assign, ("Beginner", "Business", "Advanced", "Professional").

.PARAMETER Type
Type of new org, defaults to Organization, ("oem_partner","strategic_partner","channel","organization") 

.PARAMETER Type
Switch Enables trial.

.PARAMETER URL
Website for org
https://www.microsoft.com

.PARAMETER Address
Street Address for org

.PARAMETER Postcode
Postcode for org.

.PARAMETER State
State for org.
https://us3.proofpointessentials.com/api/v1/docs/index.php#valid_values

.PARAMETER Country
Country for org.
https://us3.proofpointessentials.com/api/v1/docs/index.php#valid_values

.PARAMETER Phone
Phone number for org
555-555-5555

.PARAMETER AdminEmail
Email address for Org admin user. This will have the organization admin role.

.PARAMETER TemplateID
ID of template to apply to new org.

.EXAMPLE

PS> New-ProofpointOrg -Domain microsoft.com -Primary Github.com -Name "Github" -UserLicense 10 -LicensePackage "Advanced" -AdminEmail "OrgAdmin@github.com"

#> 


Function New-ProofpointOrg{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
    [Parameter(Mandatory=$true)]
    [string]$Domain,
    [Parameter(Mandatory=$true)]
    [string]$PrimaryDomain,
    [Parameter(Mandatory=$true)]
    [string]$Name,
    [Parameter(Mandatory=$true)][int]$UserLicense,
    [validateset ("Beginner", "Business", "Advanced", "Professional")] $LicensePackage,
    [validateset ("oem_partner","strategic_partner","channel","organization")]$Type ="organization",
    [switch]$Trial,
    [string]$URL,
    [string]$Address,
    [string]$Postcode,
    [string]$State,
    [string]$Country,
    [string]$Phone,
    [Parameter(Mandatory=$true)][string]$AdminEmail,
    [string]$TemplateID
  )
 

  $Body =[ORDERED] @{
    primary_domain= "$($PrimaryDomain)"
    name= "$($Name)"
    is_active= "true"
    type= "organization"
    licensing_package= "$($LicensePackage)"
    is_on_trial= "$(if($Trial){"true"}else{"false"})"
    user_licenses= "$($UserLicense)"
  
    admin_user= @{
      primary_email= "$($AdminEmail)"
      } 
    domains= @(
      @{
        name= "$($PrimaryDomain)"
      }
    )
    account_template_id= "$(if($TemplateID){"$($TemplateID)"}else{"null"})"
  }


  If($URL){
  $Body +=@{www= "$($URL)"}
  }
    
  if($Address){
  $Body += @{address= "$($Address)"}
  $Body += @{postcode= "$($Postcode)"}
  $Body += @{stateprov= "$($State)"}
  $Body += @{country= "$($Country)"}
  }
  
  if($Phone){
  $Body += @{phone= "$($Phone)"}
  }

  $jsonBody = $Body | ConvertTo-Json 

  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/orgs" -Headers $PPheaders -Method Post -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }