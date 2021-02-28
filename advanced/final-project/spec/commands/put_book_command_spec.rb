require '../class/commands/put_book_command.rb'
require '../class/library.rb'

RSpec.describe 'PutBookCommand' do
  it 'stub Library#put_book' do
    command = PutBookCommand.new
    args = ['9780747532743', 'Harry Potter 1', 'J. K. Rowling']
    expect_any_instance_of(Library).to receive(:put_book)
    command.execute(args)
  end
end