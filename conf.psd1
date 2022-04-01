@{
    Name            = 'TestPathMailer'
    SilenceInterval = 10
    #Interval during which emails are not resent

    MonitoredPath   = @{
        "c:\tmpp"  = @{
            To       = @("alhaos@gmail.com")
            Cc       = @("alhaos@gmail.com")
            Bcc      = $null
            Subject  = "c:\tmpp unavailable now"
            HtmlBody = @"
<h1 style="color:darkred">c:\tmpp unavailable now<h1>
"@
        }
        "C:\utils" = @{
            To       = @("alhaos@gmail.com")
            Cc       = @("alhaos@gmail.com")
            Bcc      = @("alhaos@gmail.com")
            Subject  = "C:\utils unavailable now"
            HtmlBody = @"
<h1 style="color:darkred">C:\utils unavailable now<h1>
"@
        }
    }
    Mail            = @{
        Title      = "ISD-Daily report"
        Username   = "accu-note@ac.com"
        Password   = "widen-qmgBMw#"
        EmailFrom  = "accu-note@accureference.com"
        Subject    = "ISD-Daily report"
        SMTPServer = "webmail.accureference.com"
        SMTPPort   = 587
    }
    NLogConfig      = @{
        LogDirectory      = ".\Logs"
        LogFilenameFormat = '${shortdate}.log'
    }

}