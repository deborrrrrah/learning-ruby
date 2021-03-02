require './class/library'
require_relative 'command'

# Command to validate and execute command search_books_by_title
class SearchBooksByTitleCommand < Command
  def args_valid?(args)
    args.length == 1
  end

  def execute(args)
    Library.instance.search_book_by_title(args[0])
  end
end
