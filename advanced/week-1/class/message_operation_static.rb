class MessageOperation
  def self.send_email(sender, recipient, email)
    EmailUtility.new.send_email(sender, recipient, email) ? 'Email successfully sent' : 'Failure when sending email'
  end

  def self.retrieve_emails(owner)
    EmailUtility.new.retrieve_emails(owner)
  end
end