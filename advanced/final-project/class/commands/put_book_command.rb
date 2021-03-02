require './class/library'
require_relative 'command'

# Command to validate and execute command put_book
class PutBookCommand < Command
  def args_valid?(args)
    args.length == 3
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
