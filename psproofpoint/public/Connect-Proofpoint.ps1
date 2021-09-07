Function Connect-Proofpoint{
    [CmdletBinding()]
param(
        [ValidateSet ("us1","us2","us3","us4","us5","eu1")]$PPRegion,
        [System.Management.Automation.PSCredential] $Credential = (Get-Credential)
)

if(!$Credential){
$Credential = Get-Credential
}

$Script:PPheaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$Script:PPheaders.Add("X-User",($Credential).UserName)
$Script:PPheaders.Add("X-Password",($Credential.GetNetworkCredential()).Password)
$Script:PPURI = "https://$PPRegion.proofpointessentials.com/api/v1"
try{
$Connect = Invoke-RestMethod -Headers $Script:PPheaders -Uri $PPURI/me -Method Get
}catch{

 Write-host "$_" -ForegroundColor Red
 Get-Variable | Where-Object {$_.name -like "PP*"} | Remove-Variable -ErrorAction Ignore
}
If ($Connect){
    Write-Host -ForegroundColor Green "Connected to $PPURI"
}
}
