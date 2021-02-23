require 'class/library.rb'
require 'class/commands/command.rb'

class Main
  @@instance = Main.new
  
  def instance
    @@instance
  end

  def run
    while true
      user_input = gets.chomp
      command_input, *params = user_input.split(" ").collect(&:strip)
      begin
        command = Command.create(command_input)
        command.execute(params)
      rescue Error => e
        puts e
      end
    end
  end
end

Main.instance.run