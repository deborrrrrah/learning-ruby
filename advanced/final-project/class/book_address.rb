require_relative 'const'

# BookAddress to determine the shelf, row, and column position in BookCollection
class BookAddress
  attr_reader :shelf, :row, :column

  def initialize(params = {})
    @shelf = params[:shelf]
    @row = params[:row]
    @column = params[:column]
  end

  def ==(other)
    other.shelf == @shelf && other.row == @row && other.column == @column
  end

  def to_s
    shelf_string = @shelf < 10 ? "0#{@shelf}" : @shelf.to_s
    row_string = @row < 10 ? "0#{@row}" : @row.to_s
    column_string = @column < 10 ? "0#{@column}" : @column.to_s
    "#{shelf_string}#{row_string}#{column_string}"
  end

  def set_from_string_address(position)
    return nil if position.length != 6

    @shelf = Integer(position.slice(0, 2))
    @row = Integer(position.slice(2, 2))
    @column = Integer(position.slice(4, 2))
    self
  end

  def valid?
    return false if @shelf.nil? || @row.nil? || @column.nil?
    return false unless shelf_in_range?(Const.instance.size[:min_size], Const.instance.size[:max_size])
    return false unless row_in_range?(Const.instance.size[:min_size], Const.instance.size[:max_size])
    return false unless column_in_range?(Const.instance.size[:min_size], Const.instance.size[:max_size])

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

  def increment(address_element, max_size, carry)
    next_address_element = address_element + carry
    if next_address_element > max_size
      carry = 1
      next_address_element = 1
    else
      carry = 0
    end
    [next_address_element, carry]
  end

  def next_address(size_limit)
    next_address_column, carry = increment(@column, size_limit[:column_size], 1)
    next_address_row, carry = increment(@row, size_limit[:row_size], carry)
    next_address_shelf, carry = increment(@shelf, size_limit[:shelf_size], carry)
    return nil if carry == 1

    params = {}
    params[:column] = next_address_column
    params[:row] = next_address_row
    params[:shelf] = next_address_shelf
    BookAddress.new(params)
  end

  private :increment
end
