class Price
  """
  This class is to defined rupiah price between Rp0,00 - Rp999.000.000.000.000,00
  """ 
  def initialize(value)
    @value = value.tr(',.', "").to_i
  end

  def to_s
    return "" unless valid?
    separated_num = []
    temp_value = value % 1000000000000
    separated_num << value % 1000
    thousands = value / 1000
    "Rp ,00"
  end

  def valid?
    return @value > 0
  end
end