require '../class/commands/search_books_by_title_command.rb'
require '../class/library.rb'

RSpec.describe 'SearchBooksByTitleCommand' do
  describe '#args_valid?' do
    it 'return true when argument only consist of one element' do
      command = SearchBooksByTitleCommand.new
      args = ['Harry Potter 1']
      expect(command.args_valid?(args)).to eq(true)
    end

    it 'return false when argument only consist of two element' do
      command = SearchBooksByTitleCommand.new
      args = ['Harry Potter 1', 'another params']
      expect(command.args_valid?(args)).to eq(false)
    end
  end
  
  describe '#execute' do
    it 'stub Library#search_book_by_title' do
      command = SearchBooksByTitleCommand.new
      args = ['Harry Potter 1']
      expect_any_instance_of(Library).to receive(:search_book_by_title).with(args[0])
      command.execute(args)
    end
  end
end