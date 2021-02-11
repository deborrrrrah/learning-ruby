require_relative 'const'
require_relative 'book_address'
require_relative 'book_collection'

class Library
  def initialize(params={})
    @book_collection = params[:book_collection].nil? ? BookCollection.new : params[:book_collection]  
    @shelf_size = params[:shelf_size]
    @row_size = params[:row_size]
    @column_size = params[:column_size]
    @available_position = '010101'
  end

  def valid?
    return false if @shelf_size.nil? || @row_size.nil? || @column_size.nil?
    return false unless @shelf_size > CONST[:min_size] && @shelf_size < CONST[:max_size]
    return false unless @row_size > CONST[:min_size] && @row_size < CONST[:max_size]
    return false unless @column_size > CONST[:min_size] && @column_size < CONST[:max_size]
    true 
  end

  def find_next_empty_position
    available_book_address = BookAddress.new.set(@available_position)
    BookAddress.next_address(available_book_address, @shelf_size, @row_size, @column_size)
  end

  def full?
    false
  end

  def put_book(isbn, author, title)
    book = Book.new({
      isbn: isbn,
      author: author,
      title: title
    })
    response = @book_collection.insert(@available_book_address, book)
    @available_book_address = find_next_empty_position
    response
  end
end