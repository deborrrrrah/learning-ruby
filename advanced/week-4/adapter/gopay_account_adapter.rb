require_relative 'gopay_account'

class GopayAccountAdapter
  def initialize(account, country)
    balance = recalculate_balance(account.balance, country)
    currency = define_currency(country)
    @gopay_account = GopayAccount.new(balance, currency) 
  end

  def account
    @gopay_account
  end

  def define_currency(country)
    if country == 'indonesia'
      'IDT'
    elsif country == 'singapore'
      'SGD'
    elsif country == 'thailand'
      'THB'
    elsif country == 'vietnam'
      'VND'
    else
      raise 'Country not in scope' 
    end
  end

  def recalculate_balance(balance, country)
    if country == 'indonesia'
      currency_rate = 14000
    elsif country == 'singapore'
      currency_rate = 2
    elsif country == 'thailand'
      currency_rate = 30
    elsif country == 'vietnam'
      currency_rate = 23000
    else
      raise 'Country not in scope'
    end
    balance * currency_rate
  end

  private :define_currency, :recalculate_balance
end