class Book
  attr_reader :isbn, :author, :title

  def initialize(params)
    @isbn = params[:isbn]
    @author = params[:author]
    @title = params[:title]
  end

  def valid?
    return false if @isbn == '' || @author == '' || @title == ''
    return false if @isbn.length != 13 || !numeric?(@isbn)
    true
  end

  def numeric?(string)
    string.scan(/\D/).empty?
  end

  def ==(book)
    book.isbn == @isbn && book.author == @author && book.title == @title
  end

  def to_s
    'Book isbn: , author: , title: '
  end

  private :numeric?
end