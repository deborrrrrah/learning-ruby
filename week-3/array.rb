# Array excercise

puts "\nInput 10-size array"
puts "=" * 20
ARRAY_SIZE = 10
arr = Array.new
idx = 1
while idx >= 1 && idx <= ARRAY_SIZE do
  arr.push(gets.chomp.to_i)
  idx += 1
end

puts "\nUniq function"
puts "=" * 20
arr = arr.uniq
arr.each{ |elmt| puts "#{elmt}"}

puts "\nEach do"
puts "=" * 20
result = []
arr.each do |elmt| 
  if !result.include?(elmt) 
    result.push(elmt)
  end
end
result.each{ |elmt| puts "#{elmt}"}

puts "\nEach ternary"
puts "=" * 20
result = []
arr.each { |elmt| !result.include?(elmt) ? result.push(elmt) : nil }
result.each{ |elmt| puts "#{elmt}"}