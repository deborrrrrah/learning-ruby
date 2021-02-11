require '../class/const.rb'
require '../class/book.rb'

class BookCollection
  def initialize
    @collection = Hash.new
  end

  def get_book(book_address)
    @collection[book_address]
  end

  def insert(book_address, book)
    return RESPONSE[:invalid_book] unless book.valid?
    @collection[book_address] = book
    RESPONSE[:success]
  end

  def delete(book_address)
    @collection.delete(book_address)
    RESPONSE[:success]
  end

  def to_s
    string_output = []
    @collection.each do |book_address, book|
      string_output << "#{ book_address }: #{ book }"
    end
    string_output.reject(&:empty?).join('\n')
  end

  def find_book(isbn)
    address_result = nil
    target_book = Book.new({isbn: isbn})
    @collection.each do |book_address, book|
      if book == target_book
        address_result = book_address
      end
    end
    address_result
  end
end