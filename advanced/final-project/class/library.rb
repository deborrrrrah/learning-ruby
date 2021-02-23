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
      RESPONSE[:full]
    else
      book = Book.new(params)
      response = @book_collection.insert(@available_position, book)
      if response == RESPONSE[:invalid_book] 
        puts 'Failed to put_book because the book attributes are invalid.'
      elsif response == RESPONSE[:success]
        puts "Allocated address: #{ @available_position }"
        @available_position = find_next_empty_position
      end
      response
    end
  end

  def address_valid?(address)
    book_address = BookAddress.new.set(address)
    book_address.shelf_in_range?(0, @shelf_size + 1) && book_address.row_in_range?(0, @row_size + 1) && book_address.column_in_range?(0, @column_size + 1)
  end
  
  def take_book_from(address)
    if !address_valid?(address)
      puts 'Invalid code!'
      RESPONSE[:invalid_address]
    else
      response = @book_collection.delete(address)
      if response == RESPONSE[:success]
        if address < @available_position.to_s
          @available_position = address
        end
        puts "Slot #{ address } is free"
      elsif response == RESPONSE[:failed]
        puts "Slot #{ address } is already empty"
      end
      response
    end
  end

  private :address_valid?
end