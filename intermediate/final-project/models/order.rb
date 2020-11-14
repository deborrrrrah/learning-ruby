require './db/mysql_connector.rb'
require './models/helper/const_functions.rb'
require './models/customer'
require './models/order_detail'

class Order
  attr_reader :id, :customer_id, :order_date_time, :status
  def initialize(params)
    @customer_id = params[:customer_id]
    @status = params[:status]
    @order_date_time = params[:order_date_time]
    @id = params[:id]
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

  # def valid?
  #   return false if @id.nil?
  #   return false if @customer_id.nil?
  #   return false if !ORDER_STATUS.has_value?(@status)
  #   return false if @order_date_time.nil?
  #   true
  # end

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
    "Order @id = #{ @id }, @name = #{ @name }, @price = #{ @price }"
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

  def self.cart 
    client = create_db_client
    raw_data = client.query("select id, customer_id, status, order_date_time from orders where status = '#{ ORDER_STATUS[:in_cart] }'")
    client.close
    convert_to_array(raw_data)[0]
  end
end