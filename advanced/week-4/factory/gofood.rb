require_relative 'service'

class GoFood < Service
  def create_order(order_detail)
    "Hi, GoFood order created, #{ order_detail[0] } will be delivered to #{ order_detail[1] }"
  end
end