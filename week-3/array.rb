
arr = Array.new(3)
temp = Array.new

arr.each { |elmt| temp.push(gets.chomp.to_i) }
arr = Array.new(temp)
puts (arr)

puts "Uniq function\n"
arr = arr.uniq
arr.each{ |elmt| puts "#{elmt}"}

puts "Each do\n"
result = []
arr.each do |elmt| 
  if !result.include?(elmt) 
    result.push(elmt)
  end
end
result.each{ |elmt| puts "#{elmt}"}

puts "Each ternary\n"
result = []
arr.each { |elmt| !result.include?(elmt) ? result.push(elmt) : nil }
result.each{ |elmt| puts "#{elmt}"}