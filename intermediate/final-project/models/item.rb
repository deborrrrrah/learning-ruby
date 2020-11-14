require './db/mysql_connector.rb'
require './models/helper/const_functions.rb'
require './models/helper/price'
require './models/category'
require './models/item_category'

class Item
  attr_reader :id, :name, :price, :categories
  def initialize(params)
    @name = params[:name]
    @price = params[:price].nil? ? nil : Price.new(params[:price])
    @id = params[:id].nil? && !@name.nil? && @price.valid? ? -999 : params[:id]
    @categories = []
  end

  def new?
    return valid? && @id == -999
  end

  def delete?
    return valid? && @id != -999
  end

  def valid?
    return false if @id.nil?
    return false if @name.nil? || @name == ''
    return false if !@price.valid?
    true
  end

  def ==(item)
    return false if item.nil?
    return @name == item.name && @id == item.id && @price == item.price
  end

  def save 
    return CRUD_RESPONSE[:invalid] unless valid?
    client = create_db_client
    item = Item.find_by_name(self.name)
    if item.nil? && new?
      client.query("insert into items (name, price) values ('#{ @name }', '#{ @price.value }')")
      @id = client.last_id
      client.close
      Item.find_by_id(@id) == self ? CRUD_RESPONSE[:create_success] : CRUD_RESPONSE[:failed]
    elsif !item.nil? && new?
      CRUD_RESPONSE[:already_existed]
    else
      client.query("update items set name = '#{ @name }', price = '#{ @price.value }' where id = '#{ @id }'")
      client.close
      Item.find_by_id(@id) == self ? CRUD_RESPONSE[:update_success] : CRUD_RESPONSE[:failed]
    end
  end

  def delete
    return CRUD_RESPONSE[:invalid] unless delete?
    return CRUD_RESPONSE[:failed] if Item.find_by_id(self.id).nil?
    client = create_db_client
    client.query("delete from item_categories where item_id = #{ @id }")
    client.query("delete from items where id = #{ @id }")
    client.close
    return Item.find_by_id(self.id).nil? ? CRUD_RESPONSE[:delete_success] : CRUD_RESPONSE[:failed]
  end

  def get_categories
    return nil unless valid?
    item_categories = ItemCategory.find_by_item_id(@id)
    categories = Array.new
    item_categories.each do |item_category|
      category = Category.find_by_id(item_category.category_id)
      categories << category
    end
    categories
  end

  def categories_to_s 
    @categories = get_categories
    return "" if categories.empty? or categories.nil?
    return categories[0].name if categories.length == 1
    return "#{ categories[0].name } and #{ categories[1].name }" if categories.length == 2
    first_two_categories = categories.slice(0,2).join(", ")
    remaining_num_of_categories = categories.slice(2,categories.length).length
    if remaining_num_of_categories == 1
      return "#{ categories[0].name }, #{ categories[1].name } and #{ categories[2].name }"
    else
      return "#{ categories[0].name }, #{ categories[1].name }, and #{ remaining_num_of_categories } category(ies)"
    end
  end

  def to_s
    "Item @id = #{ @id }, @name = #{ @name }, @price = #{ @price }"
  end
  
  def self.convert_to_array(raw_data)
    items = Array.new
    raw_data.each do |row|
      item = Item.new({
        id: row['id'],
        name: row['name'],
        price: row['price']
      })
      items << item
    end
    items.sort_by(&:id)
  end

  def self.find_by_name(name)
    client = create_db_client
    raw_data = client.query("select id, name, format(price, 0) as price from items where name = '#{ name }'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def self.filter_by_name(name)
    client = create_db_client
    raw_data = client.query("select id, name, format(price, 0) as price from items where name like '%#{ name }%'")
    client.close
    convert_to_array(raw_data)
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select id, name, format(price, 0) as price from items where id = '#{ id }'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select id, name, format(price, 0) as price from items")
    client.close
    convert_to_array(raw_data)
  end
end