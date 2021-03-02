require './class/library'
require_relative 'command'

# Command to validate and execute command build_library
class BuildLibraryCommand < Command
  def args_valid?(args)
    return false unless args.length == 3

    args.each do |arg|
      arg_to_i = begin
        Integer(arg)
      rescue StandardError
        nil
      end
      return false if arg_to_i.nil?
    end
    true
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
