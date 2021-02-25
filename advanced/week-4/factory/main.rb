require_relative 'service_factory'

service_type = ARGV[0]
order_detail = ARGV.slice(1, 2)
service = ServiceFactory.new_service(service_type)
puts service.create_order(order_detail)
