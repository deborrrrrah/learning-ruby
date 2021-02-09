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

  private :numeric?
end