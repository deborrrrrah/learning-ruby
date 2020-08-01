print "Hi, I'm Playful Bot. What is your name?\n> "
name = gets.chomp
print "Nice name, #{name.reverse}. Where do you come from?\n> "
country = gets.chomp
puts "#{country} is a #{country.length}-letter word. #{country.length*13} is your lucky number!"