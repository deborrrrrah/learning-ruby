class Rectangle
  attr_reader :height, :width
  def initialize(height, width)
    @height = height
    @width = width
  end
end

rect_1 = Rectangle.new(10, 5)
puts rect_1.height