<#
.SYNOPSIS

Disconnects to the Proofpoint API Endpoint.

.DESCRIPTION

Removes the objects for the Proofpoint API Connection.


.EXAMPLE

PS> Disconnenct-Proofpoint

#>



Function Disconnect-Proofpoint {
Try{
    
    Get-Variable | Where-Object {$_.name -like "PP*"} | Remove-Variable
}Catch{

    Write-Output "$_"
}
}