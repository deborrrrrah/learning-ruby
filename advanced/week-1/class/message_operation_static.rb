class MessageOperation
  def self.send_email(sender, recipient, email)
    EmailUtility.new.send_email(sender, recipient, email) ? 'Email successfully sent' : 'Failure when sending email'
  end
end