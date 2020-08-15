temp = Array.new(3)
hash = Hash.new

temp.each do |key|
  print "Hash Key : "
  key_string = gets.chomp
  print "Hash Value : "
  value_string = gets.chomp
  hash[key_string.to_sym] = value_string
end
puts hash

result = Hash.new
hash.each do |key, value|
  result[value.to_sym] = key.to_s
end

puts result