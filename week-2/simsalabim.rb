print "insert magic word: "
magic_word = gets.chomp.to_s
AGE_LIMIT = 8
COINS_PER_BAG = 5

if magic_word == "simsalabim"
    
    print "welcome! umm.... what's your name? "
    name = gets.chomp.to_s
    
    print "welcome #{ name.downcase.capitalize }! How old are you? "
    age = gets.chomp.to_i
    
    print "are you with someone whose more than 20 years old? "
    answer = gets.chomp.to_s

    if age > AGE_LIMIT or answer == "yes" 
        puts "well well well, hello #{ name.downcase.capitalize }. Please pick which help do you need?"
        puts "1. determine even/odd number"
        puts "2. convert minutes to hours"
        puts "3. determine how many bag do you need if you have x coin"
        choice = gets.chomp.to_i

        case choice 
        when 1
            print "what number do you want to determine? "
            input = gets.chomp.to_i
            puts input % 2 == 0 ? "this is an even number!" : "this is an odd number!" 
        when 2
            print "how many minutes do you want to convert? "
            input = gets.chomp.to_i
            puts "#{ input } is #{ input / 60 } hour(s) and #{ input % 60 } minute(s)"
        when 3
            print "1 bag can only hold up to 5 coins, how many coin do you have? "
            input = gets.chomp.to_i
            puts "you will need #{ (input.to_f./COINS_PER_BAG).ceil } bag(s) for #{ input } coin(s)"
        else 
            puts "invalid input. sorry :("
        end

    elsif age < AGE_LIMIT
        puts "you are too young to understand this, get back after #{AGE_LIMIT - age} more year(s) please. See you!"
    end

else
    puts "thou shall not pass!!"
end