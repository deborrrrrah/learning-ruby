require './class/commands/build_library_command'
require './class/commands/find_book_command'
require './class/commands/list_books_command'
require './class/commands/put_book_command'
require './class/commands/search_books_by_author_command'
require './class/commands/search_books_by_title_command'
require './class/commands/take_book_command'

# System to execute and clean the arguments
class System
  def initialize
    @commands = {}
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
    cleaned_args = []
    args.each do |arg|
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
        raise ArgumentError, "Invalid arguments #{args} for #{command}"
      end
    elsif command == 'exit'
      exit
    else
      raise ArgumentError, "Command '#{command}' is not recognized"
    end
    puts
  end

  private :remove_white_space_args
end
