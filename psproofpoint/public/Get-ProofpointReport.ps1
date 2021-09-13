<#
.SYNOPSIS

Gets the Proofpoint Report for doamin.

.DESCRIPTION

Gets the Proofpoint Domain Report for specified Domain.

.PARAMETER Domain
Specified Domain in org.

.PARAMETER Period
Daily/Weekly/Monthly

.PARAMETER Direction
Can scope to Inbound or Outbound

.EXAMPLE

PS> Get-ProofpointReport -Domain microsoft.com -Period Weekly

.EXAMPLE

PS> Get-ProofpointReport -Domain microsoft.com -Period Weekly -Direction Inbound

#> 





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
  
  