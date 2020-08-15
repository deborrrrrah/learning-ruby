# Hash excercise

hash = Hash.new

# # First approach to get input by using Array.each >_<
# temp = Array.new(3)
# temp.each do |key|
#   print "Hash Key : "
#   key_string = gets.chomp
#   print "Hash Value : "
#   value_string = gets.chomp
#   hash[key_string.to_sym] = value_string
# end

def get_input(message)
  print message + " "
  result = gets.chomp
  return result
end

num_of_input = 3
num_of_input.times do |counter|
  key_string = get_input "Hash Key #{counter + 1} = "
  val_string = get_input "Hash Value #{counter + 1} = "
  hash[key_string.to_sym] = val_string
end

puts hash

result = Hash.new
hash.each do |key, value|
  result[value.to_sym] = key.to_s
end

puts result