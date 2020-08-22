class Cat
  attr_reader :name
  attr_accessor :age
  @@class_name = "Cat"
  
  def self.class_name
    return @@class_name
  end
  
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def meow()
    puts "#{ @name } says meow!"
  end
  
  def move(place)
    puts "#{ @name } runs to #{ place }"
  end
end

class Dog
  attr_reader :name
  attr_accessor :age
  @@class_name = "Dog"

  def self.class_name
    return @@class_name
  end

  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def bark()
    puts "#{ @name } says woof!"
  end
  
  def move(place)
    puts "#{ @name } runs to #{ place }"
  end
end

my_dog = Dog.new("Doja", 1)
my_cat = Cat.new("Owen", 2)
puts "#{ my_dog.name } is #{ my_dog.age } years old"
my_dog.age = 2
puts "#{ my_dog.name } is #{ my_dog.age } years old"
puts "#{ my_cat.name } is #{ my_cat.age } years old"

my_dog.bark
my_cat.meow
my_dog.move("kitchen")
my_cat.move("street") 
puts Dog.class_name