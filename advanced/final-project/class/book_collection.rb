require '../class/const.rb'
require '../class/book.rb'

class BookCollection
  def initialize
    @collection = Hash.new
  end

  def insert(book_address, book)
    RESPONSE[:success]
  end
end