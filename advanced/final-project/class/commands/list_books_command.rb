require './class/library.rb'
require_relative 'command'

class ListBooksCommand < Command
  def execute(args = [])
    Library.instance.list_books
  end
end