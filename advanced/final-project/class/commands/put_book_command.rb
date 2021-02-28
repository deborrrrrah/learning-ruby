require '../class/library.rb'
require_relative 'command'

class PutBookCommand < Command
  def execute(args)
    params = Hash.new({
      isbn: args[0],
      author: args[2],
      title: args[1]
    })
    Library.instance.put_book(params)
  end
end