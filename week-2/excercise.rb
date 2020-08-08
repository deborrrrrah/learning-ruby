# first_name = "debOraH"
# last_name = "aPriliA"

# # puts "My name is #{first_name.capitalize} #{last_name.downcase.capitalize}, often called #{first_name.slice(1,first_name.length).downcase.capitalize}. Just for fun fact, my name have #{(first_name + " " + last_name).length} letters including whitespaces"

# full_name = first_name.downcase.capitalize + " " + last_name.downcase.capitalize

# puts "My name is #{full_name}, often called #{first_name.slice(1,first_name.length).downcase.capitalize}. Just for fun fact, my name have #{full_name.length} letters including whitespaces"

# puts "#{first_name[1..-1]}"

# age = 20

# if age == 20
#     puts "we are young!"
# end

age = 20

case age 
when 0..9
    puts "children"
when 10..19
    puts "adolescence"
else 
    puts "tuwir"
end

puts age < 20 ? age < 10 ? "children" : "adolescence" : "tuwir"

text = age < 20 ? age < 10 ? "children" : "adolescence" : "tuwir"
puts text