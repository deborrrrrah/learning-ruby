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
      if @isbn.length != 13 
        false
      else
        true
      end
    end
  end
end