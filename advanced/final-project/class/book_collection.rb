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
    nil
  end
end