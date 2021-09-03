param(
        [ValidateSet ("us1","us2","us3","us4","us5","eu1")]$PPRegion,
        $Creds = (Get-Credential)
)
    
#$Creds = Get-Credential
$Global:PPheaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$Global:PPheaders.Add("X-User",($Creds).UserName)
$Global:PPheaders.Add("X-Password",($Creds.GetNetworkCredential()).Password)
$Global:PPURI = "https://$PPRegion.proofpointessentials.com/api/v1"
try{
$Connect = Invoke-RestMethod -Headers $Global:PPheaders -Uri $PPURI/me -Method Get
}catch{

 Write-host "$_" -ForegroundColor Red
 Get-Variable | Where-Object {$_.name -like "PP*"} | Remove-Variable
}
If ($Connect){
    Write-Host -ForegroundColor Green "Connected to $PPURI"
}