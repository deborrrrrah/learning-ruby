class Price
  """
  This class is to defined rupiah price between Rp0,00 - Rp999.000.000.000.000,00
  """ 
  def initialize(value)
    @value = value.tr(',.', "").to_i
  end

  def to_s
    return "" unless valid?
    "Rp#{ @value }"
  end

  def valid?
    return @value > 0
  end
end