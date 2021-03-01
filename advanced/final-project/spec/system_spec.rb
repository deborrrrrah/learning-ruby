require '../class/system.rb'
require '../class/commands/build_library_command.rb'
require '../class/commands/find_book_command.rb'
require '../class/commands/list_books_command.rb'
require '../class/commands/put_book_command.rb'
require '../class/commands/search_books_by_author_command.rb'
require '../class/commands/search_books_by_title_command.rb'
require '../class/commands/take_book_command.rb'

RSpec.describe 'System' do
  describe '#execute' do
    it 'raised exit when command is exit' do
      command = 'exit'
      args = []
      expect{System.instance.execute(command, args)}.to raise_error(SystemExit)
    end

    it 'stub BuildLibraryCommand#execute when command is build_library' do
      command = 'build_library'
      args = [2, 1, 3]
      expect_any_instance_of(BuildLibraryCommand).to receive(:execute).with(args)
      System.instance.execute(command, args)
    end

    it 'stub FindBookCommand#execute when command is find_book' do
      command = 'find_book'
      args = ['9780807281918']
      expect_any_instance_of(FindBookCommand).to receive(:execute).with(args)
      System.instance.execute(command, args)
    end

    it 'stub ListBooksCommand#execute when command is list_books' do
      command = 'list_books'
      args = []
      expect_any_instance_of(ListBooksCommand).to receive(:execute).with (args)
      System.instance.execute(command, args)
    end

    it 'stub PutBookCommand#execute when command is put_book' do
      command = 'put_book'
      args = ['9780747532743', 'Harry Potter 1', 'J. K. Rowling']
      expect_any_instance_of(PutBookCommand).to receive(:execute).with (args)
      System.instance.execute(command, args)
    end

    it 'stub SearchBooksByAuthorCommand#execute when command is search_books_by_author' do
      command = 'search_books_by_author'
      args = ['Kent Beck']
      expect_any_instance_of(SearchBooksByAuthorCommand).to receive(:execute).with (args)
      System.instance.execute(command, args)
    end

    it 'stub SearchBooksByTitleCommand#execute when command is search_books_by_title' do
      command = 'search_books_by_title'
      args = ['Harry Potter']
      expect_any_instance_of(SearchBooksByTitleCommand).to receive(:execute).with (args)
      System.instance.execute(command, args)
    end

    it 'stub TakeBookCommand#execute when command is take_book_from' do
      command = 'take_book_from'
      args = ['010101']
      expect_any_instance_of(TakeBookCommand).to receive(:execute).with (args)
      System.instance.execute(command, args)
    end

    it 'raise ArgumentError when command destroy which is not recognized' do
      command = 'destroy'
      args = []
      expect{System.instance.execute(command, args)}.to raise_error(ArgumentError)
    end
  end
end