
<#
.SYNOPSIS

Sets Proofpoint Domain Features.
.DESCRIPTION

Sets Domain Verification settings for Proofpoint configured domain.

.PARAMETER Domain
Any Domain in org.

.PARAMETER AttachmentDefence
Enables/Disables Attachment Defence
Disable with -AttachmentDefence:$False

.PARAMETER SocialMedia
Enables/Disables Social Media Account Protection
Disable with -SocialMedia:$False

.PARAMETER Encryption
Enables/Disables Email Encryption
Disable with -Encryption:$False

.PARAMETER DLP
Enables/Disables  Data Loss Prevention (DLP)
Disable with -DLP:$False

.PARAMETER InstantReplay
Number of daysfor Instant Replay, Defaults to 30.

.PARAMETER EmailArchive
Enables/Disables  Email Archiving
Disable with -EmailArchive:$False

.PARAMETER URLDefense
Enables/Disables URL Defense
Disable with -URLDefense:$False

.PARAMETER Disclaimers
Enables/Disables Email Disclaimers
Disable with -Disclaimers:$False

.PARAMETER SMTPDiscovery
Enables/Disables SMTP Discovery
Disable with SMTPDiscovery:$False

.EXAMPLE

PS> Set-ProofpointFeatures -Domain microsoft.com -DLP:$False -Encryption

#> 

Function Set-ProofpointFeatures{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [switch]$AttachmentDefense,
        [switch]$DLP,
        [switch]$Encryption,
        [Switch]$SocialMedia,
        [switch]$OutboundRelay,
        [string]$InstantReplay,
        [switch]$EmailArchive,
        [switch]$URLDefense,
        [switch]$Disclaimers,
        [switch]$SMTPDiscovery
        )
  
$PSBoundParameters | Out-Null

$Body = [ordered]@{
  
}  

switch ($PSBoundParameters.keys){

  "AttachmentDefense" {$Body += @{attachment_defense = "$($PSBoundParameters["AttachmentDefense"])"}}
  "DLP" {$Body += @{dlp = "$($PSBoundParameters["DLP"])"}}
  "Encryption" {$Body += @{email_encryption = "$($PSBoundParameters["Encryption"])"}}
  "SocialMedia" {$Body += @{social_media_account_protection = "$($PSBoundParameters["SocialMedia"])"}}
  "OutboundRelay" {$Body += @{outbound_relaying = "$($PSBoundParameters["OutboundRelay"])"}}
  "InstantReplay" {$Body += @{instant_replay = "$($PSBoundParameters["InstantReplay"])"}}
  "EmailArchive" {$Body += @{email_archive = "$($PSBoundParameters["EmailArchive"])"}}
  "URLDefense" {$Body += @{url_defense = "$($PSBoundParameters["URLDefense"])"}}
  "Disclaimers" {$Body += @{disclaimers = "$($PSBoundParameters["Disclaimers"])"}}
  "SMTPDiscovery" {$Body += @{smtp_discovery = "$($PSBoundParameters["SMTPDiscovery"])"}}

}




  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  

  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/features" -Headers $PPheaders -Method put -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
      
  }