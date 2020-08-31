def get_input(message)
  print message + " "
  result = gets.chomp
  return result
end

def print_with_line(message)
  puts message
  puts "=" * message.length 
end

class Item
  attr_reader :name
  def initialize(name, price, tags)
    @name = name.downcase
    @price = price
    @tags = []
    tags.each{ |tag| @tags.push(tag.downcase) }
  end

  def to_s
    return @name + " Rp" + @price.to_s
  end

  def tags_to_s
    result = ""
    if !@tags.empty?
      result += " tags: "
      @tags.each{ |tag| result += tag + " "}
    end
    return result
  end
end

class Food < Item
  def initialize(name, price, tags, is_vegan)
    super(name, price, tags)
    @is_vegan = is_vegan
  end

  def to_s
    result = super()
    result += " non-vegan" if !@is_vegan
    result += tags_to_s()
    return result.rstrip
  end
end

class Drink < Item
  def initialize(name, price, tags, size, temperature, is_caffeine)
    super(name, price, tags)
    @size = size
    @temperature = temperature.downcase
    @is_caffeine = is_caffeine
  end

  def to_s
    result = super()
    result += " size: " + @size if @size
    result += " non-caffeine" if !@is_caffeine
    result += tags_to_s()
    return result.rstrip
  end
end

class RecommendationSystem
  attr_reader :kill_instance 
  
  def initialize
    @menus = Array.new
    @num_of_item_menu = 0
    @kill_instance = false
  end

  def read_command()
    available_tags = ["sweet", "sour", "bitter", "spicy", "salty", "umami", "healthy", "junk_food", "italy", "japan", "indonesia", "china"]   
    command = gets.chomp
    variables = command.split(" ")
    
    case variables[0]
    when "create_menu"
      self.create_menu(variables[1].to_i) if variables[1].to_i > 0
      puts "Create menu command failed because number of entry should be more than 0" if !(variables[1].to_i > 0) 
    when "add_food"
      tags = Array.new
      variables.each{ |var| tags.push(var) if available_tags.include?(var) }
      add_food(variables[1], variables[2].to_i, tags, !command.include?("non-vegan"))
    when "add_drink"
      tags = Array.new
      variables.each{ |var| tags.push(var) if available_tags.include?(var) }
      add_drink(variables[1], variables[2].to_i, tags, variables[3], variables[4], !command.include?("non-caffeine"))
    when "list_menu"
      self.list_menu()
    when "give_recommendations"
      self.give_recommendations()
    when "exit"
      puts "Goodbye!"
      @kill_instance = true
    else 
      puts "No command recognized. (created_menu, add_food, add_drink, list_menu, give_recommendations, exit)"
    end
  end

  def create_menu(n_entry)
    @menus = Array.new
    @num_of_item_menu = n_entry
    puts "Created " + n_entry.to_s + " menu"
  end

  def add_food(name, price, tags, is_vegan)
    new_food = Food.new(name, price, tags, is_vegan)
    @menus.push(new_food) if @menus.length < @num_of_item_menu
    puts new_food.name + " added"
  end

  def add_drink(name, price, tags, size, temperature, is_caffeine)
    new_drink = Drink.new(name, price, tags, size, temperature, is_caffeine)
    @menus.push(new_drink) if @menus.length < @num_of_item_menu
    puts new_drink.name + " added"
  end

  def list_menu
    puts !@menus.empty? ? @menus : "No item in menu" 
  end

  def ask_preferences
    preference = Hash.new
    preference[:item_type] = get_input("Do you want to drink/eat?").downcase == "eat" ? "food" : "drink"
    flavour = get_input("What flavour do you prefer (sweet, salty, sour, bitter, spicy, umami)?").downcase
    preference[:tags] = [flavour]
      
    budget = get_input("How many budgets do you have per person (range)?").split("-")
    preference[:min_budget] = budget[0].to_i < budget[1].to_i ? budget[0].to_i : budget[1].to_i
    preference[:max_budget] = budget[0].to_i > budget[1].to_i ? budget[0].to_i : budget[1].to_i
    
    case preference[:item_type]
    when "food"
      preference[:vegan] = get_input("Are you vegan (no/yes)?") == "yes" ? true : false
      food_type = get_input("Do you prefer healthy food or junk food (healthy/junk_food)?").downcase
      preference[:tags].push(food_type)
    when "drink"
      preference[:size] = get_input("Which size do you want (S/M/L)?").upcase
      preference[:temperature] = get_input("Which temperature do you want (hot/cold)?").downcase
      preference[:caffeine] = get_input("Do you want caffeine (yes/no)?").downcase == "yes" ? true : false
    end

    originality = get_input("Originality (italy, japan, indonesia, china)?").downcase
    originality = originality == "any" ? nil : originality 
    preference[:tags].push(originality) if originality
    return preference
  end

  def give_recommendations 
    preference = ask_preferences()
    puts preference
  end
end

recommendation_system = RecommendationSystem.new

while !recommendation_system.kill_instance
  print "> "
  recommendation_system.read_command()
end