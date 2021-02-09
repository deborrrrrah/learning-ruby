class Book
  attr_reader :isbn, :author, :title

  def initialize(params)
    @isbn = params[:isbn]
    @author = params[:author]
    @title = params[:title]
  end

  def valid?
    if @isbn == '' && @author == '' && @title == ''
      false
    else
      if @isbn.length == 13 && numeric?(@isbn)
        true
      else
        false
      end
    end
  end

  def numeric?(string)
    string.scan(/\D/).empty?
  end

  private :numeric?
end