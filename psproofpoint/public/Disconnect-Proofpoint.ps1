Try{
    
    Get-Variable | Where-Object {$_.name -like "PP*"} | Remove-Variable
}Catch{

    Write-host "$_" -ForegroundColor Red
}