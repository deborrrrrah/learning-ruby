print "what number do you want to determine? "
number = gets.chomp.to_i

if number % 2 == 0 
    puts "This is an even number!"
elsif number % 2 != 0
    puts "This is an odd number!"
end