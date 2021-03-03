require_relative 'service'

class GoRide < Service
  def create_order(order_detail)
    "Hi, GoRide order created, driver will pick up from #{ order_detail[0] } to #{ order_detail[1] }"
  end
end