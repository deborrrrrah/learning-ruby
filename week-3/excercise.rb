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

  phone_num += "("
  first_sep.times do |counter|
    phone_num += numbers[counter].to_s
  end
  
  phone_num += ") "
  second_sep.times do |counter|
    phone_num += numbers[counter + first_sep].to_s
  end
  
  phone_num += "-"
  thrid_sep.times do |counter|
    phone_num += numbers[counter + second_sep + first_sep].to_s
  end

  return phone_num
end

def multiplication(num_of_times, number)
  i = 1
  result = []
  begin
    result << i * number # Same as push
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

puts create_sentence(["hello", "beautiful", "world"])
puts create_sentence([])
puts format_phone_number([1, 2, 3, 4, 5, 6, 7, 8, 9, 0])
puts multiplication(3, 5)
puts checkerboard(6)