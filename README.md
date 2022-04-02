# TestPathMailer

Это работает так в файле параметров ключ MonitoredPath содержит Ключи имена которых начинаются с 

It works like this, in the parameters file the key MonitoredPath contains Keys whose names contain directories for monitoring.
Each time the script runs through these keys and retrieves their latest state from the database.
Checks the current state.
If the status changes from "available" to "not available" a mail message is sent, body and subject in the options file in the key with this directory.

