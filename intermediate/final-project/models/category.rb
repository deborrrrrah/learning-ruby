require './db/mysql_connector.rb'
require './models/helper/const_functions.rb'

class Category
  attr_reader :id, :name, :items
  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @items = []
  end

  def valid?
    return false if @name.nil?
    true
  end

  def ==(category)
    return false if category.nil?
    return @name == category.name && @id == category.id
  end

  def save 
    return CRUD_RESPONSE[:failed] unless valid?
    client = create_db_client
    if @id.nil?
      client.query("insert into categories (name) values ('#{ @name }')")
      @id = client.last_id
      client.close
      Category.find_by_id(@id) == self ? CRUD_RESPONSE[:create_success] : CRUD_RESPONSE[:failed]
    else
      client.query("update categories set name = '#{ @name }' where id = '#{ @id }'")
      client.close
      Category.find_by_id(@id) == self ? CRUD_RESPONSE[:update_success] : CRUD_RESPONSE[:failed]
    end
  end

  def delete
    return CRUD_RESPONSE[:failed] unless valid? && !Category.find_by_id(self.id).nil?
    client = create_db_client
    if !@id.nil?
      client.query("delete from item_categories where category_id = #{ @id }")
      client.query("delete from categories where id = #{ @id }")
      client.close
      return Category.find_by_id(self.id).nil? ? CRUD_RESPONSE[:delete_success] : CRUD_RESPONSE[:failed]
    end
    client.close
    return CRUD_RESPONSE[:failed]
  end

  def items
    return nil unless valid?
    []
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
    categories
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select id, name from categories where id = '#{ id }'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select id, name from categories")
    client.close
    convert_to_array(raw_data).sort_by(&:id)
  end
end