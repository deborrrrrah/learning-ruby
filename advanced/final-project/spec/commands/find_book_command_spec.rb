require '../class/commands/find_book_command.rb'
require '../class/library.rb'

RSpec.describe 'FindBookCommand' do
  describe '#args_valid?' do
    it 'return true when args consist of one args' do
      command = FindBookCommand.new
      args = ['010101']
      expect(command.args_valid?(args)).to eq(true)
    end

    it 'return false when args consist of three args' do
      command = FindBookCommand.new
      args = ['010101', 1, 2]
      expect(command.args_valid?(args)).to eq(false)
    end

    it 'return false when args consist invalid address' do
      command = FindBookCommand.new
      args = ['0101010']
      expect(command.args_valid?(args)).to eq(false)
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