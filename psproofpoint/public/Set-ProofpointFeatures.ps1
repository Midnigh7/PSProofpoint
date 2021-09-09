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
        [switch]$SMTPDiscovery,
        [switch]$test
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