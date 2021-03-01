require './class/library.rb'
require_relative 'command'
require './class/book_address.rb'

class FindBookCommand < Command
  def args_valid?(args)
    return false unless args.length == 1
    address = BookAddress.new.set_from_string_address(args[0]) rescue nil
    return false if address.nil?
    true
  end

  def execute(args)
    Library.instance.find_book(args[0])
  end
end