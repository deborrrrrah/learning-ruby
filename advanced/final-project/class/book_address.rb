class BookAddress
  def initialize(params)
    @shelf = params[:shelf]
    @row = params[:row]
    @column = params[:column]
  end

  def to_s
    '010101'
  end
end