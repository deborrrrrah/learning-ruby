class MessageOperation
  def initialize(email_utility)
    @email_utility = email_utility
  end
  
  def send_email(sender, recipient, email)
    return 'Email successfully sent' if @email_utility.send_email(sender, recipient, email)
  end
end