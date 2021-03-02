require '../class/book'

RSpec.describe 'Book' do
  describe '#valid?' do
    it 'return false when empty strings as parameters' do
      book = Book.new({
                        isbn: '',
                        author: '',
                        title: ''
                      })
      result = book.valid?
      expect(result).to eq(false)
    end

    it 'return true when got valid parameters' do
      book = Book.new({
                        isbn: '1234567890123',
                        author: 'J. K. Rowling',
                        title: 'Harry Potter'
                      })
      result = book.valid?
      expect(result).to eq(true)
    end

    it 'return false when isbn parameter is not 13-length string' do
      book = Book.new({
                        isbn: '123456789012',
                        author: 'J. K. Rowling',
                        title: 'Harry Potter'
                      })
      result = book.valid?
      expect(result).to eq(false)
    end

    it 'return false when isbn contain char' do
      book = Book.new({
                        isbn: '123456789012a',
                        author: 'J. K. Rowling',
                        title: 'Harry Potter'
                      })
      result = book.valid?
      expect(result).to eq(false)
    end
  end

  describe '#==' do
    it 'return true when same object attributes' do
      book1 = Book.new({
                          isbn: '1234567890123',
                          author: 'J. K. Rowling',
                          title: 'Harry Potter'
                        })

      book2 = Book.new({
                          isbn: '1234567890123',
                          author: 'J. K. Rowling',
                          title: 'Harry Potter'
                        })
      result = book1 == book2
      expect(result).to eq(true)
    end

    it 'return true when same isbn different author and title' do
      book1 = Book.new({
                          isbn: '1234567890123',
                          author: 'J. K. Rowling',
                          title: 'Harry Potter'
                        })

      book2 = Book.new({
                          isbn: '1234567890123',
                          author: 'J. L. Rowling',
                          title: 'Harry Weasley'
                        })
      result = book1 == book2
      expect(result).to eq(true)
    end

    it 'return false when different object attributes' do
      book1 = Book.new({
                          isbn: '1234567890122',
                          author: 'J. K. Rowling',
                          title: 'Harry Potter'
                        })

      book2 = Book.new({
                          isbn: '1234567890123',
                          author: 'J. K. Rowling',
                          title: 'Harry Potter'
                        })
      result = book1 == book2
      expect(result).to eq(false)
    end
  end

  describe '#to_s' do
    it 'return the empty format of to_s' do
      book = Book.new({
                        isbn: '',
                        author: '',
                        title: ''
                      })
      result = book.to_s
      expect(result).to eq(' |  | ')
    end

    it 'return the right format of to_s' do
      book = Book.new({
                        isbn: '1234567890123',
                        author: 'J. K. Rowling',
                        title: 'Harry Potter'
                      })
      result = book.to_s
      expect(result).to eq('1234567890123 | Harry Potter | J. K. Rowling')
    end
  end

  describe '#author_contains' do
    context 'when book is valid' do
      before(:all) do
        @book = Book.new({
                           isbn: '1234567890123',
                           author: 'J. K. Rowling',
                           title: 'Harry Potter'
                         })
      end

      it 'return true when keyword is empty string' do
        result = @book.author_contains('')
        expect(result).to eq(true)
      end

      it 'return true when keyword row' do
        result = @book.author_contains('row')
        expect(result).to eq(true)
      end

      it 'return false when keyword deb' do
        result = @book.author_contains('deb')
        expect(result).to eq(false)
      end
    end
  end

  describe '#title_contains' do
    context 'when book is valid' do
      before(:all) do
        @book = Book.new({
                           isbn: '1234567890123',
                           author: 'J. K. Rowling',
                           title: 'Harry Potter'
                         })
      end
      it 'return true when keyword is empty string' do
        result = @book.title_contains('')
        expect(result).to eq(true)
      end

      it 'return true when keyword harr' do
        result = @book.title_contains('harr')
        expect(result).to eq(true)
      end

      it 'return false when keyword deb' do
        result = @book.title_contains('deb')
        expect(result).to eq(false)
      end
    end
  end
end
