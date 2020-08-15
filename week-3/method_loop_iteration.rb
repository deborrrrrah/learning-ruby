def create_sentence(sentences)
  str = ""
  # For loop
  for sentence in sentences do
    str += sentence + " "
  end

  # # Other approaches
  # idx = 0
  # if sentences.length > 0
  #   # Begin until
  #   begin
  #     str += sentences[idx] + " "
  #     idx += 1
  #   end until idx == sentences.length

  #   # Loop break
  #   loop do
  #     str += sentences[idx] + " "
  #     idx += 1
  #     break if idx == sentences.length
  #   end

  #   # While
  #   while idx < sentences.length 
  #     str += sentences[idx] + " "
  #     idx += 1
  #   end
  # end

  return str.chomp
end

def format_phone_number(numbers)
  phone_num = ""
  
  first_sep = 3
  second_sep = 3
  thrid_sep = 4

  # First element (XXX)
  phone_num += "("
  first_sep.times do |counter|
    phone_num += numbers[counter].to_s
  end
  phone_num += ") "
  
  # Second element XXX-
  second_sep.times do |counter|
    phone_num += numbers[counter + first_sep].to_s
  end
  phone_num += "-"
  
  # Last element XXX
  thrid_sep.times do |counter|
    phone_num += numbers[counter + second_sep + first_sep].to_s
  end

  return phone_num
end

def multiplication(num_of_times, number)
  i = 1
  result = []
  begin
    result << i * number # Same as Array.push
    i += 1
  end until i > num_of_times
  return result
end

def checkerboard(size)
  result = ""
  for row in 0...size
    for col in 0...size
      result += (row + col) % 2 == 0 ? "[r]" : "[b]"
    end
    result += "\n"
  end
  return result
end

def find_palindromes(start_num, num_of_output)
  result = []
  curr_num = start_num
  while result.length < num_of_output
    if curr_num.to_s == curr_num.to_s.reverse
      result << curr_num
    end
    curr_num += 1
  end
  return result
end

def print_with_line(message)
  puts message
  puts "=" * message.length 
end

print_with_line("\nExcercise 1")
puts create_sentence(["hello", "beautiful", "world"])
puts create_sentence([])
print_with_line("\nExcercise 2")
puts format_phone_number([1, 2, 3, 4, 5, 6, 7, 8, 9, 0])
print_with_line("\nExcercise 3")
puts multiplication(3, 5)
print_with_line("\nExcercise 4")
puts checkerboard(5)
print_with_line("\nExcercise 5")
puts find_palindromes(100, 2)