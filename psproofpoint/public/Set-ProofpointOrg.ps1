Function Set-ProofpointOrg{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [string]$Active
        )
        $PSBoundParameters| Out-Null
  $Body = @{
   }  
  
   switch ($PSBoundParameters.keys){
    "Active" {$Body += @{is_active = "$($PSBoundParameters["AttachmentDefense"])"}}
   }

  $jsonBody = $Body | ConvertTo-Json
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain" -Headers $PPheaders -Method patch -Body $jsonBody -ContentType 'application/json'
  }Catch{
    Write-Output "$_"
  }
  
  }