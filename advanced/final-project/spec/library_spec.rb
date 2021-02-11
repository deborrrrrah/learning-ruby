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

  describe '#full?' do
    it 'return false when initialization of valid empty library' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 2
      }
      library = Library.new(params)
      result = library.full?
      expect(result).to eq(false)
    end
  end

  context 'when intialization of library is valid' do
    before(:all) do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 2
      }
      @library = Library.new(params)
      @valid_book = Book.new({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      @invalid_book = Book.new({
        isbn: '123456789012a',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
    end

    describe '#put_book' do
      it 'return success response with valid book' do
        isbn = @valid_book.isbn
        author = @valid_book.author
        title = @valid_book.title
        result = @library.put_book(isbn, author, title)
        expect(result).to eq(RESPONSE[:success])
      end

      it 'return invalid response with invalid book' do
        isbn = @invalid_book.isbn
        author = @invalid_book.author
        title = @invalid_book.title
        result = @library.put_book(isbn, author, title)
        expect(result).to eq(RESPONSE[:invalid_book])
      end
    end
  end
end