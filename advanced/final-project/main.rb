require './class/system'

class Main
  while true
    command, *args = gets.chomp.split('|')
    begin
      System.instance.execute(command, args)
    rescue => error
      puts "#{error.class}: #{error.message}\n\n"
    end
  end
end

Main.new
