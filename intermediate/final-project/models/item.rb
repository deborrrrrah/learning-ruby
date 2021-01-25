require './db/mysql_connector.rb'
require './models/helper/const_functions.rb'
require './models/helper/price'
require './models/category'
require './models/item_category'

class Item
  attr_reader :id, :name, :price
  def initialize(params)
    @name = params[:name]
    @price = params[:price].nil? ? nil : Price.new(params[:price])
    @id = params[:id].nil? && !@name.nil? && @price.valid? ? -999 : params[:id]
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
    return @name == item.name && @id.to_i == item.id.to_i && @price == item.price
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
    client.query("delete from order_details where item_id = #{ @id }")
    client.query("delete from item_categories where item_id = #{ @id }")
    client.query("delete from items where id = #{ @id }")
    client.close
    return Item.find_by_id(self.id).nil? ? CRUD_RESPONSE[:delete_success] : CRUD_RESPONSE[:failed]
  end

  def categories
    return [] unless valid?
    item_categories = ItemCategory.find_by_item_id(@id)
    category_list = Array.new
    item_categories.each do |item_category|
      category = Category.find_by_id(item_category.category_id)
      category_list << category
    end
    category_list
  end

  def categories_to_s 
    category_list = categories
    return "No category" if category_list.empty? or category_list.nil?
    return category_list[0].name if category_list.length == 1
    return "#{ category_list[0].name } and #{ category_list[1].name }" if category_list.length == 2
    first_two_category_list = category_list.slice(0,2).join(", ")
    remaining_num_of_categories = category_list.slice(2,category_list.length).length
    if remaining_num_of_categories == 1
      return "#{ category_list[0].name }, #{ category_list[1].name } and #{ category_list[2].name }"
    else
      return "#{ category_list[0].name }, #{ category_list[1].name }, and #{ remaining_num_of_categories } category(ies)"
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