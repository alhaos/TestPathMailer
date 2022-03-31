using module .\classes\DatabaseManager.psm1
using module .\classes\СheckingResult.psm1

$Global:conf = Import-PowerShellDataFile .\conf.psd1

foreach ($target in $Global:conf.Monitored) {
    [СheckingResult]::new($target.Path)
}