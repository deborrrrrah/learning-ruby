
arr = Array.new
idx = 1
while idx >= 1 && idx <=3 do
  arr.push(gets.chomp.to_i)
  idx += 1
end

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