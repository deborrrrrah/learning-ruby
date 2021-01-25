require './db/mysql_connector.rb'
require './models/helper/const_functions.rb'
require './models/item'

class OrderDetail
  attr_reader :id, :item_id, :quantity, :order_id
  def initialize(params)
    @item_id = params[:item_id]
    @order_id = params[:order_id]
    @quantity = params[:quantity].nil? ? 1 : params[:quantity]
  end

  def new?
    return valid? && OrderDetail.find_by_row({ item_id: @item_id, order_id: @order_id }).nil?
  end

  def valid?
    return @item_id.nil? || @order_id.nil? || @quantity.nil? ? false : true
  end

  def ==(order_detail)
    return false if order_detail.nil?
    return @item_id.to_i == order_detail.item_id.to_i && @order_id.to_i == order_detail.order_id.to_i && @quantity.to_i == order_detail.quantity.to_i
  end

  def save 
    return CRUD_RESPONSE[:invalid] unless valid?
    client = create_db_client
    if new?
      client.query("insert into order_details (item_id, order_id, quantity) values ('#{ @item_id }', '#{ @order_id }', '#{ @quantity }')")
    else
      client.query("update order_details set quantity = '#{ @quantity }' where item_id = '#{ @item_id }' and order_id = '#{ @order_id }'")
    end
    client.close
    ItemCategory.find_by_row({ item_id: @item_id, order_id: @order_id}) == self ? CRUD_RESPONSE[:create_success] : CRUD_RESPONSE[:failed]
  end

  def delete
    return CRUD_RESPONSE[:failed] if OrderDetail.find_by_row({ item_id: @item_id, order_id: @order_id}).nil?
    client = create_db_client
    client.query("delete from order_details where order_id = #{ @order_id } and item_id = #{ @item_id }")
    client.close
    return OrderDetail.find_by_row({ item_id: @item_id, order_id: @order_id}).nil? ? CRUD_RESPONSE[:delete_success] : CRUD_RESPONSE[:failed]
  end

  def to_s
    "Order Detail @item_id = #{ @item_id }, @order_id = #{ @order_id }, @quantity = #{ @quantity }"
  end
  
  def self.convert_to_array(raw_data)
    order_details = Array.new
    raw_data.each do |row|
      order_detail = OrderDetail.new({
        item_id: row['item_id'],
        order_id: row['order_id'],
        quantity: row['quantity']
      })
      order_details << order_detail
    end
    order_details.sort_by(&:id)
  end

  def self.find_by_order_id(order_id)
    client = create_db_client
    raw_data = client.query("select item_id, order_id, quantity from order_details where order_id = '#{ order_id }'")
    client.close
    convert_to_array(raw_data)
  end

  def self.find_items_by_order_id(order_id)
    order_details = OrderDetail.find_by_order_id(order_id)
    order_items = Array.new
    order_details.each do |order_detail|
      order_item = Hash.new
      item = Item.find_by_id(order_detail.item_id)
      order_item[:item] = item
      order_item[:quantity] = order_detail.quantity
      order_items << order_item
    end
    order_items
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select item_id, order_id, quantity from order_details")
    client.close
    convert_to_array(raw_data)
  end

  def self.find_by_row(params)
    client = create_db_client
    raw_data = client.query("select item_id, order_id from order_details where item_id = '#{ params[:item_id] }' and order_id = '#{ params[:order_id]}'")
    client.close
    convert_to_array(raw_data)[0]
  end
end