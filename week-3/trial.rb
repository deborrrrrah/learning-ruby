def get_input(message, type)
  print message + " "
  result = gets.chomp
  if type == "i"
    result = result.to_i
  end
  result_2 = 2
  return result
end

puts get_input "masukin something", "i"