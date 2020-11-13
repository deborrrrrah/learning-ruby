require './db/mysql_connector.rb'
require './models/helper/const_functions.rb'
require './models/item'
require './models/category'

class ItemCategory
  attr_reader :item_id, :category_id
  def initialize(params)
    @item_id = params[:item_id]
    @category_id = params[:category_id]
  end

  def new?
    return valid? && ItemCategory.find_by_row({ item_id: @item_id, category_id: @category_id }).nil?
  end

  def valid?
    return false if @item_id.nil? || @category_id.nil?
    true
  end

  def ==(item_category)
    return false if item_category.nil?
    return @item_id == item_category.item_id && @category_id == item_category.category_id
  end

  def save 
    return CRUD_RESPONSE[:invalid] unless valid?
    client = create_db_client
    if new?
      client.query("insert into item_categories (item_id, category_id) values ('#{ @item_id }', '#{ @category_id }')")
      client.close
      ItemCategory.find_by_row({ item_id: @item_id, category_id: @category_id}) == self ? CRUD_RESPONSE[:create_success] : CRUD_RESPONSE[:failed]
    else
      CRUD_RESPONSE[:already_existed]
    end
  end

  def delete
    return CRUD_RESPONSE[:invalid] unless valid?
    return CRUD_RESPONSE[:failed] if ItemCategory.find_by_row({ item_id: @item_id, category_id: @category_id}).nil?
    client = create_db_client
    client.query("delete from item_categories where category_id = #{ @category_id } and item_id = #{ @item_id }")
    client.close
    return ItemCategory.find_by_row({ item_id: @item_id, category_id: @category_id}).nil? ? CRUD_RESPONSE[:delete_success] : CRUD_RESPONSE[:failed]
  end

  def to_s
    "ItemCategory @item_id = #{ @item_id }, @category_id = #{ @category_id }"
  end
  
  def self.convert_to_array(raw_data)
    item_categories = Array.new
    raw_data.each do |row|
      item_category = ItemCategory.new({
        item_id: row['item_id'],
        category_id: row['category_id']
      })
      item_categories << item_category
    end
    item_categories
  end

  def self.find_by_item_id(item_id)
    client = create_db_client
    raw_data = client.query("select category_id, item_id from item_categories where item_id = '#{ item_id }'")
    client.close
    convert_to_array(raw_data).sort_by(&:category_id)
  end

  def self.find_by_category_id(category_id)
    client = create_db_client
    raw_data = client.query("select item_id, category_id from item_categories where category_id = '#{ category_id }'")
    client.close
    convert_to_array(raw_data).sort_by(&:item_id)
  end

  def self.find_by_row(params)
    client = create_db_client
    raw_data = client.query("select item_id, category_id from item_categories where item_id = '#{ params[:item_id] }' and category_id = '#{ params[:category_id]}'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select item_id, category_id from item_categories")
    client.close
    convert_to_array(raw_data)
  end
end