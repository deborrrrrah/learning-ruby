class MessageOperation
  def initialize(email_utility)
    @email_utility = email_utility
  end
  
  def send_email(sender, recipient, email)
    @email_utility.send_email(sender, recipient, email) ? 'Email successfully sent' : 'Failure when sending email' 
  end

  def retrieve_emails(owner)
    @email_utility.retrieve_emails(owner)
  end
end