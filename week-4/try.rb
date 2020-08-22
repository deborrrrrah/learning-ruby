$global_variable_ex = "Test"
class Person
  @@total = 0
  @@class_name = "Person"
  $global_variable_ex = "Ganti gan"
  def initialize(name, gender)
    @name = name
    @gender = gender
    @@total += 1
  end

  def say_my_name()
    $global_variable_ex = "Ganti lg" + @@total.to_s
    puts @name
  end

  def self.get_total
    return @@total
  end

  def self.set_total(val)
    @@total = val
  end

  def self.class_name
    return @@class_name
  end

end

deborah = Person.new("Deborah", "F")
deborah.say_my_name()
p $global_variable_ex
other = Person.new("Other", "M")
other.say_my_name()
puts Person.get_total
p $global_variable_ex
puts Person.set_total(100)
puts Person.class_name

p $global_variable_ex