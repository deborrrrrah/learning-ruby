require '../class/book.rb'

RSpec.describe 'Book' do
  before(:all) do
    @book_1 = Book.new({
      isbn: '',
      author: '',
      title: ''
    })
  end

  describe '#valid?' do
    it 'return false' do
      result = @book_1.valid?
      expect(result).to eq(false)
    end
  end
end