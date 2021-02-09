require '../class/book.rb'

RSpec.describe 'Book' do
  describe '#valid?' do
    it 'return false' do
      book = Book.new({
        isbn: '',
        author: '',
        title: ''
      })
      result = book.valid?
      expect(result).to eq(false)
    end

    it 'return true' do
      book = Book.new({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      result = book.valid?
      expect(result).to eq(true)
    end
  end
end