require 'date'

print "Hi, I'm Greeing Bot. What is your name?\n> "
name = gets.chomp
print "Nice name, #{name}. Where do you come from?\n> "
country = gets.chomp
print "And what year were you born?\n> "
year = gets.chomp.to_i
age = Date.today.year - year
puts "Well, nice to meet you #{name} of #{country}! You were born on #{year}, so you're #{age} years old now! It's such a challenging age, eh?"