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

    it 'return 100101' do
      book_address = BookAddress.new({
        shelf: 10,
        row: 1,
        column: 1, 
      })
      result = book_address.to_s
      expect(result).to eq('100101')
    end
  end

  describe '#==' do
    it 'return true of the exact same address attributes' do
      book_address_1 = BookAddress.new({
        shelf: 1,
        row: 1,
        column: 1, 
      })
      book_address_2 = BookAddress.new({
        shelf: 1,
        row: 1,
        column: 1, 
      })
      result = book_address_1 == book_address_2
      expect(result).to eq(true)
    end

    it 'return false of the different address attributes' do
      book_address_1 = BookAddress.new({
        shelf: 1,
        row: 1,
        column: 1, 
      })
      book_address_2 = BookAddress.new({
        shelf: 2,
        row: 1,
        column: 1, 
      })
      result = book_address_1 == book_address_2
      expect(result).to eq(false)
    end
  end

  describe '#set' do
    it 'return right book address when set 010101' do
      book_address = BookAddress.new({
        shelf: 1,
        row: 1,
        column: 1, 
      })
      result = BookAddress.new.set('010101')
      expect(result).to eq(book_address)
    end
    
    it 'return right book address when set 100101' do
      book_address = BookAddress.new({
        shelf: 10,
        row: 1,
        column: 1, 
      })
      result = BookAddress.new.set('100101')
      expect(result).to eq(book_address)
    end
  end
end