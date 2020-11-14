require './db/mysql_connector.rb'
require './models/helper/const_functions.rb'
require './models/item'

class OrderDetail
  attr_reader :id, :item_id, :quantity, :order_id
  def initialize(params)
    @item_id = params[:item_id]
    @order_id = params[:order_id]
    @quantity = params[:quantity]
  end

  # def new?
  #   return valid? && @id == -999
  # end

  # def delete?
  #   return valid? && @id != -999
  # end

  # def cart?
  #   return valid? && @status == ORDER_STATUS[:in_cart]
  # end

  def valid?
    return false if @item_id.nil? || @order_id.nil?
    true
  end

  def ==(order_detail)
    return false if order_detail.nil?
    return @id == order_detail.id && @customer_id == order_detail.customer_id && @order_date_time == order_detail.order_date_time && @status == order_detail.status
  end

  def customer 
    Customer.find_by_id(@customer_id)
  end

  # def save 
  #   return CRUD_RESPONSE[:invalid] unless valid?
  #   client = create_db_client
  #   order = Order.find_by_id(self.id)
  #   if !order.nil? && cart?
  #     client.query("insert into orders (customer_id, ) values ('#{ @name }', '#{ @price.value }')")
  #     @id = client.last_id
  #     client.close
  #     order.find_by_id(@id) == self ? CRUD_RESPONSE[:create_success] : CRUD_RESPONSE[:failed]
  #   elsif order.nil? && new?
  #   elsif !order.nil? && new?
  #     CRUD_RESPONSE[:already_existed]
  #   else
  #     client.query("update orders set name = '#{ @name }', price = '#{ @price.value }' where id = '#{ @id }'")
  #     client.close
  #     order.find_by_id(@id) == self ? CRUD_RESPONSE[:update_success] : CRUD_RESPONSE[:failed]
  #   end
  # end

  # def delete
  #   return CRUD_RESPONSE[:invalid] unless delete?
  #   return CRUD_RESPONSE[:failed] if order.find_by_id(self.id).nil?
  #   client = create_db_client
  #   client.query("delete from order_details where order_id = #{ @id }")
  #   client.query("delete from order_categories where order_id = #{ @id }")
  #   client.query("delete from orders where id = #{ @id }")
  #   client.close
  #   return order.find_by_id(self.id).nil? ? CRUD_RESPONSE[:delete_success] : CRUD_RESPONSE[:failed]
  # end

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
      item = Item.find_by_id(order_detail.item_id)
      order_items << item
    end
    order_items
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select item_id, order_id, quantity from order_details")
    client.close
    convert_to_array(raw_data)
  end
end