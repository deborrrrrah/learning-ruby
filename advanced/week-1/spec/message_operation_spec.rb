require '../class/message_operation.rb'

RSpec.describe 'MessageOperation' do
  describe '#send_email' do
    it 'return successfully sent' do
      email_utility = double
      allow(email_utility).to receive(:send_email).and_return(true)
      
      sender = 'person_1'
      recipient = 'person_2'
      email = 'some text'
      
      result = MessageOperation.new(email_utility).send_email(sender, recipient, email) 
      expect(result).to eq('Email successfully sent')
    end
  end

  # describe '.retrieve_emails' do
  # end
end