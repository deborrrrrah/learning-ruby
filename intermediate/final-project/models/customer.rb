require './db/mysql_connector.rb'
require './models/helper/const_functions.rb'
require './models/helper/price'

class Customer
  attr_reader :id, :name, :phone, :orders
  def initialize(params)
    @name = params[:name]
    @phone = params[:phone]
    @id = params[:id].nil? && !@name.nil? && !@phone.nil? ? -999 : params[:id]
    @orders = []
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
    return false if @phone.nil? || @phone.length < 12
    true
  end

  def ==(customer)
    return false if customer.nil?
    return @name == customer.name && @id == customer.id && @phone == customer.phone
  end

  def save 
    return CRUD_RESPONSE[:invalid] unless valid?
    client = create_db_client
    customer = Customer.find_by_phone(self.phone)
    if customer.nil? && new?
      client.query("insert into customers (name, phone) values ('#{ @name }', '#{ @phone }')")
      @id = client.last_id
      client.close
      Customer.find_by_id(@id) == self ? CRUD_RESPONSE[:create_success] : CRUD_RESPONSE[:failed]
    elsif !customer.nil? && new?
      CRUD_RESPONSE[:already_existed]
    else
      return CRUD_RESPONSE[:failed] if Customer.find_by_id(@id).nil?
      client.query("update customers set name = '#{ @name }', phone = '#{ @phone }' where id = '#{ @id }'")
      client.close
      Customer.find_by_id(@id) == self ? CRUD_RESPONSE[:update_success] : CRUD_RESPONSE[:failed]
    end
  end

  def delete
    return CRUD_RESPONSE[:invalid] unless delete?
    return CRUD_RESPONSE[:failed] if Customer.find_by_id(self.id).nil?
    client = create_db_client
    client.query("delete from orders where customer_id = #{ @id }")
    client.query("delete from customers where id = #{ @id }")
    client.close
    return Customer.find_by_id(self.id).nil? ? CRUD_RESPONSE[:delete_success] : CRUD_RESPONSE[:failed]
  end

  def get_orders
    return nil unless valid?
    []
  end

  def orders_to_s 
    @orders = get_orders
    "No order"
  end

  def to_s
    "Customer @id = #{ @id }, @name = #{ @name }, @phone = #{ @phone }"
  end
  
  def self.convert_to_array(raw_data)
    customers = Array.new
    raw_data.each do |row|
      customer = Customer.new({
        id: row['id'],
        name: row['name'],
        phone: row['phone']
      })
      customers << customer
    end
    customers.sort_by(&:id)
  end

  def self.filter_by_name(name)
    client = create_db_client
    raw_data = client.query("select id, name, phone from customers where name like '%#{ name }%'")
    client.close
    convert_to_array(raw_data)
  end

  def self.find_by_name(name)
    client = create_db_client
    raw_data = client.query("select id, name, phone from customers where name = '#{ name }'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def self.find_by_phone(phone)
    client = create_db_client
    raw_data = client.query("select id, name, phone from customers where phone = '#{ phone }'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select id, name, phone from customers where id = '#{ id }'")
    client.close
    convert_to_array(raw_data)[0]
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select id, name, phone from customers")
    client.close
    convert_to_array(raw_data)
  end
end