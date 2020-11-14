class Price
  """
  This class is to defined rupiah price.
  TODO : Add separator '.' per thousands. Ex : Rp100.000,00
  """ 
  attr_reader :value
  def initialize(value)
    # Remove the comma or dot in the strings
    value = value.to_s.tr(',.', "")
    @value = value.nil? || !(value !~ /\D/) ? -999 : value.to_i
  end

  def ==(price)
    return @value == price.value
  end

  def to_s
    return '' unless valid?
    "Rp#{ @value }"
  end

  def valid?
    return @value >= 0
  end
end