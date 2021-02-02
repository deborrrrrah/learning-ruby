class ArrayIncrementer
  def increment(input)
    if input.empty? or input == [0]
      [1]
    else
      result = Array.new
      input.each do |elmt|
        result << elmt + 1
      end
      result
    end
  end
end