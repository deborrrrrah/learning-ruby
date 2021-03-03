require_relative 'print_command'

class PrintSinglePageCommand < PrintCommand
  def print(args)
    puts "printing page #{ args[0] }"
  end
end
