require '../class/email_utility.rb'
require '../class/message_operation_static.rb'

RSpec.describe 'MessageOperation' do
  before(:each) do
    @sender = 'person_1'
    @recipient = '@person_2'
    @email = 'some text'
    @owner = 'person_1' 
  end

  describe '.send_email' do
    it 'return successfully sent' do
      allow_any_instance_of(EmailUtility).to receive(:send_email).and_return(true)
      expect_any_instance_of(EmailUtility).to receive(:send_email).with(@sender, @recipient, @email)
      result = MessageOperation.send_email(@sender, @recipient, @email) 
      expect(result).to eq('Email successfully sent')
    end
  end
end