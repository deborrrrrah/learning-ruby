class BookAddress
  def initialize(params)
    @shelf = params[:shelf]
    @row = params[:row]
    @column = params[:column]
  end

  def ==(book_address)
    true
  end

  def to_s
    shelf_string = @shelf < 10 ? "0#{ @shelf }" : @shelf.to_s 
    row_string = @row < 10 ? "0#{ @row }" : @row.to_s
    column_string = @column < 10 ? "0#{ @column }" : @column.to_s
    "#{ shelf_string }#{ row_string }#{ column_string }"
  end
end