using namespace MailKit.Net.Smtp
using namespace MimeKit

class Mailer {

    static Send (
        [string[]]$To,
        [string[]]$Cc,
        [string[]]$Bcc,
        [String]$Subject,
        [String]$HtmlBody
    ) {

        $SMTPClient = [SmtpClient]::new()
        $BodyBuilder = [BodyBuilder]::new()

        $BodyBuilder.HtmlBody = $HtmlBody
        
        $Message = [MimeMessage]::new()
        $Message.From.Add($global:conf.Mail.EmailFrom)

        foreach ($email in $To) {
            $Message.To.Add($email) 
        }     
   
        foreach ($email in $Cc) {
            $Message.Cc.Add($email) 
        } 
    
        foreach ($email in $Bcc) {
            $Message.Bcc.Add($email) 
        } 
           
        $Message.Subject = $Subject
        $Message.Body = $BodyBuilder.ToMessageBody()
    
        try {
            $SMTPClient.Connect($global:conf.mail.SMTPServer, $global:conf.mail.SMTPPort, [MailKit.Security.SecureSocketOptions]::Auto)
            $SMTPClient.Authenticate($global:conf.mail.username, $global:conf.mail.password)
            $SMTPClient.Send($Message)
        }
        catch {
            $global:logger.Error($_)
            throw $_
        }
        finally {
            $SMTPClient.Disconnect($true)
            $SMTPClient.Dispose()
        }
    }
}

