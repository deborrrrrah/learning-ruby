require '../class/const.rb'
require '../class/book.rb'
require '../class/library.rb'
require '../class/book_address.rb'
require '../class/book_collection.rb'

RSpec.describe 'Library' do
  describe '#valid?' do
    it 'return false when params is nil' do
      result = Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return true when shelf_size 3, row_size 2, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 2
      }
      Library.instance.reset_size(params)
      result = Library.instance.valid?
      expect(result).to eq(true)
    end

    it 'return false when shelf_size 0, row_size 2, column_size 2' do
      params = {
        shelf_size: 0,
        row_size: 2,
        column_size: 2
      }
      Library.instance.reset_size(params)
      result = Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 100, row_size 2, column_size 2' do
      params = {
        shelf_size: 100,
        row_size: 2,
        column_size: 2
      }
      Library.instance.reset_size(params)
      result = Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 0, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 0,
        column_size: 2
      }
      Library.instance.reset_size(params)
      result = Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 100, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 100,
        column_size: 2
      }
      Library.instance.reset_size(params)
      result = Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 2, column_size 0' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 0
      }
      Library.instance.reset_size(params)
      result = Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 2, column_size 100' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 100
      }
      Library.instance.reset_size(params)
      result = Library.instance.valid?
      expect(result).to eq(false)
    end
  end

  describe '#find_next_empty_position' do
    before (:all) do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 3
      }
      Library.instance.reset_size(params)
    end

    it 'return 010102 when empty library' do
      result = Library.instance.find_next_empty_position
      expected = BookAddress.new.set_from_string_address('010102')
      expect(result).to eq (expected)
    end

    it 'return 010103 when schema quite complex' do
      Library.instance.put_book({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      Library.instance.put_book({
        isbn: '1234567890124',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      Library.instance.take_book_from('010101')
      result = Library.instance.find_next_empty_position
      expected = BookAddress.new.set_from_string_address('010103')
      expect(result).to eq (expected)
    end
  end
  
  context 'library initialize with shelf_size 1, row_size 1, column_size 1' do
    before(:each) do
      Library.instance.reset_size({
        shelf_size: 1,
        row_size: 1,
        column_size: 1
      })
    end

    describe '#full?' do
      it 'return false when initialization of valid empty library' do
        result = Library.instance.full?
        expect(result).to eq(false)
      end

      it 'return true' do
        Library.instance.put_book({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        result = Library.instance.full?
        expect(result).to eq(true)
      end
    end

    describe '#put_book' do
      it 'return success response' do
        result = Library.instance.put_book({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        expect(result).to eq(Const.instance.response[:success])
      end

      it 'return full response' do
        Library.instance.put_book({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        result = Library.instance.put_book({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        expect(result).to eq(Const.instance.response[:full])
      end

      it 'return invalid book response' do
        result = Library.instance.put_book({
          isbn: '12345678901',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        expect(result).to eq(Const.instance.response[:invalid_book])
      end
    end

    describe '#take_book_from' do
      it 'return invalid address' do
        result = Library.instance.take_book_from('010201')
        expect(result).to eq(Const.instance.response[:invalid_address])
      end

      it 'return failed address due to empty library' do
        result = Library.instance.take_book_from('010101')
        expect(result).to eq(Const.instance.response[:failed])
      end

      it 'return success response' do
        Library.instance.put_book({
          isbn: '1234567890123',
          author: 'J. K. Rowling',
          title: 'Harry Potter'
        })
        result = Library.instance.take_book_from('010101')
        expect(result).to eq(Const.instance.response[:success])
      end
    end
  end

  context 'library initialize with shelf_size 1, row_size 3, column_size 2' do
    before(:all) do
      Library.instance.reset_size({
        shelf_size: 2,
        row_size: 1,
        column_size: 3
      })
      Library.instance.put_book({
        isbn: '9780747532743',
        author: 'J. K. Rowling',
        title: 'Harry Potter 1'
      })
      Library.instance.put_book({
        isbn: '9780807281918',
        author: 'J. K. Rowling',
        title: 'Harry Potter 2'
      })
      Library.instance.put_book({
        isbn: '9780739330944',
        author: 'Christopher Paolini',
        title: 'Eragon 1'
      })
      Library.instance.put_book({
        isbn: '9780545582933',
        author: 'J. K. Rowling',
        title: 'Harry Potter 3'
      })
      Library.instance.put_book({
        isbn: '9780132350884',
        author: 'Robert Cecil Martin',
        title: 'Clean Code'
      })
      Library.instance.put_book({
        isbn: '9780201485677',
        author: 'Martin Fowler, Kent Beck',
        title: 'Refactoring'
      })
    end

    describe '#find_book' do
      it 'return book found when find 9780807281918' do
        result = Library.instance.find_book('9780807281918')
        expect(result).to eq(Const.instance.response[:found])
      end

      it 'return book found when find 000' do
        result = Library.instance.find_book('000')
        expect(result).to eq(Const.instance.response[:not_found])
      end
    end

    describe '#search_book_by_author' do
      it 'return book found when find Kent Beck' do
        result = Library.instance.search_book_by_author('Kent Beck')
        expect(result).to eq(Const.instance.response[:found])
      end

      it 'return book found when find Tolkien' do
        result = Library.instance.search_book_by_author('Tolkien')
        expect(result).to eq(Const.instance.response[:not_found])
      end
    end

    describe '#search_book_by_title' do
      it 'return book found when find Harry Potter' do
        result = Library.instance.search_book_by_title('Harry Potter')
        expect(result).to eq(Const.instance.response[:found])
      end

      it 'return book found when find Tolkien' do
        result = Library.instance.search_book_by_title('Little Prince')
        expect(result).to eq(Const.instance.response[:not_found])
      end
    end

    describe '#list_books' do
      it 'return calls the list_books function' do
        expect_any_instance_of(BookCollection).to receive(:to_s)
        Library.instance.list_books
      end
    end

    describe '#take_book_from' do
      it 'return success response and change the available position value' do
        result = Library.instance.take_book_from('010102')
        expect(result).to eq(Const.instance.response[:success])
      end
    end
  end
end