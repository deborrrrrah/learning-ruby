class Book
  attr_reader :isbn, :author, :title

  def initialize(params)
    @isbn = params['isbn']
    @author = params['author']
    @title = params['title']
  end

  def valid?
    false
  end
end