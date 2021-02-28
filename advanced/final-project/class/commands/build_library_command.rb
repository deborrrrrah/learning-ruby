require '../class/library.rb'
require_relative 'command'

class BuildLibraryCommand < Command
  def execute(args)
    params = Hash.new({
      shelf_size: args[0],
      row_size: args[1],
      column_size: args[2]
    })
    Library.instance.reset_size(params)
  end
end