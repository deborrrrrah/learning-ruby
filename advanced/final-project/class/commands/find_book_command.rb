require './class/library.rb'
require_relative 'command'
require './class/book_address.rb'

class FindBookCommand < Command
  def execute(args)
    Library.instance.find_book(args[0])
  end
end