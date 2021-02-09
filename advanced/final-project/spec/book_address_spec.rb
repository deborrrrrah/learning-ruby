require '../class/book_address.rb'

RSpec.describe 'BookAddress' do
  describe '#to_s' do
    it 'return 010101' do
      book_address = BookAddress.new({
        shelf: 1,
        row: 1,
        column: 1, 
      })
      result = book_address.to_s
      expect(result).to eq('010101')
    end
  end
end