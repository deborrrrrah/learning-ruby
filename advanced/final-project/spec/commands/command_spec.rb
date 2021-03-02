require '../class/commands/command'

RSpec.describe 'Command' do
  describe '#args_valid?' do
    it 'raised NotImplementedError when not override' do
      command = Command.new
      args = {}
      expect { command.args_valid?(args) }.to raise_error(NotImplementedError)
    end
  end

  describe '#execute' do
    it 'raised NotImplementedError when not override' do
      command = Command.new
      args = {}
      expect { command.execute(args) }.to raise_error(NotImplementedError)
    end
  end
end
