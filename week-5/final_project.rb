class Item
  def initialize(name, price, tags)
    @name = name
    @price = price
    @tags = tags
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
    @temperature = temperature
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
  def create_menu(n_entry)
    @menus = Array.new
    @num_of_item_menu = n_entry
    puts "Created " + n_entry.to_s + " menu"
  end

  def add_food(name, price, tags, is_vegan)
    @menus.push(Food.new(name, price, tags, is_vegan)) if @menus.length < @num_of_item_menu
  end

  def add_drink(name, price, tags, size, temperature, is_caffeine)
    @menus.push(Drink.new(name, price, tags, size, temperature, is_caffeine)) if @menus.length < @num_of_item_menu
  end

  def list_menu
    @menus.each{ |menu| puts menu.to_s }
  end
end

# while true
  recommendation_system = RecommendationSystem.new
  recommendation_system.create_menu(2)
  recommendation_system.add_food("spaghetti", 10000, ["sweet", "sour", "healthy", "italia"], false)
  recommendation_system.add_drink("ocha", 10000, ["bitter", "japan"], "M", "cold", false)
  recommendation_system.list_menu()
# end