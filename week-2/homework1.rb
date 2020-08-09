# if elsif else

print "Do you have a job? "
working = gets.chomp.upcase

if working == "N" 
  working = false
elsif working == "Y"
  working = true
end

if !working
  is_eligible = false
else
  print "How much your income (please combine if you already married)? "
  income = gets.chomp.to_i
  
  if income <= 100000
    is_eligible = false
  else 
    print "How much your monthly expense? "
    expense = gets.chomp.to_i
    
    if expense > 70000 || expense < 0
      is_eligible = false
    else
      print "How much your current loan? "
      loan = gets.chomp.to_i
      
      if loan >= 10000 || loan < 0
        is_eligible = false
      else
        is_eligible = true

        print "How much your old are you? "
        age = gets.chomp.to_i

        print "What type of job? "
        type_of_job = gets.chomp.downcase

        print "Are you married? "
        married = gets.chomp.upcase
        
        if married == "N" 
          married = false
        elsif married == "Y"
          married = true
        end
        
        if married
          credit_limit = 1.5
        else
          if type_of_job == "software engineer" || type_of_job == "businessman" || type_of_job == "government employee"
            credit_limit = 0.7
          elsif type_of_job == "other"
            credit_limit = 0.5
          else 
            credit_limit = 0
          end
        end

        if age >= 50 && age < 60
          extra_credit_limit = 0.1
        elsif age >= 60 && age < 80
          extra_credit_limit = 0.2
        elsif age >= 80 && age < 100
          extra_credit_limit = 0.3
        else
          extra_credit_limit = 0
        end

      end
    end
  end
end

puts ""

if not is_eligible
  puts "You are not eligible for this credit program"
else 
  no_extra_credit = (income * (1 + credit_limit)).round
  final_credit_limit = (no_extra_credit + no_extra_credit * extra_credit_limit).round
  puts "You are eligible for this credit program"
  puts "Your max credit limit is #{ income } + (#{ income } x #{ extra_credit_limit }) + (#{ no_extra_credit } x #{ extra_credit_limit }) = #{ final_credit_limit }"
end