require './class/system.rb'

class Main
  while true
    command, *args = gets.chomp.split('|')
    System.instance.execute(command, args)
  end
end

Main.new