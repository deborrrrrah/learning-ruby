class Banana
    def name
        puts "Banana"
    end
end

class Apple
    # def name 
    #     puts "Apple"
    # end
end

def some_function(fruit)
    fruit.name
end

some_function(Banana.new)
some_function(Apple.new)