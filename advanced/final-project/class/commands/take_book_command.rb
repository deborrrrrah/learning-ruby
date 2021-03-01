require './class/library.rb'
require_relative 'command'

class TakeBookCommand < Command
  def args_valid?(args)
    return false unless args.length == 1
    address = BookAddress.new.set_from_string_address(args[0]) rescue nil
    return false if address.nil?
    true
  end
  
  def execute(args)
    Library.instance.take_book_from(args[0])
  end
end