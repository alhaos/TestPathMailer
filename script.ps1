using assembly .\lib\System.Data.SQLite.dll 
using assembly .\lib\MailKit.dll
using assembly .\lib\MimeKit.dll
using assembly .\lib\NLog.dll

using module .\classes\DatabaseManager.psm1
using module .\classes\NLog.psm1
using module .\classes\СheckingResult.psm1
using module .\classes\Mailer.psm1


Set-StrictMode -Version 'latest'
$DebugPreference = 'continue'
$ErrorActionPreference = 'stop'

$Global:conf = Import-PowerShellDataFile .\conf.psd1
$Global:logger = [NLogInitializer]::GetLogger($global:conf.NLogConfig)
$Global:logger.Trace('{0} session start', $Global:conf.name)

$DatabaseManager = [DatabaseManager]::new()

foreach ($target in $Global:conf.MonitoredPath.Keys) {
    $Global:logger.Trace('process target [{0}]', $target)
    $LastResult = $DatabaseManager.GetLast($target)
    $CurrentResult = [СheckingResult]::new($target)

    $Global:logger.Trace('   last status: [{0,-5}] datetime [{1:yyyy-MM-dd hh:mm:ss}]', $LastResult.Result, $LastResult.When)
    $Global:logger.Trace('current status: [{0,-5}] datetime [{1:yyyy-MM-dd hh:mm:ss}]', $CurrentResult.Result, $CurrentResult.When)
    if ($LastResult.Result -eq $true -and $CurrentResult.Result -eq $false) {
        $Global:logger.Trace('availability lost')
        [Mailer]::Send(
            $Global:conf.MonitoredPath.$target.To,
            $Global:conf.MonitoredPath.$target.Cc,
            $Global:conf.MonitoredPath.$target.Bcc,
            $Global:conf.MonitoredPath.$target.Subject,
            $Global:conf.MonitoredPath.$target.HtmlBody
        )
    }
    $DatabaseManager.Push($CurrentResult)
}

$Global:logger.Trace('{0} session end', $Global:conf.name)

