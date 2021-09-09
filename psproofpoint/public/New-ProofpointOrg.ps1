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