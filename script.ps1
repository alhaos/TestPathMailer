using assembly .\lib\System.Data.SQLite.dll 

using module .\classes\DatabaseManager.psm1
using module .\classes\СheckingResult.psm1

Set-StrictMode -Version 'latest'

$Global:conf = Import-PowerShellDataFile .\conf.psd1

$DatabaseManager = [DatabaseManager]::new()

foreach ($target in $Global:conf.MonitoredPath) {

    $LastResult = $DatabaseManager.GetLast($target.Path)
    $LastResult
    $CurrentResult = [СheckingResult]::new($target.Path)
    if ($LastResult.Result -eq $true -and $CurrentResult.Result -eq $false){

    }
    $DatabaseManager.Push($CurrentResult)
}


