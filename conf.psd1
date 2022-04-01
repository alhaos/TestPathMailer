@{

    SilenceInterval = 10
    #Interval during which emails are not resent

    MonitoredPath = @(
        @{
            Path                  = "c:\tmp"
            NotificationAddresses = @(
                "alhaos@gmail.com"
            )
        }
    )
}