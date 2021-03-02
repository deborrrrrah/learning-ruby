require '../class/commands/take_book_command'
require '../class/library'

RSpec.describe 'TakeBookCommand' do
  describe '#args_valid?' do
    it 'return true when args consist of one args' do
      command = TakeBookCommand.new
      args = ['010101']
      expect(command.args_valid?(args)).to eq(true)
    end

    it 'return false when args consist of three args' do
      command = TakeBookCommand.new
      args = ['010101', 1, 2]
      expect(command.args_valid?(args)).to eq(false)
    end

    it 'return false when args consist invalid address' do
      command = TakeBookCommand.new
      args = ['0101010']
      expect(command.args_valid?(args)).to eq(false)
    end

    it 'return false when args consist another invalid address' do
      command = TakeBookCommand.new
      args = ['01aa01']
      expect(command.args_valid?(args)).to eq(false)
    end
  end

  describe '#execute' do
    it 'stub Library#take_book_from' do
      command = TakeBookCommand.new
      args = ['020102']
      expect_any_instance_of(Library).to receive(:take_book_from).with(args[0])
      command.execute(args)
    end
  end
end
