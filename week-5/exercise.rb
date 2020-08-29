class Person
  def eat(fruit)
    fruit.name
  end

  def nutritional_intake(fruit)
    fruit.nutrition
  end
end

class Apple
  def name
    puts "I'm an apple"
  end

  def nutrition
    puts "Protein 0.3 grams, and Sugar 10.4 grams"
  end
end

class Banana
  def name
    puts "I'm banana"
  end

  def nutrition 
    puts "Protein 1.1 grams, and Sugar 12.2 grams"
  end
end

deborah = Person.new
banana = Banana.new
apple = Apple.new

deborah.eat(banana)
deborah.nutritional_intake(banana)
deborah.eat(apple)
deborah.nutritional_intake(apple)