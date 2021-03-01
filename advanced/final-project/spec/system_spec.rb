require '../class/system.rb'

RSpec.describe 'System' do
  it 'raised exit when command is exit' do
    command = 'exit'
    args = []
    expect{System.instance.execute(command, args)}.to raise_error(SystemExit)
  end
end