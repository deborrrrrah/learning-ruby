class MessageOperation
  def initialize(email_utility)
    @email_utility = email_utility
  end
  
  def send_email(sender, recipient, email)
    return @email_utility.send_email(sender, recipient, email) ? 'Email successfully sent' : 'Failure when sending email' 
  end
end