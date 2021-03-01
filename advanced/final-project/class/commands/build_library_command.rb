require './class/library.rb'
require_relative 'command'

class BuildLibraryCommand < Command
  def args_valid?(args)
    args.length == 3
  end

  def execute(args)
    params = {
      shelf_size: args[0].to_i,
      row_size: args[1].to_i,
      column_size: args[2].to_i
    }
    Library.instance.reset_size(params)
  end
end