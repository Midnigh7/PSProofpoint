<#
.SYNOPSIS

Connects to the Proofpoint API Endpoint specified in $Region variable.

.DESCRIPTION

Connects to the Proofpoint API Endpoint specified in $Region variable.


.PARAMETER Region
Specifies the region to connect to "us1","us2","us3","us4","us5","eu1"

.PARAMETER Credential
Specifies the credentials used.


.EXAMPLE

PS> Connect-Proofpoint -Region US3 -Credential $ProofpointCred

#>



Function Connect-Proofpoint{
    [CmdletBinding()]
param(
    [Parameter(Mandatory=$true)] [ValidateSet ("us1","us2","us3","us4","us5","eu1")]$Region,
        [System.Management.Automation.PSCredential] $Credential = (Get-Credential)
)

if(!$Credential){
$Credential = Get-Credential
}

$Script:PPheaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$Script:PPheaders.Add("X-User",($Credential).UserName)
$Script:PPheaders.Add("X-Password",($Credential.GetNetworkCredential()).Password)
$Script:PPURI = "https://$Region.proofpointessentials.com/api/v1"
try{
$Connect = Invoke-RestMethod -Headers $Script:PPheaders -Uri $PPURI/me -Method Get
}catch{

    Write-Output "$_"
 Get-Variable | Where-Object {$_.name -like "PP*"} | Remove-Variable -ErrorAction Ignore
}
If ($Connect){
    Write-Output "Connected to $PPURI"
}
}
