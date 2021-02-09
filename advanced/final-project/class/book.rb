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
    book.isbn == @isbn
  end

  def to_s
    "Book isbn: #{ @isbn }, author: #{ @author }, title: #{ @title }"
  end

  def title_contains(keyword)
    @title.downcase.include?(keyword.downcase)
  end

  def author_contains(keyword)
    true
  end

  private :numeric?
end