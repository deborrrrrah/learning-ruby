require '../class/commands/take_book_command.rb'
require '../class/library.rb'

RSpec.describe 'TakeBookCommand' do
  it 'stub Library#take_book_from' do
    command = TakeBookCommand.new
    args = ['020102']
    expect_any_instance_of(Library).to receive(:take_book_from).with(args[0])
    command.execute(args)
  end
end