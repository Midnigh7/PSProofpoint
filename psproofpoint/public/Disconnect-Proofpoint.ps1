Function Disconnect-Proofpoint {
Try{
    
    Get-Variable | Where-Object {$_.name -like "PP*"} | Remove-Variable
}Catch{

    Write-Output "$_"
}
}