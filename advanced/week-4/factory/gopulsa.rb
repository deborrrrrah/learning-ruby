require_relative 'service'

class GoPulsa < Service
  def create_order(order_detail)
    "Hi, GoPulsa order created, will topup #{ order_detail[1] } to #{ order_detail[0] }"
  end
end