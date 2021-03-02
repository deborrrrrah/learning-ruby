require '../class/const.rb'
require '../class/book.rb'
require '../class/book_collection.rb'
require '../class/book_address.rb'

RSpec.describe 'BookCollection' do
  context 'when need empty and non-empty book collection' do
    before(:all) do
      @empty_book_collection = BookCollection.new
      @book_collection = BookCollection.new
      @book_address = '010101'
      @book = Book.new({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      @book_collection.insert(@book_address, @book)
    end

    describe '#get_book' do
      it 'return nil' do 
        result = @empty_book_collection.get_book(@book_address)
        expect(result).to eq(nil)
      end

      it 'return book' do 
        result = @book_collection.get_book(@book_address)
        expect(result).to eq(@book)
      end
    end

    describe '#empty?' do
      it 'return true' do
        result = @empty_book_collection.empty?
        expect(result).to eq(true)
      end

      it 'return false' do
        result = @book_collection.empty?
        expect(result).to eq(false)
      end
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
      expect(result).to eq(Const.instance.response[:success])
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
      expect(result).to eq(Const.instance.response[:invalid_book])
      expect(inserted_book).to eq(nil)
    end

    it 'return failed insert response due to not empty address' do
      book_collection = BookCollection.new
      book_address = BookAddress.new.set_from_string_address('010101')
      book_1 = Book.new({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      book_collection.insert(book_address, book_1)
      book_2 = Book.new({
        isbn: '1234567890124',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      result = book_collection.insert(book_address, book_2)
      inserted_book = book_collection.get_book(book_address)
      expect(result).to eq(Const.instance.response[:failed])
      expect(inserted_book).to eq(book_1)
    end
  end

  context 'when library is not empty' do
    before(:all) do
      @book_collection = BookCollection.new
      @books = [
        Book.new({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        }),
        Book.new({
          isbn: '1234567890124',
          author: 'Robert Cecil Martin',
          title: 'Clean Code'
        })
      ]
      @book_collection.insert('010101', @books[0])
      @book_collection.insert('010102', @books[1])
    end

    describe '#delete' do
      it 'return success response' do
        book_address = '010101'
        result = @book_collection.delete(book_address)
        deleted_book = @book_collection.get_book(book_address)
        expect(result).to eq(Const.instance.response[:success])
        expect(deleted_book).to eq(nil)
      end

      it 'return failed response because the address has no book' do
        book_address = '010103'
        result = @book_collection.delete(book_address)
        deleted_book = @book_collection.get_book(book_address)
        expect(result).to eq(Const.instance.response[:failed])
      end
    end

    describe '#empty_address?' do
      it 'return false when address is 010102' do
        result = @book_collection.empty_address?('010102')
        expect(result).to eq(false)
      end

      it 'return true when address is 020101' do
        result = @book_collection.empty_address?('020101')
        expect(result).to eq(true)
      end
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
      expect(result).to eq('010101: 1234567890123 | Harry Potter | J. K. Rowling')
    end

    it 'return string of more than one book' do
      book_collection = BookCollection.new
      book_address_1 = '010101'
      book_address_2 = '010102'
      book = Book.new({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      book_collection.insert(book_address_1, book)
      book_collection.insert(book_address_2, book)
      result = book_collection.to_s
      expected = "010101: 1234567890123 | Harry Potter | J. K. Rowling\n010102: 1234567890123 | Harry Potter | J. K. Rowling"
      expect(result).to eq(expected)
    end
  end

  context 'when book collection consist of many books' do
    before(:all) do
      @book_collection = BookCollection.new
      @books = [
        Book.new({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        }),
        Book.new({
          isbn: '1234567890124',
          author: 'Robert Cecil Martin',
          title: 'Clean Code'
        }),
        Book.new({
          isbn: '1234567890125',
          author: 'Robert Cecil Martin',
          title: 'Clean Code'
        })
      ]
      @book_collection.insert('010101', @books[0])
      @book_collection.insert('010102', @books[1])
    end

    describe '#==' do
      it 'return true' do
        another_book_collection = BookCollection.new
        another_book_collection.insert('010101', @books[0])
        another_book_collection.insert('010102', @books[1])
        result = @book_collection == another_book_collection
        expect(result).to eq(true)
      end

      it 'return false when different address' do
        another_book_collection = BookCollection.new
        another_book_collection.insert('010101', @books[0])
        another_book_collection.insert('010103', @books[1])
        result = @book_collection == another_book_collection
        expect(result).to eq(false)
      end

      it 'return false when different books' do
        another_book_collection = BookCollection.new
        another_book_collection.insert('010101', @books[1])
        another_book_collection.insert('010102', @books[0])
        result = @book_collection == another_book_collection
        expect(result).to eq(false)
      end
    end

    describe '#find_book' do
      it 'return empty for isbn 1234567890125 not existed in the collection' do
        result = @book_collection.find_book('1234567890125')
        expect(result).to eq(nil)
      end

      it 'return 010102 for book with isbn 1234567890124' do
        result = @book_collection.find_book('1234567890124')
        expect(result).to eq('010102')
      end
    end

    describe '.search_book_by_title' do
      it 'return empty BookCollection' do
        expected = BookCollection.new
        result = BookCollection.search_book_by_title(@book_collection, 'ruby')
        expect(result).to eq(expected)
      end

      it 'return a BookCollection consist of a book' do
        expected = BookCollection.new
        expected.insert('010102', @books[1])
        result = BookCollection.search_book_by_title(@book_collection, 'code')
        expect(result).to eq(expected)
      end
    end

    describe '.search_book_by_author' do
      it 'return empty BookCollection' do
        expected = BookCollection.new
        result = BookCollection.search_book_by_author(@book_collection, 'ruby')
        expect(result).to eq(expected)
      end

      it 'return a BookCollection consist of a book' do
        expected = BookCollection.new
        expected.insert('010102', @books[1])
        result = BookCollection.search_book_by_author(@book_collection, 'rob')
        expect(result).to eq(expected)
      end
    end
  end
end