class Const
  attr_reader :response, :size

  def initialize
    @response = {
      success: 0,
      failed: 1,
      full: 2,
      invalid_book: 3,
      invalid_address: 4,
      found: 5,
      not_found: 6,
      already_exist: 7
    }
  
    @size = {
      min_size: 0,
      max_size: 100
    }
  end

  @@instance = Const.new

  def self.instance
    @@instance
  end
end