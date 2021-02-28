require '../class/commands/command.rb'

RSpec.describe 'Command' do
  it 'raised NotImplementedError when not override' do
    command = Command.new
    args = Hash.new
    expect{command.execute(args)}.to raise_error(NotImplementedError)
  end
end