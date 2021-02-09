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

    it 'return right book address when set 999999' do
      book_address = BookAddress.new({
        shelf: 99,
        row: 99,
        column: 99, 
      })
      result = BookAddress.new.set('999999')
      expect(result).to eq(book_address)
    end
  end

  describe '#valid?' do
    it 'return true for position 010101' do
      book_address = BookAddress.new.set('010101')
      result = book_address.valid?
      expect(result).to eq(true)
    end

    it 'return false for shelf -1, row 1, column 1' do
      book_address = BookAddress.new({
        shelf: -1,
        row: 1,
        column: 1, 
      })
      result = book_address.valid?
      expect(result).to eq(false)
    end

    it 'return false for position 010001' do
      book_address = BookAddress.new.set('010001')
      result = book_address.valid?
      expect(result).to eq(false)
    end

    it 'return false for position 010100' do
      book_address = BookAddress.new.set('010100')
      result = book_address.valid?
      expect(result).to eq(false)
    end

    it 'return false for shelf 1, row 100, column 1' do
      book_address = BookAddress.new({
        shelf: 1,
        row: 100,
        column: 1, 
      })
      result = book_address.valid?
      expect(result).to eq(false)
    end
  end

  describe '#shelf_in_range?' do
    it 'return true for position 010101 with max_size 3 and min_size 0' do
      book_address = BookAddress.new.set('010101')
      min_size = 0
      max_size = 3
      result = book_address.shelf_in_range?(min_size, max_size)
      expect(result).to eq(true)
    end

    it 'return false for position 010101 with max_size 3 and min_size 1' do
      book_address = BookAddress.new.set('010101')
      min_size = 1
      max_size = 3
      result = book_address.shelf_in_range?(min_size, max_size)
      expect(result).to eq(false)
    end
  end

  describe '#row_in_range?' do
    it 'return true for position 010101 with max_size 3 and min_size 0' do
      book_address = BookAddress.new.set('010101')
      min_size = 0
      max_size = 3
      result = book_address.row_in_range?(min_size, max_size)
      expect(result).to eq(true)
    end

    it 'return false for position 020101 with max_size 3 and min_size 1' do
      book_address = BookAddress.new.set('020101')
      min_size = 1
      max_size = 3
      result = book_address.row_in_range?(min_size, max_size)
      expect(result).to eq(false)
    end
  end

  describe '#column_in_range?' do
    it 'return true for position 010101 with max_size 3 and min_size 0' do
      book_address = BookAddress.new.set('010101')
      min_size = 0
      max_size = 3
      result = book_address.column_in_range?(min_size, max_size)
      expect(result).to eq(true)
    end
  end
end