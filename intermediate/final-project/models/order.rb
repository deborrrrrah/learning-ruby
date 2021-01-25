require './db/mysql_connector.rb'
require './models/helper/const_functions.rb'
require './models/customer'
require './models/order_detail'

require 'pry'

class Order
  attr_reader :id, :customer_id, :order_date_time, :status
  def initialize(params)
    @customer_id = params[:customer_id].to_i
    @status = params[:status].nil? ? ORDER_STATUS[:in_cart] : params[:status].to_i
    @order_date_time = params[:order_date_time]
    @id = params[:id].nil? && !@customer_id.nil? ? -999 : params[:id].to_i
  end

  def set_params(params)
    @customer_id = params[:customer_id].nil? ? @customer_id : params[:customer_id].to_i
  end

  def new?
    return valid? && @id == -999
  end

  def delete?
    return valid? && @id != -999
  end

  def cart?
    return valid? && @status == ORDER_STATUS[:in_cart]
  end

  def valid?
    return false if @id.nil?
    return false if @customer_id.nil?
    return false if !ORDER_STATUS.has_value?(@status)
    return false if @order_date_time.nil?
    true
  end

  def ==(order)
    return false if order.nil?
    return @id == order.id && @customer_id == order.customer_id && @order_date_time == order.order_date_time && @status == order.status
  end

  def customer 
    Customer.find_by_id(@customer_id)
  end

  def items
    OrderDetail.find_items_by_order_id(@id)
  end

  def items_to_s
    item_list = items
    "#{ item_list.length } item(s)"
  end

  def to_s
    "Order @id = #{ @id }, @customer_id = #{ @customer_id }, @status = #{ @status }, @order_date_time = #{ @order_date_time }"
  end

  def self.cart 
    client = create_db_client
    raw_data = client.query("select id, customer_id, status, order_date_time from orders where status = '#{ ORDER_STATUS[:in_cart] }'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def save_cart
    return CRUD_RESPONSE[:invalid] unless valid? && cart?
    client = create_db_client
    client.query("update orders set customer_id = '#{ @customer_id }', status = '#{ ORDER_STATUS[:completed] }' where id = '#{ @id }'")
    @id = client.last_id
    client.close
    Order.find_by_id(@id) == self ? CRUD_RESPONSE[:create_success] : CRUD_RESPONSE[:failed]
  end

  def self.new_cart
    client = create_db_client
    client.query("insert into orders values (DEFAULT, DEFAULT, DEFAULT, DEFAULT)")
    @id = client.last_id
    new_cart = Order.find_by_id(@id)
    client.close
    Order.find_by_id(@id) == new_cart ? CRUD_RESPONSE[:create_success] : CRUD_RESPONSE[:failed]
  end
  
  def self.convert_to_array(raw_data)
    orders = Array.new
    raw_data.each do |row|
      order = Order.new({
        id: row['id'],
        customer_id: row['customer_id'],
        status: row['status'],
        order_date_time: row['order_date_time']
      })
      orders << order
    end
    orders.sort_by(&:id)
  end

  def self.find_by_customer_id(customer_id)
    client = create_db_client
    raw_data = client.query("select id, customer_id, status, order_date_time from orders where customer_id = '#{ customer_id }' and status = '#{ ORDER_STATUS[:completed] }'")
    client.close
    convert_to_array(raw_data)
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select id, customer_id, status, order_date_time from orders where id = '#{ id }' and status = '#{ ORDER_STATUS[:completed] }'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select id, customer_id, status, order_date_time from orders where status = '#{ ORDER_STATUS[:completed] }'")
    client.close
    convert_to_array(raw_data)
  end
end
