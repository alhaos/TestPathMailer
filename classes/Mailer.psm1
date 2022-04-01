using namespace MailKit.Net.Smtp
using namespace MimeKit

class Mailer {

    static Send (
        [String]$HtmlBody,
        [String]$Subject,
        [String[]]$Attachments
    ) {

        #$global:logger.Trace("Send report {0} started", $ReportName) 
       
        $SMTPClient = [SmtpClient]::new()
        $BodyBuilder = [BodyBuilder]::new()

        $BodyBuilder.HtmlBody = $HtmlBody
        
        foreach ($Attachment in $Attachments) {
            $BodyBuilder.Attachments.Add($Attachment)            
        }
        
        $Message = [MimeMessage]::new()
        $Message.From.Add($global:conf.Mail.EmailFrom)

        foreach ($email in $global:conf.Mail.EmailsTo) {
            $Message.To.Add($email) 
            #$global:logger.Trace($email)
        }     

   
        foreach ($email in $global:conf.Mail.EmailsCc) {
            $Message.Cc.Add($email) 
            #$global:logger.Trace($email)
        } 
    
        foreach ($email in $global:conf.Mail.EmailsBcc) {
            $Message.Bcc.Add($email) 
            #$global:logger.Trace($email)
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
        #$global:logger.Trace("Send report {0} finished", $ReportName) 
    }
}

