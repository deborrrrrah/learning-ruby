DASH_N = 30

# Output
puts "-" * DASH_N
puts "Output with puts, print and p"
puts "-" * DASH_N

puts "Hello, girls!!
Nice to meet you"

print "Hello, girls!!
Nice to meet you
"

p "Hello, girls!!
Nice to meet you"

puts "Hello my name is Deborah Tampubolon\nI live in Depok.\n\nNice to meet you!"

puts ""

# Excercise Output
puts "-" * DASH_N
puts "String Interpolation"
puts "-" * DASH_N

puts "Hello my name is Deborah Tampubolon"
puts "I live in Depok.\n\n"
puts "Nice to meet you!"
puts 

# Input
print ("What is your name? ")
name = gets
p "Welcome, #{name}!"

puts

print ("What is your name? ")
name = gets.chomp
p "Welcome, #{name}!"