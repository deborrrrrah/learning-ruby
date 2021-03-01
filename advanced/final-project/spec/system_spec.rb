require '../class/system.rb'
require '../class/commands/build_library_command.rb'
require '../class/commands/find_book_command.rb'

RSpec.describe 'System' do
  describe '#execute' do
    it 'raised exit when command is exit' do
      command = 'exit'
      args = []
      expect{System.instance.execute(command, args)}.to raise_error(SystemExit)
    end

    it 'stub BuildLibraryCommand#execute when command is build_library' do
      command = 'build_library'
      args = [2, 1, 3]
      expect_any_instance_of(BuildLibraryCommand).to receive(:execute).with(args)
      System.instance.execute(command, args)
    end

    it 'stub FindBookCommand#execute when command is find_book' do
      command = 'find_book'
      args = ['9780807281918']
      expect_any_instance_of(FindBookCommand).to receive(:execute).with(args)
      System.instance.execute(command, args)
    end
  end
end