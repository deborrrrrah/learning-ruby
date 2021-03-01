require './class/library.rb'
require_relative 'command'

class FindBookCommand < Command
  def args_valid?(args)
    true
  end

  def execute(args)
    Library.instance.find_book(args[0])
  end
end