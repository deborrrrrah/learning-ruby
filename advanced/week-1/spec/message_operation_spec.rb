require '../class/message_operation.rb'

RSpec.describe 'MessageOperation' do
  before(:each) do
    @sender = 'person_1'
    @recipient = '@person_2'
    @email = 'some text'
    @owner = 'person_1' 
  end
  
  describe '#send_email' do
    it 'return successfully sent' do
      email_utility = double
      allow(email_utility).to receive(:send_email).and_return(true)
      expect(email_utility).to receive(:send_email).with(@sender, @recipient, @email)
      result = MessageOperation.new(email_utility).send_email(@sender, @recipient, @email)
      expect(result).to eq('Email successfully sent')
    end

    it 'return failure when sending email' do
      email_utility = double
      allow(email_utility).to receive(:send_email).and_return(false)
      expect(email_utility).to receive(:send_email).with(@sender, @recipient, @email)
      result = MessageOperation.new(email_utility).send_email(@sender, @recipient, @email) 
      expect(result).to eq('Failure when sending email')
    end
  end

  describe '#retrieve_emails' do
    it 'return empty list when no emails retrieved' do
      email_utility = double
      allow(email_utility).to receive(:retrieve_emails).and_return([])
      expect(email_utility).to receive(:retrieve_emails).with(@owner)
      result = MessageOperation.new(email_utility).retrieve_emails(@owner) 
      expect(result).to eq([])
    end

    it 'return ["email text 1", "email text 2"] when some emails retrieved' do
      email_utility = double
      allow(email_utility).to receive(:retrieve_emails).and_return(['email text 1', 'email text 2'])
      expect(email_utility).to receive(:retrieve_emails).with(@owner)
      result = MessageOperation.new(email_utility).retrieve_emails(@owner) 
      expect(result).to eq(['email text 1', 'email text 2'])
    end
  end
end