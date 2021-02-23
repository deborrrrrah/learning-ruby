require_relative 'gojek_app'
require_relative 'paymepay_account'
require_relative 'gopay_account_adapter'
require 'pry'

class Main
  paymepay_balance = ARGV[0].to_i
  country = ARGV[1].strip
  deduction = ARGV[2].to_i

  gojek_app = GojekApp.new
  paymepay_account = PaymepayAccount.new(paymepay_balance)
  paymepay = GopayAccountAdapter.new(paymepay_account, country).account

  gojek_app.pay_order(paymepay, deduction)
end

Main.new