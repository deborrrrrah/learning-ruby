require './class/library.rb'
require_relative 'command'

class PutBookCommand < Command
  def args_valid?(args)
    true
  end
  
  def execute(args)
    params = {
      isbn: args[0],
      author: args[2],
      title: args[1]
    }
    Library.instance.put_book(params)
  end
end