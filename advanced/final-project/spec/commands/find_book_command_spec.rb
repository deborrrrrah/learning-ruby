require '../class/commands/find_book_command.rb'
require '../class/library.rb'

RSpec.describe 'FindBookCommand' do
  describe '#args_valid?' do
    it 'return true when only one args' do
      command = FindBookCommand.new
      args = ['9780807281918']
      expect(command.args_valid?(args)).to eq(true)
    end
  end
  
  describe '#execute' do
    it 'stub Library#find_book' do
      command = FindBookCommand.new
      args = ['9780807281918']
      expect_any_instance_of(Library).to receive(:find_book).with(args[0])
      command.execute(args)
    end
  end
end