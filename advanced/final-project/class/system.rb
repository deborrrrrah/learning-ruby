require '../class/commands/build_library_command.rb'
require '../class/commands/find_book_command.rb'
require '../class/commands/list_books_command.rb'
require '../class/commands/put_book_command.rb'
require '../class/commands/search_books_by_author_command.rb'
require '../class/commands/search_books_by_title_command.rb'

class System
  def initialize
    @commands = Hash.new
    @commands['build_library'] = BuildLibraryCommand.new
    @commands['find_book'] = FindBookCommand.new
    @commands['list_books'] = ListBooksCommand.new
    @commands['put_book'] = PutBookCommand.new
    @commands['search_books_by_author'] = SearchBooksByAuthorCommand.new
    @commands['search_books_by_title'] = SearchBooksByTitleCommand.new
  end

  @@instance = System.new

  def self.instance
    @@instance
  end

  def execute(command, args)
    if @commands.has_key?(command)
      @commands[command].execute(args)
    elsif command == 'exit'
      exit
    else
      puts "Command '#{ command }' is not recognized"
      raise ArgumentError
    end
  end
end