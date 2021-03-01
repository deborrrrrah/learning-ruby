require './class/system.rb'

class Main
  while true
    command, *args = gets.chomp.split('|')
    command = command.strip
    cleaned_args = Array.new
    for arg in args
      cleaned_args << arg.strip
    end
    System.instance.execute(command, args)
    puts
  end
end

Main.new