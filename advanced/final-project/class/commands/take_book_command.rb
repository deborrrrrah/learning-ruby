require '../class/library.rb'
require_relative 'command'

class TakeBookCommand < Command
  def execute(args)
    Library.instance.take_book_from(args[0])
  end
end