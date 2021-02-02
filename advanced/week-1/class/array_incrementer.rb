class ArrayIncrementer
  def increment(input)
    if input.empty? or input == [0]
      [1]
    else
      result = Array.new
      input.each do |elmt|
        val = elmt + 1
        if val > 9 
          result << elmt - 9
          result << 1
        else
          result << elmt + 1
        end
      end
      result.reverse
    end
  end
end