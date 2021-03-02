require './class/commands/build_library_command.rb'
require './class/commands/find_book_command.rb'
require './class/commands/list_books_command.rb'
require './class/commands/put_book_command.rb'
require './class/commands/search_books_by_author_command.rb'
require './class/commands/search_books_by_title_command.rb'
require './class/commands/take_book_command.rb'

class System
  def initialize
    @commands = Hash.new
    @commands['build_library'] = BuildLibraryCommand.new
    @commands['find_book'] = FindBookCommand.new
    @commands['list_books'] = ListBooksCommand.new
    @commands['put_book'] = PutBookCommand.new
    @commands['search_books_by_author'] = SearchBooksByAuthorCommand.new
    @commands['search_books_by_title'] = SearchBooksByTitleCommand.new
    @commands['take_book_from'] = TakeBookCommand.new
  end

  @@instance = System.new

  def self.instance
    @@instance
  end

  def remove_white_space_args(args)
    cleaned_args = Array.new
    for arg in args
      cleaned_args << String(arg).strip
    end
    cleaned_args
  end

  def execute(command, args)
    if @commands.has_key?(command)
      command = command.strip
      args = remove_white_space_args(args)
      if @commands[command].args_valid?(args)
        @commands[command].execute(args)
      else
        raise ArgumentError, "Invalid arguments #{ args } for #{ command }"
      end
    elsif command == 'exit'
      exit
    else
      raise ArgumentError, "Command '#{ command }' is not recognized"
    end
    puts
  end

  private :remove_white_space_args
end