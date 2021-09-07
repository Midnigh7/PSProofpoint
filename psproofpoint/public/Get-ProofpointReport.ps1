Function Get-ProofpointReport{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    [Parameter(Mandatory=$true)][validateset ("Daily","Weekly","Monthly")]$Period,
    [validateset ("inbound","outbound")]$Direction

  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
        $URI = "$PPURI/reporting/$Domain/$Period"
        if($Direction){$URI = $URI + "/$Direction"}
      $Report = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Report
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  