options = {:font_size => 10, :font_family => 'Arial'}
puts options

options.delete(:font_size)
puts options

options.insert()

puts options.key('Arial')

options.each do |key, value|
  puts "#{key} ditambah 2"
  puts "#{value}"
end