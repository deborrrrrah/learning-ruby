require '../class/commands/put_book_command'
require '../class/library'

RSpec.describe 'PutBookCommand' do
  describe '#args_valid?' do
    it 'return true when args consist of three arguments' do
      command = PutBookCommand.new
      args = ['9780747532743', 'Harry Potter 1', 'J. K. Rowling']
      expect(command.args_valid?(args)).to eq(true)
    end

    it 'return false when args consist of two arguments' do
      command = PutBookCommand.new
      args = ['9780747532743', 'Harry Potter 1']
      expect(command.args_valid?(args)).to eq(false)
    end
  end

  describe '#execute' do
    it 'stub Library#put_book' do
      command = PutBookCommand.new
      args = ['9780747532743', 'Harry Potter 1', 'J. K. Rowling']
      params = {
        isbn: args[0],
        title: args[1],
        author: args[2]
      }
      expect_any_instance_of(Library).to receive(:put_book).with(params)
      command.execute(args)
    end
  end
end
