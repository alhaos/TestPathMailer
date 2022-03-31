@{

    SilenceInterval = 10
    #Interval during which emails are not resent

    Monitored = @(
        @{
            Path                  = "c:\tmp"
            NotificationAddresses = @(
                "alhaos@gmail.com"
            )
        }
    )
}