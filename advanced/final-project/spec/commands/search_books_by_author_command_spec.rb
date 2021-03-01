require '../class/commands/search_books_by_author_command.rb'
require '../class/library.rb'

RSpec.describe 'SearchBooksByAuthorCommand' do
  it 'stub Library#search_book_by_author' do
    command = SearchBooksByAuthorCommand.new
    args = ['Kent Beck']
    expect_any_instance_of(Library).to receive(:search_book_by_author).with(args[0])
    command.execute(args)
  end
end