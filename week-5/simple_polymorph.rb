class Bank 
  attr_reader :balance, :name
  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def add(amount) 
    @balance += amount
    puts @name + " received " + amount.to_s + ". Current balance " + @balance.to_s
  end

  def subtract(amount)
    @balance -= amount
    puts @name + " sent " + amount.to_s + ". Current balance " + @balance.to_s
  end
end

class Mandiri < Bank
  attr_reader :is_sharia

  def initialize(name, balance, is_sharia)
    super(name, balance)
    @type = is_sharia
  end

  def transfer(amount, account)
    cross_bank = 6500
    cross_type = 2500
    minimum_balance = 100000
    if @balance > minimum_balance
      total_deduct = amount
      if account.class == self.class && (account.is_sharia == self.is_sharia)
        total_deduct += cross_type
      elsif account.class != self.class
        total_deduct += cross_bank
      end
      self.subtract(total_deduct)
      account.add(amount)
      puts "Transfer success"
    else
      puts "Failed to transfer"
    end
  end
end

class BRI < Bank
  attr_reader :is_sharia

  def initialize(name, balance, is_sharia)
    super(name, balance)
    @type = is_sharia
  end

  def transfer(amount, account)
    cross_bank = 6000
    cross_type = 2000
    minimum_balance = 150000
    if @balance > minimum_balance
      total_deduct = amount
      if account.class == self.class && (account.is_sharia == self.is_sharia)
        total_deduct += cross_type
      elsif account.class != self.class
        total_deduct += cross_bank
      end
      self.subtract(total_deduct)
      account.add(amount)
      puts "Transfer success"
    else
      puts "Failed to transfer"
    end
  end
end

class BNI < Bank
  def initialize(name, balance)
    super(name, balance)
  end

  def transfer(amount, account)
    cross_bank = 7000
    minimum_balance = 200000
    if @balance > minimum_balance
      total_deduct = amount
      if account.class != self.class
        total_deduct += cross_bank
      end
      self.subtract(total_deduct)
      account.add(amount)
      puts "Transfer success"
    else
      puts "Failed to transfer"
    end
  end
end

deborah = Mandiri.new("Deborah", 10000000, false)
ginga = Mandiri.new("Ginga", 5000000, true)
dorothy = BNI.new("Dorothy", 7500000)

deborah.transfer(500000, ginga)
dorothy.transfer(250000, ginga)