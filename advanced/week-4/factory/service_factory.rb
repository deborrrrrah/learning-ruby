require_relative 'gofood'
require_relative 'gopulsa'
require_relative 'goride'

class ServiceFactory
  def self.new_service(type)
    if type.downcase == 'gofood'
      GoFood.new
    elsif type.downcase == 'gopulsa'
      GoPulsa.new
    elsif type.downcase == 'goride'
      GoRide.new
    else 
      raise "Type #{ type } not handled"
    end
  end

  private_class_method :new
end