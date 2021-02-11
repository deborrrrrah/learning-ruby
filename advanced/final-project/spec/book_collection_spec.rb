require '../class/const.rb'
require '../class/book.rb'
require '../class/book_collection.rb'

RSpec.describe 'BookCollection' do
  describe '#get_book' do
    it 'return nil' do 
      book_collection = BookCollection.new
      book_address = '010101'
      result = book_collection.get_book(book_address)
      expect(result).to eq(nil)
    end

    it 'return book' do 
      book_collection = BookCollection.new
      book_address = '010101'
      book = Book.new({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      book_collection.insert(book_address, book)
      result = book_collection.get_book(book_address)
      expect(result).to eq(book)
    end
  end

  describe '#insert' do
    it 'return success response' do
      book_collection = BookCollection.new
      book_address = '010101'
      book = Book.new({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      result = book_collection.insert(book_address, book)
      inserted_book = book_collection.get_book(book_address)
      expect(result).to eq(RESPONSE[:success])
      expect(inserted_book).to eq(book)
    end

    it 'return invalid book response' do
      book_collection = BookCollection.new
      book_address = '010101'
      book = Book.new({
        isbn: '123456789012',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      result = book_collection.insert(book_address, book)
      inserted_book = book_collection.get_book(book_address)
      expect(result).to eq(RESPONSE[:invalid_book])
      expect(inserted_book).to eq(nil)
    end
  end

  describe '#delete' do
    it 'return success response' do
      book_collection = BookCollection.new
      book_address = '010101'
      book = Book.new({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      book_collection.insert(book_address, book)
      result = book_collection.delete(book_address)
      deleted_book = book_collection.get_book(book_address)
      expect(result).to eq(RESPONSE[:success])
      expect(deleted_book).to eq(nil)
    end
  end

  describe '#to_s' do
    it 'return empty string' do
      book_collection = BookCollection.new
      result = book_collection.to_s
      expect(result).to eq('')
    end

    it 'return string of one book' do
      book_collection = BookCollection.new
      book_address = '010101'
      book = Book.new({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      book_collection.insert(book_address, book)
      result = book_collection.to_s
      expect(result).to eq('010101: 1234567890123 | J. K. Rowling | Harry Potter')
    end
  end
end