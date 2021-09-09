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
        [int]$InstantReplay = 30,
        [switch]$EmailArchive,
        [switch]$URLDefense,
        [switch]$Disclaimers,
        [switch]$SMTPDiscovery
        )
  
  $Body = @{
    attachment_defense = "$(if($AttachmentDefense){"true"}else{"false"})"
    dlp = "$(if($DLP){"true"}else{"false"})"
    email_encryption = "$(if($Encryption){"true"}else{"false"})"
    social_media_account_protection = "$(if($SocialMedia){"true"}else{"false"})"
    outbound_relaying = "$(if($OutboundRelay){"true"}else{"false"})"
    instant_replay = "$($InstantReplay)"
    email_archive = "$(if($EmailArchive){"true"}else{"false"})"
    url_defense = "$(if($URLDefense){"true"}else{"false"})"
    disclaimers = "$(if($Disclaimers){"true"}else{"false"})"
    smtp_discovery = "$(if($SMTPDiscovery){"true"}else{"false"})"
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