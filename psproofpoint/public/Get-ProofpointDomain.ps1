<#
.SYNOPSIS

Gets the Proofpoint Domain Settings.

.DESCRIPTION

Gets the Proofpoint Domain Settings.

.PARAMETER Domain
Any domain in org.

.PARAMETER TargetDomain
Target domain


.EXAMPLE

PS> Get-ProofpointDomain -Domain microsoft.com 


.EXAMPLE

PS> Get-ProofpointDomain -Domain microsoft.com -targetdomain contoso.com

#>






Function Get-ProofpointDomain{
    [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]$Domain,
    $TargetDomain
  )
  
  
  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
      
    }
    try{
        $URI = "$PPURI/orgs/$Domain/domains"
        if($TargetDomainq){$URI = $URI + "/$TargetDomain"}


      $Domain = Invoke-RestMethod -Uri $URI -Headers $PPheaders
     
      Return $Domain
    }Catch{
      Write-Output "$_" 
    }
  
  }
  
  