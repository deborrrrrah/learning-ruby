require 'pry'

class ArrayIncrementer
  def increment(input)
    if input.empty? or input == [0]
      [1]
    else
      result = Array.new
      carry = 0
      (input.length - 1).downto(0) do |idx|
        val = idx == (input.length - 1) ? input[idx] + 1 + carry : input[idx] + carry
        if val > 9 
          result << val - 10
          carry = 1
        else
          result << val
          carry = 0
        end
      end
      if carry == 1 
        result << carry
      end
      result.reverse
    end
  end
end