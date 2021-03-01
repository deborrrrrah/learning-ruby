require '../class/commands/build_library_command.rb'
require '../class/commands/find_book_command.rb'

class System
  def initialize
    @commands = Hash.new
    @commands['build_library'] = BuildLibraryCommand.new
    @commands['find_book'] = FindBookCommand.new
  end

  @@instance = System.new

  def self.instance
    @@instance
  end

  def execute(command, args)
    if @commands.has_key?(command)
      @commands[command].execute(args)
    elsif command == 'exit'
      exit
    else
      puts "Command '#{ command }' is not recognized"
      raise ArgumentError
    end
  end
end