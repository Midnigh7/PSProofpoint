<#
.SYNOPSIS

Gets the Proofpoint Stats for doamin.

.DESCRIPTION

Gets the Proofpoint Domain Stats for specified Domain and/or children.

.PARAMETER Domain
Specified Domain in org.

.PARAMETER Children
Flag to get child domain information


.EXAMPLE

PS> Get-ProofpointStats-Domain microsoft.com 

.EXAMPLE

PS> Get-ProofpointStats-Domain microsoft.com -Children
#> 






Function Get-ProofpointStats{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    [switch]$Children

  )
  
  
  if(!($PPheaders)){
  
      Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
        $URI = "$PPURI/stats/$Domain/partner"
        if($Children){$URI = $URI + "/$orgs"}
      $Stats = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Stats
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  