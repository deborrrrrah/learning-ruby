require '../class/commands/list_books_command.rb'
require '../class/library.rb'

RSpec.describe 'ListBooksCommand' do
  describe '#args_valid?' do
    it 'always return true' do
      command = ListBooksCommand.new
      args = []
      expect(command.args_valid?(args)).to eq(true)
    end 
  end
  
  describe '#execute' do
    it 'stub Library#list_books' do
      command = ListBooksCommand.new
      expect_any_instance_of(Library).to receive(:list_books)
      command.execute
    end
  end
end