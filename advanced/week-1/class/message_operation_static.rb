class MessageOperation
  def self.send_email(sender, recipient, email)
    result = EmailUtility.new.send_email(sender, recipient, email)
    'Email successfully sent'
  end
end