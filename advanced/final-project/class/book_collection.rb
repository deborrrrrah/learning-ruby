require './class/const'
require './class/book'

# BookCollection to store the books into its address
class BookCollection
  attr_reader :collection

  def initialize
    @collection = {}
  end

  def get_book(book_address)
    @collection[book_address.to_s]
  end

  def empty_address?(address)
    get_book(address.to_s).nil?
  end

  def insert(book_address, book)
    return Const.instance.response[:failed] unless empty_address?(book_address)
    return Const.instance.response[:invalid_book] unless book.valid?
    return Const.instance.response[:already_exist] if @collection.value?(book)

    @collection[book_address.to_s] = book
    Const.instance.response[:success]
  end

  def delete(book_address)
    return Const.instance.response[:failed] if empty_address?(book_address)

    @collection.delete(book_address.to_s)
    Const.instance.response[:success]
  end

  def to_s
    string_output = []
    @collection.each do |book_address, book|
      string_output << "#{book_address}: #{book}"
    end
    string_output.reject(&:empty?).join("\n")
  end

  def empty?
    @collection.empty?
  end

  def ==(other)
    return false unless @collection.keys == other.collection.keys

    @collection.each do |book_address, book|
      return false if other.collection[book_address] != book
    end
    true
  end

  def find_book(isbn)
    address_result = nil
    target_book = Book.new({ isbn: isbn })
    @collection.each do |book_address, book|
      address_result = book_address if book == target_book
    end
    address_result
  end

  def self.search_book_by_title(book_collection, keyword)
    result = BookCollection.new
    book_collection.collection.each do |book_address, book|
      result.insert(book_address, book) if book.title_contains(keyword)
    end
    result
  end

  def self.search_book_by_author(book_collection, keyword)
    result = BookCollection.new
    book_collection.collection.each do |book_address, book|
      result.insert(book_address, book) if book.author_contains(keyword)
    end
    result
  end
end
