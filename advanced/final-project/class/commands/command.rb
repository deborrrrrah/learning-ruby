require_relative 'build_library_command'
require_relative 'find_book_command'
require_relative 'list_books_command'
require_relative 'put_book_command'
require_relative 'search_book_by_author_command'
require_relative 'search_book_by_title_command'
require_relative 'take_book_command'
require_relative 'exit_command'

class Command
  def self.create(command_keyword)
    case command_keyword
    when 'build_library'
      return BuildLibraryCommand.new
    when 'put_book'
      return PutBookCommand.new
    when 'take_book_from'
      return TakeBookCommand.new
    when 'find_book'
      return FindBookCommand.new
    when 'list_books'
      return ListBooksCommand.new
    when 'search_books_by_title'
      return SearchBookByTitleCommand.new
    when 'search_books_by_author'
      return SearchBookByAuthorCommand.new
    else
      raise "Command #{ command_keyword } is not supported"
    end 
  end
end