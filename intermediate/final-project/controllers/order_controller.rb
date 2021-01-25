require './models/order'
require './models/order_detail'
require './models/customer'
require './models/helper/const_functions.rb'

class OrderController
  def self.show(params)
    all_orders = Order.find_all
    page = params[:page].nil? ? 1 : params[:page].to_i
    max_page = (all_orders.length().to_f / MAX_ITEM).ceil()
    orders = all_orders.slice((page - 1) * MAX_ITEM, MAX_ITEM)
    renderer = ERB.new(File.read("./views/order/list.erb"))
    renderer.result(binding)
  end

  def self.detail(params) 
    order = Order.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/order/detail.erb"))
    renderer.result(binding)
  end

  def self.show_cart 
    cart = Order.cart
    customers = Customer.find_all
    renderer = ERB.new(File.read("./views/order/cart.erb"))
    renderer.result(binding)
  end

  def self.delete_items 
    cart = Order.cart
    order_details = OrderDetail.find_by_order_id(cart.id)
    order_details.each do |order_detail|
      order_detail.delete
    end
  end

  def self.delete_item(params)
    cart = Order.cart
    params[:order_id] = cart.id
    order_detail = OrderDetail.find_by_row(params)
    order_detail.delete
  end

  def self.add_item(params)
    cart = Order.cart
    params[:order_id] = cart.id
    order_detail = OrderDetail.new(params)
    order_detail.save
  end

  def self.save_cart(params) 
    cart = Order.cart
    cart.set_params(params)
    id = cart.id
    params.each do |key, quantity|
      if key == "customer_id"
        next
      end
      item_id = key.delete("quantity_")
      order_detail = OrderDetail.new({
        item_id: item_id,
        order_id: id,
        quantity:quantity
      })
      order_detail.save
    end
    cart.save_cart
    Order.new_cart
    id
  end
end