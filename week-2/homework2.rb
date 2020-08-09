# unless when case ternary

is_eligible = true

print "Do you have a job? "
working = gets.chomp.upcase == "Y" ? true : false

unless working
  is_eligible = false
end

unless !is_eligible
  print "How much your income (please combine if you already married)? "
  income = gets.chomp.to_i

  unless income > 100000
    is_eligible = false
  end
end

unless !is_eligible
  print "How much your monthly expense? "
  expense = gets.chomp.to_i

  unless expense >= 0 && expense <= 70000
    is_eligible = false
  end
end

unless !is_eligible
  print "How much your current loan? "
  loan = gets.chomp.to_i
  
  unless loan >= 0 && loan < 10000
    is_eligible = false
  end
end

unless !is_eligible
  print "How much your old are you? "
  age = gets.chomp.to_i

  print "What type of job? "
  type_of_job = gets.chomp.downcase

  print "Are you married? "
  married = gets.chomp.upcase == "Y" ? true : false

  credit_limit = 0

  unless !married
    credit_limit = 1.5
  end

  unless married
    unless type_of_job != "software engineer" && type_of_job != "businessman" && type_of_job != "government employee"
      credit_limit = 0.7
    end

    unless type_of_job != "other"
      credit_limit = 0.5
    end
  end

  extra_credit_limit = 0
  case age
  when 50...60
    extra_credit_limit = 0.1
  when 60...80
    extra_credit_limit = 0.2
  when 80...100
    extra_credit_limit = 0.3
  end
end

puts ""

case is_eligible
when false
  puts "You are not eligible for this credit program"
when true 
  no_extra_credit = (income * (1 + credit_limit)).round
  final_credit_limit = (no_extra_credit + no_extra_credit * extra_credit_limit).round
  puts "You are eligible for this credit program"
  puts "Your max credit limit is #{ income } + (#{ income } x #{ credit_limit }) + (#{ no_extra_credit } x #{ extra_credit_limit }) = #{ final_credit_limit }"
end