require './class/library.rb'
require_relative 'command'

class SearchBooksByAuthorCommand < Command
  def args_valid?(args)
    true
  end

  def execute(args)
    Library.instance.search_book_by_author(args[0])
  end
end