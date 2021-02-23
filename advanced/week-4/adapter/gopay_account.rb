class GopayAccount
  attr_reader :currency, :balance

  def initialize(balance, currency)
    @balance = balance
    @currency = currency
  end
end