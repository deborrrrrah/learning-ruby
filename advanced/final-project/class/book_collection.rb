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
end