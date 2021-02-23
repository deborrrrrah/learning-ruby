require_relative 'gopay_account'

class GojekApp
  def pay_order(account, deduction)
    if !account.is_a? (GopayAccount)
      puts 'cannot pay order using other payment account'
    else
      remaining_balance = account.balance - deduction
      puts "Order paid using Gopay account. Remaining balance is #{ remaining_balance } #{ account.currency }"
    end
  end
end