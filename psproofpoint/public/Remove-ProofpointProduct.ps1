<#
.SYNOPSIS

Removes a Proofpoint Product.

.DESCRIPTION

Removes a Proofpoint Product from org.

.PARAMETER Domain
Any Domain in org.

.PARAMETER Product
Product to remove


.EXAMPLE

PS> Remove-ProofpointProduct -Domain microsoft.com -Product "Email_Security"

#> 


Function Remove-ProofpointProduct{
    [CmdletBinding(SupportsShouldProcess = $true)]
  Param(
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [Parameter(Mandatory=$true)] 
        [string]$Product
        )
  

  if(!($PPheaders)){
  
    Write-Error "Not Connected to Proofpoint." 
   
  }
  
  
  
  
  try{
  Invoke-RestMethod -Uri "$PPURI/orgs/$Domain/products/$Product" -Headers $PPheaders -Method Delete
  }Catch{
    Write-Output "$_"
  }
  
  }