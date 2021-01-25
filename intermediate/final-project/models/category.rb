require './db/mysql_connector.rb'
require './models/helper/const_functions.rb'
require './models/item'
require './models/item_category'

class Category
  attr_reader :id, :name
  def initialize(params)
    @id = params[:id].nil? && !params[:name].nil? ? -999 : params[:id]
    @name = params[:name]
  end

  def new?
    return valid? && @id == -999
  end

  def delete?
    return valid? && @id != -999
  end

  def valid?
    return false if @name.nil? || @name == ''
    return false if @id.nil?
    true
  end

  def ==(category)
    return false if category.nil?
    return @name == category.name && @id.to_i == category.id.to_i
  end

  def save 
    return CRUD_RESPONSE[:invalid] unless valid?
    client = create_db_client
    category = Category.find_by_name(self.name)
    if category.nil? && new?
      client.query("insert into categories (name) values ('#{ @name }')")
      @id = client.last_id
      client.close
      Category.find_by_id(@id) == self ? CRUD_RESPONSE[:create_success] : CRUD_RESPONSE[:failed]
    elsif !category.nil? && new?
      CRUD_RESPONSE[:already_existed]
    else
      client.query("update categories set name = '#{ @name }' where id = '#{ @id }'")
      client.close
      Category.find_by_id(@id) == self ? CRUD_RESPONSE[:update_success] : CRUD_RESPONSE[:failed]
    end
  end

  def delete
    return CRUD_RESPONSE[:invalid] unless delete?
    return CRUD_RESPONSE[:failed] if Category.find_by_id(self.id).nil?
    client = create_db_client
    client.query("delete from item_categories where category_id = #{ @id }")
    client.query("delete from categories where id = #{ @id }")
    client.close
    return Category.find_by_id(self.id).nil? ? CRUD_RESPONSE[:delete_success] : CRUD_RESPONSE[:failed]
  end

  def items
    return [] unless valid?
    item_categories = ItemCategory.find_by_category_id(@id)
    item_list = Array.new
    item_categories.each do |item_category|
      item = Item.find_by_id(item_category.item_id)
      item_list << item
    end
    item_list
  end

  def items_to_s 
    item_list = self.items
    return "No item" if item_list.empty? or item_list.nil?
    return item_list[0].name.to_s if item_list.length == 1
    return "#{ item_list[0].name } and #{ item_list[1].name }" if item_list.length == 2
    first_two_categories = item_list.slice(0,2).each{|name|}.join(", ")
    remaining_num_of_categories = item_list.slice(2,item_list.length).length
    if remaining_num_of_categories == 1
      return "#{ item_list[0].name }, #{ item_list[1].name } and #{ item_list[2].name }"
    else
      return "#{ item_list[0].name }, #{ item_list[1].name }, and #{ remaining_num_of_categories } item(s)"
    end
  end

  def to_s
    "Category @id = #{ @id }, @name = #{ @name }"
  end
  
  def self.convert_to_array(raw_data)
    categories = Array.new
    raw_data.each do |row|
      category = Category.new({
        id: row["id"],
        name: row["name"]
      })
      categories << category
    end
    categories.sort_by(&:id)
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select id, name from categories where id = '#{ id }'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def self.find_by_name(name)
    client = create_db_client
    raw_data = client.query("select id, name from categories where name = '#{ name }'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def self.filter_by_name(name)
    client = create_db_client
    raw_data = client.query("select id, name from categories where name like '%#{ name }%'")
    client.close
    convert_to_array(raw_data)
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select id, name from categories")
    client.close
    convert_to_array(raw_data)
  end
end