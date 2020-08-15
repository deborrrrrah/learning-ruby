# Range Excercise 1
puts "Range Excercise 1"
puts "=" * 20
expected_delivery_day = gets.chomp.to_i
case expected_delivery_day
when 1
  service_suggestion = "One Day Service"
when 2..4 
  service_suggestion = "Regular Service"
when 5..7
  service_suggestion = "Economic Service"
when 8..10
  service_suggestion = "Cargo Service"
else 
  service_suggestion = "No Service Available (?)"
end
puts service_suggestion

# Range Excercise 2
puts "\nRange Excercise 2"
puts "=" * 20
input = []
8.times do 
  input << gets.chomp.to_i
end

puts "Missing value"
puts "-" * 20
for i in 1...10
  if !input.include?(i)
    puts i
  end
end

# Range Excercise 3
puts "\nRange Excercise 3"
puts "=" * 20

for num in 1..100
  if num % 3 == 0 && num % 5 == 0
    puts "FizzBuzz"
  elsif num % 3 == 0
    puts "Fizz"
  elsif num % 5 ==0
    puts "Buzz"
  else
    puts num.to_s
  end
end 