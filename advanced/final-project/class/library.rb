require_relative 'const'
require_relative 'book_address'
require_relative 'book_collection'

class Library
  def initialize(params={})
    @book_collection = params[:books].nil? ? BookCollection.new : params[:books]  
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
    @available_position.nil?
  end

  def put_book(params)
    if full?
      puts 'All shelves are full!'
      response = RESPONSE[:full]
    else
      book = Book.new(params)
      response = @book_collection.insert(@available_position, book)
      if response == RESPONSE[:invalid_book] 
        puts 'Failed to put_book because the book attributes are invalid.'
      elsif response == RESPONSE[:success]
        puts "Allocated address: #{ @available_position }"
        @available_position = find_next_empty_position
      end
    end
    response
  end
end