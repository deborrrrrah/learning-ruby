require_relative 'const'

class BookAddress
  attr_reader :shelf, :row, :column

  def initialize(params={})
    @shelf = params[:shelf]
    @row = params[:row]
    @column = params[:column]
  end

  def ==(book_address)
    book_address.shelf == @shelf && book_address.row == @row && book_address.column == @column
  end

  def to_s
    shelf_string = @shelf < 10 ? "0#{ @shelf }" : @shelf.to_s 
    row_string = @row < 10 ? "0#{ @row }" : @row.to_s
    column_string = @column < 10 ? "0#{ @column }" : @column.to_s
    "#{ shelf_string }#{ row_string }#{ column_string }"
  end

  def set(position)
    @shelf = position.slice(0, 2).to_i
    @row = position.slice(2, 2).to_i
    @column = position.slice(4, 2).to_i
    self
  end

  def valid?
    return false unless shelf_in_range?(CONST[:min_size], CONST[:max_size])
    return false unless row_in_range?(CONST[:min_size], CONST[:max_size])
    true
    return false unless column_in_range?(CONST[:min_size], CONST[:max_size])
    true
  end

  def shelf_in_range?(min, max)
    return false unless @shelf < max && @shelf > min
    true
  end

  def row_in_range?(min, max)
    return false unless @row < max && @row > min
    true
  end

  def column_in_range?(min, max)
    return false unless @column < max && @column > min
    true
  end

  def self.next_address(book_address, shelf_size, row_size, column_size)
    next_address_column = book_address.column + 1
    carry = 0
    if next_address_column > column_size
      carry += 1
      next_address_column = 1
    end
    next_address_row = book_address.row + carry
    if next_address_row > row_size
      carry += 1
      next_address_row = 1
    end
    params = Hash.new
    params[:column] = next_address_column
    params[:row] = next_address_row
    params[:shelf] = book_address.shelf
    BookAddress.new(params)
  end
end