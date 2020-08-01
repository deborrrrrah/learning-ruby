print "Hi, I'm Playful Bot. What is your name?\n> "
name = gets.chomp
print "#{name.reverse.swapcase}! Very nice to meet you! Where do you come from?\n> "
country = gets.chomp
puts "#{country} is a #{country.length}-letter word. #{country.length*13} is your lucky number!"