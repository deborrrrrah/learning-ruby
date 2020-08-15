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