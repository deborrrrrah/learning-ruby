# Helper function
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
  attr_reader :name, :price, :tags
  def initialize(name, price, tags)
    @name = name.downcase
    @price = price
    @tags = Array.new
    tags.each{ |tag| @tags.push(tag.downcase) }
  end

  def name_price_to_s
    return @name + " Rp" + @price.to_s
  end

  def tags_to_s
    result = ""
    if !@tags.empty?
      result += " tags: "
      @tags.each{ |tag| result += tag + ", "}
    end
    return result[0...-2] # Remove ", " addition at the end of string
  end

  def to_s 
    puts name_price_to_s()
    puts tags_to_s()
  end

  def match(preference)
    # Return false if not match with item_type, in budget range, or tag not match
    return false if preference[:item_type].downcase != self.class.name.downcase
    return false if @price > preference[:max_budget] || @price < preference[:min_budget]
    preference[:tags].each{ |tag| return false if !@tags.include?(tag)}

    # Otherwise return true
    return true
  end

  def ==(item)
    return (@name == item.name) && (@price == item.price) && (@tags == item.tags)
  end
end

class Food < Item
  attr_reader :is_vegan
  def initialize(name, price, tags, is_vegan)
    super(name, price, tags)
    @is_vegan = is_vegan
  end

  def to_s
    result = name_price_to_s()
    result += " non-vegan" if !@is_vegan
    result += tags_to_s()
    return result.rstrip
  end

  def match(preference)
    return super(preference) && (preference[:vegan] == @is_vegan)
  end

  def ==(food)
    return super(food) && (@is_vegan == food.is_vegan)
  end
end

class Drink < Item
  attr_reader :size, :temperature, :is_caffeine
  def initialize(name, price, tags, size, temperature, is_caffeine)
    super(name, price, tags)
    @size = size
    @temperature = temperature.downcase
    @is_caffeine = is_caffeine
  end

  def to_s
    result = name_price_to_s()
    result += " size: " + @size if @size
    result += " non-caffeine" if !@is_caffeine
    result += tags_to_s()
    return result.rstrip
  end

  def match(preference)
    return super(preference) && (preference[:size] == @size) && (preference[:temperature] == @temperature) && (preference[:caffeine] == @is_caffeine)
  end

  def ==(drink)
    return super(drink) && (@is_caffeine == drink.is_caffeine) && (@size == drink.size) && (@temperature == drin.temperature)
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
      puts "Create menu command failed. Number of entry should be more than 0" if !(variables[1].to_i > 0) 
    
    when "add_food"
      # Assumption : user input "add_food <name> <price> <non-vegan/vegan> <tag_1> <tag_2> .. <tag_n>"
      tags = Array.new
      variables.each{ |var| tags.push(var) if available_tags.include?(var) }
      add_food(variables[1], variables[2].to_i, tags, !command.include?("non-vegan"))
    
    when "add_drink"
      # Assumption : user input "add_drink <name> <price> <S/M/L> <hot/cold> <non-caffeine/caffeine> <tag_1> <tag_2> .. <tag_n>"
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
    if !@menus.include?(new_food)
      @menus.push(new_food) if @menus.length < @num_of_item_menu 
      puts new_food.name + " added"
    else
      puts new_food.name + " already exist in menu"
    end
  end

  def add_drink(name, price, tags, size, temperature, is_caffeine)
    new_drink = Drink.new(name, price, tags, size, temperature, is_caffeine)
    if !@menus.include?(new_drink)
      @menus.push(new_drink) if @menus.length < @num_of_item_menu 
      puts new_drink.name + " added"
    else 
      puts new_drink.name + " already exist in menu"
    end
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
      preference[:vegan] = get_input("Are you vegan (no/yes)?").downcase == "yes" ? true : false
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
    recommendations = Array.new
    @menus.each{ |menu| recommendations.push(menu.name.capitalize) if menu.match(preference)}
    puts "Recommendations for you:"
    puts recommendations.empty? ? "No recommendation suits your taste :(" : recommendations
  end
end

recommendation_system = RecommendationSystem.new

while !recommendation_system.kill_instance
  print "> "
  recommendation_system.read_command()
end