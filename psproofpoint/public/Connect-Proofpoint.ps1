Function Connect-Proofpoint{
    [CmdletBinding()]
param(
        [ValidateSet ("us1","us2","us3","us4","us5","eu1")]$PPRegion,
        [SecureString] $Creds = (Get-Credential)
)
    
#$Creds = Get-Credential
$Script:PPheaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$Script:PPheaders.Add("X-User",($Creds).UserName)
$Script:PPheaders.Add("X-Password",($Creds.GetNetworkCredential()).Password)
$Script:PPURI = "https://$PPRegion.proofpointessentials.com/api/v1"
try{
$Connect = Invoke-RestMethod -Headers $Global:PPheaders -Uri $PPURI/me -Method Get
}catch{

 Write-host "$_" -ForegroundColor Red
 Get-Variable | Where-Object {$_.name -like "PP*"} | Remove-Variable
}
If ($Connect){
    Write-Host -ForegroundColor Green "Connected to $PPURI"
}
}