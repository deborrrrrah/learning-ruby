require '../class/commands/search_books_by_title_command.rb'
require '../class/library.rb'

RSpec.describe 'SearchBooksByTitleCommand' do
  it 'stub Library#search_book_by_title' do
    command = SearchBooksByTitleCommand.new
    args = ['Harry Potter 1']
    expect_any_instance_of(Library).to receive(:search_book_by_title)
    command.execute(args)
  end
end