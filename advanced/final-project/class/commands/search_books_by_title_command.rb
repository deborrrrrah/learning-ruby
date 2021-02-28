require '../class/library.rb'
require_relative 'command'

class SearchBooksByTitleCommand < Command
  def execute(args)
    Library.instance.search_book_by_title(args[0])
  end
end