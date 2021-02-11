require '../class/const.rb'
require '../class/book.rb'
require '../class/book_collection.rb'

RSpec.describe 'BookCollection' do
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
      expect(result).to eq(RESPONSE[:success])
    end
  end
end