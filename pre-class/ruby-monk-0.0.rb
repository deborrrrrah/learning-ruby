# Taken from https://rubymonk.com/

addition = lambda {|a, b| return a + b }
puts addition.call(5, 6)

empty_block = lambda { }
puts empty_block.object_id
puts empty_block.class
puts empty_block.class.superclass

class Calculator
  def add(a, b)
    return a + b
  end
end
  
puts Calculator.new.add(5, 6)

addition_method = Calculator.new.method("add")
addition =  addition_method.to_proc

puts addition.call(5, 6)

class Array
  def foldl(method)
    inject {|result, i| result ? result.send(method, i) : i }
  end
end

puts [1000.0, 200.0, 50.0].foldl("/") # Feel free to experiment with this

class SetInStone
#empty class
end

class SetInStone
  def everything_changes
    return "Wait, what? You just added a method to me!\n"
  end
end
 
print SetInStone.new.everything_changes

zen = eval("7 * 6")
print zen

zen = 7 * 6
print zen

def zen
  41
end

eval("def zen; 42; end")

puts zen