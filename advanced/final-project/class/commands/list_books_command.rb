require './class/library'
require_relative 'command'

# Command to validate and execute command list_books
class ListBooksCommand < Command
  def args_valid?(_args)
    true
  end

  def execute(_args = [])
    Library.instance.list_books
  end
end
