
<#
.SYNOPSIS

Sets Proofpoint Domain Settings.

.DESCRIPTION

Sets Domain settings for Proofpoint configured domain.

.PARAMETER Domain
Any Domain in org.

.PARAMETER TargetDomain
Target Domain

.PARAMETER IsRelay
Enables Relay funcitons

.PARAMETER IsActive
Enables Domain

.PARAMETER Destination
Destination Address for relay
.EXAMPLE

PS> Set-ProofpointDomain -Domain microsoft.com -TargetDomain "Contoso.com" -Relay -Destination "Microsoftdomain.onmicrosoft.com

#> 



Function Set-ProofpointDomain{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [string]$TargetDomain,
        [switch]$IsRelay,
        [Switch]$IsActive,
        [string]$Destination
        )
  
  $Body = @{

  }  
  


  switch ($PSBoundParameters.keys){

    "TargetDomain" {$Body += @{name = "$($PSBoundParameters["TargetDomain"])"}}
    "IsActive" {$Body += @{is_active = "$($PSBoundParameters["IsActive"])"}}
    "IsRelay" {$Body += @{is_relay = "$($PSBoundParameters["IsRelay"])"}}
    "Destination" {$Body += @{destination = "$($PSBoundParameters["Destination"])"}}
  
  }


  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/domains/$TargetDomain" -Headers $PPheaders -Method put -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }