require_relative 'print_single_page_command'
require_relative 'print_multiple_pages_command'
require_relative 'print_range_command'

class Printer
  def initialize
    @commands = Hash.new
    @commands['single_page'] = PrintSinglePageCommand.new
    @commands['multiple_pages'] = PrintMultiplePagesCommand.new
    @commands['range'] = PrintRangeCommand.new
  end

  def execute(command, args)
    @commands[command].print(args)
  end
end