require '../class/const.rb'
require '../class/book.rb'
require '../class/library.rb'
require '../class/book_address.rb'

RSpec.describe 'Library' do
  describe '#valid?' do
    it 'return false when params is nil' do
      library = Library.new
      result = library.valid?
      expect(result).to eq(false)
    end

    it 'return true when shelf_size 3, row_size 2, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(true)
    end

    it 'return false when shelf_size 0, row_size 2, column_size 2' do
      params = {
        shelf_size: 0,
        row_size: 2,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 100, row_size 2, column_size 2' do
      params = {
        shelf_size: 100,
        row_size: 2,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 0, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 0,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 100, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 100,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 2, column_size 0' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 0
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 2, column_size 100' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 100
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end
  end

  describe '#find_next_empty_position' do
    it 'return 010102 when empty library' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 2
      }
      library = Library.new(params)
      result = library.find_next_empty_position
      expected = BookAddress.new.set('010102')
      expect(result).to eq result
    end
  end
  
  context 'library initialize with shelf_size 1, row_size 1, column_size 1' do
    before(:each) do
      @library = Library.new({
        shelf_size: 1,
        row_size: 1,
        column_size: 1
      })
    end

    describe '#full?' do
      it 'return false when initialization of valid empty library' do
        result = @library.full?
        expect(result).to eq(false)
      end

      it 'return true' do
        @library.put_book({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        result = @library.full?
        expect(result).to eq(true)
      end
    end

    describe '#put_book' do
      it 'return success response' do
        result = @library.put_book({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        expect(result).to eq(RESPONSE[:success])
      end

      it 'return full response' do
        @library.put_book({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        result = @library.put_book({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        expect(result).to eq(RESPONSE[:full])
      end

      it 'return invalid book response' do
        result = @library.put_book({
          isbn: '12345678901',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        expect(result).to eq(RESPONSE[:invalid_book])
      end
    end

    describe '#take_book_from' do
      it 'return invalid address' do
        result = @library.take_book_from('010201')
        expect(result).to eq(RESPONSE[:invalid_address])
      end

      it 'return failed address due to empty library' do
        result = @library.take_book_from('010101')
        expect(result).to eq(RESPONSE[:failed])
      end

      it 'return success response' do
        @library.put_book({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        result = @library.take_book_from('010101')
        expect(result).to eq(RESPONSE[:success])
      end
    end
  end

  context 'library initialize with shelf_size 1, row_size 3, column_size 2' do
    before(:all) do
      @library = Library.new({
        shelf_size: 2,
        row_size: 1,
        column_size: 3
      })
      @library.put_book({
        isbn: '9780747532743',
        author: 'J. K. Rowling',
        title: 'Harry Potter 1'
      })
      @library.put_book({
        isbn: '9780807281918',
        author: 'J. K. Rowling',
        title: 'Harry Potter 2'
      })
      @library.put_book({
        isbn: '9780739330944',
        author: 'Christopher Paolini',
        title: 'Eragon 1'
      })
      @library.put_book({
        isbn: '9780545582933',
        author: 'J. K. Rowling',
        title: 'Harry Potter 3'
      })
      @library.put_book({
        isbn: '9780132350884',
        author: 'Robert Cecil Martin',
        title: 'Clean Code'
      })
      @library.put_book({
        isbn: '9780545582933',
        author: 'Martin Fowler, Kent Beck',
        title: 'Refactoring'
      })
    end
    describe '#take_book_from' do
      it 'return success response and change the available position value' do
        result = @library.take_book_from('010102')
        expect(result).to eq(RESPONSE[:success])
      end
    end
  end
end